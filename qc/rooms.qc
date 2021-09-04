void(entity e) printPointEntity{

	dprint(e.classname);
	dprint(": #");
	dprint(ftos(e.roomindex));
	dprint(" @ ");
	dprint(vtos(e.origin));
	dprint(" @ ");
	dprint(vtos(e.angles));
	dprint("\n");

}

void() info_roomorigin{ /*printPointEntity(self);*/ }
void() info_roomterminus{ /*printPointEntity(self);*/ }
void() info_firstterminus{ /*printPointEntity(self);*/ }

entity(entity room) findorigin{

	local float contsearch;
	local entity iterator;
	contsearch = TRUE;
	iterator = world;

	while(contsearch == TRUE){

		iterator = find(iterator, classname, "info_roomorigin");
		if(iterator == world){ dprint("whoops"); contsearch = FALSE; }
		if(iterator.roomindex == room.roomindex){ return iterator; }

	}

	return iterator;

}

entity(entity room) findterminus{

	local float contsearch;
	local entity iterator;
	contsearch = TRUE;
	iterator = world;

	while(contsearch == TRUE){

		iterator = find(iterator, classname, "info_roomterminus");
		if(iterator == world){ contsearch = FALSE; }
		if(iterator.roomindex == room.roomindex){ return iterator; }

	}

	return iterator;

}

void() func_room{

	if(self.roomindex == 0){

		dprint("ROOM INDICES COUNT FROM 1");
		return;

	}

	float roombit = bitshift(1, self.roomindex);

	if(self.roomindex < 32){

		if(world.roomschosenlower & roombit){

			func_wall();
			self.shouldspawn = TRUE;

		}

	}else{

		if(world.roomschosenupper & roombit){

			func_wall();
			self.shouldspawn = TRUE;

		}

	}

}

void(entity attacker, float damage) testprint{

	setorigin(self, self.origin + '0 0 16');
//	remove(self);

}

void() func_test{

	func_wall();
	self.takedamage = DAMAGE_AIM;
	self.th_pain = testprint;

}
void(entity room) moveroom{

	local entity curroomorigin = findorigin(room);
	local entity curroomterminus = findterminus(room);

	room.shouldspawn = FALSE;
	setorigin(room, room.origin + (lastterminus.origin - curroomorigin.origin));
	setorigin(curroomterminus, curroomterminus.origin + (lastterminus.origin - curroomorigin.origin));

	printPointEntity(lastterminus);
	lastterminus = findterminus(room);

}
void() arrangerooms{

	local entity iterator;
	local float contsearch;
	local float skipped;
	local float lotto;
	iterator = world;
	contsearch = TRUE;
	skipped = FALSE;
	lastterminus = find(world, classname, "info_firstterminus");

	while(contsearch == TRUE){

		iterator = find(iterator, classname, "func_room");

		lotto = random();

		if(lotto <= 0.5){
			skipped = TRUE;		//hacky randomness lol
			lotto = 0;
		}
		if(iterator == world && skipped == FALSE){

			contsearch = FALSE;

		}else if(iterator == world){

			skipped = FALSE;

		}else if(iterator.shouldspawn == TRUE && skipped == FALSE){

			moveroom(iterator);

		}

	}

}
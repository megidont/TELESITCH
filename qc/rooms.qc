void() func_room = {

	if(self.roomindex == 0){

		dprint("ROOM INDICES COUNT FROM 1");
		return;

	}

	float roombit = bitshift(1, self.roomindex);

	if(self.roomindex < 32){

		if(world.roomschosenlower & roombit){

			func_wall();

		}

	}else{

		if(world.roomschosenupper & roombit){

			func_wall();

		}

	}

}

void(entity attacker, float damage) testprint{

	setorigin(self, self.origin + '0 0 16');
//	remove(self);

}

void() func_test = {

	func_wall();
	self.takedamage = DAMAGE_AIM;
	self.th_pain = testprint;

}
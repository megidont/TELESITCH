void() func_room = {

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

//	setorigin(self, '0 0 16');
	sprint(attacker, ftos(evilTestGlobal));
	centerprint(attacker, ftos(world.roomschosenlower));
//	remove(self);

}

void() func_test = {

	func_wall();
	self.takedamage = DAMAGE_AIM;
	self.th_pain = testprint;

}
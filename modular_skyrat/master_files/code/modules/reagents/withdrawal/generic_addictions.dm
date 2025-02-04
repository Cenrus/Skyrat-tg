/datum/addiction/nicotine
	name = "nicotine"
	addiction_relief_treshold = 0.03 //This used to be 0.01.
	withdrawal_stage_messages = list("Feel like having a smoke...", "I really need a smoke now...", "I can't take it, I really need a smoke now!")

	medium_withdrawal_moodlet = /datum/mood_event/nicotine_withdrawal_moderate
	severe_withdrawal_moodlet = /datum/mood_event/nicotine_withdrawal_severe

/datum/addiction/nicotine/proc/trigger_random_side_effect(mob/living/carbon/affected_carbon, delta_time, strength)
	switch(rand(1, 10))
		if(1 to 3)
			if(!HAS_TRAIT(affected_carbon, TRAIT_NOHUNGER))
				affected_carbon.adjust_nutrition(-delta_time * 10 * strength)
		if(3 to 5)
			affected_carbon.emote("cough")
		if(5 to 7)
			to_chat(affected_carbon, span_warning("Your head hurts."))
			affected_carbon.adjustStaminaLoss(4 * strength)
		if(8)
			if(strength >= 2)
				to_chat(affected_carbon, span_warning("You feel a little dizzy."))
				affected_carbon.set_timed_status_effect(strength * 6 SECONDS, /datum/status_effect/dizziness)
		if(8 to 10)
			to_chat(affected_carbon, span_warning("You feel tired."))
			affected_carbon.adjustStaminaLoss(6 * strength)

/datum/addiction/nicotine/withdrawal_enters_stage_1(mob/living/carbon/affected_carbon, delta_time)
	. = ..()
	affected_carbon.set_timed_status_effect(10 SECONDS, /datum/status_effect/jitter, only_if_higher = TRUE)

/datum/addiction/nicotine/withdrawal_enters_stage_2(mob/living/carbon/affected_carbon, delta_time)
	. = ..()
	affected_carbon.set_timed_status_effect(20 SECONDS, /datum/status_effect/jitter, only_if_higher = TRUE)

/datum/addiction/nicotine/withdrawal_enters_stage_3(mob/living/carbon/affected_carbon, delta_time)
	. = ..()
	affected_carbon.set_timed_status_effect(30 SECONDS, /datum/status_effect/jitter, only_if_higher = TRUE)

/datum/addiction/nicotine/withdrawal_stage_2_process(mob/living/carbon/affected_carbon, delta_time)
	. = ..()
	if(DT_PROB(3, delta_time))
		trigger_random_side_effect(affected_carbon, delta_time, 1)

/datum/addiction/nicotine/withdrawal_stage_3_process(mob/living/carbon/affected_carbon, delta_time)
	. = ..()
	if(DT_PROB(5, delta_time))
		trigger_random_side_effect(affected_carbon, delta_time, 2)

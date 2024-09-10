Return-Path: <linux-pm+bounces-13934-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A51F9972E8A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 11:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295211F2539C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 09:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D940E18E773;
	Tue, 10 Sep 2024 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="K7V9sdNK"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35EA188CC1;
	Tue, 10 Sep 2024 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961392; cv=none; b=lAak0nVOnGG3udsLelh1eLjc5/MVEE4csrUn1YtX1a6wVp0Djz83/031h8PzMuTRi2cfLQcn3waj0WE8waNb3z66q3XqM6kFVfan3rukZ+pwFvzbVr7695Q7I1PgSb5EhrzkAkyrw3wG4WqM2o28Fns4UW2qUUunYwm9pSSuqNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961392; c=relaxed/simple;
	bh=BRfixD8ukgBaZKSp2YnvGEiPR8ycPlOqNkoGGidfO6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tj6SfncKlMV2+MaTvCtDwMkw/VcELl67imTHJGpDJQJ6wWP5AZ1W3XmXdiu92isNtY1fpsJSl/57peiRrtJWKQmJCfvrkbXKSmAZrbv6wrn18sIhZ1wEC66xt8zVkIO43ojWZcw0RLgsHZYX7vsOp3daYK6pSq/I3gQazn7edpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=K7V9sdNK reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 89051e00c9a54e99; Tue, 10 Sep 2024 11:43:07 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 55B7E6B836A;
	Tue, 10 Sep 2024 11:43:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1725961387;
	bh=BRfixD8ukgBaZKSp2YnvGEiPR8ycPlOqNkoGGidfO6w=;
	h=From:Subject:Date;
	b=K7V9sdNKT72vjYiPjwIMz9h3TsMoeJoo3hykVHXDOc4FV4VkuEOf1JorBbjOCWa9Z
	 OOJ9tfSmrOEQrdC19sry7a0RRmTm6pUATh1XFKNZbMOb4YUaLORppxl9hW4IEqeI7C
	 0Hb1wtzHQHmoYPnMjP84XHsvO97KfXOF09zs/pdFCxIlyqRM7CeXOQmbPspNhWh+18
	 ouebrerT/XO/KLe8q7ZA9XvEl+znQ3lMR+dDmjPcSCmmwKxuwVH+O9iu7PeMcRtDo0
	 jvgcAtLxFooz9b1A6W7t6IGueQHz3JC/czSYniYtBE0vV70N5jyD5OJ5qEfr0Gwr6o
	 GZlpoNLMZwXGQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH for 6.13 v1 1/8] thermal: core: Move lists of thermal instances to
 trip descriptors
Date: Tue, 10 Sep 2024 11:27:52 +0200
Message-ID: <2196792.irdbgypaU6@rjwysocki.net>
In-Reply-To: <4920970.GXAFRqVoOG@rjwysocki.net>
References: <4920970.GXAFRqVoOG@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiledgudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdr
 tghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=20 Fuz1=20 Fuz2=20

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In almost all places where a thermal zone's list of thermal instances
is walked, there is a check to match a specific trip point and it is
walked in vain whenever there are no cooling devices associated with
the given trip.

To address this, store the lists of thermal instances in trip point
descriptors instead of storing them in thermal zones and adjust all
code using those lists accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_bang_bang.c       |   11 ++++-----
 drivers/thermal/gov_fair_share.c      |   16 ++++---------
 drivers/thermal/gov_power_allocator.c |   41 ++++++++++++++--------------------
 drivers/thermal/gov_step_wise.c       |   16 ++++++-------
 drivers/thermal/thermal_core.c        |   33 +++++++++++++++------------
 drivers/thermal/thermal_core.h        |    5 +---
 drivers/thermal/thermal_helpers.c     |    5 ++--
 7 files changed, 60 insertions(+), 67 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -488,7 +488,7 @@ static void thermal_zone_device_check(st
 
 static void thermal_zone_device_init(struct thermal_zone_device *tz)
 {
-	struct thermal_instance *pos;
+	struct thermal_trip_desc *td;
 
 	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
 
@@ -496,8 +496,12 @@ static void thermal_zone_device_init(str
 	tz->passive = 0;
 	tz->prev_low_trip = -INT_MAX;
 	tz->prev_high_trip = INT_MAX;
-	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
-		pos->initialized = false;
+	for_each_trip_desc(tz, td) {
+		struct thermal_instance *instance;
+
+		list_for_each_entry(instance, &td->thermal_instances, trip_node)
+			instance->initialized = false;
+	}
 }
 
 static void thermal_governor_trip_crossed(struct thermal_governor *governor,
@@ -761,12 +765,12 @@ struct thermal_zone_device *thermal_zone
  * Return: 0 on success, the proper error value otherwise.
  */
 static int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
-				     const struct thermal_trip *trip,
+				     struct thermal_trip *trip,
 				     struct thermal_cooling_device *cdev,
 				     struct cooling_spec *cool_spec)
 {
-	struct thermal_instance *dev;
-	struct thermal_instance *pos;
+	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
+	struct thermal_instance *dev, *instance;
 	bool upper_no_limit;
 	int result;
 
@@ -829,13 +833,13 @@ static int thermal_bind_cdev_to_trip(str
 		goto remove_trip_file;
 
 	mutex_lock(&cdev->lock);
-	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
-		if (pos->trip == trip && pos->cdev == cdev) {
+	list_for_each_entry(instance, &td->thermal_instances, trip_node)
+		if (instance->cdev == cdev) {
 			result = -EEXIST;
 			break;
 		}
 	if (!result) {
-		list_add_tail(&dev->tz_node, &tz->thermal_instances);
+		list_add_tail(&dev->trip_node, &td->thermal_instances);
 		list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
 		atomic_set(&tz->need_update, 1);
 
@@ -869,15 +873,16 @@ free_mem:
  * This function is usually called in the thermal zone device .unbind callback.
  */
 static void thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
-					  const struct thermal_trip *trip,
+					  struct thermal_trip *trip,
 					  struct thermal_cooling_device *cdev)
 {
+	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *pos, *next;
 
 	mutex_lock(&cdev->lock);
-	list_for_each_entry_safe(pos, next, &tz->thermal_instances, tz_node) {
-		if (pos->trip == trip && pos->cdev == cdev) {
-			list_del(&pos->tz_node);
+	list_for_each_entry_safe(pos, next, &td->thermal_instances, trip_node) {
+		if (pos->cdev == cdev) {
+			list_del(&pos->trip_node);
 			list_del(&pos->cdev_node);
 
 			thermal_governor_update_tz(tz, THERMAL_TZ_UNBIND_CDEV);
@@ -1414,7 +1419,6 @@ thermal_zone_device_register_with_trips(
 		}
 	}
 
-	INIT_LIST_HEAD(&tz->thermal_instances);
 	INIT_LIST_HEAD(&tz->node);
 	ida_init(&tz->ida);
 	mutex_init(&tz->lock);
@@ -1438,6 +1442,7 @@ thermal_zone_device_register_with_trips(
 	tz->num_trips = num_trips;
 	for_each_trip_desc(tz, td) {
 		td->trip = *trip++;
+		INIT_LIST_HEAD(&td->thermal_instances);
 		/*
 		 * Mark all thresholds as invalid to start with even though
 		 * this only matters for the trips that start as invalid and
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -30,6 +30,7 @@ struct thermal_trip_desc {
 	struct thermal_trip trip;
 	struct thermal_trip_attrs trip_attrs;
 	struct list_head notify_list_node;
+	struct list_head thermal_instances;
 	int notify_temp;
 	int threshold;
 };
@@ -93,7 +94,6 @@ struct thermal_governor {
  * @tzp:	thermal zone parameters
  * @governor:	pointer to the governor for this thermal zone
  * @governor_data:	private pointer for governor data
- * @thermal_instances:	list of &struct thermal_instance of this thermal zone
  * @ida:	&struct ida to generate unique id for this zone's cooling
  *		devices
  * @lock:	lock to protect thermal_instances list
@@ -128,7 +128,6 @@ struct thermal_zone_device {
 	struct thermal_zone_params *tzp;
 	struct thermal_governor *governor;
 	void *governor_data;
-	struct list_head thermal_instances;
 	struct ida ida;
 	struct mutex lock;
 	struct list_head node;
@@ -223,7 +222,7 @@ struct thermal_instance {
 	struct device_attribute attr;
 	char weight_attr_name[THERMAL_NAME_LENGTH];
 	struct device_attribute weight_attr;
-	struct list_head tz_node; /* node in tz->thermal_instances */
+	struct list_head trip_node; /* node in trip->thermal_instances */
 	struct list_head cdev_node; /* node in cdev->thermal_instances */
 	unsigned int weight; /* The weight of the cooling device */
 	bool upper_no_limit;
Index: linux-pm/drivers/thermal/gov_bang_bang.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_bang_bang.c
+++ linux-pm/drivers/thermal/gov_bang_bang.c
@@ -67,6 +67,7 @@ static void bang_bang_control(struct the
 			      const struct thermal_trip *trip,
 			      bool crossed_up)
 {
+	const struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *instance;
 
 	lockdep_assert_held(&tz->lock);
@@ -75,10 +76,8 @@ static void bang_bang_control(struct the
 		thermal_zone_trip_id(tz, trip), trip->temperature,
 		tz->temperature, trip->hysteresis);
 
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (instance->trip == trip)
-			bang_bang_set_instance_target(instance, crossed_up);
-	}
+	list_for_each_entry(instance, &td->thermal_instances, trip_node)
+		bang_bang_set_instance_target(instance, crossed_up);
 }
 
 static void bang_bang_manage(struct thermal_zone_device *tz)
@@ -104,8 +103,8 @@ static void bang_bang_manage(struct ther
 		 * to the thermal zone temperature and the trip point threshold.
 		 */
 		turn_on = tz->temperature >= td->threshold;
-		list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-			if (!instance->initialized && instance->trip == trip)
+		list_for_each_entry(instance, &td->thermal_instances, trip_node) {
+			if (!instance->initialized)
 				bang_bang_set_instance_target(instance, turn_on);
 		}
 	}
Index: linux-pm/drivers/thermal/gov_fair_share.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_fair_share.c
+++ linux-pm/drivers/thermal/gov_fair_share.c
@@ -44,7 +44,7 @@ static int get_trip_level(struct thermal
 /**
  * fair_share_throttle - throttles devices associated with the given zone
  * @tz: thermal_zone_device
- * @trip: trip point
+ * @td: trip point descriptor
  * @trip_level: number of trips crossed by the zone temperature
  *
  * Throttling Logic: This uses three parameters to calculate the new
@@ -61,29 +61,23 @@ static int get_trip_level(struct thermal
  * new_state of cooling device = P3 * P2 * P1
  */
 static void fair_share_throttle(struct thermal_zone_device *tz,
-				const struct thermal_trip *trip,
+				const struct thermal_trip_desc *td,
 				int trip_level)
 {
 	struct thermal_instance *instance;
 	int total_weight = 0;
 	int nr_instances = 0;
 
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (instance->trip != trip)
-			continue;
-
+	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
 		total_weight += instance->weight;
 		nr_instances++;
 	}
 
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
 		struct thermal_cooling_device *cdev = instance->cdev;
 		u64 dividend;
 		u32 divisor;
 
-		if (instance->trip != trip)
-			continue;
-
 		dividend = trip_level;
 		dividend *= cdev->max_state;
 		divisor = tz->num_trips;
@@ -116,7 +110,7 @@ static void fair_share_manage(struct the
 		    trip->type == THERMAL_TRIP_HOT)
 			continue;
 
-		fair_share_throttle(tz, trip, trip_level);
+		fair_share_throttle(tz, td, trip_level);
 	}
 }
 
Index: linux-pm/drivers/thermal/gov_power_allocator.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_power_allocator.c
+++ linux-pm/drivers/thermal/gov_power_allocator.c
@@ -97,13 +97,6 @@ struct power_allocator_params {
 	struct power_actor *power;
 };
 
-static bool power_actor_is_valid(struct power_allocator_params *params,
-				 struct thermal_instance *instance)
-{
-	return (instance->trip == params->trip_max &&
-		 cdev_is_power_actor(instance->cdev));
-}
-
 /**
  * estimate_sustainable_power() - Estimate the sustainable power of a thermal zone
  * @tz: thermal zone we are operating in
@@ -118,13 +111,14 @@ static bool power_actor_is_valid(struct
 static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
 {
 	struct power_allocator_params *params = tz->governor_data;
+	const struct thermal_trip_desc *td = trip_to_trip_desc(params->trip_max);
 	struct thermal_cooling_device *cdev;
 	struct thermal_instance *instance;
 	u32 sustainable_power = 0;
 	u32 min_power;
 
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (!power_actor_is_valid(params, instance))
+	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
+		if (!cdev_is_power_actor(instance->cdev))
 			continue;
 
 		cdev = instance->cdev;
@@ -400,6 +394,7 @@ static void divvy_up_power(struct power_
 static void allocate_power(struct thermal_zone_device *tz, int control_temp)
 {
 	struct power_allocator_params *params = tz->governor_data;
+	const struct thermal_trip_desc *td = trip_to_trip_desc(params->trip_max);
 	unsigned int num_actors = params->num_actors;
 	struct power_actor *power = params->power;
 	struct thermal_cooling_device *cdev;
@@ -417,10 +412,10 @@ static void allocate_power(struct therma
 	/* Clean all buffers for new power estimations */
 	memset(power, 0, params->buffer_size);
 
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
 		struct power_actor *pa = &power[i];
 
-		if (!power_actor_is_valid(params, instance))
+		if (!cdev_is_power_actor(instance->cdev))
 			continue;
 
 		cdev = instance->cdev;
@@ -454,10 +449,10 @@ static void allocate_power(struct therma
 		       power_range);
 
 	i = 0;
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
 		struct power_actor *pa = &power[i];
 
-		if (!power_actor_is_valid(params, instance))
+		if (!cdev_is_power_actor(instance->cdev))
 			continue;
 
 		power_actor_set_power(instance->cdev, instance,
@@ -538,12 +533,13 @@ static void reset_pid_controller(struct
 static void allow_maximum_power(struct thermal_zone_device *tz)
 {
 	struct power_allocator_params *params = tz->governor_data;
+	const struct thermal_trip_desc *td = trip_to_trip_desc(params->trip_max);
 	struct thermal_cooling_device *cdev;
 	struct thermal_instance *instance;
 	u32 req_power;
 
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (!power_actor_is_valid(params, instance))
+	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
+		if (!cdev_is_power_actor(instance->cdev))
 			continue;
 
 		cdev = instance->cdev;
@@ -581,13 +577,11 @@ static void allow_maximum_power(struct t
 static int check_power_actors(struct thermal_zone_device *tz,
 			      struct power_allocator_params *params)
 {
+	const struct thermal_trip_desc *td = trip_to_trip_desc(params->trip_max);
 	struct thermal_instance *instance;
 	int ret = 0;
 
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (instance->trip != params->trip_max)
-			continue;
-
+	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
 		if (!cdev_is_power_actor(instance->cdev)) {
 			dev_warn(&tz->device, "power_allocator: %s is not a power actor\n",
 				 instance->cdev->type);
@@ -635,14 +629,15 @@ static void power_allocator_update_tz(st
 				      enum thermal_notify_event reason)
 {
 	struct power_allocator_params *params = tz->governor_data;
+	const struct thermal_trip_desc *td = trip_to_trip_desc(params->trip_max);
 	struct thermal_instance *instance;
 	int num_actors = 0;
 
 	switch (reason) {
 	case THERMAL_TZ_BIND_CDEV:
 	case THERMAL_TZ_UNBIND_CDEV:
-		list_for_each_entry(instance, &tz->thermal_instances, tz_node)
-			if (power_actor_is_valid(params, instance))
+		list_for_each_entry(instance, &td->thermal_instances, trip_node)
+			if (cdev_is_power_actor(instance->cdev))
 				num_actors++;
 
 		if (num_actors == params->num_actors)
@@ -652,8 +647,8 @@ static void power_allocator_update_tz(st
 		break;
 	case THERMAL_INSTANCE_WEIGHT_CHANGED:
 		params->total_weight = 0;
-		list_for_each_entry(instance, &tz->thermal_instances, tz_node)
-			if (power_actor_is_valid(params, instance))
+		list_for_each_entry(instance, &td->thermal_instances, trip_node)
+			if (cdev_is_power_actor(instance->cdev))
 				params->total_weight += instance->weight;
 		break;
 	default:
Index: linux-pm/drivers/thermal/gov_step_wise.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_step_wise.c
+++ linux-pm/drivers/thermal/gov_step_wise.c
@@ -66,9 +66,10 @@ static unsigned long get_target_state(st
 }
 
 static void thermal_zone_trip_update(struct thermal_zone_device *tz,
-				     const struct thermal_trip *trip,
+				     const struct thermal_trip_desc *td,
 				     int trip_threshold)
 {
+	const struct thermal_trip *trip = &td->trip;
 	enum thermal_trend trend = get_tz_trend(tz, trip);
 	int trip_id = thermal_zone_trip_id(tz, trip);
 	struct thermal_instance *instance;
@@ -82,12 +83,9 @@ static void thermal_zone_trip_update(str
 	dev_dbg(&tz->device, "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
 		trip_id, trip->type, trip_threshold, trend, throttle);
 
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
 		int old_target;
 
-		if (instance->trip != trip)
-			continue;
-
 		old_target = instance->target;
 		instance->target = get_target_state(instance, trend, throttle);
 
@@ -127,11 +125,13 @@ static void step_wise_manage(struct ther
 		    trip->type == THERMAL_TRIP_HOT)
 			continue;
 
-		thermal_zone_trip_update(tz, trip, td->threshold);
+		thermal_zone_trip_update(tz, td, td->threshold);
 	}
 
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
-		thermal_cdev_update(instance->cdev);
+	for_each_trip_desc(tz, td) {
+		list_for_each_entry(instance, &td->thermal_instances, trip_node)
+			thermal_cdev_update(instance->cdev);
+	}
 }
 
 static struct thermal_governor thermal_gov_step_wise = {
Index: linux-pm/drivers/thermal/thermal_helpers.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_helpers.c
+++ linux-pm/drivers/thermal/thermal_helpers.c
@@ -43,10 +43,11 @@ static bool thermal_instance_present(str
 				     struct thermal_cooling_device *cdev,
 				     const struct thermal_trip *trip)
 {
+	const struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *ti;
 
-	list_for_each_entry(ti, &tz->thermal_instances, tz_node) {
-		if (ti->trip == trip && ti->cdev == cdev)
+	list_for_each_entry(ti, &td->thermal_instances, trip_node) {
+		if (ti->cdev == cdev)
 			return true;
 	}
 





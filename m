Return-Path: <linux-pm+bounces-12087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD0194EF08
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 15:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28C31C217C1
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 13:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D962017C9EB;
	Mon, 12 Aug 2024 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="udcu4bC1"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A1853370;
	Mon, 12 Aug 2024 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723471180; cv=none; b=C1zBS7eULKdfWK8PFZUWeVHHonRXUp1jqnZlth7MA8g+V0fVNTE0p6crtEWbJPOvWdjOh7Nigh6hgUJB9Vwe2sKj0ZNwGS5X+m6+HCrrWN3Q/jmhyVPKkjP3dPcgmtkhMOkjG953KBkhc2Kf+LZmnIcz+4OQRygvpt3N07nfEZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723471180; c=relaxed/simple;
	bh=be02wNLge2e81Ebkc7I/FYYHGdi53PRnzeF6kZu+KvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+82dvwZQQ0aksfojUN1IFQopdveiEo9J2MaeX9hPFKd9t3BRAw3ST70P1TQxh2iAKMneBsP4HqCXAi0O0w8CmqDP41v8epwGSIK+YKc4rCeUdCx4KAKJmKX2rDFilndMb0lWJur+w+tCI3mu6fagp/WZsezjbUPYJpSgu4KdPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=udcu4bC1 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id d02df626233d17d3; Mon, 12 Aug 2024 15:59:35 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5050B6F0D6A;
	Mon, 12 Aug 2024 15:59:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1723471175;
	bh=be02wNLge2e81Ebkc7I/FYYHGdi53PRnzeF6kZu+KvE=;
	h=From:Subject:Date;
	b=udcu4bC17/7/Ahk9GaVzowX2hUVXBoJS67PlZ1fKmNQullDa6ogJzVTMppVA9DZzH
	 n7NzQ3i6J51yVY1Hk6NNeAUAlqFrHbBKtBT9B9aRL22m8m3J5EDAVvCzgrf84YuNQc
	 a7woftomhKLR74dZehhZPzKSk3Aw/CtTDr/UMQyTbaaWC7tw9RcYdhI5PGuu3AXJ5h
	 P4VyYNLV/Wp//z6jbUkeGmaxHfpascIrh88y7yg2AiTOP2PzCxg8Ii/JUoYjk4o/0J
	 pMlekI+ACOuKdE9qF+wdZmwz0mfHSnyYW5pjULA3jE4LndWrUTfCQ/jJUL4W2ksB4e
	 6Bgbpbw8v3YRA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v2 05/17] thermal: core: Move lists of thermal instances to trip
 descriptors
Date: Mon, 12 Aug 2024 15:59:15 +0200
Message-ID: <2691915.BddDVKsqQX@rjwysocki.net>
In-Reply-To: <114901234.nniJfEyVGO@rjwysocki.net>
References: <114901234.nniJfEyVGO@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddgjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhr
 tghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

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

v1 -> v2: No changes

---
 drivers/thermal/gov_bang_bang.c       |    8 ++----
 drivers/thermal/gov_fair_share.c      |   16 ++++---------
 drivers/thermal/gov_power_allocator.c |   41 ++++++++++++++--------------------
 drivers/thermal/gov_step_wise.c       |   16 ++++++-------
 drivers/thermal/thermal_core.c        |   33 +++++++++++++++------------
 drivers/thermal/thermal_core.h        |    5 +---
 drivers/thermal/thermal_helpers.c     |    5 ++--
 include/linux/thermal.h               |    4 +--
 8 files changed, 60 insertions(+), 68 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -491,7 +491,7 @@ static void thermal_zone_device_check(st
 
 static void thermal_zone_device_init(struct thermal_zone_device *tz)
 {
-	struct thermal_instance *pos;
+	struct thermal_trip_desc *td;
 
 	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
 
@@ -499,8 +499,12 @@ static void thermal_zone_device_init(str
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
@@ -774,13 +778,13 @@ struct thermal_zone_device *thermal_zone
  * Return: 0 on success, the proper error value otherwise.
  */
 int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
-				     const struct thermal_trip *trip,
+				     struct thermal_trip *trip,
 				     struct thermal_cooling_device *cdev,
 				     unsigned long upper, unsigned long lower,
 				     unsigned int weight)
 {
-	struct thermal_instance *dev;
-	struct thermal_instance *pos;
+	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
+	struct thermal_instance *dev, *instance;
 	bool upper_no_limit;
 	int result;
 
@@ -850,14 +854,14 @@ int thermal_bind_cdev_to_trip(struct the
 	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
 
-	list_for_each_entry(pos, &tz->thermal_instances, tz_node) {
-		if (pos->trip == trip && pos->cdev == cdev) {
+	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
+		if (instance->cdev == cdev) {
 			result = -EEXIST;
 			goto remove_weight_file;
 		}
 	}
 
-	list_add_tail(&dev->tz_node, &tz->thermal_instances);
+	list_add_tail(&dev->trip_node, &td->thermal_instances);
 	list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
 	atomic_set(&tz->need_update, 1);
 
@@ -909,17 +913,18 @@ EXPORT_SYMBOL_GPL(thermal_zone_bind_cool
  * Return: 0 on success, the proper error value otherwise.
  */
 int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
-				  const struct thermal_trip *trip,
+				  struct thermal_trip *trip,
 				  struct thermal_cooling_device *cdev)
 {
+	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *pos, *next;
 
 	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
 
-	list_for_each_entry_safe(pos, next, &tz->thermal_instances, tz_node) {
-		if (pos->trip == trip && pos->cdev == cdev) {
-			list_del(&pos->tz_node);
+	list_for_each_entry_safe(pos, next, &td->thermal_instances, trip_node) {
+		if (pos->cdev == cdev) {
+			list_del(&pos->trip_node);
 			list_del(&pos->cdev_node);
 
 			thermal_governor_update_tz(tz, THERMAL_TZ_UNBIND_CDEV);
@@ -1446,7 +1451,6 @@ thermal_zone_device_register_with_trips(
 		}
 	}
 
-	INIT_LIST_HEAD(&tz->thermal_instances);
 	INIT_LIST_HEAD(&tz->node);
 	ida_init(&tz->ida);
 	mutex_init(&tz->lock);
@@ -1470,6 +1474,7 @@ thermal_zone_device_register_with_trips(
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
@@ -224,7 +223,7 @@ struct thermal_instance {
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
@@ -45,6 +45,7 @@ static void bang_bang_control(struct the
 			      const struct thermal_trip *trip,
 			      bool crossed_up)
 {
+	const struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *instance;
 
 	lockdep_assert_held(&tz->lock);
@@ -53,10 +54,7 @@ static void bang_bang_control(struct the
 		thermal_zone_trip_id(tz, trip), trip->temperature,
 		tz->temperature, trip->hysteresis);
 
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (instance->trip != trip)
-			continue;
-
+	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
 		if (instance->target != 0 && instance->target != 1 &&
 		    instance->target != THERMAL_NO_TARGET)
 			pr_debug("Unexpected state %ld of thermal instance %s in bang-bang\n",
@@ -75,7 +73,7 @@ static void bang_bang_control(struct the
 		mutex_unlock(&instance->cdev->lock);
 	}
 
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
+	list_for_each_entry(instance, &td->thermal_instances, trip_node)
 		thermal_cdev_update(instance->cdev);
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
 
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -237,7 +237,7 @@ int thermal_zone_device_id(struct therma
 struct device *thermal_zone_device(struct thermal_zone_device *tzd);
 
 int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
-			      const struct thermal_trip *trip,
+			      struct thermal_trip *trip,
 			      struct thermal_cooling_device *cdev,
 			      unsigned long upper, unsigned long lower,
 			      unsigned int weight);
@@ -246,7 +246,7 @@ int thermal_zone_bind_cooling_device(str
 				     unsigned long, unsigned long,
 				     unsigned int);
 int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
-				  const struct thermal_trip *trip,
+				  struct thermal_trip *trip,
 				  struct thermal_cooling_device *cdev);
 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
 				       struct thermal_cooling_device *);





Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9893F67ED4B
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jan 2023 19:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbjA0SSc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Jan 2023 13:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbjA0SSP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jan 2023 13:18:15 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF4812F30;
        Fri, 27 Jan 2023 10:17:54 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 6963bb0f03b95451; Fri, 27 Jan 2023 19:17:05 +0100
Received: from kreacher.localnet (unknown [213.134.163.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 7155269CB42;
        Fri, 27 Jan 2023 19:17:04 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1] thermal: ACPI: Make helpers retrieve temperature only
Date:   Fri, 27 Jan 2023 19:17:03 +0100
Message-ID: <5641279.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.211
X-CLIENT-HOSTNAME: 213.134.163.211
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedruddviedguddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepvddufedrudefgedrudeifedrvdduudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieefrddvuddupdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
 lhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is slightly better to make the ACPI thermal helper functions retrieve
the trip point temperature only instead of doing the full trip point
initialization, because they are also used for updating some already
registered trip points, in which case initializing a new trip just
in order to update the temperature of an existing one is somewhat
wasteful.

Modify the ACPI thermal helpers accordingly and update their users.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

I've change my mind regarding what the ACPI thermal helpers should do after
the realization that they can be used for updating an existing trip point
as well as for initializing a new one.  It makes more sense for them to
return the temperature because of that, which is the change made here.

The patch is on top of the current linux-next branch in linux-pm.git.

Thanks!

---
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c |   40 ++--
 drivers/thermal/intel/intel_pch_thermal.c                    |    7 
 drivers/thermal/thermal_acpi.c                               |  108 +++--------
 include/linux/thermal.h                                      |    9 
 4 files changed, 70 insertions(+), 94 deletions(-)

Index: linux-pm/drivers/thermal/thermal_acpi.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_acpi.c
+++ linux-pm/drivers/thermal/thermal_acpi.c
@@ -21,42 +21,11 @@
 #define TEMP_MIN_DECIK	2180
 #define TEMP_MAX_DECIK	4480
 
-static int thermal_acpi_trip_init(struct acpi_device *adev,
-				  enum thermal_trip_type type, int id,
-				  struct thermal_trip *trip)
+static int thermal_acpi_trip_temp(struct acpi_device *adev, char *obj_name,
+				  int *ret_temp)
 {
 	unsigned long long temp;
 	acpi_status status;
-	char obj_name[5];
-
-	switch (type) {
-	case THERMAL_TRIP_ACTIVE:
-		if (id < 0 || id > 9)
-			return -EINVAL;
-
-		obj_name[1] = 'A';
-		obj_name[2] = 'C';
-		obj_name[3] = '0' + id;
-		break;
-	case THERMAL_TRIP_PASSIVE:
-		obj_name[1] = 'P';
-		obj_name[2] = 'S';
-		obj_name[3] = 'V';
-		break;
-	case THERMAL_TRIP_HOT:
-		obj_name[1] = 'H';
-		obj_name[2] = 'O';
-		obj_name[3] = 'T';
-		break;
-	case THERMAL_TRIP_CRITICAL:
-		obj_name[1] = 'C';
-		obj_name[2] = 'R';
-		obj_name[3] = 'T';
-		break;
-	}
-
-	obj_name[0] = '_';
-	obj_name[4] = '\0';
 
 	status = acpi_evaluate_integer(adev->handle, obj_name, NULL, &temp);
 	if (ACPI_FAILURE(status)) {
@@ -65,87 +34,84 @@ static int thermal_acpi_trip_init(struct
 	}
 
 	if (temp >= TEMP_MIN_DECIK && temp <= TEMP_MAX_DECIK) {
-		trip->temperature = deci_kelvin_to_millicelsius(temp);
+		*ret_temp = deci_kelvin_to_millicelsius(temp);
 	} else {
 		acpi_handle_debug(adev->handle, "%s result %llu out of range\n",
 				  obj_name, temp);
-		trip->temperature = THERMAL_TEMP_INVALID;
+		*ret_temp = THERMAL_TEMP_INVALID;
 	}
 
-	trip->hysteresis = 0;
-	trip->type = type;
-
 	return 0;
 }
 
 /**
- * thermal_acpi_trip_active - Get the specified active trip point
- * @adev: Thermal zone ACPI device object to get the description from.
+ * thermal_acpi_active_trip_temp - Retrieve active trip point temperature
+ * @adev: Target thermal zone ACPI device object.
  * @id: Active cooling level (0 - 9).
- * @trip: Trip point structure to be populated on success.
+ * @ret_temp: Address to store the retrieved temperature value on success.
  *
  * Evaluate the _ACx object for the thermal zone represented by @adev to obtain
  * the temperature of the active cooling trip point corresponding to the active
- * cooling level given by @id and initialize @trip as an active trip point using
- * that temperature value.
+ * cooling level given by @id.
  *
  * Return 0 on success or a negative error value on failure.
  */
-int thermal_acpi_trip_active(struct acpi_device *adev, int id,
-			     struct thermal_trip *trip)
+int thermal_acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp)
 {
-	return thermal_acpi_trip_init(adev, THERMAL_TRIP_ACTIVE, id, trip);
+	char obj_name[] = {'_', 'A', 'C', '0' + id, '\0'};
+
+	if (id < 0 || id > 9)
+		return -EINVAL;
+
+	return thermal_acpi_trip_temp(adev, obj_name, ret_temp);
 }
-EXPORT_SYMBOL_GPL(thermal_acpi_trip_active);
+EXPORT_SYMBOL_GPL(thermal_acpi_active_trip_temp);
 
 /**
- * thermal_acpi_trip_passive - Get the passive trip point
- * @adev: Thermal zone ACPI device object to get the description from.
- * @trip: Trip point structure to be populated on success.
+ * thermal_acpi_passive_trip_temp - Retrieve passive trip point temperature
+ * @adev: Target thermal zone ACPI device object.
+ * @ret_temp: Address to store the retrieved temperature value on success.
  *
  * Evaluate the _PSV object for the thermal zone represented by @adev to obtain
- * the temperature of the passive cooling trip point and initialize @trip as a
- * passive trip point using that temperature value.
+ * the temperature of the passive cooling trip point.
  *
  * Return 0 on success or -ENODATA on failure.
  */
-int thermal_acpi_trip_passive(struct acpi_device *adev, struct thermal_trip *trip)
+int thermal_acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp)
 {
-	return thermal_acpi_trip_init(adev, THERMAL_TRIP_PASSIVE, INT_MAX, trip);
+	return thermal_acpi_trip_temp(adev, "_PSV", ret_temp);
 }
-EXPORT_SYMBOL_GPL(thermal_acpi_trip_passive);
+EXPORT_SYMBOL_GPL(thermal_acpi_passive_trip_temp);
 
 /**
- * thermal_acpi_trip_hot - Get the near critical trip point
- * @adev: the ACPI device to get the description from.
- * @trip: a &struct thermal_trip to be filled if the function succeed.
+ * thermal_acpi_hot_trip_temp - Retrieve hot trip point temperature
+ * @adev: Target thermal zone ACPI device object.
+ * @ret_temp: Address to store the retrieved temperature value on success.
  *
  * Evaluate the _HOT object for the thermal zone represented by @adev to obtain
  * the temperature of the trip point at which the system is expected to be put
- * into the S4 sleep state and initialize @trip as a hot trip point using that
- * temperature value.
+ * into the S4 sleep state.
  *
  * Return 0 on success or -ENODATA on failure.
  */
-int thermal_acpi_trip_hot(struct acpi_device *adev, struct thermal_trip *trip)
+int thermal_acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp)
 {
-	return thermal_acpi_trip_init(adev, THERMAL_TRIP_HOT, INT_MAX, trip);
+	return thermal_acpi_trip_temp(adev, "_HOT", ret_temp);
 }
-EXPORT_SYMBOL_GPL(thermal_acpi_trip_hot);
+EXPORT_SYMBOL_GPL(thermal_acpi_hot_trip_temp);
 
 /**
- * thermal_acpi_trip_critical - Get the critical trip point
- * @adev: the ACPI device to get the description from.
- * @trip: a &struct thermal_trip to be filled if the function succeed.
+ * thermal_acpi_critical_trip_temp - Retrieve critical trip point temperature
+ * @adev: Target thermal zone ACPI device object.
+ * @ret_temp: Address to store the retrieved temperature value on success.
  *
  * Evaluate the _CRT object for the thermal zone represented by @adev to obtain
- * the temperature of the critical cooling trip point and initialize @trip as a
- * critical trip point using that temperature value.
+ * the temperature of the critical cooling trip point.
  *
  * Return 0 on success or -ENODATA on failure.
  */
-int thermal_acpi_trip_critical(struct acpi_device *adev, struct thermal_trip *trip)
+int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp)
 {
-	return thermal_acpi_trip_init(adev, THERMAL_TRIP_CRITICAL, INT_MAX, trip);
+	return thermal_acpi_trip_temp(adev, "_CRT", ret_temp);
 }
-EXPORT_SYMBOL_GPL(thermal_acpi_trip_critical);
+EXPORT_SYMBOL_GPL(thermal_acpi_critical_trip_temp);
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -347,11 +347,10 @@ int thermal_zone_get_num_trips(struct th
 int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp);
 
 #ifdef CONFIG_THERMAL_ACPI
-int thermal_acpi_trip_active(struct acpi_device *adev, int id,
-			     struct thermal_trip *trip);
-int thermal_acpi_trip_passive(struct acpi_device *adev, struct thermal_trip *trip);
-int thermal_acpi_trip_hot(struct acpi_device *adev, struct thermal_trip *trip);
-int thermal_acpi_trip_critical(struct acpi_device *adev, struct thermal_trip *trip);
+int thermal_acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp);
+int thermal_acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp);
+int thermal_acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp);
+int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp);
 #endif
 
 #ifdef CONFIG_THERMAL
Index: linux-pm/drivers/thermal/intel/intel_pch_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_pch_thermal.c
+++ linux-pm/drivers/thermal/intel/intel_pch_thermal.c
@@ -100,16 +100,17 @@ static void pch_wpt_add_acpi_psv_trip(st
 				      int *nr_trips)
 {
 	struct acpi_device *adev;
-	int ret;
+	int temp;
 
 	adev = ACPI_COMPANION(&ptd->pdev->dev);
 	if (!adev)
 		return;
 
-	ret = thermal_acpi_trip_passive(adev, &ptd->trips[*nr_trips]);
-	if (ret || ptd->trips[*nr_trips].temperature <= 0)
+	if (thermal_acpi_passive_trip_temp(adev, &temp) || temp <= 0)
 		return;
 
+	ptd->trips[*nr_trips].type = THERMAL_TRIP_PASSIVE;
+	ptd->trips[*nr_trips].temperature = temp;
 	++(*nr_trips);
 }
 #else
Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -70,24 +70,35 @@ static int int340x_thermal_read_trips(st
 {
 	int i, ret;
 
-	ret = thermal_acpi_trip_critical(zone_adev, &zone_trips[trip_cnt]);
-	if (!ret)
+	ret = thermal_acpi_critical_trip_temp(zone_adev,
+					      &zone_trips[trip_cnt].temperature);
+	if (!ret) {
+		zone_trips[trip_cnt].type = THERMAL_TRIP_CRITICAL;
 		trip_cnt++;
+	}
 
-	ret = thermal_acpi_trip_hot(zone_adev, &zone_trips[trip_cnt]);
-	if (!ret)
+	ret = thermal_acpi_hot_trip_temp(zone_adev,
+					 &zone_trips[trip_cnt].temperature);
+	if (!ret) {
+		zone_trips[trip_cnt].type = THERMAL_TRIP_HOT;
 		trip_cnt++;
+	}
 
-	ret = thermal_acpi_trip_passive(zone_adev, &zone_trips[trip_cnt]);
-	if (!ret)
+	ret = thermal_acpi_passive_trip_temp(zone_adev,
+					     &zone_trips[trip_cnt].temperature);
+	if (!ret) {
+		zone_trips[trip_cnt].type = THERMAL_TRIP_PASSIVE;
 		trip_cnt++;
+	}
 
 	for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
 
-		ret = thermal_acpi_trip_active(zone_adev, i, &zone_trips[trip_cnt]);
+		ret = thermal_acpi_active_trip_temp(zone_adev, i,
+						    &zone_trips[trip_cnt].temperature);
 		if (ret)
 			break;
 
+		zone_trips[trip_cnt].type = THERMAL_TRIP_ACTIVE;
 		trip_cnt++;
 	}
 
@@ -213,22 +224,21 @@ void int340x_thermal_update_trips(struct
 	mutex_lock(&int34x_zone->zone->lock);
 
 	for (i = int34x_zone->aux_trip_nr; i < trip_cnt; i++) {
-		struct thermal_trip trip;
-		int err;
+		int temp, err;
 
 		switch (zone_trips[i].type) {
 		case THERMAL_TRIP_CRITICAL:
-			err = thermal_acpi_trip_critical(zone_adev, &trip);
+			err = thermal_acpi_critical_trip_temp(zone_adev, &temp);
 			break;
 		case THERMAL_TRIP_HOT:
-			err = thermal_acpi_trip_hot(zone_adev, &trip);
+			err = thermal_acpi_hot_trip_temp(zone_adev, &temp);
 			break;
 		case THERMAL_TRIP_PASSIVE:
-			err = thermal_acpi_trip_passive(zone_adev, &trip);
+			err = thermal_acpi_passive_trip_temp(zone_adev, &temp);
 			break;
 		case THERMAL_TRIP_ACTIVE:
-			err = thermal_acpi_trip_active(zone_adev, act_trip_nr++,
-						       &trip);
+			err = thermal_acpi_active_trip_temp(zone_adev, act_trip_nr++,
+							    &temp);
 			break;
 		default:
 			err = -ENODEV;
@@ -238,7 +248,7 @@ void int340x_thermal_update_trips(struct
 			continue;
 		}
 
-		zone_trips[i].temperature = trip.temperature;
+		zone_trips[i].temperature = temp;
 	}
 
 	mutex_unlock(&int34x_zone->zone->lock);




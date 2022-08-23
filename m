Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F0359E6EF
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 18:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243238AbiHWQWC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 12:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244656AbiHWQV3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 12:21:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADC613A381
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 05:43:24 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:43:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661258602;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x4w4Yfq0FxnMwhB5m+vQ0Y4e0kTKx+MDp6Cv2PzTzwg=;
        b=Y++lQhILLQc+Pw4pw/qaVyJLnSVaZv8ncaAJtibs0moZ6ayORCA3n20HcE8xDpkkFc9P5r
        Hl+vNzujW47AtFaTinyxJQL7T6uj78GZ0KJ66FRrpA2QBqVS97AdIycWNudNihCZjYLZeD
        KDfpE5t6jtSohKN83mfX9OT53MMTjMn+3tc1fmrGcfkh5hrHOlrJjLPeGVle3AVCDlJKy1
        m+NEEAlnXHV3usdnQXUx+RsBLJGRJIrm6kIBfFECUug3Zf3jHJSgfGtwDYvb1ai8R1R3+S
        38Js8i9GLkQC334lVZcgye7gjNvLjUNhUMAcTxDqXmMrbvn0d1j24wlw3VB6dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661258602;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x4w4Yfq0FxnMwhB5m+vQ0Y4e0kTKx+MDp6Cv2PzTzwg=;
        b=ImDbiYK2/Ij3CzMAtdYA5uImCjWETqzYxreREUktWrMr5ZQkkSXQdzw1M/Qtyd6epsOWRw
        C/7lnD+cN8dv6vAg==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/of: Rework the thermal device tree
 initialization
Cc:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220804224349.1926752-2-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-2-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Message-ID: <166125860167.401.14088771946746448449.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     3fd6d6e2b4e80fe45bfd1c8f01dff7d30a0f9b53
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//3fd6d6e2b4e80fe45bfd1c8f01dff7d30a0f9b53
Author:        Daniel Lezcano <daniel.lezcano@linexp.org>
AuthorDate:    Fri, 05 Aug 2022 00:43:17 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Aug 2022 14:09:37 +02:00

thermal/of: Rework the thermal device tree initialization

The following changes are reworking entirely the thermal device tree
initialization. The old version is kept until the different drivers
using it are converted to the new API.

The old approach creates the different actors independently. This
approach is the source of the code duplication in the thermal OF
because a thermal zone is created but a sensor is registered
after. The thermal zones are created unconditionnaly with a fake
sensor at init time, thus forcing to provide fake ops and store all
the thermal zone related information in duplicated structures. Then
the sensor is initialized and the code looks up the thermal zone name
using the device tree. Then the sensor is associated to the thermal
zone, and the sensor specific ops are called with a second level of
indirection from the thermal zone ops.

When a sensor is removed (with a module unload), the thermal zone
stays there with the fake sensor.

The cooling device associated with a thermal zone and a trip point is
stored in a list, again duplicating information, using the node name
of the device tree to match afterwards the cooling devices.

The new approach is simpler, it creates a thermal zone when the sensor
is registered and destroys it when the sensor is removed. All the
matching between the cooling device, trip points and thermal zones are
done using the device tree, as well as bindings. The ops are no longer
specific but uses the generic ones provided by the thermal framework.

When the old code won't have any users, it can be removed and the
remaining thermal OF code will be much simpler.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Link: https://lore.kernel.org/r/20220804224349.1926752-2-daniel.lezcano@linexp.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_of.c | 460 +++++++++++++++++++++++++++++++++-
 include/linux/thermal.h      |  18 +-
 2 files changed, 468 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 802c30b..82236fe 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -811,16 +811,6 @@ static int thermal_of_get_trip_type(struct device_node *np,
 	return -ENODEV;
 }
 
-/**
- * thermal_of_populate_trip - parse and fill one trip point data
- * @np: DT node containing a trip point node
- * @trip: trip point data structure to be filled up
- *
- * This function parses a trip point type of node represented by
- * @np parameter and fills the read data into @trip data structure.
- *
- * Return: 0 on success, proper error code otherwise
- */
 static int thermal_of_populate_trip(struct device_node *np,
 				    struct thermal_trip *trip)
 {
@@ -1065,6 +1055,456 @@ static __init void of_thermal_destroy_zones(void)
 	of_node_put(np);
 }
 
+static struct device_node *of_thermal_zone_find(struct device_node *sensor, int id)
+{
+	struct device_node *np, *tz;
+	struct of_phandle_args sensor_specs;
+
+	np = of_find_node_by_name(NULL, "thermal-zones");
+	if (!np) {
+		pr_err("Unable to find thermal zones description\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	/*
+	 * Search for each thermal zone, a defined sensor
+	 * corresponding to the one passed as parameter
+	 */
+	for_each_available_child_of_node(np, tz) {
+
+		int count, i;
+
+		count = of_count_phandle_with_args(tz, "thermal-sensors",
+						   "#thermal-sensor-cells");
+		if (count <= 0) {
+			pr_err("%pOFn: missing thermal sensor\n", tz);
+			tz = ERR_PTR(-EINVAL);
+			goto out;
+		}
+
+		for (i = 0; i < count; i++) {
+
+			int ret;
+
+			ret = of_parse_phandle_with_args(tz, "thermal-sensors",
+							 "#thermal-sensor-cells",
+							 i, &sensor_specs);
+			if (ret < 0) {
+				pr_err("%pOFn: Failed to read thermal-sensors cells: %d\n", tz, ret);
+				tz = ERR_PTR(ret);
+				goto out;
+			}
+
+			if ((sensor == sensor_specs.np) && id == (sensor_specs.args_count ?
+								  sensor_specs.args[0] : 0)) {
+				pr_debug("sensor %pOFn id=%d belongs to %pOFn\n", sensor, id, tz);
+				goto out;
+			}
+		}
+	}
+out:
+	of_node_put(np);
+	return tz;
+}
+
+static int thermal_of_monitor_init(struct device_node *np, int *delay, int *pdelay)
+{
+	int ret;
+
+	ret = of_property_read_u32(np, "polling-delay-passive", pdelay);
+	if (ret < 0) {
+		pr_err("%pOFn: missing polling-delay-passive property\n", np);
+		return ret;
+	}
+
+	ret = of_property_read_u32(np, "polling-delay", delay);
+	if (ret < 0) {
+		pr_err("%pOFn: missing polling-delay property\n", np);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct thermal_zone_params *thermal_of_parameters_init(struct device_node *np)
+{
+	struct thermal_zone_params *tzp;
+	int coef[2];
+	int ncoef = ARRAY_SIZE(coef);
+	int prop, ret;
+
+	tzp = kzalloc(sizeof(*tzp), GFP_KERNEL);
+	if (!tzp)
+		return ERR_PTR(-ENOMEM);
+
+	tzp->no_hwmon = true;
+
+	if (!of_property_read_u32(np, "sustainable-power", &prop))
+		tzp->sustainable_power = prop;
+
+	/*
+	 * For now, the thermal framework supports only one sensor per
+	 * thermal zone. Thus, we are considering only the first two
+	 * values as slope and offset.
+	 */
+	ret = of_property_read_u32_array(np, "coefficients", coef, ncoef);
+	if (ret) {
+		coef[0] = 1;
+		coef[1] = 0;
+	}
+
+	tzp->slope = coef[0];
+	tzp->offset = coef[1];
+
+	return tzp;
+}
+
+static struct device_node *thermal_of_zone_get_by_name(struct thermal_zone_device *tz)
+{
+	struct device_node *np, *tz_np;
+
+	np = of_find_node_by_name(NULL, "thermal-zones");
+	if (!np)
+		return ERR_PTR(-ENODEV);
+
+	tz_np = of_get_child_by_name(np, tz->type);
+
+	of_node_put(np);
+
+	if (!tz_np)
+		return ERR_PTR(-ENODEV);
+
+	return tz_np;
+}
+
+static int __thermal_of_unbind(struct device_node *map_np, int index, int trip_id,
+			       struct thermal_zone_device *tz, struct thermal_cooling_device *cdev)
+{
+	struct of_phandle_args cooling_spec;
+	int ret;
+
+	ret = of_parse_phandle_with_args(map_np, "cooling-device", "#cooling-cells",
+					 index, &cooling_spec);
+
+	of_node_put(cooling_spec.np);
+
+	if (ret < 0) {
+		pr_err("Invalid cooling-device entry\n");
+		return ret;
+	}
+
+	if (cooling_spec.args_count < 2) {
+		pr_err("wrong reference to cooling device, missing limits\n");
+		return -EINVAL;
+	}
+
+	if (cooling_spec.np != cdev->np)
+		return 0;
+
+	ret = thermal_zone_unbind_cooling_device(tz, trip_id, cdev);
+	if (ret)
+		pr_err("Failed to unbind '%s' with '%s': %d\n", tz->type, cdev->type, ret);
+
+	return ret;
+}
+
+static int __thermal_of_bind(struct device_node *map_np, int index, int trip_id,
+			     struct thermal_zone_device *tz, struct thermal_cooling_device *cdev)
+{
+	struct of_phandle_args cooling_spec;
+	int ret, weight = THERMAL_WEIGHT_DEFAULT;
+
+	of_property_read_u32(map_np, "contribution", &weight);
+
+	ret = of_parse_phandle_with_args(map_np, "cooling-device", "#cooling-cells",
+					 index, &cooling_spec);
+
+	of_node_put(cooling_spec.np);
+
+	if (ret < 0) {
+		pr_err("Invalid cooling-device entry\n");
+		return ret;
+	}
+
+	if (cooling_spec.args_count < 2) {
+		pr_err("wrong reference to cooling device, missing limits\n");
+		return -EINVAL;
+	}
+
+	if (cooling_spec.np != cdev->np)
+		return 0;
+
+	ret = thermal_zone_bind_cooling_device(tz, trip_id, cdev, cooling_spec.args[1],
+					       cooling_spec.args[0],
+					       weight);
+	if (ret)
+		pr_err("Failed to bind '%s' with '%s': %d\n", tz->type, cdev->type, ret);
+
+	return ret;
+}
+
+static int thermal_of_for_each_cooling_device(struct device_node *tz_np, struct device_node *map_np,
+					      struct thermal_zone_device *tz, struct thermal_cooling_device *cdev,
+					      int (*action)(struct device_node *, int, int,
+							    struct thermal_zone_device *, struct thermal_cooling_device *))
+{
+	struct device_node *tr_np;
+	int count, i, trip_id;
+
+	tr_np = of_parse_phandle(map_np, "trip", 0);
+	if (!tr_np)
+		return -ENODEV;
+
+	trip_id = of_find_trip_id(tz_np, tr_np);
+	if (trip_id < 0)
+		return trip_id;
+
+	count = of_count_phandle_with_args(map_np, "cooling-device", "#cooling-cells");
+	if (count <= 0) {
+		pr_err("Add a cooling_device property with at least one device\n");
+		return -ENOENT;
+	}
+
+	/*
+	 * At this point, we don't want to bail out when there is an
+	 * error, we will try to bind/unbind as many as possible
+	 * cooling devices
+	 */
+	for (i = 0; i < count; i++)
+		action(map_np, i, trip_id, tz, cdev);
+
+	return 0;
+}
+
+static int thermal_of_for_each_cooling_maps(struct thermal_zone_device *tz,
+					    struct thermal_cooling_device *cdev,
+					    int (*action)(struct device_node *, int, int,
+							  struct thermal_zone_device *, struct thermal_cooling_device *))
+{
+	struct device_node *tz_np, *cm_np, *child;
+	int ret = 0;
+
+	tz_np = thermal_of_zone_get_by_name(tz);
+	if (IS_ERR(tz_np)) {
+		pr_err("Failed to get node tz by name\n");
+		return PTR_ERR(tz_np);
+	}
+
+	cm_np = of_get_child_by_name(tz_np, "cooling-maps");
+	if (!cm_np)
+		goto out;
+
+	for_each_child_of_node(cm_np, child) {
+		ret = thermal_of_for_each_cooling_device(tz_np, child, tz, cdev, action);
+		if (ret)
+			break;
+	}
+
+	of_node_put(cm_np);
+out:
+	of_node_put(tz_np);
+
+	return ret;
+}
+
+static int thermal_of_bind(struct thermal_zone_device *tz,
+			   struct thermal_cooling_device *cdev)
+{
+	return thermal_of_for_each_cooling_maps(tz, cdev, __thermal_of_bind);
+}
+
+static int thermal_of_unbind(struct thermal_zone_device *tz,
+			     struct thermal_cooling_device *cdev)
+{
+	return thermal_of_for_each_cooling_maps(tz, cdev, __thermal_of_unbind);
+}
+
+/**
+ * thermal_of_zone_unregister - Cleanup the specific allocated ressources
+ *
+ * This function disables the thermal zone and frees the different
+ * ressources allocated specific to the thermal OF.
+ *
+ * @tz: a pointer to the thermal zone structure
+ */
+void thermal_of_zone_unregister(struct thermal_zone_device *tz)
+{
+	thermal_zone_device_disable(tz);
+	thermal_zone_device_unregister(tz);
+	kfree(tz->trips);
+	kfree(tz->tzp);
+	kfree(tz->ops);
+}
+EXPORT_SYMBOL_GPL(thermal_of_zone_unregister);
+
+/**
+ * thermal_of_zone_register - Register a thermal zone with device node
+ * sensor
+ *
+ * The thermal_of_zone_register() parses a device tree given a device
+ * node sensor and identifier. It searches for the thermal zone
+ * associated to the couple sensor/id and retrieves all the thermal
+ * zone properties and registers new thermal zone with those
+ * properties.
+ *
+ * @sensor: A device node pointer corresponding to the sensor in the device tree
+ * @id: An integer as sensor identifier
+ * @data: A private data to be stored in the thermal zone dedicated private area
+ * @ops: A set of thermal sensor ops
+ *
+ * Return: a valid thermal zone structure pointer on success.
+ * 	- EINVAL: if the device tree thermal description is malformed
+ *	- ENOMEM: if one structure can not be allocated
+ *	- Other negative errors are returned by the underlying called functions
+ */
+struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
+						     const struct thermal_zone_device_ops *ops)
+{
+	struct thermal_zone_device *tz;
+	struct thermal_trip *trips;
+	struct thermal_zone_params *tzp;
+	struct thermal_zone_device_ops *of_ops;
+	struct device_node *np;
+	int delay, pdelay;
+	int ntrips, mask;
+	int ret;
+
+	of_ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
+	if (!of_ops)
+		return ERR_PTR(-ENOMEM);
+
+	np = of_thermal_zone_find(sensor, id);
+	if (IS_ERR(np)) {
+		pr_err("Failed to find thermal zone for %pOFn id=%d\n", sensor, id);
+		return ERR_CAST(np);
+	}
+
+	trips = thermal_of_trips_init(np, &ntrips);
+	if (IS_ERR(trips)) {
+		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
+		return ERR_CAST(trips);
+	}
+
+	ret = thermal_of_monitor_init(np, &delay, &pdelay);
+	if (ret) {
+		pr_err("Failed to initialize monitoring delays from %pOFn\n", np);
+		goto out_kfree_trips;
+	}
+
+	tzp = thermal_of_parameters_init(np);
+	if (IS_ERR(tzp)) {
+		ret = PTR_ERR(tzp);
+		pr_err("Failed to initialize parameter from %pOFn: %d\n", np, ret);
+		goto out_kfree_trips;
+	}
+
+	of_ops->get_trip_type = of_ops->get_trip_type ? : of_thermal_get_trip_type;
+	of_ops->get_trip_temp = of_ops->get_trip_temp ? : of_thermal_get_trip_temp;
+	of_ops->get_trip_hyst = of_ops->get_trip_hyst ? : of_thermal_get_trip_hyst;
+	of_ops->set_trip_hyst = of_ops->set_trip_hyst ? : of_thermal_set_trip_hyst;
+	of_ops->get_crit_temp = of_ops->get_crit_temp ? : of_thermal_get_crit_temp;
+	of_ops->bind = thermal_of_bind;
+	of_ops->unbind = thermal_of_unbind;
+
+	mask = GENMASK_ULL((ntrips) - 1, 0);
+
+	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
+						     mask, data, of_ops, tzp,
+						     pdelay, delay);
+	if (IS_ERR(tz)) {
+		ret = PTR_ERR(tz);
+		pr_err("Failed to register thermal zone %pOFn: %d\n", np, ret);
+		goto out_kfree_tzp;
+	}
+
+	ret = thermal_zone_device_enable(tz);
+	if (ret) {
+		pr_err("Failed to enabled thermal zone '%s', id=%d: %d\n",
+		       tz->type, tz->id, ret);
+		thermal_of_zone_unregister(tz);
+		return ERR_PTR(ret);
+	}
+
+	return tz;
+
+out_kfree_tzp:
+	kfree(tzp);
+out_kfree_trips:
+	kfree(trips);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(thermal_of_zone_register);
+
+static void devm_thermal_of_zone_release(struct device *dev, void *res)
+{
+	thermal_of_zone_unregister(*(struct thermal_zone_device **)res);
+}
+
+static int devm_thermal_of_zone_match(struct device *dev, void *res,
+				      void *data)
+{
+	struct thermal_zone_device **r = res;
+
+	if (WARN_ON(!r || !*r))
+		return 0;
+
+	return *r == data;
+}
+
+/**
+ * devm_thermal_of_zone_register - register a thermal tied with the sensor life cycle
+ *
+ * This function is the device version of the thermal_of_zone_register() function.
+ *
+ * @dev: a device structure pointer to sensor to be tied with the thermal zone OF life cycle
+ * @sensor_id: the sensor identifier
+ * @data: a pointer to a private data to be stored in the thermal zone 'devdata' field
+ * @ops: a pointer to the ops structure associated with the sensor
+ */
+struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, int sensor_id, void *data,
+							  const struct thermal_zone_device_ops *ops)
+{
+	struct thermal_zone_device **ptr, *tzd;
+
+	ptr = devres_alloc(devm_thermal_of_zone_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	tzd = thermal_of_zone_register(dev->of_node, sensor_id, data, ops);
+	if (IS_ERR(tzd)) {
+		devres_free(ptr);
+		return tzd;
+	}
+
+	*ptr = tzd;
+	devres_add(dev, ptr);
+
+	return tzd;
+}
+EXPORT_SYMBOL_GPL(devm_thermal_of_zone_register);
+
+/**
+ * devm_thermal_of_zone_unregister - Resource managed version of
+ *				thermal_of_zone_unregister().
+ * @dev: Device for which which resource was allocated.
+ * @tz: a pointer to struct thermal_zone where the sensor is registered.
+ *
+ * This function removes the sensor callbacks and private data from the
+ * thermal zone device registered with devm_thermal_zone_of_sensor_register()
+ * API. It will also silent the zone by remove the .get_temp() and .get_trend()
+ * thermal zone device callbacks.
+ * Normally this function will not need to be called and the resource
+ * management code will ensure that the resource is freed.
+ */
+void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz)
+{
+	WARN_ON(devres_release(dev, devm_thermal_zone_of_sensor_release,
+			       devm_thermal_of_zone_match, tz));
+}
+EXPORT_SYMBOL_GPL(devm_thermal_of_zone_unregister);
+
 /**
  * of_parse_thermal_zones - parse device tree thermal data
  *
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 1386c71..e2ac9d4 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -325,6 +325,16 @@ struct thermal_zone_of_device_ops {
 
 /* Function declarations */
 #ifdef CONFIG_THERMAL_OF
+struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
+						     const struct thermal_zone_device_ops *ops);
+
+struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, int id, void *data,
+							  const struct thermal_zone_device_ops *ops);
+
+void thermal_of_zone_unregister(struct thermal_zone_device *tz);
+
+void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz);
+
 int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
 				  struct device_node *sensor_np,
 				  u32 *id);
@@ -366,6 +376,14 @@ static inline struct thermal_zone_device *devm_thermal_zone_of_sensor_register(
 	return ERR_PTR(-ENODEV);
 }
 
+static inline void thermal_of_zone_unregister(struct thermal_zone_device *tz)
+{
+}
+
+static inline void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz)
+{
+}
+
 static inline
 void devm_thermal_zone_of_sensor_unregister(struct device *dev,
 					    struct thermal_zone_device *tz)

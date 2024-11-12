Return-Path: <linux-pm+bounces-17375-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5459C4E2A
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 06:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDEC22859AE
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 05:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F3C20ADF5;
	Tue, 12 Nov 2024 05:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="b2Ub0Gix";
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QrZyyn/s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tmq4MrcL"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139F520720F;
	Tue, 12 Nov 2024 05:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731388939; cv=none; b=mwJuoZv56zC1DO9usQt317R0O0MFMKAtD8ZlaiwdC+I7vDAWgaO5xD49Vfa7xRqDoH0rFXcofCfWcb2OnpgzwjpMUj/B21d2CXNjkX9jxjOIha7LdcG3GcB8hnaGM9+lkyyZ6pBb1qpY0Srl5qKIygjG2N092NIyLE4nJAXzY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731388939; c=relaxed/simple;
	bh=8xwilQFGOCfXbB+ZJp+tGPxGwe3Aq/z9dFzjyvqsuZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOqVQk4cazSC65UVjkOve0460QZdtrw7h8iBlrGY8+/kUlEbpx9CbEGsze/2uJI/UAqedTaeiozGVCAGMUnM0j1Ls1v/d78NRjmuf2lUIzgsc9i/3iPMDG4bs2ATtuQytFNP44LwEvN3JBDVs9eWtgRGVz5CqjwiBljFg8qT/9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=b2Ub0Gix; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QrZyyn/s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tmq4MrcL; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 185A113800AB;
	Tue, 12 Nov 2024 00:22:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 12 Nov 2024 00:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=2016-12.pbsmtp; t=1731388935;
	 x=1731475335; bh=Nq/6/CpfdvFHxWlMyGuOOsUGAG0x/aWCQ1FsqavQtag=; b=
	b2Ub0GixUiKwPuZ7/wiIbHZA9KFM9ovk3JvBNwwfoGaSBvnP1u6EvYJTgWPNDhlM
	ZwSOgebG0AaFjSZMgiJzpuPR88wdq1t4bxvKJPW478/VmYBqa6vQ/N4E3T0CLtXw
	lzdKFXQ+xHIGkQT0tp2C0kDPikyED6X9G1q+H35XVIM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1731388935; x=
	1731475335; bh=Nq/6/CpfdvFHxWlMyGuOOsUGAG0x/aWCQ1FsqavQtag=; b=Q
	rZyyn/sYsLDHeMObQHre8KQqKi7dIoa2X8OKkWeMG7jFbiT9EZvv4H3pbmYSfc+m
	y1PrfnpeE3xb5f4wcgQuPTtJzs+zg6KWAF79iWVZH62nor2YfW6uUEm3cs9ncoG6
	eXrSbYcSILbRoVLS4DFkN2d/TIeyVWo1YHo1a/guMtDJ5QfjCM5cR4qyw5X7JW2S
	rmlH7TVqsY1lHEFFPQjhrTOW1TsBhq5QbAeDGNnjchf57bIOdWgzOljQ2Ddq9rVB
	JOR3fhINmFwsyCO6WTpypZOMJ6uKFMZaUqDOur3RtxgsfR9L43vlavlAN/o6zFWQ
	eJRqC0ivzt6FpfAAXmg1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731388935; x=1731475335; bh=N
	q/6/CpfdvFHxWlMyGuOOsUGAG0x/aWCQ1FsqavQtag=; b=Tmq4MrcLscEkBmac1
	MWosvcbvpDyrcO7Aoz71MPLfUrMqmKWWspkg08d1x5x2TOYBZCFe8NLsF3OPPN+r
	92C3dOCYFsAjyHSZ/+ydxNQOgDrgVfGSvUgHUTwlQVR324lg9N4Y6q1Zbx3It2KS
	v795n5P0L9bPXYLxlis+bpT5Q6wHrb2amxvTfsc3hPYiD5EMyVsgyNlTaUWOoaC4
	y2qw3+l6+bk+PjDwUqYeIKXDMMW5w4KHNj5LS1pu4XbKeBJlGWjAC4t9Uh8UQSG8
	E5kVe2wJ8J08jwPliADl98KBbCMRwZ4oqrldiav1Ksic2YxbeTJFvetfP9zMZ7QW
	gJqvQ==
X-ME-Sender: <xms:BuYyZzNJ6e-Pei75mY8KB20kfneTD5kcG_2mAV4aZkA79HtAZCDp6g>
    <xme:BuYyZ98YErsVxwa3a72MkfyxxMS1pkAluWz3nFKPdATDtHMm1Hu5va2MaoNaUo571
    GTlO2jTqSsJGdqWyjw>
X-ME-Received: <xmr:BuYyZyRJATBvWu4RLHcCCFcHe88scJl5RVdSP9NKMZ0Y-rfcoQRwK5FqUKCQWArBSIozzfmj4rH4tSk4G0r2C5hiBpuWQRQ1geCdEBbWxx-09jR5AA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnihgtrdhnvg
    htqeenucggtffrrghtthgvrhhnpedtjeeuieeiheeiueffuddvffelheekleegkedukeef
    fffhudffudegvdetiefhteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehnihgtohesfhhluhignhhitgdrnhgvthdpnhgspghrtghpthhtohep
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprggsrghilhhonhessggrhihlih
    gsrhgvrdgtohhmpdhrtghpthhtohepnhhpihhtrhgvsegsrgihlhhisghrvgdrtghomhdp
    rhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnh
    hivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhmvgguihgrthgvkheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtth
    hopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BuYyZ3voVYKdV8Zv----873fx8QXorOIRyvKjdFUXhw2fkhPQm0eZg>
    <xmx:BuYyZ7dCGuVnJNBEZaa0MQpES1UQGhbRIjSomy4QDWuqdf-qMuSdyA>
    <xmx:BuYyZz1uudd1BvaQqt-0MXAIBmAzjXKWlN_Uj_ISm99SsE7ii3xdqw>
    <xmx:BuYyZ39P2GvwXnQWGCWL5ogXoN2w4zxNsFxB-qqhmwFcfza7rFNVAw>
    <xmx:B-YyZ_4dclgNqVYDVRD7bGaXcrK1GzJwkd0hoDCIlOyDIW5fqwNBhSf1>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 00:22:14 -0500 (EST)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 17908ECB800;
	Tue, 12 Nov 2024 00:22:14 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Nicolas Pitre <npitre@baylibre.com>,
	Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH 3/5] thermal: aggregation support
Date: Tue, 12 Nov 2024 00:19:40 -0500
Message-ID: <20241112052211.3087348-4-nico@fluxnic.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112052211.3087348-1-nico@fluxnic.net>
References: <20241112052211.3087348-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

This provides support for the creation of virtual thermal zone devices
that serve as aggregation point for other devices. Individual primary
thermal devices remain accessible in sysfs but all cooling device bindings
are moved over to the thermal aggregator whose temperature is the weighted
average of its primary devices. Trip points are inherited from the
aggregator but only the aggregator will bind to cooling devices.

Although cooling devices are bound to the aggregator, critical trip
points remain individually accessible, and more importantly triggerable
for each primary device.

Full visibility of primary devices is preserved via the sysfs interface.
Some sysfs symbolic links are created to represent the hierarchical
relationship between the aggregator and its primary devices.

When this is enabled, the aggregation is applied to all entries found in
the device tree's "thermal-sensors" list when it contains more than one
entry. For example, let's consider:

```
        thermal_zones: thermal-zones {
                cpu0-thermal {
                        thermal-sensors = <&sensor_mcu 0>;
                };

                cpu1-thermal {
                        thermal-sensors = <&sensor_mcu 1>;
                };
        };
```

The above won't provide any aggregation. However:

```
        thermal_zones: thermal-zones {
                cluster0-thermal {
                        thermal-sensors = <&sensor_mcu 0>,
                                          <&sensor_mcu 1>;
                        coefficients = <6 4>;
                };
        };
```

The above will create the "cluster0-thermal" aggregator that combines
the "sensor_mcu(0)" and "sensor_mcu(1)" primary zones whose thermal
measurement contributions are 60% and 40% respectively.

In sysfs we have:
```
$ cd /sys/class/thermal
$ ls -l thermal_zone*/aggregator
lrwxrwxrwx 1 root root ... thermal_zone5/aggregator -> ../thermal_zone4
lrwxrwxrwx 1 root root ... thermal_zone6/aggregator -> ../thermal_zone4
$ ls ls -l thermal_zone*/primary_zone*
lrwxrwxrwx 1 root root ... thermal_zone4/primary_zone_0 -> ../thermal_zone5
lrwxrwxrwx 1 root root ... thermal_zone4/primary_zone_1 -> ../thermal_zone6
$ cat thermal_zone4/type
cluster0-thermal
$ cat thermal_zone*/primary_zone*/type
sensor_mcu(0)
sensor_mcu(1)
```

Future work may allow the addition and removal of primary thermal zones
to an aggregadirectly tor within sysfs for added flexibility.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/thermal/Kconfig        |  15 ++
 drivers/thermal/thermal_core.c | 416 +++++++++++++++++++++++++++++++++
 drivers/thermal/thermal_core.h |  14 ++
 drivers/thermal/thermal_of.c   |  23 +-
 4 files changed, 467 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 61e7ae524b..111f07b52a 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -220,6 +220,21 @@ config DEVFREQ_THERMAL
 
 	  If you want this support, you should say Y here.
 
+config THERMAL_AGGREGATION
+	bool "Thermal zone aggregation support"
+	depends on THERMAL_OF
+	help
+	  This provides support for the creation of virtual thermal zone
+	  devices that serve as aggregation point for other devices.
+	  Individual primary thermal devices remain accessible in sysfs
+	  but all cooling device bindings are moved over to the thermal
+	  aggregator whose temperature is the weighted average of its
+	  primary devices.
+
+	  When this is enabled, the aggregation is applied to all entries
+	  found in the device tree's "thermal-sensors" list when it contains
+	  more than one entry.
+
 config THERMAL_EMULATION
 	bool "Thermal emulation mode support"
 	help
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 8f03985f97..73a1b30081 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -748,6 +748,13 @@ struct thermal_zone_device *thermal_zone_get_by_id(int id)
  *				     binding, and unbinding.
  */
 
+#ifdef CONFIG_THERMAL_AGGREGATION
+static void thermal_remove_tz_from_aggregator(struct thermal_zone_device *tz);
+#else
+static inline void thermal_remove_tz_from_aggregator(struct thermal_zone_device *tz)
+{}
+#endif /* CONFIG_THERMAL_AGGREGATION */
+
 /**
  * thermal_bind_cdev_to_trip - bind a cooling device to a thermal zone
  * @tz:		pointer to struct thermal_zone_device
@@ -1577,6 +1584,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	thermal_debug_tz_remove(tz);
 
+	thermal_remove_tz_from_aggregator(tz);
+
 	mutex_lock(&thermal_list_lock);
 	list_for_each_entry(pos, &thermal_tz_list, node)
 		if (pos == tz)
@@ -1654,6 +1663,413 @@ struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_name);
 
+#ifdef CONFIG_THERMAL_AGGREGATION
+
+static LIST_HEAD(thermal_aggregator_list);
+
+struct thermal_zone_aggregator {
+	struct thermal_zone_device *tz;
+	struct list_head primary_tz_list;
+	struct mutex lock;
+	struct ida ida;
+	struct list_head node;
+};
+
+static bool is_aggregated(struct thermal_zone_device *tz)
+{
+	return tz->aggregator != NULL;
+}
+
+/*
+ * Get weighted average temperature for all aggregated zones.
+ *
+ * A "max temp" variant could also be provided but the end result on the
+ * cooling device would be the same as if no aggregation was done in the
+ * first place.
+ */
+static int thermal_aggr_get_average_temp(struct thermal_zone_device *aggr_tz,
+				     int *aggr_temp)
+{
+	struct thermal_zone_aggregator *aggr = aggr_tz->devdata;
+	struct thermal_zone_device *tz;
+	int temp, weight;
+	s64 temp_sum = 0;
+	u32 weight_sum = 0;
+	int ret = -ENODATA;
+
+	mutex_lock(&aggr->lock);
+	list_for_each_entry(tz, &aggr->primary_tz_list, aggregated_node) {
+		mutex_lock(&tz->lock);
+		if (tz->suspended || tz->mode != THERMAL_DEVICE_ENABLED) {
+			mutex_unlock(&tz->lock);
+			continue;
+		}
+		ret = __thermal_zone_get_temp(tz, &temp);
+		if (ret) {
+			mutex_unlock(&tz->lock);
+			break;
+		}
+		if (temp <= THERMAL_TEMP_INVALID) {
+			/*
+			 * Invalid temp values are ignored, unless all
+			 * primary zones are invalid in which case it is
+			 * passed up to accommodate the special case in
+			 * __thermal_zone_device_update().
+			 */
+			*aggr_temp = temp;
+		} else {
+			weight = tz->tzp->slope;
+			temp_sum += (s64)temp * weight;
+			weight_sum += weight;
+		}
+		mutex_unlock(&tz->lock);
+	}
+	mutex_unlock(&aggr->lock);
+
+	if (weight_sum)
+		*aggr_temp = div_s64(temp_sum, weight_sum);
+
+	return ret;
+}
+
+static int thermal_aggr_set_trips(struct thermal_zone_device *aggr_tz,
+				  int low, int high)
+{
+	struct thermal_zone_aggregator *aggr = aggr_tz->devdata;
+	struct thermal_zone_device *tz;
+
+	mutex_lock(&aggr->lock);
+	list_for_each_entry(tz, &aggr->primary_tz_list, aggregated_node) {
+		mutex_lock(&tz->lock);
+		if (!tz->suspended && tz->mode == THERMAL_DEVICE_ENABLED)
+			thermal_zone_set_trips(tz, low, high);
+		mutex_unlock(&tz->lock);
+	}
+	mutex_unlock(&aggr->lock);
+
+	return 0;
+}
+
+static int thermal_aggr_change_mode(struct thermal_zone_device *aggr_tz,
+				    enum thermal_device_mode mode)
+{
+	struct thermal_zone_aggregator *aggr = aggr_tz->devdata;
+	struct thermal_zone_device *tz;
+	int ret, err = 0;
+
+	mutex_lock(&aggr->lock);
+	list_for_each_entry(tz, &aggr->primary_tz_list, aggregated_node) {
+		ret = thermal_zone_device_set_mode(tz, mode);
+		if (ret)
+			err = ret;
+		/* cycle through all tz's even if there are errors */
+	}
+	mutex_unlock(&aggr->lock);
+
+	return err;
+}
+
+static const struct thermal_zone_device_ops thermal_aggr_tz_ops = {
+	.get_temp	= thermal_aggr_get_average_temp,
+	.set_trips	= thermal_aggr_set_trips,
+	.change_mode	= thermal_aggr_change_mode,
+};
+
+/**
+ * create_thermal_aggregator - create a tz to be used as an aggregator
+ *
+ * @ref_tz: the tz from which parameters such as trip values are copied
+ * @name: name to identify this aggregator
+ *
+ * This creates a virtual thermal zone to be used as an aggregator for
+ * other zones called "primary" zones. Those primary zones must be added to
+ * the created aggregator with add_tz_to_aggregator().
+ *
+ * Return: a pointer to the created struct thermal_zone_device or an ERR_PTR
+ * value in case of errors.
+ */
+static struct thermal_zone_device *
+create_thermal_aggregator(struct thermal_zone_device *ref_tz, const char *name)
+{
+	struct thermal_zone_aggregator *aggr;
+	struct thermal_zone_device *aggr_tz;
+	struct thermal_trip *trips;
+	int ntrips = ref_tz->num_trips;
+	int ret;
+
+	trips = kcalloc(ntrips, sizeof(*trips),  GFP_KERNEL);
+	if (!trips)
+		return ERR_PTR(-ENOMEM);
+	for (int i = 0; i < ntrips; i++)
+		trips[i] = ref_tz->trips[i].trip;
+
+	aggr = kzalloc(sizeof(*aggr), GFP_KERNEL);
+	if (!aggr) {
+		ret = -ENOMEM;
+		goto err_free_trips;
+	}
+	mutex_init(&aggr->lock);
+	INIT_LIST_HEAD(&aggr->primary_tz_list);
+	ida_init(&aggr->ida);
+
+	aggr_tz = thermal_zone_device_register_with_trips(name, trips, ntrips,
+							  aggr,
+							  &thermal_aggr_tz_ops,
+							  ref_tz->tzp, 0, 0);
+	if (IS_ERR(aggr_tz)) {
+		ret = PTR_ERR(aggr_tz);
+		pr_err("Failed to register thermal aggregator zone: %d\n", ret);
+		goto err_free_aggr;
+	}
+	aggr_tz->polling_delay_jiffies = ref_tz->polling_delay_jiffies;
+	aggr_tz->passive_delay_jiffies = ref_tz->passive_delay_jiffies;
+	aggr_tz->ops.should_bind = ref_tz->ops.should_bind;
+	aggr->tz = aggr_tz;
+	kfree(trips);
+
+	ret = thermal_zone_device_enable(aggr_tz);
+	if (ret) {
+		pr_err("Failed to enable thermal aggregator zone: %d\n", ret);
+		goto err_unregister_tz;
+	}
+
+	mutex_lock(&thermal_list_lock);
+	list_add_tail(&aggr->node, &thermal_aggregator_list);
+	mutex_unlock(&thermal_list_lock);
+
+	return aggr_tz;
+
+err_unregister_tz:
+	thermal_zone_device_unregister(aggr_tz);
+err_free_aggr:
+	ida_destroy(&aggr->ida);
+	kfree(aggr);
+err_free_trips:
+	kfree(trips);
+	return ERR_PTR(ret);
+}
+
+/**
+ * add_tz_to_aggregator() - add a primary zone to an aggregator
+ *
+ * @aggr_tz: the aggregator tz to use, as returned by create_thermal_aggregator()
+ * @tz: a primary tz to be added
+ *
+ * This enrolls a primary tz with an aggregator tz. Thermal instances
+ * (bindings) from the primary tz are moved to the aggregator. It is assumed
+ * that all primary tz's added to a given aggregator have the same set of
+ * trip points. This can be called with an already enrolled tz in which case
+ * only new thermal instances from the primary, if any, will be moved over
+ * to the aggregator. Duplicate thermal instances are simply dropped.
+ *
+ * An "aggregator" symlink is created within the primary tz's sysfs directory
+ * to the aggregator tz directory. And a list of "primary_zone_<n>" symlinks
+ * in the aggregator's directory point back to all primary tz's it owns.
+ */
+static void add_tz_to_aggregator(struct thermal_zone_device *aggr_tz,
+				 struct thermal_zone_device *tz)
+{
+	struct thermal_zone_aggregator *aggr = aggr_tz->devdata;
+	struct thermal_instance *ti, *next;
+	int ret;
+
+	mutex_lock(&aggr->lock);
+	mutex_lock(&aggr_tz->lock);
+	mutex_lock(&tz->lock);
+
+	/* duplicate thermal instances onto the aggregator */
+	list_for_each_entry(ti, &tz->thermal_instances, tz_node) {
+		int i = thermal_zone_trip_id(tz, ti->trip);
+		struct thermal_trip *aggr_trip = &aggr_tz->trips[i].trip;
+		struct thermal_cooling_device *cdev = ti->cdev;
+		struct cooling_spec c = {
+			.upper = ti->upper_no_limit ?  THERMAL_NO_LIMIT : ti->upper,
+			.lower = ti->lower,
+			.weight = ti->weight,
+		};
+		ret = thermal_bind_cdev_to_trip(aggr_tz, aggr_trip, cdev, &c);
+		if (ret == -EEXIST)
+			ret = 0;
+		if (ret) {
+			print_bind_err_msg(aggr_tz, aggr_trip, cdev, ret);
+			goto out;
+		}
+	}
+
+	/* remove thermal instances from the primary tz */
+	list_for_each_entry_safe(ti, next, &tz->thermal_instances, tz_node) {
+		thermal_unbind_cdev_from_trip(tz, ti->trip, ti->cdev);
+	}
+
+	if (!tz->aggregator) {
+		list_add_tail(&tz->aggregated_node, &aggr->primary_tz_list);
+		tz->aggregator = aggr_tz;
+
+		/* add a link from the primary tz to its aggregator */
+		ret = sysfs_create_link(&tz->device.kobj,
+					&aggr_tz->device.kobj,
+					"aggregator");
+		if (ret)
+			dev_err(&tz->device, "linking to aggregator failed: %d\n", ret);
+
+		/* add a link from the aggregator to this primary tz */
+		tz->aggregated_id = ret = ida_alloc(&aggr->ida, GFP_KERNEL);
+		if (ret >= 0) {
+			char name[sizeof("primary_zone_000")];
+
+			snprintf(name, sizeof(name), "primary_zone_%d", ret);
+			ret = sysfs_create_link(&aggr_tz->device.kobj,
+						&tz->device.kobj,
+						name);
+			if (ret) {
+				ida_free(&aggr->ida, tz->aggregated_id);
+				tz->aggregated_id = -1;
+			}
+		}
+		if (ret)
+			dev_err(&aggr_tz->device, "linking to primary failed: %d\n", ret);
+	}
+
+out:
+	mutex_unlock(&tz->lock);
+	mutex_unlock(&aggr_tz->lock);
+	mutex_unlock(&aggr->lock);
+}
+
+/**
+ * free_thermal_aggregator_unlock - unregister and free an aggregator tz
+ *
+ * @aggr_tz: the aggregator to free, as returned by create_thermal_aggregator()
+ *
+ * This unregisters the tz used as an aggregator and frees its associated
+ * memory. This is called by thermal_remove_tz_from_aggregator() when the
+ * last primary tz is removed from the aggregator, or if the aggregator was
+ * created and is no longer needed before any primary tz's have been added
+ * to it.
+ *
+ * Note: To avoid race issues, this is expected to be called with
+ * thermal_list_lock held, but it will be released before returning.
+ */
+static void free_thermal_aggregator_unlock(struct thermal_zone_device *aggr_tz)
+{
+	struct thermal_zone_aggregator *aggr = aggr_tz->devdata;
+
+	lockdep_assert_held(&thermal_list_lock);
+	BUG_ON(!list_empty(&aggr->primary_tz_list));
+
+	list_del(&aggr->node);
+	mutex_unlock(&thermal_list_lock);
+
+	thermal_zone_device_disable(aggr_tz);
+	thermal_zone_device_unregister(aggr_tz);
+	ida_destroy(&aggr->ida);
+	kfree(aggr);
+}
+
+/**
+ * thermal_remove_tz_from_aggregator - remove a primary tz from an aggregator
+ *
+ * @tz: the thermal zone to remove from its aggregator
+ *
+ * This retires a primary tz from its aggregator. If not aggregated, this
+ * is a no-op. Thermal instance bindings are re-established with the primary
+ * tz.
+ *
+ * If given tz was the last one owned by the aggregator, then the aggregator
+ * is destroyed.
+ */
+static void thermal_remove_tz_from_aggregator(struct thermal_zone_device *tz)
+{
+	struct thermal_zone_device *aggr_tz = tz->aggregator;
+	struct thermal_zone_aggregator *aggr = aggr_tz->devdata;
+	struct thermal_cooling_device *cdev;
+
+	if (!is_aggregated(tz))
+		return;
+
+	mutex_lock(&thermal_list_lock);
+
+	/* Bind cooling devices back to this zone */
+	tz->ops.should_bind = aggr_tz->ops.should_bind;
+	list_for_each_entry(cdev, &thermal_cdev_list, node)
+		thermal_zone_cdev_bind(tz, cdev);
+
+	mutex_lock(&aggr->lock);
+	list_del(&tz->aggregated_node);
+	tz->aggregator = NULL;
+	sysfs_remove_link(&tz->device.kobj, "aggregator");
+	if (tz->aggregated_id >= 0) {
+		char name[sizeof("primary_zone_000")];
+
+		snprintf(name, sizeof(name), "primary_zone_%d", tz->aggregated_id);
+		sysfs_remove_link(&aggr_tz->device.kobj, name);
+		ida_free(&aggr->ida, tz->aggregated_id);
+	}
+	mutex_unlock(&aggr->lock);
+
+	if (list_empty(&aggr->primary_tz_list)) {
+		/* no more tz tied to this aggregator */
+		free_thermal_aggregator_unlock(aggr_tz);
+	} else {
+		mutex_unlock(&thermal_list_lock);
+	}
+}
+
+/**
+ * thermal_zone_device_aggregate - aggregate provided thermal zone device
+ *
+ * @tz: the thermal zone to aggregate
+ * @name: the aggregator's name to use
+ *
+ * This adds the provided thermal zone device to the thermal aggregator
+ * identified by @name. If no such aggregator exists it is created.
+ *
+ * In case of any error, the provided thermal zone will remain freestanding
+ * on its own and an error message will be logged. There is no point returning
+ * an error as it would be unwise for the caller to revert registration of
+ * this tz anyway (a suboptimal thermal configuration is better than no
+ * configuration).
+ */
+void thermal_zone_device_aggregate(struct thermal_zone_device *tz,
+				   const char *name)
+{
+	struct thermal_zone_aggregator *aggr;
+	struct thermal_zone_device *aggr_tz;
+
+	/* look for an existing aggregator */
+	mutex_lock(&thermal_list_lock);
+	list_for_each_entry(aggr, &thermal_aggregator_list, node) {
+		aggr_tz = aggr->tz;
+		if (strcmp(aggr_tz->type, name) != 0)
+			continue;
+		if (aggr_tz->ops.should_bind != tz->ops.should_bind) {
+			pr_err("%s: same name but ops.should_bind differs\n",
+			       __func__);
+			goto out;
+		}
+		goto add;
+	}
+	mutex_unlock(&thermal_list_lock);
+
+	/* no aggregator with specified name exists, create one */
+	aggr_tz = create_thermal_aggregator(tz, name);
+	if (IS_ERR(aggr_tz)) {
+		pr_err("unable to create thermal aggregator (%ld)\n",
+		       PTR_ERR(aggr_tz));
+		return;
+	}
+
+	mutex_lock(&thermal_list_lock);
+add:
+	add_tz_to_aggregator(aggr_tz, tz);
+	if (is_aggregated(tz))
+		tz->ops.should_bind = NULL;
+out:
+	mutex_unlock(&thermal_list_lock);
+}
+
+#endif /* CONFIG_THERMAL_AGGREGATION */
+
 static void thermal_zone_device_resume(struct work_struct *work)
 {
 	struct thermal_zone_device *tz;
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index a64d39b1c8..ff5aa20e82 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -136,6 +136,11 @@ struct thermal_zone_device {
 	enum thermal_notify_event notify_event;
 	bool suspended;
 	bool resuming;
+#ifdef CONFIG_THERMAL_AGGREGATION
+	struct thermal_zone_device *aggregator;
+	struct list_head aggregated_node;
+	int aggregated_id;
+#endif
 #ifdef CONFIG_THERMAL_DEBUGFS
 	struct thermal_debugfs *debugfs;
 #endif
@@ -287,4 +292,13 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 				    unsigned long new_state) {}
 #endif /* CONFIG_THERMAL_STATISTICS */
 
+#ifdef CONFIG_THERMAL_AGGREGATION
+void thermal_zone_device_aggregate(struct thermal_zone_device *tz,
+				   const char *aggr_name);
+#else
+static inline void
+thermal_zone_device_aggregate(struct thermal_zone_device *tz, const char *aggr_name)
+{}
+#endif /* CONFIG_THERMAL_AGGREGATION */
+
 #endif /* __THERMAL_CORE_H__ */
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index b8ddd41247..1761a60db5 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -451,7 +451,25 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 		if (!of_ops.critical && !strcasecmp(action, "reboot"))
 			of_ops.critical = thermal_zone_device_critical_reboot;
 
-	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
+	/*
+	 * The device tree node name is used with single-sensor entries.
+	 * When multiple-sensor entries are aggregated, the node name is used
+	 * for the aggregator and primary sensors use their compatible alias
+	 * name with the id value.
+	 */
+	bool multi = (index != -1);
+	char namebuf[THERMAL_NAME_LENGTH];
+	const char *tz_name = namebuf;
+
+	if (!multi)
+		tz_name = np->name;
+	else if (of_alias_from_compatible(sensor, namebuf, sizeof(namebuf)) == 0)
+		snprintf(namebuf + strlen(namebuf), sizeof(namebuf) - strlen(namebuf),
+			 "(%d)", id);
+	else
+		snprintf(namebuf, sizeof(namebuf), "%s(%d)", sensor->name, id);
+
+	tz = thermal_zone_device_register_with_trips(tz_name, trips, ntrips,
 						     data, &of_ops, &tzp,
 						     pdelay, delay);
 	if (IS_ERR(tz)) {
@@ -460,6 +478,9 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 		goto out_kfree_trips;
 	}
 
+	if (multi)
+		thermal_zone_device_aggregate(tz, np->name);
+
 	of_node_put(np);
 	kfree(trips);
 
-- 
2.47.0



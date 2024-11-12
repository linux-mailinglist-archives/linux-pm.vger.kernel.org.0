Return-Path: <linux-pm+bounces-17372-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F9A9C4E1F
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 06:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0691F23A0B
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 05:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA9320A5CC;
	Tue, 12 Nov 2024 05:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="jYatm4tJ";
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ihlurd1z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ntcc2Tke"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13999204932;
	Tue, 12 Nov 2024 05:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731388938; cv=none; b=dpmkhgXl09gA+8v7HZRMpL4Zo3Kmpb/dGkcQds7W5p0HXzSrLSqIV2keL0fzyyUk5PsDyPrXT0Jk3vlLSieWcQNec8PTWKV9OzW0EShJGE41VJ0RHEBP5GyKHvdr9ggmfOg9ySGLXKWa8UnlnGujoom+L7ebL+dRQwVBSi40KL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731388938; c=relaxed/simple;
	bh=zni73RqvremBaxqTSqo+uI0FtebRS0qFn43PsYFOywA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkT8GT/RI8JN/ZOHFLdb2YX/Fl/afuoyVCIpyJFEOm63j4o4qo4xifwG3z/joRZAXm4Iy60WnBb5GStZdtN9mEOuQOPwaYyZlk5gpdGrkrSkUzagHgLUYRMNPTbjGJ7hfPndbsprw0nc/9ZreJbKdwMXDnHOs3JaXr1M3ZfdSHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=jYatm4tJ; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ihlurd1z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ntcc2Tke; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3CB5E1380171;
	Tue, 12 Nov 2024 00:22:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 12 Nov 2024 00:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=2016-12.pbsmtp; t=1731388935;
	 x=1731475335; bh=5bdj/n2LgxLKoSXpmbjX7w9HpSLYegxH5T6o6/+YLS4=; b=
	jYatm4tJFXRKm7NQ8XYg2KX0WHovLYH0dUK9B1MYh4UMuZc7QetfVrW1VMzX/c4L
	xK2+kCKgriOtR4B/LdRxzV46koiaEUk0oAudOcmLX+g1rhoTAwI2XsbUUEOmvR5V
	Ln8DpIn4c8FWmvyK5bmLxcak+WObR2zi1cFXKdxjDbs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1731388935; x=
	1731475335; bh=5bdj/n2LgxLKoSXpmbjX7w9HpSLYegxH5T6o6/+YLS4=; b=I
	hlurd1z1Sd2ci34BmfzTXcoQ/Is08G1unGuXoEmyREBNmgqiGPinELUWuqKsFpL4
	4B3dXnkhDdrdAyvepACJVP1hMPbw39nno52z7+3reN0IcqeyM4XJSnE5CUG9fCD7
	cFUlD8DkGk0CtDZmk8IkllwAPDFbCtjcaeIpnXzqm/x2U9bEt6Eh9OPwTSu6LG9M
	ISPiXpbn47r2momwV/TkJz+RC4bqyijlH9trQ7Y+iP7ZPITJ0uoEvai2+vCdzj6f
	14XZIqHbUJrfuOgkSvMtp3iYcTAsyN3GyaW3/C7PWX/7Sq+YTFrSlb8kjRQpcPnL
	FOVeGdkCN3KKC44lMpMcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731388935; x=1731475335; bh=5
	bdj/n2LgxLKoSXpmbjX7w9HpSLYegxH5T6o6/+YLS4=; b=ntcc2TkeDYUK6tgEf
	YYUrMidO7bng67ULq+kMCjMT7f5peMKz/HNy4QQF4jJlwYhz+kqi4jLin+M3n8jl
	47vfMBjOwl9uwXB8FDKHi4BreoLeyt9wkkgLlDUO+dkN18QeMpOloyFSAGKvn1KD
	KUT7tioNiMTN7nHE+GqG8FGFxSFz7fmbtsixyyC0MFoV5r77FA/wXkAMrXTuVEpC
	z63Wu1zl+e/DhMszVclkEIeswHXVXRiiUF8pWfSkrWMizulwFkP5nlWrretiMm7R
	oM4sOOc+aFkpQfGx5nD+5OrH/u5R4uJ9AuIIHIY+vJJ5PwtiSeq9FL1PNr/Pk3OO
	3RQ9w==
X-ME-Sender: <xms:BuYyZ0MPM7hJT8rNj_sCGzeDpz1acZR4IxBLyiLmqu-ekkJ9prxgDA>
    <xme:BuYyZ6_NLcFRoq8YxQ0OJAiKsQWys06YWKd9mJ-W3BESr-RYoILIEKQiuRd_3V8jI
    GZ5d874uotFODT3XJA>
X-ME-Received: <xmr:BuYyZ7QlAL54e_b-ZYZxPlNs2hBYAUdnsBIHuhUa08y9k41NYxcVFRpwqJe-Y3VTIxwpGORAIjoYlejq8TF1f9NnrsaDvyPI2S4ff0_M40w2d9Nemw>
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
X-ME-Proxy: <xmx:BuYyZ8sxwyYSMm_zme-jCVZKlaTVBvZSsoVExB7Q5vOb83ZELOr-aA>
    <xmx:BuYyZ8dZQA0xStF6_56cA4Kln8cFJ5mG6sL2h7KfGtRidJxMQt04fw>
    <xmx:BuYyZw2gaUuRXSlJbVNcO5dV95DJ9RLExFTSwyIGsB7nN35zgfyk9A>
    <xmx:BuYyZw9lXkaYUyuJDuqRCc5B89HxTgyQnrvGZUIkzfR9geq_Mo5FCQ>
    <xmx:B-YyZ05bBCseepkVvlkSdcdy8JCcGR24tWdyng2Y3gK1tYoVEZJlymID>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 00:22:14 -0500 (EST)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 32494ECB802;
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
Subject: [PATCH 4/5] thermal: automatic aggregation support
Date: Tue, 12 Nov 2024 00:19:41 -0500
Message-ID: <20241112052211.3087348-5-nico@fluxnic.net>
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

Automatically apply thermal aggregation of multiple related thermal zones
into a single one. Here "related" means such zones must have the same trip
points and cooling devices bound to them. This is an alternative to the
device tree's "thermal-sensors" list for testing purpose without actually
modifying the DTB.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/thermal/Kconfig        |  12 ++
 drivers/thermal/thermal_core.c | 227 +++++++++++++++++++++++++++++++++
 2 files changed, 239 insertions(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 111f07b52a..1b2f319838 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -235,6 +235,18 @@ config THERMAL_AGGREGATION
 	  found in the device tree's "thermal-sensors" list when it contains
 	  more than one entry.
 
+config THERMAL_AGGREGATION_AUTO
+	bool "Automatic Thermal Aggregation support"
+	depends on THERMAL_AGGREGATION
+	help
+	  Automatically apply thermal aggregation of multiple related thermal
+	  zones into a single one. Here "related" means such zones must have
+	  the same trip points and cooling devices bound to them. This is an
+	  alternative to the device tree's "thermal-sensors" list for testing
+	  purpose without actually modifying the DTB. It is highly recommended
+	  that the device tree method be used in preference to this for actual
+	  system deployment.
+
 config THERMAL_EMULATION
 	bool "Thermal emulation mode support"
 	help
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 73a1b30081..934d248aa9 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -755,6 +755,16 @@ static inline void thermal_remove_tz_from_aggregator(struct thermal_zone_device
 {}
 #endif /* CONFIG_THERMAL_AGGREGATION */
 
+#ifdef CONFIG_THERMAL_AGGREGATION_AUTO
+static void thermal_check_zone_for_aggregation(struct thermal_zone_device *target_tz);
+static void thermal_check_cdev_for_aggregation(struct thermal_cooling_device *new_cdev);
+#else
+static inline void thermal_check_zone_for_aggregation(struct thermal_zone_device *target_tz)
+{}
+static inline void thermal_check_cdev_for_aggregation(struct thermal_cooling_device *new_cdev)
+{}
+#endif /* CONFIG_THERMAL_AGGREGATION_AUTO */
+
 /**
  * thermal_bind_cdev_to_trip - bind a cooling device to a thermal zone
  * @tz:		pointer to struct thermal_zone_device
@@ -1073,6 +1083,8 @@ __thermal_cooling_device_register(struct device_node *np,
 
 	mutex_unlock(&thermal_list_lock);
 
+	thermal_check_cdev_for_aggregation(cdev);
+
 	return cdev;
 
 out_cooling_dev:
@@ -1515,6 +1527,8 @@ thermal_zone_device_register_with_trips(const char *type,
 	if (atomic_cmpxchg(&tz->need_update, 1, 0))
 		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
+	thermal_check_zone_for_aggregation(tz);
+
 	thermal_notify_tz_create(tz);
 
 	thermal_debug_tz_add(tz);
@@ -2068,6 +2082,219 @@ void thermal_zone_device_aggregate(struct thermal_zone_device *tz,
 	mutex_unlock(&thermal_list_lock);
 }
 
+#ifdef CONFIG_THERMAL_AGGREGATION_AUTO
+
+static bool is_aggregator(struct thermal_zone_device *tz)
+{
+	return !strcmp(tz->type, "aggregator");
+}
+
+/**
+ * thermal_trip_related - determine if two trips are equivalent
+ *
+ * @tt1, @tt2: thermal trip specs to compare
+ *
+ * Determine if given trips may be candidates for aggregation.
+ *
+ * Return: true if related for aggregation, false otherwise
+ */
+static bool thermal_trip_related(struct thermal_trip *tt1,
+				 struct thermal_trip *tt2)
+{
+	return tt1->temperature == tt2->temperature &&
+	       tt1->hysteresis == tt2->hysteresis &&
+	       tt1->type == tt2->type &&
+	       tt1->flags == tt2->flags;
+}
+
+static struct thermal_cooling_device *
+trip_to_cdev(struct thermal_zone_device *tz, int trip_idx)
+{
+	struct thermal_instance *ti;
+
+	list_for_each_entry(ti, &tz->thermal_instances, tz_node)
+		if (trip_to_trip_desc(ti->trip) == &tz->trips[trip_idx])
+			return ti->cdev;
+
+	return NULL;
+}
+
+/**
+ * thermal_zone_related - determine if two tz's are candidates for aggregation
+ *
+ * @tz1, @tz2: thermal zones to compare
+ *
+ * Return: true if related for aggregation, false otherwise
+ */
+static bool thermal_zone_related(struct thermal_zone_device *tz1,
+				 struct thermal_zone_device *tz2)
+{
+	/* a tz can't aggregate with itself */
+	if (tz1 == tz2)
+		return false;
+
+	/* no relation possible if ops.should_bind is unset */
+	if (!tz1->ops.should_bind || !tz2->ops.should_bind)
+		return false;
+
+	/* a tz always relates to its aggregator */
+	if (tz1->aggregator == tz2 || tz2->aggregator == tz1)
+		return true;
+
+	/* related tz's must have the same number of trip points */
+	if (tz1->num_trips != tz2->num_trips)
+		return false;
+
+	/* tz's with no cdev bindings are not (yet) considered */
+	if (list_empty(&tz1->thermal_instances) ||
+	    list_empty(&tz2->thermal_instances))
+		return false;
+
+	for (int i = 0; i < tz1->num_trips; i++) {
+		/* all trips must be related */
+		if (!thermal_trip_related(&tz1->trips[i].trip, &tz2->trips[i].trip))
+			return false;
+		/* cdevs for given trips must be the same */
+		if (trip_to_cdev(tz1, i) != trip_to_cdev(tz2, i))
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * find_related_tz - look for a tz aggregation candidate
+ *
+ * @target_tz: tz to compare against
+ *
+ * Return: candidate tz for aggregation, or NULL if none
+ */
+static struct thermal_zone_device *
+find_related_tz(struct thermal_zone_device *target_tz)
+{
+	struct thermal_zone_device *tz;
+
+	list_for_each_entry(tz, &thermal_tz_list, node) {
+		if (is_aggregated(tz))
+			continue;
+		if (is_aggregator(tz))
+			continue;
+		if (!thermal_zone_related(tz, target_tz))
+			continue;
+		return tz;
+	}
+
+	return NULL;
+}
+
+/**
+ * thermal_check_zone_for_aggregation - consider tz for aggregation
+ *
+ * @target_tz: tz to compare against
+ *
+ * Adds the provided tz to a compatible aggregator. If none found, look for
+ * the possibility to create a new aggregator if another compatible tz exists.
+ * This is called, notably, when a new tz is registered and potentially bound
+ * to existing cdevs.
+ */
+static void thermal_check_zone_for_aggregation(struct thermal_zone_device *target_tz)
+{
+	struct thermal_zone_aggregator *aggr;
+	struct thermal_zone_device *aggr_tz, *tz;
+
+	if (is_aggregator(target_tz))
+		return;
+
+	mutex_lock(&thermal_list_lock);
+	if (!thermal_zone_is_present(target_tz)) {
+		mutex_unlock(&thermal_list_lock);
+		return;
+	}
+
+	/* see if existing aggregators can appropriate this zone  */
+	list_for_each_entry(aggr, &thermal_aggregator_list, node) {
+		aggr_tz = aggr->tz;
+		if (!thermal_zone_related(aggr_tz, target_tz))
+			continue;
+		pr_debug("aggr %s(%d) and zone %s(%d) are related\n",
+			 aggr_tz->type, aggr_tz->id, target_tz->type, target_tz->id);
+		add_tz_to_aggregator(aggr_tz, target_tz);
+		mutex_unlock(&thermal_list_lock);
+		return;
+	}
+
+	/* see if non-aggregated zones can be aggregated */
+	tz = find_related_tz(target_tz);
+	if (!tz) {
+		mutex_unlock(&thermal_list_lock);
+		return;
+	}
+
+	pr_debug("zones %s(%d) and %s(%d) are related\n",
+		 tz->type, tz->id, target_tz->type, target_tz->id);
+
+	mutex_unlock(&thermal_list_lock);
+	aggr_tz = create_thermal_aggregator(target_tz, "aggregator");
+	if (IS_ERR(aggr_tz)) {
+		pr_err("unable to create thermal aggregator (%ld)\n",
+		       PTR_ERR(aggr_tz));
+		return;
+	}
+
+	mutex_lock(&thermal_list_lock);
+
+	/* the lock was momentarily dropped so need to revalide everything */
+	if (thermal_zone_is_present(target_tz)) {
+		tz = find_related_tz(target_tz);
+		if (tz) {
+			add_tz_to_aggregator(aggr_tz, target_tz);
+			add_tz_to_aggregator(aggr_tz, tz);
+			mutex_unlock(&thermal_list_lock);
+			return;
+		}
+	}
+
+	/* our match disappeared in the mean time */
+	free_thermal_aggregator_unlock(aggr_tz);
+}
+
+/**
+ * thermal_check_cdev_for_aggregation - consider aggregation after new cdev registration
+ *
+ * @new_cdev: cdev for which new thermal bindings might create aggregation candidates
+ *
+ * Consider tz's having thermal instance bindings with this new cdev as
+ * candidates for aggregation. This is called when a new cdev is registered
+ * and potentially bound to existing tz's.
+ */
+static void thermal_check_cdev_for_aggregation(struct thermal_cooling_device *new_cdev)
+{
+	struct thermal_zone_device *tz, *last_tz = NULL;
+	struct thermal_instance *ti;
+
+start_over:
+	mutex_lock(&thermal_list_lock);
+
+	list_for_each_entry(tz, &thermal_tz_list, node) {
+		if (tz == last_tz)
+			continue;
+		if (is_aggregator(tz))
+			continue;
+		list_for_each_entry(ti, &tz->thermal_instances, tz_node) {
+			if (ti->cdev == new_cdev) {
+				last_tz = tz;
+				mutex_unlock(&thermal_list_lock);
+				thermal_check_zone_for_aggregation(tz);
+				/* because the lock was dropped ... */
+				goto start_over;
+			}
+		}
+	}
+
+	mutex_unlock(&thermal_list_lock);
+}
+
+#endif /* CONFIG_THERMAL_AGGREGATION_AUTO */
 #endif /* CONFIG_THERMAL_AGGREGATION */
 
 static void thermal_zone_device_resume(struct work_struct *work)
-- 
2.47.0



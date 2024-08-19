Return-Path: <linux-pm+bounces-12469-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688D895707F
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 18:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E83D8B27757
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 16:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F800176FDB;
	Mon, 19 Aug 2024 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="fXkQH3GN"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0FD175D20;
	Mon, 19 Aug 2024 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085318; cv=none; b=QtT54bg81r/RsfgmimGZKiCs5VMxC5K8McO8ifNyTgBQOkpvAuODy8zhRWcAYEgKNdFIJpKoNgh00vCVMpPuHWv6bt5Jrw2s0S9SUr/0ohtvnGHeJuEWyOmnRfYZfBCz5S40TVz8q9jj0Au5gma38m/hOv7IQVmAVpbflHntB9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085318; c=relaxed/simple;
	bh=6M1RFv1QmucOEj5xSInzRLYUjqK4ZH5JJM5Lw0+nIGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLHJrzi1YQfz/AFI47wTCZneW0KWPweY5fh+PjURLtw/iJbixD+8o73o6gQvbxSZ2gNY1f85kZJNaV1CaP6jtRMPnSnimUpeQnMgVwRwZcxgl5tT+1iM3qgrdoTmI9EO+UsgYNCZcjn+9Qe0DTc9b4B+CyhREr5Vdk+Idjdl1pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=fXkQH3GN reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 257890579296d155; Mon, 19 Aug 2024 18:35:13 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 4ABE073B5D4;
	Mon, 19 Aug 2024 18:35:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724085313;
	bh=6M1RFv1QmucOEj5xSInzRLYUjqK4ZH5JJM5Lw0+nIGo=;
	h=From:Subject:Date;
	b=fXkQH3GNAG6I21/sW5nn+7RbjxrfgLcjiRF9O+kYGle4LDdG62WMQxiK6BTnBjUgn
	 F+L0Rf53K21KwsxglBy9yYjeGTZ0sAX1TNW4Kh4e87NUg2VJxIWZRiEtptWLRfDuQR
	 rWkD890P2irqzq8PHyI8Er0WaHAuMzkUazk6x+JQRg9ZO0lCFMwa9XB2wjmspr+8rN
	 ggMqZo5eSpb8Im2UfNuCxOud9NIJI1fJX1V8ujpbnS7KScjWxX9tvv3gSffLMdIyF5
	 iEVHjHRXeW4nwevf60zuKRdPjmgkudDDFCwSoBP853bDHn/bKOssBxZaTJTJrT0/0L
	 klobBvRfVOVmQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Subject:
 [PATCH v3 10/14] mlxsw: core_thermal:  Use the .should_bind() thermal zone
 callback
Date: Mon, 19 Aug 2024 18:24:37 +0200
Message-ID: <2216931.Icojqenx9y@rjwysocki.net>
In-Reply-To: <2205737.irdbgypaU6@rjwysocki.net>
References: <2205737.irdbgypaU6@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedguddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdr
 lhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepihguohhstghhsehnvhhiughirgdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=14 Fuz1=14 Fuz2=14

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the mlxsw core_thermal driver use the .should_bind() thermal zone
callback to provide the thermal core with the information on whether or
not to bind the given cooling device to the given trip point in the
given thermal zone.  If it returns 'true', the thermal core will bind
the cooling device to the trip and the corresponding unbinding will be
taken care of automatically by the core on the removal of the involved
thermal zone or cooling device.

It replaces the .bind() and .unbind() thermal zone callbacks (in 3
places) which assumed the same trip points ordering in the driver
and in the thermal core (that may not be true any more in the
future).  The .bind() callbacks used loops over trip point indices
to call thermal_zone_bind_cooling_device() for the same cdev (once
it had been verified) and all of the trip points, but they passed
different 'upper' and 'lower' values to it for each trip.

To retain the original functionality, the .should_bind() callbacks
need to use the same 'upper' and 'lower' values that would be used
by the corresponding .bind() callbacks when they are about to return
'true'.  To that end, the 'priv' field of each trip is set during the
thermal zone initialization to point to the corresponding 'state'
object containing the maximum and minimum cooling states of the
cooling device.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

v2 -> v3:
   * Add R-by from Ido
   * Reorder (previously [13/17])

v1 -> v2:
   * Fix typo in the changelog.
   * Do not move the mlxsw_thermal_ops definition.
   * Change ordering of local variables in mlxsw_thermal_module_should_bind().

This patch only depends on the [06/14] introducing the .should_bind()
thermal zone callback:

https://lore.kernel.org/linux-pm/9334403.CDJkKcVGEf@rjwysocki.net/

---
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |  115 +++++----------------
 1 file changed, 31 insertions(+), 84 deletions(-)

Index: linux-pm/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
===================================================================
--- linux-pm.orig/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ linux-pm/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -165,52 +165,22 @@ static int mlxsw_get_cooling_device_idx(
 	return -ENODEV;
 }
 
-static int mlxsw_thermal_bind(struct thermal_zone_device *tzdev,
-			      struct thermal_cooling_device *cdev)
+static bool mlxsw_thermal_should_bind(struct thermal_zone_device *tzdev,
+				      const struct thermal_trip *trip,
+				      struct thermal_cooling_device *cdev,
+				      struct cooling_spec *c)
 {
 	struct mlxsw_thermal *thermal = thermal_zone_device_priv(tzdev);
-	struct device *dev = thermal->bus_info->dev;
-	int i, err;
+	const struct mlxsw_cooling_states *state = trip->priv;
 
 	/* If the cooling device is one of ours bind it */
 	if (mlxsw_get_cooling_device_idx(thermal, cdev) < 0)
-		return 0;
-
-	for (i = 0; i < MLXSW_THERMAL_NUM_TRIPS; i++) {
-		const struct mlxsw_cooling_states *state = &thermal->cooling_states[i];
-
-		err = thermal_zone_bind_cooling_device(tzdev, i, cdev,
-						       state->max_state,
-						       state->min_state,
-						       THERMAL_WEIGHT_DEFAULT);
-		if (err < 0) {
-			dev_err(dev, "Failed to bind cooling device to trip %d\n", i);
-			return err;
-		}
-	}
-	return 0;
-}
-
-static int mlxsw_thermal_unbind(struct thermal_zone_device *tzdev,
-				struct thermal_cooling_device *cdev)
-{
-	struct mlxsw_thermal *thermal = thermal_zone_device_priv(tzdev);
-	struct device *dev = thermal->bus_info->dev;
-	int i;
-	int err;
+		return false;
 
-	/* If the cooling device is our one unbind it */
-	if (mlxsw_get_cooling_device_idx(thermal, cdev) < 0)
-		return 0;
+	c->upper = state->max_state;
+	c->lower = state->min_state;
 
-	for (i = 0; i < MLXSW_THERMAL_NUM_TRIPS; i++) {
-		err = thermal_zone_unbind_cooling_device(tzdev, i, cdev);
-		if (err < 0) {
-			dev_err(dev, "Failed to unbind cooling device\n");
-			return err;
-		}
-	}
-	return 0;
+	return true;
 }
 
 static int mlxsw_thermal_get_temp(struct thermal_zone_device *tzdev,
@@ -240,57 +210,27 @@ static struct thermal_zone_params mlxsw_
 };
 
 static struct thermal_zone_device_ops mlxsw_thermal_ops = {
-	.bind = mlxsw_thermal_bind,
-	.unbind = mlxsw_thermal_unbind,
+	.should_bind = mlxsw_thermal_should_bind,
 	.get_temp = mlxsw_thermal_get_temp,
 };
 
-static int mlxsw_thermal_module_bind(struct thermal_zone_device *tzdev,
-				     struct thermal_cooling_device *cdev)
+static bool mlxsw_thermal_module_should_bind(struct thermal_zone_device *tzdev,
+					     const struct thermal_trip *trip,
+					     struct thermal_cooling_device *cdev,
+					     struct cooling_spec *c)
 {
 	struct mlxsw_thermal_module *tz = thermal_zone_device_priv(tzdev);
+	const struct mlxsw_cooling_states *state = trip->priv;
 	struct mlxsw_thermal *thermal = tz->parent;
-	int i, j, err;
 
 	/* If the cooling device is one of ours bind it */
 	if (mlxsw_get_cooling_device_idx(thermal, cdev) < 0)
-		return 0;
-
-	for (i = 0; i < MLXSW_THERMAL_NUM_TRIPS; i++) {
-		const struct mlxsw_cooling_states *state = &tz->cooling_states[i];
+		return false;
 
-		err = thermal_zone_bind_cooling_device(tzdev, i, cdev,
-						       state->max_state,
-						       state->min_state,
-						       THERMAL_WEIGHT_DEFAULT);
-		if (err < 0)
-			goto err_thermal_zone_bind_cooling_device;
-	}
-	return 0;
-
-err_thermal_zone_bind_cooling_device:
-	for (j = i - 1; j >= 0; j--)
-		thermal_zone_unbind_cooling_device(tzdev, j, cdev);
-	return err;
-}
-
-static int mlxsw_thermal_module_unbind(struct thermal_zone_device *tzdev,
-				       struct thermal_cooling_device *cdev)
-{
-	struct mlxsw_thermal_module *tz = thermal_zone_device_priv(tzdev);
-	struct mlxsw_thermal *thermal = tz->parent;
-	int i;
-	int err;
+	c->upper = state->max_state;
+	c->lower = state->min_state;
 
-	/* If the cooling device is one of ours unbind it */
-	if (mlxsw_get_cooling_device_idx(thermal, cdev) < 0)
-		return 0;
-
-	for (i = 0; i < MLXSW_THERMAL_NUM_TRIPS; i++) {
-		err = thermal_zone_unbind_cooling_device(tzdev, i, cdev);
-		WARN_ON(err);
-	}
-	return err;
+	return true;
 }
 
 static int mlxsw_thermal_module_temp_get(struct thermal_zone_device *tzdev,
@@ -313,8 +253,7 @@ static int mlxsw_thermal_module_temp_get
 }
 
 static struct thermal_zone_device_ops mlxsw_thermal_module_ops = {
-	.bind		= mlxsw_thermal_module_bind,
-	.unbind		= mlxsw_thermal_module_unbind,
+	.should_bind	= mlxsw_thermal_module_should_bind,
 	.get_temp	= mlxsw_thermal_module_temp_get,
 };
 
@@ -342,8 +281,7 @@ static int mlxsw_thermal_gearbox_temp_ge
 }
 
 static struct thermal_zone_device_ops mlxsw_thermal_gearbox_ops = {
-	.bind		= mlxsw_thermal_module_bind,
-	.unbind		= mlxsw_thermal_module_unbind,
+	.should_bind	= mlxsw_thermal_module_should_bind,
 	.get_temp	= mlxsw_thermal_gearbox_temp_get,
 };
 
@@ -451,6 +389,7 @@ mlxsw_thermal_module_init(struct device
 			  struct mlxsw_thermal_area *area, u8 module)
 {
 	struct mlxsw_thermal_module *module_tz;
+	int i;
 
 	module_tz = &area->tz_module_arr[module];
 	/* Skip if parent is already set (case of port split). */
@@ -465,6 +404,8 @@ mlxsw_thermal_module_init(struct device
 	       sizeof(thermal->trips));
 	memcpy(module_tz->cooling_states, default_cooling_states,
 	       sizeof(thermal->cooling_states));
+	for (i = 0; i < MLXSW_THERMAL_NUM_TRIPS; i++)
+		module_tz->trips[i].priv = &module_tz->cooling_states[i];
 }
 
 static void mlxsw_thermal_module_fini(struct mlxsw_thermal_module *module_tz)
@@ -579,7 +520,7 @@ mlxsw_thermal_gearboxes_init(struct devi
 	struct mlxsw_thermal_module *gearbox_tz;
 	char mgpir_pl[MLXSW_REG_MGPIR_LEN];
 	u8 gbox_num;
-	int i;
+	int i, j;
 	int err;
 
 	mlxsw_reg_mgpir_pack(mgpir_pl, area->slot_index);
@@ -606,6 +547,9 @@ mlxsw_thermal_gearboxes_init(struct devi
 		       sizeof(thermal->trips));
 		memcpy(gearbox_tz->cooling_states, default_cooling_states,
 		       sizeof(thermal->cooling_states));
+		for (j = 0; j < MLXSW_THERMAL_NUM_TRIPS; j++)
+			gearbox_tz->trips[j].priv = &gearbox_tz->cooling_states[j];
+
 		gearbox_tz->module = i;
 		gearbox_tz->parent = thermal;
 		gearbox_tz->slot_index = area->slot_index;
@@ -722,6 +666,9 @@ int mlxsw_thermal_init(struct mlxsw_core
 	thermal->bus_info = bus_info;
 	memcpy(thermal->trips, default_thermal_trips, sizeof(thermal->trips));
 	memcpy(thermal->cooling_states, default_cooling_states, sizeof(thermal->cooling_states));
+	for (i = 0; i < MLXSW_THERMAL_NUM_TRIPS; i++)
+		thermal->trips[i].priv = &thermal->cooling_states[i];
+
 	thermal->line_cards[0].slot_index = 0;
 
 	err = mlxsw_reg_query(thermal->core, MLXSW_REG(mfcr), mfcr_pl);





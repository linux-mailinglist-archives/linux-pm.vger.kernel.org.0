Return-Path: <linux-pm+bounces-14279-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A84B97905A
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 13:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D2571C22A6A
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 11:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E31B1CF2B1;
	Sat, 14 Sep 2024 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="q7Z2q5zH"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C601DA5E;
	Sat, 14 Sep 2024 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726312444; cv=none; b=HHYWL9R7dGn32p1O/dmncNteHPJj7GIN+YjVHZg3X4yr0HiTPXoeVFPKHNRUowabsDF0+vwrQ4FYikF41IrkKmUSk/5ZjDZ2UmMCFHch4NtMBdK2aRRLQVaEYhI+xCEuLdfqx3Nw1O4SyDddnUoZc2boYIK66td/7XZj1sJkZ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726312444; c=relaxed/simple;
	bh=IlQgOKwKcriIkpiTmpqGXxTu1Frf5sbwkloQzYZPnSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+JTBXfMLay+hm6hNQxEcnToVfex0FL2xMLY3XH2EIGhZJNJMutKfd0cjddIvWxlEa9c3F/lyfhqJihvOE0n7D+X9wLDA7boNJ8xuf63EegdRTG8+sguH3R73ZgM5idrevl0jO1e9NPUnllo09JltDZVI/tWROfXz+/KG+UesDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=q7Z2q5zH reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id b6bb8940ca4bfd4e; Sat, 14 Sep 2024 13:14:00 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id CDD2C8532AE;
	Sat, 14 Sep 2024 13:13:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1726312440;
	bh=IlQgOKwKcriIkpiTmpqGXxTu1Frf5sbwkloQzYZPnSQ=;
	h=From:Subject:Date;
	b=q7Z2q5zH9AKEBmD4ZyzfRBukAT/LzrP4Abf+oEHTz4YlYTiwqEyfM+jV8wrmIEu57
	 aJF873KS7jEFHuOdpOzJ2nLXcK3gM9dAM0DsFsdQAtc5ykYMcThlEmeCpL2RHgVDYK
	 t4ZhiCFXfCyoNJqSHA2CY0/U+KFMBJIdBTVAQvEb8PfIFitqZokf9rREosM4UlJ/Tu
	 MIEgSy64DJ511xWBFTG3lWVDhflERGuUNt83A73/ZCTVSN5cx2pam5AdkciQRO7j5R
	 /jmaHeewqEzkerg7/UTdiPDrRFL8tfnXag7jNYnjCxQSeZ3QCiKlexwydyNFJUl+sS
	 vSS/krDZb6l/w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [RFC PATCH for 6.13 v1 01/20] thermal: core: Use the thermal zone guard in
 more cases
Date: Sat, 14 Sep 2024 12:25:53 +0200
Message-ID: <4613601.LvFx2qVVIh@rjwysocki.net>
In-Reply-To: <6100907.lOV4Wx5bFT@rjwysocki.net>
References: <6100907.lOV4Wx5bFT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudektddgfeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphht
 thhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=45 Fuz1=45 Fuz2=45

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are a few more cases in which the thermal zone guard introduced
previously can be used to help clarify the code, so do that.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

To be merged with https://lore.kernel.org/linux-pm/3241904.5fSG56mABF@rjwysocki.net/

---
 drivers/thermal/thermal_debugfs.c |   25 +++++++++++++++----------
 drivers/thermal/thermal_hwmon.c   |    6 +-----
 drivers/thermal/thermal_netlink.c |   21 ++++++---------------
 3 files changed, 22 insertions(+), 30 deletions(-)

Index: linux-pm/drivers/thermal/thermal_netlink.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_netlink.c
+++ linux-pm/drivers/thermal/thermal_netlink.c
@@ -460,7 +460,7 @@ static int thermal_genl_cmd_tz_get_trip(
 	if (!start_trip)
 		return -EMSGSIZE;
 
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
 
 	for_each_trip_desc(tz, td) {
 		const struct thermal_trip *trip = &td->trip;
@@ -470,19 +470,12 @@ static int thermal_genl_cmd_tz_get_trip(
 		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TYPE, trip->type) ||
 		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TEMP, trip->temperature) ||
 		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_HYST, trip->hysteresis))
-			goto out_cancel_nest;
+			return -EMSGSIZE;
 	}
 
-	mutex_unlock(&tz->lock);
-
 	nla_nest_end(msg, start_trip);
 
 	return 0;
-
-out_cancel_nest:
-	mutex_unlock(&tz->lock);
-
-	return -EMSGSIZE;
 }
 
 static int thermal_genl_cmd_tz_get_temp(struct param *p)
@@ -515,7 +508,7 @@ static int thermal_genl_cmd_tz_get_gov(s
 {
 	struct sk_buff *msg = p->msg;
 	struct thermal_zone_device *tz;
-	int id, ret = 0;
+	int id;
 
 	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
 		return -EINVAL;
@@ -526,16 +519,14 @@ static int thermal_genl_cmd_tz_get_gov(s
 	if (!tz)
 		return -EINVAL;
 
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
 
 	if (nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_ID, id) ||
 	    nla_put_string(msg, THERMAL_GENL_ATTR_TZ_GOV_NAME,
 			   tz->governor->name))
-		ret = -EMSGSIZE;
-
-	mutex_unlock(&tz->lock);
+		return -EMSGSIZE;
 
-	return ret;
+	return 0;
 }
 
 static int __thermal_genl_cmd_cdev_get(struct thermal_cooling_device *cdev,
Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -885,6 +885,19 @@ void thermal_debug_tz_add(struct thermal
 	tz->debugfs = thermal_dbg;
 }
 
+static struct thermal_debugfs *thermal_debug_tz_clear(struct thermal_zone_device *tz)
+{
+	struct thermal_debugfs *thermal_dbg;
+
+	guard(thermal_zone)(tz);
+
+	thermal_dbg = tz->debugfs;
+	if (thermal_dbg)
+		tz->debugfs = NULL;
+
+	return thermal_dbg;
+}
+
 void thermal_debug_tz_remove(struct thermal_zone_device *tz)
 {
 	struct thermal_debugfs *thermal_dbg;
@@ -892,17 +905,9 @@ void thermal_debug_tz_remove(struct ther
 	struct tz_debugfs *tz_dbg;
 	int *trips_crossed;
 
-	mutex_lock(&tz->lock);
-
-	thermal_dbg = tz->debugfs;
-	if (!thermal_dbg) {
-		mutex_unlock(&tz->lock);
+	thermal_dbg = thermal_debug_tz_clear(tz);
+	if (!thermal_dbg)
 		return;
-	}
-
-	tz->debugfs = NULL;
-
-	mutex_unlock(&tz->lock);
 
 	tz_dbg = &thermal_dbg->tz_dbg;
 
Index: linux-pm/drivers/thermal/thermal_hwmon.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_hwmon.c
+++ linux-pm/drivers/thermal/thermal_hwmon.c
@@ -78,19 +78,15 @@ temp_crit_show(struct device *dev, struc
 	int temperature;
 	int ret;
 
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
 
 	ret = tz->ops.get_crit_temp(tz, &temperature);
-
-	mutex_unlock(&tz->lock);
-
 	if (ret)
 		return ret;
 
 	return sprintf(buf, "%d\n", temperature);
 }
 
-
 static struct thermal_hwmon_device *
 thermal_hwmon_lookup_by_type(const struct thermal_zone_device *tz)
 {





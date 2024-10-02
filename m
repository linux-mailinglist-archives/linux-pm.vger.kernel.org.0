Return-Path: <linux-pm+bounces-15073-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C9C98DFFD
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 17:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA721F23A82
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 15:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BEA1D0E0D;
	Wed,  2 Oct 2024 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="enE5G7ac"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058161D0955;
	Wed,  2 Oct 2024 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884776; cv=none; b=p6h4Ur10uLMAV7/Fxbm+Ve6zB1Kd1ZSlr0YFvUR42eOnXhqc76UZOvY1lQc4jBaz4ILotOvqkeyPGZIjZHFTOSIihxbl9c3O5+ZphfnSkbuilh/UACA4biTznfvuCJnMmFet/9EKyeYWobAH+i5tJh1beKD5UZy0OYPze4sfMeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884776; c=relaxed/simple;
	bh=2AnRSR3YcszEmc4sqq0RyJX7r8qHwSzPNKtgv/cI62k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VmwULZak8lHZPvpDdRvHAPHx9BsTQbCRk+uEfr/HAv7/lOkRxqay2y1lJaxs497ypFEcRPAHD3Lpz9HtEXXDS/ejbXJsPcD35sEGDJcNkEoWcF6UerOWz32ztYY4ZWp/y/flxEtX9mdFZR8u8y8XlvdF/9feVBn3yhqvmbBhftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=enE5G7ac reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id c9f45710d69ff03b; Wed, 2 Oct 2024 16:59:31 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 46C037F587A;
	Wed,  2 Oct 2024 16:59:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1727881171;
	bh=2AnRSR3YcszEmc4sqq0RyJX7r8qHwSzPNKtgv/cI62k=;
	h=From:Subject:Date;
	b=enE5G7acY/7DlTqOpQjM1q6wjzA+xvG+h/mbPNTvxvtAUJx69YlD2WbdnaNqWsAAC
	 9aSU4qTGLU6EU5F09bZxls5ftYYwB7DJkzV9xTrtlZgU4v0S11GxyIp429Lw4d9Yx7
	 ZMNU0zRUAQQ0TTAtb8OaRL1Ch63p4zDsm51/d5vnQLusBA8MjmLH4BtiNybMkpSxbG
	 U9WlCqmarqcj5DhG1FMgozsi+mL7FeTRnhHDup2aOllHkohd0iALAMxwrgU+yhrU0w
	 uMs22fj4uRR15+CHdMMr4oahlLZYTPiqe5VbR4gqAWInOCPPaNFSTL1biU7y1CQOVy
	 +oQCxj8UidRBQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 1/2] thermal: core: Reference count the zone in
 thermal_zone_get_by_id()
Date: Wed, 02 Oct 2024 16:57:49 +0200
Message-ID: <6104329.lOV4Wx5bFT@rjwysocki.net>
In-Reply-To: <12541117.O9o76ZdvQC@rjwysocki.net>
References: <12541117.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthh
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are places in the thermal netlink code where nothing prevents
a thermal zone object from going away while being accessed after it
has been returned by thermal_zone_get_by_id().

To address this, make thermal_zone_get_by_id() get a reference on the
thermal zone device object to be returned with the help of get_device(),
under thermal_list_lock, and adjust all of its callers to this change.

Fixes: 1ce50e7d408e ("thermal: core: genetlink support for events/cmd/sampling")
Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c    |    1 +
 drivers/thermal/thermal_core.h    |    5 +++++
 drivers/thermal/thermal_netlink.c |   22 ++++++++++++++--------
 3 files changed, 20 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -728,6 +728,7 @@ struct thermal_zone_device *thermal_zone
 	mutex_lock(&thermal_list_lock);
 	list_for_each_entry(tz, &thermal_tz_list, node) {
 		if (tz->id == id) {
+			get_device(&tz->device);
 			match = tz;
 			break;
 		}
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -194,6 +194,11 @@ int for_each_thermal_governor(int (*cb)(
 
 struct thermal_zone_device *thermal_zone_get_by_id(int id);
 
+static inline void thermal_zone_put(struct thermal_zone_device *tz)
+{
+	put_device(&tz->device);
+}
+
 static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
 {
 	return cdev->ops->get_requested_power && cdev->ops->state2power &&
Index: linux-pm/drivers/thermal/thermal_netlink.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_netlink.c
+++ linux-pm/drivers/thermal/thermal_netlink.c
@@ -445,7 +445,7 @@ static int thermal_genl_cmd_tz_get_trip(
 	const struct thermal_trip_desc *td;
 	struct thermal_zone_device *tz;
 	struct nlattr *start_trip;
-	int id;
+	int id, ret = -EMSGSIZE;
 
 	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
 		return -EINVAL;
@@ -458,7 +458,7 @@ static int thermal_genl_cmd_tz_get_trip(
 
 	start_trip = nla_nest_start(msg, THERMAL_GENL_ATTR_TZ_TRIP);
 	if (!start_trip)
-		return -EMSGSIZE;
+		goto out_put;
 
 	mutex_lock(&tz->lock);
 
@@ -470,19 +470,20 @@ static int thermal_genl_cmd_tz_get_trip(
 		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TYPE, trip->type) ||
 		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TEMP, trip->temperature) ||
 		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_HYST, trip->hysteresis))
-			goto out_cancel_nest;
+			goto out_unlock;
 	}
 
-	mutex_unlock(&tz->lock);
-
 	nla_nest_end(msg, start_trip);
 
-	return 0;
+	ret = 0;
 
-out_cancel_nest:
+out_unlock:
 	mutex_unlock(&tz->lock);
 
-	return -EMSGSIZE;
+out_put:
+	thermal_zone_put(tz);
+
+	return ret;
 }
 
 static int thermal_genl_cmd_tz_get_temp(struct param *p)
@@ -501,6 +502,9 @@ static int thermal_genl_cmd_tz_get_temp(
 		return -EINVAL;
 
 	ret = thermal_zone_get_temp(tz, &temp);
+
+	thermal_zone_put(tz);
+
 	if (ret)
 		return ret;
 
@@ -535,6 +539,8 @@ static int thermal_genl_cmd_tz_get_gov(s
 
 	mutex_unlock(&tz->lock);
 
+	thermal_zone_put(tz);
+
 	return ret;
 }
 





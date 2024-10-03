Return-Path: <linux-pm+bounces-15103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC64198EF36
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 14:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FA5EB21A3F
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 12:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C8917BED2;
	Thu,  3 Oct 2024 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="a84yPbz6"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4EF170A15;
	Thu,  3 Oct 2024 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727958460; cv=none; b=gOXXqVzLn78AX+hWUb1HyERMBxcIKMbRH4u3sy0KwOByaNiGBg3NdNndYX6Os/DxKLFyUzR16Q1RoS62DTqCtQ5JM9s7LzmdDS//ISHcOeQqelL6pKbLidCFTtezIxw1aByC5L0S/5rxueXJ5NSzcwVPi2QOLApnVcxKHP0vDig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727958460; c=relaxed/simple;
	bh=3AUT0qbVBllCXwcYP01BrR5y7LgLCgAZ4smGcfEfsg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mu2w/6eIsiqHeS38TV0dO46qruf8mpmhtSYBLjir0syHFqGXK70UkAONE2ZBooFiz4yS+78LFkN+mdrlm/7Gea8Nu+SLrljQu02f9jCQb7HWpP3S0RLu19nRdAGQT1Ftgsl26jsz6pTR1HUlgHOlp97Iyfz1yx3GTJ3Q278lg1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=a84yPbz6 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 9019a01100d1cff5; Thu, 3 Oct 2024 14:27:34 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2AD436A94E9;
	Thu,  3 Oct 2024 14:27:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1727958454;
	bh=3AUT0qbVBllCXwcYP01BrR5y7LgLCgAZ4smGcfEfsg0=;
	h=From:Subject:Date;
	b=a84yPbz6F2K6sCuJrqD49sJann19dT0assj+gn1qK58wEC5H8ZrzFxKSBZMUGd38T
	 +BATK8zbmjqdjdcisct+LsrG+o3/6yIJ5llCX7Vxnso6mtsvppdCHEz4uMMKQmWkBK
	 F7+0TSF70k+84JM0JRPKIUH2g3U7Iz75oSSCinzgOyUSvGoQkv3RDyW32J1cxhsohg
	 prFSBLYedxTXgAzRQnq2Iy8Iv01eK236BV6XtIYvXFVWmihb96aaqceMBgodm4Dp8l
	 RaiNUk074JRBQ55gA/dHax2OJygMEko284U8EScH3nPKyHegZaHFVV/3zayBTtKAZy
	 +Ra7NvC5KGmvw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 1/2] thermal: core: Reference count the zone in
 thermal_zone_get_by_id()
Date: Thu, 03 Oct 2024 14:25:58 +0200
Message-ID: <6112242.lOV4Wx5bFT@rjwysocki.net>
In-Reply-To: <12549318.O9o76ZdvQC@rjwysocki.net>
References: <12549318.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddghedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthh
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are places in the thermal netlink code where nothing prevents
the thermal zone object from going away while being accessed after it
has been returned by thermal_zone_get_by_id().

To address this, make thermal_zone_get_by_id() get a reference on the
thermal zone device object to be returned with the help of get_device(),
under thermal_list_lock, and adjust all of its callers to this change
with the help of the cleanup.h infrastructure.

Fixes: 1ce50e7d408e ("thermal: core: genetlink support for events/cmd/sampling")
Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Use the cleanup.h infrastructure to reduce the amount of code changes.

---
 drivers/thermal/thermal_core.c    |    1 +
 drivers/thermal/thermal_core.h    |    3 +++
 drivers/thermal/thermal_netlink.c |    9 +++------
 3 files changed, 7 insertions(+), 6 deletions(-)

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
@@ -194,6 +194,9 @@ int for_each_thermal_governor(int (*cb)(
 
 struct thermal_zone_device *thermal_zone_get_by_id(int id);
 
+DEFINE_CLASS(thermal_zone_get_by_id, struct thermal_zone_device *,
+	     if (_T) put_device(&_T->device), thermal_zone_get_by_id(id), int id)
+
 static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
 {
 	return cdev->ops->get_requested_power && cdev->ops->state2power &&
Index: linux-pm/drivers/thermal/thermal_netlink.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_netlink.c
+++ linux-pm/drivers/thermal/thermal_netlink.c
@@ -443,7 +443,6 @@ static int thermal_genl_cmd_tz_get_trip(
 {
 	struct sk_buff *msg = p->msg;
 	const struct thermal_trip_desc *td;
-	struct thermal_zone_device *tz;
 	struct nlattr *start_trip;
 	int id;
 
@@ -452,7 +451,7 @@ static int thermal_genl_cmd_tz_get_trip(
 
 	id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
 
-	tz = thermal_zone_get_by_id(id);
+	CLASS(thermal_zone_get_by_id, tz)(id);
 	if (!tz)
 		return -EINVAL;
 
@@ -488,7 +487,6 @@ out_cancel_nest:
 static int thermal_genl_cmd_tz_get_temp(struct param *p)
 {
 	struct sk_buff *msg = p->msg;
-	struct thermal_zone_device *tz;
 	int temp, ret, id;
 
 	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
@@ -496,7 +494,7 @@ static int thermal_genl_cmd_tz_get_temp(
 
 	id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
 
-	tz = thermal_zone_get_by_id(id);
+	CLASS(thermal_zone_get_by_id, tz)(id);
 	if (!tz)
 		return -EINVAL;
 
@@ -514,7 +512,6 @@ static int thermal_genl_cmd_tz_get_temp(
 static int thermal_genl_cmd_tz_get_gov(struct param *p)
 {
 	struct sk_buff *msg = p->msg;
-	struct thermal_zone_device *tz;
 	int id, ret = 0;
 
 	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
@@ -522,7 +519,7 @@ static int thermal_genl_cmd_tz_get_gov(s
 
 	id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
 
-	tz = thermal_zone_get_by_id(id);
+	CLASS(thermal_zone_get_by_id, tz)(id);
 	if (!tz)
 		return -EINVAL;
 





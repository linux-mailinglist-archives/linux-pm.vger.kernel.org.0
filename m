Return-Path: <linux-pm+bounces-7843-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF84B8C4F7D
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D461C21258
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E586E140E50;
	Tue, 14 May 2024 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a16DJAT7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ItKPj1Qm"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7699B86634
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681946; cv=none; b=J26wThOzqY8yJBFMq/gFodpX7Dl5o14b2W+cGILnGckYyyEJ4oCAYMMUbnF6j73dPmjPHy0gGW9sYKH4S9y0vN4TgbXSdH5M/kJwdH3A4lNcBuk1wuwnB0mC7BkfiiOTGbqLvpQFLQ0AWVUvu2Dr1HXevX3oBTQ399QeMRBP3XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681946; c=relaxed/simple;
	bh=hldiB9AyqTER90NWxnd5+cFLkN4FNKEcqjZZLFS7HkI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=cupJNwhmivdE5aVo20Q+nFwEyUbw2fiGd9ana2utACrSZSziS+dxElVxNDJMYnshluEZ0zhjsYvVL7mm9U7P93RA6T3+JjzCOcpwg1TqzRsds2mZAAO/2eHVJLnZdwa/R4rMDkGWOHFtjpwM67kejUwkcDYg1fTH9lILGKtSnCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a16DJAT7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ItKPj1Qm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8uvhmtQUDnFD1NzxcCct4YZiYyx7U4U+0lG3iMT/uQY=;
	b=a16DJAT7p6gxa54GHwXIxfgTuP8JJMx3g4FFxNkrfFcnGAgSwPMEhnC/HGkXCJQ1Y/QPCj
	BPKDn1px2uqGGgI4pDnx3KiyeJXukV96aXDeIXwcdSzpGuFVHUAzahia8eGDLnswduZmLm
	KTz3WYAlbRo8luZ0nZvyzK93pflbY7k/9lI3aViR0umAA+HnOgJtJu6wabrMwETRs/MqSZ
	blzCpZPbkebNpD1xzNvTn2e3EqQpgIlLiE7pKaxNuF+3XfT/07VaPSWEpuJQN9MzyT+j1M
	Rf+LLPYdFNZ5GZsrBKbiyVLrxC0jf9+43obFujaGEERNio6oiyZ7CfbXf+7Wsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8uvhmtQUDnFD1NzxcCct4YZiYyx7U4U+0lG3iMT/uQY=;
	b=ItKPj1QmI3z7pI2GqNgb3JIdMHQh0l3j7WBkRyNqqwlR+ZqQoJcVEeT2WRN1fzJxRsjNFI
	mdLpCGWYPy79bODw==
From: "thermal-bot for Rafael J. Wysocki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject:
 [thermal: thermal/fixes] thermal: gov_step_wise: Simplify get_target_state()
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
 daniel.lezcano@linaro.org, amitk@kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193728.10875.16091886234901327225.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     f1164d333cc3c063cfdf7d03ddbca4f93a5a5c41
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//f1164d333cc3c063cfdf7d03ddbca4f93a5a5c41
Author:        Rafael J. Wysocki <rafael.j.wysocki@intel.com>
AuthorDate:    Wed, 03 Apr 2024 20:11:10 +02:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Mon, 08 Apr 2024 15:57:50 +02:00

thermal: gov_step_wise: Simplify get_target_state()

The step-wise governor's get_target_state() function contains redundant
braces, redundant parens and a redundant next_target local variable, so
get rid of all that stuff.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_step_wise.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 5436aa5..aad98e0 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -32,7 +32,6 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 {
 	struct thermal_cooling_device *cdev = instance->cdev;
 	unsigned long cur_state;
-	unsigned long next_target;
 
 	/*
 	 * We keep this instance the way it is by default.
@@ -40,32 +39,26 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 	 * cdev in use to determine the next_target.
 	 */
 	cdev->ops->get_cur_state(cdev, &cur_state);
-	next_target = instance->target;
 	dev_dbg(&cdev->device, "cur_state=%ld\n", cur_state);
 
 	if (!instance->initialized) {
-		if (throttle) {
-			next_target = clamp((cur_state + 1), instance->lower, instance->upper);
-		} else {
-			next_target = THERMAL_NO_TARGET;
-		}
+		if (throttle)
+			return clamp(cur_state + 1, instance->lower, instance->upper);
 
-		return next_target;
+		return THERMAL_NO_TARGET;
 	}
 
 	if (throttle) {
 		if (trend == THERMAL_TREND_RAISING)
-			next_target = clamp((cur_state + 1), instance->lower, instance->upper);
-	} else {
-		if (trend == THERMAL_TREND_DROPPING) {
-			if (cur_state <= instance->lower)
-				next_target = THERMAL_NO_TARGET;
-			else
-				next_target = clamp((cur_state - 1), instance->lower, instance->upper);
-		}
+			return clamp(cur_state + 1, instance->lower, instance->upper);
+	} else if (trend == THERMAL_TREND_DROPPING) {
+		if (cur_state <= instance->lower)
+			return THERMAL_NO_TARGET;
+
+		return clamp(cur_state - 1, instance->lower, instance->upper);
 	}
 
-	return next_target;
+	return instance->target;
 }
 
 static void thermal_zone_trip_update(struct thermal_zone_device *tz,


Return-Path: <linux-pm+bounces-33025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117D3B340D2
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 15:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7CD17AEC6D
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 13:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3152777E8;
	Mon, 25 Aug 2025 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtNxSrWf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA40F2765CC;
	Mon, 25 Aug 2025 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128739; cv=none; b=AxOQZWFdPRZ5NIVPBmhmpBW32eVM9zlT6OCQsdWXvru/ucnXD1sFn6I9sdVP6Q7DVq9FEqNqtExz3mnQ5Hmmkf2hGu2oY8LmR6yn+zbaVS+VgG7pJHPHrjMKB0+tUoNT4bntssjlEL+d251XjzCnZOnuVxqJp06JrK5l8/tcdbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128739; c=relaxed/simple;
	bh=XaTIaj6qHhD1hUA7V34cPlXuSaGIqHi/61efSmJGlLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttpG0lw1CYM+QomZZn5nWwbr2rGDyLpq1ATPp52W4lCeXyPeAf4AsW6RhNL8q9kIlu+goXoD0EVZytrt9Y8415skukN02iKBpESnx5jHl48cBwBLEWloynnWLG/fQkDlFbNo+kaes+u7r8ODGuAhu7aEklfUilhk9awaQQnMd40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtNxSrWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E3AC4CEED;
	Mon, 25 Aug 2025 13:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756128738;
	bh=XaTIaj6qHhD1hUA7V34cPlXuSaGIqHi/61efSmJGlLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FtNxSrWfOi+pHEA2JMEoer3JvCXgm4+JALquieVGBhzcgcZX6xPe6+HKmCeaCR7Df
	 ARojhsZyh+gLDLg2pPB90qnk+L2gWP7/BKy4UHm+F//Yx+M1VWG4xyuou1OGoTuJ1Q
	 kdBcdZKZJTHwDf7mjErpJ1XNjJeGvcXDc7FV3Yu7tJgBpnE/hjhIvDF7nbvTUPrqnz
	 v6j9/f3ZbGaVZKb3/y3Xn+omkBuRRlUDaE3p0PZHtXVc6I/BbXMKZk06WgVPNNH5hg
	 1OLdkU4EsNif2X2rKBV3C6st+84w7PHsyN7wloaVIpuwMnRC/RkjoDxwSuwqjDj4Ew
	 /eQWrCwiupdpg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v2 3/3] thermal: gov_step_wise: Allow cooling level to be reduced
 earlier
Date: Mon, 25 Aug 2025 15:31:53 +0200
Message-ID: <1947735.tdWV9SEqCh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12745610.O9o76ZdvQC@rafael.j.wysocki>
References: <12745610.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The current behavior of the Step-wise thermal governor is to increase
the cooling level one step at a time after trip point threshold passing
by thermal zone temperature until the temperature stops to rise and then
do nothing until it falls down below the (possibly new) trip point
threshold, at which point the cooling level is reduced straight to the
applicable minimum.

While this generally works, it is not in agreement with the throttling
logic description comment in step_wise_manage() any more after some
relatively recent changes, and in the case of passive cooling, it may
lead to undesirable performance oscillations between high and low
levels.

For this reason, modify the governor's cooling device state selection
function, get_target_state(), to reduce cooling by one level even if
the temperature is still above the thermal zone threshold, but the
temperature has started to fall down.  However, ensure that the cooling
level will remain above the applicable minimum in that case to pull
the zone temperature further down, possibly until it falls below the
trip threshold (which may now be equal to the low temperature of the
trip).

Doing so should help higher performance to be restored earlier in some
cases which is desirable especially for passive trip points with
relatively high hysteresis values.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_step_wise.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -20,7 +20,9 @@
  * If the temperature is higher than a trip point,
  *    a. if the trend is THERMAL_TREND_RAISING, use higher cooling
  *       state for this trip point
- *    b. if the trend is THERMAL_TREND_DROPPING, do nothing
+ *    b. if the trend is THERMAL_TREND_DROPPING, use a lower cooling state
+ *       for this trip point, but keep the cooling state above the applicable
+ *       minimum
  * If the temperature is lower than a trip point,
  *    a. if the trend is THERMAL_TREND_RAISING, do nothing
  *    b. if the trend is THERMAL_TREND_DROPPING, use the minimum applicable
@@ -51,6 +53,17 @@
 	if (throttle) {
 		if (trend == THERMAL_TREND_RAISING)
 			return clamp(cur_state + 1, instance->lower, instance->upper);
+
+		/*
+		 * If the zone temperature is falling, the cooling level can
+		 * be reduced, but it should still be above the lower state of
+		 * the given thermal instance to pull the temperature further
+		 * down.
+		 */
+		if (trend == THERMAL_TREND_DROPPING)
+			return clamp(cur_state - 1,
+				     min(instance->lower + 1, instance->upper),
+				     instance->upper);
 	} else if (trend == THERMAL_TREND_DROPPING) {
 		if (cur_state <= instance->lower)
 			return THERMAL_NO_TARGET;





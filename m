Return-Path: <linux-pm+bounces-32167-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5524EB20CEA
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 17:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9884A7B2434
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67F22DEA90;
	Mon, 11 Aug 2025 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DH/ynZYC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6F96A8D2;
	Mon, 11 Aug 2025 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754924601; cv=none; b=mGt2t4kYn/Qg63zJcK78ZAZwy5THafa1xMfRT1lt977cIQRW+93H9iXoKw4IVvxsedfjsQdpMw2lTWbL/pl808DFXAolApMBhtkc7+NxEjdJxjnhKUQIVYd8eG/V7bfooWhEpgDFgxHLSbkx5x1U43OiS1OV3VaRQKGDIA0/tUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754924601; c=relaxed/simple;
	bh=zH3Xr4/8gJV2SChW0xUKH3jzlpgJZI6xap1AHoXTOnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MuLtiF3UoX/IGz4/nUC9/Ptvmsi7LDcKHzQt/ZbAURuK2HwiXo5fzHZUTKF5GCgT+jZenbewOAIvTufAdZM3e50f18JnfU5qr3ecGKdw5mgPidk5YkMH7i7+GYeZ14Vq93RqVrDn+5nK50wy0uMVY6XSwlaE3ir5Ws2BtJySVPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DH/ynZYC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE6BC4CEED;
	Mon, 11 Aug 2025 15:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754924601;
	bh=zH3Xr4/8gJV2SChW0xUKH3jzlpgJZI6xap1AHoXTOnE=;
	h=From:To:Cc:Subject:Date:From;
	b=DH/ynZYCs8+d8JPMciiByh6+fpomeBGINIb88dTAM54Rg4feOgpEFufU0KX7o6gZE
	 W7+IhEnkGBxrt05CBqLVTrW/KTr/IyUoY0NGkbyKQLZbSOAZRVIH96sjhMkACmfynZ
	 x9zQZtv0HJ0/iCPLcXjNxM2mucbwDMCtwWUR3TG0Z1yrfdZipwF521PTEJ3eCFhLtW
	 dyHe+euR/48F7x1wYgl2yN0tr2q0z0g7mOzGRZBHq8mOG6rR+n27312OYbyS/by1aI
	 4E4ukXnJRVC2Kapa6XjuPXKyBErIp4YIAl3sZJxjmPCFYektTvbyo+zGGmhgPeE+uo
	 kURCTDvNlY2cw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
 Marc Zyngier <maz@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject:
 [PATCH v1] cpuidle: governors: menu: Avoid using invalid recent intervals
 data
Date: Mon, 11 Aug 2025 17:03:11 +0200
Message-ID: <2793874.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Marc has reported that commit 85975daeaa4d ("cpuidle: menu: Avoid
discarding useful information") caused the number of wakeup interrupts
to increase on an idle system [1], which was not expected to happen
after merely allowing shallower idle states to be selected by the
governor in some cases.

However, on the system in question, all of the idle states deeper than
WFI are rejected by the driver due to a firmware issue [2].  This causes
the governor to only consider the recent interval duriation data
corresponding to attempts to enter WFI that are successful and the
recent invervals table is filled with values lower than the scheduler
tick period.  Consequently, the governor predicts an idle duration
below the scheduler tick period length and avoids stopping the tick
more often which leads to the observed symptom.

Address it by modifying the governor to update the recent intervals
table also when entering the previously selected idle state fails, so
it knows that the short idle intervals might have been the minority
had the selected idle states been actually entered every time.

Fixes: 85975daeaa4d ("cpuidle: menu: Avoid discarding useful information")
Link: https://lore.kernel.org/linux-pm/86o6sv6n94.wl-maz@kernel.org/ [1]
Link: https://lore.kernel.org/linux-pm/7ffcb716-9a1b-48c2-aaa4-469d0df7c792@arm.com/ [2]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Marc Zyngier <maz@kernel.org>
---
 drivers/cpuidle/governors/menu.c |   21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -97,6 +97,14 @@
 
 static DEFINE_PER_CPU(struct menu_device, menu_devices);
 
+static void menu_update_intervals(struct menu_device *data, unsigned int interval_us)
+{
+	/* Update the repeating-pattern data. */
+	data->intervals[data->interval_ptr++] = interval_us;
+	if (data->interval_ptr >= INTERVALS)
+		data->interval_ptr = 0;
+}
+
 static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev);
 
 /*
@@ -222,6 +230,14 @@
 	if (data->needs_update) {
 		menu_update(drv, dev);
 		data->needs_update = 0;
+	} else if (!dev->last_residency_ns) {
+		/*
+		 * This happens when the driver rejects the previously selected
+		 * idle state and returns an error, so update the recent
+		 * intervals table to prevent invalid information from being
+		 * used going forward.
+		 */
+		menu_update_intervals(data, UINT_MAX);
 	}
 
 	/* Find the shortest expected idle interval. */
@@ -482,10 +498,7 @@
 
 	data->correction_factor[data->bucket] = new_factor;
 
-	/* update the repeating-pattern data */
-	data->intervals[data->interval_ptr++] = ktime_to_us(measured_ns);
-	if (data->interval_ptr >= INTERVALS)
-		data->interval_ptr = 0;
+	menu_update_intervals(data, ktime_to_us(measured_ns));
 }
 
 /**





Return-Path: <linux-pm+bounces-24857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25970A7CFD8
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 20:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72C01889448
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 18:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17A61A2622;
	Sun,  6 Apr 2025 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jmco9d/K"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFB11A08B1
	for <linux-pm@vger.kernel.org>; Sun,  6 Apr 2025 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743965910; cv=none; b=PLVzX9zifPsSXA78WEowJIDHOOM/X0ofLIwFjeeV6OX+YLEcCyrHxJ7lWt2CeZmc1Hh/xrfgGhhcpnEK6KpQl+Wg6nGFCFzkDoHsLAxSAhfAdfCiH8svaPZgzxrT1DEz778BaVA8lkD48ncIjpELYRmCCLKUD3nxzhZZslo0h4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743965910; c=relaxed/simple;
	bh=MESxv7015TB2C6nWfpmPu2AjsvIBZINelF1XBMnV2fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxNjpxRsGgBfqUT0OgUOdvo9EbgJcZjm9BJE8jEeEhXgKUYF8zjhNOa4Dvleap33l0u8EwB+Cw/w5LNCW7O+bXaDg0VCTr/hna/GJFR9oMsdLmMXtoDm+iFgn6n2gaLtAjj4LkPM3yi7gt8sCAGEYcACOQxeKoGKQ7MmlbrpMtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jmco9d/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4836AC4CEE3;
	Sun,  6 Apr 2025 18:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743965910;
	bh=MESxv7015TB2C6nWfpmPu2AjsvIBZINelF1XBMnV2fM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=Jmco9d/KmOkNnzcFfBYfSBxWvHoNrrLyamuum4FBfaq2PiFUPhy6b7+oVfq1sBUfL
	 Kn6yl5xE3aNWCxPCAMgT29LSfQS1SGB5TuTlYt9QBTzvehVAZwlYfeo586VysN8nSL
	 wxTcEK3Uz92Iog+Co8c5RwNvCIr99RIkJ9DnBOYFBVWk/y7fzcfSX42UygVS+pW2aq
	 0sQHIEY+2+YiAePkFAcEdYfx0wxC6JB1NGUMQ/MtUWv3hzqq1ALNdUdZv38jaijmxF
	 bq8ppI2B+3FGG4ypSSbIid0miFqarZt/aIlxj2LikBobYkhRXEXzxG0zXlQbHpW30H
	 nhHNZgROX92SA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 06/10] tools/power turbostat: report CoreThr per measurement interval
Date: Sun,  6 Apr 2025 14:57:15 -0400
Message-ID: <f729775f79a9c942c6c82ed6b44bd030afe10423.1743965272.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <1c7c7388e6c31f46b26a884d80b45efbad8237b2.1743965272.git.len.brown@intel.com>
References: <1c7c7388e6c31f46b26a884d80b45efbad8237b2.1743965272.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

The CoreThr column displays total thermal throttling events
since boot time.

Change it to report events during the measurement interval.

This is more useful for showing a user the current conditions.
Total events since boot time are still available to the user via
/sys/devices/system/cpu/cpu*/thermal_throttle/*

Document CoreThr on turbostat.8

Fixes: eae97e053fe30 ("turbostat: Support thermal throttle count print")
Reported-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Cc: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 | 2 ++
 tools/power/x86/turbostat/turbostat.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 52d727e29ea7..144565151e1e 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -172,6 +172,8 @@ The system configuration dump (if --quiet is not used) is followed by statistics
 .PP
 \fBPkgTmp\fP Degrees Celsius reported by the per-package Package Thermal Monitor.
 .PP
+\fBCoreThr\fP Core Thermal Throttling events during the measurement interval.  Note that events since boot can be find in /sys/devices/system/cpu/cpu*/thermal_throttle/*
+.PP
 \fBGFX%rc6\fP The percentage of time the GPU is in the "render C6" state, rc6, during the measurement interval. From /sys/class/drm/card0/power/rc6_residency_ms or /sys/class/drm/card0/gt/gt0/rc6_residency_ms or /sys/class/drm/card0/device/tile0/gtN/gtidle/idle_residency_ms depending on the graphics driver being used.
 .PP
 \fBGFXMHz\fP Instantaneous snapshot of what sysfs presents at the end of the measurement interval. From /sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz or /sys/class/drm/card0/gt_cur_freq_mhz or /sys/class/drm/card0/gt/gt0/rps_cur_freq_mhz or /sys/class/drm/card0/device/tile0/gtN/freq0/cur_freq depending on the graphics driver being used.
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 218aca958923..70e17d4ad9b6 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3485,7 +3485,7 @@ void delta_core(struct core_data *new, struct core_data *old)
 	old->c6 = new->c6 - old->c6;
 	old->c7 = new->c7 - old->c7;
 	old->core_temp_c = new->core_temp_c;
-	old->core_throt_cnt = new->core_throt_cnt;
+	old->core_throt_cnt = new->core_throt_cnt - old->core_throt_cnt;
 	old->mc6_us = new->mc6_us - old->mc6_us;
 
 	DELTA_WRAP32(new->core_energy.raw_value, old->core_energy.raw_value);
-- 
2.45.2



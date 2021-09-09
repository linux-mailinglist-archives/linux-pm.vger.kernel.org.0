Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90691404410
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 05:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbhIIDtZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 23:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhIIDtY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Sep 2021 23:49:24 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4563C061575;
        Wed,  8 Sep 2021 20:48:15 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e7so464550pgk.2;
        Wed, 08 Sep 2021 20:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y/WLSgOpfX2HTAAFSy41d9N/Nx3WgxZrgw34NFl7Pyk=;
        b=WEpx8gdhjWkgjEgy6QJdqDX/SJmY8aoekT3/QHpqD0N7BGhrnbmsWUBZ4CbKyAv0n6
         9u9e0iq0uE+ErvS+uifc8GkhJxyX/kcv0DLUoI3M3eUpnlwr2lptHcRRHOj/DGyqOlLY
         EZgYw1Re00fxrIYhCtvsgVhZJFO7fIfq/atvc0dMO5zhSGqwMTpJMY0PF612pfjRaPWr
         /CsHwzwf0v6JIyykcFiYgSs1dl1W9LACFs0ntOQQkvRul4lnIFFlwBcwoVDoPjeBeby8
         y6QnuGtwQoUqopkYyGksk5NnAsq9UrggYgypglyunJWDyYwC+8wWprKLEuL0fJ1r+Yua
         fsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y/WLSgOpfX2HTAAFSy41d9N/Nx3WgxZrgw34NFl7Pyk=;
        b=FqsjFJthwi818+9Ec5ep+zBo9aVK6de8PkHzXlypncNRbOR3te3C0w7kVF2EGTxs2k
         +p+CCwQ8FTHLK/kUUIbIxO1/X08KhLkmUzhh4vTb9XO9VJeiX9MpoIeNDyWgwBbwCATq
         TkPXg19c4tRUi8IuYMMjdqKyreCvzv3Sx8E61spT5iEvp3e9w+2mcH51KXkIUsK9ogwB
         H/onqcmrqQgjy/d5UABver3tq4bAyQQ8Mv1Ci+OuA7zMESNcuRcetkdmM4otaHx3QgWQ
         lgeff9IJx0x1yOjoHYB9xArIBaWPAx9YQsLOFXA8mKQL/YMaoX5yQ9abQo3C/60HMaGT
         seAg==
X-Gm-Message-State: AOAM5304f4Qoq0YEPZW7a5UEdfVkQP5SuY/KSvJisTCohKXZFP6HUQO1
        7iJTv22+W1vrQ5z6uBAAYs8=
X-Google-Smtp-Source: ABdhPJxl3OjM6Pkzb/siLHawQc6x1AHV0Ukpbs4WQ5/MI7Ob2/fFSuGKE0/BcDaZ8FczdMZaHW42aQ==
X-Received: by 2002:a63:bf07:: with SMTP id v7mr742651pgf.333.1631159295250;
        Wed, 08 Sep 2021 20:48:15 -0700 (PDT)
Received: from s19.smythies.com ([173.180.45.4])
        by smtp.gmail.com with ESMTPSA id v13sm361881pfm.16.2021.09.08.20.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 20:48:14 -0700 (PDT)
From:   Doug Smythies <doug.smythies@gmail.com>
X-Google-Original-From: Doug Smythies <dsmythies@telus.net>
To:     srinivas.pandruvada@linux.intel.com, rafael@kernel.org,
        len.brown@intel.com
Cc:     dsmythies@telus.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq: intel_pstate: Override parameters if HWP forced by BIOS
Date:   Wed,  8 Sep 2021 20:48:02 -0700
Message-Id: <20210909034802.1708-1-dsmythies@telus.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If HWP has been already been enabled by BIOS, it may be
necessary to override some kernel command line parameters.
Once it has been enabled it requires a reset to be disabled.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 drivers/cpufreq/intel_pstate.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index bb4549959b11..073bae5d4498 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3267,7 +3267,7 @@ static int __init intel_pstate_init(void)
 		 */
 		if ((!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) ||
 		    intel_pstate_hwp_is_enabled()) {
-			hwp_active++;
+			hwp_active = 1;
 			hwp_mode_bdw = id->driver_data;
 			intel_pstate.attr = hwp_cpufreq_attrs;
 			intel_cpufreq.attr = hwp_cpufreq_attrs;
@@ -3347,17 +3347,27 @@ device_initcall(intel_pstate_init);
 
 static int __init intel_pstate_setup(char *str)
 {
+	/*
+	 * If BIOS is forcing HWP, then parameter
+	 * overrides might be needed. Only print
+	 * the message once, and regardless of
+	 * any overrides.
+	 */
+	if(!hwp_active && boot_cpu_has(X86_FEATURE_HWP))
+		if(intel_pstate_hwp_is_enabled()){
+			pr_info("HWP enabled by BIOS\n");
+			hwp_active = 1;
+		}
 	if (!str)
 		return -EINVAL;
 
-	if (!strcmp(str, "disable"))
+	if (!strcmp(str, "disable") && !hwp_active)
 		no_load = 1;
-	else if (!strcmp(str, "active"))
+	if (!strcmp(str, "active"))
 		default_driver = &intel_pstate;
-	else if (!strcmp(str, "passive"))
+	if (!strcmp(str, "passive"))
 		default_driver = &intel_cpufreq;
-
-	if (!strcmp(str, "no_hwp")) {
+	if (!strcmp(str, "no_hwp") && !hwp_active) {
 		pr_info("HWP disabled\n");
 		no_hwp = 1;
 	}
-- 
2.25.1


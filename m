Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A804B407F8E
	for <lists+linux-pm@lfdr.de>; Sun, 12 Sep 2021 20:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbhILSwS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Sep 2021 14:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbhILSwR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Sep 2021 14:52:17 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627A5C061574;
        Sun, 12 Sep 2021 11:51:03 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id bg1so4396931plb.13;
        Sun, 12 Sep 2021 11:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N1vLVWi+RFNi6Lt1/29FRDB4TWWMhTl4uyfGG7aD3tY=;
        b=NlqlbMJiK2E1YWTxgXUdHHmZFjzgEi7dCGaI2G1/NtMvvoFqBEg78eEPwU4VKovhQB
         AfAYZb8tHbFhVvwh1kOLPcVN6+Mw3Wsn3J9oKC8JdY/a+GanDrcqCjWHXRueOG299gZU
         biat7dhmd+ie2v7d23iYHNDt+PIFnFgF6kqnlhVQZoNua5lydGOy5lermLb/H9daVhLR
         KZ5H2RJtcprwsi52mZgdTO7av/jzvNDR1OkWjw28veg76J57X9RmMN53HdT3Xax5sjny
         j4KX3GtKfoPm74D/cW3pbclN/pWSRFNq1NekkZASgua53GGRT+U9zxzX4tV83gQskHen
         SOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N1vLVWi+RFNi6Lt1/29FRDB4TWWMhTl4uyfGG7aD3tY=;
        b=YLpW3QiuDEUR8Sj+DZJhggaEh9QA4Uuv1/W7z6F0maUesJrFU/SBOz8WAuz10C4fN+
         Fih0dXQnTd/wN1XEmzrOAdxu2a1Cq9BUEqHmbEdBPmqdoai5Kl0i0I3gKuiz1VOoJ8bT
         SMWdfvX4k6TZiHvnkmtjtty5Fg9CoGU++Nlw5YOSVp6NGbWFzS2HsijGi3arKrOfijiw
         QZqg5l2khHbiHgRLPYbI12WjbdRL7lqpAVJhWf9ggp6ZzY/OE3JVXAJ2va4URB2rz+vl
         0EO8QVWzhK2DHMEDBgFsw+OfMd14bH1WRPU5rgl4LZMAG596AB04o5j8Sah5iQoNzg6d
         DdFQ==
X-Gm-Message-State: AOAM5316UK4xsQkF505to0cxmaQ3z/HDaexqZHRn9hyGQibj7fZPuRgs
        ISLTSqo/HYz/T1zgKFocz0s=
X-Google-Smtp-Source: ABdhPJyQXhCb4Opp7kQdEEOvWhpynEaeqa3gnJ7BNQDwaZLTZpFA4PjcNFtLpF8+C+j0S/AN//TXAw==
X-Received: by 2002:a17:90a:6c97:: with SMTP id y23mr8877993pjj.117.1631472662929;
        Sun, 12 Sep 2021 11:51:02 -0700 (PDT)
Received: from s19.smythies.com ([173.180.45.4])
        by smtp.gmail.com with ESMTPSA id z8sm4520964pfa.113.2021.09.12.11.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 11:51:02 -0700 (PDT)
From:   Doug Smythies <doug.smythies@gmail.com>
X-Google-Original-From: Doug Smythies <dsmythies@telus.net>
To:     srinivas.pandruvada@linux.intel.com, rafael@kernel.org,
        len.brown@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH v2] cpufreq: intel_pstate: Override parameters if HWP forced by BIOS
Date:   Sun, 12 Sep 2021 11:50:29 -0700
Message-Id: <20210912185029.5704-1-dsmythies@telus.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If HWP has been already been enabled by BIOS, it may be
necessary to override some kernel command line parameters.
Once it has been enabled it requires a reset to be disabled.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 drivers/cpufreq/intel_pstate.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1097f826ad70..8c176b7dae41 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3205,11 +3205,15 @@ static int __init intel_pstate_init(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return -ENODEV;
 
-	if (no_load)
-		return -ENODEV;
-
 	id = x86_match_cpu(hwp_support_ids);
 	if (id) {
+		bool hwp_forced = intel_pstate_hwp_is_enabled();
+
+		if (hwp_forced)
+			pr_info("HWP enabled by BIOS\n");
+		else if (no_load)
+			return -ENODEV;
+
 		copy_cpu_funcs(&core_funcs);
 		/*
 		 * Avoid enabling HWP for processors without EPP support,
@@ -3219,8 +3223,7 @@ static int __init intel_pstate_init(void)
 		 * If HWP is enabled already, though, there is no choice but to
 		 * deal with it.
 		 */
-		if ((!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) ||
-		    intel_pstate_hwp_is_enabled()) {
+		if ((!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) || hwp_forced) {
 			hwp_active++;
 			hwp_mode_bdw = id->driver_data;
 			intel_pstate.attr = hwp_cpufreq_attrs;
@@ -3235,7 +3238,11 @@ static int __init intel_pstate_init(void)
 
 			goto hwp_cpu_matched;
 		}
+		pr_info("HWP not enabled\n");
 	} else {
+		if (no_load)
+			return -ENODEV;
+
 		id = x86_match_cpu(intel_pstate_cpu_ids);
 		if (!id) {
 			pr_info("CPU model not supported\n");
@@ -3314,10 +3321,9 @@ static int __init intel_pstate_setup(char *str)
 	else if (!strcmp(str, "passive"))
 		default_driver = &intel_cpufreq;
 
-	if (!strcmp(str, "no_hwp")) {
-		pr_info("HWP disabled\n");
+	if (!strcmp(str, "no_hwp"))
 		no_hwp = 1;
-	}
+
 	if (!strcmp(str, "force"))
 		force_load = 1;
 	if (!strcmp(str, "hwp_only"))
-- 
2.25.1


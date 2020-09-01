Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0091258E73
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 14:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgIAMpZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 08:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbgIAMMj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 08:12:39 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F44C061245
        for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2020 05:12:39 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a15so1229118ljk.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2020 05:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KcabfpNUbz/94m2beE+mIi0sXiS5hWouLrlZQW6A0Y8=;
        b=tFGpbEeRPaD/7SAstAub6FEw+WEvnVTGkhEeyL6nCREb3OqTlxa9EvlkGGqsAuSD0I
         oaav8ujwDhRA3r023cxpDaTEsOiA307jLZL1B/hmJshz5Sl+0/ZSWx6W1UHRpaT4eIPb
         +O6tEgWgTWdUmwNsGAyCtd4sGtsCKjOoVlRfrhXEXp0MfPp0GN1FSmiQI2z+ZuyYLXPD
         NP7dGfwJwvLsn6pzlvFtQNHojbjzO0NR7NFOU0QcjlDtii3Xy3I7ZTg4whZBzCrEyl9V
         Y3z42lmtIqv9N9lny3HUry9lBuqN1V9VCzWSsQE4my9nTlfPAMi6ZjqUqKMot5jkw5EB
         P7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KcabfpNUbz/94m2beE+mIi0sXiS5hWouLrlZQW6A0Y8=;
        b=PV0SCJ071HZbkRylHVoxo+FnJKR4dnTH3riCreNL9c21DglS/7I0OVTEC3GOlAdjgQ
         Jc7vgxGnEACh6PZO99kJ8FX4fV4FkqiDOYMsIrfGaJ7TDUE/Wt79f22mA/ivfm4uJV7Y
         aL/CXVHVSRHeVFAnFn9ig3e6eXSVBqsv0PkEwbcw5THVcHZM1kUGSzGj9lTgXsc2DaEI
         e9qkVwz3K3Sprc5MOFV0W+eKW/1iXntz8mWx7blgyniNn6rcIn+TEFGEIlhT6kfl7REx
         aIjb4Cg0NesjkDZ8niLIMH2gIPBLWAxKhG7SVGYyKQYLqzRKOWuiPcBlfpt6NadcQX5I
         rxHA==
X-Gm-Message-State: AOAM530pQI/GAsy7xDJrE13kG0VCtfM89tIHLI8x26h3o+Za3MzN4ElV
        IVaxbbu6493Aqg9TlCzcWUd43g==
X-Google-Smtp-Source: ABdhPJwSUvot8vq5xYnb2+1JuH6uVSjJsEVhPQ3s0aSQUvNrkB6VE+cTn0rhlDdWzXfSBxy7OGrMqg==
X-Received: by 2002:a2e:89d9:: with SMTP id c25mr465597ljk.46.1598962357475;
        Tue, 01 Sep 2020 05:12:37 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-79.NA.cust.bahnhof.se. [98.128.180.79])
        by smtp.gmail.com with ESMTPSA id u6sm241193ljg.105.2020.09.01.05.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 05:12:36 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] firmware: psci: Extend psci_set_osi_mode() to allow reset to PC mode
Date:   Tue,  1 Sep 2020 14:12:25 +0200
Message-Id: <20200901121226.217568-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200901121226.217568-1-ulf.hansson@linaro.org>
References: <20200901121226.217568-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The current user (cpuidle-psci) of psci_set_osi_mode() only needs to enable
the PSCI OSI mode. Although, as subsequent changes shows, there is a need
to be able to reset back into the PSCI PC mode.

Therefore, let's extend psci_set_osi_mode() to take a bool as in-parameter,
to let the user indicate whether to enable OSI or to switch back to PC
mode.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci-domain.c |  2 +-
 drivers/firmware/psci/psci.c          | 12 +++++++-----
 include/linux/psci.h                  |  2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index b6e9649ab0da..b6ab0415f450 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -278,7 +278,7 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 		goto remove_pd;
 
 	/* Try to enable OSI mode. */
-	ret = psci_set_osi_mode();
+	ret = psci_set_osi_mode(true);
 	if (ret) {
 		pr_warn("failed to enable OSI mode: %d\n", ret);
 		psci_pd_remove_topology(np);
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 92013ecc2d9e..00af99b6f97c 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -151,12 +151,15 @@ static u32 psci_get_version(void)
 	return invoke_psci_fn(PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0);
 }
 
-int psci_set_osi_mode(void)
+int psci_set_osi_mode(bool enable)
 {
+	unsigned long suspend_mode;
 	int err;
 
-	err = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE,
-			     PSCI_1_0_SUSPEND_MODE_OSI, 0, 0);
+	suspend_mode = enable ? PSCI_1_0_SUSPEND_MODE_OSI :
+			PSCI_1_0_SUSPEND_MODE_PC;
+
+	err = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE, suspend_mode, 0, 0);
 	return psci_to_linux_errno(err);
 }
 
@@ -546,8 +549,7 @@ static int __init psci_1_0_init(struct device_node *np)
 		pr_info("OSI mode supported.\n");
 
 		/* Default to PC mode. */
-		invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE,
-			       PSCI_1_0_SUSPEND_MODE_PC, 0, 0);
+		psci_set_osi_mode(false);
 	}
 
 	return 0;
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 14ad9b9ebcd6..2a1bfb890e58 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -18,7 +18,7 @@ bool psci_tos_resident_on(int cpu);
 
 int psci_cpu_suspend_enter(u32 state);
 bool psci_power_state_is_valid(u32 state);
-int psci_set_osi_mode(void);
+int psci_set_osi_mode(bool enable);
 bool psci_has_osi_support(void);
 
 struct psci_operations {
-- 
2.25.1


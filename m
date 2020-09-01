Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31472259067
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 16:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgIAO30 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 10:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgIAO3K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 10:29:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBA6C061245
        for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2020 07:29:09 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id r13so1800323ljm.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2020 07:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LTilAKx6uhyrrDCSQGM9DUga+qKc7kxrp8ADcGsaoJo=;
        b=WDHB19AGJeh66EVd4uru7yOjVuBjxtiQGn+tHoHz1rkFf4LoQ14AJI8XoVMOkqK1y+
         tP4yxQX7bkHab4DxtpYpGgaL2Wj7b4sr7vFGIS875JY2yLLMr/+gOFObjVzJ8V5FQV0/
         sqtEblQh1nYuMiWsgwjzDQOOf2C7f1lZKdda/US6QBJvCn3uCGsYuXIWdEi14gHxGdXW
         LOpgn9Zy3O3S3ZJTfxKNMlWHX2My2WRvMuIxhqAVheK1sA+i/kkAy3n9J+qAX4FE32Ml
         B4Et8qXF96r9/1hws7RdaLIcK8AL5WV3C9/OZroNUOaWitkbW4uLMmzRpSEQchNDGkPl
         3ePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LTilAKx6uhyrrDCSQGM9DUga+qKc7kxrp8ADcGsaoJo=;
        b=kyOrIugZAMnwby/OENEu8VY89Z3oJLVdFU19GIZ2TR+f8K5HT6rj9Drkjpe0QX41mm
         Cs6qWuuhSBqd+aLex/aReQmy1v2NR+UQUUs3jW3+d69UPMB8yS69QLo4mnKc8vrj7rjk
         Z3yvPM7Mcz5s8RyxjhLj71FWfr/IzLYpXZnaDIGKqDRJkwTXvd6uyIV/T9Wt6qEFJdCu
         h4rW/SmLhQSWFOYkM2iBy6nZpi8Sc0IBR7l9DKgLU39WDo2y13bZGe1f2mmQkmoTeOQc
         6VRlN1D0uRnhUgb5MVq0rYtgpPIHa/syS4Lg88ykLHqRJeJ8grwZwrJPf18XUDO9YOZp
         FowQ==
X-Gm-Message-State: AOAM530a9WvpShwPQ5JLbl1huPjaG1gwQIoymoyIWxtUKgr3K6wAu0TL
        cfgQHRt7W2OpVxetKN6U7uh1sg==
X-Google-Smtp-Source: ABdhPJyWQNEbbmEJWXfQWRgICw8JuT0MwqJbc8qwxQ+05+O9Zg1NEAZsOpYK5ll8S0N/aewyZdl5/w==
X-Received: by 2002:a05:651c:505:: with SMTP id o5mr755471ljp.306.1598970547217;
        Tue, 01 Sep 2020 07:29:07 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-79.NA.cust.bahnhof.se. [98.128.180.79])
        by smtp.gmail.com with ESMTPSA id r7sm318313lfn.84.2020.09.01.07.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:29:06 -0700 (PDT)
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
Subject: [PATCH v3 1/2] firmware: psci: Extend psci_set_osi_mode() to allow reset to PC mode
Date:   Tue,  1 Sep 2020 16:28:58 +0200
Message-Id: <20200901142859.224381-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200901142859.224381-1-ulf.hansson@linaro.org>
References: <20200901142859.224381-1-ulf.hansson@linaro.org>
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

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Added reviewed-by tag.

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


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A680A12D0F2
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2019 15:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfL3OoQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Dec 2019 09:44:16 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36055 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfL3OoQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Dec 2019 09:44:16 -0500
Received: by mail-lf1-f67.google.com with SMTP id n12so25273600lfe.3
        for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2019 06:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=krY1+EzVUJ6sQ3sUZo42Ne6/cEpafTpvxV4MO9ew0Qs=;
        b=Gc+Fg4TmSoUG1xWh3kAAiPa4hscTTHTe6IdrmSqns5W0W+f7yJrWKqBYznZ+x0PfgH
         NXbjsuw2UWFrmRxEtu+ztS7HJpjnO0pQMsTaHMpUkWCneB+VdUs4fpaxwI4jqRs1A/0h
         HmWRvjF8FTPMxeZXibm2xawvWvneqvZysoeI74fqb3JuHPQ6wc9t52l/qvM9Xi1BIGbr
         Xm2ICKSM+SPWCTmZkaqkmasmkFKPO744rJ8SrsfKkjQQpjcXbjzrdM+UBEz2ONQJv4hM
         Eue69/Oc3VVQtL6NLjIDPyUe3oBQcFFKMow3ZJ7rP0IwzTXPWtSqWDS1snHLUYOL6hAG
         YM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=krY1+EzVUJ6sQ3sUZo42Ne6/cEpafTpvxV4MO9ew0Qs=;
        b=XEze4tPn7RgXhtwYmm+SEjpJAPYiasCSTY0niQv+jc3zGVmkqSJ9kPl+CTPr2kmuCy
         M51bwPqwYP3JXc6e8I4ceY3if874Nc4QkbH+miKX+QcZeN6CAgVEmraI/OZ0y9gziZ/T
         6SVJkj7/7IEKhRSBjEcZ7WAsoiJak69BVtRzkQ+90Nwzj3RwoZu//zVMLJiqHHN64qho
         XvD5h1r80v2+INi/Qyn7L+3oXrzk+25ehwBMsFnKYsQ0iK+xBLh2BGHYwnPxFbP9CgJd
         ElEJ5UzA+TvPRG4isNbZkegpmggU/KTaiMXe5CAAtXbvaVitx+5x+QcCoyicmofnEWkp
         DoYg==
X-Gm-Message-State: APjAAAXsrAFklHJpuO9H3ADcj6uvcyREImdVHevSfyoMzFHN7pMEtYVt
        stxeAjx+JHOFBC++hfSWJAN02A==
X-Google-Smtp-Source: APXvYqwJxfxFlD3Cgmg6BuZVIx15qUnVkISMIx+ar2b16DDxv2vUZ23t0kZT/+jP5v39VcqlR5CAmQ==
X-Received: by 2002:a19:8a06:: with SMTP id m6mr35878357lfd.99.1577717053708;
        Mon, 30 Dec 2019 06:44:13 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id a21sm18744931lfg.44.2019.12.30.06.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 06:44:13 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 03/15] firmware: psci: Export functions to manage the OSI mode
Date:   Mon, 30 Dec 2019 15:43:50 +0100
Message-Id: <20191230144402.30195-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230144402.30195-1-ulf.hansson@linaro.org>
References: <20191230144402.30195-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To allow subsequent changes to implement support for OSI mode through the
cpuidle-psci driver, export the existing psci_has_osi_support(). Export
also a new function, psci_set_osi_mode(), that allows its caller to enable
the OS-initiated CPU-suspend mode in the PSCI FW.

To deal with backwards compatibility for a kernel started through a kexec
call, default to set the CPU-suspend mode to the Platform Coordinated mode
during boot.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---

Changes in v5:
	- None.

---
 drivers/firmware/psci/psci.c | 18 ++++++++++++++++--
 include/linux/psci.h         |  2 ++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index b3b6c15e7b36..2937d44b5df4 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -97,7 +97,7 @@ static inline bool psci_has_ext_power_state(void)
 				PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK;
 }
 
-static inline bool psci_has_osi_support(void)
+bool psci_has_osi_support(void)
 {
 	return psci_cpu_suspend_feature & PSCI_1_0_OS_INITIATED;
 }
@@ -162,6 +162,15 @@ static u32 psci_get_version(void)
 	return invoke_psci_fn(PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0);
 }
 
+int psci_set_osi_mode(void)
+{
+	int err;
+
+	err = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE,
+			     PSCI_1_0_SUSPEND_MODE_OSI, 0, 0);
+	return psci_to_linux_errno(err);
+}
+
 static int psci_cpu_suspend(u32 state, unsigned long entry_point)
 {
 	int err;
@@ -544,9 +553,14 @@ static int __init psci_1_0_init(struct device_node *np)
 	if (err)
 		return err;
 
-	if (psci_has_osi_support())
+	if (psci_has_osi_support()) {
 		pr_info("OSI mode supported.\n");
 
+		/* Default to PC mode. */
+		invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE,
+			       PSCI_1_0_SUSPEND_MODE_PC, 0, 0);
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/psci.h b/include/linux/psci.h
index ebe0a881d13d..a67712b73b6c 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -18,6 +18,8 @@ bool psci_tos_resident_on(int cpu);
 
 int psci_cpu_suspend_enter(u32 state);
 bool psci_power_state_is_valid(u32 state);
+int psci_set_osi_mode(void);
+bool psci_has_osi_support(void);
 
 enum smccc_version {
 	SMCCC_VERSION_1_0,
-- 
2.17.1


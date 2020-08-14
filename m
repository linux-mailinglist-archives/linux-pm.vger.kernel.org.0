Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75392449CD
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 14:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgHNMep (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Aug 2020 08:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgHNMep (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2020 08:34:45 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FA6C061384
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2020 05:34:44 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h19so9729121ljg.13
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2020 05:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8aVoGCMCcv9Pur2tl+i/JV47L57zCbtcAw9hM4hvPuc=;
        b=x/Zvl0ougehRb3wVjQjr0HoONDuxi42khbGkjaslALueN2HvNKrxyJzDzpnyO5UTCt
         r38QGo1s2yP2+BIioamuO13Uu/nlhVXKbM1iQleCylilcLu0ITIfrBP+DFnYqJcCaiHu
         rhT4p0WmM6piixPya+OAjfBRKJuU2LBQtOJaTVWR3ZEg5DIdMxeGScmcbShOxEqxGoaI
         W5mI7Bx93MLe4v8v4jHAlY201dYwrznnZwwNnMLw3/0gy6aSC4Je9XXs9O7CHYIKTLga
         gmEuE4hMm8BdHmNx4JN9aiP93Lhioo8qqcwUMIM/o1q7q5cbxR1rXDYtXUFJzXIx7D7j
         xksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8aVoGCMCcv9Pur2tl+i/JV47L57zCbtcAw9hM4hvPuc=;
        b=iz1gOwj7HPmeP7fTM0fNtCdCL82klr9Po6eeHJUPOxoAW44GLSjh47TO68P4ei6DA/
         tgO3S06hWp/TI8FAYnddxXGZqNjqKaxSXwtx/5zh7uufI2vQLVQ+FFsmNmJwS7KQp6F1
         T9EYIuANOcadw9LlOg+baZGTx1LUrDlFf+uTfaPQbGMkKo4KH10r4FqDy10j4dKN4DZV
         pMnP6KkhhJN4TcthILT5Rr+bMTCxDJ4uv0KSQ4T6pBlgDQwj7WsTCMlMQY/d3C5R0OMz
         fVpIjSNJ43/qMmnLMRuqg93me/DJjuPREAcnL8p6Nla2WoTSlmMTO83yZ+Q/rQEGdD+r
         CGgg==
X-Gm-Message-State: AOAM5334ccGtm4jj3vEoUzXzaBWkZ3HrNl/wBuR8wJtPXj6vWKHskR6w
        12ZScnawWMCgg1d9vNMIYfsLAzk+GIOjqHg5
X-Google-Smtp-Source: ABdhPJyAOCGDj1qaSczJ9tlFNl4QXH/NCYtmOjrrS69NKLy68n1a3HBKwskLzM+LwY9ORriDJtSslg==
X-Received: by 2002:a2e:8346:: with SMTP id l6mr1264611ljh.0.1597408483313;
        Fri, 14 Aug 2020 05:34:43 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-79.NA.cust.bahnhof.se. [98.128.180.79])
        by smtp.gmail.com with ESMTPSA id 12sm1733799lju.67.2020.08.14.05.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 05:34:42 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] cpuidle: psci: Allow PM domain to be initialized even if no OSI mode
Date:   Fri, 14 Aug 2020 14:34:36 +0200
Message-Id: <20200814123436.61851-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If the PSCI OSI mode isn't supported or fails to be enabled, the PM domain
topology with the genpd providers isn't initialized. This is perfectly fine
from cpuidle-psci point of view.

However, since the PM domain topology in the DTS files is a description of
the HW, no matter of whether the PSCI OSI mode is supported or not, other
consumers besides the CPUs may rely on it.

Therefore, let's always allow the initialization of the PM domain topology
to succeed, independently of whether the PSCI OSI mode is supported.
Consequentially we need to track if we succeed to enable the OSI mode, as
to know when a domain idlestate can be selected.

Note that, CPU devices are still not being attached to the PM domain
topology, unless the PSCI OSI mode is supported.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 49 +++++++++++++--------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index b6e9649ab0da..55653c110e3a 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -28,6 +28,7 @@ struct psci_pd_provider {
 
 static LIST_HEAD(psci_pd_providers);
 static bool psci_pd_allow_domain_state;
+static bool psci_osi_mode_enabled;
 
 static int psci_pd_power_off(struct generic_pm_domain *pd)
 {
@@ -37,7 +38,7 @@ static int psci_pd_power_off(struct generic_pm_domain *pd)
 	if (!state->data)
 		return 0;
 
-	if (!psci_pd_allow_domain_state)
+	if (!psci_pd_allow_domain_state || !psci_osi_mode_enabled)
 		return -EBUSY;
 
 	/* OSI mode is enabled, set the corresponding domain state. */
@@ -190,7 +191,7 @@ static void psci_pd_remove(void)
 	}
 }
 
-static int psci_pd_init_topology(struct device_node *np, bool add)
+static int psci_pd_init_topology(struct device_node *np)
 {
 	struct device_node *node;
 	struct of_phandle_args child, parent;
@@ -203,9 +204,7 @@ static int psci_pd_init_topology(struct device_node *np, bool add)
 
 		child.np = node;
 		child.args_count = 0;
-
-		ret = add ? of_genpd_add_subdomain(&parent, &child) :
-			of_genpd_remove_subdomain(&parent, &child);
+		ret = of_genpd_add_subdomain(&parent, &child);
 		of_node_put(parent.np);
 		if (ret) {
 			of_node_put(node);
@@ -216,14 +215,21 @@ static int psci_pd_init_topology(struct device_node *np, bool add)
 	return 0;
 }
 
-static int psci_pd_add_topology(struct device_node *np)
+static void psci_pd_try_set_osi_mode(void)
 {
-	return psci_pd_init_topology(np, true);
-}
+	int ret;
 
-static void psci_pd_remove_topology(struct device_node *np)
-{
-	psci_pd_init_topology(np, false);
+	if (!psci_has_osi_support())
+		return;
+
+	/* Try to enable OSI mode. */
+	ret = psci_set_osi_mode();
+	if (ret) {
+		pr_warn("failed to enable OSI mode: %d\n", ret);
+		return;
+	}
+
+	psci_osi_mode_enabled = true;
 }
 
 static void psci_cpuidle_domain_sync_state(struct device *dev)
@@ -249,10 +255,6 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 	if (!np)
 		return -ENODEV;
 
-	/* Currently limit the hierarchical topology to be used in OSI mode. */
-	if (!psci_has_osi_support())
-		return 0;
-
 	/*
 	 * Parse child nodes for the "#power-domain-cells" property and
 	 * initialize a genpd/genpd-of-provider pair when it's found.
@@ -273,17 +275,15 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 		return 0;
 
 	/* Link genpd masters/subdomains to model the CPU topology. */
-	ret = psci_pd_add_topology(np);
+	ret = psci_pd_init_topology(np);
 	if (ret)
 		goto remove_pd;
 
-	/* Try to enable OSI mode. */
-	ret = psci_set_osi_mode();
-	if (ret) {
-		pr_warn("failed to enable OSI mode: %d\n", ret);
-		psci_pd_remove_topology(np);
-		goto remove_pd;
-	}
+	/*
+	 * If OSI mode isn't supported, the topology isn't used by CPUs, but
+	 * it may still be used by other consumers. Leave it initialized.
+	 */
+	psci_pd_try_set_osi_mode();
 
 	pr_info("Initialized CPU PM domain topology\n");
 	return 0;
@@ -291,8 +291,7 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 put_node:
 	of_node_put(node);
 remove_pd:
-	if (pd_count)
-		psci_pd_remove();
+	psci_pd_remove();
 	pr_err("failed to create CPU PM domains ret=%d\n", ret);
 	return ret;
 }
-- 
2.25.1


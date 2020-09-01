Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFCA258A55
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 10:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgIAI1Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 04:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgIAI1X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 04:27:23 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC528C061244
        for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2020 01:27:21 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y4so460875ljk.8
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2020 01:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lXhXw6gw2mHmJ9Say6lfS63FssmiQ2xQJb+o3xFUf34=;
        b=zfzrThjFMwF1c1XHJi778ZPH/w59mrO8rbDIg8IHZiiE0F8rQSGJCpKFoeWGheWK96
         Idd0WZeKs/qriujA6iGr594rONIcY2Pe1Y1GVVQsO4lgvEGU9+96HJPQvxRP13iXjLUj
         Cz0eNJgi9pyOL2kxRsm79ad9LWMkDThPn4Mcgpbd9Doky3fX2IubA6wmvKv4XemYHSLt
         8FabgI94lsEGxTNuzvzvg2tuD5eGP/jQX+/pWz19CWEXnwuwMGAInYbNigJBwfNqAXkQ
         Y9trrilA+YtBMww71ASpqRvRfImGrLaEL+yZObCcq/97LXeMmI3a6o0LdkJx2aY4/GhX
         IOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lXhXw6gw2mHmJ9Say6lfS63FssmiQ2xQJb+o3xFUf34=;
        b=UFEwsSk2Lw/YWJnuLecWYxfpE2LGmFLuPWBtcD3nk+pFYOMtHgSjVZ3Icv6uE0YVQY
         LcoeI0OY7E3mHlkhX13/BjVTyUXWBj8tgrsu0dyKOODvL0gGFe1kEg2dOXDA3pD6WvW3
         3CPYrpQaDAbgIOye5CpbjkP2fceRiUEjk3qJufoBA2MngI9euo2ShY+SBp8DU3lzNpOW
         6MGHnSxlK+P5cqPAu9NoPCNsccnE24vcDyRd/oTeKYLeT5QfhuEBcr4vuDfACpGkKw86
         Q+L/yKwZOcyKks4RFGE8/65LaTvHLZ6ND+CEBJyfQoGGWVTsQvto0B8hVoxzMKkERUie
         Us0w==
X-Gm-Message-State: AOAM533wolIyh57Pbync3oR8iHSQsWE2GfL8N/yK1EeDpx3rXpjNnRuh
        T1Sqx4L9f8uZ7LnZEeRAiyAjTw==
X-Google-Smtp-Source: ABdhPJzVe2jkEa7XevmysGxEov7CVQX9Xjx6o7FSE+FdPUQgf+fKxVXEDSf0N3C1OuCCKppIMFQdzw==
X-Received: by 2002:a05:651c:110:: with SMTP id a16mr12283ljb.152.1598948839148;
        Tue, 01 Sep 2020 01:27:19 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-79.NA.cust.bahnhof.se. [98.128.180.79])
        by smtp.gmail.com with ESMTPSA id c5sm111252lfb.24.2020.09.01.01.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 01:27:18 -0700 (PDT)
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
Subject: [PATCH 2/2] cpuidle: psci: Enable s2idle when using OSI with the PM domain topology
Date:   Tue,  1 Sep 2020 10:27:07 +0200
Message-Id: <20200901082707.106860-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200901082707.106860-1-ulf.hansson@linaro.org>
References: <20200901082707.106860-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To select domain idle states for cpuidle-psci, the PM domains via genpd are
being managed by using runtime PM. This works fine for the regular idle
path, but it doesn't when doing s2idle.

More precisely, the domain idle states becomes temporarily disabled, which
is because the PM core disables runtime PM for devices during system
suspend. Even if genpd tries to power off the PM domain in the
suspend_noirq phase, that doesn't help to properly select a domain idle
state, as this needs to be done on per CPU basis.

Let's address the issue by enabling the syscore flag for the attached CPU
devices. This prevents genpd from trying to power off the corresponding PM
domains in the suspend_noirq phase. Moreover, let's assign a specific
->enter_s2idle() callback for the corresponding domain idle state and let
it invoke pm_genpd_syscore_poweroff|poweron(), rather than using runtime
PM.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci-domain.c |  2 ++
 drivers/cpuidle/cpuidle-psci.c        | 30 +++++++++++++++++++++++----
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index b6e9649ab0da..65437ba5fa78 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -324,6 +324,8 @@ struct device *psci_dt_attach_cpu(int cpu)
 	if (cpu_online(cpu))
 		pm_runtime_get_sync(dev);
 
+	dev_pm_syscore_device(dev, true);
+
 	return dev;
 }
 
diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 74463841805f..6322d55a0a7d 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -19,6 +19,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/psci.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -52,8 +53,9 @@ static inline int psci_enter_state(int idx, u32 state)
 	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state);
 }
 
-static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
-					struct cpuidle_driver *drv, int idx)
+static int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
+					  struct cpuidle_driver *drv, int idx,
+					  bool s2idle)
 {
 	struct psci_cpuidle_data *data = this_cpu_ptr(&psci_cpuidle_data);
 	u32 *states = data->psci_states;
@@ -66,7 +68,10 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
 		return -1;
 
 	/* Do runtime PM to manage a hierarchical CPU toplogy. */
-	pm_runtime_put_sync_suspend(pd_dev);
+	if (s2idle)
+		pm_genpd_syscore_poweroff(pd_dev);
+	else
+		pm_runtime_put_sync_suspend(pd_dev);
 
 	state = psci_get_domain_state();
 	if (!state)
@@ -74,7 +79,10 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
 
 	ret = psci_cpu_suspend_enter(state) ? -1 : idx;
 
-	pm_runtime_get_sync(pd_dev);
+	if (s2idle)
+		pm_genpd_syscore_poweron(pd_dev);
+	else
+		pm_runtime_get_sync(pd_dev);
 
 	cpu_pm_exit();
 
@@ -83,6 +91,19 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
 	return ret;
 }
 
+static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
+					struct cpuidle_driver *drv, int idx)
+{
+	return __psci_enter_domain_idle_state(dev, drv, idx, false);
+}
+
+static int psci_enter_s2idle_domain_idle_state(struct cpuidle_device *dev,
+					       struct cpuidle_driver *drv,
+					       int idx)
+{
+	return __psci_enter_domain_idle_state(dev, drv, idx, true);
+}
+
 static int psci_idle_cpuhp_up(unsigned int cpu)
 {
 	struct device *pd_dev = __this_cpu_read(psci_cpuidle_data.dev);
@@ -170,6 +191,7 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 	 * deeper states.
 	 */
 	drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
+	drv->states[state_count - 1].enter_s2idle = psci_enter_s2idle_domain_idle_state;
 	psci_cpuidle_use_cpuhp = true;
 
 	return 0;
-- 
2.25.1


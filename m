Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522494EEEF6
	for <lists+linux-pm@lfdr.de>; Fri,  1 Apr 2022 16:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346723AbiDAONi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Apr 2022 10:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346724AbiDAONb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2022 10:13:31 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B030D217973
        for <linux-pm@vger.kernel.org>; Fri,  1 Apr 2022 07:11:41 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id h11so4123149ljb.2
        for <linux-pm@vger.kernel.org>; Fri, 01 Apr 2022 07:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+mT7DozH0I+kyrJvkjL2P2dEm61K2NFLYH90tYVa51o=;
        b=P7c4fDPcdG/p6IDbn6XygyqieRQwUZhlzkE+5K1NmkEbE4nBBTsJDkJPg9D8E8pAu4
         9ETDlnCnoW27jEd3/9JE2NVFZSCcFSaavPEe04CxJhnt6xl7IGYtRjcbYZ2uqxm4yc97
         151x3IIqAzoJLcwfNBz0Dry5Lab0/okslV9lDKgLV3C5f2bEEJMrgVH4jOF80Ut9lPmB
         UuyClcUBsUdMxA2mztVPVxsjUWDwL6+HiNIVkbRQsAwMzmnYBqRi4s1wXkRBI1tmiuzo
         W7inJ9GMeM+3W8VdsmjmOGHz36wfnRBgB7QX7Y0o4M+XmSJfT6IHm4AIKtOyr9aupyEd
         wdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+mT7DozH0I+kyrJvkjL2P2dEm61K2NFLYH90tYVa51o=;
        b=xoonHMgotXqgkHYdDn8U3c0pAHfNBZ3oHudYVjltuDa0lTgyAX7l/m2yGKKp+QRamr
         qTGU6J6N82bDkviy8gV9hIoL4fJfmqrv+mEN84MNZu8w6P08Clxtqc3TRdC8/9LuWaJI
         hw3AVgKuacZrV4OoeqjZtY0+4p1Z2tRvWpL2h8vLxG8zEMJmWMotm2QSttQoomGqL8bU
         PbOQppVj/P4imyA+hMaymM+9h426F+c3sOpSbl00JNcg5NvPkPRWCxdXUsm7iGr3hwl+
         VCQEYqmMZulEFueDgqxsgtvGdQ3mLCJzY3gIBJqUMDmfQRfJDN5HOhlQ9wncTUHt5rET
         8IFQ==
X-Gm-Message-State: AOAM531/R855+x8lzm+Vy3HVY8Fd2vhXNzZLuw2qwAC/GTodyPwim98B
        FNT2VXUrsnQKn1al3xbInZWgFg==
X-Google-Smtp-Source: ABdhPJzPNIzR8o/fTHBpIIc5TQRIQ6skrKM1Hx35yicn83dRV3rC2APQINhmpRQugY4tPM0ZnstwXg==
X-Received: by 2002:a2e:9045:0:b0:249:78ba:fbf8 with SMTP id n5-20020a2e9045000000b0024978bafbf8mr13484220ljg.218.1648822299947;
        Fri, 01 Apr 2022 07:11:39 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id 16-20020ac24d50000000b0044a255c8d3bsm251926lfp.116.2022.04.01.07.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 07:11:38 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     Maulik Shah <quic_mkshah@quicinc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] cpuidle: psci: Improve support for suspend-to-ram for PSCI OSI mode
Date:   Fri,  1 Apr 2022 16:11:24 +0200
Message-Id: <20220401141124.27272-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401141124.27272-1-ulf.hansson@linaro.org>
References: <20220401141124.27272-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When PSCI OSI mode is supported the syscore flag is set for the CPU devices
that becomes attached to their PM domains (genpds). In the suspend-to-idle
case, we call dev_pm_genpd_suspend|resume() to allow genpd to properly
manage the power-off/on operations (pick an idlestate and manage the on/off
notifications).

For suspend-to-ram, dev_pm_genpd_suspend|resume() is currently not being
called, which causes a problem that the genpd on/off notifiers do not get
sent as expected. This prevents the platform-specific operations from being
executed, typically needed just before/after the boot CPU is being turned
off/on.

To deal with this problem, let's register a syscore ops for cpuidle-psci
when PSCI OSI mode is being used and call dev_pm_genpd_suspend|resume()
from them. In this way, genpd regains control of the PM domain topology and
then sends the on/off notifications when it's appropriate.

Reported-by: Maulik Shah <quic_mkshah@quicinc.com>
Suggested-by: Maulik Shah <quic_mkshah@quicinc.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci.c | 46 ++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index b51b5df08450..540105ca0781 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -23,6 +23,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/syscore_ops.h>
 
 #include <asm/cpuidle.h>
 
@@ -131,6 +132,49 @@ static int psci_idle_cpuhp_down(unsigned int cpu)
 	return 0;
 }
 
+static void psci_idle_syscore_switch(bool suspend)
+{
+	bool cleared = false;
+	struct device *dev;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		dev = per_cpu_ptr(&psci_cpuidle_data, cpu)->dev;
+
+		if (dev && suspend) {
+			dev_pm_genpd_suspend(dev);
+		} else if (dev) {
+			dev_pm_genpd_resume(dev);
+
+			/* Account for userspace having offlined a CPU. */
+			if (pm_runtime_status_suspended(dev))
+				pm_runtime_set_active(dev);
+
+			/* Clear domain state to re-start fresh. */
+			if (!cleared) {
+				psci_set_domain_state(0);
+				cleared = true;
+			}
+		}
+	}
+}
+
+static int psci_idle_syscore_suspend(void)
+{
+	psci_idle_syscore_switch(true);
+	return 0;
+}
+
+static void psci_idle_syscore_resume(void)
+{
+	psci_idle_syscore_switch(false);
+}
+
+static struct syscore_ops psci_idle_syscore_ops = {
+	.suspend = psci_idle_syscore_suspend,
+	.resume = psci_idle_syscore_resume,
+};
+
 static void psci_idle_init_cpuhp(void)
 {
 	int err;
@@ -138,6 +182,8 @@ static void psci_idle_init_cpuhp(void)
 	if (!psci_cpuidle_use_cpuhp)
 		return;
 
+	register_syscore_ops(&psci_idle_syscore_ops);
+
 	err = cpuhp_setup_state_nocalls(CPUHP_AP_CPU_PM_STARTING,
 					"cpuidle/psci:online",
 					psci_idle_cpuhp_up,
-- 
2.25.1


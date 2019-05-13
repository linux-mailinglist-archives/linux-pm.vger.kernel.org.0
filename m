Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8511BDC5
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 21:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfEMTZP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 15:25:15 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33151 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729651AbfEMTXV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 15:23:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id x132so9958879lfd.0
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2019 12:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o5+9luZ7sCLYkQQCN67HXS68IdQpduZUcgaX5OCzqos=;
        b=FV//hyoMnEuhzttuAwy+3IjGHtAXZchGsvSZSUyMAJmSDn6Qk/tkPJX+DlL6/5jYzf
         jjMWLRDOaqPCtvzv2sKC48W9o1aofdOROz4I4viJvVGZPZnvq+pyPn3BVrwCJB/hIPhj
         xoxPevY6gXOnHpj09x2OwoTmPkocCKVcE7Z93ckD9UyadrfNo3LJ7pOTKkOK+xuf6SLV
         Afnne5GeWsYyFeQRUOEE13gZvwjrLN5xx482cgJ/AFWRxxE3zyhRueMlyLJa7HIuxd+d
         tSoTPkin1gaqwGLGobS1zs6UV3QuJLhH0X8bHUVoBjRumtVozN5vQTbZ8hJpt19iAGq+
         W/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o5+9luZ7sCLYkQQCN67HXS68IdQpduZUcgaX5OCzqos=;
        b=MP38HEFUUefBBSi5L3NnxW5WYASbOZQG7C/AL6j3RO53jclnb+WJaoQugA+TjM+h06
         qXH6SwcafO9XyJolIqNVpZfHL+mlKI+Fp6AZERZ6Xf/If8FQNS2Llf9SZnvFDyJEA/To
         MdMGShhWuButM5hflAnk3F/6gaPXzsy5qebKRvRPOaR6IboGRwthjOvyFopu7Zo8M9Tg
         3h5vHIcqIBJGRq46YDqKuKDZHqEe/wi9UtE4s/jswCnVSxCOW+CN74YKmtnYI5fsfB4G
         sb5X6jujzgB4WwQ+oY+pfKuyUZxwzIoc0mbAtvbePVE1MtLrrJ+K0r836pgax58rSwlH
         gHVA==
X-Gm-Message-State: APjAAAXQ99/fuQGC3ePKAMzu9n4WqStsi0hS86RQPtQjXnQH+85P2arP
        RD0G3A5VGudTeTOFo9G1YYuWYA==
X-Google-Smtp-Source: APXvYqw2t+LdElc4Xj4e0QzMBJlLjpK3q+ffxnx73kmsSfuwHRWHbqmUdPJVxZsVxNzXZK8vAzoQbQ==
X-Received: by 2002:a19:4a04:: with SMTP id x4mr14103234lfa.124.1557775398769;
        Mon, 13 May 2019 12:23:18 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q21sm3449365lfa.84.2019.05.13.12.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 12:23:18 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 07/18] drivers: firmware: psci: Prepare to use OS initiated suspend mode
Date:   Mon, 13 May 2019 21:22:49 +0200
Message-Id: <20190513192300.653-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513192300.653-1-ulf.hansson@linaro.org>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The per CPU variable psci_power_state, contains an array of fixed values,
which reflects the corresponding arm,psci-suspend-param parsed from DT, for
each of the available CPU idle states.

This isn't sufficient when using the hierarchical CPU topology in DT in
combination with having PSCI OS initiated (OSI) mode enabled. More
precisely, in OSI mode, Linux is responsible of telling the PSCI FW what
idle state the cluster (a group of CPUs) should enter, while in PSCI
Platform Coordinated (PC) mode, each CPU independently votes for an idle
state of the cluster.

For this reason, let's introduce an additional per CPU variable called
domain_state and implement two helper functions to read/write its values.
Following patches, which implements PM domain support for PSCI, will use
the domain_state variable and set it to corresponding bits that represents
the selected idle state for the cluster.

Finally, in psci_cpu_suspend_enter() and psci_suspend_finisher(), let's
take into account the values in the domain_state, as to get the complete
suspend parameter.

Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes:
	- Clarify changelog.
	- Drop changes in psci_cpu_on() as it belongs in the patch for hotplug.
	- Move some code inside "#ifdef CONFIG_CPU_IDLE".

---
 drivers/firmware/psci/psci.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index b11560f7c4b9..4aec513136e4 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -285,6 +285,17 @@ static int __init psci_features(u32 psci_func_id)
 
 #ifdef CONFIG_CPU_IDLE
 static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
+static DEFINE_PER_CPU(u32, domain_state);
+
+static inline u32 psci_get_domain_state(void)
+{
+	return __this_cpu_read(domain_state);
+}
+
+static inline void psci_set_domain_state(u32 state)
+{
+	__this_cpu_write(domain_state, state);
+}
 
 static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
 {
@@ -420,15 +431,17 @@ int psci_cpu_init_idle(struct cpuidle_driver *drv, unsigned int cpu)
 static int psci_suspend_finisher(unsigned long index)
 {
 	u32 *state = __this_cpu_read(psci_power_state);
+	u32 composite_state = state[index - 1] | psci_get_domain_state();
 
-	return psci_ops.cpu_suspend(state[index - 1],
-				    __pa_symbol(cpu_resume));
+	return psci_ops.cpu_suspend(composite_state, __pa_symbol(cpu_resume));
 }
 
 int psci_cpu_suspend_enter(unsigned long index)
 {
 	int ret;
 	u32 *state = __this_cpu_read(psci_power_state);
+	u32 composite_state = state[index - 1] | psci_get_domain_state();
+
 	/*
 	 * idle state index 0 corresponds to wfi, should never be called
 	 * from the cpu_suspend operations
@@ -436,11 +449,14 @@ int psci_cpu_suspend_enter(unsigned long index)
 	if (WARN_ON_ONCE(!index))
 		return -EINVAL;
 
-	if (!psci_power_state_loses_context(state[index - 1]))
-		ret = psci_ops.cpu_suspend(state[index - 1], 0);
+	if (!psci_power_state_loses_context(composite_state))
+		ret = psci_ops.cpu_suspend(composite_state, 0);
 	else
 		ret = cpu_suspend(index, psci_suspend_finisher);
 
+	/* Clear the domain state to start fresh when back from idle. */
+	psci_set_domain_state(0);
+
 	return ret;
 }
 
-- 
2.17.1


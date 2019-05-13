Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 593821BDF0
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 21:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfEMTaF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 15:30:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39841 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfEMTaE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 15:30:04 -0400
Received: by mail-lj1-f194.google.com with SMTP id a10so4114846ljf.6
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2019 12:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7mMRJh0gRWk8jRKSu7vpJTGJ6ww/FK+bFoVvoMzjgck=;
        b=A5Wrb60xziILjw5xMgQgTTamMl9xJY2MhOSpDPLTAf/3EQCP+lf+7yig/Ph/N48Hs+
         5eISRFo4PakItBUPivivio9sRWxxOcKf9wZko/ylG4GFm+PHhBbtsOQFhs6a2EYmk6cf
         d08V0bhI77Ip2AT10wAzzGYunJYYv1Xq6bLSZK+0AvF8kKHSnNeeoT7ASAv0aJjZ/uXa
         pAh3Vd1UJMx+yB0pcoGTGuiTiECq7yRcyQftboHCRgguQn1fjPxSH/PuwhRrzWxMWrOP
         vkkAGabM1BZQ68YI0gr+vhbHfVr1udpWSAPl8raFY3py7bW24MK4MzWkC91WgHCON7Du
         frtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7mMRJh0gRWk8jRKSu7vpJTGJ6ww/FK+bFoVvoMzjgck=;
        b=gQhVeZlpkQ6/ut+c2ci4l7FtF1kMtjtRyCJE36HHEAk+P2VzNjNXormR7smcj9wDER
         SAKFGKpmk8ok2KMcSbIGhtvmy/TjIUNyEJ/qErfxy8+XxYZZ+NwaTNzIc7+kmPpzAGcc
         l1xfwjd5Vhx6VLYpyfDw2+rmrHNUCIxCZcSpfQZTft1U0UbaGhQYZuiaEtvjEK+tXWQW
         WPRmTXSeSO7u8GIJUpgWMV6VrNo4HfgowXtVhz6FLyMqMPpPYwKnpBa23MF0KW/kcJ+R
         K4YUNKyXO6/FV/yXbOi7eqJ++YBGLNAAu/ND1Hh2zMpB/q7VmkJ2Q77ofUwSTUsOrMou
         MDRA==
X-Gm-Message-State: APjAAAUETz7wGwmYBAg64Pz/Dnc7Dcd5nZZYKNudDaN/FOl47RhlV5tx
        NmyNy91fVsBwVjBtiUc2nuukjw==
X-Google-Smtp-Source: APXvYqxf9UXPo2PbATF2Ej4O/JEKsCNTcYfsKPhGKIQE6BXSznQnuXwlAcye5xuHinSMJfMHW3VIvg==
X-Received: by 2002:a2e:8954:: with SMTP id b20mr4530759ljk.10.1557775409921;
        Mon, 13 May 2019 12:23:29 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q21sm3449365lfa.84.2019.05.13.12.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 12:23:29 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 13/18] drivers: firmware: psci: Attach the CPU's device to its PM domain
Date:   Mon, 13 May 2019 21:22:55 +0200
Message-Id: <20190513192300.653-14-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513192300.653-1-ulf.hansson@linaro.org>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to allow the CPU to be power managed through a potential PM domain
and the corresponding topology, it needs to be attached to it. For that
reason, check if the PM domain data structures have been initiated for PSCI
and if so, let's try to attach the CPU device to its PM domain.

However, before attaching the CPU to its PM domain, we need to check
whether the PSCI firmware supports OS initiated mode or not. If that isn't
the case, we rely solely on the cpuidle framework to deal with the idle
state selection, which means we need to parse DT and convert the
hierarchical described domain idle states into regular cpuidle states,
hence let's do that.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes:
	- Adapt to updated psci_dt_attach_cpu() helper, as it now returns a
	  struct device * instead of an int.
	- Create a per CPU struct, to store the relevant PSCI cpuidle data.

---
 drivers/firmware/psci/psci.c | 46 +++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 28745234b53f..54e23d4ed0ea 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -295,7 +295,13 @@ static int __init psci_features(u32 psci_func_id)
 }
 
 #ifdef CONFIG_CPU_IDLE
-static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
+
+struct psci_cpuidle_data {
+	u32 *psci_states;
+	struct device *dev;
+};
+
+static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
 static DEFINE_PER_CPU(u32, domain_state);
 static bool psci_dt_topology;
 
@@ -332,8 +338,9 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 	int i, ret = 0, num_state_nodes = drv->state_count - 1;
 	u32 *psci_states;
 	struct device_node *state_node;
+	struct psci_cpuidle_data *data = per_cpu_ptr(&psci_cpuidle_data, cpu);
 
-	psci_states = kcalloc(num_state_nodes, sizeof(*psci_states),
+	psci_states = kcalloc(CPUIDLE_STATE_MAX, sizeof(*psci_states),
 			GFP_KERNEL);
 	if (!psci_states)
 		return -ENOMEM;
@@ -357,8 +364,31 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 		goto free_mem;
 	}
 
-	/* Idle states parsed correctly, initialize per-cpu pointer */
-	per_cpu(psci_power_state, cpu) = psci_states;
+	/*
+	 * If the hierarchical CPU topology is used, let's attach the CPU device
+	 * to its corresponding PM domain. If OSI mode isn't supported, convert
+	 * the additional domain idle states from the hierarchical DT layout
+	 * into regular flattened cpuidle states, as to let cpuidle manage them.
+	 */
+	if (psci_dt_topology) {
+		struct device *dev;
+
+		if (!psci_has_osi_support()) {
+			ret = psci_dt_pm_domains_parse_states(drv, cpu_node,
+							      psci_states);
+			if (ret)
+				goto free_mem;
+		}
+
+		dev = psci_dt_attach_cpu(cpu);
+		if (IS_ERR_OR_NULL(dev))
+			goto free_mem;
+
+		data->dev = dev;
+	}
+
+	/* Idle states parsed correctly, store them in the per-cpu struct. */
+	data->psci_states = psci_states;
 	return 0;
 
 free_mem:
@@ -403,8 +433,8 @@ static int __maybe_unused psci_acpi_cpu_init_idle(unsigned int cpu)
 		}
 		psci_states[i] = state;
 	}
-	/* Idle states parsed correctly, initialize per-cpu pointer */
-	per_cpu(psci_power_state, cpu) = psci_states;
+	/* Idle states parsed correctly, store them in the per-cpu struct. */
+	per_cpu(psci_cpuidle_data.psci_states, cpu) = psci_states;
 	return 0;
 }
 #else
@@ -442,7 +472,7 @@ int psci_cpu_init_idle(struct cpuidle_driver *drv, unsigned int cpu)
 
 static int psci_suspend_finisher(unsigned long index)
 {
-	u32 *state = __this_cpu_read(psci_power_state);
+	u32 *state = __this_cpu_read(psci_cpuidle_data.psci_states);
 	u32 composite_state = state[index - 1] | psci_get_domain_state();
 
 	return psci_ops.cpu_suspend(composite_state, __pa_symbol(cpu_resume));
@@ -451,7 +481,7 @@ static int psci_suspend_finisher(unsigned long index)
 int psci_cpu_suspend_enter(unsigned long index)
 {
 	int ret;
-	u32 *state = __this_cpu_read(psci_power_state);
+	u32 *state = __this_cpu_read(psci_cpuidle_data.psci_states);
 	u32 composite_state = state[index - 1] | psci_get_domain_state();
 
 	/*
-- 
2.17.1


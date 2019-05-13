Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD661BDFE
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 21:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfEMTa6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 15:30:58 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40399 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbfEMTa5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 15:30:57 -0400
Received: by mail-lj1-f194.google.com with SMTP id d15so12082247ljc.7
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2019 12:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Bq5498AOcSF9nWVNbhGQT9xwPiaFsmcqnV/fxv1rlk=;
        b=W4GhQnl8ZsdBUVqc7l5KLussGmwg71kqOstSI+0Ph1Lr8vtPu9C8+icwujP0k7qwj9
         5TvlopE+qiKZV7fIhJrr2LcsOWK4knRqcbjI3G606AbC5uurrDPc2GBqBm2Z8X7wFqcb
         xuy2+GAFpVZPm3a4PgV1+kuQcOFBsu5X8EQf3CLRm/NY65JX12Jphpgy0BQ+ErCA8MCX
         XsgxxvmN9Z8ltKyBNnDzlSHpbzkBWLl35VLjd/y7Rf4k97Vd2ckc3dCg4vydyK0sZ/nj
         C2KJHlpK/BuH7Z72z3Gs9vGq81hQW/3d8xcMAg7uKl8L8MYlYOGjQS9YqTX6hTirdBD6
         +zBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Bq5498AOcSF9nWVNbhGQT9xwPiaFsmcqnV/fxv1rlk=;
        b=AwQcOMG9pIjWeKmw/VPeS7TxdB2+CzjEKtevsSE4tT1D3atNkO8Y4PjjYWhXlhr13z
         S2KjiAnbJPi4s9j8rwtzWuVpzCqcMZJpge1kiYFXzFUVg9aAyh3uev0h9fy8brCCdUUB
         9A/qZ1Eefi0G2o6kx0dpEnBhzXYft5mWyLBGarem64YN8EFrsI//BIsNsp9BHv86RUr9
         XX7rwc1GWZrSEzr1ev1Ya2hjb58vnZEZzYRhfq/JrafHd8bOg9h+hLquGfQqr1rAJTdP
         vgLMacUL9feNUE9oBK9CQ9D3YeUKnzj+Tb/+Vnbuz4Ud0vfyEbh/M4joJmvqYe7JTZul
         xyeQ==
X-Gm-Message-State: APjAAAVhVtZNdYrc4pYKv/wmnP9/XAytiv5c7s2eRM3TUP+8CyeEq3Zn
        1IYEyEsR6OMcndRi6j0gNJmJYQ==
X-Google-Smtp-Source: APXvYqw7+OiJXxfFee31pCrymAeYS08U5pee+00MkBLRYZuV1nu61St5Md6HOWASXzRRprmmKqAw5g==
X-Received: by 2002:a2e:92ce:: with SMTP id k14mr14559128ljh.83.1557775402543;
        Mon, 13 May 2019 12:23:22 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q21sm3449365lfa.84.2019.05.13.12.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 12:23:21 -0700 (PDT)
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
Subject: [PATCH 09/18] drivers: firmware: psci: Add support for PM domains using genpd
Date:   Mon, 13 May 2019 21:22:51 +0200
Message-Id: <20190513192300.653-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513192300.653-1-ulf.hansson@linaro.org>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When the hierarchical CPU topology layout is used in DT, we need to setup
the corresponding PM domain data structures, as to allow a CPU and a group
of CPUs to be power managed accordingly. Let's enable this by deploying
support through the genpd interface.

Additionally, when the OS initiated mode is supported by the PSCI FW, let's
also parse the domain idle states DT bindings as to make genpd responsible
for the state selection, when the states are compatible with
"domain-idle-state". Otherwise, when only Platform Coordinated mode is
supported, we rely solely on the state selection to be managed through the
regular cpuidle framework.

If the initialization of the PM domain data structures succeeds and the OS
initiated mode is supported, we try to switch to it. In case it fails,
let's fall back into a degraded mode, rather than bailing out and returning
an error code.

Due to that the OS initiated mode may become enabled, we need to adjust to
maintain backwards compatibility for a kernel started through a kexec call.
Do this by explicitly switch to Platform Coordinated mode during boot.

Finally, the actual initialization of the PM domain data structures, is
done via calling the new shared function, psci_dt_init_pm_domains().
However, this is implemented by subsequent changes.

Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes:
	- Simplify code setting domain_state at power off.
	- Use the genpd ->free_state() callback to manage freeing of states.
	- Fixup a bogus while loop.

---
 drivers/firmware/psci/Makefile         |   2 +-
 drivers/firmware/psci/psci.c           |   7 +-
 drivers/firmware/psci/psci.h           |   5 +
 drivers/firmware/psci/psci_pm_domain.c | 268 +++++++++++++++++++++++++
 4 files changed, 280 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/psci/psci_pm_domain.c

diff --git a/drivers/firmware/psci/Makefile b/drivers/firmware/psci/Makefile
index 1956b882470f..ff300f1fec86 100644
--- a/drivers/firmware/psci/Makefile
+++ b/drivers/firmware/psci/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
+obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o psci_pm_domain.o
 obj-$(CONFIG_ARM_PSCI_CHECKER)	+= psci_checker.o
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 0e91d864e346..bfef300b7ebe 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -721,9 +721,14 @@ static int __init psci_1_0_init(struct device_node *np)
 	if (err)
 		return err;
 
-	if (psci_has_osi_support())
+	if (psci_has_osi_support()) {
 		pr_info("OSI mode supported.\n");
 
+		/* Make sure we default to PC mode. */
+		invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE,
+			       PSCI_1_0_SUSPEND_MODE_PC, 0, 0);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
index f2277c3ad405..00d2e3dcef49 100644
--- a/drivers/firmware/psci/psci.h
+++ b/drivers/firmware/psci/psci.h
@@ -11,6 +11,11 @@ bool psci_has_osi_support(void);
 #ifdef CONFIG_CPU_IDLE
 void psci_set_domain_state(u32 state);
 int psci_dt_parse_state_node(struct device_node *np, u32 *state);
+#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
+int psci_dt_init_pm_domains(struct device_node *np);
+#else
+static inline int psci_dt_init_pm_domains(struct device_node *np) { return 0; }
+#endif
 #endif
 
 #endif /* __PSCI_H */
diff --git a/drivers/firmware/psci/psci_pm_domain.c b/drivers/firmware/psci/psci_pm_domain.c
new file mode 100644
index 000000000000..3c6ca846caf4
--- /dev/null
+++ b/drivers/firmware/psci/psci_pm_domain.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PM domains for CPUs via genpd - managed by PSCI.
+ *
+ * Copyright (C) 2019 Linaro Ltd.
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ *
+ */
+
+#define pr_fmt(fmt) "psci: " fmt
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/pm_domain.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "psci.h"
+
+#if defined(CONFIG_CPU_IDLE) && defined(CONFIG_PM_GENERIC_DOMAINS_OF)
+
+struct psci_pd_provider {
+	struct list_head link;
+	struct device_node *node;
+};
+
+static LIST_HEAD(psci_pd_providers);
+static bool osi_mode_enabled;
+
+static int psci_pd_power_off(struct generic_pm_domain *pd)
+{
+	struct genpd_power_state *state = &pd->states[pd->state_idx];
+	u32 *pd_state;
+
+	/* If we have failed to enable OSI mode, then abort power off. */
+	if (psci_has_osi_support() && !osi_mode_enabled)
+		return -EBUSY;
+
+	if (!state->data)
+		return 0;
+
+	/* When OSI mode is enabled, set the corresponding domain state. */
+	pd_state = state->data;
+	psci_set_domain_state(*pd_state);
+
+	return 0;
+}
+
+static int psci_pd_parse_state_nodes(struct genpd_power_state *states,
+				int state_count)
+{
+	int i, ret;
+	u32 psci_state, *psci_state_buf;
+
+	for (i = 0; i < state_count; i++) {
+		ret = psci_dt_parse_state_node(to_of_node(states[i].fwnode),
+					&psci_state);
+		if (ret)
+			goto free_state;
+
+		psci_state_buf = kmalloc(sizeof(u32), GFP_KERNEL);
+		if (!psci_state_buf) {
+			ret = -ENOMEM;
+			goto free_state;
+		}
+		*psci_state_buf = psci_state;
+		states[i].data = psci_state_buf;
+	}
+
+	return 0;
+
+free_state:
+	i--;
+	for (; i >= 0; i--)
+		kfree(states[i].data);
+	return ret;
+}
+
+static int psci_pd_parse_states(struct device_node *np,
+			struct genpd_power_state **states, int *state_count)
+{
+	int ret;
+
+	/* Parse the domain idle states. */
+	ret = of_genpd_parse_idle_states(np, states, state_count);
+	if (ret)
+		return ret;
+
+	/* Fill out the PSCI specifics for each found state. */
+	ret = psci_pd_parse_state_nodes(*states, *state_count);
+	if (ret)
+		kfree(*states);
+
+	return ret;
+}
+
+static void psci_pd_free_states(struct genpd_power_state *states,
+				unsigned int state_count)
+{
+	int i;
+
+	for (i = 0; i < state_count; i++)
+		kfree(states[i].data);
+	kfree(states);
+}
+
+static int psci_pd_init(struct device_node *np)
+{
+	struct generic_pm_domain *pd;
+	struct psci_pd_provider *pd_provider;
+	struct dev_power_governor *pd_gov;
+	struct genpd_power_state *states = NULL;
+	int ret = -ENOMEM, state_count = 0;
+
+	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		goto out;
+
+	pd_provider = kzalloc(sizeof(*pd_provider), GFP_KERNEL);
+	if (!pd_provider)
+		goto free_pd;
+
+	pd->name = kasprintf(GFP_KERNEL, "%pOF", np);
+	if (!pd->name)
+		goto free_pd_prov;
+
+	/*
+	 * For OSI mode, parse the domain idle states and let genpd manage the
+	 * state selection for those being compatible with "domain-idle-state".
+	 */
+	if (psci_has_osi_support()) {
+		ret = psci_pd_parse_states(np, &states, &state_count);
+		if (ret)
+			goto free_name;
+		pd->free_states = psci_pd_free_states;
+	}
+
+	pd->name = kbasename(pd->name);
+	pd->power_off = psci_pd_power_off;
+	pd->states = states;
+	pd->state_count = state_count;
+	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
+
+	/* Use governor for CPU PM domains if it has some states to manage. */
+	pd_gov = state_count > 0 ? &pm_domain_cpu_gov : NULL;
+
+	ret = pm_genpd_init(pd, pd_gov, false);
+	if (ret) {
+		psci_pd_free_states(states, state_count);
+		goto free_name;
+	}
+
+	ret = of_genpd_add_provider_simple(np, pd);
+	if (ret)
+		goto remove_pd;
+
+	pd_provider->node = of_node_get(np);
+	list_add(&pd_provider->link, &psci_pd_providers);
+
+	pr_debug("init PM domain %s\n", pd->name);
+	return 0;
+
+remove_pd:
+	pm_genpd_remove(pd);
+free_name:
+	kfree(pd->name);
+free_pd_prov:
+	kfree(pd_provider);
+free_pd:
+	kfree(pd);
+out:
+	pr_err("failed to init PM domain ret=%d %pOF\n", ret, np);
+	return ret;
+}
+
+static void psci_pd_remove(void)
+{
+	struct psci_pd_provider *pd_provider, *it;
+	struct generic_pm_domain *genpd;
+
+	list_for_each_entry_safe(pd_provider, it, &psci_pd_providers, link) {
+		of_genpd_del_provider(pd_provider->node);
+
+		genpd = of_genpd_remove_last(pd_provider->node);
+		if (!IS_ERR(genpd))
+			kfree(genpd);
+
+		of_node_put(pd_provider->node);
+		list_del(&pd_provider->link);
+		kfree(pd_provider);
+	}
+}
+
+static int psci_pd_init_topology(struct device_node *np)
+{
+	struct device_node *node;
+	struct of_phandle_args child, parent;
+	int ret;
+
+	for_each_child_of_node(np, node) {
+		if (of_parse_phandle_with_args(node, "power-domains",
+					"#power-domain-cells", 0, &parent))
+			continue;
+
+		child.np = node;
+		child.args_count = 0;
+
+		ret = of_genpd_add_subdomain(&parent, &child);
+		of_node_put(parent.np);
+		if (ret) {
+			of_node_put(node);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+int psci_dt_init_pm_domains(struct device_node *np)
+{
+	struct device_node *node;
+	int ret, pd_count = 0;
+
+	/*
+	 * Parse child nodes for the "#power-domain-cells" property and
+	 * initialize a genpd/genpd-of-provider pair when it's found.
+	 */
+	for_each_child_of_node(np, node) {
+		if (!of_find_property(node, "#power-domain-cells", NULL))
+			continue;
+
+		ret = psci_pd_init(node);
+		if (ret)
+			goto put_node;
+
+		pd_count++;
+	}
+
+	/* Bail out if not using the hierarchical CPU topology. */
+	if (!pd_count)
+		return 0;
+
+	/* Link genpd masters/subdomains to model the CPU topology. */
+	ret = psci_pd_init_topology(np);
+	if (ret)
+		goto remove_pd;
+
+	/* Try to enable OSI mode if supported. */
+	if (psci_has_osi_support()) {
+		ret = psci_set_osi_mode();
+		if (ret)
+			pr_warn("failed to enable OSI mode: %d\n", ret);
+		else
+			osi_mode_enabled = true;
+	}
+
+	pr_info("Initialized CPU PM domain topology\n");
+	return pd_count;
+
+put_node:
+	of_node_put(node);
+remove_pd:
+	if (pd_count)
+		psci_pd_remove();
+	pr_err("failed to create CPU PM domains ret=%d\n", ret);
+	return ret;
+}
+#endif
-- 
2.17.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E359D282A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 13:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbfJJLkX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 07:40:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46219 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732863AbfJJLkX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 07:40:23 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so4087880lfc.13
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2019 04:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2v9/BZjYcJIdE6oCC/CcRM0giFXsQcqyknGG6jsekOw=;
        b=pmkfwxkafYHpSiVu7Ke8qyTAai9lSVf06gP+DuoqVBCdmPXeDGwnD865H9L/eBz4ph
         Mc9ompj19KSeeGD0zY0gJs9/1NRziZ4G6M4cVNufONzPB091FVd+9U8bfrnXLjJGKtE9
         pAQYezMrOQdjnwzzgKZmW5HKmYTuct69TUSjXw6+GrU/YHAfNCanJ6BDM38VmVxYsNbc
         cbh97OXyVvfcM6T5W7OaMF45PzJqZu++xoLU4W8ssiLmHyCzUXnjiE8RbIu+qjux57Tp
         ojfn/CavWRGpl+nUU0gmPejv7qQMlHjHX1NTievqsgP/5MBWzAGS8nANRqEZI38DpQ9t
         FjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2v9/BZjYcJIdE6oCC/CcRM0giFXsQcqyknGG6jsekOw=;
        b=DMf77cSb2PjCHyeSI5TLhwDnAJG/z4ZPSf2xnzsFFuvf1VrjbYRcmtms7a5QhCmMxb
         vmA9BDbC3OSbJl9hbYF2Z+Y3qWV5Y9qFTFh2iqeJ11DkFFy0YstSvZx62wSAmtlBUoQS
         R7p5PQeV9kEYEcSHVT+3MXhU2a/9xI2b9hCAZYJE+QMPRi/VSptufz5L03+94Gcw+JiF
         V2QIm3zfX6rwMGy31buXYda7V2zi2hXhF6GMIm7yIRbAlldUhfPEscNrO0hF7Ybng5YQ
         xYugbyrXphtDdMttOociRoFRvKuRWGUqM96QlGXlJcgvtcO+/5Lp25X4bWWm4YK0Nq0b
         A3Eg==
X-Gm-Message-State: APjAAAUQl0HTku91UmN+q341N0/HqU8I/k9Sd1Eeonl7hWvZB5IwUSxT
        d0E6q0S3YXbIwa4pd2133DiUdQ==
X-Google-Smtp-Source: APXvYqx1mFKVFqlLoIdvx8IvMJJulifnGJ7CfjYgTVgfhhrbHW5f47BT8zn+1dU3qSnhC5ZTUi5f1Q==
X-Received: by 2002:a19:c392:: with SMTP id t140mr5888002lff.156.1570707619664;
        Thu, 10 Oct 2019 04:40:19 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id p3sm1168937ljn.78.2019.10.10.04.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 04:40:19 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 09/13] cpuidle: psci: Add support for PM domains by using genpd
Date:   Thu, 10 Oct 2019 13:39:33 +0200
Message-Id: <20191010113937.15962-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010113937.15962-1-ulf.hansson@linaro.org>
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When the hierarchical CPU topology layout is used in DT and the PSCI OSI
mode is supported by the PSCI FW, let's initialize a corresponding PM
domain topology by using genpd. This enables a CPU and a group of CPUs,
when attached to the topology, to be power-managed accordingly.

To trigger the attempt to initialize the genpd data structures a
subsys_initcall is used, which should be early enough to allow CPUs, but
also other devices to be attached.

The initialization consists of parsing the PSCI OF node for the topology
and the "domain idle states" DT bindings. In case the idle states are
compatible with "domain-idle-state", the initialized genpd becomes
responsible of selecting an idle state for the PM domain, via assigning it
genpd governor.

Note that, a successful initialization of the genpd data structures, is
followed by a call to psci_set_osi_mode(), as to try to enable the OSI mode
in the PSCI FW. In case this fails, we fall back into a degraded mode
rather than bailing out and returning an error code.

Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/Makefile              |   4 +-
 drivers/cpuidle/cpuidle-psci-domain.c | 281 ++++++++++++++++++++++++++
 2 files changed, 284 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cpuidle/cpuidle-psci-domain.c

diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index ee70d5cc5b99..cc8c769d7fa9 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -21,7 +21,9 @@ obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
 obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
 obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
 obj-$(CONFIG_ARM_CPUIDLE)		+= cpuidle-arm.o
-obj-$(CONFIG_ARM_PSCI_CPUIDLE)		+= cpuidle-psci.o
+obj-$(CONFIG_ARM_PSCI_CPUIDLE)		+= cpuidle_psci.o
+cpuidle_psci-y				:= cpuidle-psci.o
+cpuidle_psci-$(CONFIG_PM_GENERIC_DOMAINS_OF) += cpuidle-psci-domain.o
 
 ###############################################################################
 # MIPS drivers
diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
new file mode 100644
index 000000000000..3f5143ccc3e0
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PM domains for CPUs via genpd - managed by cpuidle-psci.
+ *
+ * Copyright (C) 2019 Linaro Ltd.
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ *
+ */
+
+#define pr_fmt(fmt) "CPUidle PSCI: " fmt
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/pm_domain.h>
+#include <linux/psci.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "cpuidle-psci.h"
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
+	if (!osi_mode_enabled)
+		return -EBUSY;
+
+	if (!state->data)
+		return 0;
+
+	/* OSI mode is enabled, set the corresponding domain state. */
+	pd_state = state->data;
+	psci_set_domain_state(*pd_state);
+
+	return 0;
+}
+
+static int __init psci_pd_parse_state_nodes(struct genpd_power_state *states,
+					int state_count)
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
+static int __init psci_pd_parse_states(struct device_node *np,
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
+static int __init psci_pd_init(struct device_node *np)
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
+	 * Parse the domain idle states and let genpd manage the state selection
+	 * for those being compatible with "domain-idle-state".
+	 */
+	ret = psci_pd_parse_states(np, &states, &state_count);
+	if (ret)
+		goto free_name;
+
+	pd->free_states = psci_pd_free_states;
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
+static void __init psci_pd_remove(void)
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
+static int __init psci_pd_init_topology(struct device_node *np)
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
+static const struct of_device_id psci_of_match[] __initconst = {
+	{ .compatible = "arm,psci" },
+	{ .compatible = "arm,psci-0.2" },
+	{ .compatible = "arm,psci-1.0" },
+	{}
+};
+
+static int __init psci_idle_init_domains(void)
+{
+	struct device_node *np = of_find_matching_node(NULL, psci_of_match);
+	struct device_node *node;
+	int ret = 0, pd_count = 0;
+
+	if (!np)
+		return -ENODEV;
+
+	/* Currently limit the hierarchical topology to be used in OSI mode. */
+	if (!psci_has_osi_support())
+		goto out;
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
+		goto out;
+
+	/* Link genpd masters/subdomains to model the CPU topology. */
+	ret = psci_pd_init_topology(np);
+	if (ret)
+		goto remove_pd;
+
+	/* Try to enable OSI mode. */
+	ret = psci_set_osi_mode();
+	if (ret)
+		pr_warn("failed to enable OSI mode: %d\n", ret);
+	else
+		osi_mode_enabled = true;
+
+	of_node_put(np);
+	pr_info("Initialized CPU PM domain topology\n");
+	return pd_count;
+
+put_node:
+	of_node_put(node);
+remove_pd:
+	if (pd_count)
+		psci_pd_remove();
+	pr_err("failed to create CPU PM domains ret=%d\n", ret);
+out:
+	of_node_put(np);
+	return ret;
+}
+subsys_initcall(psci_idle_init_domains);
-- 
2.17.1


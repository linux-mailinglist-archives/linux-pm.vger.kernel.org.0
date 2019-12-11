Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B84B11B3A8
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 16:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388358AbfLKPoA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 10:44:00 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37095 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387474AbfLKPoA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 10:44:00 -0500
Received: by mail-lf1-f68.google.com with SMTP id b15so17063791lfc.4
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2019 07:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ofbrgz68OSPrbND6/WhbxfBKi0bLlwB+/hz0+n8YJzw=;
        b=KVepL9vstN03XHppcxydjSKRLkFgwNOhFqMhTEnVlF1MReXK/9bNoLInJ8YP4E/Oja
         ZsW6VRW6o1OTBRvvY3Pk+F5pawI/QV//nAh+XSUsYvZyyHcT4x89o5sJIBMcUQRb2GmY
         q3FFC/XGyS6X8bjQylLBcBwEoXtkItkLrJCdTELVIh9uptrXS8Y6bz7BCWQUJCiWuS9+
         0HnCy/45OUr7AwyD/twItRhW6qCTqBU1ffy810aL/t37q+e8zskOr9aZG8I/TMXTfhT0
         IgHIUiScQLkUlvprt8NBTDMSwKQ0ZagBxHs/8xctCRVLEI7+GdKbAawY6YKngYrmAxEc
         zIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ofbrgz68OSPrbND6/WhbxfBKi0bLlwB+/hz0+n8YJzw=;
        b=KgQW4qtWKm0nmrcPtHn2hAxCpMJovkaYUiG/g6mM6dsLRSHr0TnRYK1heIuGl8Jn/W
         t3rWFxcbahyP2odRdsS7ovRnpvjyRfSzHJqzR7qKcOvbRNGicy3ZElNzyULewj7bhncV
         mmuGP0ttNHV1JI+aEifVxXdQXb1Abov7rqoF37s12n98bE+ZvW3yqeLhiNhY6FaHGvW8
         g2oaxB1awPGxlS6pvstW1zhalaR5YiPCpT5ezDfaog7Xs+J3ZZ2TUfDWCVBZxMjNZ1fH
         M146YbuivusFxZK5zdEYTB71hG1TlKl5bDOvbVIsngpyGGIu21J7tJANZV5l3Nk1kLKK
         OuJw==
X-Gm-Message-State: APjAAAW5b0oZnNzqiEhOHzvUVjSrXfd8FPjn2ByBIVPNpGbi8D1y+MBZ
        T7RA2bv6kYpqDdhT5QqkzWvTWA==
X-Google-Smtp-Source: APXvYqz89XHVxkLmuyY/NWdcwtGhitRaQeBPBPqirkbVbNQySVcoy9ANADV7MYrC0JZJfJfwa4yKGw==
X-Received: by 2002:a05:6512:21d:: with SMTP id a29mr2713494lfo.186.1576079037661;
        Wed, 11 Dec 2019 07:43:57 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b14sm1389608lff.68.2019.12.11.07.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:43:57 -0800 (PST)
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
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v4 04/14] of: base: Add of_get_cpu_state_node() to get idle states for a CPU node
Date:   Wed, 11 Dec 2019 16:43:33 +0100
Message-Id: <20191211154343.29765-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211154343.29765-1-ulf.hansson@linaro.org>
References: <20191211154343.29765-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The CPU's idle state nodes are currently parsed at the common cpuidle DT
library, but also when initializing data for specific CPU idle operations,
as in the PSCI cpuidle driver case and qcom-spm cpuidle case.

To avoid open-coding, let's introduce of_get_cpu_state_node(), which takes
the device node for the CPU and the index to the requested idle state node,
as in-parameters. In case a corresponding idle state node is found, it
returns the node with the refcount incremented for it, else it returns
NULL.

Moreover, for PSCI there are two options to describe the CPU's idle states
[1], either via a flattened description or a hierarchical layout. Hence,
let's take both options into account.

[1] Documentation/devicetree/bindings/arm/psci.yaml

Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---

Changes in v4:
	- None.

---
 drivers/of/base.c  | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/of.h |  8 ++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index db7fbc0c0893..614f0c674995 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -489,6 +489,42 @@ int of_cpu_node_to_id(struct device_node *cpu_node)
 }
 EXPORT_SYMBOL(of_cpu_node_to_id);
 
+/**
+ * of_get_cpu_state_node - Get CPU's idle state node at the given index
+ *
+ * @cpu_node: The device node for the CPU
+ * @index: The index in the list of the idle states
+ *
+ * Two generic methods can be used to describe a CPU's idle states, either via
+ * a flattened description through the "cpu-idle-states" binding or via the
+ * hierarchical layout, using the "power-domains" and the "domain-idle-states"
+ * bindings. This function check for both and returns the idle state node for
+ * the requested index.
+ *
+ * In case an idle state node is found at @index, the refcount is incremented
+ * for it, so call of_node_put() on it when done. Returns NULL if not found.
+ */
+struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
+					  int index)
+{
+	struct of_phandle_args args;
+	int err;
+
+	err = of_parse_phandle_with_args(cpu_node, "power-domains",
+					"#power-domain-cells", 0, &args);
+	if (!err) {
+		struct device_node *state_node =
+			of_parse_phandle(args.np, "domain-idle-states", index);
+
+		of_node_put(args.np);
+		if (state_node)
+			return state_node;
+	}
+
+	return of_parse_phandle(cpu_node, "cpu-idle-states", index);
+}
+EXPORT_SYMBOL(of_get_cpu_state_node);
+
 /**
  * __of_device_is_compatible() - Check if the node matches given constraints
  * @device: pointer to node
diff --git a/include/linux/of.h b/include/linux/of.h
index 844f89e1b039..c669c0a4732f 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -351,6 +351,8 @@ extern const void *of_get_property(const struct device_node *node,
 				int *lenp);
 extern struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
 extern struct device_node *of_get_next_cpu_node(struct device_node *prev);
+extern struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
+						 int index);
 
 #define for_each_property_of_node(dn, pp) \
 	for (pp = dn->properties; pp != NULL; pp = pp->next)
@@ -765,6 +767,12 @@ static inline struct device_node *of_get_next_cpu_node(struct device_node *prev)
 	return NULL;
 }
 
+static inline struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
+					int index)
+{
+	return NULL;
+}
+
 static inline int of_n_addr_cells(struct device_node *np)
 {
 	return 0;
-- 
2.17.1


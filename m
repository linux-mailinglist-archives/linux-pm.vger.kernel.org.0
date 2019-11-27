Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEFAD10ADA0
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 11:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfK0K31 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 05:29:27 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36732 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfK0K30 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 05:29:26 -0500
Received: by mail-lj1-f195.google.com with SMTP id k15so23869241lja.3
        for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2019 02:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hR3fATInnhJT0Il8OsjH3yU7lJcZN7xcMci8RIbbM2k=;
        b=hV6JyPoeJ6ScqrZKdsERvcTAjECHZPKrEpiECJjJ2opXh0u63rwgTFmXVvsdu2X0H5
         ICa9gP/wcirISvdKCLUGE/oSc075kXCJPeVFk1ObygGjfw01gIFsrcO6TnfrHFBHoWH7
         DKuK5ax/e4uTVk6L9WIaN3h5ifumDU4XlNesZNqqm8c8D/7Me9f0kHQCaK+30B43RfwD
         gfKgt3Uwxz1lWHtEj3Hpt//hH10XK3vYERtLGm136PpCMUIvS22JkORRZXKwpoE7WT6X
         AR7s38eXNR6p/BkAh2p5qx4ND2GJqCjIu427zkHIbuXE71HMxpb5zXF0EbXTFojvke0C
         GOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hR3fATInnhJT0Il8OsjH3yU7lJcZN7xcMci8RIbbM2k=;
        b=jPMSOqBATmcMGL1ZH9dyO6kOZqRbL6NQwxQ5fd6iVh71qXxGIW70ho7zn5kkMNqH75
         FfjmuyNFSVFVo3SBUoIFjw6fITyFyMhOwqmZacTutQNYo5nSjWsWXyineejIbbueNW+n
         ArtlJd9sh6LBfLvBVXyWyFM1liL12raS8VETCOWlqqMghbVORg7fJJDgl6WaH9h054zI
         hpzQcW/vdswhCjKSLopAE3a4UnwmXgeii0eYVRmg49ciH6u8h2aZkl73KFxg+JO/8YHV
         uJ0ItvkI4ZcJFpQlKrCJHDDHjeGhmw7Fqnp/nQYPbY8gKXA84QC6VcZipfgq1ScWeIhh
         aBqw==
X-Gm-Message-State: APjAAAUU/mTn31eUAW0aBy15MRRcihzEAxupCImbHgy3VBFDc0V9NNj9
        UNgRMNWsD/eK7uO3Tf23K87XmA==
X-Google-Smtp-Source: APXvYqwCBgszickFdMaiVIID+IrQo2mOi4OX8ab6dEe54mVNp2DqUjt/6Yig54hA/QaPvMO1ZC4nzA==
X-Received: by 2002:a2e:6c0c:: with SMTP id h12mr30985887ljc.24.1574850564180;
        Wed, 27 Nov 2019 02:29:24 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id t9sm6868260ljj.19.2019.11.27.02.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 02:29:23 -0800 (PST)
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
Subject: [PATCH v3 04/13] of: base: Add of_get_cpu_state_node() to get idle states for a CPU node
Date:   Wed, 27 Nov 2019 11:29:05 +0100
Message-Id: <20191127102914.18729-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191127102914.18729-1-ulf.hansson@linaro.org>
References: <20191127102914.18729-1-ulf.hansson@linaro.org>
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

Changes in v3:
	- None.

---
 drivers/of/base.c  | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/of.h |  8 ++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 1d667eb730e1..0e4cdf0f3864 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -477,6 +477,42 @@ int of_cpu_node_to_id(struct device_node *cpu_node)
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


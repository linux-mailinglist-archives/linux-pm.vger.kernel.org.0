Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7DE8D281E
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 13:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbfJJLkO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 07:40:14 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42620 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfJJLkO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 07:40:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so5813036lje.9
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2019 04:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GuctgQaNXDpvCtGnyWFncLAWkLOPv4PuyrC/plBYoKw=;
        b=DanIYhUZr/1fcPOq8Ic6qUfgUj21pf/pck8soG6eZQCQYhtidxPLIlbpjpwqD+1XB+
         LMxMZ2fIBihfggtcjrtFGfxbLLq8eIV21kCamNCqUj6Y/iWMUWu5aY+SkSB36/59rvHv
         j2I8r/mohLV8cTtkXEd+eQ4NLXVuf773dkPbaDzPLUWhrFdJ/PkSO1P1JFPRVaQlfxR6
         x153P2vsxw0BA+ayURQPn/ry91aXPfcYe4iFNFCWze/i0veaWf0Nw7nIyqJZhu/YfH1Z
         HbqHDu1AQp+bYI6dm7I4KRDV4j0iojylqAYBVwYJwMtnRXRspSEkZSOnemFgvBXNAT0P
         fYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GuctgQaNXDpvCtGnyWFncLAWkLOPv4PuyrC/plBYoKw=;
        b=qihU7uQtIaHfxDEIOwMzculQ0GkqLLKnvXW+z4B9TH7KNcKh/0o5HW/PVeTlE2DbMj
         9ZK/QL7HmkQvfVbWcv2OxIMcXDVwjKFKK7PREKh1uzENwcEOV1VuwUcI7iNnSysRexkP
         vhgBUdUqfgv/whhu35JusDz5sHo/ITmG4Ab0V9Xez4LZnM5FjbOckaV+Xj3wa4eZ1aUf
         cQBK26xxjZRxlB/DJ5N9goucuPLyrf8OJSXjlcqU8RhQ0K1dqIxmnA2eDpPBRkPVbhfF
         HsSlIJaYAAH+RK5ITIz678tFVCN8mbpyAGKI76ryVASVs/LZagU+dVSU+yIzrm4TktET
         Fg5Q==
X-Gm-Message-State: APjAAAXEzZiKcdGrfMur6wrCvTC7NpS0EcUFBrqWorvE/IpmWJkVsWmc
        tUM5bQaBGBq3Pvd/hclq/VkfXg==
X-Google-Smtp-Source: APXvYqzJlSXBelf9XaR8Fb0R4bdv691aPCwO1Z3PRCtK+D7bKXcC8xeURfNHeN93zAvSqzcikcMDsw==
X-Received: by 2002:a2e:286:: with SMTP id y6mr6266107lje.184.1570707611403;
        Thu, 10 Oct 2019 04:40:11 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id p3sm1168937ljn.78.2019.10.10.04.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 04:40:10 -0700 (PDT)
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
Subject: [PATCH 04/13] of: base: Add of_get_cpu_state_node() to get idle states for a CPU node
Date:   Thu, 10 Oct 2019 13:39:28 +0200
Message-Id: <20191010113937.15962-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010113937.15962-1-ulf.hansson@linaro.org>
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
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


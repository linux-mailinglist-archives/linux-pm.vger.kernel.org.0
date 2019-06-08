Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C69CA39B11
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2019 06:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbfFHEoB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 8 Jun 2019 00:44:01 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:34332 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730471AbfFHEn7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Jun 2019 00:43:59 -0400
Received: by mail-qk1-f202.google.com with SMTP id h198so3411702qke.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2019 21:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AQaL/PGq4V0DuXs35/Wx+s7nNXc5+qEy/Os9W/iGFYA=;
        b=cHfi3CnTUcT1n2hmhkaz7Mg9O1ojtQBcEgDon17GIJ7rAI2DCEokMLnia6lX2ELmA1
         xmRYRLLSFDWkW4AbAza2SAuDM8uNw1ML5WBrgCxz53AKgWu/5e+V67Og3J/KXliXlq9P
         viieHIuJgf2Q43PHgfe3i6Fb5VuUmOFwzOVJbWLcZiEPXqpJUgqbbHKzcs6gTTSDnHAI
         SQog4t282FQWBS+PPYN8Lem/9034ox8YIearSEgBN8nVVXVXuApsd3tOcr/HXp73U9Fh
         yLdkzE4F2D7baTtK4XvCFfhGbigKyDViR63AutM8OLXSitJshAKEhifKe4m0FQgJm7Xu
         ujpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AQaL/PGq4V0DuXs35/Wx+s7nNXc5+qEy/Os9W/iGFYA=;
        b=e/80DUwFKBlOSX6yPDqBvmOrsbldg6WNZGHzSuN3IUIbK5lyP00t90sa0Cn5OU4e6a
         s2bBpnEDKi5tpnxUs02pJ/CfEtdZDXf9XpEzQoF8w54HmQJ/wsILW/vAljpUCyuDrUjU
         uRIstUXXmg8x9GhC47cvlENaB2nJ3S2SlcEtiCaaqsRcAUex50jb7IRQHZl6m/V5VyIx
         n+oqfKOuKj85zx7i7ST2OO4lC3toml8WF11hdr4jIODBFoGdDzKbUDjewZT8c2cFJsuW
         kJy0vY7TWE40zLevdSBgtHm89lxJrYqyKW+MpnHYfjb2UfURqW+dPBPwl7fHbJ0UcwuX
         sCHg==
X-Gm-Message-State: APjAAAV+9RGH356f/LehLKsB3EfSZRXPVUcPhB8k5+qKM+y5IJ+QKwnX
        9NvnqZkZd2xCw1N3Bs3PaY6yKnMfUlID508=
X-Google-Smtp-Source: APXvYqzDiL0bLzrWM4BPLbZ4rXoIgduk46Uiyp6JQp8vO+GfSBOMdB0GFp36bFyZrGIsx1NIsnvnzMRXmsbPiuI=
X-Received: by 2002:a0c:d047:: with SMTP id d7mr45723029qvh.64.1559969038459;
 Fri, 07 Jun 2019 21:43:58 -0700 (PDT)
Date:   Fri,  7 Jun 2019 21:43:34 -0700
In-Reply-To: <20190608044339.115026-1-saravanak@google.com>
Message-Id: <20190608044339.115026-5-saravanak@google.com>
Mime-Version: 1.0
References: <20190608044339.115026-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v1 4/9] OPP: Add API to find an OPP table from its DT node
From:   Saravana Kannan <saravanak@google.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        sibis@codeaurora.org, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This allows finding a device's OPP table (when it has multiple) from a
phandle to the OPP table in DT.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/opp/of.c       | 42 ++++++++++++++++++++++++++++++++++--------
 include/linux/pm_opp.h |  7 +++++++
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 54fa70ed2adc..34c51905f56d 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -42,14 +42,9 @@ struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_opp_desc_node);
 
-struct opp_table *_managed_opp(struct device *dev, int index)
+struct opp_table *_find_opp_table_from_node(struct device_node *np)
 {
 	struct opp_table *opp_table, *managed_table = NULL;
-	struct device_node *np;
-
-	np = _opp_of_get_opp_desc_node(dev->of_node, index);
-	if (!np)
-		return NULL;
 
 	list_for_each_entry(opp_table, &opp_tables, node) {
 		if (opp_table->np == np) {
@@ -69,11 +64,42 @@ struct opp_table *_managed_opp(struct device *dev, int index)
 		}
 	}
 
-	of_node_put(np);
-
 	return managed_table;
 }
 
+/**
+ * dev_pm_opp_of_find_table_from_node() - Find OPP table from its DT node
+ * @np: DT node used for finding the OPP table
+ *
+ * Return: OPP table corresponding to the DT node, else NULL on failure.
+ *
+ * The caller needs to put the node with of_node_put() after using it.
+ */
+struct opp_table *dev_pm_opp_of_find_table_from_node(struct device_node *np)
+{
+	struct opp_table *opp_table;
+
+	mutex_lock(&opp_table_lock);
+	opp_table = _find_opp_table_from_node(np);
+	mutex_unlock(&opp_table_lock);
+	return opp_table;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_find_table_from_node);
+
+struct opp_table *_managed_opp(struct device *dev, int index)
+{
+	struct device_node *np;
+	struct opp_table *opp_table;
+
+	np = _opp_of_get_opp_desc_node(dev->of_node, index);
+	if (!np)
+		return NULL;
+
+	opp_table = _find_opp_table_from_node(np);
+	of_node_put(np);
+	return opp_table;
+}
+
 /* The caller must call dev_pm_opp_put() after the OPP is used */
 static struct dev_pm_opp *_find_opp_of_np(struct opp_table *opp_table,
 					  struct device_node *opp_np)
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 7f040cc20daf..3f30ce55e8eb 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -359,6 +359,7 @@ int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask);
 void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
 struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
+struct opp_table *dev_pm_opp_of_find_table_from_node(struct device_node *np);
 struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
 int of_get_required_opp_performance_state(struct device_node *np, int index);
 void dev_pm_opp_of_register_em(struct cpumask *cpus);
@@ -396,6 +397,12 @@ static inline struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device
 	return NULL;
 }
 
+static inline struct opp_table *dev_pm_opp_of_find_table_from_node(
+							struct device_node *np)
+{
+	return NULL;
+}
+
 static inline struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
 {
 	return NULL;
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog


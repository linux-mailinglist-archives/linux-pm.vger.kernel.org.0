Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D38B1B3F1
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 12:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfEMKZp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 06:25:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38806 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfEMKZp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 06:25:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so6549708pgl.5
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2019 03:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O4HEaAMyAMCganTSaAvSboYnsj/4pMpeSESB7y6FIX4=;
        b=qUis5yia/e6b15f6sCIoHlgrM1BSAgv3YKoBdtDFbjvUDOisCTYQ5ke765kIrJzgWr
         no2LgiBarXOvQOc/NZeCkViQELN2C+r5K+N6OtePGPqb2l3Su5lqSOUVFfu4vJ2EP114
         ZEHa5dIZBUAIe+HsBcUuo4+kRsrmb8HkGoBpZ9bLLFknzaIxVhy0n0J0y1iOcgRzWbTd
         lnMoQHwhZPqSz6ekqNefYHsFLYEbZTFS2o+hEMuR1k/hWmEioiX/I9ZpHnSbJYR1fTUQ
         yqOhQnaSbpyDU4YwvoY1i/QIkeGRXE1O6phXjVlbYBWlXo7eb8rqbYH6MaGCU4hU4SZh
         HNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O4HEaAMyAMCganTSaAvSboYnsj/4pMpeSESB7y6FIX4=;
        b=Sh7MPESkXZFF7pMyPTsncDqtLWfPjpdfOJvn6HanJZ7uZ9ZDmruSwlMR5get85grDt
         38f+3dPz7JMFr14Wx5OKJX80AVayCa5s97JWMn2Pk0Kg0CsJ+s9gYhVhqvQane7MLlvL
         JATQot17F4EIjsT0AXBiM8wDG/dldmA3A1MC+YklwvubpMsVy4RW1HmQyC6XlB3xJmZm
         2ZoqeZykvF8bHaCBx64av3RbkjcneClx80Po6JgZrngQJijayDNdNbWnBgaJY/sVULA1
         nhNA83QInDmDDGr0/KhCO6gq/KQuRnZxiYm7dVb3xUpsxCNdbvqeaeuRxol9o1tvaUiz
         l58Q==
X-Gm-Message-State: APjAAAVszoZRxwzv7KuGOlgLO+o47GJJpIrMfMgJeFFVKKYSxbZabG0a
        pIb1OhzEnOIfcC75GyA5oB3kCQ==
X-Google-Smtp-Source: APXvYqymGHvuojqBehocrN36SOhETDgwB7UkIU6Ak4Yv1bRU89tnNMDIUsXKL5yqNV0K4fRuRWs6Sg==
X-Received: by 2002:a63:e24c:: with SMTP id y12mr5686326pgj.276.1557743143803;
        Mon, 13 May 2019 03:25:43 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id c23sm30833287pfp.0.2019.05.13.03.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 03:25:42 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, niklas.cassel@linaro.org,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] opp: Attach genpds to devices from within OPP core
Date:   Mon, 13 May 2019 15:54:10 +0530
Message-Id: <1bc9053f5c41a10832b58a2a81decbad7f1aded9.1557742920.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The OPP core requires the virtual device pointers to set performance
state on behalf of the device, for the multiple power domain case. The
genpd API (dev_pm_domain_attach_by_name()) has evolved now to support
even the single power domain case and that lets us add common code for
handling both the cases more efficiently.

The virtual device structure returned by dev_pm_domain_attach_by_name()
isn't normally used by the cpufreq drivers as they don't manage power
on/off of the domains and so is only useful for the OPP core.

This patch moves all the complexity into the OPP core to make the end
drivers simple. The earlier APIs dev_pm_opp_{set|put}_genpd_virt_dev()
are reworked into dev_pm_opp_{attach|detach}_genpd(). The new helper
dev_pm_opp_attach_genpd() accepts a NULL terminated array of strings
which contains names of all the genpd's to attach. It then attaches all
the domains and saves the pointers to the virtual devices. The other
helper undo the work done by this helper.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
@Niklas: Can you please try these patches and confirm they solve the
issues you were facing ?

 drivers/opp/core.c     | 128 ++++++++++++++++++++++++++---------------
 include/linux/pm_opp.h |   8 +--
 2 files changed, 86 insertions(+), 50 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 0e7703fe733f..67d6b0caeab1 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1744,91 +1744,127 @@ void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_unregister_set_opp_helper);
 
+static void _opp_detach_genpd(struct opp_table *opp_table)
+{
+	int index;
+
+	for (index = 0; index < opp_table->required_opp_count; index++) {
+		if (!opp_table->genpd_virt_devs[index])
+			continue;
+
+		dev_pm_domain_detach(opp_table->genpd_virt_devs[index], false);
+		opp_table->genpd_virt_devs[index] = NULL;
+	}
+}
+
 /**
- * dev_pm_opp_set_genpd_virt_dev - Set virtual genpd device for an index
- * @dev: Consumer device for which the genpd device is getting set.
- * @virt_dev: virtual genpd device.
- * @index: index.
+ * dev_pm_opp_attach_genpd - Attach genpd(s) for the device and save virtual device pointer
+ * @dev: Consumer device for which the genpd is getting attached.
+ * @names: Null terminated array of pointers containing names of genpd to attach.
  *
  * Multiple generic power domains for a device are supported with the help of
  * virtual genpd devices, which are created for each consumer device - genpd
  * pair. These are the device structures which are attached to the power domain
  * and are required by the OPP core to set the performance state of the genpd.
+ * The same API also works for the case where single genpd is available and so
+ * we don't need to support that separately.
  *
  * This helper will normally be called by the consumer driver of the device
- * "dev", as only that has details of the genpd devices.
+ * "dev", as only that has details of the genpd names.
  *
- * This helper needs to be called once for each of those virtual devices, but
- * only if multiple domains are available for a device. Otherwise the original
- * device structure will be used instead by the OPP core.
+ * This helper needs to be called once with a list of all genpd to attach.
+ * Otherwise the original device structure will be used instead by the OPP core.
  */
-struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev,
-						struct device *virt_dev,
-						int index)
+struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names)
 {
 	struct opp_table *opp_table;
+	struct device *virt_dev;
+	int index, ret = -EINVAL;
+	const char **name = names;
 
 	opp_table = dev_pm_opp_get_opp_table(dev);
 	if (!opp_table)
 		return ERR_PTR(-ENOMEM);
 
+	/*
+	 * If the genpd's OPP table isn't already initialized, parsing of the
+	 * required-opps fail for dev. We should retry this after genpd's OPP
+	 * table is added.
+	 */
+	if (!opp_table->required_opp_count) {
+		ret = -EPROBE_DEFER;
+		goto put_table;
+	}
+
 	mutex_lock(&opp_table->genpd_virt_dev_lock);
 
-	if (unlikely(!opp_table->genpd_virt_devs ||
-		     index >= opp_table->required_opp_count ||
-		     opp_table->genpd_virt_devs[index])) {
+	while (*name) {
+		index = of_property_match_string(dev->of_node,
+						 "power-domain-names", *name);
+		if (index < 0) {
+			dev_err(dev, "Failed to find power domain: %s (%d)\n",
+				*name, index);
+			goto err;
+		}
 
-		dev_err(dev, "Invalid request to set required device\n");
-		dev_pm_opp_put_opp_table(opp_table);
-		mutex_unlock(&opp_table->genpd_virt_dev_lock);
+		if (index >= opp_table->required_opp_count) {
+			dev_err(dev, "Index can't be greater than required-opp-count - 1, %s (%d : %d)\n",
+				*name, opp_table->required_opp_count, index);
+			goto err;
+		}
 
-		return ERR_PTR(-EINVAL);
+		if (opp_table->genpd_virt_devs[index]) {
+			dev_err(dev, "Genpd virtual device already set %s\n",
+				*name);
+			goto err;
+		}
+
+		virt_dev = dev_pm_domain_attach_by_name(dev, *name);
+		if (IS_ERR(virt_dev)) {
+			ret = PTR_ERR(virt_dev);
+			dev_err(dev, "Couldn't attach to pm_domain: %d\n", ret);
+			goto err;
+		}
+
+		opp_table->genpd_virt_devs[index] = virt_dev;
+		name++;
 	}
 
-	opp_table->genpd_virt_devs[index] = virt_dev;
 	mutex_unlock(&opp_table->genpd_virt_dev_lock);
 
 	return opp_table;
+
+err:
+	_opp_detach_genpd(opp_table);
+	mutex_unlock(&opp_table->genpd_virt_dev_lock);
+
+put_table:
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(dev_pm_opp_attach_genpd);
 
 /**
- * dev_pm_opp_put_genpd_virt_dev() - Releases resources blocked for genpd device.
- * @opp_table: OPP table returned by dev_pm_opp_set_genpd_virt_dev().
- * @virt_dev: virtual genpd device.
- *
- * This releases the resource previously acquired with a call to
- * dev_pm_opp_set_genpd_virt_dev(). The consumer driver shall call this helper
- * if it doesn't want OPP core to update performance state of a power domain
- * anymore.
+ * dev_pm_opp_detach_genpd() - Detach genpd(s) from the device.
+ * @opp_table: OPP table returned by dev_pm_opp_attach_genpd().
+ *
+ * This detaches the genpd(s), resets the virtual device pointers, and puts the
+ * OPP table.
  */
-void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table,
-				   struct device *virt_dev)
+void dev_pm_opp_detach_genpd(struct opp_table *opp_table)
 {
-	int i;
-
 	/*
 	 * Acquire genpd_virt_dev_lock to make sure virt_dev isn't getting
 	 * used in parallel.
 	 */
 	mutex_lock(&opp_table->genpd_virt_dev_lock);
-
-	for (i = 0; i < opp_table->required_opp_count; i++) {
-		if (opp_table->genpd_virt_devs[i] != virt_dev)
-			continue;
-
-		opp_table->genpd_virt_devs[i] = NULL;
-		dev_pm_opp_put_opp_table(opp_table);
-
-		/* Drop the vote */
-		dev_pm_genpd_set_performance_state(virt_dev, 0);
-		break;
-	}
-
+	_opp_detach_genpd(opp_table);
 	mutex_unlock(&opp_table->genpd_virt_dev_lock);
 
-	if (unlikely(i == opp_table->required_opp_count))
-		dev_err(virt_dev, "Failed to find required device entry\n");
+	dev_pm_opp_put_opp_table(opp_table);
 }
+EXPORT_SYMBOL_GPL(dev_pm_opp_detach_genpd);
 
 /**
  * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for src_table.
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index b150fe97ce5a..be570761b77a 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -131,8 +131,8 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
-struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev, struct device *virt_dev, int index);
-void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev);
+struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names);
+void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
@@ -295,12 +295,12 @@ static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const
 
 static inline void dev_pm_opp_put_clkname(struct opp_table *opp_table) {}
 
-static inline struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev, struct device *virt_dev, int index)
+static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names)
 {
 	return ERR_PTR(-ENOTSUPP);
 }
 
-static inline void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev) {}
+static inline void dev_pm_opp_detach_genpd(struct opp_table *opp_table) {}
 
 static inline int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate)
 {
-- 
2.21.0.rc0.269.g1a574e7a288b


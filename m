Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C274C583AD
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 15:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfF0Nev (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 09:34:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37456 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfF0Ner (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 09:34:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BCB5C60E75; Thu, 27 Jun 2019 13:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561642486;
        bh=3W21pQMFNZFtYVC6GlWd+gVxHXzD/QUiLxcs6mipQqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kwcYh9FZ62DG0esKAw45uS1++60L+pG1LE5YlnFzCZJ9gi1HiqPHq2eW1ONZVWIdl
         nS2RGhQ7RwMIrT65ZoxWnsxtUYcOQYVnbPfgzX7FUXgdw8kDqNaeRena5IY4O/rOsJ
         UbUNo3ghZiAhQuEiq2nPabffpSl2PinuASHvQU3s=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CCF6460C8B;
        Thu, 27 Jun 2019 13:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561642485;
        bh=3W21pQMFNZFtYVC6GlWd+gVxHXzD/QUiLxcs6mipQqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n/ziMy77wzDA1k2VuMRaSUiLXp/tZilMDVQe9oYy8VY5CrhLJfXPc1NZnBpvvT5IX
         ZdIfvdeQ9xiWFY0EI703Od/CizMUljxE3E1X/QRHQE2y7L2IOsaqeuy7EJyqNYrGbj
         Qa92WpLcvYgditEMgvayLGbi6/PwUtkyy6qfOEdM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CCF6460C8B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        georgi.djakov@linaro.org
Cc:     agross@kernel.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        saravanak@google.com, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH RFC 2/4] OPP: Add and export helper to set bandwidth
Date:   Thu, 27 Jun 2019 19:04:22 +0530
Message-Id: <20190627133424.4980-3-sibis@codeaurora.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627133424.4980-1-sibis@codeaurora.org>
References: <20190627133424.4980-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add and export 'dev_pm_opp_set_bw' to set the bandwidth
levels associated with an OPP for a given frequency.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/opp/core.c     | 46 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  6 ++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index c85c04dc2c7de..78f42960860d1 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -746,6 +746,52 @@ static int _set_required_opps(struct device *dev,
 	return ret;
 }
 
+/**
+ * dev_pm_opp_set_bw() - Configures OPP bandwidth levels
+ * @dev:	device for which we do this operation
+ * @freq:	bandwidth values to set with matching 'freq'
+ *
+ * This configures the bandwidth to the levels specified
+ * by the OPP corresponding to the given frequency.
+ *
+ * Return: 0 on success or a negative error value.
+ */
+int dev_pm_opp_set_bw(struct device *dev, unsigned long freq)
+{
+	struct opp_table *opp_table;
+	struct dev_pm_opp *opp;
+	int ret = 0;
+	int i;
+
+	opp = dev_pm_opp_find_freq_exact(dev, freq, true);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		dev_err(dev, "%s: device opp table doesn't exist\n", __func__);
+		ret = PTR_ERR(opp_table);
+		goto put_opp;
+	}
+
+	if (IS_ERR_OR_NULL(opp_table->paths)) {
+		ret = -ENODEV;
+		goto put_opp_table;
+	}
+
+	for (i = 0; i < opp_table->path_count; i++) {
+		ret = icc_set_bw(opp_table->paths[i], opp->bandwidth[i].avg,
+				 opp->bandwidth[i].peak);
+	}
+
+put_opp_table:
+	dev_pm_opp_put_opp_table(opp_table);
+put_opp:
+	dev_pm_opp_put(opp);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_bw);
+
 /**
  * dev_pm_opp_set_rate() - Configure new OPP based on frequency
  * @dev:	 device for which we do this operation
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index a17c462974851..1cdc2d0a2b20e 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -152,6 +152,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names
 void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
+int dev_pm_opp_set_bw(struct device *dev, unsigned long freq);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
 void dev_pm_opp_remove_table(struct device *dev);
@@ -336,6 +337,11 @@ static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_f
 	return -ENOTSUPP;
 }
 
+static inline int dev_pm_opp_set_bw(struct device *dev, unsigned long freq)
+{
+	return -ENOTSUPP;
+}
+
 static inline int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask)
 {
 	return -ENOTSUPP;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


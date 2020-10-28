Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4792C29D7DA
	for <lists+linux-pm@lfdr.de>; Wed, 28 Oct 2020 23:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733266AbgJ1W1Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 18:27:24 -0400
Received: from foss.arm.com ([217.140.110.172]:40038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733250AbgJ1W1X (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Oct 2020 18:27:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C08E19F0;
        Wed, 28 Oct 2020 07:09:26 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.12.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7C95E3F66E;
        Wed, 28 Oct 2020 07:09:23 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vireshk@kernel.org, robh+dt@kernel.org
Cc:     sboyd@kernel.org, nm@ti.com, rafael@kernel.org,
        sudeep.holla@arm.com, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com, lukasz.luba@arm.com
Subject: [PATCH 3/4] OPP: Add dev_pm_opp_set_sustainable_opp_freq()
Date:   Wed, 28 Oct 2020 14:08:46 +0000
Message-Id: <20201028140847.1018-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201028140847.1018-1-lukasz.luba@arm.com>
References: <20201028140847.1018-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a new function allowing to set sustainable OPP from the drivers code.
This is helpful when the device drivers populate the OPP table by
themself.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/opp/core.c     | 49 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  8 +++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index bb1e68b96d0e..753443f17327 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -325,6 +325,55 @@ unsigned long dev_pm_opp_get_sustainable_opp_freq(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_sustainable_opp_freq);
 
+/**
+ * dev_pm_opp_set_sustainable_opp_freq() - Find and set the OPP sustainable
+ *					   based on given frequency
+ * @dev:	device for which we do this operation
+ * @freq:	frequency which OPP is going to be marked
+ *
+ * Mark the OPP of a given frequency @freq as sustainable_opp. If there is
+ * already sustainable OPP, choose the highest frequency one and set.
+ *
+ * Return: This function return 0 when the new OPP is marked as sustainable
+ * or error return value, which can be:
+ * EINVAL:	for bad pointer or no match found for frequency search
+ * EEXIST:	if existing sustainable OPP has higher rate
+ */
+int dev_pm_opp_set_sustainable_opp_freq(struct device *dev, unsigned long freq)
+{
+	struct opp_table *opp_table;
+	struct dev_pm_opp *opp;
+	int ret = 0;
+
+	opp = dev_pm_opp_find_freq_exact(dev, freq, true);
+	if (IS_ERR_OR_NULL(opp))
+		return -EINVAL;
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table))
+		return -EINVAL;
+
+	if (opp_table->sustainable_opp) {
+		/* Pick the OPP with higher rate as sustainable OPP */
+		if (opp->rate > opp_table->sustainable_opp->rate) {
+			opp_table->sustainable_opp->sustainable = false;
+			opp->sustainable = true;
+			opp_table->sustainable_opp = opp;
+		} else {
+			ret = -EEXIST;
+		}
+	} else {
+		opp->sustainable = true;
+		opp_table->sustainable_opp = opp;
+	}
+
+	dev_pm_opp_put(opp);
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_sustainable_opp_freq);
+
 int _get_opp_count(struct opp_table *opp_table)
 {
 	struct dev_pm_opp *opp;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 363d5a2c1ef3..e634a6b00e65 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -107,6 +107,8 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev);
 unsigned long dev_pm_opp_get_max_transition_latency(struct device *dev);
 unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev);
 unsigned long dev_pm_opp_get_sustainable_opp_freq(struct device *dev);
+int dev_pm_opp_set_sustainable_opp_freq(struct device *dev,
+					unsigned long freq);
 
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					      unsigned long freq,
@@ -221,6 +223,12 @@ static inline unsigned long dev_pm_opp_get_sustainable_opp_freq(struct device *d
 	return 0;
 }
 
+static inline int dev_pm_opp_set_sustainable_freq(struct device *dev,
+					unsigned long freq)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					unsigned long freq, bool available)
 {
-- 
2.17.1


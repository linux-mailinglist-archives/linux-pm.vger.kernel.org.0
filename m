Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FC129D7FF
	for <lists+linux-pm@lfdr.de>; Wed, 28 Oct 2020 23:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733241AbgJ1W2r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 18:28:47 -0400
Received: from foss.arm.com ([217.140.110.172]:40034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733185AbgJ1W10 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Oct 2020 18:27:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21ABC19BF;
        Wed, 28 Oct 2020 07:09:23 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.12.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6FE6B3F66E;
        Wed, 28 Oct 2020 07:09:20 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vireshk@kernel.org, robh+dt@kernel.org
Cc:     sboyd@kernel.org, nm@ti.com, rafael@kernel.org,
        sudeep.holla@arm.com, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com, lukasz.luba@arm.com
Subject: [PATCH 2/4] OPP: Add support for parsing the 'opp-sustainable' property
Date:   Wed, 28 Oct 2020 14:08:45 +0000
Message-Id: <20201028140847.1018-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201028140847.1018-1-lukasz.luba@arm.com>
References: <20201028140847.1018-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that the OPP bindings are updated to include an optional
'opp-sustainable' property, add support to parse it from device tree and
store it as part of dev_pm_opp structure.
Also add and export an helper 'dev_pm_opp_get_sustainable()' that can be
used to get the sustainable OPP when present.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/opp/core.c     | 26 ++++++++++++++++++++++++++
 drivers/opp/of.c       | 14 ++++++++++++++
 drivers/opp/opp.h      |  3 +++
 include/linux/pm_opp.h |  6 ++++++
 4 files changed, 49 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 9915e8487f0b..bb1e68b96d0e 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -299,6 +299,32 @@ unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp_freq);
 
+/**
+ * dev_pm_opp_get_sustainable_opp_freq() - Get frequency of sustainable opp
+ *					   in Hz
+ * @dev:	device for which we do this operation
+ *
+ * Return: This function returns the frequency of the OPP marked as
+ * sustainable_opp if one is available, else returns 0;
+ */
+unsigned long dev_pm_opp_get_sustainable_opp_freq(struct device *dev)
+{
+	struct opp_table *opp_table;
+	unsigned long freq = 0;
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table))
+		return 0;
+
+	if (opp_table->sustainable_opp && opp_table->sustainable_opp->available)
+		freq = dev_pm_opp_get_freq(opp_table->sustainable_opp);
+
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return freq;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_sustainable_opp_freq);
+
 int _get_opp_count(struct opp_table *opp_table)
 {
 	struct dev_pm_opp *opp;
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 9faeb83e4b32..1f6b19bb1a95 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -815,6 +815,20 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 		}
 	}
 
+	if (of_property_read_bool(np, "opp-sustainable")) {
+		if (opp_table->sustainable_opp) {
+			/* Pick the OPP with higher rate as sustainable OPP */
+			if (new_opp->rate > opp_table->sustainable_opp->rate) {
+				opp_table->sustainable_opp->sustainable = false;
+				new_opp->sustainable = true;
+				opp_table->sustainable_opp = new_opp;
+			}
+		} else {
+			new_opp->sustainable = true;
+			opp_table->sustainable_opp = new_opp;
+		}
+	}
+
 	if (new_opp->clock_latency_ns > opp_table->clock_latency_ns_max)
 		opp_table->clock_latency_ns_max = new_opp->clock_latency_ns;
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index ebd930e0b3ca..45288ccbb295 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -56,6 +56,7 @@ extern struct list_head opp_tables;
  * @dynamic:	not-created from static DT entries.
  * @turbo:	true if turbo (boost) OPP
  * @suspend:	true if suspend OPP
+ * @sustainable: true if sustainable OPP
  * @pstate: Device's power domain's performance state.
  * @rate:	Frequency in hertz
  * @level:	Performance level
@@ -78,6 +79,7 @@ struct dev_pm_opp {
 	bool dynamic;
 	bool turbo;
 	bool suspend;
+	bool sustainable;
 	unsigned int pstate;
 	unsigned long rate;
 	unsigned int level;
@@ -183,6 +185,7 @@ struct opp_table {
 	unsigned int parsed_static_opps;
 	enum opp_table_access shared_opp;
 	struct dev_pm_opp *suspend_opp;
+	struct dev_pm_opp *sustainable_opp;
 
 	struct mutex genpd_virt_dev_lock;
 	struct device **genpd_virt_devs;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index dbb484524f82..363d5a2c1ef3 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -106,6 +106,7 @@ unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev);
 unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev);
 unsigned long dev_pm_opp_get_max_transition_latency(struct device *dev);
 unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev);
+unsigned long dev_pm_opp_get_sustainable_opp_freq(struct device *dev);
 
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					      unsigned long freq,
@@ -215,6 +216,11 @@ static inline unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
 	return 0;
 }
 
+static inline unsigned long dev_pm_opp_get_sustainable_opp_freq(struct device *dev)
+{
+	return 0;
+}
+
 static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					unsigned long freq, bool available)
 {
-- 
2.17.1


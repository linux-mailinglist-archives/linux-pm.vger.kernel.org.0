Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8AF28B8E5
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 15:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390506AbgJLNzz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 09:55:55 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:50549 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390248AbgJLNzx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 09:55:53 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436685|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0758005-0.0504991-0.8737;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=20;RT=20;SR=0;TI=SMTPD_---.IiEO.rd_1602510932;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.IiEO.rd_1602510932)
          by smtp.aliyun-inc.com(10.147.41.137);
          Mon, 12 Oct 2020 21:55:46 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        rjw@rjwysocki.net, jcrouse@codeaurora.org, eric@anholt.net,
        tiny.windzz@gmail.com, kholk11@gmail.com,
        emil.velikov@collabora.com, gustavoars@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Yangtao Li <frank@allwinnertech.com>
Subject: [PATCH 2/3] opp: Add devres wrapper for dev_pm_opp_set_prop_name
Date:   Mon, 12 Oct 2020 21:55:16 +0800
Message-Id: <20201012135517.19468-3-frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012135517.19468-1-frank@allwinnertech.com>
References: <20201012135517.19468-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

Add devres wrapper for dev_pm_opp_set_prop_name() to simplify driver
code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 drivers/opp/core.c     | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  6 ++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index b38852dde578..3263fa8302c9 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1721,6 +1721,45 @@ void dev_pm_opp_put_prop_name(struct opp_table *opp_table)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
 
+static void devm_pm_opp_put_prop_name(struct device *dev, void *res)
+{
+	dev_pm_opp_put_prop_name(*(struct opp_table **)res);
+}
+
+/**
+ * devm_pm_opp_set_prop_name() - Set prop-extn name
+ * @dev: Device for which the prop-name has to be set.
+ * @name: name to postfix to properties.
+ *
+ * This is required only for the V2 bindings, and it enables a platform to
+ * specify the extn to be used for certain property names. The properties to
+ * which the extension will apply are opp-microvolt and opp-microamp. OPP core
+ * should postfix the property name with -<name> while looking for them.
+ *
+ * The opp_table structure will be freed after the device is destroyed.
+ */
+struct opp_table *devm_pm_opp_set_prop_name(struct device *dev,
+					    const char *name)
+{
+	struct opp_table **ptr, *opp_table;
+
+	ptr = devres_alloc(devm_pm_opp_put_prop_name,
+			   sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	opp_table = dev_pm_opp_set_prop_name(dev, name);
+	if (!IS_ERR(opp_table)) {
+		*ptr = opp_table;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return opp_table;
+}
+EXPORT_SYMBOL(devm_pm_opp_set_prop_name);
+
 static int _allocate_set_opp_data(struct opp_table *opp_table)
 {
 	struct dev_pm_set_opp_data *data;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 901920e29c54..1708485200dd 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -143,6 +143,7 @@ void dev_pm_opp_put_supported_hw(struct opp_table *opp_table);
 struct opp_table *devm_pm_opp_set_supported_hw(struct device *dev, const u32 *versions, unsigned int count);
 struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
+struct opp_table *devm_pm_opp_set_prop_name(struct device *dev, const char *name);
 struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count);
 void dev_pm_opp_put_regulators(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
@@ -321,6 +322,11 @@ static inline struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, con
 
 static inline void dev_pm_opp_put_prop_name(struct opp_table *opp_table) {}
 
+static inline struct opp_table *devm_pm_opp_set_prop_name(struct device *dev, const char *name)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 static inline struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count)
 {
 	return ERR_PTR(-ENOTSUPP);
-- 
2.28.0


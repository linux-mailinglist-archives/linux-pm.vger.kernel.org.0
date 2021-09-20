Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096824127A8
	for <lists+linux-pm@lfdr.de>; Mon, 20 Sep 2021 23:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbhITVEd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Sep 2021 17:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237260AbhITVCb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Sep 2021 17:02:31 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00422C059360;
        Mon, 20 Sep 2021 10:23:17 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g1so71208106lfj.12;
        Mon, 20 Sep 2021 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5KsYfuNRlvMrE9NTZucMYXQywZC0cvfGbwd3TTvoBus=;
        b=mIy29wnqTh/a+pG1/GhLjs4DPHYZh1fwdtWW9WBdYtBOZtF+FMQuaB0QREWg6WNMQM
         CxKIjEWqB6RHsDTwIkLRXLAQJPUx6Opfjie0elWseVbWwomEKw7q8UeqyXX1IVL+youx
         dNGg8IT6hG6njsTIpkEWrncIHRkgil7XomK+YmJ4wP+UcepHESEHYkUzjS6r/Z1Mj9Cu
         KjECztze6YUjw/EKcZwLZVbsS/sAtoeddghdaw8YHvK0b/+z1bvfh8HAFp7qO4Rect5S
         XFKjBa5dleRBaQQ/MZ+KGDBCfnLPix4akR1CzyW9AUBBtu7PiqtrbotIeILBbpxJ60XI
         dqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5KsYfuNRlvMrE9NTZucMYXQywZC0cvfGbwd3TTvoBus=;
        b=dmh1NYOaH+jKhxkEDHwRa+AkNfdMLykDjS8b3gK9BePJpWf7DxQ/V7TxDQX/B76zun
         LS3w6HEd9uMcViJcSmTxP5an5Qr3gtSPkIv0dmR6bkr56rJEZ1/iAutyEHdEMP2oYz8S
         ou0urGj3Zime7lO2yHI4b9MaeRolDnaqNzd08ZYm2ENZ4jFf9R+34DYlPCnfi/ZHBRLd
         oHKwrkRO/TJwKEruQ1fkYeg18gMtl0MyyP6BQTT9S4cGdWhPQVm9o4kQ9dRD41eXICou
         bWKRsZXWatn/GwMphCMeY4QDh/NsWlUAUE1IItM6Y6imqtw16/9Df0xd9LnPbgOtja5p
         izEQ==
X-Gm-Message-State: AOAM53383QqbDHghcUF+VezerEOpJOXSHleb2th0sKEuOUq+4hC+N7SY
        D5Ash0PRPYHBTynWhIDekic=
X-Google-Smtp-Source: ABdhPJwoDWyXi9BcogBV3S+UFDfaIOWEOVRWIFTDYk1rirMOV90ZCNnisW4HjFBDVUdNDYBesRAkwg==
X-Received: by 2002:a05:6512:1292:: with SMTP id u18mr19358027lfs.218.1632158594857;
        Mon, 20 Sep 2021 10:23:14 -0700 (PDT)
Received: from localhost.localdomain (46-138-151-206.dynamic.spd-mgts.ru. [46.138.151.206])
        by smtp.gmail.com with ESMTPSA id t13sm1311038lff.279.2021.09.20.10.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:23:14 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 1/4] opp: Add more resource-managed variants of dev_pm_opp_of_add_table()
Date:   Mon, 20 Sep 2021 20:22:46 +0300
Message-Id: <20210920172249.28206-2-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210920172249.28206-1-digetx@gmail.com>
References: <20210920172249.28206-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add resource-managed variants of dev_pm_opp_of_add_table_indexed() and
dev_pm_opp_of_add_table_noclk(), allowing drivers to remove boilerplate
code.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/of.c       | 46 +++++++++++++++++++++++++++++++++++-------
 include/linux/pm_opp.h | 12 +++++++++++
 2 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 2a97c6535c4c..bd01ecb1d85c 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1081,6 +1081,17 @@ static void devm_pm_opp_of_table_release(void *data)
 	dev_pm_opp_of_remove_table(data);
 }
 
+static int devm_of_add_table_indexed(struct device *dev, int index, bool getclk)
+{
+	int ret;
+
+	ret = _of_add_table_indexed(dev, index, getclk);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, devm_pm_opp_of_table_release, dev);
+}
+
 /**
  * devm_pm_opp_of_add_table() - Initialize opp table from device tree
  * @dev:	device pointer used to lookup OPP table.
@@ -1102,13 +1113,7 @@ static void devm_pm_opp_of_table_release(void *data)
  */
 int devm_pm_opp_of_add_table(struct device *dev)
 {
-	int ret;
-
-	ret = dev_pm_opp_of_add_table(dev);
-	if (ret)
-		return ret;
-
-	return devm_add_action_or_reset(dev, devm_pm_opp_of_table_release, dev);
+	return devm_of_add_table_indexed(dev, 0, true);
 }
 EXPORT_SYMBOL_GPL(devm_pm_opp_of_add_table);
 
@@ -1151,6 +1156,19 @@ int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table_indexed);
 
+/**
+ * devm_pm_opp_of_add_table_indexed() - Initialize indexed opp table from device tree
+ * @dev:	device pointer used to lookup OPP table.
+ * @index:	Index number.
+ *
+ * This is a resource-managed variant of dev_pm_opp_of_add_table_indexed().
+ */
+int devm_pm_opp_of_add_table_indexed(struct device *dev, int index)
+{
+	return devm_of_add_table_indexed(dev, index, true);
+}
+EXPORT_SYMBOL_GPL(devm_pm_opp_of_add_table_indexed);
+
 /**
  * dev_pm_opp_of_add_table_noclk() - Initialize indexed opp table from device
  *		tree without getting clk for device.
@@ -1169,6 +1187,20 @@ int dev_pm_opp_of_add_table_noclk(struct device *dev, int index)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table_noclk);
 
+/**
+ * devm_pm_opp_of_add_table_noclk() - Initialize indexed opp table from device
+ *		tree without getting clk for device.
+ * @dev:	device pointer used to lookup OPP table.
+ * @index:	Index number.
+ *
+ * This is a resource-managed variant of dev_pm_opp_of_add_table_noclk().
+ */
+int devm_pm_opp_of_add_table_noclk(struct device *dev, int index)
+{
+	return devm_of_add_table_indexed(dev, index, false);
+}
+EXPORT_SYMBOL_GPL(devm_pm_opp_of_add_table_noclk);
+
 /* CPU device specific helpers */
 
 /**
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 84150a22fd7c..a95d6fdd20b6 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -439,7 +439,9 @@ static inline int dev_pm_opp_sync_regulators(struct device *dev)
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
 int dev_pm_opp_of_add_table(struct device *dev);
 int dev_pm_opp_of_add_table_indexed(struct device *dev, int index);
+int devm_pm_opp_of_add_table_indexed(struct device *dev, int index);
 int dev_pm_opp_of_add_table_noclk(struct device *dev, int index);
+int devm_pm_opp_of_add_table_noclk(struct device *dev, int index);
 void dev_pm_opp_of_remove_table(struct device *dev);
 int devm_pm_opp_of_add_table(struct device *dev);
 int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask);
@@ -465,11 +467,21 @@ static inline int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
 	return -EOPNOTSUPP;
 }
 
+static inline int devm_pm_opp_of_add_table_indexed(struct device *dev, int index)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int dev_pm_opp_of_add_table_noclk(struct device *dev, int index)
 {
 	return -EOPNOTSUPP;
 }
 
+static inline int devm_pm_opp_of_add_table_noclk(struct device *dev, int index)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void dev_pm_opp_of_remove_table(struct device *dev)
 {
 }
-- 
2.32.0


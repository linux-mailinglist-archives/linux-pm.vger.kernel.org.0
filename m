Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C1C407F88
	for <lists+linux-pm@lfdr.de>; Sun, 12 Sep 2021 20:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbhILSr0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Sep 2021 14:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbhILSrZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Sep 2021 14:47:25 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EF5C061574;
        Sun, 12 Sep 2021 11:46:10 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i25so12205761lfg.6;
        Sun, 12 Sep 2021 11:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5KsYfuNRlvMrE9NTZucMYXQywZC0cvfGbwd3TTvoBus=;
        b=F6/2gZ2lcI7EMAJusRhiZ0/WloKbWLGv7Pqkl0DzVlelronblNjwRQhrRkeh7NZzSO
         0n4GUizzOJT9eKx/BmqRPdTEchksRuEczSXJ0xqeh5KOEyk4chmy3OqTgdlgaB3DHyjG
         1mTws3KxM93MjvLe5iHYN/Hgq+5gBuZ+btCVJQJrOM7IRIpdfCeaFTbiY24/sG77Y2Dz
         GqPsR4hlOxvzqn+pW15Ti0/OCWEMCCnFJl9Gnq8KaOZVJUc4NdCZCUu5XH3K3fsbZnZV
         T5xzw2UDGOeVixDEh4aLFp/1JiD0hKstcVfhmN0LckyUMJGu4l1m/pJIzfuOCZqM5HA2
         KBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5KsYfuNRlvMrE9NTZucMYXQywZC0cvfGbwd3TTvoBus=;
        b=by5WzGB4iP/zESgYPLauyljmC55vBMG4g60RyEkZxea4LzRvA4oQGro6QtvRbK/9aF
         uDPKWNgCRwNSr93jxdMaFH594xPgc1zhgCcSWPSc51yH2sQAI13sY2vhf6XDTJCaQKUG
         PlIRy7f1AYPHV/tR8arA+a3fJTl6Z/oIQt5jKgUEy4IOnXMOg/L/TtHopfptaj+Jm/o6
         M7AcmpP+23fTwIX8gdB8zL0DgWvIBzmvuHteyPi0XebH7gWgjpn/RWRTnR72IKFaqRL1
         y97GwYV3pXFRoM9HOob2Fvwxz98MonKIVN6I18eCynFuzvcOrz/k/mV3BaIeqfCcLjO4
         VZzA==
X-Gm-Message-State: AOAM533NJ7nObNYD57yxftjwudIDG2bEcu0Q7jB/GbZF5SvfgAe8m/4T
        JLsQZ9MuFdLAd13ByNDkPYkgle6+31o=
X-Google-Smtp-Source: ABdhPJx2aJX677qx18QbIaaMBgBaIgcdcDE4og02j8bJno8wZ2+OMe4JANO5qGz7yOvYXsBWazcVRA==
X-Received: by 2002:ac2:57cb:: with SMTP id k11mr473082lfo.70.1631472368956;
        Sun, 12 Sep 2021 11:46:08 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id q5sm588570lfg.36.2021.09.12.11.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 11:46:08 -0700 (PDT)
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
Subject: [PATCH v1 1/4] opp: Add more resource-managed variants of dev_pm_opp_of_add_table()
Date:   Sun, 12 Sep 2021 21:44:55 +0300
Message-Id: <20210912184458.17995-2-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210912184458.17995-1-digetx@gmail.com>
References: <20210912184458.17995-1-digetx@gmail.com>
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


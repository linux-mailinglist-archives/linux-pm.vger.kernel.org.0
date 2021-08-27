Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDEF3F91FB
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 03:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243962AbhH0Bip (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 21:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243942AbhH0Bip (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Aug 2021 21:38:45 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA65C0613C1;
        Thu, 26 Aug 2021 18:37:56 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x27so10991639lfu.5;
        Thu, 26 Aug 2021 18:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mNDPFfJoz12hFjDc4vGNuTAE2kgagxC+anlHBzhNgsQ=;
        b=tsiC4xKXBeIsfvwuKpWI/WiJvKSXZ/XfBwPt/3wYfrcKOWhxsEX2EINvFbfLNA9r1P
         21qBc/o7l3Zh3lmITdU9Mkj4p7CfhtBlc0phouJmD3nH/w+cTiVU8HkJX6RYSphEv6uW
         ELXig5fiPpAJYHrk/aO6oKa/GgSZOq+RfA+mV/HYA1lAgy/VsxzBj/phNSSwqudtmH3F
         6sDa4D6dx0qE/rtgkGtqz+nPRJOSgVqrEjivpFXv3Fknb5jwYfHyOx1xmXTxwk3Ep6li
         3XYlP0fSAdZsixFe5+kOxCewUrdQ+hZIRkcKg3cIiY+YocZIC3tt+Mkp3B6S5346JHWN
         JOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mNDPFfJoz12hFjDc4vGNuTAE2kgagxC+anlHBzhNgsQ=;
        b=qoqmEjjny1o8RMo64b+RHT94eHS/ABgKsrL0MLqqIIcz0ypswTkekf1p3klPQvlIoS
         kxeVppsdsXr+7IDvkM+IsD+4kMjCFsY15nxuVTRxwzCzsHj5iDSfNOPun5NWw7fGAAc3
         SavpcYqXB3APxP7Mf3pTZZP6jsF+T9tKyw+X3AIwLChj8I83WrRZrSmbXXizjamXCI7V
         6/U4FDQtirPltJBUE+T/vNYe2S6nBNI+NYs6EByucmtj3A/PglALdRzUiysd6TpyEl3D
         y7Ebp3Q3mQnlJesBCf4SZIodc+Yi2FhHm4QVSOA/wp6Q2AihSaVyuftZDS4pnfcPpoaK
         jC/Q==
X-Gm-Message-State: AOAM530/xkWG08Va3So9g1AAgF/PUplSQYDALXy14ftNFKWmyGbxGYzC
        JextG7espYOMpeNPgy2TjOepbebeG08=
X-Google-Smtp-Source: ABdhPJwzpjsWEmQfij6d+BF6RWlYMJi3ECUYnQE34njtgRn8H0T4PpitRelV4QV1Ml5lftzoswvsFw==
X-Received: by 2002:ac2:562f:: with SMTP id b15mr1651077lff.604.1630028275255;
        Thu, 26 Aug 2021 18:37:55 -0700 (PDT)
Received: from localhost.localdomain (94-29-17-251.dynamic.spd-mgts.ru. [94.29.17.251])
        by smtp.gmail.com with ESMTPSA id y3sm494289lfa.240.2021.08.26.18.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 18:37:55 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v9 1/8] opp: Add dev_pm_opp_from_clk_rate()
Date:   Fri, 27 Aug 2021 04:34:08 +0300
Message-Id: <20210827013415.24027-2-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210827013415.24027-1-digetx@gmail.com>
References: <20210827013415.24027-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add dev_pm_opp_from_clk_rate() helper that returns OPP corresponding
to the current clock rate of a device.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c     | 42 +++++++++++++++++++++++++++++++++++++++---
 include/linux/pm_opp.h |  6 ++++++
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 04b4691a8aac..fae5267f5218 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -939,7 +939,8 @@ static int _set_required_opps(struct device *dev,
 	return ret;
 }
 
-static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
+static struct dev_pm_opp *
+_find_current_opp(struct device *dev, struct opp_table *opp_table)
 {
 	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
 	unsigned long freq;
@@ -961,7 +962,7 @@ static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
 		mutex_unlock(&opp_table->lock);
 	}
 
-	opp_table->current_opp = opp;
+	return opp;
 }
 
 static int _disable_opp_table(struct device *dev, struct opp_table *opp_table)
@@ -1003,7 +1004,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 
 	/* Find the currently set OPP if we don't know already */
 	if (unlikely(!opp_table->current_opp))
-		_find_current_opp(dev, opp_table);
+		opp_table->current_opp = _find_current_opp(dev, opp_table);
 
 	old_opp = opp_table->current_opp;
 
@@ -2931,3 +2932,38 @@ int dev_pm_opp_sync_regulators(struct device *dev)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_sync_regulators);
+
+/**
+ * dev_pm_opp_from_clk_rate() - Get OPP from current clock rate
+ * @dev:	device for which we do this operation
+ *
+ * Get OPP which corresponds to the current clock rate of a device.
+ *
+ * Return: pointer to 'struct dev_pm_opp' on success and errorno otherwise.
+ */
+struct dev_pm_opp *dev_pm_opp_from_clk_rate(struct device *dev)
+{
+	struct dev_pm_opp *opp = ERR_PTR(-ENOENT);
+	struct opp_table *opp_table;
+	unsigned long freq;
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table))
+		return ERR_CAST(opp_table);
+
+	if (IS_ERR(opp_table->clk)) {
+		opp = ERR_CAST(opp_table->clk);
+		goto put_table;
+	}
+
+	if (opp_table->clk) {
+		freq = clk_get_rate(opp_table->clk);
+		opp = _find_freq_ceil(opp_table, &freq);
+	}
+put_table:
+	/* Drop reference taken by _find_opp_table() */
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return opp;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_from_clk_rate);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 84150a22fd7c..57e75144dd88 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -168,6 +168,7 @@ int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 void dev_pm_opp_remove_table(struct device *dev);
 void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_sync_regulators(struct device *dev);
+struct dev_pm_opp *dev_pm_opp_from_clk_rate(struct device *dev);
 #else
 static inline struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
 {
@@ -434,6 +435,11 @@ static inline int dev_pm_opp_sync_regulators(struct device *dev)
 	return -EOPNOTSUPP;
 }
 
+static struct inline dev_pm_opp *dev_pm_opp_from_clk_rate(struct device *dev)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 #endif		/* CONFIG_PM_OPP */
 
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
-- 
2.32.0


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235252F9719
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 02:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbhARBDt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 20:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730436AbhARA5E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 19:57:04 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93B3C061786;
        Sun, 17 Jan 2021 16:55:44 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m25so21599203lfc.11;
        Sun, 17 Jan 2021 16:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QLPIfKPwYX5SNI2taLqEpDVVxuBGhm+P/85rwSfPkA8=;
        b=NLXB4ayekAjXRjsu8jPpTl41qXyhkUxkvb9o9/yqhHOEvKgQLslVlGJTIkcv43BLPo
         ckHAExViue2jU8DBzie491RWKnMhqsXdxS/tDTZFx7xVk/k19DCpdQlaHfuJxmXLOpSc
         YBwjBXA+lsfIwLDjyPvGlefi1VSwyManWxk8a8Zmr1luEFR4xjvf7lus6NkMwC2U9CPX
         f6XJ380gSwfeXvIGk0xlB90wG82wDFtwr9ep+4SNtUrodQrRXq4l0ZmTw8dAW0IHokTh
         7LfFYxibouKAHxYMZu8BQqEJ+x7Oi5ytajf/nTVjyafFf8YYMZP98bM1Z9v9fPEKaBvx
         mJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QLPIfKPwYX5SNI2taLqEpDVVxuBGhm+P/85rwSfPkA8=;
        b=lge/uy+7m9Rey0rinBnAnqCt8/4ZPq+wHkoasRBr7+eEzOOFeYurnzN3Qt1PV1xTiw
         g7Enj4Z4M2cYtpY3xm8cPO/o4yVeLLOFLTMg+7xFWZhrMaX2GoO5VQiLJ4BLFXFKXN5y
         8sigVrRHaP0DsrmAucKob1N0XAG9BmVPdLPVqIb+6YyPyRxcn9LDz9RX393evsOHuUgS
         7t4G33z0tZGlZ+jBp4cM0JBBR+2iCXQCQmgblT9xR8p4b/VOpzfY7LYYa8zfD5106QoW
         JTUfQKG4obLsaaAteC8bz3Yq4yYbOKuSJaEVjw9n8RfB7xC/km+AEQdRmo0xIrI27KIz
         cFyg==
X-Gm-Message-State: AOAM530UBmROfCX2ARtpVVgHHxUCpJTuq4RC581Ci8v404TWzxmxsJZ1
        Vm67R/fsktwwt7P8h+ZjQ8I=
X-Google-Smtp-Source: ABdhPJycsd/DptfAMvflHjHcqyL5YTSyHEYOaBxhLvtXy18zfMIe8CFN1aBbB4IBWFgNf3huq4l9+A==
X-Received: by 2002:a19:651a:: with SMTP id z26mr9970794lfb.306.1610931343400;
        Sun, 17 Jan 2021 16:55:43 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id m24sm1484553ljj.62.2021.01.17.16.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 16:55:43 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 09/12] opp: Add devm_pm_opp_attach_genpd
Date:   Mon, 18 Jan 2021 03:55:21 +0300
Message-Id: <20210118005524.27787-10-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118005524.27787-1-digetx@gmail.com>
References: <20210118005524.27787-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add resource-managed version of dev_pm_opp_attach_genpd().

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c     | 35 +++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  8 ++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 8e0d2193fd5f..49419ab9fbb4 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2891,3 +2891,38 @@ devm_pm_opp_register_set_opp_helper(struct device *dev,
 	return opp_table;
 }
 EXPORT_SYMBOL_GPL(devm_pm_opp_register_set_opp_helper);
+
+static void devm_pm_opp_detach_genpd(void *data)
+{
+	dev_pm_opp_detach_genpd(data);
+}
+
+/**
+ * devm_pm_opp_attach_genpd - Attach genpd(s) for the device and save virtual device pointer
+ * @dev: Consumer device for which the genpd is getting attached.
+ * @names: Null terminated array of pointers containing names of genpd to attach.
+ * @virt_devs: Pointer to return the array of virtual devices.
+ *
+ * This is a resource-managed version of dev_pm_opp_attach_genpd().
+ *
+ * Return: pointer to 'struct opp_table' on success and errorno otherwise.
+ */
+struct opp_table *
+devm_pm_opp_attach_genpd(struct device *dev, const char **names,
+			 struct device ***virt_devs)
+{
+	struct opp_table *opp_table;
+	int err;
+
+	opp_table = dev_pm_opp_attach_genpd(dev, names, virt_devs);
+	if (IS_ERR(opp_table))
+		return opp_table;
+
+	err = devm_add_action_or_reset(dev, devm_pm_opp_detach_genpd,
+				       opp_table);
+	if (err)
+		return ERR_PTR(err);
+
+	return opp_table;
+}
+EXPORT_SYMBOL_GPL(devm_pm_opp_attach_genpd);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 6de5853aaada..eefd0b15890c 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -170,6 +170,7 @@ void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_sync_regulators(struct device *dev);
 int dev_pm_opp_set_voltage(struct device *dev, struct dev_pm_opp *opp);
 struct opp_table *devm_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
+struct opp_table *devm_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
 #else
 static inline struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
 {
@@ -436,6 +437,13 @@ devm_pm_opp_register_set_opp_helper(struct device *dev,
 	return ERR_PTR(-ENOTSUPP);
 }
 
+static inline struct opp_table *
+devm_pm_opp_attach_genpd(struct device *dev, const char **names,
+			 struct device ***virt_devs)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 #endif		/* CONFIG_PM_OPP */
 
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
-- 
2.29.2


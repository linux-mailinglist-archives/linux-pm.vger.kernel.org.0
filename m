Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB61740F73
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jun 2023 12:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjF1K52 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jun 2023 06:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjF1K5B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jun 2023 06:57:01 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F395D1BC3
        for <linux-pm@vger.kernel.org>; Wed, 28 Jun 2023 03:56:59 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so661345566b.2
        for <linux-pm@vger.kernel.org>; Wed, 28 Jun 2023 03:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687949818; x=1690541818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoU70+X2sNAFT4uGxGgFO5/mS/RvfhIZM1VSnqbKkks=;
        b=yNEfLuqzNx3cDoeEIY88b/nsT6aiugtedzyOR3wsqjxHzkEQiowKXnpCBRhuwR9Wh4
         2n5Sty5d3XHO9IkbQGkjaA3oUBZmdd4M2kalIZ+Sx6YoNSHqfvpho8+Squ1SEI+0iicU
         C5IP8OpT6/Eatnl6e4TdQWRpO5kunzN7/oXqe/BuZiypVnAUHtTuQop+ImQEMtPc5/ry
         ttBECp71sF05RWR3lsUih+oo0nCBZiNSlazXjtrgr9HwD8OyvNaLHJUSTR0Y8LMLp61g
         e1JVCQGqDCXKcqIcTgOcq1j3yEa6GZi9OdCjdNnYpNfhF6ifAisG+6+afub0kkczzd+N
         13vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687949818; x=1690541818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoU70+X2sNAFT4uGxGgFO5/mS/RvfhIZM1VSnqbKkks=;
        b=M2A1d+sgTQN+BXAdpGh+s6toun1iFvOBT0bPcJHK8H7SLQWUWa70A39Ri0pyMqKaOR
         008O/hNJCxlcaEikfYWx5bOkutk45Di5FohSzZG8kunr0UGgiADwMqShpmIQiWSBozd2
         tKqAVciNb+SmEr36nd5OGegA1a4Tib9NHiB12kXLfDPMKVGVO3ptfaaOjHzCJln6Ul7v
         dKMuc/ByOKvsjtfkWZXJk8bXUPqvsrpYaImNDTUWOPnCePRW+Ih952sWkc1stI4igi/f
         IlRnbSCA6FZU/94WS83c2MZ2cyVmGUpUQbpAerisnyowQaDefsx/JjfSr3YsJ7VGp9Yu
         oQNg==
X-Gm-Message-State: AC+VfDzPAt4KUA1lcTTy4fM+/S+E5GQ/35EeboBBe4PJbDiXuk1S9bLD
        58Xhr6TMrJeFTXWCltxwRJMYmg==
X-Google-Smtp-Source: ACHHUZ5R8auDPDyKq0JTaO686eE46cVC/Q3aPkg5gZJ1ek6Fc754AwN952k1QIbJx2Ey9n3wIrfCEw==
X-Received: by 2002:a17:906:da8b:b0:982:26c5:6525 with SMTP id xh11-20020a170906da8b00b0098226c56525mr34333689ejb.60.1687949818190;
        Wed, 28 Jun 2023 03:56:58 -0700 (PDT)
Received: from hackbox.lan ([62.231.110.100])
        by smtp.gmail.com with ESMTPSA id e8-20020a1709062c0800b0098921e1b064sm5544678ejh.181.2023.06.28.03.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 03:56:57 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        avel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/2] PM: domains: Allow devices attached to genpd to be managed by HW
Date:   Wed, 28 Jun 2023 13:56:51 +0300
Message-Id: <20230628105652.1670316-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628105652.1670316-1-abel.vesa@linaro.org>
References: <20230628105652.1670316-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Some power-domains may be capable of relying on the HW to control the power
for a device that's hooked up to it. Typically, for these kinds of
configurations the device doesn't really need to be attached to a PM domain
(genpd), from Linux point of view. However, in some cases the behaviour of
the power-domain and its device can be changed in runtime.

To allow a consumer driver to change the behaviour of the PM domain for its
device, let's provide a new function, dev_pm_genpd_set_hwmode(). Moreover,
let's add a corresponding optional genpd callback, ->set_hwmode_dev(),
which the genpd provider should implement if it can support switching
between HW controlled mode and SW controlled mode.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/base/power/domain.c | 66 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   | 15 +++++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 5cb2023581d4..23286853d1d0 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -541,6 +541,72 @@ void dev_pm_genpd_synced_poweroff(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_genpd_synced_poweroff);
 
+/**
+ * dev_pm_genpd_set_hwmode - Set the HW mode for the device and its PM domain.
+ *
+ * @dev: Device for which the HW-mode should be changed.
+ * @enable: Value to set or unset the HW-mode.
+ *
+ * Some PM domains can rely on HW signals to control the power for a device. To
+ * allow a consumer driver to switch the behaviour for its device in runtime,
+ * which may be beneficial from a latency or energy point of view, this function
+ * may be called.
+ *
+ * It is assumed that the users guarantee that the genpd wouldn't be detached
+ * while this routine is getting called.
+ *
+ * Returns 0 on success and negative error values on failures.
+ */
+int dev_pm_genpd_set_hwmode(struct device *dev, bool enable)
+{
+	struct generic_pm_domain *genpd;
+	int ret = 0;
+
+	genpd = dev_to_genpd_safe(dev);
+	if (!genpd)
+		return -ENODEV;
+
+	if (!genpd->set_hwmode_dev)
+		return -EOPNOTSUPP;
+
+	genpd_lock(genpd);
+
+	if (dev_gpd_data(dev)->hw_mode == enable)
+		goto out;
+
+	ret = genpd->set_hwmode_dev(genpd, dev, enable);
+	if (!ret)
+		dev_gpd_data(dev)->hw_mode = enable;
+
+out:
+	genpd_unlock(genpd);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_set_hwmode);
+
+/**
+ * dev_pm_genpd_get_hwmode - Get the HW mode setting for the device.
+ *
+ * @dev: Device for which the current HW-mode setting should be fetched.
+ *
+ * This helper function allows consumer drivers to fetch the current HW mode
+ * setting of its the device.
+ *
+ * It is assumed that the users guarantee that the genpd wouldn't be detached
+ * while this routine is getting called.
+ */
+bool dev_pm_genpd_get_hwmode(struct device *dev)
+{
+	struct generic_pm_domain *genpd;
+
+	genpd = dev_to_genpd_safe(dev);
+	if (!genpd)
+		return false;
+
+	return dev_gpd_data(dev)->hw_mode;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_get_hwmode);
+
 static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 {
 	unsigned int state_idx = genpd->state_idx;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f776fb93eaa0..8f60c36851d5 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -146,6 +146,8 @@ struct generic_pm_domain {
 	int (*set_performance_state)(struct generic_pm_domain *genpd,
 				     unsigned int state);
 	struct gpd_dev_ops dev_ops;
+	int (*set_hwmode_dev)(struct generic_pm_domain *domain,
+			      struct device *dev, bool enable);
 	int (*attach_dev)(struct generic_pm_domain *domain,
 			  struct device *dev);
 	void (*detach_dev)(struct generic_pm_domain *domain,
@@ -208,6 +210,7 @@ struct generic_pm_domain_data {
 	unsigned int performance_state;
 	unsigned int default_pstate;
 	unsigned int rpm_pstate;
+	bool hw_mode;
 	void *data;
 };
 
@@ -237,6 +240,8 @@ int dev_pm_genpd_remove_notifier(struct device *dev);
 void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next);
 ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev);
 void dev_pm_genpd_synced_poweroff(struct device *dev);
+int dev_pm_genpd_set_hwmode(struct device *dev, bool enable);
+bool dev_pm_genpd_get_hwmode(struct device *dev);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -305,6 +310,16 @@ static inline ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev)
 static inline void dev_pm_genpd_synced_poweroff(struct device *dev)
 { }
 
+static inline int dev_pm_genpd_set_hwmode(struct device *dev, bool enable)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline bool dev_pm_genpd_get_hwmode(struct device *dev)
+{
+	return false;
+}
+
 #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
 #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
 #endif
-- 
2.34.1


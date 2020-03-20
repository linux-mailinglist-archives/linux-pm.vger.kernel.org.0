Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5F7818C4AF
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 02:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgCTBlO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 21:41:14 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41499 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbgCTBlO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 21:41:14 -0400
Received: by mail-qk1-f193.google.com with SMTP id q188so82967qke.8
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 18:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eW/OFJFoFR7v20uQTXTPh54Gfwm5+Kkq94S8j8KRbyc=;
        b=KHAAHrhj23E533BBgqVy2TKK9CkcDC+OiwALUwXvFo6SAi2TVKs1mJB2WM2g78Mz6K
         SH/hEEVBv5Y/WYM3+X5xyw1FJGPxEUlGxbd6NNOwmDpuyPWp92lwuI8U17HEADuXTbZ9
         tmCPLEI1tftEfJRlRIBot9aYl60W4ZdMhhrO5xS8nxxi14JlOS/mMusF2gDpc9QwFiO8
         ujIKx79Ob+MgNtBJHwRv/Nyycj3yhy/sh6f06kdZsCIYTSQzyusrpvVFEthtiBdHJ/Yz
         iUFL7ZufL460bMxi9slNvBYv7269HUi7Taz/6OtXN7BSuqhCoGJZMeuul74pHhwn8HCC
         eRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eW/OFJFoFR7v20uQTXTPh54Gfwm5+Kkq94S8j8KRbyc=;
        b=Dc1RjmKKuHpUHaLaBA9xtdSKpUwCa8YBZHJ6DBXbijsESoyVy5MJdV1PHEOLH/t5vM
         d861s09XT04wD21tDfG3XRnEtjKK31Adb0ZwTteOeu7ktfBD4xR2Onrx8Z3f/zSWyCBY
         l0c39/NXfT48fpoDWzeHdnOnYWwMcJFlG62TZvoTSCjJe3+ERR0fOfHb3xA7gqv6I0bd
         jYgn9LHwkVBykcqehViQo4ULdy1xuUr9p67CC+UF0fMof1YxpyenaSwNW1ZDtMLSGekk
         R35wyMhCiWeNOlB+7XDSWsRozlnE7rMFFg2Qr7iqizC3pbsyxloVpQs1cO758s6eX/nN
         GF8g==
X-Gm-Message-State: ANhLgQ2pm5VWmDMILBO1eDuhGTPGaVScvqETq4j2KwLSYMtTOiRmBtHL
        T8lN5F25PjRw3y79mQrXLRxXNg==
X-Google-Smtp-Source: ADFU+vupj+aipcr9NvAb73NIy/bo48Y/CMGZJQO1EeS20z8InsstfuNlICLQGUkvjfuN2dcNGNPp7w==
X-Received: by 2002:a05:620a:4e:: with SMTP id t14mr5845072qkt.122.1584668471016;
        Thu, 19 Mar 2020 18:41:11 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 2sm2706287qtp.33.2020.03.19.18.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 18:41:10 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v5 1/6] PM/Domains: Add support for retrieving genpd performance states information
Date:   Thu, 19 Mar 2020 21:41:02 -0400
Message-Id: <20200320014107.26087-2-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320014107.26087-1-thara.gopinath@linaro.org>
References: <20200320014107.26087-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add two new APIs in the genpd framework, dev_pm_genpd_get_performance_state
to return the current performance state of a power domain and
dev_pm_genpd_performance_state_count to return the total number of
performance states supported by a power domain. Since the genpd framework
does not maintain a count of number of performance states supported by a
power domain, introduce a new callback(.get_performance_state_count) that
can be used to retrieve this information from power domain drivers.

These APIs are added to aid the implementation of a power domain as a
warming device. Linux kernel cooling device framework(into which warming
device can be plugged in) requires during initialization to be provided
with the maximum number of states that can be supported. When a power
domain acts as a warming device, the max state is the max number of
perfomrance states supported by the power domain. The cooling device
framework implements API to retrieve the current state of the cooling
device. This in turn translates to the current performance state of the
power domain.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/base/power/domain.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   | 13 +++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 959d6d5eb000..d0297c48fa79 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -408,6 +408,43 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 }
 EXPORT_SYMBOL_GPL(dev_pm_genpd_set_performance_state);
 
+int dev_pm_genpd_get_performance_state(struct device *dev)
+{
+	struct generic_pm_domain *genpd;
+	unsigned int state;
+
+	genpd = dev_to_genpd_safe(dev);
+	if (IS_ERR(genpd))
+		return -ENODEV;
+
+	genpd_lock(genpd);
+	state = genpd->performance_state;
+	genpd_unlock(genpd);
+
+	return state;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_get_performance_state);
+
+int dev_pm_genpd_performance_state_count(struct device *dev)
+{
+	struct generic_pm_domain *genpd;
+	int count;
+
+	genpd = dev_to_genpd_safe(dev);
+	if (IS_ERR(genpd))
+		return -ENODEV;
+
+	if (unlikely(!genpd->get_performance_state_count))
+		return -EINVAL;
+
+	genpd_lock(genpd);
+	count = genpd->get_performance_state_count(genpd);
+	genpd_unlock(genpd);
+
+	return count;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_performance_state_count);
+
 static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 {
 	unsigned int state_idx = genpd->state_idx;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 9ec78ee53652..7d415350380f 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -117,6 +117,7 @@ struct generic_pm_domain {
 						 struct dev_pm_opp *opp);
 	int (*set_performance_state)(struct generic_pm_domain *genpd,
 				     unsigned int state);
+	int (*get_performance_state_count)(struct generic_pm_domain *genpd);
 	struct gpd_dev_ops dev_ops;
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	bool max_off_time_changed;
@@ -204,6 +205,8 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 		  struct dev_power_governor *gov, bool is_off);
 int pm_genpd_remove(struct generic_pm_domain *genpd);
 int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
+int dev_pm_genpd_get_performance_state(struct device *dev);
+int dev_pm_genpd_performance_state_count(struct device *dev);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -251,6 +254,16 @@ static inline int dev_pm_genpd_set_performance_state(struct device *dev,
 	return -ENOTSUPP;
 }
 
+static inline int dev_pm_genpd_get_performance_state(struct device *dev)
+{
+	return -ENOTSUPP;
+}
+
+static inline int dev_pm_genpd_performance_state_count(struct device *dev)
+{
+	return -ENOTSUPP;
+}
+
 #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
 #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
 #endif
-- 
2.20.1


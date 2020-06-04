Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0461EDAD1
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jun 2020 03:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgFDBxX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jun 2020 21:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgFDBxW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2020 21:53:22 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FBFC08C5C1
        for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2020 18:53:22 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f18so4524087qkh.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2020 18:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OXFBxnWXYnn/70SvWtr9K2MHoufkLsFwRRiIi6zZBfk=;
        b=TTHUNmNTBK6ssrGE4vNIHuoGl36/IKA184BiSEt8dXIB0bXbrx0XulkgtaLviqMvuW
         tiIHAKyJPYZreacCzAGf8kljq9QG3N1PG/bNUFHp6FKanpARhYnd1lj2lOa6FWJptBym
         L3dMIgXoBnK89BgeVPpe8GHacwrkCx5LaXP0Aq0Xj0HBxajAOPuALcf5U/FjaB+Z1voT
         vf9KlCpD5m6T105XsMMrDnc2eE2+NRpCmzy6IkeydAUxAPeb6uqYMzZgBWZcU5IkBZgX
         EYrGk3+RyAqITb8mgfYGzzvQrK11Ct5wGRbMIFnMdg3+5dZJ1/4HOLZ606IzJqO/iePB
         GkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OXFBxnWXYnn/70SvWtr9K2MHoufkLsFwRRiIi6zZBfk=;
        b=J84jEtQBt6fAC1zfASxNA/ETrYnOG/lRzZUhtFPjpPV06obFR9YURW2ua0roPfkSt9
         eeLBMnzxorKlBP/ZJGcL08olfLcvsyErkeWsuZzfQUPuTSDoIXq8Q9ghQZ3P0K/rcgIA
         Gm/hjz+x6uoCUyy3weTCeGPin6XIf28oiiFxlxJG92aXQp2F2+WudMIIyZx2VYEypbTz
         ROhtu4GfqAxKaAui2pF3X64+07a6kvttlDYn+KpWFFNgiSevwDrD0H+duOs1doNZodIw
         45qvANFIq15TQllx1TfidcOjyrYhy7qD8oxk+X1/yG/P3qWd+pjNyu+w5sfTOa3vjdn7
         35Sw==
X-Gm-Message-State: AOAM5323K9y54M2rhWTQ55kdQIgWpc3ck/PfNt0stZAmL+e8ecIdyWrL
        eSsvDxMRLy+3NmtARL5+f+s0Ow==
X-Google-Smtp-Source: ABdhPJxtYPvU4sjsI6bm1cB56yIjkZm4HSRbup9Y6NQzxcUlyQ8iJvQmJ9f/YKDFoggQ1o/Vl5DgyA==
X-Received: by 2002:a05:620a:15a5:: with SMTP id f5mr2710795qkk.9.1591235601365;
        Wed, 03 Jun 2020 18:53:21 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id t74sm2986439qka.21.2020.06.03.18.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 18:53:19 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/6] PM/Domains: Add support for retrieving genpd performance states information
Date:   Wed,  3 Jun 2020 21:53:12 -0400
Message-Id: <20200604015317.31389-2-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200604015317.31389-1-thara.gopinath@linaro.org>
References: <20200604015317.31389-1-thara.gopinath@linaro.org>
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

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/base/power/domain.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   | 13 +++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 0a01df608849..88f8773cabe7 100644
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


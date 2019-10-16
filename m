Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD24ED9A51
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 21:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394440AbfJPThb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 15:37:31 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46310 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394412AbfJPThb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 15:37:31 -0400
Received: by mail-qt1-f193.google.com with SMTP id u22so37881113qtq.13
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 12:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O+e4P1QVmJfIMHeM4ld6pm/7hZNUvEAXXUg+herLbDU=;
        b=Km01FxsNsfs4bfJReg3ItWzLtqe5B6Zko3KM06evWv/KNiIuJmW3EURmoJ/YfVReQZ
         c7A8hFKcFVaNiESaiYjOmaKeunxu2c3xRSSzOFGUmgxQS0kp1RktUlidPtxe0YcrIOB9
         RfFmTETa21tkhEcOJP1oxGYwqhQLtuzYcVAb+d2UTJ2HsSeoga+fmks2RbmozcyQ2Wn0
         aOXeRGC+taFMKVC0+n0/yfgy/EwaN4/xMApY87zkJ85mivUwoP24IsR1Mj6c8/v95PzF
         VefQlrEBYFzukAc13s2m7vmLxBrmkbI8rWah6tlJOWbcvHvrNLIG5pV3D/dzaflP+QEh
         fyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O+e4P1QVmJfIMHeM4ld6pm/7hZNUvEAXXUg+herLbDU=;
        b=hH5KUCOeAopD2KKHjMgXKObPwb2FU9FOIkp4pPm55jYwMHGvuEqQaUn88zBCeIAkmU
         zCceGdOhGxeTP40IYGmDW+VJ/ZNsGv3IEKOyD82Ta/DgJJM41KXOMgMBuwm7WP8+HG6X
         eIUcTp2Fee8JjSLLzB8xaA6oJ3i3lKXFtYhaTnobqTp6rVVStEXJ44MahK7KBthp+VHT
         HaAhqUoqrrEa8SXpx8j41jzi8S8JAtOzS7pGsVRefcV/zOPdK55bS+809ABy9MRnVIVd
         MXytUkTgT0x83Wyufrc9w8PAc5nkJ1LNm0AEQQx65Fm/erUXmZXgTh+IrLG1NtJnp1Oq
         WCSQ==
X-Gm-Message-State: APjAAAW4IyJKTxgtOi97OFr0UApFZArm+iMsLq26b2iVuQiHiW2Y1/Cf
        Q0cftVV12fEifBMdHbd2sVI1Kw==
X-Google-Smtp-Source: APXvYqx4d8MGaeFhSXxBmxyVLxEMfR5AZpspkHx5bEU9rqkDw7xUztV9xYfx5wwljwu+Ll3m5nYjiA==
X-Received: by 2002:ad4:408c:: with SMTP id l12mr42407364qvp.210.1571254649895;
        Wed, 16 Oct 2019 12:37:29 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 54sm16246030qts.75.2019.10.16.12.37.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Oct 2019 12:37:29 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] PM/Domains: Add support for retrieving genpd performance states information
Date:   Wed, 16 Oct 2019 15:37:15 -0400
Message-Id: <1571254641-13626-2-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add two new APIs in the genpd framework,
dev_pm_genpd_get_performance_state to return the current performance
state of a power domain and dev_pm_genpd_performance_state_count to
return the total number of performance states supported by a
power domain. Since the genpd framework does not maintain
a count of number of performance states supported by a power domain,
introduce a new callback(.get_performance_state_count) that can be used
to retrieve this information from power domain drivers.

These APIs are added to aid the implementation of a power domain as
a warming device. Linux kernel cooling device framework(into which
warming device can be plugged in) requires during initialization to be
provided with the maximum number of states that can be supported. When
a power domain acts as a warming device, the max state is the max number
of perfomrance states supported by the power domain. The cooling
device framework implements API to retrieve the current state of the
cooling device. This in turn translates to the current performance
state of the power domain.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/base/power/domain.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   | 13 +++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index cc85e87..507e530 100644
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
index baf02ff..e88e57f 100644
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
2.1.4


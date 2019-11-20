Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7355D103A66
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 13:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfKTM4p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 07:56:45 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38854 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbfKTM4o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 07:56:44 -0500
Received: by mail-qt1-f194.google.com with SMTP id p20so28806208qtq.5
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 04:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e3cBvCJGRcxYKob0R3G9a3fkI3S2TOmBRjT4BE52Zwg=;
        b=ArXeuvGpoBlrfpILMx/M83+Zn/RbRWXihN50pPnTAw2ZLLkb/hp/kzXGE4e3pJcJ3R
         gsYaNqlAFKy0EJHJMMUsBRCdN68xbd0/u9HLA/lwkwTiRIie2u8OQ4ubtENtMbs+NnKA
         Cmru7KlvSqU/6oQTWAAxXSVXZ6dwfTVAU3AzwldjvPeVnpnzaSmGsFp5a7oWXickOmYY
         lTxHgbpbFs/+r9OWV46swlR8FLMWOQm2U4HrrqbOFOYw4nt/ffV6HidWqcKbMNWUSzi9
         AvukxXBhZ5W7XQoSKlFGkGDOkaR04e6y3vxHPJgKzQqCIvZauZdPMGjAh/jNQPeUlWKf
         7XSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e3cBvCJGRcxYKob0R3G9a3fkI3S2TOmBRjT4BE52Zwg=;
        b=O3U8N2FrXLMPTdy5MrhDjahoK3mCuZSUzYKB2I9Piry3zAfhJ21nX5/WfrRccwKM2Y
         Bs7qrExEV1SkJEV3AU77xeHh/SZfaCeLUYphITsx55ZZbIOApu4VHbi5+3+uTw7GJ6ft
         nBlUw3fKngoo8/fiUyERkfNU0FitZemSi0Lpo1FH9ti/PVa1IktrPYU32f8NnC1X0Uh6
         Y7+HUP4Qw9VoF9ZRcadyucoKVUNSf3tDlDT2+8HM7pb+V70tvmRj0roIObPHDX+wSJz2
         Nyl6yjtR27vi5n6K31BZTFo5F10j2VEuAwORrSkShhwjMWjSaTFHHKrmUal3WFmelCTb
         bqSw==
X-Gm-Message-State: APjAAAWkBm1NU8/dDUtpMr713wSSDitE6yB6yvSYADZ8HPlsFk5oeH/O
        7ZxFjzxgEPNg5bmAhUXGr4tnyg==
X-Google-Smtp-Source: APXvYqwv4OeeDPmAsbQS44jpcRMO6IRwZgLvnuiwUbOpTPEixRa4022JfwejzTFLXf6BZpU3r5bqkA==
X-Received: by 2002:aed:3c0a:: with SMTP id t10mr2434630qte.173.1574254603451;
        Wed, 20 Nov 2019 04:56:43 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id r2sm14109637qtc.28.2019.11.20.04.56.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 04:56:41 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v4 1/7] PM/Domains: Add support for retrieving genpd performance states information
Date:   Wed, 20 Nov 2019 07:56:27 -0500
Message-Id: <1574254593-16078-2-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org>
References: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org>
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


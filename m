Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE386AF03A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2019 19:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394246AbfIJROl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Sep 2019 13:14:41 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37664 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394241AbfIJROk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Sep 2019 13:14:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id g13so21235300qtj.4
        for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2019 10:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dCiF8fdi1tMlpba3ZCHWMNQTExOfXcmO5otqmXgClM8=;
        b=rEMMWt7tKcNRiWvTKf0j8I1+FhXUqpL+IcsO+vt1qt3at8FvGhG/IjobpztLqTc2ly
         C5u7tkmpXv3/FWNUziXTfgR2gAPKEatdBHwaaii1fyhFvPPzKBBn7Y2NAYclbUsxOfPD
         9gWfFRpkE3F9mbZTOUt1Zm16SZs70qyrgnrWOmT2FwsAaAokXmT71nldQrYLeX8oKnN2
         86p8hl1BXkdyw8lFZsvOQau8acRhbXjWJ25bbdtbfE6Hi49MBDpKKfhRalbaeP7IWDjE
         98CtQCue1LXh7/SpiZ3s4Xz+QXCfmijOaUy7N+ZbyKryBqcFsSB37Ks3vOyS4SonD+Um
         mQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dCiF8fdi1tMlpba3ZCHWMNQTExOfXcmO5otqmXgClM8=;
        b=qp2nPIQTPI6dxxHObDcD+DN77IF+uWd5CdysT/eWJ0ytBJuCkheXUSEldE6ZClMRD6
         namJwufHyEBNYrjnkJdG/+Pxe43nIjq9J/ESIGrvKSrGzUkLaAVHnVXXeiIh3etWlD8l
         7vIKUzfUl8kwd9UgnH2yL4Jeymx/DRhCdWSkGcPgnkABHPZXT7mDPv/TSC+sudLfqFGV
         GKKwNO149dC6Xuex2lIL2yfNQ5llL96Zgz/pyImMP4W3zfLFQtPlVuIvWBeaM9lsA85V
         AakVs9KytYJy73+WGwnliTGKHA/C9Jz1/FUKr2CjIExFaUx+ygGJ1NJWKDpujtY+P1WG
         AO5g==
X-Gm-Message-State: APjAAAU41mwKSWjCRxEZCdsC4JrNc7F+zqBu0sLjFZ5Gm0cegfJ/Xm8R
        il7Wwzxs6+WV+2pah/J+q/dB4w==
X-Google-Smtp-Source: APXvYqy13ITSCMnPbkYAN32ta5SIDhKwz2HWi8mDxmmNmTAFGAktekaQqYvXErOyQ+5qgK90anlY9A==
X-Received: by 2002:ad4:540c:: with SMTP id f12mr19282996qvt.104.1568135679638;
        Tue, 10 Sep 2019 10:14:39 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id g45sm3400713qtc.9.2019.09.10.10.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Sep 2019 10:14:39 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] PM/Domains: Add support for retrieving genpd performance states information
Date:   Tue, 10 Sep 2019 13:14:32 -0400
Message-Id: <1568135676-9328-2-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1568135676-9328-1-git-send-email-thara.gopinath@linaro.org>
References: <1568135676-9328-1-git-send-email-thara.gopinath@linaro.org>
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
v1->v2:
	- Use dev_to_genpd_safe when accessing genpd from a device pointer.
	- Change the format of dev_pm_genpd_get_performance_state and
	  dev_pm_genpd_performance_state_count to return back the requested
	  parameter rather than taking a point parameter as input.
  
 drivers/base/power/domain.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   | 13 +++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 2650ae2..126710e 100644
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


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9017E88769
	for <lists+linux-pm@lfdr.de>; Sat, 10 Aug 2019 02:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfHJA6v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 20:58:51 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40328 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfHJA6v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 20:58:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id s145so73089702qke.7
        for <linux-pm@vger.kernel.org>; Fri, 09 Aug 2019 17:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RcURVu+t1YV/Q1cDxzF4oRy+NUvqDu1q0IfrRPR3n+o=;
        b=hkbgyLEgZlD9kHpDLYWfPn3m8j+o9fzLN89GQTQxBW9BUB4FkDqyFtttetF+aCOvlw
         G0sFDZLfF72FRteULz0pNkf92NQIbb2ISdlLx4oVag42hvjYfCStB0Z9sW1R4x1k10J0
         IQmiPY4yaEV95Z+ufps543u6cREblT9A1d8THkUyhVdSqO9/x4DUipWpY1R6AbPWgs+U
         mMEgKPGvG7crdcydB5iGZ8Zc9N8+sZ42ksR1lkm5FpnqaRof0LZLBCDoSe7OKspv9cuB
         opSpXbTIxCBLskA52VzkGdi5JO8BCk14Jqr22prOnB4k9tqsMTzgg4PFBug1qj1oG4rB
         Ks4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RcURVu+t1YV/Q1cDxzF4oRy+NUvqDu1q0IfrRPR3n+o=;
        b=QmGDiFEps0bsS+bRdLrbVjLCtuN+BrP0PbNVPw73Z97frt6p5XOpbPZirnvR7EXkwJ
         eQQvRQemJ2b8ibJF7Ujm+ZhXTFnNZ90YDg4HfzPcFRBk3yCua6HjuK9gV9yF0AZbnhz6
         5dZGgyQQW9hhVje3cGkrTcas2EAGeKe/yB43FRBPIXFp3EoJkh/ki4M0GpMpRvhKsavg
         ZkEvL+eJ0TL7hgdzXa8gDIGc1cGJv9YuEu1FVQab3vNyliyZR36GC+/cDYWD69DCqto4
         fq79ZWYilynJj58q7VmfKI6ZZjWQmrR+zvNzxPFiF4CzrEFzzC4GPbTqsrh9iVd/rL8L
         AD6w==
X-Gm-Message-State: APjAAAUBiG4WjROb8SXWcq3KMNCY8Ul9aiaIlKoFx0ExhZZW9UBEvi+d
        AQXd52KlyGL0pxtY7N7zIIWWqg==
X-Google-Smtp-Source: APXvYqwVqWXUdgiaKatp6y0R5w7NOxvyJ9rSIcXqQHuu5nuLRot0Gi9mKVL4M3XDJ0n3Mb4tsjDu3Q==
X-Received: by 2002:a37:8a81:: with SMTP id m123mr20602707qkd.360.1565398730185;
        Fri, 09 Aug 2019 17:58:50 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.googlemail.com with ESMTPSA id t9sm4603105qtr.29.2019.08.09.17.58.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Aug 2019 17:58:49 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     qualcomm-lt@lists.linaro.org, linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        rnayak@codeaurora.org
Subject: [PATCH 1/4] PM/Domains: Add support for retrieving genpd performance states information
Date:   Fri,  9 Aug 2019 20:58:44 -0400
Message-Id: <1565398727-23090-2-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1565398727-23090-1-git-send-email-thara.gopinath@linaro.org>
References: <1565398727-23090-1-git-send-email-thara.gopinath@linaro.org>
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

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/base/power/domain.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   | 18 ++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index b063bc4..17e0375 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -413,6 +413,44 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 }
 EXPORT_SYMBOL_GPL(dev_pm_genpd_set_performance_state);
 
+int dev_pm_genpd_get_performance_state(struct device *dev,
+				       unsigned int *state)
+{
+	struct generic_pm_domain *genpd;
+
+	genpd = dev_to_genpd(dev);
+	if (IS_ERR(genpd))
+		return -ENODEV;
+
+	genpd_lock(genpd);
+	*state = genpd->performance_state;
+	genpd_unlock(genpd);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_get_performance_state);
+
+int dev_pm_genpd_performance_state_count(struct device *dev,
+					 unsigned int *count)
+{
+	struct generic_pm_domain *genpd;
+	int ret;
+
+	genpd = dev_to_genpd(dev);
+	if (IS_ERR(genpd))
+		return -ENODEV;
+
+	if (unlikely(!genpd->get_performance_state_count))
+		return -EINVAL;
+
+	genpd_lock(genpd);
+	ret = genpd->get_performance_state_count(genpd, count);
+	genpd_unlock(genpd);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_performance_state_count);
+
 static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 {
 	unsigned int state_idx = genpd->state_idx;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 91d9bf4..0e5f502 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -117,6 +117,8 @@ struct generic_pm_domain {
 						 struct dev_pm_opp *opp);
 	int (*set_performance_state)(struct generic_pm_domain *genpd,
 				     unsigned int state);
+	int (*get_performance_state_count)(struct generic_pm_domain *genpd,
+					   unsigned int *count);
 	struct gpd_dev_ops dev_ops;
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	bool max_off_time_changed;
@@ -204,6 +206,10 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 		  struct dev_power_governor *gov, bool is_off);
 int pm_genpd_remove(struct generic_pm_domain *genpd);
 int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
+int dev_pm_genpd_get_performance_state(struct device *dev,
+				       unsigned int *state);
+int dev_pm_genpd_performance_state_count(struct device *dev,
+					 unsigned int *count);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -251,6 +257,18 @@ static inline int dev_pm_genpd_set_performance_state(struct device *dev,
 	return -ENOTSUPP;
 }
 
+static inline int dev_pm_genpd_get_performance_state(struct device *dev,
+						     unsigned int *state);
+{
+	return -ENOTSUPP;
+}
+
+static inline int dev_pm_genpd_performance_state_count(struct device *dev,
+						       unsigned int *count);
+{
+	return -ENOTSUPP;
+}
+
 #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
 #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
 #endif
-- 
2.1.4


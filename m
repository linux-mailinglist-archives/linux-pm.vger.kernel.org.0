Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28C748876A
	for <lists+linux-pm@lfdr.de>; Sat, 10 Aug 2019 02:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfHJA6w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 20:58:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40974 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfHJA6w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 20:58:52 -0400
Received: by mail-qk1-f195.google.com with SMTP id g17so2401634qkk.8
        for <linux-pm@vger.kernel.org>; Fri, 09 Aug 2019 17:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=13LVANg+Nc4wFsq66FKdnpOxcNuSuCvqcBPgkyt37SU=;
        b=fkj1qM9fpuWVUyr8YFX96K/2OyizzEfajg6DpswTKkG/OhVeSk2Fc+uduUGyGafahx
         qEncxtkTPQmbq2yn6z4WOIm34roKXlIk1qnKVZx26SDb6Zu60Do/RIPcilBsUR3n6COx
         LdvK6eX0x75jB5f0AfwKR3PkNk1jVmVFnPUOUNnHvlavHjYrazxS9c7jJxYsn6vPy/Nh
         xdDHeO2W78Q8iIf/uQqfICn3+ujmhZxFZK66apZFPSas95MfmuIrSjcSgzIMf7wyyiPS
         dGz3da4NQjrVYfK6kI8mF4S2uF7QVTLAQ9N4Do7DPs5Kgyszx+8eBVLfOgOIjsJWR0+X
         XngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=13LVANg+Nc4wFsq66FKdnpOxcNuSuCvqcBPgkyt37SU=;
        b=bramyJozsIEeScA7TZGFhVaofFEJWdyq6rKsmp7s8ENs1Y6WdRGSW48aAqBDyDgbQa
         hYEcfeSm++CuRhyb+u/zM69Ycin+m6vmBsSQoAacUiGcfwqT7RZcmuD4COxSrlA+X7p+
         NYal3BDHm7KyHUTkWd2rdPf8iAlni/gsngCH7uCpf2Zw+iKAPCg1J4ca+yHt+jtAl4Uz
         6dI/b+RHvcSNpzr4n+DHvFduGj9+NeFsYJ0LQqsk7MDP6vzGIn8avu1fLGrR4AcRhb5T
         ykywrzbuMp04lLxCC39X+V8KmKAfxfg4uNq9PieAw/Nnpp3s6AkPl8wVzupp5G+mC0ja
         RcLQ==
X-Gm-Message-State: APjAAAV9YxYXhU/daIQ8/LqlG6Td/BdxCkIY8Ene7QQhwMiqtqeps2sJ
        t8D/FicLZrxCOf63B8cUF7rujQ==
X-Google-Smtp-Source: APXvYqwPfw5tMPGmDonH9R3MweBxvO62aCmlCy7dkPhWpJ1RXRRZrIs4T/MtLBqSpymfsL4nXK3Ozg==
X-Received: by 2002:a37:6905:: with SMTP id e5mr14664658qkc.121.1565398731271;
        Fri, 09 Aug 2019 17:58:51 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.googlemail.com with ESMTPSA id t9sm4603105qtr.29.2019.08.09.17.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Aug 2019 17:58:50 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     qualcomm-lt@lists.linaro.org, linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        rnayak@codeaurora.org
Subject: [PATCH 2/4] soc: qcom: rpmhpd: Introduce function to retrieve power domain performance state count
Date:   Fri,  9 Aug 2019 20:58:45 -0400
Message-Id: <1565398727-23090-3-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1565398727-23090-1-git-send-email-thara.gopinath@linaro.org>
References: <1565398727-23090-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Populate .get_performace_state_count in genpd ops to retrieve the count
of performance states supported by a rpmh power domain.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/soc/qcom/rpmhpd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 5741ec3..c3ceffd 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -285,6 +285,15 @@ static unsigned int rpmhpd_get_performance_state(struct generic_pm_domain *genpd
 	return dev_pm_opp_get_level(opp);
 }
 
+static int rpmhpd_performance_states_count(struct generic_pm_domain *domain,
+					   unsigned int *count)
+{
+	struct rpmhpd *pd = domain_to_rpmhpd(domain);
+
+	*count = pd->level_count;
+	return 0;
+}
+
 static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
 {
 	int i;
@@ -373,6 +382,8 @@ static int rpmhpd_probe(struct platform_device *pdev)
 		rpmhpds[i]->pd.power_on = rpmhpd_power_on;
 		rpmhpds[i]->pd.set_performance_state = rpmhpd_set_performance_state;
 		rpmhpds[i]->pd.opp_to_performance_state = rpmhpd_get_performance_state;
+		rpmhpds[i]->pd.get_performance_state_count =
+					rpmhpd_performance_states_count;
 		pm_genpd_init(&rpmhpds[i]->pd, NULL, true);
 
 		data->domains[i] = &rpmhpds[i]->pd;
-- 
2.1.4


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 728B4103A76
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 13:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbfKTM4s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 07:56:48 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:39426 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729958AbfKTM4r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 07:56:47 -0500
Received: by mail-qv1-f66.google.com with SMTP id v16so9641345qvq.6
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 04:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bjn8ReEOuhGj9F9W8fuw8HgClV07G2HHM36EtHpy9gw=;
        b=V3yYTK2+0pBvo3Fs29fkJr+7+mmKEYMjFkE7Ka3SjI9crrpN1l2CayK3y0m4ygetZ3
         nlTP0SZkttXLJbDk5AOuS6mH+hTEpZkfTBcG+NUhtj2fwrBaoGZCtzSWrQysLdKVzK6G
         82BJ8fTCqtLxFEutXC0gQzqzT+b5UJC7ur3ECvk4P6L6747BLjqdVCcBzBeh0GFR44xO
         TI/nl70KdWfEcZ2jjkTNH1sWgohGuRtMyxavuy530AY0D8o3H4iRL+3+s1mBeoMlYguD
         CRTIxUPLmNgN3NAZR8vYGqsc8gqU5PIQyqE51k+aXurXAhWBYR/jx70NiwU8ZN6stAVZ
         Dg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bjn8ReEOuhGj9F9W8fuw8HgClV07G2HHM36EtHpy9gw=;
        b=eQhH9mTBFMQEkF5gltT2uO4uCTkaodKpF/dMg4W0pxmZCNS+fNzn6IRs3FTEVJtFki
         HzUzjyQxr4M9TdPz2pKn/vpBh1n+hdo2ydyKzXbhrRW77X+h09poKv6PQhCxSJ25S0l9
         kEea/RZGMV1Lt5lRZxdSslRNzO3W7xHcCpvJx3Paxa0iHPcTDVx/TAzryv63hb5Dch3K
         789y9rt6mRCkUlAEFyFv7kas5m3VPkYhnSPF9HmdGgycqPMZWAifHupzGF1akha8JErF
         SGeo8+k2kx2aIUlNc9UDWJynabANuiEsF/eWsfwFN3xILO86htQessOiqYYGIE6ny83j
         /4yA==
X-Gm-Message-State: APjAAAWo5XoxjrR7WUVR/9H/r9V9DJuIVmPAUkLL/D3O+GpmmFe+Sc6S
        Lggn+WZasMwEbkKgyo7/oYiMYw==
X-Google-Smtp-Source: APXvYqxf+sKw7EwManApOCl7KSNRE1MiRk/sThSYeiR8bBGoNF0Mhv4ABmcOFKGpvjkgYskeZk0h+w==
X-Received: by 2002:a0c:e947:: with SMTP id n7mr1303514qvo.103.1574254606578;
        Wed, 20 Nov 2019 04:56:46 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id r2sm14109637qtc.28.2019.11.20.04.56.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 04:56:44 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v4 2/7] soc: qcom: rpmhpd: Introduce function to retrieve power domain performance state count
Date:   Wed, 20 Nov 2019 07:56:28 -0500
Message-Id: <1574254593-16078-3-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org>
References: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Populate .get_performace_state_count in genpd ops to retrieve the count of
performance states supported by a rpmh power domain.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/soc/qcom/rpmhpd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 5741ec3..9d37534 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -285,6 +285,13 @@ static unsigned int rpmhpd_get_performance_state(struct generic_pm_domain *genpd
 	return dev_pm_opp_get_level(opp);
 }
 
+static int rpmhpd_performance_states_count(struct generic_pm_domain *domain)
+{
+	struct rpmhpd *pd = domain_to_rpmhpd(domain);
+
+	return pd->level_count;
+}
+
 static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
 {
 	int i;
@@ -373,6 +380,8 @@ static int rpmhpd_probe(struct platform_device *pdev)
 		rpmhpds[i]->pd.power_on = rpmhpd_power_on;
 		rpmhpds[i]->pd.set_performance_state = rpmhpd_set_performance_state;
 		rpmhpds[i]->pd.opp_to_performance_state = rpmhpd_get_performance_state;
+		rpmhpds[i]->pd.get_performance_state_count =
+					rpmhpd_performance_states_count;
 		pm_genpd_init(&rpmhpds[i]->pd, NULL, true);
 
 		data->domains[i] = &rpmhpds[i]->pd;
-- 
2.1.4


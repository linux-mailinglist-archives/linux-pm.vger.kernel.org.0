Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 391FD18C4AE
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 02:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgCTBlO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 21:41:14 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41502 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbgCTBlN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 21:41:13 -0400
Received: by mail-qk1-f193.google.com with SMTP id q188so83011qke.8
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 18:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PMpp9cGV1kolIa23/+eXnHG3jYVNr7iJ09Ptby/dQWg=;
        b=iUr7LVw9yHWif+ZG2vxEMY0bR1h+bCvJ+y8Af7km3yxODyCKqGeLTuoAa94xgvtgvN
         9r/pYxzS6JQpcpWm6vPUMohRn6hsM+mnz8L/BY7V9ZuUcOl8gFc/Cl/ONKiXSl2AwYID
         4DAY+x0Q81jFcJcTVsMUpyGs/ybHm1U4GYKlV8sEh1ON90pbIijtoj5Rx3dlLn/iHT1i
         Z4A++AavvO8qdTEW/g3j1JcgA/OTnxayZveVOoI8mupFY3geIf3aEqQkt94XG3BVgW67
         AWJW6g6HffdtQsixG9lBHGPbeENRX/pNWXM5SnyOipO8XPB7/JyA4K085MljAgLQrnOA
         bWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMpp9cGV1kolIa23/+eXnHG3jYVNr7iJ09Ptby/dQWg=;
        b=Gk7IXFv74FBruKPc8oS9VULSbWfIAc/k3ArYOiA1xqyULrlGHvVgXqiIvkrzy5u2nY
         teLj2UF0nOXywQD7srMAOmYGow0UIiO4LZci264dr6BWklWLIvkGN5S9osWV7LJr1s76
         FCWJ/QU/kZhz33WmboJMeP2QjuxCkxEF1lLfBnH4QWzI+K4J3uxYTAmL9+JO36qrRScx
         I2R0DSgMWYoJKYwh5VZoi12dVa2FmlwLbFZmOSesOmfKWTbinKnqRqe7LxZV5/IxQsbX
         SnILQaChtlyXdigh8gNBMWOZG+54FZSsLUWwkEI7p4X3s04VXdt6pnf2DhBsmVsXxA3A
         nnLg==
X-Gm-Message-State: ANhLgQ3WnhNjTb/XdDbzVa1XSeeltjhHQfcxgAHmLea4SwvkxXSuc/Cq
        3b44HJvyRPTTxCY2+Ul8PG5FWg==
X-Google-Smtp-Source: ADFU+vtZPj94yZXMLwqO8JOCiKMUmJSZBqsuWIHCWksgaTY/SAPuOrMmCfd9rU2kKgjinskLZzoRhw==
X-Received: by 2002:a37:aa92:: with SMTP id t140mr5385602qke.119.1584668472463;
        Thu, 19 Mar 2020 18:41:12 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 2sm2706287qtp.33.2020.03.19.18.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 18:41:11 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v5 2/6] soc: qcom: rpmhpd: Introduce function to retrieve power domain performance state count
Date:   Thu, 19 Mar 2020 21:41:03 -0400
Message-Id: <20200320014107.26087-3-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320014107.26087-1-thara.gopinath@linaro.org>
References: <20200320014107.26087-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Populate .get_performace_state_count in genpd ops to retrieve the count of
performance states supported by a rpmh power domain.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/soc/qcom/rpmhpd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 4d264d0672c4..7142409a3b77 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -341,6 +341,13 @@ static unsigned int rpmhpd_get_performance_state(struct generic_pm_domain *genpd
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
@@ -429,6 +436,8 @@ static int rpmhpd_probe(struct platform_device *pdev)
 		rpmhpds[i]->pd.power_on = rpmhpd_power_on;
 		rpmhpds[i]->pd.set_performance_state = rpmhpd_set_performance_state;
 		rpmhpds[i]->pd.opp_to_performance_state = rpmhpd_get_performance_state;
+		rpmhpds[i]->pd.get_performance_state_count =
+					rpmhpd_performance_states_count;
 		pm_genpd_init(&rpmhpds[i]->pd, NULL, true);
 
 		data->domains[i] = &rpmhpds[i]->pd;
-- 
2.20.1


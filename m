Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 787DFD9A35
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 21:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394465AbfJPThe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 15:37:34 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36531 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394413AbfJPThd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 15:37:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id o12so37924912qtf.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 12:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E2xMtfg5bJTmZe94/qx4v5HPv3cpP1DHi2yBTTi4UXk=;
        b=yiEGyuxwygGASqd+4EnfQQXnAstv6WNIJC4tpcMTrjTHMRBlAxqUUmy3TXbQ9wu1OS
         jDd/n79uL5Fh7FnlU3t+AjYcBamWvQW9x5Fk4Wu2074XgFIzZ614l7R8FsvKfxEMRsWJ
         ITsuWypSAEltVlevAHN+PVhr+CvPw2BZNuOgs/ZRm91Ly7xpPDomQ4Rv00ssBs+cxQFg
         0B3G4r0phywCDRzo2iFnxSmyTQTnWVtEJDawys7gUkmESDhvMhbJb7XHsia+hkyAB/of
         7OowfA6qoW5J/sGNBUqAGvouMHJQYZA2yIbTy4NzsYAcJZ4oqmGDXC087MoHr6rLPfiA
         LnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E2xMtfg5bJTmZe94/qx4v5HPv3cpP1DHi2yBTTi4UXk=;
        b=HYT3Csn2+za6hItGfBhfdXKBPW6cDzMW6IZAarmd0J0ZEAlhN3Yk8YCFycz6aYu9fg
         FEmp9shVd8pT5hZQ5sMZ91K/tyqzBEiYOarNJ0Fte3up9VC5T4ykQdFotkm5vbTRjOcF
         NYAKQZVBELYIlMoswJci7EEu2RwjCdpRVYgycxo4zK5aYZYDifPgA/7fjvm1NfwDRwUt
         q2nz4T5q8UPML2OOfSBqxy/bzex+hYB4WNw1fbUcsFJqOFqS3ILdjP6O6RuEnDHTUFlL
         lI4Wm80Xd//Ypn3SPfMXHMKTB2mnkjNEH0V3TGrANfhTaFJKGS9TiZzCUAo1uv5mfRXk
         VxBQ==
X-Gm-Message-State: APjAAAVLpaISXMCLPuUpYlgDhsnGzYBhzeAWKQoKC3LLOlCt07QMO8ss
        QSCs0ze8QUX16DKCIIxIAcIuDg==
X-Google-Smtp-Source: APXvYqzM2qvnUjfMlRvsvXUMH3bvdX6uNGcU6wQ3RSuMt0JXSDsqGZCSUlK0OwltEypjlC181PH/Vg==
X-Received: by 2002:ac8:3652:: with SMTP id n18mr13523277qtb.232.1571254651349;
        Wed, 16 Oct 2019 12:37:31 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 54sm16246030qts.75.2019.10.16.12.37.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Oct 2019 12:37:30 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] soc: qcom: rpmhpd: Introduce function to retrieve power domain performance state count
Date:   Wed, 16 Oct 2019 15:37:16 -0400
Message-Id: <1571254641-13626-3-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Populate .get_performace_state_count in genpd ops to retrieve the count
of performance states supported by a rpmh power domain.

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


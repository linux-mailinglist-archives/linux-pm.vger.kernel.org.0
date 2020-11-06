Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAF42A99D7
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 17:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgKFQtb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 11:49:31 -0500
Received: from z5.mailgun.us ([104.130.96.5]:31305 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgKFQta (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Nov 2020 11:49:30 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604681370; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=SIqpORGbW4shELRaFdgQTrSokqzECNUsVNAgwqJ/78c=; b=Ud479Y5NWfTgXzgAHKrp2MVXEHENM3105vwPr9JOTu7GgVgw79WKHZ4Tqrl+YnqlEGrCmyhh
 k5sIs8IbfmIXKhDgOgRSgPtg5Rz8/pMI/KeOTuMt7Lnu3ZpxC16JjFCCeEJKzEgPBPUzwgBG
 AydO53zgYWanCLU8aA6OIYbb4eo=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5fa57e8618b2aa4b1f910e27 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 06 Nov 2020 16:49:10
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5E328C433CB; Fri,  6 Nov 2020 16:49:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D7838C433CB;
        Fri,  6 Nov 2020 16:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D7838C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     rjw@rjwysocki.net, ulf.hansson@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH] PM / Domains: replace -ENOTSUPP with -EOPNOTSUPP
Date:   Fri,  6 Nov 2020 09:49:03 -0700
Message-Id: <20201106164903.3906-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

While submitting a patch to add next_wakeup, checkpatch reported this -

WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
+       return -ENOTSUPP;

Address the above warning in other functions in pm_domain.h.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 include/linux/pm_domain.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 49982cd58bfd..e390388e6c17 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -259,24 +259,24 @@ static inline int pm_genpd_init(struct generic_pm_domain *genpd,
 }
 static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int dev_pm_genpd_set_performance_state(struct device *dev,
 						     unsigned int state)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int dev_pm_genpd_add_notifier(struct device *dev,
 					    struct notifier_block *nb)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int dev_pm_genpd_remove_notifier(struct device *dev)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
@@ -334,13 +334,13 @@ struct device *genpd_dev_pm_attach_by_name(struct device *dev,
 static inline int of_genpd_add_provider_simple(struct device_node *np,
 					struct generic_pm_domain *genpd)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int of_genpd_add_provider_onecell(struct device_node *np,
 					struct genpd_onecell_data *data)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline void of_genpd_del_provider(struct device_node *np) {}
@@ -396,7 +396,7 @@ static inline struct device *genpd_dev_pm_attach_by_name(struct device *dev,
 static inline
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
 {
-	return ERR_PTR(-ENOTSUPP);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


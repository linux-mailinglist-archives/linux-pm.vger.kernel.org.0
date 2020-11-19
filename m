Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7509E2B9856
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 17:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgKSQnl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 11:43:41 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:42320 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728077AbgKSQnl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Nov 2020 11:43:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605804220; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=xXWY11AkQl+qkoWNFqEm2VGxxmdvC3mfMPPJNFQ47Us=; b=l0cJ69SeNd3BjvWR7PIQ8t+x8vUVBppR7iEWQ8ciSaDuOdUuVt2+s889JVD7Y42HawB1fS8g
 PkgHC1bxcfUyeNPvPvh/Q4/wFpoZSu2cl4yvr2N/XTP6i353u7k3Nu3BnPAJGi4OFTOvyM8j
 QWZRfIYoHRJw/Y+Je2bysvulO+0=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5fb6a0b6b9b39088ed4688d8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 19 Nov 2020 16:43:34
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 228B2C43461; Thu, 19 Nov 2020 16:43:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F1D79C433ED;
        Thu, 19 Nov 2020 16:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F1D79C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     rjw@rjwysocki.net, ulf.hansson@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v2] PM / Domains: replace -ENOTSUPP with -EOPNOTSUPP
Date:   Thu, 19 Nov 2020 09:43:25 -0700
Message-Id: <20201119164325.9536-1-ilina@codeaurora.org>
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

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 include/linux/pm_domain.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 34a8784b0ad4..e55781333695 100644
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


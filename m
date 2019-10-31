Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA20EB6EB
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 19:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbfJaS3A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 14:29:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33632 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbfJaS27 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 14:28:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 255E360A23; Thu, 31 Oct 2019 18:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572546538;
        bh=28gXZHObDLcaUnkvLy2J2bRGCEy8fMDphUJiu2quWxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tss01mpSM/zZeGnOKAGrJSCo/3ABRZg+vdOJCk63tV1ZpoYCqAQ2hfMqYwtpu1+7v
         LkNyjzlkAmmGWa6AF/kRj1qVztb5h8Mz+dp0etjgPHuXeozgc7/wXyFKsKwFYJCYOk
         b7ipUlhi4OKA6EWUIxzl1715XmMgyQu1SFJPzXMo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 139DE60ACF;
        Thu, 31 Oct 2019 18:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572546537;
        bh=28gXZHObDLcaUnkvLy2J2bRGCEy8fMDphUJiu2quWxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ggGVru41wLxORxdTapQHvpButnQCFEmnDuZUSnnKPaLBHeBuex/sP+WIFet3z+F87
         rHO4JkkJOI2mHcpCviOj+ThLpAV+BoYRKreuKTDVEHnEm3JMtVDgrMDAEJFMw1ElmB
         UlknnN6fsK2qY5uUF426sA+PGOHsyS/EtdNM5QTE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 139DE60ACF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH v1 1/2] interconnect: Move interconnect drivers to core_initcall
Date:   Thu, 31 Oct 2019 12:28:51 -0600
Message-Id: <1572546532-19248-2-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572546532-19248-1-git-send-email-jcrouse@codeaurora.org>
References: <1572546532-19248-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The interconnect drivers are essential to nearly every leaf driver and
subcomponent in the SoC. Initialize them at the core_initcall level
so that they are available to their dependent drivers when built in.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/interconnect/qcom/msm8974.c | 14 +++++++++++++-
 drivers/interconnect/qcom/qcs404.c  | 14 +++++++++++++-
 drivers/interconnect/qcom/sdm845.c  | 13 ++++++++++++-
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
index c70ac58..9386d5c 100644
--- a/drivers/interconnect/qcom/msm8974.c
+++ b/drivers/interconnect/qcom/msm8974.c
@@ -778,7 +778,19 @@ static struct platform_driver msm8974_noc_driver = {
 		.of_match_table = msm8974_noc_of_match,
 	},
 };
-module_platform_driver(msm8974_noc_driver);
+
+static int __init msm8974_noc_driver_init(void)
+{
+	return platform_driver_register(&msm8974_noc_driver);
+}
+core_initcall(msm8974_noc_driver_init);
+
+static void __exit msm8974_noc_driver_exit(void)
+{
+	platform_driver_unregister(&msm8974_noc_driver);
+}
+module_exit(msm8974_noc_driver_exit);
+
 MODULE_DESCRIPTION("Qualcomm MSM8974 NoC driver");
 MODULE_AUTHOR("Brian Masney <masneyb@onstation.org>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index b4966d8..7dd3e76 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -535,6 +535,18 @@ static struct platform_driver qcs404_noc_driver = {
 		.of_match_table = qcs404_noc_of_match,
 	},
 };
-module_platform_driver(qcs404_noc_driver);
+
+static int __init qcs404_noc_driver_init(void)
+{
+	return platform_driver_register(&qcs404_noc_driver);
+}
+core_initcall(qcs404_noc_driver_init);
+
+static void __exit qcs404_noc_driver_exit(void)
+{
+	platform_driver_unregister(&qcs404_noc_driver);
+}
+module_exit(qcs404_noc_driver_exit);
+
 MODULE_DESCRIPTION("Qualcomm QCS404 NoC driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 502a6c2..4dab92a 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -892,7 +892,18 @@ static struct platform_driver qnoc_driver = {
 		.of_match_table = qnoc_of_match,
 	},
 };
-module_platform_driver(qnoc_driver);
+
+static int __init qnoc_driver_init(void)
+{
+	return platform_driver_register(&qnoc_driver);
+}
+core_initcall(qnoc_driver_init);
+
+static void __exit qnoc_driver_exit(void)
+{
+	platform_driver_unregister(&qnoc_driver);
+}
+module_exit(qnoc_driver_exit);
 
 MODULE_AUTHOR("David Dai <daidavid1@codeaurora.org>");
 MODULE_DESCRIPTION("Qualcomm sdm845 NoC driver");
-- 
2.7.4


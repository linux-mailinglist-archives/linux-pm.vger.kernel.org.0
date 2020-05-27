Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E821E4E15
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 21:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgE0TYu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 15:24:50 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:23763 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725306AbgE0TYt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 15:24:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590607488; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=sez9DLoTCLoV1yeYXeZwwXSuXPX1bIuNFVUeJPl9HsA=; b=MIzOuCNesGcTqSmd8N8JeJ4lvRttATgjhJPfk2MG3kSGKfi3INArde/5lmWDgntNAtsAU/Ss
 E1Zp/IUAunLl29DU9OS3hdg7ST4AUNbhA34rtH1Sroq9CVrcqBKWx3KS13wq1YTuKc1+etqR
 MV3loKK1UC7FYsJArRobCTpqGi4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5ecebe71cb045869336ec11c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 May 2020 19:24:33
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2EA7FC433A0; Wed, 27 May 2020 19:24:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 34819C433C9;
        Wed, 27 May 2020 19:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34819C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org, georgi.djakov@linaro.org
Cc:     nm@ti.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        saravanak@google.com, mka@chromium.org, smasetty@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH] OPP: Check for bandwidth values before creating icc paths
Date:   Thu, 28 May 2020 00:54:18 +0530
Message-Id: <20200527192418.20169-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Prevent the core from creating and voting on icc paths when the
opp-table does not have the bandwidth values populated. Currently
this check is performed on the first OPP node.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/opp/of.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 61fce1284f012..95cf6f1312765 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -338,6 +338,21 @@ int dev_pm_opp_of_find_icc_paths(struct device *dev,
 	struct device_node *np;
 	int ret = 0, i, count, num_paths;
 	struct icc_path **paths;
+	struct property *prop;
+
+	/* Check for bandwidth values on the first OPP node */
+	if (opp_table && opp_table->np) {
+		np = of_get_next_available_child(opp_table->np, NULL);
+		if (!np) {
+			dev_err(dev, "Empty OPP table\n");
+			return 0;
+		}
+
+		prop = of_find_property(np, "opp-peak-kBps", NULL);
+		of_node_put(np);
+		if (!prop || !prop->length)
+			return 0;
+	}
 
 	np = of_node_get(dev->of_node);
 	if (!np)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


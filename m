Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035433D159E
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jul 2021 19:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbhGUROW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Jul 2021 13:14:22 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:51839 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237346AbhGUROV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Jul 2021 13:14:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626890098; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=5dPU7wCaoRSEGtGGrTM61+mt3X7vyLAV8Dbh9+xJrHI=; b=pqh8Nu07Yyt+29N963IdnVsk4J2bsGgcoD2PEpuPTSvfyVa/KnnPNfC5CTxru41iX36Q1oF7
 QxG3i5PD8+yxTixfkm/+RItBrPpnoyXYTNlnSFOg7ibDJ5NypO/IaTyxO8P/eBfcIvyOhbJf
 e0DjaDL6yvN+Fm3GbsoYf4K8VgY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60f85f60290ea35ee67b346e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 17:54:40
 GMT
Sender: mdtipton=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C4B12C4360C; Wed, 21 Jul 2021 17:54:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 90162C433F1;
        Wed, 21 Jul 2021 17:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 90162C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     djakov@kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        saravanak@google.com, okukatla@codeaurora.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH v2 1/4] interconnect: Zero initial BW after sync-state
Date:   Wed, 21 Jul 2021 10:54:29 -0700
Message-Id: <20210721175432.2119-2-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210721175432.2119-1-mdtipton@codeaurora.org>
References: <20210721175432.2119-1-mdtipton@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The initial BW values may be used by providers to enforce floors. Zero
these values after sync-state so that providers know when to stop
enforcing them.

Fixes: b1d681d8d324 ("interconnect: Add sync state support")
Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
---
 drivers/interconnect/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 8a1e70e00876..945121e18b5c 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1106,6 +1106,8 @@ void icc_sync_state(struct device *dev)
 		dev_dbg(p->dev, "interconnect provider is in synced state\n");
 		list_for_each_entry(n, &p->nodes, node_list) {
 			if (n->init_avg || n->init_peak) {
+				n->init_avg = 0;
+				n->init_peak = 0;
 				aggregate_requests(n);
 				p->set(n, n);
 			}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


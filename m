Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A34E41D743
	for <lists+linux-pm@lfdr.de>; Thu, 30 Sep 2021 12:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349756AbhI3KLQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Sep 2021 06:11:16 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:24959 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349774AbhI3KLQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Sep 2021 06:11:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632996573; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=E1AIzzsSn5azqCzofW1zjFrXokehguwfbLDDQiqkgO8=; b=FHd5H64ncEPFIp3DEk2XKRceZLYEXsfRLLjUx+DA+J5H0X+SVtn5ZPGcCynDx4ML7vXBDeeV
 2DcLNSxBEjeuFujX8lKSbdLgqQSuYK4EYYZo4eKcngr2E9y2wL9alNQUMAtSvgrwVPE2LRyh
 f26t/+bdcTmIvtvNvv84ZZeD2P4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 61558cdd47d64efb6df8cf3c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 30 Sep 2021 10:09:33
 GMT
Sender: pkondeti=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8C51AC4360C; Thu, 30 Sep 2021 10:09:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 674C5C4338F;
        Thu, 30 Sep 2021 10:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 674C5C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Pavankumar Kondeti <pkondeti@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH] opp: Fix required-opps phandle array count check
Date:   Thu, 30 Sep 2021 15:39:08 +0530
Message-Id: <1632996548-11647-1-git-send-email-pkondeti@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The 'required-opps' property is optional. So of_count_phandle_with_args()
can return -ENOENT when queried for required-opps. Handle this case.

Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
---
 drivers/opp/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 2a97c65..5437085 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -170,7 +170,7 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 	}
 
 	count = of_count_phandle_with_args(np, "required-opps", NULL);
-	if (!count)
+	if (count <= 0)
 		goto put_np;
 
 	required_opp_tables = kcalloc(count, sizeof(*required_opp_tables),
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.


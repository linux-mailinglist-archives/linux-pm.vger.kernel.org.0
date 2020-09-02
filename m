Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF67E25B586
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 22:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgIBU54 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 16:57:56 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:64611 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgIBU5z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Sep 2020 16:57:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599080275; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=mRrgCYdmpBVXsKfAZnYtNsUvU0XQpKHZ5ed6uW+nx8o=; b=WllKtH8KwHxk4OqmBU4TzXPcngHhL9UjD2dKl3N9Ixmu8jlPtmxWUujO/KbIjF5pEBZoAsxH
 t0wQBQhnlyptPjJwqt3DG6ioGq7vsyrM1E7uQE2B4O4SFKc4v7cEAA+ugeJwYzG33Bj0zYct
 QPX2vY80rGbD+2WJy2rORKZdfr8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f500752be06707b34a3a076 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Sep 2020 20:57:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5BE89C43391; Wed,  2 Sep 2020 20:57:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6A037C433C6;
        Wed,  2 Sep 2020 20:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A037C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH] cpuidle: governor: export cpuidle_register_governor
Date:   Wed,  2 Sep 2020 14:57:20 -0600
Message-Id: <20200902205720.2548-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 83788c0caed3 ("cpuidle: remove unused exports") removed
capability of registering cpuidle governors, which was unused at that
time. By exporting the symbol, let's allow platform specific modules to
register cpuidle governors.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/cpuidle/governor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
index 29acaf48e575..480ec58cffa9 100644
--- a/drivers/cpuidle/governor.c
+++ b/drivers/cpuidle/governor.c
@@ -102,6 +102,7 @@ int cpuidle_register_governor(struct cpuidle_governor *gov)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cpuidle_register_governor);
 
 /**
  * cpuidle_governor_latency_req - Compute a latency constraint for CPU
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


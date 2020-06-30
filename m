Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C821920FC83
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 21:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgF3TNU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jun 2020 15:13:20 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:34620 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgF3TNU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Jun 2020 15:13:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593544400; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=wc4nrm4IdAq1nboWQlDczEUkTg7DqiIfiJLwe8CPi+8=; b=xj/RgkXaORdYeHbiY2BZEC1gMl5vCbRTXcfI14HUhAevl+ZgW9cxyqcQYNMQIFsZVfqWc2kn
 KwmuEc0QYyQ6GN4wmJrPrKG8hcFRVHtRh6cBHbHIav3M6C6wEA7h7dlV4gtkSGx65nWASeAA
 s64Gnj3FVY8XXKtsNHb1DJjJgfs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5efb8ecef3deea03f37c2df8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 30 Jun 2020 19:13:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6A42BC433CA; Tue, 30 Jun 2020 19:13:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 71EB9C433C8;
        Tue, 30 Jun 2020 19:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 71EB9C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH] cpuidle: governor: export cpuidle_register_governor
Date:   Tue, 30 Jun 2020 13:13:08 -0600
Message-Id: <20200630191308.23611-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 83788c0caed3 ("cpuidle: remove unused exports") removed
capability of registering cpuidle governors. With this change, let's
bring the capability back to allow cpuidle governors to be registered
from a module.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/cpuidle/governor.c | 1 +
 include/linux/cpuidle.h    | 1 +
 2 files changed, 2 insertions(+)

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
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index ec2ef63771f0..cc02ce7eab6c 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -264,6 +264,7 @@ struct cpuidle_governor {
 					bool *stop_tick);
 	void (*reflect)		(struct cpuidle_device *dev, int index);
 };
+EXPORT_SYMBOL_GPL(cpuidle_governor);
 
 #ifdef CONFIG_CPU_IDLE
 extern int cpuidle_register_governor(struct cpuidle_governor *gov);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


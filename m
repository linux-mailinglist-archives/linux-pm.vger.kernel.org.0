Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29AD33E5C50
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 15:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240450AbhHJNy4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 09:54:56 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:55138 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242055AbhHJNyz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Aug 2021 09:54:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628603673; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=zmgMFu36hTXT896+HcyEK3jKVy9QFCSIhPn+Dbj1dOQ=; b=s590pgZIO4+j3cljo5MAl+3G4bovy1UnYAy5eB9JsY/Xcva1y4dfMzzR3OnlHsORwapEhEze
 p/iGZxbpuJVdZfvYjkI2mCI0I/Pmc6zTBe4w1OUjsqX6pQMDYsEXVXboNQSuFivmiMdUvoUb
 0H0q/MG3yja+dZk1AKK0DcCfkP4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 61128518f746c298d90625a3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 10 Aug 2021 13:54:32
 GMT
Sender: psodagud=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A4ED8C4323A; Tue, 10 Aug 2021 13:54:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from th-lint-038.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8C6B6C43460;
        Tue, 10 Aug 2021 13:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C6B6C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=psodagud@codeaurora.org
From:   Prasad Sodagudi <psodagud@codeaurora.org>
To:     gregkh@linuxfoundation.org, rjw@rjwysocki.net
Cc:     len.brown@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, pavel@ucw.cz, psodagud@codeaurora.org
Subject: [PATCH v2] PM: sleep: core: Avoid setting power.must_resume to false
Date:   Tue, 10 Aug 2021 06:54:18 -0700
Message-Id: <1628603658-261568-2-git-send-email-psodagud@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628603658-261568-1-git-send-email-psodagud@codeaurora.org>
References: <1628603658-261568-1-git-send-email-psodagud@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are variables(power.may_skip_resume and dev->power.must_resume)
and DPM_FLAG_MAY_SKIP_RESUME flags to control the resume of devices after
a system wide suspend transition.

Setting the DPM_FLAG_MAY_SKIP_RESUME flag means that the driver allows
its "noirq" and "early" resume callbacks to be skipped if the device
can be left in suspend after a system-wide transition into the working
state. PM core determines that the driver's "noirq" and "early" resume
callbacks should be skipped or not with dev_pm_skip_resume() function by
checking power.may_skip_resume variable.

power.must_resume variable is getting set to false in __device_suspend()
function without checking device's DPM_FLAG_MAY_SKIP_RESUME and
dev->power.usage_count variables. In problematic scenario, where
all the devices in the suspend_late stage are successful and some
device can fail to suspend in suspend_noirq phase. So some devices
successfully suspended in suspend_late stage are not getting chance
to execute __device_suspend_noirq() to set dev->power.must_resume
variable to true and not getting resumed in early_resume phase.

Add a check for device's DPM_FLAG_MAY_SKIP_RESUME flag before
setting power.must_resume variable in __device_suspend function.

Fixes: 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the resume phase")
Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
---
 V1 -> V2: Fixed indentation and commit text to include scenario

 drivers/base/power/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index d568772..9ee6987 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1642,7 +1642,11 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 	}
 
 	dev->power.may_skip_resume = true;
-	dev->power.must_resume = false;
+	if ((atomic_read(&dev->power.usage_count) <= 1) &&
+	     (dev_pm_test_driver_flags(dev, DPM_FLAG_MAY_SKIP_RESUME)))
+		dev->power.must_resume = false;
+	else
+		dev->power.must_resume = true;
 
 	dpm_watchdog_set(&wd, dev);
 	device_lock(dev);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


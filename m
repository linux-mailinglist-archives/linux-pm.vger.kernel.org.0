Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064C53F4D7C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 17:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhHWP2y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 11:28:54 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:58419 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230380AbhHWP2x (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Aug 2021 11:28:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629732491; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=LT52FNjaUPr3dPS7ArBA3SbxjCRfsPrjN73Mk31zk6k=; b=QIRF7fSTzpsN4Z2Ly3+s932V4L1p3AQYfHjZ4ULLalqfwcT88NJIQ76xX9qcgNbxZUFmcsYw
 RLYwBUJDokH3qkezmgTi9zuU7Ydl6ONNNqH985YjM+j9UTGVkkrWS/1s5RHXJp+bChpiyGBI
 96z0ShTe479Fldd+vLER1Omby10=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6123be8389fbdf3ffe846dc9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Aug 2021 15:28:03
 GMT
Sender: psodagud=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1EA45C43617; Mon, 23 Aug 2021 15:28:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from th-lint-038.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 240A2C4338F;
        Mon, 23 Aug 2021 15:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 240A2C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Prasad Sodagudi <psodagud@codeaurora.org>
To:     gregkh@linuxfoundation.org, rjw@rjwysocki.net
Cc:     len.brown@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, pavel@ucw.cz, psodagud@codeaurora.org
Subject: [PATCH v4] PM: sleep: core: Avoid setting power.must_resume to false
Date:   Mon, 23 Aug 2021 08:27:50 -0700
Message-Id: <1629732470-155444-1-git-send-email-psodagud@codeaurora.org>
X-Mailer: git-send-email 2.7.4
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
function without checking device's DPM_FLAG_MAY_SKIP_RESUME settings.
In problematic scenario, where all the devices in the suspend_late
stage are successful and some device can fail to suspend in
suspend_noirq phase. So some devices successfully suspended in suspend_late
stage are not getting chance to execute __device_suspend_noirq()
to set dev->power.must_resume variable to true and not getting
resumed in early_resume phase.

Add a check for device's DPM_FLAG_MAY_SKIP_RESUME flag before
setting power.must_resume variable in __device_suspend function.

Fixes: 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the resume phase")
Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
---
 V3 -> V4: Remove dev->power.usage_count variable check
 V2 -> V3: Format issues patch posting
 V1 -> V2: Fixed indentation and commit text to include scenario
 drivers/base/power/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index d568772..50e8ea3 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1642,7 +1642,10 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 	}
 
 	dev->power.may_skip_resume = true;
-	dev->power.must_resume = false;
+	if (dev_pm_test_driver_flags(dev, DPM_FLAG_MAY_SKIP_RESUME))
+		dev->power.must_resume = false;
+	else
+		dev->power.must_resume = true;
 
 	dpm_watchdog_set(&wd, dev);
 	device_lock(dev);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


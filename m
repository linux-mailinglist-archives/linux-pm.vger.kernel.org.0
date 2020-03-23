Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E56218EF0C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 06:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgCWFJZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Mar 2020 01:09:25 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:10878 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725838AbgCWFJY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2020 01:09:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584940163; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=YwgqPRzi5A+j0qLDmgYbIu+o6KUyxQt47gBd1J1KNzA=; b=xkZiJxn7DoFBJzRpIgFFSyIiUBU6PIFojnz6+RQHG/VN9j0JcpPsDc4wk3ngBECEZrPST7sL
 vcsJuIwrFpfIFKwcjleyNkL09jzplc0+Fa1ottKcl/TjTsEW5hlC9Mrn5Bxe/pKhSnWh0d6u
 06BqD4SSyiiOw7alii/tywYG+jI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e784470.7f5e12e18570-smtp-out-n01;
 Mon, 23 Mar 2020 05:09:04 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D2D89C433CB; Mon, 23 Mar 2020 05:09:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from neeraju-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0B71FC433D2;
        Mon, 23 Mar 2020 05:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B71FC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
        gregkh@linuxfoundation.org, swboyd@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        irgeorgiev@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] PM / wakeup: Skip wakeup_source_sysfs_remove if device is not added
Date:   Mon, 23 Mar 2020 10:38:51 +0530
Message-Id: <1584940131-1591-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Skip wakeup_source_sysfs_remove(), to fix null pinter access of
ws->dev, if wakeup source is unregistered before wakeup class
is registered from device_add().

Fixes: 2ca3d1ecb8c4 ("PM / wakeup: Register wakeup class kobj after device is added")
Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 drivers/base/power/wakeup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 27f3e60..f8f8c0a 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -241,7 +241,8 @@ void wakeup_source_unregister(struct wakeup_source *ws)
 {
 	if (ws) {
 		wakeup_source_remove(ws);
-		wakeup_source_sysfs_remove(ws);
+		if (ws->dev)
+			wakeup_source_sysfs_remove(ws);
 		wakeup_source_destroy(ws);
 	}
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

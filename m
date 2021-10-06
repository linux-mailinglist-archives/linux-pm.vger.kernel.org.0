Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4BB42429C
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 18:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbhJFQ3j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 12:29:39 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30726 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232315AbhJFQ3j (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 Oct 2021 12:29:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633537667; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=aMfTtM8Khons/dOHU7+EI8xp1jZm6JOGRGNqXgdbORw=; b=a2tRvzpDys2ajItEHek4t0fB4YcW9czrecRZng5r4TPzMji0hoSB0us+owFIPVeApeRRdKNp
 B7QdFfUlVegpN+BBXA4aPNIUsns3d94Jfdgq2VW7bubeQCW6nK12XhOAl+bfCrw4i6mkxKK2
 wfPxwB2MNHW8vYYJLNF0wK0nC+s=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 615dce828ea00a941f6fe3c2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 06 Oct 2021 16:27:46
 GMT
Sender: mojha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 42AE9C43618; Wed,  6 Oct 2021 16:27:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-mojha-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 88D5AC43616;
        Wed,  6 Oct 2021 16:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 88D5AC43616
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH] PM / suspend: Abort suspend if somebody holds wakelock
Date:   Wed,  6 Oct 2021 21:57:20 +0530
Message-Id: <1633537640-15800-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There could be a scenario, where request_firmware() call results in
user land process trying to load firmwares into memory and
parallely one miscellaneous process is trying to invoke manual
suspend and due to which user mode helper gets disabled during
freezing of processes and that aborts loading of firmware even
though request_firmware() thread has taken wakelock.

Although, we are checking for any wakeup event inside
try_to_freeze_tasks() but that could be too late for the
above scenario.

Let's add a check before freezing/disable user land process in
suspend path.

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
 kernel/power/process.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 37401c9..3e0d3d6 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -124,6 +124,9 @@ int freeze_processes(void)
 {
 	int error;
 
+	if (pm_wakeup_pending())
+		return -EBUSY;
+
 	error = __usermodehelper_disable(UMH_FREEZING);
 	if (error)
 		return error;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project


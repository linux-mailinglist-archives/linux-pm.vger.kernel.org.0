Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADE115308F
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2020 13:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgBEM0k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Feb 2020 07:26:40 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:14855 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728021AbgBEM0k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Feb 2020 07:26:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580905599; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=5J/2d/yKfmhZMsyOqM5Y4Fz6w9WN5sJ8CWELf2rRwCk=; b=Xb9REnIYGWpiK3eGP2ODO5l5ueuxW8BW4c8QGAY32aZHTGU+XL8wPWSNJ4kSg6faRUw8UoDV
 VYGtpu08Yt6T2nKVPL2Bur1vR8CPjPctcNCGdjR0Ca8h4G5g4zuhCzwPKgXWCSt9sN+Ww7bL
 Hct8QXCQ27A/c+L3wEI4BWgN++0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3ab47b.7f28108510d8-smtp-out-n03;
 Wed, 05 Feb 2020 12:26:35 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7FF86C447A0; Wed,  5 Feb 2020 12:26:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 71543C447A3;
        Wed,  5 Feb 2020 12:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 71543C447A3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     swboyd@chromium.org, agross@kernel.org, david.brown@linaro.org,
        sudeep.holla@arm.com, Lorenzo.Pieralisi@arm.com
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, ulf.hansson@linaro.org, rjw@rjwysocki.net,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH v4 1/6] drivers: qcom: rpmh: fix macro to accept NULL argument
Date:   Wed,  5 Feb 2020 17:56:07 +0530
Message-Id: <1580905572-22712-2-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580905572-22712-1-git-send-email-mkshah@codeaurora.org>
References: <1580905572-22712-1-git-send-email-mkshah@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Device argument matches with dev variable declared in RPMH message.
Compiler reports error when the argument is NULL since the argument
matches the name of the property. Rename dev argument to device to
fix this.

Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/rpmh.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 035091f..3a4579d 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -23,7 +23,7 @@
 
 #define RPMH_TIMEOUT_MS			msecs_to_jiffies(10000)
 
-#define DEFINE_RPMH_MSG_ONSTACK(dev, s, q, name)	\
+#define DEFINE_RPMH_MSG_ONSTACK(device, s, q, name)	\
 	struct rpmh_request name = {			\
 		.msg = {				\
 			.state = s,			\
@@ -33,7 +33,7 @@
 		},					\
 		.cmd = { { 0 } },			\
 		.completion = q,			\
-		.dev = dev,				\
+		.dev = device,				\
 		.needs_free = false,				\
 	}
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

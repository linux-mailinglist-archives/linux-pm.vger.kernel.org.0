Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A62D1150767
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2020 14:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgBCNhG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Feb 2020 08:37:06 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:11149 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727100AbgBCNhG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Feb 2020 08:37:06 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580737025; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=5J/2d/yKfmhZMsyOqM5Y4Fz6w9WN5sJ8CWELf2rRwCk=; b=io42RisKX+fOTD9JqolKlCkwSaIEgmoR07C+7Nm3xN2sT4WtbHqz313OhsGkUyH3Xl2xuTsN
 2+SXDd+IOLd8/eINKnT3iyO1Cn9Hf9BINF7C4fMqYd3N0q7KXd61ZxwxvVk0K0l/mfwI0l/D
 scNKqGREAA2SGrlWG/dTJH3+CsE=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3821fe.7fb9521a0ce0-smtp-out-n01;
 Mon, 03 Feb 2020 13:37:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8DC0FC4479C; Mon,  3 Feb 2020 13:37:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 531FAC433A2;
        Mon,  3 Feb 2020 13:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 531FAC433A2
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
Subject: [PATCH v3 1/7] drivers: qcom: rpmh: fix macro to accept NULL argument
Date:   Mon,  3 Feb 2020 19:05:34 +0530
Message-Id: <1580736940-6985-2-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580736940-6985-1-git-send-email-mkshah@codeaurora.org>
References: <1580736940-6985-1-git-send-email-mkshah@codeaurora.org>
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

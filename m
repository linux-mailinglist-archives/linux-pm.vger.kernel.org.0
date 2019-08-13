Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 223638B256
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 10:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfHMIZz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 04:25:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48824 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbfHMIZz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 04:25:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0071F60ACA; Tue, 13 Aug 2019 08:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565684754;
        bh=gplh7GQjZcJ4EgN1MsaY6C3S+turay46CIinA1xbsdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KH04mm5jCee/ft+dDToqSFzRkIdhL4iQY1VlTSPJVQqGRpoUGUqrF6P8mWoSu9ScW
         bkyEiNhZB2LCz73uFWVhp/mjleaUJLpi6TrVn4x18rfRfzs2RMYnNDJ9ch/8HIJ7vB
         M1Wa+JX5SBRThbdwYT22N8vq/NUGznGIbly1gejE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EC7AE60909;
        Tue, 13 Aug 2019 08:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565684753;
        bh=gplh7GQjZcJ4EgN1MsaY6C3S+turay46CIinA1xbsdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l9rcLFDkReVMk2Rfk/4oqQ22ECUuq1zccBas1XrxNl6s1mdjjoyfAEEoiYzE8dUNU
         +b3Uu21KScb7xSji6WqpjqQtfMIftqSIzPbwoGyW7+X9r6EagXCI/7WSFiekNB50LY
         fsMldO9tF/AzpDiy2ed15xlUmfdc16nz9K9QAJas=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC7AE60909
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     agross@kernel.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, swboyd@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org, ulf.hansson@linaro.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH 1/4] drivers: qcom: rpmh: fix macro to accept NULL argument
Date:   Tue, 13 Aug 2019 13:54:39 +0530
Message-Id: <20190813082442.25796-2-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190813082442.25796-1-mkshah@codeaurora.org>
References: <20190813082442.25796-1-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Device argument matches with dev variable declared in RPMH message.
Compiler reports error when the argument is NULL since the argument
matches the name of the property. Rename dev argument to device to
fix this.

Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
---
 drivers/soc/qcom/rpmh.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 035091fd44b8..3a4579d056a4 100644
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
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.


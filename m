Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1164D70C18
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 23:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732982AbfGVVx6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 17:53:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36820 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732976AbfGVVx5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 17:53:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1095161797; Mon, 22 Jul 2019 21:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563832437;
        bh=WpCgEOoGvhbJ0VBx0zgHnAYDeYg4fRD+EEEeXF83K7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kigNPpsLEDWvA2sOZdchiIzG5y+kYbkgspozzhWGmMnXP2bzip3Rse+vP+DO4TD/b
         0T1b1GWC5hhksYodKN8KHA7kTv1KyJ0ilr9TgmuVl81Zo0ShHqT1kpbwUcUw5U4uea
         YNZGY/YaysLIbLKu+x8PhXOVbWoqNBrtYmn27p0c=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 641E861779;
        Mon, 22 Jul 2019 21:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563832436;
        bh=WpCgEOoGvhbJ0VBx0zgHnAYDeYg4fRD+EEEeXF83K7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=StB3Yl4TvVkl2cyDH2O50knw+oTV/Xm/C4wMqyWFR24GVSuJFQQ0bfUH91o/v1xBN
         gMRQ1wIppWk7O9qozF/dXTec0c9c2Eh1wWfWwF1Qr2Uayj+SYTvlhuVNH2UGTnbA28
         YS1hChsyqMaDnU7SQfuFl2gki915JFFK/VnI54LY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 641E861779
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, swboyd@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        mkshah@codeaurora.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH V2 4/4] drivers: qcom: rpmh-rsc: remove redundant register access
Date:   Mon, 22 Jul 2019 15:53:40 -0600
Message-Id: <20190722215340.3071-4-ilina@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190722215340.3071-1-ilina@codeaurora.org>
References: <20190722215340.3071-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since drv->tcs_in_use is updated when the DRV_STATUS is updated, we
could simply use the former to determine if the TCS is idle or not.
Therefore, remove redundant TCS register read.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index add5e84751c9..b04cd2d2910c 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -93,8 +93,7 @@ static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int tcs_id,
 
 static bool tcs_is_free(struct rsc_drv *drv, int tcs_id)
 {
-	return !test_bit(tcs_id, drv->tcs_in_use) &&
-	       read_tcs_reg(drv, RSC_DRV_STATUS, tcs_id, 0);
+	return !test_bit(tcs_id, drv->tcs_in_use);
 }
 
 static struct tcs_group *get_tcs_of_type(struct rsc_drv *drv, int type)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


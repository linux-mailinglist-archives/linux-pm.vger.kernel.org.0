Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE226240232
	for <lists+linux-pm@lfdr.de>; Mon, 10 Aug 2020 09:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgHJHIb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Aug 2020 03:08:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:42243 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgHJHI3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Aug 2020 03:08:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597043308; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=DWno83mBRJaK7NOCf0kx0lg1MeEy1FowAQbEwyuoYr4=; b=eN6FIskGg7sU0DjXA5lxtZ0jb2akfaiUgEJtIeItOVWI6NFb2SdDBaJMQ4sY1AHL6Z8zHxgr
 OHeZpSZNA5SOihl5O9H4S0l0TOVJeoD0nccs8suO3Yl9V+ogmAXQTUorvG3if5g8t4vcfql9
 S5xxUCmjq371XKHwFUJSGARpkaw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f30f20d1e4d3989d4ed2b27 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 10 Aug 2020 07:06:53
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 64E17C433CB; Mon, 10 Aug 2020 07:06:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7C2E4C433C6;
        Mon, 10 Aug 2020 07:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C2E4C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH] opp: Fix dev_pm_opp_set_rate() to not return early
Date:   Mon, 10 Aug 2020 12:36:19 +0530
Message-Id: <1597043179-17903-1-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

dev_pm_opp_set_rate() can now be called with freq = 0 inorder
to either drop performance or bandwidth votes or to disable
regulators on platforms which support them.
In such cases, a subsequent call to dev_pm_opp_set_rate() with
the same frequency ends up returning early because 'old_freq == freq'
Instead make it fall through and put back the dropped performance
and bandwidth votes and/or enable back the regulators.

Fixes: cd7ea582 ("opp: Make dev_pm_opp_set_rate() handle freq = 0 to drop performance votes")
Reported-by: Sajida Bhanu <sbhanu@codeaurora.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/opp/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 0c8c74a..a994f30 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -901,6 +901,9 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
 	/* Return early if nothing to do */
 	if (old_freq == freq) {
+		if (opp_table->required_opp_tables || opp_table->regulators ||
+		    opp_table->paths)
+			goto skip_clk_only;
 		dev_dbg(dev, "%s: old/new frequencies (%lu Hz) are same, nothing to do\n",
 			__func__, freq);
 		ret = 0;
@@ -919,6 +922,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		goto put_opp_table;
 	}
 
+skip_clk_only:
 	temp_freq = old_freq;
 	old_opp = _find_freq_ceil(opp_table, &temp_freq);
 	if (IS_ERR(old_opp)) {
@@ -954,8 +958,10 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 						 IS_ERR(old_opp) ? NULL : old_opp->supplies,
 						 opp->supplies);
 	} else {
+		ret = 0;
 		/* Only frequency scaling */
-		ret = _generic_set_opp_clk_only(dev, clk, freq);
+		if (freq != old_freq)
+			ret = _generic_set_opp_clk_only(dev, clk, freq);
 	}
 
 	/* Scaling down? Configure required OPPs after frequency */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


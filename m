Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 609495C866
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2019 06:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfGBEgy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jul 2019 00:36:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52254 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfGBEgx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jul 2019 00:36:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6EBA1607DF; Tue,  2 Jul 2019 04:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562042213;
        bh=zZPzUmRssl1hYuGZRP1UExVBZhx+79WmuCJUsSBCzIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P20RLyZzIpSH9VRUgrmeq0uC5hMqayEPXybdCoQoKDd8McNnRuc4rukJNwXNnk1NK
         YnIIf2Pv/PSlpXu+vwZrTuLOUKupjLAtajU+98aDpBLHsZIHUbetD8RljYuRFFDzRR
         19rWcQ3+yxlPkp+LCTUFD6P6JOXDWHyQ06RGmvsM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5DD606028D;
        Tue,  2 Jul 2019 04:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562042213;
        bh=zZPzUmRssl1hYuGZRP1UExVBZhx+79WmuCJUsSBCzIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P20RLyZzIpSH9VRUgrmeq0uC5hMqayEPXybdCoQoKDd8McNnRuc4rukJNwXNnk1NK
         YnIIf2Pv/PSlpXu+vwZrTuLOUKupjLAtajU+98aDpBLHsZIHUbetD8RljYuRFFDzRR
         19rWcQ3+yxlPkp+LCTUFD6P6JOXDWHyQ06RGmvsM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5DD606028D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     vireshk@kernel.org, sboyd@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 2/2] opp: Manage empty OPP tables with clk handle
Date:   Tue,  2 Jul 2019 10:06:43 +0530
Message-Id: <20190702043643.1746-2-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702043643.1746-1-rnayak@codeaurora.org>
References: <20190702043643.1746-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With OPP core now supporting DVFS for IO devices, we have instances of
IO devices (same IP block) with require an OPP on some platforms/SoCs
while just needing to scale the clock on some others.
In order to avoid conditional code in every driver, (to check for 
availability of OPPs and then deciding to do either dev_pm_opp_set_rate()
or clk_set_rate()) add support to manage empty OPP tables with a clk handle.
This makes dev_pm_opp_set_rate() equivalent of a clk_set_rate() for devices
with just a clk and no OPPs specified.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/opp/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index ae033bb1e5b7..fa7d4d6d37b3 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -801,6 +801,11 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		goto put_opp_table;
 	}
 
+	if (!_get_opp_count(opp_table)) {
+		ret = _generic_set_opp_clk_only(dev, clk, freq);
+		goto put_opp_table;
+	}
+
 	temp_freq = old_freq;
 	old_opp = _find_freq_ceil(opp_table, &temp_freq);
 	if (IS_ERR(old_opp)) {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


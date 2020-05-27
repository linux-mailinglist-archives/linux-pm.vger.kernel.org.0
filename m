Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9664E1E4F17
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 22:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgE0UWV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 16:22:21 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:54632 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbgE0UWV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 May 2020 16:22:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590610940; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=G4owDA73rya93Iq5Ppovobk5IRWHk7KpXDDQCNQdgSI=; b=jI00MpJNIo0uLWmXVm5+4PmzNN2y2YzBN06o5LuY9m9/A7E6MjFiNv0xF+ft67rs+u7IbTfH
 OT/lCK90JSn2OqTGqcCf777CrExBNgFPXQFQk02R7+NCF8K2HX+AZUbinrxYDp1cNCb7w1B8
 bzOv0T9iEEkAdEAlV5UdM8zg2Nk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5ececbfc76fccbb4c8d4a63d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 May 2020 20:22:20
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5590AC4339C; Wed, 27 May 2020 20:22:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5C2E6C433C9;
        Wed, 27 May 2020 20:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C2E6C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, mka@chromium.org
Cc:     nm@ti.com, bjorn.andersson@linaro.org, agross@kernel.org,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, vincent.guittot@linaro.org,
        amit.kucheria@linaro.org, lukasz.luba@arm.com,
        sudeep.holla@arm.com, smasetty@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v5 0/5] DDR/L3 Scaling support on SDM845 and SC7180 SoCs
Date:   Thu, 28 May 2020 01:51:48 +0530
Message-Id: <20200527202153.11659-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch series aims to extend cpu based scaling support to L3/DDR on
SDM845 and SC7180 SoCs.

Patches [1-2] - Blacklist SDM845 and SC7180 in cpufreq-dt-platdev
Patches [3-5] - Update bw levels based on cpu frequency change

Based on the following series:
https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/log/?h=opp/linux-next

V5:
 * Pick up R-bs from Amit
 * Drop icc tag support/dt changes till the a consensus is achieved
 * Use dev_pm_opp_adjust_voltage instead [Viresh]
 * Drop dev_pm_opp_get_path_count [Saravana]
 * Rework dev_pm_opp_set_bw

V4:
 * Migrate to using Georgi's new bindings
 * Misc fixups based on Matthias comments
 * API fixups based on Bjorn's comments on v2
 * Picked up a few R-bs from Matthias

v3:
 * Migrated to using Saravana's opp-kBps bindings [1]
 * Fixed some misc comments from Rajendra
 * Added support for SC7180

v2:
 * Incorporated Viresh's comments from:
 https://lore.kernel.org/lkml/20190410102429.r6j6brm5kspmqxc3@vireshk-i7/
 https://lore.kernel.org/lkml/20190410112516.gnh77jcwawvld6et@vireshk-i7/
 * Dropped cpufreq-map passive governor

Sibi Sankar (5):
  cpufreq: blacklist SDM845 in cpufreq-dt-platdev
  cpufreq: blacklist SC7180 in cpufreq-dt-platdev
  OPP: Add and export helper to set bandwidth
  cpufreq: qcom: Update the bandwidth levels on frequency change
  cpufreq: qcom: Disable fast switch when scaling DDR/L3

 drivers/cpufreq/cpufreq-dt-platdev.c |  2 +
 drivers/cpufreq/qcom-cpufreq-hw.c    | 81 ++++++++++++++++++++++++++--
 drivers/opp/core.c                   | 31 +++++++++++
 include/linux/pm_opp.h               |  6 +++
 4 files changed, 116 insertions(+), 4 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


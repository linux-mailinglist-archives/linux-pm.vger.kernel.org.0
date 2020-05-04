Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1531C47F3
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 22:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgEDUYF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 16:24:05 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:21628 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726433AbgEDUYE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 16:24:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588623844; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=HTXjWdBLrHj7qKXU26YhsxMP+8VY0C42SPBv+HCFlE4=; b=Nr7aVzyBbk8t+9MRUveuVa/22iOeEiaQcR/OBPX6aCdOzxNSNAu+EIPr09hhrmR9UdomDBOw
 mFGfQ0HmoPDFSoFgz9uPFjrFuUVyX5TOSy0t/NyXyCtNBDudcocEMELYNaGXx4NxNh3lf9U4
 HtJo98ru3jAJfTUUeJHKL06uq0g=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb079cd.7f8bed75ba08-smtp-out-n05;
 Mon, 04 May 2020 20:23:41 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 82689C44788; Mon,  4 May 2020 20:23:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6780DC433CB;
        Mon,  4 May 2020 20:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6780DC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        saravanak@google.com, mka@chromium.org
Cc:     nm@ti.com, agross@kernel.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, vincent.guittot@linaro.org,
        amit.kucheria@linaro.org, ulf.hansson@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v4 00/12] DDR/L3 Scaling support on SDM845 and SC7180 SoCs
Date:   Tue,  5 May 2020 01:52:31 +0530
Message-Id: <20200504202243.5476-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch series aims to extend cpu based scaling support to L3/DDR on
SDM845 and SC7180 SoCs.

Patches [1-3] - Blacklist SDM845 and SC7180 in cpufreq-dt-platdev
Patches [4-8] - Update bw levels based on cpu frequency change
Patches [9-10] - Add tag setting support to OPP
Patches [11-12] - Add the cpu opp tables for SDM845 and SC7180 SoCs.

Depends on the following series:
https://lore.kernel.org/patchwork/cover/1230626/

Georgi,
 Would it make sense to include tag support patches [9-10] in your next
 re-spin?

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

Sibi Sankar (12):
  arm64: dts: qcom: sdm845: Add SoC compatible to MTP
  cpufreq: blacklist SDM845 in cpufreq-dt-platdev
  cpufreq: blacklist SC7180 in cpufreq-dt-platdev
  OPP: Add and export helper to update voltage
  OPP: Add and export helper to set bandwidth
  cpufreq: qcom: Update the bandwidth levels on frequency change
  OPP: Add and export helper to get icc path count
  cpufreq: qcom: Disable fast switch when scaling ddr/l3
  dt-bindings: interconnect: Add interconnect-tags bindings
  OPP: Add support for setting interconnect-tags
  arm64: dts: qcom: sdm845: Add cpu OPP tables
  arm64: dts: qcom: sc7180: Add cpu OPP tables

 .../bindings/interconnect/interconnect.txt    |   5 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi          | 168 ++++++++++++
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts       |   2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 258 ++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
 drivers/cpufreq/qcom-cpufreq-hw.c             |  89 +++++-
 drivers/opp/core.c                            | 114 ++++++++
 drivers/opp/of.c                              |  25 +-
 include/linux/pm_opp.h                        |  22 ++
 9 files changed, 675 insertions(+), 10 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9087715075F
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2020 14:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgBCNgx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Feb 2020 08:36:53 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:23723 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726913AbgBCNgx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Feb 2020 08:36:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580737012; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=TI7++YyK03sKgcFbSkBWtvsKpSvZvojFEGq67S9YhVg=; b=DdWTImzF7P7Kc4Lvw9/TMx1+m8Ffsu38tI2wcRmVj9qcIXRiANscJeZpP3jkygCoDjJhaOzc
 nHdkebymNLT9yLuRci6oIVhfFnOtHvmKS1xU4aXIv7xGlgCGbS7dv9QOEIYPJLkJ3LYaI5Mb
 waHKwYfTlhQOxgY7EyQMlYBARjU=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3821f1.7f666f5e3c00-smtp-out-n03;
 Mon, 03 Feb 2020 13:36:49 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B81BFC447A0; Mon,  3 Feb 2020 13:36:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE292C433A2;
        Mon,  3 Feb 2020 13:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE292C433A2
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
Subject: [PATCH v3 0/7] Add RSC power domain support
Date:   Mon,  3 Feb 2020 19:05:33 +0530
Message-Id: <1580736940-6985-1-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes in v3:
- Address Rob's comment on dt property value
- Address Stephen's comments on rpmh-rsc driver change
- Include sc7180 cpuidle low power mode changes from [1]
- Include hierarchical domain idle states converter change from [2]

Changes in v2:
- Add Stephen's Reviewed-By to the first three patches
- Addressed Stephen's comments on fourth patch
- Include changes to connect rpmh domain to cpuidle and genpds

Resource State Coordinator (RSC) is responsible for powering off/lowering
the requirements from CPU subsystem for the associated hardware like buses,
clocks, and regulators when all CPUs and cluster is powered down.

RSC power domain uses last-man activities provided by genpd framework based on
Ulf Hansoon's patch series[3], when the cluster of CPUs enter deepest idle
states. As a part of domain poweroff, RSC can lower resource state requirements
by flushing the cached sleep and wake state votes for resources.

[1] https://patchwork.kernel.org/patch/11218965
[2] https://patchwork.kernel.org/patch/10941671
[3] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=222355

Maulik Shah (6):
  drivers: qcom: rpmh: fix macro to accept NULL argument
  drivers: qcom: rpmh: remove rpmh_flush export
  dt-bindings: soc: qcom: Add RSC power domain specifier
  drivers: qcom: rpmh-rsc: Add RSC power domain support
  arm64: dts: qcom: sc7180: Add cpuidle low power states
  arm64: dts: qcom: sc7180: Convert to the hierarchical CPU topology
    layout

Ulf Hansson (1):
  drivers: firmware: psci: Add hierarchical domain idle states converter

 .../devicetree/bindings/soc/qcom/rpmh-rsc.txt      |   9 ++
 arch/arm64/boot/dts/qcom/sc7180.dtsi               | 133 ++++++++++++++++++++
 drivers/cpuidle/cpuidle-psci-domain.c              | 137 ++++++++++++++++++---
 drivers/cpuidle/cpuidle-psci.c                     |  41 +++---
 drivers/cpuidle/cpuidle-psci.h                     |  11 ++
 drivers/soc/qcom/rpmh-internal.h                   |   3 +
 drivers/soc/qcom/rpmh-rsc.c                        |  81 ++++++++++++
 drivers/soc/qcom/rpmh.c                            |  22 ++--
 include/soc/qcom/rpmh.h                            |   5 -
 9 files changed, 389 insertions(+), 53 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

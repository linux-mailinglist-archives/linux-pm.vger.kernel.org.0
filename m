Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D550D8B253
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 10:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfHMIZl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 04:25:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48640 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfHMIZl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 04:25:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DB61A607DE; Tue, 13 Aug 2019 08:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565684740;
        bh=POHCskCBMH1ZdCeQ/s1wr7SV0EammuFdxrlrI4KWC7Y=;
        h=From:To:Cc:Subject:Date:From;
        b=F+3YgV5ieTKv1XlDc+0RfiorOfMs9Jmdg7l83A8gMSn9U/WiSNBOcj/08RHoIwMI9
         x6bBh7wpmImdlVlVllKNJ7cTvvmX7F8UvetSCNhPlL02lKBJpya1Zeudj2rXZ2IQFf
         On8BcVpcvGxB/ncL6TaPV22Qi1ffuFVocCqISdg0=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A3F4E60709;
        Tue, 13 Aug 2019 08:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565684740;
        bh=POHCskCBMH1ZdCeQ/s1wr7SV0EammuFdxrlrI4KWC7Y=;
        h=From:To:Cc:Subject:Date:From;
        b=F+3YgV5ieTKv1XlDc+0RfiorOfMs9Jmdg7l83A8gMSn9U/WiSNBOcj/08RHoIwMI9
         x6bBh7wpmImdlVlVllKNJ7cTvvmX7F8UvetSCNhPlL02lKBJpya1Zeudj2rXZ2IQFf
         On8BcVpcvGxB/ncL6TaPV22Qi1ffuFVocCqISdg0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A3F4E60709
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
Subject: [PATCH 0/4] Add RSC power domain support
Date:   Tue, 13 Aug 2019 13:54:38 +0530
Message-Id: <20190813082442.25796-1-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Resource State Coordinator (RSC) is responsible for powering off/lowering
the requirements from CPU subsystem for the associated hardware like buses,
clocks, and regulators when all CPUs and cluster is powered down.

RSC power domain uses last-man activities provided by genpd framework based on
Ulf Hansoon's patch series[1], when the cluster of CPUs enter deepest idle
states. As a part of domain poweroff, RSC can lower resource state requirements
by flushing the cached sleep and wake state votes for resources.

Dependencies:

[1] https://lkml.org/lkml/2019/5/13/839

Maulik Shah (4):
  drivers: qcom: rpmh: fix macro to accept NULL argument
  drivers: qcom: rpmh: remove rpmh_flush export
  dt-bindings: soc: qcom: Add RSC power domain specifier
  drivers: qcom: rpmh-rsc: Add RSC power domain support

 .../devicetree/bindings/soc/qcom/rpmh-rsc.txt |  7 ++
 drivers/soc/qcom/rpmh-internal.h              |  3 +
 drivers/soc/qcom/rpmh-rsc.c                   | 96 +++++++++++++++++++
 drivers/soc/qcom/rpmh.c                       | 22 ++---
 include/soc/qcom/rpmh.h                       |  5 -
 5 files changed, 116 insertions(+), 17 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.

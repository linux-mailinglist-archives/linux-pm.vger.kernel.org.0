Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3081EDA394
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 04:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733053AbfJQCVE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 22:21:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45248 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfJQCVD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 22:21:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 63F476032D; Thu, 17 Oct 2019 02:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571278862;
        bh=ya0y6uIRyTrjP0oZpf7fC4HeXiZCPtMSPUrBj16lLQg=;
        h=From:To:Cc:Subject:Date:From;
        b=HXw4sWQlIeoRH5NyTz3+OYGP6BiUi6CdoiBqNCJtAyD56RlSas7vL4VTLHVoICbU/
         0VgkSxesa8qR+22m31W7p3Wfgrw1udapEqjeVvuKZwg55g3z6L5yO+m4KQ6zRpt/40
         7bFaOjMNrIwjHdfFJK1OK8Wh58eLGY/9OzpNYs8k=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from davidai-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0AB7860588;
        Thu, 17 Oct 2019 02:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571278861;
        bh=ya0y6uIRyTrjP0oZpf7fC4HeXiZCPtMSPUrBj16lLQg=;
        h=From:To:Cc:Subject:Date:From;
        b=dp1hnxySPzveI1r8i/H0PIobU3pyRmtIX34yugKQ1bM7Mv/XWpn0YVp+b8nq606HF
         hThh7an7dxGYOh8QB3frRfnC/sqMAQHRgd61fhFdtjGJhtffuR+kN8K10qLougTNFw
         1ekXsd2PGWfR4AFXs1D60BFVEfBax4wqEYwpF/A4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0AB7860588
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
From:   David Dai <daidavid1@codeaurora.org>
To:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc:     David Dai <daidavid1@codeaurora.org>, evgreen@google.com,
        sboyd@kernel.org, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        elder@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [RFC PATCH 0/4] Redefine interconnect provider DT nodes for SDM845
Date:   Wed, 16 Oct 2019 19:20:48 -0700
Message-Id: <1571278852-8023-1-git-send-email-daidavid1@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

While there are no current consumers of the SDM845 interconnect device in
devicetree, take this opportunity to redefine the interconnect device nodes
as the previous definitions of using a single child node under the apps_rsc
device did not accurately capture the description of the hardware.
The Network-On-Chip (NoC) interconnect devices should be represented in a
manner akin to QCS404 platforms[1] where there is a separation of NoC devices
and its RPM/RPMh counterparts.

The bcm-voter devices are representing the RPMh devices that the interconnect
providers need to communicate with and there can be more than one instance of
the Bus Clock Manager (BCM) which can live under different instances of Resource
State Coordinators (RSC). There are display use cases where consumers may need
to target a different bcm-voter (Some display specific RSC) than the default,
and there needs to be a way to represent this connection in devicetree.

This patches series extends the original discussion involving the SDM845
interconnect bindings[2] by adding accompanying driver implementations
using the split NoC devices. The first patch also updates existing
sdm845 binding documentation to DT schema format using json-schema.

[1]: https://lkml.org/lkml/2019/6/13/143
[2]: https://lkml.org/lkml/2019/7/19/1063

David Dai (4):
  dt-bindings: interconnect: Update Qualcomm SDM845 DT bindings
  arm64: dts: sdm845: Redefine interconnect provider DT nodes
  interconnect: qcom: Refactor icc rpmh support
  interconnect: qcom: sdm845: Split qnodes into their respective NoCs

 .../bindings/interconnect/qcom,bcm-voter.yaml      |  45 ++
 .../bindings/interconnect/qcom,sdm845.txt          |  24 -
 .../bindings/interconnect/qcom,sdm845.yaml         | 108 +++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |  60 +-
 drivers/interconnect/qcom/Kconfig                  |   8 +
 drivers/interconnect/qcom/Makefile                 |   4 +
 drivers/interconnect/qcom/bcm-voter.c              | 355 ++++++++++
 drivers/interconnect/qcom/bcm-voter.h              |  28 +
 drivers/interconnect/qcom/icc-rpmh.c               | 154 +++++
 drivers/interconnect/qcom/icc-rpmh.h               | 150 +++++
 drivers/interconnect/qcom/sdm845.c                 | 727 ++++++---------------
 11 files changed, 1115 insertions(+), 548 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
 delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
 create mode 100644 drivers/interconnect/qcom/bcm-voter.c
 create mode 100644 drivers/interconnect/qcom/bcm-voter.h
 create mode 100644 drivers/interconnect/qcom/icc-rpmh.c
 create mode 100644 drivers/interconnect/qcom/icc-rpmh.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


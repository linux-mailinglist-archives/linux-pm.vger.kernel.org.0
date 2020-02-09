Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 043F8156C15
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2020 19:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgBISe2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Feb 2020 13:34:28 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:30957 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727413AbgBISe2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Feb 2020 13:34:28 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581273267; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=aBio5nz03nEeEcJwl1oNFkBeK2euxvmLESZKLdRwEqc=; b=TR4iUTsKc4+J8KC19VEfJ9TgPfKymh/iXYyBqhSl6DzdgaIFoO35I/2q39SN2hTrEe+rnGi6
 qIRGL+wAG0IcQT18ICVmXUPHtObXtwljKoImWRlKDFP/KddaXX5uXQAlrhVWBU68KqvAx9ES
 Dpl5++8K4dvK8OisiZklSB0DEGY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4050b2.7f81a23dcd88-smtp-out-n02;
 Sun, 09 Feb 2020 18:34:26 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1A39BC447A2; Sun,  9 Feb 2020 18:34:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0EEFCC43383;
        Sun,  9 Feb 2020 18:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EEFCC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     robh+dt@kernel.org, georgi.djakov@linaro.org, evgreen@chromium.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mark.rutland@arm.com,
        daidavid1@codeaurora.org, saravanak@google.com, mka@chromium.org,
        linux-pm@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 0/6] Split SDM845 interconnect nodes and consolidate RPMh support
Date:   Mon, 10 Feb 2020 00:04:05 +0530
Message-Id: <20200209183411.17195-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This patches series extends the discussions[2][3] involving the SDM845
interconnect bindings by adding accompanying driver implementations
using the split NoC devices. Some of the code used to support the SDM845
provider driver are refactored into common modules that can used by other
RPMh based interconnect providers such as SC7180[4]. This patch series also
updates existing sdm845 binding documentation to DT schema format using
json-schema.

v3:
- Picked up Robs R-b for patch 1 
- Fixup qcom,bcm-voter.yaml. comments (Rob)
- Use qcom,bcm-voter instead of SoC specific compatible for
  SDM845 and SC7180 (Odelu/Sibi)
- Fixup bindings check failures for qcom,sdm845.yaml
- Fixup the misc bugs. comments (Evan/Sibi)
- Fixup reg size for aggre1/2_noc

v2: 
- Reorganized dt-binding patches
- Fixed a bug that adds duplicate BCM node to voter (Georgi)
- Addressed misc. comments (Georgi)

v1: https://lkml.org/lkml/2019/12/16/15

[1]: https://lkml.org/lkml/2019/6/13/143
[2]: https://lkml.org/lkml/2019/7/19/1063
[3]: https://lkml.org/lkml/2019/10/16/1793
[4]: https://lkml.org/lkml/2019/11/26/389

David Dai (6):
  dt-bindings: interconnect: Convert qcom,sdm845 to DT schema
  dt-bindings: interconnect: Add YAML schemas for QCOM bcm-voter
  dt-bindings: interconnect: Update Qualcomm SDM845 DT bindings
  interconnect: qcom: Consolidate interconnect RPMh support
  interconnect: qcom: sdm845: Split qnodes into their respective NoCs
  arm64: dts: sdm845: Redefine interconnect provider DT nodes

 .../bindings/interconnect/qcom,bcm-voter.yaml |   45 +
 .../bindings/interconnect/qcom,sdm845.txt     |   24 -
 .../bindings/interconnect/qcom,sdm845.yaml    |   74 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   65 +-
 drivers/interconnect/qcom/Kconfig             |   13 +-
 drivers/interconnect/qcom/Makefile            |    4 +
 drivers/interconnect/qcom/bcm-voter.c         |  366 +++++
 drivers/interconnect/qcom/bcm-voter.h         |   27 +
 drivers/interconnect/qcom/icc-rpmh.c          |  147 ++
 drivers/interconnect/qcom/icc-rpmh.h          |  149 +++
 drivers/interconnect/qcom/sdm845.c            | 1185 +++++++----------
 .../dt-bindings/interconnect/qcom,sdm845.h    |  263 ++--
 12 files changed, 1516 insertions(+), 846 deletions(-)
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

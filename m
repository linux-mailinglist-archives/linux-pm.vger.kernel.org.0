Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 506746EB9A
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 22:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbfGSUcf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 16:32:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56414 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbfGSUcf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jul 2019 16:32:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3A065611D1; Fri, 19 Jul 2019 20:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563568354;
        bh=nOzlrnBEamhN2JgiNCP88vDUSaUd5wB7eTA/ysgT7+Y=;
        h=From:To:Cc:Subject:Date:From;
        b=a70ZBH4EIBVxceERFjClWJxCJWOzK9nnbr1rAd7bNYiAQqPNW+NzZGnndqU5ZDTDb
         pXIMvUAYHrr/x2yih7yPPVOQcjT0zKJmKYEmkiDyQECiLiJt1yPfNQNmgwuOIFtM2H
         PTfRrCJw6WlmKwJlx5h5dyU5KEO23GVn+GxAS7U4=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C18060ACA;
        Fri, 19 Jul 2019 20:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563568353;
        bh=nOzlrnBEamhN2JgiNCP88vDUSaUd5wB7eTA/ysgT7+Y=;
        h=From:To:Cc:Subject:Date:From;
        b=bfZWMo7/uLhZ5X3/fbuEjCzGmhOqeKzaKIkp37wmbcNKGHmCDMAhPPh9ndEORWLsZ
         VH7XfUlyVR2l4z7Ab+GNbScfUqP4IyXbTsC/aDf+RwkAscPXispicbGgihr/JtbjB8
         pIvJdFVNJcMkFV+cofopcAMQzFJbeckHjhHSKKnI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C18060ACA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
From:   David Dai <daidavid1@codeaurora.org>
To:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc:     David Dai <daidavid1@codeaurora.org>, evgreen@google.com,
        ilina@codeaurora.org, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 0/2] Redefine interconnect provider DT nodes for SDM845
Date:   Fri, 19 Jul 2019 13:32:22 -0700
Message-Id: <1563568344-1274-1-git-send-email-daidavid1@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Redefine the SDM845 interconnect device nodes as the previous definitions
of using a single child node under the apps_rsc device did not accurately
capture the description of the hardware. The Network-On-Chip (NoC) interconnect
devices should be represented in a manner akin to QCS404 platforms[1]
where there is a separation of NoC devices and its RPM/RPMh counterparts.

The bcm-voter devices are representing the RPMh devices that the interconnect
providers need to communicate with and there can be more than one instance of
the Bus Clock Manager (BCM) which can live under different instances of Resource
State Coordinators (RSC). There are display use cases where consumers may need
to target a different bcm-voter (Some display specific RSC) than the default,
and there needs to be a way to represent this connection in devicetree.

[1]: https://lkml.org/lkml/2019/6/13/143

David Dai (2):
  dt-bindings: interconnect: Update Qualcomm SDM845 DT bindings
  arm64: dts: sdm845: Redefine interconnect provider DT nodes

 .../bindings/interconnect/qcom,bcm-voter.txt       | 32 ++++++++++++
 .../bindings/interconnect/qcom,sdm845.txt          | 40 ++++++++++----
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 61 ++++++++++++++++++++--
 3 files changed, 121 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.txt

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


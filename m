Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D58340251
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 10:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCRJqy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 05:46:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhCRJqb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Mar 2021 05:46:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EE4B64F0C;
        Thu, 18 Mar 2021 09:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616060790;
        bh=hxJs/mIL6KwJJl4VSxDtA4EFb/qBN31GavYb1+99x9M=;
        h=From:To:Cc:Subject:Date:From;
        b=O9GvhqQrBSSRCOAg78sYzGAMoPboqFJbPcQ5Gv4sC41z1mY0CT+XeJBT4h0v+1DSs
         ChTdKmkNx8bK0vF9VBUKz3nCQ7yZTpnD1lsSYEFpX6gosBBMOtYf3xW/LG+drfd7KZ
         RnqZl2JI1PwFo0QEG2y6Lcwt96wIoCK6VTIvdpdM6vQW7xBaTtz74808m5CMonVTxm
         vAS8VdBSa9fPVmU20cq8sS8Z/zkRgJEzK5Z4uPaKQioybj3Q2VKSU0y47fO6sSHVBv
         z6o20IMSD0HdMD179kJpNrY11EKTLWiTeea3T8FXUzfI0syBwLU/mwxsh/KMhYbN6D
         t3QgNnV++JSVw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] interconnect: qcom: Add SM8350 support
Date:   Thu, 18 Mar 2021 15:16:15 +0530
Message-Id: <20210318094617.951212-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds support for interconnect support for SM8350 SoC

Changes since v2:
 - Plug gaps in indexes
 - fix typo in commit log for patch2 and kconfig depends (for real this time)

Changes since v1:
 - Fix comments by Georgi, split the header
 - Fix the macro for qns_llcc

Vinod Koul (2):
  dt-bindings: interconnect: Add Qualcomm SM8350 DT bindings
  interconnect: qcom: Add SM8350 interconnect provider driver

 .../bindings/interconnect/qcom,rpmh.yaml      |  10 +
 drivers/interconnect/qcom/Kconfig             |   9 +
 drivers/interconnect/qcom/Makefile            |   2 +
 drivers/interconnect/qcom/sm8350.c            | 633 ++++++++++++++++++
 drivers/interconnect/qcom/sm8350.h            | 168 +++++
 .../dt-bindings/interconnect/qcom,sm8350.h    | 172 +++++
 6 files changed, 994 insertions(+)
 create mode 100644 drivers/interconnect/qcom/sm8350.c
 create mode 100644 drivers/interconnect/qcom/sm8350.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8350.h

-- 
2.26.3


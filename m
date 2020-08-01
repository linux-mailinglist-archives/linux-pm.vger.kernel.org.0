Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE6C235249
	for <lists+linux-pm@lfdr.de>; Sat,  1 Aug 2020 14:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgHAMbQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Aug 2020 08:31:16 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:14255 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728609AbgHAMbP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Aug 2020 08:31:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596285075; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=Q3UxvfdaSAZg3ceqWsx2yQaBTKuEUieAdlU+miZJLm0=; b=niM2LJoj87dlVzhcAqPmD7YbRbZxjhgCTba+JWwmwDCLQZNZlOiuVjm6e0VJEN8zirpo18FK
 ZaTYfPgKoHCsf7BtLouAUExK6EcoUxS7EjhIVzRXomhPu6uRthFbQSaOKAkRQCly1izZHqLZ
 bqe1LfcECi0YX5CvEvr1n/j5T70=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f256085eecfc978d3e73110 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 01 Aug 2020 12:31:01
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CEF0AC43395; Sat,  1 Aug 2020 12:31:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6F83BC433C9;
        Sat,  1 Aug 2020 12:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6F83BC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     robh+dt@kernel.org, georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jonathan@marek.ca,
        linux-pm@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 0/7] Add L3 provider support for SM8150/SM8250
Date:   Sat,  1 Aug 2020 18:00:42 +0530
Message-Id: <20200801123049.32398-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Operation State Manager (OSM) L3 provider support on SM8150 and Epoch
Subsystem (EPSS) L3 provider support on SM8250 SoCs.

Depends on: https://patchwork.kernel.org/cover/11687925/

Sibi Sankar (7):
  dt-bindings: interconnect: Add OSM L3 DT binding on SM8150
  interconnect: qcom: Add OSM L3 support on SM8150
  interconnect: qcom: Lay the groundwork for adding EPSS support
  dt-bindings: interconnect: Add EPSS L3 DT binding on SM8250
  interconnect: qcom: Add EPSS L3 support on SM8250
  arm64: dts: qcom: sm8150: Add OSM L3 interconnect provider
  arm64: dts: qcom: sm8250: Add EPSS L3 interconnect provider

 .../bindings/interconnect/qcom,osm-l3.yaml    |  2 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi          | 11 +++
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 11 +++
 drivers/interconnect/qcom/osm-l3.c            | 75 ++++++++++++++++---
 drivers/interconnect/qcom/sm8150.h            |  2 +
 drivers/interconnect/qcom/sm8250.h            |  2 +
 .../dt-bindings/interconnect/qcom,osm-l3.h    |  3 +
 7 files changed, 95 insertions(+), 11 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


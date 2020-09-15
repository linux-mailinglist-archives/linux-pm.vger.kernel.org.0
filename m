Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768FD269F98
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 09:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgIOHYl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 03:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgIOHYh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 03:24:37 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616E1C06174A
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 00:24:37 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o16so1309772pjr.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 00:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qLQnD0O574PmqchHwylwIu1vZvsCOyk6uoC7Y035P2k=;
        b=EC+Yh96NN7VUrpu9VrwDTKqfosoTian8TpCa8LULjrmawU4sR9gh0aUhzzwrHCOq4j
         +/0fBgCGwkZRKX5yBfcfCsZjDe3TjZHgbGOwLUEqzi8Qga6HspQEpXAP6tZZpOa10JFW
         IbNUeVCE3ACdyHtvtfCx2N+XUsPwJFZmAA9o0QNQ+aw0DGjV7/OwEsg5GR+cRsoZGj2R
         40DYzq3GQG6it509ZAv2ghXtAVRXYuq4ipvPZet8MTPfv/KuVHk1F/3sMTotq9n3s2VN
         wo/MsNPCNakIjm63+BVO/HSyzeDIXClh7H0MV7mM1LPg6Twzy98zsAOvqAzVdx7PYvjY
         WQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qLQnD0O574PmqchHwylwIu1vZvsCOyk6uoC7Y035P2k=;
        b=JWoWD5iAIYyCebRcBieiRlFtlRiZqZYWRTM/U4ovRMfIHTDte/qleOi3eTmdkLyJwW
         S05u2HRaD+4KWW569sNP6QpjvKgF4524R67TaPd/COcSrNP6pF9KEjNAwcLTbqly5g//
         Xsp/ExHH+2h7HQ1dANWJV6eYcMmLb1OJwahAE8ijNhE+dFhyNCR2zqW6vDu04kI87wQc
         LlizAIPBq/ny9IJaQdYmmccoFwotGhxwk7hpB6KeJp0DBAJ96MQvmOSvuuQU1YKScGHM
         rLapV9EEft4VTEUfAYQWeYfnFuNUK/Wn7p+3P0RbV8I8/Jaw5uAK0g6khH71NNVZzTvu
         aInA==
X-Gm-Message-State: AOAM531oHep8dx5XglBHF/Qtwp/7S9oW2QRntOmko89vaQxTY/Lr8X5C
        vW24FMxdw47bxm4Z5g5/xmm2
X-Google-Smtp-Source: ABdhPJy7OZY+IuFBCVarMJtkmyCdKUypcZIIyOiMzldBQTKxxQLcwNy30YZbhi5yU4EK+AAS9rs6Ug==
X-Received: by 2002:a17:902:7103:b029:d1:e5e7:be75 with SMTP id a3-20020a1709027103b02900d1e5e7be75mr535859pll.79.1600154676753;
        Tue, 15 Sep 2020 00:24:36 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id m24sm10701501pgn.44.2020.09.15.00.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 00:24:36 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     amitk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        tdas@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/5] Add CPUFreq support for SM8250 SoC
Date:   Tue, 15 Sep 2020 12:54:18 +0530
Message-Id: <20200915072423.18437-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This series adds CPUFreq support for Qualcomm SM8250 SoC. The existing
qcom-hw driver is reworked to support the EPSS block on this SoC which
handles the CPUFreq duties.

The EPSS block supports additional features for which incremental patches
will be submitted on top of this series!

Thanks,
Mani

Changes in v2:

* Dropped the regmap conversion patch
* Used "qcom,cpufreq-epss" compatible and "epss_soc_data" for dev data
* Switched to "of_device_get_match_data" API
* Collected reviews from Amit, Viresh and Bjorn
* Dropped patch [3/7] which got applied by Viresh

Bjorn Andersson (1):
  arm64: dts: qcom: sm8250: Add cpufreq hw node

Manivannan Sadhasivam (4):
  dt-bindings: cpufreq: cpufreq-qcom-hw: Document Qcom EPSS compatible
  cpufreq: qcom-hw: Use devm_platform_ioremap_resource() to simplify
    code
  cpufreq: qcom-hw: Use of_device_get_match_data for offsets and row
    size
  cpufreq: qcom-hw: Add cpufreq support for SM8250 SoC

 .../bindings/cpufreq/cpufreq-qcom-hw.txt      |   2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  22 ++++
 drivers/cpufreq/qcom-cpufreq-hw.c             | 107 ++++++++++++------
 3 files changed, 93 insertions(+), 38 deletions(-)

-- 
2.17.1


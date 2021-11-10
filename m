Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CB244C0CD
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 13:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhKJMK2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 07:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbhKJMKZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Nov 2021 07:10:25 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD8EC0613F5
        for <linux-pm@vger.kernel.org>; Wed, 10 Nov 2021 04:07:38 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id h24so1405122pjq.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Nov 2021 04:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8rRp4mt0YjhP7Pw1VHZ7lqEaPAtaRzgAK3M7/sT4H5c=;
        b=Ccochr5bIhiZaZAQs2NdVrtS68+qrZ5EXk6TfkfgmGcO5XLJIwsJZBJehcoZEAk0Np
         aiZ0liAGf88wfukqv7TLiNaGIhom8CANSs11D+ScQu7hdUZ/vcMYjrf4Y+fbV8W40iR1
         UigIuz5jkx3tJM7wN9wiLT+wDS20P7jSHRqasNqjvipziwRLgXYnEreM3UD0KgqFNQux
         oQMtMom/qFBn/wux6f3yLtzc+rDY1GS5rm5Wwfl5ttr/YC3gGl/ih5m1Wiz6I77YCuxG
         TH0YEgvXE8PyzAOgGDav9vyHF0Oi1bFgBoEnrEUkIjEk2YjUiTAQysi/qFtiyd8nFarm
         a+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8rRp4mt0YjhP7Pw1VHZ7lqEaPAtaRzgAK3M7/sT4H5c=;
        b=61gUHxLpAk9ndL4yWt7jku4QTb9PrnaUo4B6gGgBcPiGi/E8ugswpb4DfM80jZR1uD
         ZwB0qFE7ROkpjFB81ZmcK8nV12SU9Gv3mSaoQ7QO8gYy+JtA3bDUv9EiXo7QiWIJ/ymN
         6MuEuAMSk4oIlMF8gLAZTnwTPhAyQr6HvW7qn5Rj2qKOFzTtGAFR5UoRYE7OONMUI5XO
         D4q+eafO9lNuuZFnMwAfvDa6XYTP3N6MuI9rOQehIrXHG8wI3ucUasDcg+vaDFiILMSA
         Q+vpWZVEN18U+n13Q+luORaraOyq9Ovta6b288AXqOmzVroe4ZAOSVRUprDNYFnw15HM
         ZpIg==
X-Gm-Message-State: AOAM531Sxraulh/s/XRpl47WXZ5JM1vPe5Y+5XHfMexesBcNS7Eppq+U
        q1mkHNxaldfzEHrGih1CaYr8rw==
X-Google-Smtp-Source: ABdhPJzssEF1wgqVETKPrumL9GFeiX2PGWcV2MJgPs6EMbsDH3gWOTZJb62ALRHwD4BK31j2dNy+tQ==
X-Received: by 2002:a17:902:b593:b0:12d:7aa5:de2d with SMTP id a19-20020a170902b59300b0012d7aa5de2dmr15353076pls.31.1636546057736;
        Wed, 10 Nov 2021 04:07:37 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id g9sm8377914pfc.182.2021.11.10.04.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 04:07:37 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/6] Add QCM2290 interconnect support
Date:   Wed, 10 Nov 2021 20:07:10 +0800
Message-Id: <20211110120716.6401-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The series begins with a separate cleanup on icc-rpm, followed by a few
prep changes for QCM2290 support, and then adds bindings and
interconnect driver for QCM2290 platform. 

Shawn Guo (6):
  interconnect: icc-rpm: Use NOC_QOS_MODE_INVALID for qos_mode check
  interconnect: icc-rpm: Define ICC device type
  interconnect: icc-rpm: Add QNOC type QoS support
  interconnect: icc-rpm: Support child NoC device probe
  dt-bindings: interconnect: Add Qualcomm QCM2290 NoC support
  interconnect: qcom: Add QCM2290 driver support

 .../bindings/interconnect/qcom,qcm2290.yaml   |  117 ++
 drivers/interconnect/qcom/Kconfig             |    9 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/icc-rpm.c           |   56 +-
 drivers/interconnect/qcom/icc-rpm.h           |   14 +-
 drivers/interconnect/qcom/msm8916.c           |    4 +-
 drivers/interconnect/qcom/msm8939.c           |    5 +-
 drivers/interconnect/qcom/qcm2290.c           | 1363 +++++++++++++++++
 drivers/interconnect/qcom/sdm660.c            |    7 +-
 .../dt-bindings/interconnect/qcom,qcm2290.h   |   94 ++
 10 files changed, 1658 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
 create mode 100644 drivers/interconnect/qcom/qcm2290.c
 create mode 100644 include/dt-bindings/interconnect/qcom,qcm2290.h

-- 
2.17.1


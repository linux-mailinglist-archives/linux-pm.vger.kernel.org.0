Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D926593AB
	for <lists+linux-pm@lfdr.de>; Fri, 30 Dec 2022 01:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbiL3APx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Dec 2022 19:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiL3APX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Dec 2022 19:15:23 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFE913D55;
        Thu, 29 Dec 2022 16:15:22 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id g2so7372548ila.4;
        Thu, 29 Dec 2022 16:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vgvoEEnyjKhsQK10130Jze9YY2KZ/Q9IY37GnBFEgKI=;
        b=gNGRGSxl8V4wHDSPwtt4bphd8lyOKtJ62I6Ng6kLm+jQDhfbjWzgcaLBW1pZifh1PG
         goFH83WAlXYiMYST4WESMUWO2jJBp1StIjbMxhYo4zSnyAiu42b/eI4mwiM5lbRcUP3o
         HlQ1dzXGUh60H4y7wgq5RpptUKiX2HZ7FDHO9dqJAVGDddpaHTxFsa5kBXQ3nR9joLfy
         TABo7umBHYqGX/N0fcgwG3yTy16kOHqKgz9O0xSyuSj8yMBsLWNziJwcoVK7g9vZEuLo
         kN/lRXqpmLT67xBi8Hg8WHjl8Cf+hKSRmXnLQTtdyXo6ddaJ02ABEKbP/3tEh7QcdF+p
         JHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgvoEEnyjKhsQK10130Jze9YY2KZ/Q9IY37GnBFEgKI=;
        b=AO/IbvKl/J/N+KvBypKgx6xAyXrhNBZN0bDmrpl1tinTkDj7VeGS21zV4vp2Y6TEM7
         QJxxLmYVEavG1xhH5T0r6TjIsKn59uRTiKYNczoTVqNpvErAHd27D7lsbsANX/mySy8p
         M3LHRpkZF7FFUcOIggNdP2CccZd2sabS3gF8tAz+ssjT/6+UuH4PjTiY7WdGebXGW88B
         Wo/NMhkEcm635QWVua2JRHasw6ESpKWaWkcu3vPNUi8gErsH7nXqvzEw6CGTAyuLiAg4
         f8N4tSR6qcdDWdQa/3b5KuSY0dNeKkLLdmZt1BUqyWmVtiUVoYbmAIjQE9xZKBVpGfD1
         R+Tw==
X-Gm-Message-State: AFqh2kqq4UI/HouYiG/zchCB/neN4Fa7C35bfay8c8K26QcwYO2FEjY0
        PsDHWYjTgV//nlVwjt02cOE=
X-Google-Smtp-Source: AMrXdXu47pJ52bYyRnQiS09cn2wkVFPR3q8S55x0BzwGHbUPrR4BqtZZoU8EylarKxHLB1j1h9H76g==
X-Received: by 2002:a05:6e02:1d91:b0:302:3883:e567 with SMTP id h17-20020a056e021d9100b003023883e567mr38620194ila.29.1672359322227;
        Thu, 29 Dec 2022 16:15:22 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::b8e2])
        by smtp.gmail.com with ESMTPSA id g20-20020a02b714000000b0038a56594026sm6443996jam.66.2022.12.29.16.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 16:15:21 -0800 (PST)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v2 0/4] SDM670 Interconnects
Date:   Thu, 29 Dec 2022 19:14:38 -0500
Message-Id: <20221230001442.369608-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds interconnects and consumers to the Snapdragon 670.

Changes:
 - change qcom,sdm670.h to qcom,sdm670-rpmh.h (1/4, 4/4)

Richard Acayan (4):
  dt-bindings: interconnect: add sdm670 interconnects
  interconnect: qcom: add sdm670 interconnects
  arm64: dts: qcom: sdm670: add interconnects
  arm64: dts: qcom: sdm670: add opps for peripherals

 .../bindings/interconnect/qcom,rpmh.yaml      |   8 +
 arch/arm64/boot/dts/qcom/sdm670.dtsi          | 165 +++++++
 drivers/interconnect/qcom/Kconfig             |   9 +
 drivers/interconnect/qcom/Makefile            |   2 +
 drivers/interconnect/qcom/sdm670.c            | 440 ++++++++++++++++++
 drivers/interconnect/qcom/sdm670.h            | 128 +++++
 .../interconnect/qcom,sdm670-rpmh.h           | 136 ++++++
 7 files changed, 888 insertions(+)
 create mode 100644 drivers/interconnect/qcom/sdm670.c
 create mode 100644 drivers/interconnect/qcom/sdm670.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sdm670-rpmh.h

-- 
2.39.0


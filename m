Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAB05663E9
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jul 2022 09:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiGEHXv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jul 2022 03:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiGEHXu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2022 03:23:50 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036422615
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 00:23:49 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id k14so10289787plh.4
        for <linux-pm@vger.kernel.org>; Tue, 05 Jul 2022 00:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8rbEhw6j9pFcMzg6DlhT76WbqkNNFflGCPGuP0xsCvg=;
        b=CRNz0GunVs1FoGBH1egrw9QzY53WtHgCknHKIf9Ij2oeHltlJ8saEDwEWShrWPhV+p
         1+Ug/RUhOTGcEzLCEg6gb3RE4+ItgPm/qGEqkQ3ppGCjTk6efwWxMN2LqRr24dXXA/d6
         KM9rfDkEHB251KclJQuJhmwp+qgcr099oiz9Yl77nwtkzcM/hxqx93rm13VPo+BsOEAN
         0IwgAkLt3i5TMo4FkZ2rEktYVO+ao5mFqHjV3vfwXl5Y6SKzoTdz9Q4TTipfLpMEvVkx
         pELjlBGPR+KfjThxzZw5qzVGd5dVZ6QtwEcpLTEHQ0uQoPnd172zG+WLUKBgqCXgrI8i
         ycBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8rbEhw6j9pFcMzg6DlhT76WbqkNNFflGCPGuP0xsCvg=;
        b=cgChTAG8kfnhY+tkk7hWZet/3nhqsqfENHNUDZD9uzQB+aBSnPSf6NPt0XulyyDZXk
         v7WFcV4iqQLOJ5JJRS+G5HWcVjJi+eNRQwdOnXBufTvbv5/6nn4ISOlpc2jLNNHwbGbo
         cYcHCKNblPZgCoD4jnEdRm2VP9ee+V0mAnqO0r7zNA42549QtTEJbItEIIHprxGv7xw/
         VmNl8qsR22tMq2N/CcYDJoFWGt4lBRlgjeS/Oawz3cpXjG3W+YWGbQi3b33t91xH4PPG
         7WyWvr6jtSyBT565nA8ddaMu7lDIwIhpY4Kci3FSZ+yF/4S2a8O0RwWDvrhXDm97CING
         DdLA==
X-Gm-Message-State: AJIora9+IlXEzzaSrryVzBj+dUfI0OXD77B9M5Q1eKkxbfek14f/+bVP
        VX659ErjD8g3QWUVWOB851/1nw==
X-Google-Smtp-Source: AGRyM1ujrD8pTQ5NVOgiq84qm4JbwiwkARGBkqLVU0itnVKShIBiN9vGOR8+cBcIJHPKHXlJ0eDzZw==
X-Received: by 2002:a17:902:7c12:b0:16a:11b9:ae9f with SMTP id x18-20020a1709027c1200b0016a11b9ae9fmr39927775pll.82.1657005828364;
        Tue, 05 Jul 2022 00:23:48 -0700 (PDT)
Received: from leo-build-box.lan ([154.3.32.171])
        by smtp.gmail.com with ESMTPSA id y6-20020a626406000000b0050dc76281f0sm22148016pfb.202.2022.07.05.00.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:23:47 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 0/5] interconnect: qcom: icc-rpm: Support bucket
Date:   Tue,  5 Jul 2022 15:23:31 +0800
Message-Id: <20220705072336.742703-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch set is to support bucket in icc-rpm driver, so it implements
the similar mechanism in the icc-rpmh driver.

We can use interconnect path tag to indicate the bandwidth voting is for
which buckets, and there have three kinds of buckets: AWC, WAKE and
SLEEP, finally the wake and sleep bucket values are used to set the
corresponding clock (active and sleep clocks).  So far, we keep the AWC
bucket but doesn't really use it.

Patches 01, 02, 03 enable interconnect path tag and update the DT
binding document; patches 04 and 05 support bucket and use bucket values
to set the bandwidth and clock rates.

Changes from v3:
- Removed $ref and redundant sentence in DT binding document for
  '#interconnect-cells' (Krzysztof Kozlowski).

Changes from v2:
- Fixed for DT checker error for command ''make DT_CHECKER_FLAGS=-m
  dt_binding_check' (Rob Herring).

Changes from v1:
- Added description for property "#interconnect-cells" (Rob Herring);
- Added Dimtry's reviewed tags for patches 02 and 03 (Dmitry Baryshkov);
- Rebased on the latest mainline kernel and resolved conflict.


Leo Yan (5):
  dt-bindings: interconnect: Update property for icc-rpm path tag
  interconnect: qcom: Move qcom_icc_xlate_extended() to a common file
  interconnect: qcom: icc-rpm: Change to use qcom_icc_xlate_extended()
  interconnect: qcom: icc-rpm: Support multiple buckets
  interconnect: qcom: icc-rpm: Set bandwidth and clock for bucket values

 .../bindings/interconnect/qcom,rpm.yaml       |   6 +-
 drivers/interconnect/qcom/Makefile            |   3 +
 drivers/interconnect/qcom/icc-common.c        |  34 +++++
 drivers/interconnect/qcom/icc-common.h        |  13 ++
 drivers/interconnect/qcom/icc-rpm.c           | 134 ++++++++++++++++--
 drivers/interconnect/qcom/icc-rpm.h           |   6 +
 drivers/interconnect/qcom/icc-rpmh.c          |  26 +---
 drivers/interconnect/qcom/icc-rpmh.h          |   1 -
 drivers/interconnect/qcom/sm8450.c            |   1 +
 9 files changed, 182 insertions(+), 42 deletions(-)
 create mode 100644 drivers/interconnect/qcom/icc-common.c
 create mode 100644 drivers/interconnect/qcom/icc-common.h

-- 
2.25.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E6F56120E
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jun 2022 07:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiF3F6P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jun 2022 01:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiF3F6N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2022 01:58:13 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC49511A
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 22:58:09 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id g4so10591376pgc.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 22:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vST4GG3gAOIX2GEs1KQ/Cp0t/5GyuwSLCsdFHqp/yEQ=;
        b=oRv0MgQaZPxDcDTTxS8/zcCC1jV3zZblrcj54mJjDUW28h1hFBuHTADCFNECibmfvA
         KXinMKVdFRhzb6wYoLTOHIdtgCaL53LSzgX5+gj1tvOJpuJYZO5BquZbcDhxpTHJ3nX8
         0o586YGgM1B6e4uUZOt0tF1vO0isLPW3+yp5p2GLjoFHeROFplT9/2fwxgZwkxvGbEoY
         k+dDGZ1dUISp3MlbUWX7AmDF67TK8bAoUwT0lnr0kK0plfPhanlAOfkPSfoYLRUZlEh6
         AcnMpsiwAkJyJevyN9VYuPvPSUsFlyR1df752q9KC3/7p6XXbt59rm+m8Njvyl2enrvu
         Ixxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vST4GG3gAOIX2GEs1KQ/Cp0t/5GyuwSLCsdFHqp/yEQ=;
        b=yO6e4YZHYVDALYO6wyuJ2xDjCfeZnYEdjScuahB5ZV+5mAUsn8rD38exM3fAayqC+e
         snVq1f6OXe3nNwm5qTj3pKzZFUQ8mrrnKP5UjV1s/7jWx0jBxvwFy+Ynt1eHs2raxazF
         JKLYS3zabvXBD7YKukcmW4wfy5Dyuoq2hiEHiAdrL5osM4MoQOV+vu+9nx9l4MfQ8m6l
         qy1vQ0VOAapJ8JjHyVOGkNcB3xetqeunEF1OfH0WBN9IpX4Y8nR/Q8/hduvn9WvVBuRa
         GPiVhQtVeaD/EKx6mLZ03r+LsHMq/Jak/pIN9Fj7TsDSD2tf1+nx2zsl6H/fXzf1TIYS
         jojg==
X-Gm-Message-State: AJIora8baiNO1mtFwrQe6Q4g3gzRXush6mhKXicjggereV5YoAmZusQ0
        n9AvTd+cUrhnF2kzvFofO/Bu9A==
X-Google-Smtp-Source: AGRyM1sT4QampM8pQEesiircQrg5ViYkwV77T3kk74oPP5EDbwljqIJwY+axYBSwAZ0GacVc1Pgmbw==
X-Received: by 2002:a05:6a00:17a7:b0:525:4306:72ad with SMTP id s39-20020a056a0017a700b00525430672admr13028386pfg.42.1656568689180;
        Wed, 29 Jun 2022 22:58:09 -0700 (PDT)
Received: from leo-build-box.lan ([154.3.32.171])
        by smtp.gmail.com with ESMTPSA id b14-20020a17090a550e00b001e31f4cc977sm3309288pji.56.2022.06.29.22.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 22:58:08 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/5] interconnect: qcom: icc-rpm: Support bucket
Date:   Thu, 30 Jun 2022 13:57:17 +0800
Message-Id: <20220630055723.704605-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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


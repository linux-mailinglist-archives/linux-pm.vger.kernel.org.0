Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BD44F5659
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 08:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241793AbiDFFij (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Apr 2022 01:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1851312AbiDFDC7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2022 23:02:59 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54FE64E9
        for <linux-pm@vger.kernel.org>; Tue,  5 Apr 2022 16:59:13 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bu29so1322653lfb.0
        for <linux-pm@vger.kernel.org>; Tue, 05 Apr 2022 16:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QOt6DJcLelTgkTPVmldTvMlvDQEbrpbWK917oZbjN0w=;
        b=tHjIQHSXPYXo6cTSKoL3JHG0UImC5yIJ+e/f9YaJDb9ZqDD9TNBB7U8EczTEXMmnk/
         xQaoJCCgTk2t9KgbcdXuBiFwZEPteCYG8ZHHEaDiFBbRi4zlsxu7uLRG9dVuqkkOUEoX
         QOLJ0fDNLZu6f0nPHj38DekLjDHPTO+fggRVpYFkd/SStJZ7a4rNENEj9weqtJPskiYl
         6DdNIaNhdMvn29IP9L1Z2170us9SEFyUui8pHoDVAlYIH5nrcwd4v4MhPkhnGjCi3jkS
         IIZHRXdtThjM/gRZ3nnzaTta7ukxzt5JiONJmn96GuH998VuWSgSY6upUxUv3U6dMLBS
         yW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QOt6DJcLelTgkTPVmldTvMlvDQEbrpbWK917oZbjN0w=;
        b=GxRppdGSvAr2FUr+pBrCG65MiIKF1jL1O6unYfbH9cl/QKMJLG1F0u/r9/CrFFzBkV
         Lu/tXD4hoWZJA+PFPEah7duYlFf/hdH9ovRwLIibqWUxOpRMDkPVBVEJfWjVC/poOHiA
         BRGW3zxKrb8i+Ok8hYNM8e1y3gn7Tfq6fJVH7oPiMl1EfidY152jxrW+p8XZ3qACsU1S
         gEJwdspdVODZYSPWHidjtc1XEc8mQYjArj9KYv+rBhirrSLQSqiDUyfeU+uwOVSMP6zH
         K/7VtBnm2pd/A5oGcO1kLl47NFBezohkX/mM0lBcLIHOsIBIim0r23JVXO1bCUjqGKUe
         JYBQ==
X-Gm-Message-State: AOAM532qYv8ilCk62LzpuV6IsFpxMzKLexSVjQVdn+dGodTbU11U/ya2
        shCi0vfD6uNUz5qJpZS4Qwhmvg==
X-Google-Smtp-Source: ABdhPJyRrLV6ZhWNcC+LtcC93NA/42wRqTNcug5mNhrZb9Xd+1lGj4wfRvbf/sgIYJiwvkye/aavpg==
X-Received: by 2002:a05:6512:16a7:b0:445:862e:a1ba with SMTP id bu39-20020a05651216a700b00445862ea1bamr4085065lfb.85.1649203151822;
        Tue, 05 Apr 2022 16:59:11 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w14-20020a0565120b0e00b0044a9b61d2b3sm1646471lfu.221.2022.04.05.16.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 16:59:11 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 0/4] arm: qcom: qcom-apq8064: add separate device node for tsens
Date:   Wed,  6 Apr 2022 02:59:06 +0300
Message-Id: <20220405235910.373107-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
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

Currently gcc-msm8960 driver manually creates tsens device. Instantiate
the device using DT node instead. This follow the IPQ8064 device tree
schema.

Compatibility with the previous devices trees is kept intact.

Dmitry Baryshkov (4):
  dt-bindings: thermal: qcom-tsens.yaml: add msm8960 compat string
  thermal/drivers/tsens: add compat string for the qcom,msm8960
  clk: qcom: gcc-msm8960: create tsens device if there are no child
    nodes
  arm: dts: qcom-apq8064: create tsens device node

 .../bindings/thermal/qcom-tsens.yaml          |  4 +++-
 arch/arm/boot/dts/qcom-apq8064.dtsi           | 23 +++++++++++++------
 drivers/clk/qcom/gcc-msm8960.c                | 18 +++++++++------
 drivers/thermal/qcom/tsens.c                  |  3 +++
 4 files changed, 33 insertions(+), 15 deletions(-)

-- 
2.35.1


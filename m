Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB095118FF
	for <lists+linux-pm@lfdr.de>; Wed, 27 Apr 2022 16:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbiD0M5k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Apr 2022 08:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbiD0M5i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2022 08:57:38 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DE14B415
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 05:54:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t25so2967389lfg.7
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 05:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HqwVCZPmc4mOi+NYnTP0qy4thOKdsBFKwRmb5wY2Y64=;
        b=nb2mYuJus/SBWKqm+xwNcWbLPTPY8OHld/D92DhMZDeDDvXZ1O2qm8P9B2sPE7HjDT
         k5SHg44VprWmmOt+sVgtGU6Mvqtizzsg4DSIsVHcZL9IVKk5tOSDofqu5PBDw9lu0LwA
         C1exm9Ip7hWKEo9MTPlsPSUgZwB7SCxi2RXc6EI9jlHJpxkypBW4+13lBclvGZCwZced
         FO0WN2MofEnZsf6/lK8ffA5xmzxwH2iRFGk6FRzqG8/ej3fhSpIOElB7lXrdrQF/rf1g
         +rEGoG/hnrctD39363ggSuJ/kI4bI0bs9eXqL5U+S069tQjpikEKee23Q6aRMU6hKYrQ
         RFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HqwVCZPmc4mOi+NYnTP0qy4thOKdsBFKwRmb5wY2Y64=;
        b=DBp4nYvqTfHZ4j8pFz+rmbFTc2JH+CuVsJvmFq6Mm23R1N0O/wA5GnQNw4cix18FZR
         qKOlmRXMD4nIP7KKMK/pRvgE9A7VidY6x+wE7y8QhB0D3+C3YH+legPAme+nW3+F1lb8
         FMXi6hLu5hrhnHD7idGDkpe7ROof6vVPn6VeuU3q6XTlsd95AuUY38Xo0HhnVwUYB6HZ
         ciR9UArO2MjSo7hLNWyB8GFFpHlFj3FJs6Qe76exCG41Rt2X/baxTxt0f+ph2Ao5LgrH
         VOA4HY4DiK8Vd2RdBd96MtgnTzpYqZFKiPrvv9fCcTJknZVDSb+OahqsbmzIODA3BdaN
         wbfw==
X-Gm-Message-State: AOAM5325XXJ9ICqK1Zv7s7muovSZAd/LW+jFSCblxaQmS+idSjl07B00
        DWAICXzcIB4wyCtPzgMu2O4kTFO3s4/M8A==
X-Google-Smtp-Source: ABdhPJzIgbUxr5NmjM1/E6copsx350dNy6TDDaAQYsEjU2Ck+B9ydWxc5wsxXOyLjTiao6E5dAqaEw==
X-Received: by 2002:ac2:4204:0:b0:464:f034:77a7 with SMTP id y4-20020ac24204000000b00464f03477a7mr19790889lfh.328.1651064065238;
        Wed, 27 Apr 2022 05:54:25 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id r9-20020a2e94c9000000b0024b4c2a1346sm1827445ljh.123.2022.04.27.05.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 05:54:24 -0700 (PDT)
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
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        quic_tdas@quicinc.com
Subject: [PATCH v5 0/3] arm: qcom: qcom-apq8064: add separate device node for tsens
Date:   Wed, 27 Apr 2022 15:54:20 +0300
Message-Id: <20220427125423.3166138-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently gcc-msm8960 driver manually creates tsens device. Instantiate
the device using DT node instead. This makes the APQ8064 follow the
IPQ8064 device tree schema (which is also closer to the way tsens
devices are described on newer Qualcomm platforms).

Compatibility with the previous devices trees is kept intact.

Changes since v4:
- Added thermal-sensor description to the qcom,gcc-apq8064 schema

Changes since v3:
- Fix a typo qcom,gcc-msm8060 -> qcom,gcc-msm8960 (noted by Krzyshtof)
- Fixed indentation in the example (also noted by Krzyshtof)

Changes since v2:
- Remove patches merged by Daniel
- Rephrase commit messages to emphasize that these changes make apq8064
  follow ipq8064

Changes since v1:
- populate child devices in gcc-msm8960
- add syscon to the gcc device tree node

Dmitry Baryshkov (3):
  clk: qcom: gcc-msm8960: create tsens device if there are no child
    nodes
  arm: dts: qcom-apq8064: create tsens device node
  dt-bindings: clock: qcom,gcc-apq8064: split tsens to the child node

 .../bindings/clock/qcom,gcc-apq8064.yaml      | 49 +++++++++----------
 arch/arm/boot/dts/qcom-apq8064.dtsi           | 25 +++++++---
 drivers/clk/qcom/gcc-msm8960.c                |  6 ++-
 3 files changed, 44 insertions(+), 36 deletions(-)


base-commit: 3123109284176b1532874591f7c81f3837bbdc17
prerequisite-patch-id: b5aad2b1e0db4e6d77d6a2faa2fe95acf274b3c8
prerequisite-patch-id: a0c7dcfc85a1eac4969530b73230f226006d6e1a
prerequisite-patch-id: 0fbf70957a52fa87d038d08f9c599e314c69e7d5
prerequisite-patch-id: d22652b1f0e097692b670a0ed4c3f803875d1c5e
-- 
2.35.1


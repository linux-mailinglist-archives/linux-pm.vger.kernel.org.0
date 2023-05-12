Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A196FFDB3
	for <lists+linux-pm@lfdr.de>; Fri, 12 May 2023 02:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbjELANk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 May 2023 20:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239562AbjELANj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 May 2023 20:13:39 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC91E69
        for <linux-pm@vger.kernel.org>; Thu, 11 May 2023 17:13:36 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f2676d62a2so2352724e87.0
        for <linux-pm@vger.kernel.org>; Thu, 11 May 2023 17:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683850415; x=1686442415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8vXWsYBVQ6fbfhImzVmNrZ7KIf2Nh83Q0Y/f2HJbonU=;
        b=ke+VD4d38T34P9YvH3jv5n2uLWRSYlGZkauyTrFcp3JDSLKylhR+SfN0Te14UTX8DW
         QHmuljjMN0wMmk8GRB+9enMjpqKHug0rekF+pCZYpc7mC3XJNFzvZL0uIYyVrsAX5xYz
         KuARiQlhvoI3JSWHAZYxhB8R5qLnZcJdbid6I+ZmZGF0ZaTjVxBnm3pSF6KHsrzwWkO3
         POJfXt5qWUODtPgE7lb6995kkEyMdL7W6fHTFrjr6aaVgFH9XLlWBXnKqMG5qtubojrU
         +7jNenQGEnTmwDyc3Y+XOmzo9im2LWG1afZcxADgKcgTLHmt3AlATjFsM3OrI1FciMBP
         Yw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683850415; x=1686442415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8vXWsYBVQ6fbfhImzVmNrZ7KIf2Nh83Q0Y/f2HJbonU=;
        b=hSRCZ+uWVVf3htKYjbvagZwV/qt44p8g7N5+QEypF0UcJhJwIJInxDtRSROdMn592Z
         rp0Hc/WOMnmgicODaNN72gJbhfSluEBEOpof5vcWAIdOVH4QIpzujTcUAO+2r+ZASdaG
         6PkM/d5fJXoAz57nuhoxO+bO1XKhHgAieFTT5ubNLeN+Z5QFSCY1MH6BBQTGcraVMKDX
         cd7NorRYDBeRHX9uC8mmcydMH/i/u6oqLudveYRb14tYDEklz4/EWs5wyce+VQFb2x5o
         j8KenQb4ouEqFTvk/M6iCNowjwP0U1oMVT9Rt/Opq3CtkA0zQ7sPmfxFK4VAIUuTsb8/
         qnug==
X-Gm-Message-State: AC+VfDyAF8Lt0XMuthkqpBnJSJt4gJlo6A5hPA1ayQhVSWSZeEM6YpoC
        wp+ncRo6buarlVYhoM7E2Bk/CA==
X-Google-Smtp-Source: ACHHUZ5ipOmBCCs95o29BHFEojWXb4HSYqv5FmFsuBgFkAAsTTATvkiyGaYwFO0c+lQPZh/+g08ZOA==
X-Received: by 2002:a05:6512:909:b0:4d8:6540:a731 with SMTP id e9-20020a056512090900b004d86540a731mr2764683lft.47.1683850414945;
        Thu, 11 May 2023 17:13:34 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p15-20020ac246cf000000b004f13c3cb9ffsm1258109lfo.200.2023.05.11.17.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 17:13:34 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v6 0/4] clk: qcom: msm8996: add support for the CBF clock
Date:   Fri, 12 May 2023 03:13:30 +0300
Message-Id: <20230512001334.2983048-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On MSM8996 two CPU clusters are interconnected using the Core Bus
Fabric (CBF). In order for the CPU clusters to function properly, it
should be clocked following the core's frequencies to provide adequate
bandwidth.

Register CBF as a clock (required for CPU to boot) and add a tiny
interconnect layer on top of it to let cpufreq/opp scale the CBF clock.

Changes since v5:
- Fixed !INTERCONNECT warning (Konrad)
- Fixed the sync_state wrapper for !INTERCONNECT case

Changes since v4:
- Fixed typos in commit messages

Changes since v3:
- Dropped merged patches
- Moved interconnect shim to drivers/interconnect/icc-clk.c

Changes since v2:
- Added interconnect-related bindings
- Switched CPU and CBF clocks to RPM_SMD_XO_A_CLK_SRC

Changes since v1:
- Relicensed schema to GPL-2.0 + BSD-2-Clause (Krzysztof)
- Changed clock driver to use parent_hws (Konrad)
- Fixed indentation in CBF clock driver (Konrad)
- Changed MODULE_LICENSE of CBF clock driver to GPL from GPL-v2
- Switched CBF to use RPM_SMD_XO_CLK_SRC as one of the parents
- Enabled RPM_SMD_XO_CLK_SRC on msm8996 platform and switch to it from
  RPM_SMD_BB_CLK1 clock

Dmitry Baryshkov (4):
  dt-bindings: interconnect/msm8996-cbf: add defines to be used by CBF
  interconnect: add clk-based icc provider support
  clk: qcom: cbf-msm8996: scale CBF clock according to the CPUfreq
  arm64: dts: qcom: msm8996: scale CBF clock according to the CPUfreq

 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  51 ++++++
 drivers/clk/qcom/Kconfig                      |   1 +
 drivers/clk/qcom/clk-cbf-8996.c               |  60 ++++++-
 drivers/interconnect/Kconfig                  |   6 +
 drivers/interconnect/Makefile                 |   2 +
 drivers/interconnect/icc-clk.c                | 168 ++++++++++++++++++
 .../interconnect/qcom,msm8996-cbf.h           |  12 ++
 include/linux/interconnect-clk.h              |  22 +++
 8 files changed, 321 insertions(+), 1 deletion(-)
 create mode 100644 drivers/interconnect/icc-clk.c
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8996-cbf.h
 create mode 100644 include/linux/interconnect-clk.h

-- 
2.39.2


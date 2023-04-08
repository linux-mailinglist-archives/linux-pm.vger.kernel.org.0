Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A206DBE05
	for <lists+linux-pm@lfdr.de>; Sun,  9 Apr 2023 01:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjDHXth (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 8 Apr 2023 19:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDHXtg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Apr 2023 19:49:36 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434537DA9
        for <linux-pm@vger.kernel.org>; Sat,  8 Apr 2023 16:49:35 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i26so2823273lfc.6
        for <linux-pm@vger.kernel.org>; Sat, 08 Apr 2023 16:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680997773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vjY5uC2OLDu9t/zvDb185Jxk6WyhGhG54ExhZw16Qwo=;
        b=l2al2UAagNYfqX7sZv1z+V5IlXKiVQBgY4m2o784ANPhaiE9CXzTO9siI09VRwmCkh
         p9cKuEQ/ZuqqK7dPMC6pfISk9F8xNwTLWrP2lnX1pnKIDcHkJyBBKDu7Nk3nVTWJ59NG
         iEdgNvK8qDnu4tDRr1rGXyAS1P1DSUZqpb4jwRpIR6d8l/OxXZej1rFMejyw8ARgkJ67
         pkvQz6gjwNs4NGFogR/hp1D1rEhM8XruZqVAK2Lw36XrgfJz3Sot7kIZDk/tSH5PsZVZ
         w2UKdAmdZvBf99EW+s7id68E9wh6sylpHYSWWcsY3qBsZBBobiCMg62sfA6p7ywuIvjc
         +SUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680997773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjY5uC2OLDu9t/zvDb185Jxk6WyhGhG54ExhZw16Qwo=;
        b=rV+qOupQZeCmw6JfZ01yW/8hGsEvc+pf/g8zSkqTXIqedBadqs6+J94/+Tt9Ut7lmF
         PER+g+dyirVnfh3173Ds7LSJ30QQr4WixNHcziKyUcNSGVn+BQMxmD7qEmdKnGNp4UTP
         VRKwimpdg/2H4eAdbA4B9BA7JK4nu4RXH+sirP1wJMkCmjPsljJiQVJT7XIDkX8k3zbW
         eu/maBZhgRWonvT1Dh+jKUZrqPxRtU0H6KOQeBvzPvA9oEdViOHLPjdpEi9jresR8/3g
         jJ2A/4fKa1qnMzsY6E9cr/PaQK2T3ZclbfMB6DrQbjnPGvbWbaDgueoctRY8+RZmQulh
         g+eg==
X-Gm-Message-State: AAQBX9d7r2O2IV3U8wSvjOsQQIOnWnDcq8o1ehMY7VjElZuQzuDsgpjW
        HFO6ukf2HIxPUtCqsKpLUimvSw==
X-Google-Smtp-Source: AKy350ZHHe39RG5XW12vdubBuDno6QcKlq9lIVpew6JDRJpleJrMUXHY+fJ/ATmARXYRoruGadAYEQ==
X-Received: by 2002:ac2:5385:0:b0:4db:3a70:e9f3 with SMTP id g5-20020ac25385000000b004db3a70e9f3mr1371294lfh.69.1680997773424;
        Sat, 08 Apr 2023 16:49:33 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id q26-20020ac2529a000000b004e7fa99f3f4sm1353008lfm.265.2023.04.08.16.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 16:49:33 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 0/4] clk: qcom: msm8996: add support for the CBF clock
Date:   Sun,  9 Apr 2023 02:49:28 +0300
Message-Id: <20230408234932.2363302-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
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
  dt-bindints: interconnect/msm8996-cbf: add defines to be used by CBF
  iterconnect: add clk-based icc provider support
  clk: qcom: cbf-msm8996: scale CBF clock according to the CPUfreq
  arm64: dts: qcom: msm8996: scale CBF clock according to the CPUfreq

 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  51 ++++++
 drivers/clk/qcom/Kconfig                      |   1 +
 drivers/clk/qcom/clk-cbf-8996.c               |  59 +++++-
 drivers/interconnect/Kconfig                  |   6 +
 drivers/interconnect/Makefile                 |   2 +
 drivers/interconnect/icc-clk.c                | 168 ++++++++++++++++++
 .../interconnect/qcom,msm8996-cbf.h           |  12 ++
 include/linux/interconnect-clk.h              |  22 +++
 8 files changed, 320 insertions(+), 1 deletion(-)
 create mode 100644 drivers/interconnect/icc-clk.c
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8996-cbf.h
 create mode 100644 include/linux/interconnect-clk.h

-- 
2.30.2


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A497073D3B2
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jun 2023 22:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjFYUZz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Jun 2023 16:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjFYUZx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jun 2023 16:25:53 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581911BB
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:25:51 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f7677a94d1so3403130e87.0
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687724749; x=1690316749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jM8O0hSMy/hliZKLd+M06pcWLRDESz+CUKduJCXbalM=;
        b=G8ckCwOA+Jy1hFd04szW6yhJCgvUgyyOwRHbosrkKU9tfZ1hacMw7mm5J6etXI2Sjt
         g3fkyvS2Pvtw36JyEm5clQ5hNETfEvkn9v3koB6GzuyGI2s2FjBkgN51CuuZUjQCAhLd
         Hoc3j8oU6SenRmd49VIcg3fHp6AIqKE6BIDtbvSkWIW/BKb7coeWmSsT9lzPygheYHsA
         rrX1WHQbnFoEOTeZHqaKggQKjopF/KTXDr1Ai0cJcit4Aq5kfh0z3Yw9nl02OWg2FGU8
         LnOZxUrXY/nBylSqlfRrtJsgbwZ5WmpDE87cGiZXrpfSW2qSxjZfYuDKh91wmge9WIMx
         xFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687724749; x=1690316749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jM8O0hSMy/hliZKLd+M06pcWLRDESz+CUKduJCXbalM=;
        b=MQSrxJV7bSNY7SbMguHGkUuofNuqkz1hcx4/w1u9uwxImQSexNuIPTqzeJNB658z3q
         xzXD8TL8n7DiXsJQN3t8AgOsaI0Wp/FraWwyg/VO+ue88boYVhIZSydqkXEmlQNHw+1B
         ISc4VekkF/7+OfijVcus3rG3LhIUqnCZY9c4R1X/98D6TlJQKjy2oLhCB7Kblthy/1QM
         tR4hEX62jX4pyLrz0c4fCZ1LbdQb7lkofXboA+izG103TlhHCViHC76sbybBehxUQUHI
         wt+MstXBd2o1rVaIqnn/4yinMtBmYuv5Rk2dRdsPX8Dl0CcB5ErVJI0R3K9j+AbJNbg9
         oHTw==
X-Gm-Message-State: AC+VfDwLz2SbthJxMnRBZU1ZbHlzmYWqLD6mwIce1A+IODeX6XFirJwU
        4RcZx5yFE+Ws1oISuc1d+aK5uA==
X-Google-Smtp-Source: ACHHUZ732AgwtsdRIGVfJVXnf6XhTB+DhJ0rehKAr5NQth9BdYVMXDZVJ2UHoZ+T8IFVFMJyZmEM5Q==
X-Received: by 2002:a05:6512:684:b0:4f9:b649:23d2 with SMTP id t4-20020a056512068400b004f9b64923d2mr2206194lfe.42.1687724749121;
        Sun, 25 Jun 2023 13:25:49 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id m21-20020a195215000000b004f8427f8716sm787537lfb.262.2023.06.25.13.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 13:25:48 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 00/26] ARM: qcom: apq8064: support CPU frequency scaling
Date:   Sun, 25 Jun 2023 23:25:21 +0300
Message-Id: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
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

Implement CPUFreq support for one of the oldest supported Qualcomm
platforms, APQ8064. Each core has independent power and frequency
control. Additionally the L2 cache is scaled to follow the CPU
frequencies (failure to do so results in strange semi-random crashes).

Core voltage is controlled through the SAW2 devices, one for each core.
The L2 has two regulators, vdd-mem and vdd-dig.

Changes since v1:
- Added separate Krait L2 cache device driver
- Moved vdd-mem and vdd-dig scaling to the L2 cache device (Christian,
  Stephen Gerhold)
- Fixed the 'INTERCONNECT' in the guarding define for krait-cc bindings
  (Stephen Boyd)
- Made SAW2's regulator property -> node handling clear (Krzysztof)
- Dropped the 'regulator' property from all SAW2 devices.

Dmitry Baryshkov (26):
  dt-bindings: opp: opp-v2-kryo-cpu: support Qualcomm Krait SoCs
  dt-bindings: soc: qcom: merge qcom,saw2.txt into qcom,spm.yaml
  dt-bindings: soc: qcom: qcom,saw2: define optional regulator node
  dt-bindings: clock: qcom,krait-cc: Krait core clock controller
  dt-bindings: cache: describe L2 cache on Qualcomm Krait platforms
  interconnect: icc-clk: add support for scaling using OPP
  clk: qcom: krait-cc: rewrite driver to use clk_hw instead of clk
  soc: qcom: spm: add support for voltage regulator
  cpufreq: qcom-nvmem: create L2 cache device
  cpufreq: qcom-nvmem: also accept operating-points-v2-krait-cpu
  cpufreq: qcom-nvmem: drop pvs_ver for format a fuses
  cpufreq: qcom-nvmem: provide separate configuration data for apq8064
  soc: qcom: Add driver for Qualcomm Krait L2 cache scaling
  ARM: dts: qcom: apq8064: rename SAW nodes to power-manager
  ARM: dts: qcom: apq8064: declare SAW2 regulators
  ARM: dts: qcom: apq8064: add L2 cache scaling
  ARM: dts: qcom: apq8064: add simple CPUFreq support
  ARM: dts: qcom: apq8064: provide voltage scaling tables
  ARM: dts: qcom: apq8064: enable passive CPU cooling
  ARM: dts: qcom: apq8064-asus-nexus7-flo: constraint cpufreq regulators
  ARM: dts: qcom: apq8064-ifc6410: constraint cpufreq regulators
  ARM: dts: qcom: msm8960: declare SAW2 regulators
  ARM: dts: qcom: apq8084: drop 'regulator' property from SAW2 device
  ARM: dts: qcom: msm8974: drop 'regulator' property from SAW2 device
  ARM: dts: qcom: ipq4019: drop 'regulator' property from SAW2 devices
  ARM: dts: qcom: ipq8064: drop 'regulator' property from SAW2 devices

 .../devicetree/bindings/arm/msm/qcom,saw2.txt |  58 --
 .../bindings/cache/qcom,krait-l2-cache.yaml   |  75 ++
 .../bindings/opp/opp-v2-kryo-cpu.yaml         |  12 +-
 .../qcom/{qcom,spm.yaml => qcom,saw2.yaml}    |  39 +-
 .../dts/qcom/qcom-apq8064-asus-nexus7-flo.dts |  14 +-
 .../boot/dts/qcom/qcom-apq8064-ifc6410.dts    |  18 +-
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi      | 671 +++++++++++++++++-
 arch/arm/boot/dts/qcom/qcom-apq8084.dtsi      |   1 -
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi      |   5 -
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi      |   2 -
 arch/arm/boot/dts/qcom/qcom-msm8960.dtsi      |  12 +-
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi      |   1 -
 drivers/clk/qcom/krait-cc.c                   | 141 ++--
 drivers/cpufreq/qcom-cpufreq-nvmem.c          |  76 +-
 drivers/interconnect/icc-clk.c                |  13 +-
 drivers/soc/qcom/Kconfig                      |   9 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/krait-l2-cache.c             | 190 +++++
 drivers/soc/qcom/spm.c                        | 205 +++++-
 include/dt-bindings/clock/qcom,krait-cc.h     |  17 +
 include/dt-bindings/soc/qcom,krait-l2-cache.h |  12 +
 include/linux/interconnect-clk.h              |   1 +
 include/soc/qcom/spm.h                        |   9 +
 23 files changed, 1403 insertions(+), 179 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
 create mode 100644 Documentation/devicetree/bindings/cache/qcom,krait-l2-cache.yaml
 rename Documentation/devicetree/bindings/soc/qcom/{qcom,spm.yaml => qcom,saw2.yaml} (57%)
 create mode 100644 drivers/soc/qcom/krait-l2-cache.c
 create mode 100644 include/dt-bindings/clock/qcom,krait-cc.h
 create mode 100644 include/dt-bindings/soc/qcom,krait-l2-cache.h

-- 
2.39.2


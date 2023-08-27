Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25106789D75
	for <lists+linux-pm@lfdr.de>; Sun, 27 Aug 2023 13:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjH0LvO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Aug 2023 07:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjH0Luj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Aug 2023 07:50:39 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482CE18D
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:36 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bbbda48904so34610131fa.2
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693137034; x=1693741834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0K+MbnVIHNJmBUEHq1L8OxtvI1t9TpAxGZDVrhCzbns=;
        b=hBFMqd94PFZ0ic5b09lqriWCn0g+Vn2c7H8ddJtYEz3WZukaozzVokoiBnmPo469Bp
         23i4qizZ5qjx1r+Y8unp4EzCd9kwwnhG099E9hw3HwX/+JhiNtUdUt0l2cVs5A3NQNJv
         QHhKwnEBZQjkUL2LMbZkqqSWn2uho8hAbbinNvC6d2DZF2I0CU3+wjqgPG9nTthK70oG
         3IxgJiuR6v/+MAmtYzyu83oA5N5YCGr0wC7MGbB2m2wKRtKPdit0u03Y+7xGuWE005Lc
         DQaR7ntOTB4L5cXcF41u3sInKL5vbp0d7mIbIwBl6n1EbJbQ2hHsoEbBID6UHu+n2W+/
         r/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693137034; x=1693741834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0K+MbnVIHNJmBUEHq1L8OxtvI1t9TpAxGZDVrhCzbns=;
        b=C5n1yiJosCLt02PnHSjQ73R70WV4zSahynCeZeyL+6j3TVgOjKFDeQk8Ojzrol+Fmg
         zuDg6vwN+oHrsLIslTvqyectFyt3QKo2HjDimQKpfl/KfT1m8gTnwSWo/f/Z9atCMY6S
         Qa1Zmi/FE+SGEq/VFOn2zYpnOv/ZpJTIHDrB1C4NfLGtQTK+MbbSS06uR+r0WuH5cQjl
         OTCF5cv5GTcKikMf1Y/iF+2XY8lgfQpym/8Dj1oZrPluhD0R7muZgIbC9Mi5wOqTzTb0
         ed6zz+FgUC8iEZ3UeCvtk8djFIPSQrHby860pEktslv+n2khZoeIq4ZVNY401N1/yWn8
         BMoA==
X-Gm-Message-State: AOJu0YyczqhXFFac35CU0nmQ8d4hf6qReUncARLGlwjXIkvEkc8qmXbk
        PFSY9t7k4fgVdS+l9+gDe0hdyQ==
X-Google-Smtp-Source: AGHT+IFPMFVklxxjw8E7/nHW4AvYLe1uhdUr31qZN4r+OVexNbN0a5/9oXem7UjxiVi9EWt3Z2rr+g==
X-Received: by 2002:ac2:4f15:0:b0:4f8:5635:2cd8 with SMTP id k21-20020ac24f15000000b004f856352cd8mr18822343lfr.32.1693137034383;
        Sun, 27 Aug 2023 04:50:34 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a8-20020a19f808000000b004ff9f88b86esm1114770lff.308.2023.08.27.04.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 04:50:33 -0700 (PDT)
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
Subject: [PATCH v4 00/23] ARM: qcom: apq8064: support CPU frequency scaling
Date:   Sun, 27 Aug 2023 14:50:10 +0300
Message-Id: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Dependencies: [1], [2].

[1] https://lore.kernel.org/linux-arm-msm/20230827005920.898719-1-dmitry.baryshkov@linaro.org/
[2] https://lore.kernel.org/linux-arm-msm/20230827032803.934819-1-dmitry.baryshkov@linaro.org/

Changes since v3:
- Split the opp and cpufreq patches to a separate series (Viresh)
- Added the cache's select clause (Rob, Krzysztof)
- Fixed $ref to include full path (Krzysztof)
- Renamed opp-table-l2 to just opp-table (Krzysztof)
- Unrolled loops in krait_l2_config_regulators() (Konrad)
- Dropped useless comments from krait-cc DT (Konrad)
- Fixed Votlage comment formatting (Konrad)
- Added empty lines between nvmem cells (Konrad)
- Replaced direct register masks with GENMASK (Konrad)
- Reordered headers in spm.c (Konrad)

Changes since v2:
- Merged basic cpufreq and voltage patches, to make sure that we don't
  undervolt the cores (Konrad)
- Reordered patches pushing voltage constraints early (Konrad)
- Removed KRAIT_NUM_CLOCKS from the kraitcc bindings header (Konrad)
- Rebased on top of PMIC cleanup
- Added missing regulator constraints to apq8064-cm-qs600 and
  apq8064-sony-xperia-lagan-yuga.

Changes since v1:
- Added separate Krait L2 cache device driver
- Moved vdd-mem and vdd-dig scaling to the L2 cache device (Christian,
  Stephen Gerhold)
- Fixed the 'INTERCONNECT' in the guarding define for krait-cc bindings
  (Stephen Boyd)
- Made SAW2's regulator property -> node handling clear (Krzysztof)
- Dropped the 'regulator' property from all SAW2 devices.


Dmitry Baryshkov (23):
  dt-bindings: soc: qcom: merge qcom,saw2.txt into qcom,spm.yaml
  dt-bindings: soc: qcom: qcom,saw2: define optional regulator node
  dt-bindings: clock: qcom,krait-cc: Krait core clock controller
  dt-bindings: cache: describe L2 cache on Qualcomm Krait platforms
  interconnect: icc-clk: add support for scaling using OPP
  clk: qcom: krait-cc: rewrite driver to use clk_hw instead of clk
  soc: qcom: spm: add support for voltage regulator
  soc: qcom: Add driver for Qualcomm Krait L2 cache scaling
  ARM: dts: qcom: apq8064-asus-nexus7-flo: constraint cpufreq regulators
  ARM: dts: qcom: apq8064-cm-qs600: constraint cpufreq regulators
  ARM: dts: qcom: apq8064-ifc6410: constraint cpufreq regulators
  ARM: dts: qcom: apq8064-sony-xperia-lagan-yuga: constraint cpufreq
    regulators
  ARM: dts: qcom: apq8064: rename SAW nodes to power-manager
  ARM: dts: qcom: apq8064: declare SAW2 regulators
  ARM: dts: qcom: apq8064: add Krait clock controller
  ARM: dts: qcom: apq8064: add L2 cache scaling
  ARM: dts: qcom: apq8064: add simple CPUFreq support
  ARM: dts: qcom: apq8064: enable passive CPU cooling
  ARM: dts: qcom: msm8960: declare SAW2 regulators
  ARM: dts: qcom: apq8084: drop 'regulator' property from SAW2 device
  ARM: dts: qcom: msm8974: drop 'regulator' property from SAW2 device
  ARM: dts: qcom: ipq4019: drop 'regulator' property from SAW2 devices
  ARM: dts: qcom: ipq8064: drop 'regulator' property from SAW2 devices

 .../devicetree/bindings/arm/msm/qcom,saw2.txt |  58 --
 .../bindings/cache/qcom,krait-l2-cache.yaml   |  86 +++
 .../qcom/{qcom,spm.yaml => qcom,saw2.yaml}    |  39 +-
 .../dts/qcom/qcom-apq8064-asus-nexus7-flo.dts |  19 +-
 .../boot/dts/qcom/qcom-apq8064-cm-qs600.dts   |  23 +-
 .../boot/dts/qcom/qcom-apq8064-ifc6410.dts    |  23 +-
 .../qcom-apq8064-sony-xperia-lagan-yuga.dts   |  13 +-
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi      | 670 +++++++++++++++++-
 arch/arm/boot/dts/qcom/qcom-apq8084.dtsi      |   1 -
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi      |   5 -
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi      |   2 -
 arch/arm/boot/dts/qcom/qcom-msm8960.dtsi      |  12 +-
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi      |   1 -
 drivers/clk/qcom/krait-cc.c                   | 141 ++--
 drivers/interconnect/icc-clk.c                |  13 +-
 drivers/soc/qcom/Kconfig                      |   9 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/krait-l2-cache.c             | 160 +++++
 drivers/soc/qcom/spm.c                        | 221 +++++-
 include/dt-bindings/clock/qcom,krait-cc.h     |  15 +
 include/dt-bindings/soc/qcom,krait-l2-cache.h |  12 +
 include/linux/interconnect-clk.h              |   1 +
 include/soc/qcom/spm.h                        |   9 +
 23 files changed, 1357 insertions(+), 177 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
 create mode 100644 Documentation/devicetree/bindings/cache/qcom,krait-l2-cache.yaml
 rename Documentation/devicetree/bindings/soc/qcom/{qcom,spm.yaml => qcom,saw2.yaml} (57%)
 create mode 100644 drivers/soc/qcom/krait-l2-cache.c
 create mode 100644 include/dt-bindings/clock/qcom,krait-cc.h
 create mode 100644 include/dt-bindings/soc/qcom,krait-l2-cache.h

-- 
2.39.2


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F39E744ECD
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jul 2023 19:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjGBRmx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 13:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjGBRmv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 13:42:51 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CD8E5C
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 10:42:50 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b6adef5c22so55946211fa.3
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2023 10:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688319768; x=1690911768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JkkzAIkRDIVyACl+zugSHl5gxRjnA8U0h5oI7gnz5vs=;
        b=ZKgOC7lh+00yrM7+NtV8phxOsljmaCTRnv0fedVtnK/j/59KzQkqBw21YZuz8az2ip
         OTGwGFX2Zt4Fmd4CydGrmG3p+ynBKZ6aCapfbmOd+FhV3mTC4HCmtGT1MyK5DHX/zgkh
         1gAysmXOAHVVmFqcChZkptYNdEc256AjJwRFatz9j5sNNjQ0uOktvBZkygb07/Ah2c2p
         bEEBipQw8WBQMv+gR+aCQm/ISM9Da3//iDdHsGaxo5IGTCuvdwj9MhwMZaPZioYU+FIe
         q1FC/9EqZmitpzQt45cEaDLxfrP3iXqPvP6lavuMO4GHYQgVm4zbqw3o+SuiHugrG71f
         HUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688319768; x=1690911768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JkkzAIkRDIVyACl+zugSHl5gxRjnA8U0h5oI7gnz5vs=;
        b=Fsz/g8wyrZaQ3bKTCJjrxns8v/NKVLZjpxVGX3cB6iWzMOmrEDcfkUQ9ICr7fA+osQ
         Qf0KFn3bsZCOnHnYWzkbYZrNoOOo8AaCB0oUPurMAHWsLNxVbxXy5BoCT2SPFrty7gar
         k2H0t7HRqP3u0xj8GzNbdlvh2TGl/pm/E/nqxUAIuKUNjk8h8432kw9NDfpxi07lfYAU
         FQO2cFDGkYttm5G8DLKww2JADomrTIKi0+yXQf56m+G59IMD8+CUfinC94C8UfBIs/V6
         e2A+0/nfSZf53Oda8w9yb3L8LUOEW+qN5Htweg2jG6LaqSegnTTWDr+X/T87w5qqQah4
         aKNg==
X-Gm-Message-State: ABy/qLZdwyrNJJa+c8MEjNss9ovjqRaZjWyRIVd6QM/XPmjLJZ7KsUJs
        4A+Vi5kltqnKWRQEuzD5IbuQ8w==
X-Google-Smtp-Source: APBJJlFRnl7aRxexcOSq5lYvCRtIrQXOIDTOzdcrEeRkOO9nUn69ZR4F/e1/GsaEZxESoxoQekLOHQ==
X-Received: by 2002:a2e:9b07:0:b0:2b6:9f1e:12c1 with SMTP id u7-20020a2e9b07000000b002b69f1e12c1mr5673723lji.3.1688319768178;
        Sun, 02 Jul 2023 10:42:48 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v23-20020a2e9917000000b002b6daa3fa2csm1372550lji.69.2023.07.02.10.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 10:42:47 -0700 (PDT)
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
Subject: [PATCH v3 00/28] ARM: qcom: apq8064: support CPU frequency scaling
Date:   Sun,  2 Jul 2023 20:42:18 +0300
Message-Id: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
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

Dependencies: [1].

[1] https://lore.kernel.org/linux-arm-msm/20230702134320.98831-1-dmitry.baryshkov@linaro.org/

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

Dmitry Baryshkov (28):
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
 .../bindings/cache/qcom,krait-l2-cache.yaml   |  75 ++
 .../bindings/opp/opp-v2-kryo-cpu.yaml         |  12 +-
 .../qcom/{qcom,spm.yaml => qcom,saw2.yaml}    |  39 +-
 .../dts/qcom/qcom-apq8064-asus-nexus7-flo.dts |  19 +-
 .../boot/dts/qcom/qcom-apq8064-cm-qs600.dts   |  23 +-
 .../boot/dts/qcom/qcom-apq8064-ifc6410.dts    |  23 +-
 .../qcom-apq8064-sony-xperia-lagan-yuga.dts   |  13 +-
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi      | 669 +++++++++++++++++-
 arch/arm/boot/dts/qcom/qcom-apq8084.dtsi      |   1 -
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi      |   5 -
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi      |   2 -
 arch/arm/boot/dts/qcom/qcom-msm8960.dtsi      |  12 +-
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi      |   1 -
 drivers/clk/qcom/krait-cc.c                   | 141 ++--
 drivers/cpufreq/qcom-cpufreq-nvmem.c          |  77 +-
 drivers/interconnect/icc-clk.c                |  13 +-
 drivers/soc/qcom/Kconfig                      |   9 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/krait-l2-cache.c             | 167 +++++
 drivers/soc/qcom/spm.c                        | 205 +++++-
 include/dt-bindings/clock/qcom,krait-cc.h     |  15 +
 include/dt-bindings/soc/qcom,krait-l2-cache.h |  12 +
 include/linux/interconnect-clk.h              |   1 +
 include/soc/qcom/spm.h                        |   9 +
 25 files changed, 1418 insertions(+), 184 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
 create mode 100644 Documentation/devicetree/bindings/cache/qcom,krait-l2-cache.yaml
 rename Documentation/devicetree/bindings/soc/qcom/{qcom,spm.yaml => qcom,saw2.yaml} (57%)
 create mode 100644 drivers/soc/qcom/krait-l2-cache.c
 create mode 100644 include/dt-bindings/clock/qcom,krait-cc.h
 create mode 100644 include/dt-bindings/soc/qcom,krait-l2-cache.h

-- 
2.39.2


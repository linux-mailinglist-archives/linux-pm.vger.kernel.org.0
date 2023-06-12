Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365E472B769
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 07:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjFLFj2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 01:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjFLFj0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 01:39:26 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9685F9B
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 22:39:25 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f629ccb8ebso4418550e87.1
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 22:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686548364; x=1689140364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EHz2Z30tdvTqewGRLECO+NJy+cg3ayTbdySyYZr/5UI=;
        b=t5ZwCfhAOWC8wyPB2ZlDMdiTPngHUZ7nZ67kwnm/Dr2UbttazmKj8zlhUsLQR3Nuwj
         sfgqBP5oTIR9ghn3OnfIeQYlA7lzPDb3uGGdvf4KFY/DKAJFt9d1+ybNNYuMeltV53gp
         GHykpbnZ3mc6xK/YNr54xghuoB4Y12dK444kxCDtSdO2qTus7IpqbPF3DPTKUUvHxJdh
         iVhwWNkFOOCtUAMIoFrBeRIXYovBournrXZWLlhdNg+ocGw4uyRRocNNY/X/B4apQ5N0
         3Pyn4woxc0otUDwXNV6TjAtS19C0NosBSXBykyzUMONyXhvTi8FLYMWbT+8HtmHFCp9Q
         aFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686548364; x=1689140364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EHz2Z30tdvTqewGRLECO+NJy+cg3ayTbdySyYZr/5UI=;
        b=SS5VDdCtw8JnrVmlvTRvDNxwoGqEjN/bLPlTnSzygxwy14rgf+f/NUefjTeBwf73Ja
         IX7FEuYwrtnl3nzK+zfo/sj91vmhDScmz9A2CeanIbX+1U6ddtOWWnYzgQgw50KR6fyf
         iyzMPl5k2dd2pXXmz9A8sjwxvnXVrOQ6zzi4ByNPXbZRR/CvUdsJiTclP5H7Vg8Wz0HD
         AJ7VuNN27uRm5X5VAchDIIVJ5fiYqopV/OZjQCrEmPi0zusOtvMfHg7OKTdJxrEFUn75
         a9L1obzNUab+EinNtRo1oiQzq+zx6Tpjf4Q3qDvNWM8oYxmyw12yicL7jP9i3azd1Lxe
         ly+g==
X-Gm-Message-State: AC+VfDxjmQeZXQ3GfTG2c6rDTL18eEXWd2Poz5TXyO9jjnZ0jf7wbjLL
        HG30YAPJTp7GzXX++gjdr5QA/Q==
X-Google-Smtp-Source: ACHHUZ7TiqLKPzDu6AYEp6emATujNOYmnTZgqrXZO3dHGPkZgxy28WkN209PjWMbBoSf8p81CeYTMA==
X-Received: by 2002:a19:6418:0:b0:4f3:c7f8:d40c with SMTP id y24-20020a196418000000b004f3c7f8d40cmr3325848lfb.29.1686548363705;
        Sun, 11 Jun 2023 22:39:23 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id n6-20020a195506000000b004f38260f196sm1324125lfe.218.2023.06.11.22.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 22:39:22 -0700 (PDT)
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
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 00/18] ARM: qcom: apq8064: support CPU frequency scaling
Date:   Mon, 12 Jun 2023 08:39:04 +0300
Message-Id: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
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

Implement CPUFreq support for one of the oldest supported Qualcomm
platforms, APQ8064. Each core has independent power and frequency
control. Additionally the L2 cache is scaled to follow the CPU
frequencies (failure to do so results in strange semi-random crashes).

Core voltage is controlled through the SAW2 devices, one for each core.
The L2 has two regulators, vdd-mem and vdd-dig.

Depenency: [1] for interconnect-clk implementation

https://lore.kernel.org/linux-arm-msm/20230512001334.2983048-3-dmitry.baryshkov@linaro.org/

Dmitry Baryshkov (18):
  dt-bindings: opp: opp-v2-kryo-cpu: support Qualcomm Krait SoCs
  dt-bindings: soc: qcom: merge qcom,saw2.txt into qcom,spm.yaml
  dt-bindings: soc: qcom: qcom,saw2: define optional regulator node
  dt-bindings: clock: qcom,krait-cc: Krait core clock controller
  clk: qcom: krait-cc: rewrite driver to use clk_hw instead of clk
  clk: qcom: krait-cc: export L2 clock as an interconnect
  soc: qcom: spm: add support for voltage regulator
  cpufreq: qcom-nvmem: also accept operating-points-v2-krait-cpu
  cpufreq: qcom-nvmem: Add support for voltage scaling
  cpufreq: qcom-nvmem: drop pvs_ver for format a fuses
  cpufreq: qcom-nvmem: provide separate configuration data for apq8064
  ARM: dts: qcom: apq8064: rename SAW nodes to power-manager
  ARM: dts: qcom: apq8064: declare SAW2 regulators
  ARM: dts: qcom: apq8064: add simple CPUFreq support
  ARM: dts: qcom: apq8064: provide voltage scaling tables
  ARM: dts: qcom: apq8064: enable passive CPU cooling
  ARM: dts: qcom: apq8064-asus-nexus7-flo: constraint cpufreq regulators
  ARM: dts: qcom: apq8064-ifc6410: constraint cpufreq regulators

 .../devicetree/bindings/arm/msm/qcom,saw2.txt |   58 -
 .../bindings/opp/opp-v2-kryo-cpu.yaml         |   11 +-
 .../qcom/{qcom,spm.yaml => qcom,saw2.yaml}    |   39 +-
 .../boot/dts/qcom-apq8064-asus-nexus7-flo.dts |   14 +-
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts    |   18 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi           | 1247 ++++++++++++++++-
 drivers/clk/qcom/Kconfig                      |    1 +
 drivers/clk/qcom/krait-cc.c                   |  185 +--
 drivers/cpufreq/qcom-cpufreq-nvmem.c          |  164 ++-
 drivers/soc/qcom/spm.c                        |  205 ++-
 include/dt-bindings/clock/qcom,krait-cc.h     |   20 +
 include/soc/qcom/spm.h                        |    9 +
 12 files changed, 1806 insertions(+), 165 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
 rename Documentation/devicetree/bindings/soc/qcom/{qcom,spm.yaml => qcom,saw2.yaml} (58%)
 create mode 100644 include/dt-bindings/clock/qcom,krait-cc.h

-- 
2.39.2


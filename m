Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA076DCBE7
	for <lists+linux-pm@lfdr.de>; Mon, 10 Apr 2023 22:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjDJUAV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Apr 2023 16:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjDJUAU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2023 16:00:20 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BD41FC4
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2023 13:00:17 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a3so769715ljr.11
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2023 13:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681156816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NDUmxVAjrN5Lm56sfIfKZCJ3s39s5f7ghbzYII7MHLU=;
        b=Xwk58mvNOAEThz0tCz/+DvXFoFZThEXonHnTDUVuCl2SOEfphJir0rbYJ25J0Kzr8F
         ok7CndbCSGTngNsYMFoTxUWXRIf4NciNULHL9i4bWgml3sezCiV2QriGMMAjMLwL3n+f
         fXYmE/xSWlxjY2jEzgfgtiLux4f3qpyNcnQkGydeo2Wqhu9n1mtsXkttj+oSGaMpErk/
         nZGFWU20TkCpuvsYwmkwkbY/AobvVW4b90dpjWigh4gk91Bakdat9U6SboVej1W0GnSn
         keTN8QXRB6vnH/qWFWCX0eqfRzhDs4LNpiMxaH/OVmFghZEq6ixTzHwe2600XL+V8Tm2
         32og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681156816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDUmxVAjrN5Lm56sfIfKZCJ3s39s5f7ghbzYII7MHLU=;
        b=aAxMlpHhJKwtRoD/PW4vTm54H28niYzdJ01jXp1I33AODbpZ3sCRw82wG+8gmFJhiH
         Jrl0OJ79nrn/BrSHjThzzTyvPtKsaEn04ZbTd3R50MJIDq5iKcpb44suTRqwTFYg45dh
         hd+VFItsqUvpcUwk8RQ0K0C2Of0DebL+mqWWW17DE9uoVrSSrp3XP88FXdJ0pMpMPSqF
         Z3zJ9WADCtWycy5MMSy3pdQJ2erm571FsTed18FobzULB49mafqpyt5EslZoRRYLNiR7
         MAco1XAI7ys78oSPrSFgF7Diyl84XlrRrDuMeXcyd3jqi73tVLvJ4DX6OHYrgovPtKWl
         ovyw==
X-Gm-Message-State: AAQBX9cOD/j/tJj0CCd4lyrpFhamDu+KK7fM6Di0o9faANZjVQs7QJnI
        PFiLK7aDnVfDHeJ5urLwOxH8Ng==
X-Google-Smtp-Source: AKy350aY8e+m/utQRn0nylzqrQ0eVD9Obve+qoEOy7oznsYS3j1jDYePOZDcdEdNdlEgsYCmt211pA==
X-Received: by 2002:a2e:a268:0:b0:2a0:5a99:65d8 with SMTP id k8-20020a2ea268000000b002a05a9965d8mr3507440ljm.18.1681156815839;
        Mon, 10 Apr 2023 13:00:15 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id z2-20020a2e8e82000000b002a7729eea3dsm973482ljk.88.2023.04.10.13.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 13:00:15 -0700 (PDT)
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
Subject: [PATCH v5 0/4] clk: qcom: msm8996: add support for the CBF clock
Date:   Mon, 10 Apr 2023 23:00:10 +0300
Message-Id: <20230410200014.432418-1-dmitry.baryshkov@linaro.org>
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


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB626588D5
	for <lists+linux-pm@lfdr.de>; Thu, 29 Dec 2022 04:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbiL2DBU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Dec 2022 22:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiL2DBM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2022 22:01:12 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55358F58F
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 19:01:09 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id z26so25912033lfu.8
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 19:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XpTUmYm6EF9aD/wV+nHiudi2Bksj3dPaoBkv/0ueyJk=;
        b=vgvAizZOX1nqsFznn7pdx0vXF/jnDumlnKBbJS/2jEt5LRU46jpz4qL3dGvgsVII4p
         ZvDAAchDAFEsZvobnoCU1M2DvTdgEA+tKYdArv+9TeNcbiWOPkBUtUHoc0BRTdUIJWQ7
         U78/uWj6mGzGPP11flFgmRbIwUw3K3Y5iepV+NOakp9XIAkGfLaeJ/DUWzQpVjDAHfeJ
         fRhvlXI1JKjwQ4pVlS+amJBh+8MgHYQI3p1AYap6KuLSAyCNZOWbaXQPTgnQl2beAhC6
         oO8mFq8pTc8bYmUXBPY4LhDLu0WXV/ksQUtyllSRdTDDrIoc4jyo6hDKGXAjuGUsYsQH
         wJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpTUmYm6EF9aD/wV+nHiudi2Bksj3dPaoBkv/0ueyJk=;
        b=C2r/yI/T/EfYxo+dqf/AQ60nGsWDe7cKAAmPPVeKz2Hxcx8jHFn9+fbUra8S3MWrey
         Plb81Cn0LISPVQ8fG+pjRT2VLJLjv6prfe514hbYnUX3q8Vx7eGbAieO8H0JKbAkEpmV
         5er9VFggco0LB1WktJ0VW0A/pumnDIXrgjxxtn+cZikj+CLIhEtV7CHIPe3/9OVmKHgR
         F7YcCQ5V1g3z/ihcBEcCcv2VrlezT36ENF05r086YADo45GAGvFhgg4m/SxBARWzB6k3
         5zfFFXMccCgFhUPBxUm2MRTGq/gXoWP1uhvIg3qL/Un6ZzH0LbI0IYNbRYcNJhb80CfK
         /Udg==
X-Gm-Message-State: AFqh2kqe2mZjKPxKhwnskjWUYCOm6UIz4RDKUSPUMNcRpzJkxaBr0jhB
        pnfACLgSmIFPIo28nAI5ktNAjQ==
X-Google-Smtp-Source: AMrXdXsLKoC9lhB1y7yWZ3hBVbW2ttsJWiCBioA543ekSvWpX7N5+OZB9i9flFdrSHg3+RG5XMc26Q==
X-Received: by 2002:a05:6512:3f9c:b0:4b6:e4e7:624c with SMTP id x28-20020a0565123f9c00b004b6e4e7624cmr8790249lfa.0.1672282867601;
        Wed, 28 Dec 2022 19:01:07 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b11-20020a056512024b00b004b57277474esm2883070lfo.106.2022.12.28.19.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 19:01:07 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 00/20] thermal/drivers/tsens: specify nvmem cells in DT rather than parsing them manually
Date:   Thu, 29 Dec 2022 05:00:46 +0200
Message-Id: <20221229030106.3303205-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Historically the tsens driver fetches the calibration data as a blob and
then parses the blob on its own. This results in semi-duplicated code
spreading over the platform-specific functions.

This patch series changes tsens calibration code to per-value nvmem
cells rather than parsing the blob in the driver. For backwards
compatibility the old code is left in place for msm8916, msm8974 and
qcs404, the platforms which have in-tree DT files. For all other
affected platforms the old parsing code has been dropped as a part of
this series.

The code was tested on msm8916 and qcs404 only.

Note: the DTs changes depend on driver changes. Tsens driver will not
work if DT patches are merged, but the driver bits are not. As the
thermal sense is critical for device safety, I'kindly ask to have an
immutable branch with the driver changes that can be merged into the
msm-dts tree.

Note2:
I still have included patches to drop legacy support for 8939
(msm8939.dtsi is on the list, patch to convert it to the proposed
bindings is available at [1]) and 8976 (msm8976.dtsi and msm8956.dtsi,
which use single-blob bindings, have been accepted for 6.2, dropping old
bindings support depends on mutual consensuns of platform and thermal
code maintainers). Corresponding patches are the last ones in the
thermal part of the series, thus if they are declined, the reset of the
series still can be applied without any problems.

[1] https://pastebin.ubuntu.com/p/rfkZgy767K/

Changes since v4:
- Changed DT bindings to use HW sensor ids rather than bare indices.
  This follows the usage of hw_ids in thermal-sensors specifications
  (and corresponds to the ID visible in debugfs).
  Previously there was no correspondence, which resulted e.g. in usage
  of s0_p1/s0_p2 for sensor 0, but s4_p1/s4_p2 for the sensor 5 on
  the msm8916 platform).
- Reworked msm8939 code to ignore the sensor10. It is available only on
  latest hw revision, it doesn't seem to be actually used and it also
  wasn't covered by the old single-blob bindings because of the parsing
  error.
- Fixed missing include reported by testing robot.

Changes since v3:
- Added a patch to fix the tsens compatible string on msm8956 SoC,
- Fixed num-sensors and slope coefficients for the msm8939 SoC,
- Rewrote code supporting old bindings into the simple data-driven
  parser common to all legacy platforms which made dropping support for
  old bindings less demanding.

Changes since v2:
- Made init_8956 static, as pointed out by the testing robot and by
  AngeloGioacchino Del Regno.

Changes since the RFC:
- Sorted out the msm8976/msm8956, custom slopes are used only for msm8956,
- Implemented proper support for msm8974/apq8084,
- Added tsens_calibrate_common() and ops_v0_1 which can be used in
  common cases,
- Removed superfluous identity hw_ids
- Fixed calibration calculation in tsens_calibrate_nvmem() for
  ONE_PT_CALIB case

Dmitry Baryshkov (20):
  dt-bindings: thermal: tsens: add msm8956 compat
  dt-bindings: thermal: tsens: support per-sensor calibration cells
  dt-bindings: thermal: tsens: add per-sensor cells for msm8974
  thermal/drivers/tsens: Drop unnecessary hw_ids
  thermal/drivers/tsens: Drop msm8976-specific defines
  thermal/drivers/tsens: Sort out msm8976 vs msm8956 data
  thermal/drivers/tsens: fix slope values for msm8939
  thermal/drivers/tsens: limit num_sensors to 9 for msm8939
  thermal/drivers/tsens: Support using nvmem cells for calibration data
  thermal/drivers/tsens: Support using nvmem cells for msm8974
    calibration
  thermal/drivers/tsens: Rework legacy calibration data parsers
  thermal/drivers/tsens: Drop single-cell code for mdm9607
  thermal/drivers/tsens: Drop single-cell code for msm8939
  thermal/drivers/tsens: Drop single-cell code for msm8976/msm8956
  arm64: dts: qcom: msm8956: use SoC-specific compat for tsens
  arm64: dts: qcom: msm8916: specify per-sensor calibration cells
  arm64: dts: qcom: msm8976: specify per-sensor calibration cells
  arm64: dts: qcom: qcs404: specify per-sensor calibration cells
  ARM: dts: qcom-msm8974: specify per-sensor calibration cells
  ARM: dts: qcom-apq8084: specify per-sensor calibration cells

 .../bindings/thermal/qcom-tsens.yaml          | 154 +++-
 arch/arm/boot/dts/qcom-apq8084.dtsi           | 313 ++++++++-
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 313 ++++++++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  85 ++-
 arch/arm64/boot/dts/qcom/msm8956.dtsi         |   4 +
 arch/arm64/boot/dts/qcom/msm8976.dtsi         | 153 +++-
 arch/arm64/boot/dts/qcom/qcs404.dtsi          | 145 +++-
 drivers/thermal/qcom/tsens-v0_1.c             | 655 +++++-------------
 drivers/thermal/qcom/tsens-v1.c               | 340 +++------
 drivers/thermal/qcom/tsens.c                  | 168 +++++
 drivers/thermal/qcom/tsens.h                  |  46 +-
 11 files changed, 1611 insertions(+), 765 deletions(-)

-- 
2.39.0


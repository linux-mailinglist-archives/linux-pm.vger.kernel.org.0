Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E529652B27
	for <lists+linux-pm@lfdr.de>; Wed, 21 Dec 2022 03:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbiLUCFZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 21:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbiLUCFY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 21:05:24 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D56F1F9F6
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 18:05:23 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id y25so21336733lfa.9
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 18:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ye2HlrNADbsjf7JW/wfENtb0EwVX+8Z6Yq86s7AA2zU=;
        b=f1zR0dmK806mB0fbNtfmm+HRT1uJXoRmUkdQ1r9CXcd35fqzCuERQclZk6ZZ4Dh8Ey
         aRwUxfTQUB4hSIh8eQ+YeDmWIVaF6WXjwr5ZD/03GylPm9ArROEgcqW2Ycth/bEOMXv8
         j3Ilp3gbn2TDunY4S6hldBHBVHWyT4AIpIfkcvr5+KoEVKoj0BqRWYMCYW0UUlqzWSGe
         SWBuIvugQKTZLFN+XR4eiPCjY1qXnpxt2nQxvxT0N/t3TiIETCFPJII2rCgnpYuotH3J
         pwMJSkx+F2SghcW7cx/UPd1RlLkUSVKz72fuEJdyAqBIyp8z5fEihJ8DETOXPm6LkZ4F
         bqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ye2HlrNADbsjf7JW/wfENtb0EwVX+8Z6Yq86s7AA2zU=;
        b=2b7JgOZh8EQ0tZ3tIRiGVY4M6IsIaUcJhYKfLkShsRVVuu5wcBrDGm4fsKpNIPvpb+
         KsylFIhJOdW8vUQPZ5fcbL1d+nLylmbQMWkHIr4lkzE0o9HTGNu1fw1CqHgLq/0SVce9
         dHKqvxB0GUY7PspA+Ouw7vqT2HVdhHGU4nXE4bgnNz95ZsNcDrSNyoCrk7DUt/6/7exM
         rcc2BRNPW1L7lkbqnxk4TyzU7L9VcwT5vk2Y+1q9LXy9dMu2fAuPYNYyYSvO1OK4pvhx
         JUHLE0oYRUXz7xjjbX3FrU1O7GYgf0QaDGQYzXp1CnHzJGvzd1RqAAGXXBHM4CjR8vkP
         Jh5w==
X-Gm-Message-State: AFqh2kpXDWGjILrC5vVtCyT8AI5NVNO+F3egVrmFFt/BrSyu8oQOceY0
        MQ7tsUZq/8yS6tJT892QVcyBnA==
X-Google-Smtp-Source: AMrXdXukAweUK2mGMYCeGVqysfreChjnjE3mfOq+jHkMJh+cmEIImDu2Cn1Ye3nt8Y3v7Mk+0FT/uA==
X-Received: by 2002:a05:6512:22c7:b0:4b5:5de9:aab8 with SMTP id g7-20020a05651222c700b004b55de9aab8mr112910lfu.66.1671588321422;
        Tue, 20 Dec 2022 18:05:21 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id q18-20020a056512211200b004b257fef958sm1673048lfr.94.2022.12.20.18.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 18:05:20 -0800 (PST)
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
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 00/15] thermal/drivers/tsens: specify nvmem cells in DT rather than parsing them manually
Date:   Wed, 21 Dec 2022 04:05:00 +0200
Message-Id: <20221221020520.1326964-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
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
thermal sense is critical for device safety, I'd suggest merging binding
and driver during one merge window and then merging DT changes in the
next merge window.

Note2:
For v3 I have reworked the legacy bindings support into the small and
manageable data-driven piece of code.

I still have included patches to drop legacy support for 8939
(msm8939.dtsi is on the list, I have provided Bryan with the patch to
update it to new bindings) and 8976 (msm8976.dtsi and msm8956.dtsi,
which use single-blob bindings, have been accepted for 6.2, dropping old
bindings support depends on mutual consensuns of platform and thermal
code maintainers). The patches are the last ones in the thermal part of
the series, thus if they are declined, the reset of the series still can
be applied without any problems.

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
  thermal/drivers/tsens: limit num_sensors to 9
  thermal/drivers/tsens: fix slope values for msm8939
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

 .../bindings/thermal/qcom-tsens.yaml          | 123 +++-
 arch/arm/boot/dts/qcom-apq8084.dtsi           | 313 ++++++++-
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 313 ++++++++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  81 ++-
 arch/arm64/boot/dts/qcom/msm8956.dtsi         |   4 +
 arch/arm64/boot/dts/qcom/msm8976.dtsi         | 153 +++-
 arch/arm64/boot/dts/qcom/qcs404.dtsi          | 145 +++-
 drivers/thermal/qcom/tsens-v0_1.c             | 653 +++++-------------
 drivers/thermal/qcom/tsens-v1.c               | 340 +++------
 drivers/thermal/qcom/tsens.c                  | 166 +++++
 drivers/thermal/qcom/tsens.h                  |  46 +-
 11 files changed, 1572 insertions(+), 765 deletions(-)

-- 
2.35.1


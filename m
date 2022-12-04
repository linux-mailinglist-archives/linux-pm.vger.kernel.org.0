Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D950B641ADD
	for <lists+linux-pm@lfdr.de>; Sun,  4 Dec 2022 06:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiLDF7Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Dec 2022 00:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiLDF7O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Dec 2022 00:59:14 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD24E140DC
        for <linux-pm@vger.kernel.org>; Sat,  3 Dec 2022 21:59:12 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id z4so9960738ljq.6
        for <linux-pm@vger.kernel.org>; Sat, 03 Dec 2022 21:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zhINbGmUkR446pTjVDx9epaOw6+W6fX9AeKTKkDRvH0=;
        b=j8b+O9T72R0RPQIslmr9y94FHdZndU+uu1Cdaebc9xn6dU6NqPygMGcGyT+GC/hR8v
         4Oe+9VA91xcAUuDbj/XSVookl/8ch26NLxTblE8net368LIgcDTV4J/jFH0AyN3qn1nX
         0Km971OI2tWuCZJWS4TbVYZ8HJ1psovARKoMB25xK0mLNDWFBDY1WoPv6mFQISAI4wG7
         0BDD4PiMB3KYPyfZ7H/pI08Psqqbt8YeGtdeCpFI1m/L4aweQDjMUwJs33SBmfINwjmr
         nuDpz1tfwO+prgtHQHksdhn4lXRij6m8JH1rMreH+UwgMT22f+zr84vwPfqgkxI9/8pE
         cjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zhINbGmUkR446pTjVDx9epaOw6+W6fX9AeKTKkDRvH0=;
        b=nx6Suezp/OBHYwDikHIB0DLsnmh8TvlNgdy251Lo50X6sYzfCuQL4CEzi3EPcFweMF
         VtAwVEnT4AYeRaHDboyIS2IP0+U1s0AHKwcUWb3GNm0qpZ3gzMLFw+hCzy4lb5EHA7+V
         MxFdkqsjaq/2kiGniRyJKZmrixfgPQl78+q/WLZ7fOOS5GeHmTG7bLp0yIOtDlf4J5p9
         r16LUlIB6dUSyk6yIPYww7xuXg/9Cju9oo+9hnWQjiyzpWqfRgex+h9onWbXvSQ4kc2O
         EbThkWoXB0mVHHDWTaJvAIIalDvIP0SOJgCXwhmzKpglxRcXgZrwO2iY6ng7/aGWxsUG
         K0Ug==
X-Gm-Message-State: ANoB5pkTflOl5j9RutApZgv9trGXCrKebko0k/ACBsy7FwPwJdN46SVY
        GTfitXfUZc0uU0nMDAlJo3k6JQ==
X-Google-Smtp-Source: AA0mqf5A4bw4tbHZFxBQx69OlO2zCAnop58y/4Y3LvtVNo6rZmDYB0YghQmyl5nBuQ7NA1k/UBVb0A==
X-Received: by 2002:a2e:7210:0:b0:279:9c12:1ef3 with SMTP id n16-20020a2e7210000000b002799c121ef3mr11515027ljc.392.1670133551162;
        Sat, 03 Dec 2022 21:59:11 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o6-20020a05651205c600b004917a30c82bsm1650028lfo.153.2022.12.03.21.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 21:59:10 -0800 (PST)
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
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 00/15] thermal/drivers/tsens: specify nvmem cells in DT rather than parsing them manually
Date:   Sun,  4 Dec 2022 07:58:54 +0200
Message-Id: <20221204055909.1351895-1-dmitry.baryshkov@linaro.org>
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

Changes since the RFC:
- Sorted out the msm8976/msm8956, custom slopes are used only for msm8956,
- Implemented proper support for msm8974/apq8084,
- Added tsens_calibrate_common() and ops_v0_1 which can be used in
  common cases,
- Removed superfluous identity hw_ids
- Fixed calibration calculation in tsens_calibrate_nvmem() for
  ONE_PT_CALIB case

Dmitry Baryshkov (15):
  dt-bindings: thermal: tsens: add msm8956 compat
  dt-bindings: thermal: tsens: support per-sensor calibration cells
  dt-bindings: thermal: tsens: add per-sensor cells for msm8974
  thermal/drivers/tsens: Drop unnecessary hw_ids
  thermal/drivers/tsens: Drop msm8976-specific defines
  thermal/drivers/tsens: Sort out msm8976 vs msm8956 data
  thermal/drivers/tsens: Support using nvmem cells for calibration data
  thermal/drivers/tsens: Drop single-cell code for msm8939
  thermal/drivers/tsens: Drop single-cell code for mdm9607
  thermal/drivers/tsens: Drop single-cell code for msm8976/msm8956
  thermal/drivers/tsens: Support using nvmem cells for msm8974
    calibration
  arm64: dts: qcom: msm8916: specify per-sensor calibration cells
  arm64: dts: qcom: qcs404: specify per-sensor calibration cells
  ARM: dts: qcom-msm8974: specify per-sensor calibration cells
  ARM: dts: qcom-apq8084: specify per-sensor calibration cells

 .../bindings/thermal/qcom-tsens.yaml          | 123 +++++++-
 arch/arm/boot/dts/qcom-apq8084.dtsi           | 262 ++++++++++++++++-
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 262 ++++++++++++++++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  70 ++++-
 arch/arm64/boot/dts/qcom/qcs404.dtsi          | 121 +++++++-
 drivers/thermal/qcom/tsens-v0_1.c             | 267 ++++--------------
 drivers/thermal/qcom/tsens-v1.c               | 190 +++----------
 drivers/thermal/qcom/tsens.c                  | 102 +++++++
 drivers/thermal/qcom/tsens.h                  |   8 +-
 9 files changed, 1002 insertions(+), 403 deletions(-)

-- 
2.35.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4976D6518F7
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 03:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiLTCr1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Dec 2022 21:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiLTCrZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2022 21:47:25 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD0C12A95
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 18:47:23 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o6so11705312lfi.5
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 18:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yPglNkkZhT01H6GrqAvdwFSnEAMGUxPAu0Igr5NqcDo=;
        b=aZOFlYEyCwfEuWE45W0/5ZJLVx8/E1nryjycd95yHoX3pBo4RaM8cYJH5VOB9JJ11F
         OF0WKjs3Zlcldrsp9om+mAZqbJWMt8PB8a0vMfdhRB0P9ktG3a7pm3apSNxIbucV2e29
         vmcdw0qRJcUMAww/sEVIlcnDENdj3OD+De/tSsoFsA2LmB4wHXoJqKjCWj3jfn2WyRQP
         Wi37gpITaUvTy+/fypb+CtR4ssBRQvX8He7k3nkVCa3vXceDn5MRIzVxEoE2A4VQdHvA
         z3k6rEkPQBnv62dEMe/nps6lXjktCnOcEXtCiqexGUrLSXnerVxJIYawCf4m9CzQNsJG
         H1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPglNkkZhT01H6GrqAvdwFSnEAMGUxPAu0Igr5NqcDo=;
        b=WElffNVWWrHeq8X5GvJ2YQUmV3mpzTO46qGf/dyDvpAMHUe75wqPo0c8E+voJi2lPu
         ApTFei+nQkzyWNVBp9MKYPhXeYwWUWS9r9w4Y+eMfHFUKRll/BeF0Plzu7jehJ9ZmElS
         VBmidfU48vEcuLdUW5hix+q0eb3wSoeNvssBOVBH4wOiYuGbAVfaYRdL5O2zxGgK7Xws
         B+M0ZtGAJsBuwKhgvQWEW8ikNqGMS7EDL4+hzgeNpYG7rZ7yh8xGUJ73HKWMqz7jv+GQ
         HkCR3ANEJ4TInSwyOnYxNtfHPFpOGBP1sZJOKyZuYAbUiOMbmvn/Ud/1IwrGf/1Pcbry
         6TSg==
X-Gm-Message-State: ANoB5plwr3tZC/rtZdFKeI9Rss6EYRjt1v2L911tiYSjHu832K4OKAuc
        VeGyC5it179Pt7Jos/5oEJjo7Q==
X-Google-Smtp-Source: AA0mqf6LKTD9j5NL7dwSrJbfsDHoU3A2etlOha2F+TQPs4g0dVv2QkURg6vYpCIVxCM8K8GMslt7xw==
X-Received: by 2002:a05:6512:3a82:b0:4b5:580f:2497 with SMTP id q2-20020a0565123a8200b004b5580f2497mr15193868lfu.17.1671504442202;
        Mon, 19 Dec 2022 18:47:22 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id e13-20020a05651236cd00b004b5a85e369asm1274866lfs.252.2022.12.19.18.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 18:47:21 -0800 (PST)
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
Subject: [PATCH v3 00/15] thermal/drivers/tsens: specify nvmem cells in DT rather than parsing them manually
Date:   Tue, 20 Dec 2022 04:47:06 +0200
Message-Id: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
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


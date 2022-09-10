Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C473C5B4644
	for <lists+linux-pm@lfdr.de>; Sat, 10 Sep 2022 14:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiIJMrG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Sep 2022 08:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiIJMrF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Sep 2022 08:47:05 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E28457574
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 05:47:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id o2so5092474lfc.10
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 05:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ygGjW9rzSm7+9sQEq9LAthoAlgsWeQrb6LhBAbELqYs=;
        b=lnoVF8uYyAuPjsc+Zs2852If5yU+bFNZT7OqufJDVKLby3LsmFY6XM+RPWbVNTuc78
         pNPFk05fqBejFctBVL0ulXrSQ26vr3w4JAuMxK1mwpBILYilPC9l+WLb5DXE/xEuErle
         VEMw6avBb6iILCy9URRAsLW8ahr2/2bUs/aEEqji4qnE8QaV9fHr+RAo4x5ID/xJlccR
         UsCIIVPUtyWi0ur2fN7HuuZ6vOAR5Hpf4iuGUWmaF1CWV5YJnJa7ahf+dyJPY0IFz8pA
         ng3S295Nib47SaT44pLxjOlZH0C2mK9gpaU5/hFX1WoYG1hdGRZYFn5Yq+Sw/jofwBoH
         Toxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ygGjW9rzSm7+9sQEq9LAthoAlgsWeQrb6LhBAbELqYs=;
        b=hLaYUV0iCtDiRY4JSqhEYpfHulJgDnUFLUp0Jocb8b0qO+0uk2FrkUxO7Uu9qBnXQq
         hIZnl/oZzdnEKgMw7h6HYOpdy4Xfctq+J8+EI7u3PolSJo8sPx6ZsShuVr1MpgCX/wMy
         uUOC6M9Z3Cj02uOklZ5t7eeXPM7YRGimr0aT5bxYQxO9fRSXmOJgXI2RxiR/G7Oi+cse
         fpHGWnmX23EXnsvSwxYPuPDM1a3sn3jpS0uiscoIWf3jjCZRQYSCUtw5eUFxQM8Bpl+h
         nN308kFB4y0cjW0ZW1y96V+YnTXRIOvbN3dtnUuy8Hs8hJPp8rYldzyGBBPTIzH/AZ2+
         KoAQ==
X-Gm-Message-State: ACgBeo22/Y9bfcd086d31OG17Qb49ncUxW/N2lys2VRVmieyYCK85o4A
        8y5AndRbsLJ6dD8dKvahk6Y+5w==
X-Google-Smtp-Source: AA6agR7LPqrahQNaRb3d6xjgAXgKZkCHZMlYWAHBupsVVGc/p/vsLSIcNu4VsS9cQlgXuDcju6u6Qg==
X-Received: by 2002:a05:6512:1315:b0:492:cbc8:e10d with SMTP id x21-20020a056512131500b00492cbc8e10dmr5713163lfu.41.1662814022845;
        Sat, 10 Sep 2022 05:47:02 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k14-20020a2e920e000000b002677a3ad1d9sm327463ljg.76.2022.09.10.05.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 05:47:02 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RFC PATCH 00/10] thermal/drivers/tsens: specify nvmem cells in DT rather than parsing them manually
Date:   Sat, 10 Sep 2022 15:46:51 +0300
Message-Id: <20220910124701.4060321-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
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

Historically the tsens driver fetches the calibration data as a blob and
then parses the blob on its own. This results in semi-duplicated code
spreading over the platform-specific functions.

This patch series changes tsens calibration code to use pre-parsed nvmem
cells rather than parsing the blob in the driver. For backwards
compatibility the old code is left in place for msm8916 and qcs404, two
platforms which have in-tree DT files. For msm8974 the original function
is left intact, since it differs significantly (and I can not test the
code on msm8974). For all other affected platforms the old parsing code
has been dropped as a part of this RFC.

The code was tested on msm8916 and qcs404 only, thus it is being sent as
an RFC.

Dmitry Baryshkov (10):
  dt-bindings: thermal: tsens: support per-sensor calibration cells
  thermal/drivers/tsens: Support using nvmem cells for calibration data
  thermal/drivers/tsens: drop single-cell code for msm8939
  thermal/drivers/tsens: drop single-cell code for mdm9607
  thermal/drivers/tsens: drop msm8976-specific defines
  thermal/drivers/tsens: use generic calibration routine for msm8976
  thermal/drivers/tsens: use tsens_calibrate_nvmem for msm8976
    calibration
  thermal/drivers/tsens: drop single-cell code for msm8976
  arm64: dts: qcom: msm8916: specify per-sensor calibration cells
  arm64: dts: qcom: qcs404: specify per-sensor calibration cells

 .../bindings/thermal/qcom-tsens.yaml          |  64 +++++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  70 +++++-
 arch/arm64/boot/dts/qcom/qcs404.dtsi          | 120 +++++++++-
 drivers/thermal/qcom/tsens-v0_1.c             | 208 +-----------------
 drivers/thermal/qcom/tsens-v1.c               | 154 +------------
 drivers/thermal/qcom/tsens.c                  |  62 ++++++
 drivers/thermal/qcom/tsens.h                  |   4 +
 7 files changed, 314 insertions(+), 368 deletions(-)

-- 
2.35.1


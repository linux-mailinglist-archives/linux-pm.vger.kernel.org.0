Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B6C5B56B2
	for <lists+linux-pm@lfdr.de>; Mon, 12 Sep 2022 10:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiILIvh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Sep 2022 04:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiILIvd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Sep 2022 04:51:33 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA39B31DF0
        for <linux-pm@vger.kernel.org>; Mon, 12 Sep 2022 01:51:19 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q3so7319426pjg.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Sep 2022 01:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1zMGL2ixE5LCd3AUjYaIWCURF27Vc3NSedrdWveqpGY=;
        b=qnAbeKHHWAua2FsRSh5RVQENB1C4wsQrjYQWC7NzJX+M+0WBiPN8Cxec2do/GI9Z6W
         ZwycFxYmafyghC3hCkhfF/79Wop9M8T+AYG6Wn1cap6YTzstNYG+qvgS3dt+TlaIuV1n
         z3MulZIHLKxxw5pZroXHhC5pcevaSZEtUyT5ATEWkErvg/0N2V4Sry1tFYmKOZ+rOpL/
         sUOCaZI873v4QOlbkDx/BOXCT+0783QGx7Qgl/4JcBoo5p8HLNh1P0BPdA4GHWVr0SOp
         tuMg5Ru8qY1GIUeI4Ky28Pwu4KZlq0lbGz3Cpnhz8Kqee20s8arx/qDCzkg1FMwOhRGK
         suWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1zMGL2ixE5LCd3AUjYaIWCURF27Vc3NSedrdWveqpGY=;
        b=0EHlJeR5toybAh5cPW5ZYXQNlaVlYS6cajU22Fg/Quv3KLhwEhXr7DnnbE1e/sRxZW
         ypu4FGn6L7G8VICXO1H2uhG4OPnQtfkjsB7gpdStYJjytVXbDet/sPSY56crhzimToCn
         6l7nv0lwPllYJ0rmjAidTbuya35DXYJy+MrFEn+3ZFMlC1/N3BdX+I3mplnLboMVx8Jz
         nZtk5DNVFpwCs/KbCvJNYS9Zmj/GtqY/BbdcxpWtHIyeYpENF9hIQx5mbhT69OUfUvc2
         LN7oLmQFPumW1ZFTCkhqz3fUMiTQ4DiWdUOTqxgrO1jz9Y27gMIWqzkVrElB0Bab6nAQ
         E2PA==
X-Gm-Message-State: ACgBeo01YMaEkKa4g0qQDhIaRsUlet6658gpw7n4QhHxCft39cf6nRGt
        ogE6dPaacBhzo3aKPUKMjbg6gw==
X-Google-Smtp-Source: AA6agR6mlldSXRGSuFIIPQLCfI9vWIkSiikHuzlG+pdLOGRiBOae8WbmAOExsu92OXfTerNcph4Dtw==
X-Received: by 2002:a17:902:d4ce:b0:178:1e39:3218 with SMTP id o14-20020a170902d4ce00b001781e393218mr9689845plg.144.1662972679148;
        Mon, 12 Sep 2022 01:51:19 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:5362:9d7f:2354:1d0a:78e3])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f54d00b00172897952a0sm5326699plf.283.2022.09.12.01.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 01:51:18 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh@kernel.org, andersson@kernel.org,
        rafael@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com
Subject: [PATCH 4/4] MAINTAINERS: Add entry for Qualcomm Cooling Driver
Date:   Mon, 12 Sep 2022 14:20:49 +0530
Message-Id: <20220912085049.3517140-5-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220912085049.3517140-1-bhupesh.sharma@linaro.org>
References: <20220912085049.3517140-1-bhupesh.sharma@linaro.org>
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

Add myself as the maintainer for the Qualcomm Cooling
driver (aka Qualcomm Thermal Mitigation Device Driver).

Cc: andersson@kernel.org
Cc: daniel.lezcano@linaro.org
Cc: rafael@kernel.org
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4dbf82d3b775..20f90089bf10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17048,6 +17048,16 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
 F:	drivers/mtd/nand/raw/qcom_nandc.c
 
+QUALCOMM QMI COOLING DRIVER (THERMAL MITIGATION DEVICE DRIVER)
+M:	Bhupesh Sharma <bhupesh.sharma@linaro.org>
+L:	linux-pm@vger.kernel.org
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/qcom,qmi-tmd-device.yaml
+F:	Documentation/devicetree/bindings/thermal/qcom,tmd-device.yaml
+F:	drivers/thermal/qcom/qmi_cooling/
+F:	include/dt-bindings/thermal/qcom,tmd.h
+
 QUALCOMM RMNET DRIVER
 M:	Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
 M:	Sean Tranchetti <quic_stranche@quicinc.com>
-- 
2.37.1


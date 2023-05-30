Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A122C715B5C
	for <lists+linux-pm@lfdr.de>; Tue, 30 May 2023 12:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjE3KUK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 May 2023 06:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjE3KUI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 May 2023 06:20:08 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC29F90
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 03:20:06 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f3bb395e69so4838872e87.2
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 03:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685442005; x=1688034005;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=77NLmH6v9od1ob++a2CgJj2yTxYlz4uZEBXOcINbeNo=;
        b=Cjbv3XEBkFdWGxRKo0MN/14XiXVsgf+CzADHLnjJwDf/UM9HKIs3ds1Y/fs1zt4+2X
         5AaP+VpQNjMybkr8eTtyItX5KI5KvUAVO3gXYCAbf4sqEEtMXhMCl5Qg0LOCQGHKS7Dy
         830vDqJ/SUgcU0VfIKk73DswdYl3D9+s2e2xVUue3SUMqQ5WDT+v+3ndrYK2ZqyRXg0X
         jdox2DbQrieOR2RfLuEu1ToxwPBIq/ty6N1+yYLVkWc+dKrQftd324QmVe98P0rwx0M0
         7nGw5Aoo9bjufNJjEzrLjVsIszFRMZoNZtz1XRYypOLLLqYGYrgoDHpOgqobhFFSOXlK
         Pq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685442005; x=1688034005;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77NLmH6v9od1ob++a2CgJj2yTxYlz4uZEBXOcINbeNo=;
        b=Iu2FWyJUInRVMXJZDVe7y4+rHkwUHBMEx+qJBaJtT/XmExHynzLFbY7gC3Cv1XpIWX
         Qkgzg8d/9v0hkO6D/Y7t4fYmNtlMrofOUQcbOICB02KrSoVYGSfAatWKh0WVxt3f0CIx
         SVS/ocNLDmf9mCVdsWu6QLLAgOKutx8Dt4dxSoYHrcCyayIbr0pMmYvJeM5dxb6sHrm1
         PyKst5zIlUQIcIUlJAc+pgTiLr5BveGLMkP7uJQgFSxtbCEcLMayjfEQMDx0lSvgEB35
         Il5n9zJUC/80qpqCiyFXD9YVlo1EQPNMa/DgU0SF8PkSiU9qiU1t/k6gBMlvL/41kmwa
         nIAQ==
X-Gm-Message-State: AC+VfDypPCI8J2WX+GFjF6MtPfiOde4RgAEt8DjAO3h8KP4xJX64tLr6
        qc2ZdNBaUMEAKroVS2OkihMQAA==
X-Google-Smtp-Source: ACHHUZ6/xo/OLZMXuevUu4Bt6wyyig1dVMyfyogbTcj0tGcewRL1b9WzTu3NPWilGXORO4klfTL1DA==
X-Received: by 2002:a19:f502:0:b0:4f1:3ca4:926f with SMTP id j2-20020a19f502000000b004f13ca4926fmr542221lfb.21.1685442005001;
        Tue, 30 May 2023 03:20:05 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c25-20020ac24159000000b004cc8196a308sm290902lfi.98.2023.05.30.03.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:20:04 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 12:20:00 +0200
Subject: [PATCH 01/20] soc: qcom: smd-rpm: Add QCOM_SMD_RPM_STATE_NUM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v1-1-1bf8e6663c4e@linaro.org>
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685442001; l=832;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=4N6lbOSoAygpQXj0UMs5Vps30KIKUCiMTFGnd+cpG9Q=;
 b=Apzq1+DyQ99gBM5pYzms5dwSiiuvW/23Rvc3hwmN3t9CEO+k4c8sJkLtc6ORu+84mOo5C7tlb
 bHCmQn3jOssC4SBuA9g3chvH/9VTnnMjWigFcmCvoClH1/3zLpvILMf
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a preprocessor define to indicate the number of RPM contexts/states.
While at it, use tabs instead of spaces for the existing entries.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 include/linux/soc/qcom/smd-rpm.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/soc/qcom/smd-rpm.h b/include/linux/soc/qcom/smd-rpm.h
index 2990f425fdef..99499e4b080e 100644
--- a/include/linux/soc/qcom/smd-rpm.h
+++ b/include/linux/soc/qcom/smd-rpm.h
@@ -4,8 +4,9 @@
 
 struct qcom_smd_rpm;
 
-#define QCOM_SMD_RPM_ACTIVE_STATE        0
-#define QCOM_SMD_RPM_SLEEP_STATE         1
+#define QCOM_SMD_RPM_ACTIVE_STATE	0
+#define QCOM_SMD_RPM_SLEEP_STATE	1
+#define QCOM_SMD_RPM_STATE_NUM		2
 
 /*
  * Constants used for addressing resources in the RPM.

-- 
2.40.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBBB72A44E
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jun 2023 22:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjFIUTW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jun 2023 16:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjFIUTU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jun 2023 16:19:20 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AED30E4
        for <linux-pm@vger.kernel.org>; Fri,  9 Jun 2023 13:19:18 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f63a2e1c5fso2823136e87.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Jun 2023 13:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686341956; x=1688933956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ak6pJEE70i86/FySUfYrSS2au3HzGmo13oLp85+Of0E=;
        b=ZYAUnt1h3zm6yQuJF1O1u6Ig6wC9ql4ygP9qXxGbilJuXcPAy7cdmCLtw+cUDcWIm0
         JmO2qITOniwgUYE3FpWPyL4a99luPb1TJ5FLn4CFYSanbrVXwmwidcberK6Ggsz6TCkL
         OrqtkGm7zVtBjrsaKY2i5UCmXrzRTU1TYxxCOWc6/CQWKch6S43Kirk93vdie2FiT7c5
         FuwPgm1WB9vL0+o+Y27wdqheOrTOlfR8UOZ9zSgAMsEu1J3PMAN+/modElOHSoARjMLH
         ZDkvuRZWwOvA8vFlVuM6u543GS4xoy2NPiE8buYk+H1i3vLawb7r//P2wbQA9YqqiNzd
         RuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686341956; x=1688933956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ak6pJEE70i86/FySUfYrSS2au3HzGmo13oLp85+Of0E=;
        b=C1TjoDn+yOziZR2XsFFgo5UHMdUu4TqxjxFcg0Fe1DLrX/ach2fRJU/3GzRtJvPb+R
         CsR7dJ0Du3NUIHGAJhAzQ/8BxoiiumeZRw2+sIFNOYVE6UfvEKPTSTjX6slMMAhwKUU2
         IWCERTI6f0ZPnm2fBQ5b9IqDzW2ZqmBM0/LPwmWDVLh6xNjL/ip7uOwTcuTK5TItst57
         F43PF9+rr2lno7FOD6EPxFMfycmjo1zHUTpGQ64bzXYIzrz/9Qjy4rPPLgpOVc4EOvAA
         h7tJKyRCr+iyao04RkeZyqKRfLrek4Lupf85OPhyEr1h7JXCPLlz9WANxyUllBGRV517
         8xMg==
X-Gm-Message-State: AC+VfDyeHkIZKeLMkkH6Ew9fVNnZ2Q8LHFq+cVoGNfvTxHvn6q11DmqX
        nO/569bRIx9azORP2Pya128rVHknW/qIekDvxNs=
X-Google-Smtp-Source: ACHHUZ4icgfvQyEhtHTf+n5uX0D49UtWc7i4nRks7NKaUET/j87fPt7+8h9IwPHPZ8DTEaVr850e1Q==
X-Received: by 2002:a19:8c14:0:b0:4f6:4fcb:6e9a with SMTP id o20-20020a198c14000000b004f64fcb6e9amr1401776lfd.12.1686341956535;
        Fri, 09 Jun 2023 13:19:16 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id b18-20020ac25632000000b004f628eb7884sm641349lff.232.2023.06.09.13.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:19:16 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 09 Jun 2023 22:19:06 +0200
Subject: [PATCH v2 01/22] soc: qcom: smd-rpm: Add QCOM_SMD_RPM_STATE_NUM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v2-1-e5934b07d813@linaro.org>
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686341953; l=664;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=XHE1WQYZzaLo+c3xD4ALM/GRb1VwY7GuxNqpdL0mBnk=;
 b=6RgsfDZ2UAsQB1GY/otsgs26Hc6coYtp4QVzrinbpw/gqd+d3IaH7aJ+z1h5QDVrTQC029lTU
 s6o+aHaRz+rBf6F8PbEP+PDGhbi82dgfHUMyjp98eDrrWChbNTFtqUy
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

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 include/linux/soc/qcom/smd-rpm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/soc/qcom/smd-rpm.h b/include/linux/soc/qcom/smd-rpm.h
index 2990f425fdef..e468f94fa323 100644
--- a/include/linux/soc/qcom/smd-rpm.h
+++ b/include/linux/soc/qcom/smd-rpm.h
@@ -6,6 +6,7 @@ struct qcom_smd_rpm;
 
 #define QCOM_SMD_RPM_ACTIVE_STATE        0
 #define QCOM_SMD_RPM_SLEEP_STATE         1
+#define QCOM_SMD_RPM_STATE_NUM		2
 
 /*
  * Constants used for addressing resources in the RPM.

-- 
2.41.0


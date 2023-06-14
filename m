Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DB072FA53
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jun 2023 12:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243246AbjFNKW0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jun 2023 06:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbjFNKWZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jun 2023 06:22:25 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D869F1BF0
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 03:22:21 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b1b66a8fd5so6789301fa.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 03:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686738140; x=1689330140;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ak6pJEE70i86/FySUfYrSS2au3HzGmo13oLp85+Of0E=;
        b=e5DN8MmVuOUVJKrecInLvzge7vnLUVfPnUv2qoy9gy7Y43omkyW0ZLgoqB3IVkmNYC
         0oP8VZmI/777Qse3/LxtFRfHg5uOVydt+omq5lLpq4xbgLMgi6Xci9ZFr+rgmmwyxxPg
         rBnApm+qLJZzhwU6bsIg8WwUQLPGUKOgAY8LUsuCq/ENbN5tOvDP2W8VR/4oXoieW5L4
         pAQkZ7lOmuaGjmz0ANCr8Z0g2fzO4cBdOAGyjdEwVw+xbJJEylLboXlieG4u9fmVWhoX
         qQD2WT6+doAMu5g/aasnnVy6GW4x0iyn3EW+vXeZGiavD0NB26uu4WrJtqfEWSgcr6Xt
         oUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686738140; x=1689330140;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ak6pJEE70i86/FySUfYrSS2au3HzGmo13oLp85+Of0E=;
        b=BfpRI+8AG9aa+5GksEbmr/Whbojj9l3ZFx2P1u+X3qqWEkedO1SYujwlOf1f9BtYBe
         YW9kp3s2oYjnE9sIXvLLf8D5pvXOV4yOxkmBL1UN4wM0Ij4Pt0Brrvw3kRGBMAS8CG4z
         oEBg/kCKUTADUwHXOJUFYwKHVMn5hH8dcLzb7hxHk2LOpaCh6tGVULvSBxlGuM7IzLow
         f/d0svSZVAt5W2XC7wO9NfNsl+P7u6mpu8VrrfPF+/NU/EPMZQDC/eZkd49LqCXYNSzd
         PnZpi8Op4dtkX7zCYyOhOuXkyjwwNiVfWExY5bUD7+MicU907bucuvp4I7i4yn0lwoLT
         YXlA==
X-Gm-Message-State: AC+VfDzmy+WxvjobJfnIfPLjuC3Xhvg2H1RD/oH8wuMi8ynlNp/uUolu
        OKpXyns5RRvcxCIxGz4yjmAQnQ==
X-Google-Smtp-Source: ACHHUZ5lmTu/9NRhwNJEGFH7nnpYNEhBSsDSJp3FrLVJyvwX31wx8PrD+NWh0X7JxLrq3Ws3PoQhxw==
X-Received: by 2002:a2e:910e:0:b0:2a8:bd1f:a377 with SMTP id m14-20020a2e910e000000b002a8bd1fa377mr6578613ljg.20.1686738139839;
        Wed, 14 Jun 2023 03:22:19 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id m2-20020a2eb6c2000000b002b20d8f270asm2520057ljo.74.2023.06.14.03.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 03:22:19 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 12:22:13 +0200
Subject: [PATCH v5 02/22] soc: qcom: smd-rpm: Add QCOM_SMD_RPM_STATE_NUM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v5-2-eeaa09d0082e@linaro.org>
References: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686738135; l=664;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=XHE1WQYZzaLo+c3xD4ALM/GRb1VwY7GuxNqpdL0mBnk=;
 b=Z8yBghNNMxMn+9eINX7qwCSmxht2X+X3SgW1EzzINyO8TFr4knjBpbMfDx/1zQ+Dwdr4u7hVi
 ErEdbmhvwVhCmO/6uGnbLZ2tTSsN1Fsus1YUnk7PWNJP7twlVwuhft8
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


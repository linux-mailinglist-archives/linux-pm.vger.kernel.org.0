Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AF2778E4B
	for <lists+linux-pm@lfdr.de>; Fri, 11 Aug 2023 13:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbjHKLza (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Aug 2023 07:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjHKLzZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2023 07:55:25 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D6711F
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 04:55:24 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe700f9bf7so3066630e87.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 04:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691754923; x=1692359723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ch1MMPzXxt2ZLlG7nltXMcHjVLEaj7rMyA9/R+Q9Z3Y=;
        b=oeoNxyzUCf/7wTNdJY6f32WjV37AuuwyBZga1pT/Vxsyaq7xfywmkt9c59bHuAf6hE
         nvDCDMSIbVhuTykuD24U0eXWxmHvkSQ/GCgaM9q5vz9gX7MaE6/Y9CgB5cgTyx5USUmM
         d54N90N1LVZnrVnUPmlWeH52bp8QU+LXy1GPEHV+p07/F/4mkwc7uUp6lUwKSG9Ivps7
         9OUk6s30Y55GTUmWqKTmfKi2Sf3UGGOUT7jH9dwgGGlES2Nc5posp4ZQ1poNWeIzp58V
         Rw/eunQPHMaXzpf9MUXpP5pdFAg/noTjajEOYWhQYKGk7b6Hiw90keq4TVdK3eBwJthC
         mxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691754923; x=1692359723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ch1MMPzXxt2ZLlG7nltXMcHjVLEaj7rMyA9/R+Q9Z3Y=;
        b=dW/K4vQZHMUDCrwL7NG33GSOC8DwSe6ZZ8e+sB4Fcya0mrMtBHQ2zpn/iEbXZGsNF1
         r9gLSGnRSqz7qlAP74/9EOIkKGE1+Oj475LErZZMYU1qNsPDbsizLA5qA0Ry0RCFoNXd
         XtBOuofg9qMRddYf8Z/KeP0bg/0uajAEfz5Z3DT+jqB9Ab1E2QA6JXhRP9rCelovzKDu
         44YfY1bFxqGP+ZOpJMFxCNRq0+Cs1McKnK00qCfMxRhYulBB2TuLyrGfVLKfHjQJKgV4
         GSgC8YUPuZekzgpbKYIYpafNUzMOlndq9dkF76TiEwD1OkEeQySyoreBUEhUNu0VzKQB
         nuSA==
X-Gm-Message-State: AOJu0YzvjuzPpWAzV6dGHmYG4xv6R1d8G2paJFX5u9qy0TH2XB4kaKLZ
        YyrFX+LXsl8qycTBXAVlbNE6zw==
X-Google-Smtp-Source: AGHT+IGWAiMNIiztaw+MSdWe2bowZ2pGCFgH/LkYVAzY8FUXhxigTgDv5wnxvaZ2/jT3M8aUTATP8w==
X-Received: by 2002:a05:6512:1154:b0:4f8:5885:61e with SMTP id m20-20020a056512115400b004f85885061emr1303842lfg.40.1691754923165;
        Fri, 11 Aug 2023 04:55:23 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id b17-20020ac25631000000b004fe4a4c61f0sm691729lff.191.2023.08.11.04.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 04:55:22 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 13:55:08 +0200
Subject: [PATCH 2/2] interconnect: qcom: bcm-voter: Use enable_maks for
 keepalive voting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-icc_fix_1he-v1-2-5c96ccef3399@linaro.org>
References: <20230811-topic-icc_fix_1he-v1-0-5c96ccef3399@linaro.org>
In-Reply-To: <20230811-topic-icc_fix_1he-v1-0-5c96ccef3399@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Mike Tipton <mdtipton@codeaurora.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691754919; l=1365;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ooKoWDrIZBGoRmYbzBT936ZVDY0VC6/O2RuTPuEpqXc=;
 b=tWCHfvHPwWdJ+l7tj7scfETlbh3LpPB3jM6S4mCR0aIO+zrEmhfuWOqfuwneYYhij6dzsCNvi
 Cy/1avBW7rKA2app07sfTr621oIoFoYrJIqh+oReAI5Z/rxilUUBNQM
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

BCMs with an enable_mask expect to only have that specific value written
to them. The current implementation only works by miracle for BCMs with
enable mask == BIT(0), as the minimal vote we've been using so far just
so happens to be equal to that.

Use the correct value with keepalive voting.

Fixes: d8630f050d3f ("interconnect: qcom: Add support for mask-based BCMs")
Reported-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/bcm-voter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index 82433f35717f..a28b87eec3da 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -78,10 +78,10 @@ static void bcm_aggregate_1he(struct qcom_icc_bcm *bcm)
 	}
 
 	if (bcm->keepalive) {
-		bcm->vote_x[QCOM_ICC_BUCKET_AMC] = 1;
-		bcm->vote_x[QCOM_ICC_BUCKET_WAKE] = 1;
-		bcm->vote_y[QCOM_ICC_BUCKET_AMC] = 1;
-		bcm->vote_y[QCOM_ICC_BUCKET_WAKE] = 1;
+		bcm->vote_x[QCOM_ICC_BUCKET_AMC] = bcm->enable_mask;
+		bcm->vote_x[QCOM_ICC_BUCKET_WAKE] = bcm->enable_mask;
+		bcm->vote_y[QCOM_ICC_BUCKET_AMC] = bcm->enable_mask;
+		bcm->vote_y[QCOM_ICC_BUCKET_WAKE] = bcm->enable_mask;
 	}
 }
 

-- 
2.41.0


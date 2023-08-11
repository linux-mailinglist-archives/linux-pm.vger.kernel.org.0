Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9617F779B23
	for <lists+linux-pm@lfdr.de>; Sat, 12 Aug 2023 01:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbjHKXVB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Aug 2023 19:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbjHKXVA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2023 19:21:00 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558E810FB
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 16:20:53 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so37753751fa.2
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 16:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691796051; x=1692400851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bm04O8HGohsVWQfFHabLYEe7SK0HV3BXVI84Y7kQs8=;
        b=oLoUDokFtwiZIzp7EmpNQrQugGfEuBvpuz+30kxRkqyHldbdvwkzdi8IUcSQKmY1AW
         Tj/lV62e7mXYmQn+4NbVI3kUnkdMMM2HbWeWxH2QDFzjjDcYnMgJB3y2r3gpLUfRKclf
         P3Dd01qviGx39yRC6HPSz2PD2PQ606MjJEyJg/ggKRJPIXf0PP46wnxWRTsTQbFYZwQR
         uabXkT2MiKGmj58t92L4sXuXpra7Hz3lWKj0DbrSjHwE4ipIwojOYPPmJICgnA4kP03G
         WaApr2cDtjm9x6dfCpbUCnjueaEL6Fc99C1uFq7A0UGSNm801KUotb71bRLzsIMulSqE
         yiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691796051; x=1692400851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bm04O8HGohsVWQfFHabLYEe7SK0HV3BXVI84Y7kQs8=;
        b=RXR7a3DxuEzpcM6Sj8HMHmDOB2X6MxK32S0WEeyyTBuRdvYRb42Mk1h/XZmWEHXUHP
         eNog4SCbtHde3PIZRHej2pdPqgZ4n+h8OGmZEbr24hF2WVvuJ2CibAUT9ZiSYXrCg1mN
         3S/DT+BmayiY2YX7v8eXErkii63r7YzphbrnDbIkzDdwX+41cYJKFdpk0Po+CQg2xadg
         YoYnNxhL/i5Suii2k+TcaeN+PCxzpFRrN+VIkHssnE9ssWpbMqyA70csKuCE8Xj2UPcK
         ZgW6Gh2G9974F3tHEhjsTw1N+fJgD5kwkqX5gAP4gPBgfhj5HTVKFz0pVA29ua1y4XtQ
         atFA==
X-Gm-Message-State: AOJu0Yzx+0mcY/0eYgGCeGgoUYzRVErxFndf/Mf46k99hpWwVNVPimR4
        LOWhYYhV2sx3Af3+k37Uh+Yirg==
X-Google-Smtp-Source: AGHT+IFtzPPJulz5/lJQcPq27385O9fjsEt3lfXOXeegufV7nzzZnqx91ItAsx/MWxm0LAPtBcMOvA==
X-Received: by 2002:a2e:9b98:0:b0:2b9:d79e:7d45 with SMTP id z24-20020a2e9b98000000b002b9d79e7d45mr2390390lji.50.1691796051589;
        Fri, 11 Aug 2023 16:20:51 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id z26-20020a2e965a000000b002b9ea00a7bbsm1038210ljh.60.2023.08.11.16.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 16:20:51 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 12 Aug 2023 01:20:45 +0200
Subject: [PATCH v2 02/11] interconnect: qcom: sc7180: Set ACV enable_mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-acv-v2-2-765ad70e539a@linaro.org>
References: <20230811-topic-acv-v2-0-765ad70e539a@linaro.org>
In-Reply-To: <20230811-topic-acv-v2-0-765ad70e539a@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Richard Acayan <mailingradian@gmail.com>,
        David Dai <daidavid1@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691796047; l=746;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1DGevw8oW4G960bkbopVLrn2cUmgSxfqPpEigmUPG14=;
 b=CJS8vWbRGuyq2+VIpVZ+N/g2K8irhOBZkBOSmtw+0DjgiGr3VeNchEAmWAooZCzeRa//1pTsa
 9HK1XXxRRodChpgc9CrIJFP2VHrY0xBKzkHldWhcCnEG9m1Y/x0cmZr
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

ACV expects an enable_mask corresponding to the APPS RSC, fill it in.

Fixes: 2d1f95ab9feb ("interconnect: qcom: Add SC7180 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sc7180.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
index d94ab9b39f3d..af2be1543840 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -1238,6 +1238,7 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = BIT(3),
 	.keepalive = false,
 	.num_nodes = 1,
 	.nodes = { &ebi },

-- 
2.41.0


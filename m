Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB04C779B34
	for <lists+linux-pm@lfdr.de>; Sat, 12 Aug 2023 01:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbjHKXVQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Aug 2023 19:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbjHKXVN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2023 19:21:13 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CAB26B6
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 16:21:05 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9bf52cd08so36939311fa.2
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 16:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691796063; x=1692400863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJbJgHOsOl3y6/PnruZk8bDmlStCRS+JefvrJckMqJU=;
        b=BfwsYmkiL0VSqqQPnqx3Bf+JKBQ/3NV3TEbO/FM+nASXc63ekSn/hQ6eNnRN2p2dgo
         Nmj/NuFxOjB0+Tg13KwXtiKZ1kuVY4P2JQ8c1loFAfgFexf9xlGaT7g3uSTtAqSTjAcC
         vjUYc+UBYxWSCPa05xrH3UAOQQHMHIysaJaW94UBsiVGJPQAtfn4SN9awp0pVhBj6gup
         poirmAUv02Ze8wmA5qniJezkV1CqtQ7EgxEQthvY79NICiRLgGfYpJkZXpnncZ8Cks9W
         452reDUbbV2WyjMTEzAaiRpy2U3KSGEgjziH0yTVyvXeEdnnJHOdaMnCa8jGE3x9CTzK
         BFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691796063; x=1692400863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJbJgHOsOl3y6/PnruZk8bDmlStCRS+JefvrJckMqJU=;
        b=BnJWERRaxG/s9l/afLbA0iWO7k/aFIaGKFdevmEvIjBWG2S3qT7eZFnYVS/VJYa0Ql
         zaaF3lu9XzfmXqu8wDmsif0ysfW8VFUmSxs11Ft0SNRF/LHAAu9k05YXGBtoLSNvs6HM
         ZF4gIrq7ZZAptiSOla83/SaeWiXAfttJPL+ctWLBlff5+E4Qbvv3nHzdZ5yaCsfk5LAR
         54V4yP+m8braUGRLSS/HwJQvel3btN4gRs8w37VTL/RFK+CZEttYpRIsiXSZvpMg99Tz
         QVPfKor4wXbmd/CA6l5q7YxlPU9JcsPn8plsieRJCBoveoLcfxIxg10onU6GgzZS09VV
         OGxQ==
X-Gm-Message-State: AOJu0YydDLfRgOsaLzXYQunyokG+DK0a+9mYvkqciVZR6KAatWGTwaK7
        fNqIPUD4HFboD+B+pGn/EsqBqA==
X-Google-Smtp-Source: AGHT+IHk5rv1jMgq6DNGkUQqY46SOO3TH9GHGCgYqLVi5qSucPkVQcUDjimd8/yORnaBj47y6WcX1A==
X-Received: by 2002:a2e:99d2:0:b0:2b6:a5df:c7fb with SMTP id l18-20020a2e99d2000000b002b6a5dfc7fbmr2529542ljj.26.1691796063679;
        Fri, 11 Aug 2023 16:21:03 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id z26-20020a2e965a000000b002b9ea00a7bbsm1038210ljh.60.2023.08.11.16.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 16:21:03 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 12 Aug 2023 01:20:53 +0200
Subject: [PATCH v2 10/11] interconnect: qcom: sm8250: Set ACV enable_mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-acv-v2-10-765ad70e539a@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691796047; l=747;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Da9X7kVpSMCeo35M9s3gZyEHupV0CrnVzHsvUI2Bgjo=;
 b=pQccsMYqRFaca7IVVVY246BLhbccHV1GXyO8QxOVYYaAtodhfy9zg1IQIz9S8ClOPUqU5HcVQ
 6BTRe4PpTMWA81zN0qf6RDsmoufT45XS1PzzX/Dcujw4TrKm58HUnqk
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

ACV expects an enable_mask corresponding to the APPS RSC, fill it in.

Fixes: 6df5b349491e ("interconnect: qcom: Add SM8250 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sm8250.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
index d4a4ecef11f0..661dc18d99db 100644
--- a/drivers/interconnect/qcom/sm8250.c
+++ b/drivers/interconnect/qcom/sm8250.c
@@ -1397,6 +1397,7 @@ static struct qcom_icc_node qup2_core_slave = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = BIT(3),
 	.keepalive = false,
 	.num_nodes = 1,
 	.nodes = { &ebi },

-- 
2.41.0


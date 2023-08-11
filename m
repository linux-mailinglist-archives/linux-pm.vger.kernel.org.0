Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD524779037
	for <lists+linux-pm@lfdr.de>; Fri, 11 Aug 2023 15:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbjHKNFG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Aug 2023 09:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbjHKNEx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2023 09:04:53 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF1930F3
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 06:04:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe94dde7d7so1411252e87.3
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 06:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691759076; x=1692363876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ItZIlqB+Ria1JrqgM0QJkLEyEvv52PbW+rw1eBSbcw8=;
        b=OGzGr/eNcCQazoqV722sdGwH4TjlsgSiAzPrio2ezGiGPx8oU1egCVscDUvCYkAz8y
         sXu0vkd4fuAImIcTOCx0ZQRMCMTmca5dmPLkjE6F4N8whWz4n8R7t6ORrpiS2ce0Mgu0
         nO54+SSdi7K4oNo0iW/ITF9b2t5sy0gA5Zm9hiMS2M/1R+jeOxuFUN6J/6O84EBi7Jbz
         FiCiyT/Ui3QgbT7OUUOGP7g2Az4qMGYjx9HC9bVP3kKXTHFw2OSc26v1SiwTBpEbH0+P
         BJqnBay+qPgkDKH7ry0Mu8YivmdOcz7VzRcobu04PTFkk70xOFzscl3w9oyYGbeJM+e4
         eMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691759076; x=1692363876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItZIlqB+Ria1JrqgM0QJkLEyEvv52PbW+rw1eBSbcw8=;
        b=QxJ/FLBaVj3+ePaTjJJeEGU6Wme4Uwifpdbz0vztOYGe9XxNTUWnVndQf5JBPeuWoQ
         ljzWW1nOt7cmoqPEGJdA0wepwLcpvk3bhiu50ahka9R3Mi8IDp/qnjPZZl/mXM6EZkZ9
         dU/Thlz3/BfxrhroqRiKcqdGNn7OSZYgDvic9w3BcaGVGy27b369o7+HVhXC+1opdLIA
         lIpqA6Q0plTMOuPS7besWpbR5IcifnaMIrkc6DK1FtnZ/0JNSzUfjkGuL/LLp1pxIPmx
         gOqURyrxQCyWyC6kB41GKYqsaScgo8bSTzOqFCdlSgZWKhZ0vr/NouOA0uXJNbXjTGC6
         HOEQ==
X-Gm-Message-State: AOJu0YyDWNJ3spVyK9TzV0gRVnXqdZAIFga7AuKRQo7eQ65BnDaVV1rv
        2TXysg9z1W/KPdHDxogIImxF0w==
X-Google-Smtp-Source: AGHT+IE+ywVcS3Sv6xVmrzcc8yEUL/+DMbG2FvfQpCnG8z4JZ2pYM94F/0AYF/uADWiuB2afvZkrpQ==
X-Received: by 2002:a05:6512:3b2a:b0:4fe:8ba9:4c0 with SMTP id f42-20020a0565123b2a00b004fe8ba904c0mr1822945lfv.26.1691759075818;
        Fri, 11 Aug 2023 06:04:35 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id v20-20020a197414000000b004fe15a2f0f6sm722491lfe.62.2023.08.11.06.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 06:04:35 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 15:04:18 +0200
Subject: [PATCH 11/11] interconnect: qcom: sm8350: Set ACV enable_mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-acv-v1-11-a85b6e94f46d@linaro.org>
References: <20230811-topic-acv-v1-0-a85b6e94f46d@linaro.org>
In-Reply-To: <20230811-topic-acv-v1-0-a85b6e94f46d@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691759050; l=757;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=etfBnMxcyZrfwYtusv1j/sgQetIS8vcPm6nKjzrLrmY=;
 b=tELDI2KeXTODUuhB9yLlfYGEIX9uU6HC+TKHXnwM4JI3Vlc9+o3JxDeS2xGU2AO1iLEoQ4h+v
 j85b9CW1NvrDyCxwzeKdK5a+GCc/MyN0V3O6omSgBB61yTcyhJ1XzWi
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

ACV expects an enable_mask corresponding to the APPS RSC, fill it in.

Fixes: d26a56674497 ("interconnect: qcom: Add SM8350 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sm8350.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
index bdf75839e6d1..b13814b3d6d0 100644
--- a/drivers/interconnect/qcom/sm8350.c
+++ b/drivers/interconnect/qcom/sm8350.c
@@ -1356,6 +1356,7 @@ static struct qcom_icc_node qns_mem_noc_sf_disp = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = ACV_RSC_APPS,
 	.keepalive = false,
 	.num_nodes = 1,
 	.nodes = { &ebi },

-- 
2.41.0


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C937C74EDED
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 14:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjGKMSc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 08:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjGKMSb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 08:18:31 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B173010C0
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:18:28 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b6a084a34cso85734451fa.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077907; x=1691669907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXcfnAFG0ALqJ5wchl9zMk96ke46h0gdnZo33aXqC6o=;
        b=VonMOp0i5+expziTeWEBTHMUNC7qXDeGRqyBPoJ1wkAUuR3RhU2Ey3IYC+JawK9rh6
         bHI9uJjJTWpyxc+pRRnma1cuAF16RAAcxjDTqfJT6s4+9D2lvb1crKrbG6E4T7E3j3JE
         7MBA0ngRqYrmXBTmKhP8l+hs9rWnbXQSPVyMw7DbtLvV9/KjkIbn9stCTJCLeYJ8Siq5
         7i6lnvVM71Lo1lZSupzYng3WE+l4ju3i2NfEvdXOdYzXzUSKWLTohxXt0Q13+Y0mjbSM
         kXXdY0gVkT+n4/u+ipmWfAu03x0bq1UG9/bal13n2vWRq52X43EVZGTNJNQro/YhG8uU
         ocRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077907; x=1691669907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXcfnAFG0ALqJ5wchl9zMk96ke46h0gdnZo33aXqC6o=;
        b=ZgaG92zHKENORdghESWOWlkg+gLabtAwD7bqSz2IVTMl556FbW6by/+t/Qz2OnQ7zY
         nBhpp1Qj7wJwPBfZUMOrY+vq3sB/zKqfmHZQRPF/2aj9C+H7qehtm+k36Jwl/vRjQmCY
         KMUX/njdt+Ghq0Yz06peTbeMpF0w8N2Hk1N33P7l1wydxh5HXfGExqYOg1i0UoNdpFIE
         nZespSPPGpQxE3h8UUUpDVbJKjJ0XEg9Rzd08LXIpYrjCDqHqaP72gNHmlMyCu122A8j
         TkHe6GcJy8GqD1iuGeuWLWDwW9VKNOrP6bttVurNdGoFEABpZoNxGEmPP1jzDFXbq7j3
         t+kA==
X-Gm-Message-State: ABy/qLYapCDMYRLHPTwNvF1F2Lxpex2aOgyEPchxoXhDwwIAWKlNNX8J
        yBX4EXtVTy2DMH2i+dyDavfIbg==
X-Google-Smtp-Source: APBJJlHATZyGrxjvNQ4UHts/OGjmEwK4EuBMFcRIRxrV1Y/bvqWGJbi81Vw/Tydk5ULRpDptO1qfDQ==
X-Received: by 2002:a2e:91d7:0:b0:2b6:e0b8:946e with SMTP id u23-20020a2e91d7000000b002b6e0b8946emr13108332ljg.51.1689077907043;
        Tue, 11 Jul 2023 05:18:27 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:18:26 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:00 +0200
Subject: [PATCH 01/53] dt-bindings: interconnect: qcom,icc: Introduce fixed
 BCM voter indices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-1-b223bd2ac8dd@linaro.org>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
In-Reply-To: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=1189;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9/TmGzQ1xk3CQ8ToyRcpOQBYP1VhR10l+JU+aSmEvI0=;
 b=N1JxOuvEYm4h/wsNdORtSNFT8AF68EXhuMFZexG+clfwKvtG5+uxA4rn/Z4fouP9EkKmuRWz+
 7R/htFQncM5BE7iN2tU0kXbvvV7s3St2Rs+MKybBnVpLAaPzAPW+821
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It makes zero (or less) sense to consume BCM voters per interconnect
provider. They are shared throughout the entire system and it's enough
to keep a single reference to each of them.

Storing them in a shared array at fixed indices will let us improve both
the representation of the RPMh architecture (every RSC can hold a resource
vote on any bus, they're not limited in that regard) and save as much as
kilobytes worth of RAM.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 include/dt-bindings/interconnect/qcom,icc.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/dt-bindings/interconnect/qcom,icc.h b/include/dt-bindings/interconnect/qcom,icc.h
index cd34f36daaaa..9c13ef8a044e 100644
--- a/include/dt-bindings/interconnect/qcom,icc.h
+++ b/include/dt-bindings/interconnect/qcom,icc.h
@@ -23,4 +23,12 @@
 #define QCOM_ICC_TAG_ALWAYS		(QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE |\
 					 QCOM_ICC_TAG_SLEEP)
 
+#define ICC_BCM_VOTER_APPS		0
+#define ICC_BCM_VOTER_DISP		1
+#define ICC_BCM_VOTER_CAM0		2
+#define ICC_BCM_VOTER_CAM1		3
+#define ICC_BCM_VOTER_CAM2		4
+
+#define ICC_BCM_VOTER_MAX		64
+
 #endif

-- 
2.41.0


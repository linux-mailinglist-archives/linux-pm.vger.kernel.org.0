Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B24274EE9E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 14:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjGKMWU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 08:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjGKMVm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 08:21:42 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6271FD3
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:20:23 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6b98ac328so85975511fa.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077965; x=1691669965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tO2vJbTBxTqUwo+iDtN9cED0N0PugFhOskIkVSgcZoE=;
        b=ARJRelBnGAIxZG/YEANwQNEnyS0nMcYoLuFxcfOEOapi3eL8cokkVKDT3OToGBPvcZ
         HHnqekREF7h2yFqOQDhfMkIFxsVa13mvPcW1Njit6OZ0hDCa8QIVvAdBt/W1e2Bx2NiZ
         PXnDzZwGSjq7ZeuTZrVyk2UDWLR6KMq8cxxNOu24yy2J616if0LNkGrgFMk+FsM/CuLC
         IiNiD5kuJqCqjcY7RhVuW747wRTwiL2z6SHnlaKeqdKIjQe+tJbtHrHW1NHZAfB0Qmmr
         rHX27X/HMNqCDTNfwbCQ/GO2bXmj6GIWXqJ9ykuqATgFKblcoMQaNAIUitVX9OtvUS1C
         De9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077965; x=1691669965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tO2vJbTBxTqUwo+iDtN9cED0N0PugFhOskIkVSgcZoE=;
        b=NKECmgRQ3bgeF+qRr3pguGhbIca+nJm7H/EMM1fZ7H1oCntUHjX/Zjx1KsMioe6/DJ
         ItbUlTAnQ/eSNG9bf8UNvmQU/GiFeDMt9btCkj8BBl8YpWs8cxt8HexSzvAdCSyhaBTn
         x9t6Iti2ZfPQT63oo5wXVDfmJnVFj6XFTud+nqFKCfD8bQvtmGdfnsu3FAQmSqQOKBr0
         c1l+yb4kV0M37sDtaR2zbUE5M77NcOKTNQGuKet7VMTLNCi3nWH5y7kQwtcVHaRsX7d/
         oxRUg9wGsysACJ8TZNe/3XPIqjp6iJSoGS5/SDgs2HUYwrkO2jMPcB8h/jyc2cxVsll/
         dCQA==
X-Gm-Message-State: ABy/qLavI5/tWZq2aDhLtu0tXW7q5+aJ3VslSzB+mgWDr/a6vDJL3dBz
        Ee2zfOmypANLBj3msP6/2ZdLWw==
X-Google-Smtp-Source: APBJJlHNsNXP3jQQq1fy4YfORvSV68I8r5L1JF7OUxsZTSrTBKxKrW5XrMOsxibOaatxVd9HmtLFGQ==
X-Received: by 2002:a2e:8784:0:b0:2b4:7f2e:a42d with SMTP id n4-20020a2e8784000000b002b47f2ea42dmr13840703lji.41.1689077965633;
        Tue, 11 Jul 2023 05:19:25 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:25 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:44 +0200
Subject: [PATCH 45/53] arm64: dts: qcom: sm8350: add qcom,bcm-voter-idx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-45-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=921;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=zd8n6/BI+I7iSUydn8vszsfz3OyuMkqkyuxPFIRsJhE=;
 b=E57CxKs72PQD3kiuEmwIYLAntDVsPXBSfYzwul/8gYNvLIixxKL1h9182RVK5JNqZz+6KgOal
 yDZg5Nh7opvDSGBwll1qr94NW+/GRz5K7PzqECKnGB2muUSSiDiiq8n
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To improve the representation and ease handling, identify each BCM voter

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 557a3d8e889b..fc8779a2fa96 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -3,6 +3,7 @@
  * Copyright (c) 2020, Linaro Limited
  */
 
+#include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,sm8350.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,dispcc-sm8350.h>
@@ -3397,6 +3398,7 @@ rpmhpd_opp_turbo_l1: opp10 {
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
+				qcom,bcm-voter-idx = <ICC_BCM_VOTER_APPS>;
 			};
 		};
 

-- 
2.41.0


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6012475047D
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jul 2023 12:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjGLKdj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jul 2023 06:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjGLKdg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2023 06:33:36 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC76919BC
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 03:33:26 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-55ba895d457so3473794a12.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 03:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689158006; x=1691750006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7R3B8EY4EOyQ9QJJeQXVuUhZWY60knY6YNAPx/POrbU=;
        b=eQa5psl+5eTSBqjMrPvYMzv4ZQ9QYShAmvfz7GrNcvDrCwnGYv/jGEqxp+nSLLSXaM
         zVDIq15DzBUHLmoUrItWkPjM/6QtkO0uPMfDqsL+726KkcY5N0JHwPr/2J4v3EcD/Zed
         lIiTqCbmeGiVTVRnXw54fkNoQfq7Uc1VU0RdGgFXnLeFzSaNPqBOCwHjAjZXNU5ZRMVR
         IaR37OhXl3SstntxhM/91GgBNfPOz7Lm7GWlEqgXUbg3ANxqDqx5NVkFLZW2XnZEFgus
         17Mb6XT5N6BX4INmfm8hC8kmOcy0YkBBhHCiXKund5fMjc3IOMxuxFDmuLdvtF2L93si
         XIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689158006; x=1691750006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7R3B8EY4EOyQ9QJJeQXVuUhZWY60knY6YNAPx/POrbU=;
        b=gNOKj0SqkKitaV3rqY7ZsHaBZw9kTfSZ3MagxLAF4S+pqJvDmBPReH4jW7k7rcryj6
         pay0yNGCjzaEj7HFQouwSeWxpMjF15msv6RJUYACSXHacRmECb8OrxSnBKr6SbtSs/6j
         JAqASdiC8VEGJv1jwMKs3hzBhAzjj0oHwjkzZUmB79YKc24u50IFd/THqME8q9JBw/2g
         L/aSs21A8DASlVqLYnZuKecV8bs8nKYNcRvjhbxUbkWwKbuVmsOZ8T3GAni3QJcenztU
         q/coPOMWsZaRGxstdCyuZRMXfFhR3O6qj61dtPymTKEDWhMcC9Ob+2BNPkqgeuPenh93
         op5w==
X-Gm-Message-State: ABy/qLYUXxA9uHUUaFQNmEefM65Ll3GI2Q2COrJBOmsp0MWey4mtEsRb
        1QepE8wsSOzaTbQywGFW1S1k
X-Google-Smtp-Source: APBJJlF14XtFwz0TZPveDzJxfHwLIpUd/zrWmutfKcxa+J6LfVlc9rCiPrzUZZq0VSrZ/4g2AnvPpQ==
X-Received: by 2002:a05:6a21:328a:b0:10d:5390:eadb with SMTP id yt10-20020a056a21328a00b0010d5390eadbmr17218406pzb.2.1689158006331;
        Wed, 12 Jul 2023 03:33:26 -0700 (PDT)
Received: from localhost.localdomain ([117.207.27.131])
        by smtp.gmail.com with ESMTPSA id k15-20020aa790cf000000b00666b3706be6sm3247860pfk.107.2023.07.12.03.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 03:33:25 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 04/14] arm64: dts: qcom: sdm845: Fix the min frequency of "ice_core_clk"
Date:   Wed, 12 Jul 2023 16:01:59 +0530
Message-Id: <20230712103213.101770-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Minimum frequency of the "ice_core_clk" should be 75MHz as specified in the
downstream vendor devicetree. So fix it!

https://git.codelinaro.org/clo/la/kernel/msm-4.9/-/blob/LA.UM.7.3.r1-09300-sdm845.0/arch/arm64/boot/dts/qcom/sdm845.dtsi

Fixes: cc16687fbd74 ("arm64: dts: qcom: sdm845: add UFS controller")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 9ed74bf72d05..89520a9fe1e3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2614,7 +2614,7 @@ ufs_mem_hc: ufshc@1d84000 {
 				<0 0>,
 				<0 0>,
 				<0 0>,
-				<0 300000000>;
+				<75000000 300000000>;
 
 			status = "disabled";
 		};
-- 
2.25.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D8E74EEEE
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 14:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjGKMcS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 08:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjGKMcR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 08:32:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39A21708
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:31:50 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb96e2b573so8897940e87.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689078657; x=1691670657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mouIVN5aOfpssmEDC+p5ObsXA9SRTIu++fiUoxbGev4=;
        b=jE14MibF7ouG7sarWe486m0INQ1Nz0pFaEv/XmERwz1sv24Y1xgpjoWwOTogztTJiC
         m7Pp9jEMi3MldLGfHMIWTN/Vyu1z681PqxpXPNFhXQDZVa8tcShIYCXhJ4NJ9FojXI4r
         QVsMMLOdXNIVmBVIHJweBx0HncCdA9bRQ2yoMXzkXQqPJQvdNB/5h1nhSOs/lGo95+mh
         wz6hx9iw+nR03Qzfgyv7T5aE3z7tPtPbka3RuFIlMVsM6bunfVvVTas+81zu38USOmA8
         4BmM+Y+8wCFt7ZQxTDlTym9m6Lq17YhrandMe9WAoxCi+Dip0ke+oS/yf1FhQnbhc/jM
         V8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689078657; x=1691670657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mouIVN5aOfpssmEDC+p5ObsXA9SRTIu++fiUoxbGev4=;
        b=a3aGrTJBoiSINBfxj0HoB+iFX22tURIJY/xEfi5rOSxfyHxjvzmBOFjbW3wHZOUlf4
         vqa3qXYUPb8uiTzvEWWPDdZxY7sjkYMoRErWVckJFRrX+e/YkmRbIZlxFwXuWKO/zxPC
         we3nPsKXHVwTz6LvetHW0pfhbqJsmEHigcqHaArYwak0iOqeB9C7UKD6xcW/tuxigojd
         2x01A9rt4ul+CxgsxtiGUvWH2TODDYF9QS/ICaG4XFJ2IVHpkTwCumjzkl1sOqF64bfs
         OcWxcw7+Wpzc2+gwhKcP6n/pO2FDoZWc83J2pkcZGZrCwpV/kQLey6R+QSjESTTLLWZ1
         wnng==
X-Gm-Message-State: ABy/qLZHx6IrEij/PfZXQ+szOi0xNiRmf7mfa1t2A8EKwv4C91QTPNie
        wbjwtBFg18slATsQc7z7FUrblVLVBplUjuznPCK9ww==
X-Google-Smtp-Source: APBJJlHf7yZI2vtKJX4P2V9vqBIPPM59NaTPvsu2eRHNcNAUC+aIqXx/owlrcF2ZViyku+o0Bd677w==
X-Received: by 2002:a2e:6e0e:0:b0:2b6:eb5a:d377 with SMTP id j14-20020a2e6e0e000000b002b6eb5ad377mr12645471ljc.5.1689077963176;
        Tue, 11 Jul 2023 05:19:23 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:22 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:42 +0200
Subject: [PATCH 43/53] arm64: dts: qcom: sm8150: add qcom,bcm-voter-idx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-43-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=1013;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=x0zGLJs0yoPS/RlnCeGNLi2dqlpoVvi8tNVTarjGkbE=;
 b=FSfXcsHn89MM1aKOUdCdC6mngIske/lMAzWCWPFQwrEpmxxUCYs9/p7KkltfVx0irKTji+kGL
 lJuu/TUXpvyD7WNEkqwsIUPvSbBK8HeL20eBfb7txG1n4B36T2oWkBK
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 0cd580920a92..151cc60de9cd 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/clock/qcom,dispcc-sm8150.h>
 #include <dt-bindings/clock/qcom,gcc-sm8150.h>
 #include <dt-bindings/clock/qcom,gpucc-sm8150.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sm8150.h>
 #include <dt-bindings/thermal/thermal.h>
@@ -4332,6 +4333,7 @@ rpmhpd_opp_turbo_l1: opp11 {
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
+				qcom,bcm-voter-idx = <ICC_BCM_VOTER_APPS>;
 			};
 		};
 

-- 
2.41.0


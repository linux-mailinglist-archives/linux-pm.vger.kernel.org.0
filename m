Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5258F76C1FA
	for <lists+linux-pm@lfdr.de>; Wed,  2 Aug 2023 03:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjHBBQC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Aug 2023 21:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjHBBQB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2023 21:16:01 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275DEDA;
        Tue,  1 Aug 2023 18:16:00 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-58419517920so71466507b3.0;
        Tue, 01 Aug 2023 18:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690938959; x=1691543759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mbRRe9sD99e8aEwE3pk6AUAMTqeEcIKbHf41jMy50A=;
        b=dM2vrnKgbDBQ6GQ1a9zozB4Kq4Dk2kIW1LJd1tS+rKFdt499gchQdf5o3jgGjgBUSU
         KwPttqMS9aUu4BdQv0sbC3a1hphgNuDk8WC5U6NGvJiah6rzGVR2QkGY5Wv2g+utsxy1
         Qo7pawYfGsXYwE1b/xlHbMVYGT0C/R4oCVDLhZTamV4uS76QFxceo1bzhcFEmSZB5RqE
         zE5X1U7SJOYl38omsTWkihuYNl2d2nVzaQWDQdKr3nyxBSH2FEMTQRkr6el7Du/E2tVr
         ibAfxYruhwk3bBY6NSrOGKCoejd2O8KCmaDTJlYCFRiW7vSVNy7vzVz7qQgzGnNbmcC8
         250g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690938959; x=1691543759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mbRRe9sD99e8aEwE3pk6AUAMTqeEcIKbHf41jMy50A=;
        b=RGxnn/NCve2dotrVlRtTV3mnycoTW5oSy+ahrLxgGzMXrAKdFc3rGuU5He+gSXYptg
         rVGdO/i180O6tilErNdU70BcNmLCqCb3tAtxNZMUQEoLTs6+kfOmgRUSVw8lgyGBpitr
         KZUR7OF81V2OKDkcx78uyQiNRWyw3Mai4RLVxXazpEvgb0zRwEabGLeLu1TWXVDNDgyC
         8d3Rhv0oaexyDykljM5WLvh1WE52BbVec58yfMzpiVbPPuqQ4wG8/qkVAwKRaZALSse6
         OaBE8fkmHFJYCrruK659It91jTWiItEhrRk9Bk6vAbrC22ZQsJSHphzdIxklLjlPcERe
         oEMw==
X-Gm-Message-State: ABy/qLa5nj7HT7GSS3svzl3WqlXzzG5mnKHADMsIe3VVCHX9lTBBcV28
        Szw7M1SbtW6EpjYuMaJlOeLjbqFz5ZXnZA==
X-Google-Smtp-Source: APBJJlH9aev4mUO794G0FKKfKs+lL+twnp2cV6tNYmgCxnNKsSTqfzJM2bvSGAZGexDsuf1aTmdjug==
X-Received: by 2002:a81:4943:0:b0:576:c543:2a5f with SMTP id w64-20020a814943000000b00576c5432a5fmr17800207ywa.4.1690938959381;
        Tue, 01 Aug 2023 18:15:59 -0700 (PDT)
Received: from localhost ([2607:fea8:529e:7800::7cda])
        by smtp.gmail.com with ESMTPSA id g67-20020a816b46000000b00576c534115bsm4189583ywc.34.2023.08.01.18.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 18:15:58 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v2 2/4] arm64: dts: qcom: sdm670: add osm l3
Date:   Tue,  1 Aug 2023 21:15:50 -0400
Message-ID: <20230802011548.387519-8-mailingradian@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802011548.387519-6-mailingradian@gmail.com>
References: <20230802011548.387519-6-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the interconnect node for L3 cache on SDM670.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm670.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
index a1c207c0266d..45f9633d2d2c 100644
--- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
@@ -1354,5 +1354,15 @@ intc: interrupt-controller@17a00000 {
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			#interrupt-cells = <3>;
 		};
+
+		osm_l3: interconnect@17d41000 {
+			compatible = "qcom,sdm670-osm-l3", "qcom,osm-l3";
+			reg = <0 0x17d41000 0 0x1400>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
+
+			#interconnect-cells = <1>;
+		};
 	};
 };
-- 
2.41.0


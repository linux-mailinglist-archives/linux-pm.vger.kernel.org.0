Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E1D65659B
	for <lists+linux-pm@lfdr.de>; Mon, 26 Dec 2022 23:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiLZWuX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Dec 2022 17:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiLZWuF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Dec 2022 17:50:05 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6816125E7;
        Mon, 26 Dec 2022 14:50:04 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id u8so6034139ilq.13;
        Mon, 26 Dec 2022 14:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSp+MSPgH+KIFV5boiLE3868PD26QSDM/7DsPwK2qP4=;
        b=SgvyMvUEQ6z8YR6YpqVAWKq8vPI70S8zYMvBZiNI6kqW3D+qMhxsP4HNDfg7AuZXpl
         5wscsOCLfDJCohVlWjwmxf0AS54V75hAQwbV4taWI80z/CgRbdkT3U/RBXp3cA/eD3oQ
         cHg7AwTkVlQVBcB954WKrv3ie29PWxfQfjI5Oc2Vz389jZpy0DbgO7A1iPlkVZbrspE+
         Z1qO8NXPBq7UkmLFYuDkgFymWMiqPKJitPskvy3dpniE3yawCP0ju+liJl1JN3KhSJrJ
         XO2VSu7JXQ7UhewYXfGtrWtjZn88jhB1LEPjp5FNIk0dLgG8a1YK/SYTjWL6ND+zsDMf
         EmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSp+MSPgH+KIFV5boiLE3868PD26QSDM/7DsPwK2qP4=;
        b=xjzq4VpeE8kXa5LT0a00PPWJ9I7b3TaqDuxUxY4zgF2Alb4PwikJweyABUFq3avzrj
         H0ocQKSBs3+DpYJyxYZ94zMtbafDIIUyd6XfcW07FVeTUbito3xgnAxgym1zH+UGUvzU
         kEsMbIU97C+KSjQC2WonGyLvl6z+H77Woownz/pY0g5ZMeRthonSTBzU3ImEyCRH1kcz
         rYhx6HNyPOt/AwZ4LrREggk6gSpQLjbFlaKyB9yxluc6sAkLcelNnDBrAkat3FspGqU+
         R+ikU6ecJZ/RfcnHJsU08h9zhGNIbkPTqeD7EIRxjF+dzKSB80eZDOfdEyrF/+iB01Z9
         pJXQ==
X-Gm-Message-State: AFqh2kqkmY82l7/2GO1WAA/Ry4b+LiRe1tqXdOhcUNC2H6tkhiHY0Tt1
        mv2OufZfYvglEFoxS+a6Omc=
X-Google-Smtp-Source: AMrXdXuNiwXwTqeUivFvEYtR4nFrnYm1C2sY4o0W/spzJY3AmgX+NLGN9T/J5pi7BBQfDxhs3eQZJw==
X-Received: by 2002:a92:d7cf:0:b0:30b:bb8e:743d with SMTP id g15-20020a92d7cf000000b0030bbb8e743dmr13478893ilq.12.1672095003820;
        Mon, 26 Dec 2022 14:50:03 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::e694])
        by smtp.gmail.com with ESMTPSA id z3-20020a92cb83000000b0030bfc39bcddsm2065584ilo.38.2022.12.26.14.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 14:50:03 -0800 (PST)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH 3/4] arm64: dts: qcom: sdm670: add interconnects
Date:   Mon, 26 Dec 2022 17:49:43 -0500
Message-Id: <20221226224944.37242-4-mailingradian@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221226224944.37242-1-mailingradian@gmail.com>
References: <20221226224944.37242-1-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The interconnects for Snapdragon 670 can be controlled. Add their
corresponding nodes in the device tree.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm670.dtsi | 56 ++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
index 47363fde64ac..67a7428291e2 100644
--- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
@@ -776,6 +776,55 @@ i2c15: i2c@a9c000 {
 			};
 		};
 
+		mem_noc: interconnect@1380000 {
+			compatible = "qcom,sdm670-mem-noc";
+			reg = <0 0x01380000 0 0x27200>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		dc_noc: interconnect@14e0000 {
+			compatible = "qcom,sdm670-dc-noc";
+			reg = <0 0x014e0000 0 0x400>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		config_noc: interconnect@1500000 {
+			compatible = "qcom,sdm670-config-noc";
+			reg = <0 0x01500000 0 0x5080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		system_noc: interconnect@1620000 {
+			compatible = "qcom,sdm670-system-noc";
+			reg = <0 0x01620000 0 0x18080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre1_noc: interconnect@16e0000 {
+			compatible = "qcom,sdm670-aggre1-noc";
+			reg = <0 0x016e0000 0 0x15080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre2_noc: interconnect@1700000 {
+			compatible = "qcom,sdm670-aggre2-noc";
+			reg = <0 0x01700000 0 0x1f300>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		mmss_noc: interconnect@1740000 {
+			compatible = "qcom,sdm670-mmss-noc";
+			reg = <0 0x01740000 0 0x1c100>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		tlmm: pinctrl@3400000 {
 			compatible = "qcom,sdm670-tlmm";
 			reg = <0 0x03400000 0 0xc00000>;
@@ -1069,6 +1118,13 @@ apps_smmu: iommu@15000000 {
 				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		gladiator_noc: interconnect@17900000 {
+			compatible = "qcom,sdm670-gladiator-noc";
+			reg = <0 0x17900000 0 0xd080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		apps_rsc: rsc@179c0000 {
 			compatible = "qcom,rpmh-rsc";
 			reg = <0 0x179c0000 0 0x10000>,
-- 
2.39.0


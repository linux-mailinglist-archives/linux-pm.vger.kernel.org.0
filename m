Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC906593B1
	for <lists+linux-pm@lfdr.de>; Fri, 30 Dec 2022 01:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbiL3APz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Dec 2022 19:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbiL3AP2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Dec 2022 19:15:28 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF6613D69;
        Thu, 29 Dec 2022 16:15:28 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id j28so10548091ila.9;
        Thu, 29 Dec 2022 16:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSp+MSPgH+KIFV5boiLE3868PD26QSDM/7DsPwK2qP4=;
        b=i+6m7v0jaQP+l6V57F6C9o0VnMSoS1QpVnzRhMa9cphAFr1Jh1uq1iOxFgz3nUXWHL
         GZI/9UrzKBIcdnFjih1NRfr5V5C942rvpIDqyAWMA/LNJXlAa3gUr1SA7ajpyuA+B6j8
         ZpUy7tKel1XowQUBOVkIM16soLWgfXEFAxMUGT/EStHigm1sWtZ8I7sQEr9YHBW/FrMJ
         Z+ZxoXPQSZFsYh4yQzt34Al7pPWBICLiqvP0kvlGYveQkt8kKZN3qbfWNgzZb45FSdGM
         Jks7UCUCnJfe71On3Silz66rAMRYHuyyRzXpcDz0Esozp4yxDeFees1thEMZZOuMFzSf
         xVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSp+MSPgH+KIFV5boiLE3868PD26QSDM/7DsPwK2qP4=;
        b=KZsX3Xlq6NJd1GRX2twLZFRgdKQnkpYI0iZnoWN01mxn0P0RrnTVpBnmmhCgDZTKXC
         jn7J6yuRaYxxROyRLl8Oc6FvLiGiic6VhSdqv0XF0cupV/m+Og9LNPrCHU0p1Ho3dpR8
         SP6JkicRf2Uwph72+FEN+ca6aiPXFaQUUlcCsUEfNhmtrLbV8J+CvtTQ9e1LR/hW3nqV
         fDungdd91Ud301NuDrRDyb1p+VLWWgfki1wCCCKC0HVVPomuF5FTL8GPUNT8cVXJlBnH
         e6pCWS5RkUpBswDL93uKSIvU53RteUfU3qUmjWiZPgLgh8B1I6dajcmlCpz10yyrBofi
         va/Q==
X-Gm-Message-State: AFqh2kpStrs0M0auzYzP6eTM1rnJ8HTJGLj3jAhsX+v3rTgBtfASPQuz
        Eeq8kPoi2sX9HPgKqupN52I=
X-Google-Smtp-Source: AMrXdXtpqRlXQuIRAgB6LoExq1PygcpZq6vEP/oBFbrBO2UFBowPwc6YcEyFa3oeL78dWQ10TAy2pQ==
X-Received: by 2002:a05:6e02:1566:b0:302:70b8:4cc4 with SMTP id k6-20020a056e02156600b0030270b84cc4mr22592910ilu.10.1672359327420;
        Thu, 29 Dec 2022 16:15:27 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::b8e2])
        by smtp.gmail.com with ESMTPSA id q9-20020a05663810c900b0038437cba721sm6303876jad.7.2022.12.29.16.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 16:15:27 -0800 (PST)
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
Subject: [PATCH v2 3/4] arm64: dts: qcom: sdm670: add interconnects
Date:   Thu, 29 Dec 2022 19:14:41 -0500
Message-Id: <20221230001442.369608-4-mailingradian@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221230001442.369608-1-mailingradian@gmail.com>
References: <20221230001442.369608-1-mailingradian@gmail.com>
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


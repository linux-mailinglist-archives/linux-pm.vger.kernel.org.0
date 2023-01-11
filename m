Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089706650A1
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jan 2023 01:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbjAKAw3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Jan 2023 19:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbjAKAw1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2023 19:52:27 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BCEDA8;
        Tue, 10 Jan 2023 16:52:27 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id a3so1325041ilp.6;
        Tue, 10 Jan 2023 16:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwrqyXxOwDECeWUhsT5aw/2p3RQHTQl3MMrK+gg4ReM=;
        b=keyhwUdRrqJt6qBxmS21kDSpKU77i8vidg/gJUDbBnIt6YBGOiw+eiSk8aJV6RfNip
         huA0bdg17GDFwInVlw9mxZI9ieosKtWSewAekYHZdwMFEUyKEOp/hDfR124RIqyJNSZy
         Tkflmj44HQe2NSITM0u8SgFnZOp3TWuNgTIf6097oLHMc1ypfdAXoZiMV+tormLt4FpM
         JPZIkGXPlTfEEdnMA7JgufAswYs2uV2w5+LP5DIGTyq8nrjuDgbLnE0Bd/BcAoYRB5wz
         O/ppD6A2B8tHMK4S3FPJ8HPkZr9nK8A1tGKEqXDGmQHuT6vwIPRQn8fJFHfmWKeVQu7R
         nUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwrqyXxOwDECeWUhsT5aw/2p3RQHTQl3MMrK+gg4ReM=;
        b=fgQcIAweMDlYGJYn0fDKqS8l8tyTwnjxdo/ZVuo1YHUyY52+joBmrPlSIKv0zW2AzI
         F7UzGrg6GPMSCRy29KLhhflOUoMGTHzl7UQLhR+E1qy9InuYH+8S9v0NNmMLD+W4z4VO
         9yjUjBTCxnb1UbJLysldKFyn4g3ibybl4SlloqPPMtHtdvzDEZNqzYCoIAL96L92Y8gb
         +1JDRAp9iaXEd6POet8ahB6+ZnGdwxb1dN/YuaiBHbny6rc+Hh1N2KMihzOfmr1Uy9Vg
         Id+JvY4hOKv8CSMMI5/gY7Wg8KNVKF2/koNdSnObXXaGvhkF2xV7EyAt485hXpE5PhnG
         ZKsw==
X-Gm-Message-State: AFqh2kpZYSImm5fNmMY6IbgA+YePvhoxtCCSACkYuCxSkpBqyyHaqmLJ
        zDW2RJujYPfHNyuWLD/ZQ4w=
X-Google-Smtp-Source: AMrXdXvFk2WkOpXn5dcE8U20FXNWxnWkNvm5sSnxoBwZB9WQPboVdWs1i3F54mDYQj9sWXrYGmNwOw==
X-Received: by 2002:a92:c26f:0:b0:30d:6de3:268b with SMTP id h15-20020a92c26f000000b0030d6de3268bmr25608831ild.19.1673398346419;
        Tue, 10 Jan 2023 16:52:26 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::11ab])
        by smtp.gmail.com with ESMTPSA id r7-20020a92c5a7000000b0030d7eb788e6sm4013770ilt.31.2023.01.10.16.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 16:52:26 -0800 (PST)
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
Subject: [PATCH v4 3/4] arm64: dts: qcom: sdm670: add interconnects
Date:   Tue, 10 Jan 2023 19:51:54 -0500
Message-Id: <20230111005155.50452-4-mailingradian@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111005155.50452-1-mailingradian@gmail.com>
References: <20230111005155.50452-1-mailingradian@gmail.com>
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
index ec9946e5f08d..02f14692dd9d 100644
--- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
@@ -788,6 +788,55 @@ i2c15: i2c@a9c000 {
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
@@ -1083,6 +1132,13 @@ apps_smmu: iommu@15000000 {
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


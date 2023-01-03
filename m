Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C926865B92B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jan 2023 02:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbjACB7A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Jan 2023 20:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236603AbjACB67 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jan 2023 20:58:59 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1B2AC;
        Mon,  2 Jan 2023 17:58:58 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id p15so6432809ilg.9;
        Mon, 02 Jan 2023 17:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwrqyXxOwDECeWUhsT5aw/2p3RQHTQl3MMrK+gg4ReM=;
        b=hrplG5J0mZEWwEcalPRbiRRGiJ8o1Nv91Sqr65AJAHVpC20fDc/j9uxcxKd5+OFAGZ
         A8EQ/QyJQr0dYSbByAFXdujm2nubO/GQc1QjFvPd8htR3al7p6RUJ/OwDDXRNG4EoomN
         k9e75p9TlwmZyCNrv2lH3LmJ3hi0Yu3xldqoNMS8Hugdb6Kq/nQPPet3Gj4C3gHj+HZR
         0/c405fMWQQLSU/FeVCwq9rjRs7hCdbnDyS8DS3xi3v4BI1U57xPSsmO88rCMH3rpDIp
         Jdm+Su3hZ4Tb5dQum5CPj1cyBO+ZNCGmyW1yTZ3UkahEdhmhIH2uM2jcrSBH/u9MC7rD
         Wupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwrqyXxOwDECeWUhsT5aw/2p3RQHTQl3MMrK+gg4ReM=;
        b=xBf9vpNVgFH6WczgaULLgIu6pzdLimCgOTnDqRIyYel0eECcW695cPt244pLAYr4OG
         cceE/Z5pxQbKsVeiowYjKoCjcFkp/pBS1mypCAJPCW3/cI3ls0vvVrT5gGSIamzSyxSe
         QUBWMo1tufBcj2KS8zbsIIeEpTGeKWpjygDIvekgidxP2UPAPzq/juzViaG+Ue9QKJBM
         NDaio4KfJkBx8f69Tud/7ffl3fzjZlDy0Zic3VF6hTubzJQP4cfqLpxt4LGaDumCvdOZ
         3zuG3gYM1G2EksYrci7JLLVkgDucDmYSxkVpv6vDaBpsnXn0v5YBzy/yppX9J85wOxDJ
         55OQ==
X-Gm-Message-State: AFqh2krN4lR518/HhAxeZfAt0vAdlUeKTVlJYHqq04bYaQ5bfIq3IdRv
        IluRoRisc3TLXX79r7rw2coTGediyso7TA==
X-Google-Smtp-Source: AMrXdXvupotTc6aNKA7hHGphgqcer7a+O6QsUIoNtKDEV+FSKQpHYn89I0S5qYvIOk2B7DcqtK7uRg==
X-Received: by 2002:a05:6e02:1d0a:b0:30b:b565:7c3 with SMTP id i10-20020a056e021d0a00b0030bb56507c3mr32367766ila.1.1672711138285;
        Mon, 02 Jan 2023 17:58:58 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::d097])
        by smtp.gmail.com with ESMTPSA id w9-20020a92d609000000b0030314a7f039sm2188988ilm.10.2023.01.02.17.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 17:58:57 -0800 (PST)
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
Subject: [PATCH v3 3/4] arm64: dts: qcom: sdm670: add interconnects
Date:   Mon,  2 Jan 2023 20:58:44 -0500
Message-Id: <20230103015845.314551-4-mailingradian@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103015845.314551-1-mailingradian@gmail.com>
References: <20230103015845.314551-1-mailingradian@gmail.com>
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


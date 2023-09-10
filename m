Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E848E799E64
	for <lists+linux-pm@lfdr.de>; Sun, 10 Sep 2023 14:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240225AbjIJMw5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Sep 2023 08:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjIJMw5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Sep 2023 08:52:57 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF52CCC;
        Sun, 10 Sep 2023 05:52:52 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b9cd6876bbso1010843a34.1;
        Sun, 10 Sep 2023 05:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694350371; x=1694955171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HAvTvLohe9TB635fRBSatAf9eavmCCemddZkbMItGg0=;
        b=pLlmYXGmkckMTFH3xNOlqMKYaIQIoj77uWLfJD/CswgJO5c6yKG1rkukEzZCJ4BUzz
         lWSgzAnI9oaouIBBasZz3QtsTcSRH1jvD7OY2qn3yY3Ho5367fOUFabLeZur8L6UEf0/
         2+uGTCoHW7vmTZLNzto+FGUg1APbXSHFZCAEmNRYtAP4zNRcVZ8jXTRWCnh+PrDctAef
         JlozvgLQ3aTMYr9BV5VxKdf6gJDVwx9Yj81CM+/7jIRLHn5NYBO4NNju2nveIrqJOqJ4
         B6XQZAGir3hFZCsC/Pb/uyiDqxMzsM5mEzPTwL6sHR1R4iO6QXaUX9XuRenLmwZm/j+X
         lTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694350371; x=1694955171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAvTvLohe9TB635fRBSatAf9eavmCCemddZkbMItGg0=;
        b=eryQxCzgqdam1X+GxF8vsOJH97UR4pZLFXhi9BKwYPHv78sThVqrznsjwuy7VRjkBx
         5qDoOj3h6PC5kw3722u/KKGTBaZVYq48cIp+4bD2bAkQhdXIeJAGMWub1L/YHjYaWGia
         DJsNj6mD7iaBDY4VHczHQ3tkvvXWUjOyv/sarQ/tgXgapixU0DqL/L18eUon7m5Fdsaq
         6wI3t6G4SvZq6O1qoMCx4/RcT+NsAQ4ig6DyJOTuOGsS1zBoC/XO6FI3eHhIvMOdbxNf
         ip1SgveMamb1CGqvkMJ/eNNFZN3uloTB7A+0aqQ/MQu0S6twj+4ttWjgcAJc8/DW1VC2
         Gyrw==
X-Gm-Message-State: AOJu0Yz0cRFLbn9DBsfMt/5YiN0udL3sIZB9oECFWFyabDPxFkYgof1J
        jmTRUNSLxBYn5wwj+9fwXVA=
X-Google-Smtp-Source: AGHT+IG/HKjsdSfIiZKBB6CVUriBl+xQx/S12XScDSCnxf4upOTi/6euM+wpcYRvcVG1pbbY6g9FNA==
X-Received: by 2002:a05:6870:170d:b0:1d5:53c0:c1fe with SMTP id h13-20020a056870170d00b001d553c0c1femr7534222oae.3.1694350371412;
        Sun, 10 Sep 2023 05:52:51 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:8ae8:e729:67d1:f8d9])
        by smtp.gmail.com with ESMTPSA id li9-20020a05687c354900b001d4de767807sm2972308oac.28.2023.09.10.05.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 05:52:50 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-imx@nxp.com,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/2] arm64: dts: imx93: Add the TMU interrupt
Date:   Sun, 10 Sep 2023 09:52:42 -0300
Message-Id: <20230910125243.1242722-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

The Thermal Monitoring Unit (TMU) interrupt is number 83.

Describe it in the devicetree to fix the following schema warning:

imx93-11x11-evk.dtb: tmu@44482000: 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	from schema $id: http://devicetree.org/schemas/thermal/qoriq-thermal.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 6f85a05ee7e1..5d36b7a5bbd5 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -385,6 +385,7 @@ anatop: anatop@44480000 {
 			tmu: tmu@44482000 {
 				compatible = "fsl,qoriq-tmu";
 				reg = <0x44482000 0x1000>;
+				interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_TMC_GATE>;
 				little-endian;
 				fsl,tmu-range = <0x800000da 0x800000e9
-- 
2.34.1


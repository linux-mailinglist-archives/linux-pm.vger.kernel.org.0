Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1C83F575A
	for <lists+linux-pm@lfdr.de>; Tue, 24 Aug 2021 06:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhHXEfh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Aug 2021 00:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhHXEfg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Aug 2021 00:35:36 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FB5C061575
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 21:34:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so1465363pjb.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 21:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nff3Tp8Tu+bjLX3ssyXcSoAVuinaN02903EEynfcyEI=;
        b=akyrO8UW4SNYZEpYM1TGkjrb18VxaZv24fdamHymXvkgr6Kfc1IY6qzydAlK3ADJO2
         oDBT9JuHVRdKmasKr+SNTcGjFx/nAZnTW0sr0g3FAr6kKjJWeL69G02RtwQO3xY4yqHB
         GEf5Py2ddON8e4RMW4nWJv8lDICXf2aGT4YVv1EnMMG4PPm3pd0ct28OyCJzMfDBKtTc
         IhulrZ1eq3H3fOWByt4dSA0ajFxQaoYKzXGU64DXg7DSuLTFJqcTao6Kznpqmz1xFTD9
         LZZx+2Ka56HW4GabUlUBQlFtfQl1mE82CwwUgwc6p1TTOIpASFAbLppRdP4hLn998i3A
         1N4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nff3Tp8Tu+bjLX3ssyXcSoAVuinaN02903EEynfcyEI=;
        b=hfPZ3pFPmfZLbwFQfJqnlAA04romDnVmS+caYgE9jA2ITweqUZfp4HyzFtNoyi6IcV
         i6hjfdYJ2ubJ7XdhEuT2lDZdbEMc251NGVn0BaJwVilbVU6td8aItBMHX8vicN7aEyKA
         Fbc7ssAa5XV7asLTQtMnJMkON9U6S1l+Ga5DoXtCCcdlxGkisj0kvZhjBq8hjLg+YPGI
         51GtTVwE8niLKkeUiSiCBl6mtb4CfBmJKcv0YhNSqAtQrfscvLuiYiMCy20peCjTEZAY
         4wL7z6MQcc78qR4Vdi8D81BB+WEwYtW1Z4sP1rurYfRPoa8in1ghtCX4UYzM8Ezep3a2
         H6Fw==
X-Gm-Message-State: AOAM532W2F5R6eaGm9pQ2oqa+73R8FH0UAn0ABEbbykZ7kK5HHAVWJn8
        DUGy//H/NTAQWPi+K0Dw9N1Szg==
X-Google-Smtp-Source: ABdhPJwCrgQs+CNG8zpMXBnm0FQPFbYJnCkHn+S6Acaqfm8JfyI/nVXVussec6xNotV2x6onHOMUSQ==
X-Received: by 2002:a17:902:c94b:b0:130:ad84:990a with SMTP id i11-20020a170902c94b00b00130ad84990amr18696165pla.1.1629779692226;
        Mon, 23 Aug 2021 21:34:52 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id p10sm789401pjv.39.2021.08.23.21.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 21:34:51 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 3/3] arm64: dts: qcom: sdm630: Add missing a2noc qos clocks
Date:   Tue, 24 Aug 2021 12:34:35 +0800
Message-Id: <20210824043435.23190-4-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210824043435.23190-1-shawn.guo@linaro.org>
References: <20210824043435.23190-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It adds the missing a2noc clocks required for QoS registers programming
per downstream kernel[1].

[1] https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/sdm660-bus.dtsi?h=LA.UM.8.2.r1-04800-sdm660.0#n43

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 9153e6616ba4..9c7f87e42fcc 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -654,9 +654,20 @@
 			compatible = "qcom,sdm660-a2noc";
 			reg = <0x01704000 0xc100>;
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
+			clock-names = "bus",
+				      "bus_a",
+				      "ipa",
+				      "ufs_axi",
+				      "aggre2_ufs_axi",
+				      "aggre2_usb3_axi",
+				      "cfg_noc_usb2_axi";
 			clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
-				 <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>;
+				 <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>,
+				 <&rpmcc RPM_SMD_IPA_CLK>,
+				 <&gcc GCC_UFS_AXI_CLK>,
+				 <&gcc GCC_AGGRE2_UFS_AXI_CLK>,
+				 <&gcc GCC_AGGRE2_USB3_AXI_CLK>,
+				 <&gcc GCC_CFG_NOC_USB2_AXI_CLK>;
 		};
 
 		mnoc: interconnect@1745000 {
-- 
2.17.1


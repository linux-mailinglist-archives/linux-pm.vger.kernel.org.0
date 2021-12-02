Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F2A466D07
	for <lists+linux-pm@lfdr.de>; Thu,  2 Dec 2021 23:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377371AbhLBWld (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Dec 2021 17:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377248AbhLBWl3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Dec 2021 17:41:29 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588C2C061757
        for <linux-pm@vger.kernel.org>; Thu,  2 Dec 2021 14:38:06 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id t83so1544380qke.8
        for <linux-pm@vger.kernel.org>; Thu, 02 Dec 2021 14:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0diK6zWMgOO/TArP/zyW7Q3OH2Ix/QmAaJD5h2ncz4A=;
        b=awoJJBi2hfUE1F4m4zBeadCl7t1J/j0kIXhSwFGX6yFqOZwkxe6P/bSW4g8ZTDdWuT
         F2nmwEEsbgkQdWGpLAs5PkLgoumu6Zzs4vGtmpnuS/YToak13ectEyghRz5wwFldqNCo
         PEewD/KBLHcg9CeSW9KEUva3ZVHe6At4qEQF3QcAibZgpFGTrtpUJVbdBfcC3zhuseJO
         ZS7M7gYvXuYqWyQtlXdm5inJ9Ed60JPkTE1I82zDbVpZSHL8MMrWOmy69brB5m8feFL+
         Aff8nwRH3QZQ9MjPX0R80Pj8BRPzmbSFJjUXrvtor12Fw4PaeWWSQAIipiG6PvwcmR+/
         3d5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0diK6zWMgOO/TArP/zyW7Q3OH2Ix/QmAaJD5h2ncz4A=;
        b=yR7cfEL8+6Bl3CPXsuQ5l0TEZm6oysy27+gDxvBSjzatoI+PSf0mmXgHVkAVoPiZYT
         5YYvzyPyyHetFgTaNUIPxsBz1OFmKKDu3qsJqsaebFOFns2Ckz1tfyLoCmDtPdHh+wot
         IZb5aQR+S4nNcguBNmWSSNUggWpcq5/1xc9t2dh8Mk6vQt6C0QvNAy2ZhODIJBTHd4k8
         tUjRFHXOhMQGrYqRprBmPkeZS5k0JFn0h9lRtE7EMTAv0/PI6yuX/Phl3hTnrtLNraCz
         dZfxn0JDdUcbiqL9NmD5/3aoFNvk9M439u0OUcZdxHQOa1iTUPXoYmH14L4xJycDqhwc
         Fb9w==
X-Gm-Message-State: AOAM530EG4PmPBZYkFS9Kx4F4PAHBeANdhDLUU5cWWoCAJayEmBDpAH2
        TxbCH7xi29UdlEHDBCGiTEqFFg==
X-Google-Smtp-Source: ABdhPJxQVbRfr9BSZgH8u3hmZetu4szGlJHsHguzhn20DLSXmmTT3Wj/07vQC6xH6L7cnqexO/15AA==
X-Received: by 2002:a05:620a:bc8:: with SMTP id s8mr14613668qki.50.1638484685510;
        Thu, 02 Dec 2021 14:38:05 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id h3sm961152qko.78.2021.12.02.14.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 14:38:05 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: qcom: sm8150: Add support for LMh node
Date:   Thu,  2 Dec 2021 17:38:01 -0500
Message-Id: <20211202223802.382068-3-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202223802.382068-1-thara.gopinath@linaro.org>
References: <20211202223802.382068-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add LMh nodes for cpu cluster0 and cpu cluster1 for sm8150 SoC.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 81b4ff2cc4cd..e755d7ab78dd 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3650,6 +3650,30 @@ cpufreq_hw: cpufreq@18323000 {
 			#freq-domain-cells = <1>;
 		};
 
+		lmh_cluster1: lmh@18350800 {
+			compatible = "qcom,sm8150-lmh";
+			reg = <0 0x18350800 0 0x400>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			cpus = <&CPU4>;
+			qcom,lmh-temp-arm-millicelsius = <60000>;
+			qcom,lmh-temp-low-millicelsius = <84500>;
+			qcom,lmh-temp-high-millicelsius = <85000>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		lmh_cluster0: lmh@18358800 {
+			compatible = "qcom,sm8150-lmh";
+			reg = <0 0x18358800 0 0x400>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			cpus = <&CPU0>;
+			qcom,lmh-temp-arm-millicelsius = <60000>;
+			qcom,lmh-temp-low-millicelsius = <84500>;
+			qcom,lmh-temp-high-millicelsius = <85000>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
 		wifi: wifi@18800000 {
 			compatible = "qcom,wcn3990-wifi";
 			reg = <0 0x18800000 0 0x800000>;
-- 
2.25.1


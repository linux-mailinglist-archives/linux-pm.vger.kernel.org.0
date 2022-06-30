Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63149561AF3
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jun 2022 15:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbiF3NGA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jun 2022 09:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbiF3NFw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2022 09:05:52 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF0124F2B
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 06:05:50 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id pk21so38941429ejb.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 06:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tQRh0AY/h380Rf7RaIfP/jHK8L0FIrKA6XtVoZoWfV4=;
        b=ebLFV31bDZqK2n/IPB1RT/5PHkVPLIASQnyZi+pXm0MimLvKJmyWIdYkXuRbYJD8CG
         YvZ1Q5aDqByLx6gBd+AkIiIQxKZ3AJ8rPeoENw0wKxrYJzmZV6hWJew8a6EcqQmLRoWF
         lo4GtYuxXM5XkkIK3njCmg62vzc4WBqEJob4IW2PmvRko4J8XQ8iyMWnVbZNOfpFKOpz
         7OYYELi+Fyl7TkuCSyPVE4vqAHTfKa0Zu3JZ05D7vLUpedn+PF+qa97lzyFe6CJbbQmB
         YR/r82tGdChjLC1lF2DepeYHPDo/PlTr/3m4Bxo+p1FIBEBGbZUzQHxlPvfq9sHFmkWl
         4HfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQRh0AY/h380Rf7RaIfP/jHK8L0FIrKA6XtVoZoWfV4=;
        b=irA+S4bZXZoWHyF734Fizthk5nL6P2J5MDRHXQWql9Iq0hkunO3uAMKr3GVZJh47oA
         PTrr+3riLeOOPiIkMwJyfytInut9W5XFMdqYYEB9jymGmWoEQ1sx5tfDAhUo87Mobvdc
         VktYibMjKaHp5nH6fBhftoTkerNoa+uwpOKb35ndyiJd4cRo1s+ZLWWGXyrtoE70R7nz
         T54ZFTxzpIb+qIOhemkjjoN4GIcbwlVjQLf+4mlXWadllVzZVWtrprJvLT7B0+MsCIHH
         dUqFTqU58pVBiWOEswYUnPxKI9Q5zBsO7jxsU2ie53wLEkU4fUuqssixycFkpDqdrt4W
         ve7A==
X-Gm-Message-State: AJIora/ME51OE9d1wT00htLuHpE3am4uE70cKdSOM6cK0jR5tmDN/4X7
        NRNwYfb5SPk22R3QfvMoulLnWQ==
X-Google-Smtp-Source: AGRyM1uB10BoPKt7+QWzG651HSJdXLFdfqX4sjG9itvbbMovPvxzB6k7N44z4ldjI/XCuJYdTWRHRw==
X-Received: by 2002:a17:907:3e82:b0:6ff:1e04:a365 with SMTP id hs2-20020a1709073e8200b006ff1e04a365mr8567135ejc.617.1656594349859;
        Thu, 30 Jun 2022 06:05:49 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f15-20020a1709062c4f00b007081282cbd8sm9124967ejh.76.2022.06.30.06.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 06:05:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: [PATCH v7 4/4] arm64: dts: qcom: sdm845: Add CPU BWMON
Date:   Thu, 30 Jun 2022 15:05:41 +0200
Message-Id: <20220630130541.563001-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220630130541.563001-1-krzysztof.kozlowski@linaro.org>
References: <20220630130541.563001-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add device node for CPU-memory BWMON device (bandwidth monitoring) on
SDM845 measuring bandwidth between CPU (gladiator_noc) and Last Level
Cache (memnoc).  Usage of this BWMON allows to remove fixed bandwidth
votes from cpufreq (CPU nodes) thus achieve high memory throughput even
with lower CPU frequencies.

Co-developed-by: Thara Gopinath <thara.gopinath@gmail.com>
Signed-off-by: Thara Gopinath <thara.gopinath@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 37 ++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 83e8b63f0910..1872fea04785 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2026,6 +2026,43 @@ llcc: system-cache-controller@1100000 {
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pmu@1436400 {
+			compatible = "qcom,sdm845-llcc-bwmon", "qcom,msm8998-llcc-bwmon";
+			reg = <0 0x01436400 0 0x600>;
+			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_LLCC 3>;
+
+			operating-points-v2 = <&llcc_bwmon_opp_table>;
+
+			llcc_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				/*
+				 * The interconnect path bandwidth taken from
+				 * cpu4_opp_table bandwidth for OSM L3
+				 * interconnect.  This also matches the OSM L3
+				 * from bandwidth table of qcom,cpu4-l3lat-mon
+				 * (qcom,core-dev-table, bus width: 16 bytes)
+				 * from msm-4.9 downstream kernel.
+				 */
+				opp-0 {
+					opp-peak-kBps = <4800000>;
+				};
+				opp-1 {
+					opp-peak-kBps = <9216000>;
+				};
+				opp-2 {
+					opp-peak-kBps = <15052800>;
+				};
+				opp-3 {
+					opp-peak-kBps = <20889600>;
+				};
+				opp-4 {
+					opp-peak-kBps = <25497600>;
+				};
+			};
+		};
+
 		pcie0: pci@1c00000 {
 			compatible = "qcom,pcie-sdm845";
 			reg = <0 0x01c00000 0 0x2000>,
-- 
2.34.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14E7519995
	for <lists+linux-pm@lfdr.de>; Wed,  4 May 2022 10:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346186AbiEDIVr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 May 2022 04:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346140AbiEDIVf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2022 04:21:35 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE07A22B3D
        for <linux-pm@vger.kernel.org>; Wed,  4 May 2022 01:17:59 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i19so1392276eja.11
        for <linux-pm@vger.kernel.org>; Wed, 04 May 2022 01:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=db4sc5OrkSnoCCAKUJDacMNlzRQIVW40R0PO9szPpSw=;
        b=KGe1IO2UQP6MpGQv+BVltLwD9dOiM7SMH1UbK9CnTQOl8t4b+rgRa096yc/0T7rmKA
         y4oqULZRKgXEJPdnA3ilr+g5cu2qvVA5dzvUCafkP9P707OmXoqXiEMtwAhajmTmt0PS
         KU/6xKMRuHuk9OIBNjRd9S3KDEJZWEC6AzacTw2JmJrfullQbhFYGNYdc9y2VrE8H/5J
         YHrzlSbNL9zKcrExFI4EZ86BsbykSMrQxsaWyQ0dWcmiIGEZzZDQipfsiZuLy/kWjZBG
         EHKb13kDDn51oBgLLUkxYjvTF49F7jioGbJWceAIxfNwjzcIooOE+UYYN27V6vJeY3vy
         GHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=db4sc5OrkSnoCCAKUJDacMNlzRQIVW40R0PO9szPpSw=;
        b=QrD+tmb8x79gwozkB2EvMSkaR5b8N+EpCo1rb9um/rqKDic5Jc6dOL2j4P1YEahlmP
         oS64pXcvyjE16Sk3UJ/RghxJM/zjs/J1hdDTHbOC9sTlfHFMeAElOM+BnO76X8vEzcMu
         s1wzpe9AZu26ZeRYaG7gLTLUfwvyCMZyA37A2bhoCPfXG34ihOAqn2X5HwlLrmvgt7yp
         0FGLJMjZDDvQ0Jnc3TB/PdyjAkSeD97l6qMxs/opfrvs8yy8Nce8zCxcOMNbfl7Pitbg
         aMOYihD0Ti+FhQFcsJJTnhEpiSOULkqKO63X/CVVPMyURJ/WGL2Gj4JxuR2tDttCV14M
         nIqg==
X-Gm-Message-State: AOAM532tyOHWf1qni8KK2Ofw/wP7OUeZxHe6Btf0Y87yXd0lK7x7gSEU
        SP6lOyTXYmk73glBiNTiE+TC7g==
X-Google-Smtp-Source: ABdhPJykdvNWku+TlTP7WoUCk8uQAX3gxkIBwzvlnxQzOMfyQc/XrabUiCA6VmEEOpKo+JqKj41WNA==
X-Received: by 2002:a17:907:7ea6:b0:6f4:9d64:8e20 with SMTP id qb38-20020a1709077ea600b006f49d648e20mr5150330ejc.634.1651652278223;
        Wed, 04 May 2022 01:17:58 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l21-20020a056402345500b0042617ba6393sm8781322edc.29.2022.05.04.01.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 01:17:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Thara Gopinath <thara.gopinath@linaro.org>
Subject: [PATCH v2 5/5] arm64: dts: qcom: sdm845: Add CPU BWMON
Date:   Wed,  4 May 2022 10:17:35 +0200
Message-Id: <20220504081735.26906-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220504081735.26906-1-krzysztof.kozlowski@linaro.org>
References: <20220504081735.26906-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add device node for CPU-memory BWMON device (bandwidth monitoring) on
SDM845.

Co-developed-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 60 ++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 692cf4be4eef..bd4577f0a92f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2026,6 +2026,66 @@ llcc: system-cache-controller@1100000 {
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pmu@1436400 {
+			compatible = "qcom,sdm845-cpu-bwmon";
+			reg = <0 0x01436400 0 0x600>;
+
+			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnect-names = "ddr", "l3c";
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+			cpu_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				/*
+				 * The interconnect paths bandwidths calculated
+				 * from msm-4.9 downstream kernel:
+				 *  - the gladiator_noc-mem_noc from bandwidth
+				 *    table of qcom,llccbw (property qcom,bw-tbl);
+				 *    bus width: 4 bytes;
+				 *  - the OSM L3 from bandiwdth table of
+				 *    qcom,cpu4-l3lat-mon (qcom,core-dev-table);
+				 *    bus width: 16 bytes;
+				 */
+				opp-0 {
+					opp-peak-kBps = <800000 4800000>;
+					opp-avg-kBps = <800000 4800000>;
+				};
+				opp-1 {
+					opp-peak-kBps = <1804000 9216000>;
+					opp-avg-kBps = <1804000 9216000>;
+				};
+				opp-2 {
+					opp-peak-kBps = <2188000 11980800>;
+					opp-avg-kBps = <2188000 11980800>;
+				};
+				opp-3 {
+					opp-peak-kBps = <3072000 15052800>;
+					opp-avg-kBps = <3072000 15052800>;
+				};
+				opp-4 {
+					opp-peak-kBps = <4068000 19353600>;
+					opp-avg-kBps = <4068000 19353600>;
+				};
+				opp-5 {
+					opp-peak-kBps = <5412000 20889600>;
+					opp-avg-kBps = <5412000 20889600>;
+				};
+				opp-6 {
+					opp-peak-kBps = <6220000 22425600>;
+					opp-avg-kBps = <6220000 22425600>;
+				};
+				opp-7 {
+					opp-peak-kBps = <7216000 25497600>;
+					opp-avg-kBps = <7216000 25497600>;
+				};
+			};
+		};
+
 		pcie0: pci@1c00000 {
 			compatible = "qcom,pcie-sdm845";
 			reg = <0 0x01c00000 0 0x2000>,
-- 
2.32.0


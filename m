Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0625601F0
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jun 2022 16:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbiF2ODh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 10:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbiF2ODP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 10:03:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA4C640A
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 07:03:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id fw3so5157808ejc.10
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 07:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tQRh0AY/h380Rf7RaIfP/jHK8L0FIrKA6XtVoZoWfV4=;
        b=Am0EqkwqnJ+nScjx0qimn2TpOAgLHVGbGcH0BWx2cVoMd0D1CKxBmAfxxBnPlN4ELQ
         VokscOphPWVRkZs9im65x1wrsgMdqytXPSLBK/NhFFzvUE/oF89/bYs8EIMMbGK4l3Qc
         G533sezxIDSqn4bxW6LkkiRc55kLYS/Q5wnngJoY8KphmGEYqHKOB5oPg8g2Nhpt8FSw
         c0ie7pwZ+Dl0ZvYgULSZZsARP3UcNaEy/4wB968Lx/UiR2kiHGx6Gug8N9O1QfbI1KYb
         Ngs3G46TuTr7qJSKwymAd69EIZHsfQGl5erTLa85M3nz9ca9U84cKYuo3mrDVk/X95gM
         2Rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQRh0AY/h380Rf7RaIfP/jHK8L0FIrKA6XtVoZoWfV4=;
        b=hUJA8o4kSdT+LYYW4vOWGezcPGnLPqF1gOc7mNKx9+FAuS4F7px0kNzuLwxY3+33MU
         STWx36GU4QB+Z6ticnSIY1XSq6U6OfwvsjAg9/9PJRfTMt93L09ToeZg4h8+1m5B/oEq
         wO0q9Xzcg2I0o446/2pXFxcO99KdQ/NbyczCgllLxd8GF7ValuRRNtevdlnG8a4jj0f4
         xXWNE1bwDuJrfMfPTReyqRZMYSG4h7HZPMlJBhX6GT3rnslcoJqyqhWkY7avI2Te2opf
         4hdop6tt3KmK9fY6S+0QxsXAvrBnEVvM6iSWet2HxjqB5r5Cgne+SMDEK7C7b3zczXFV
         wf1A==
X-Gm-Message-State: AJIora/75Nyb8Fx9xOFMkykTRhx9+9lQddxhQgr7uBor/ksCAyLyTIVG
        xoQy6UgQbvTk/MhdxdA8pymQbw==
X-Google-Smtp-Source: AGRyM1u6kqu/4/CGXf/PPcS4tuZ9ayEa1ehTWowPq+CmB/q5kkDZkH3KcRYC9QqinCpM8twU0WFJow==
X-Received: by 2002:a17:906:cc87:b0:722:fb3e:9f9c with SMTP id oq7-20020a170906cc8700b00722fb3e9f9cmr3463389ejb.624.1656511391664;
        Wed, 29 Jun 2022 07:03:11 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f9-20020a17090660c900b007262a5e2204sm7739260ejk.153.2022.06.29.07.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:03:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: [PATCH v6 4/4] arm64: dts: qcom: sdm845: Add CPU BWMON
Date:   Wed, 29 Jun 2022 16:03:02 +0200
Message-Id: <20220629140302.236715-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220629140302.236715-1-krzysztof.kozlowski@linaro.org>
References: <20220629140302.236715-1-krzysztof.kozlowski@linaro.org>
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


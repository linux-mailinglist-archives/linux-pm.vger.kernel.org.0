Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7C0583DB2
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 13:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbiG1LjA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 07:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237087AbiG1Li3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 07:38:29 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F97D68DF8
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 04:38:10 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id e11so1665209ljl.4
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 04:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i3pXhWe7F9oOinM5AqENivKksMTvJBPlQ9aYfvlTgok=;
        b=SIueaOtf2nQHEKtrGwBsEWEnweniJ+f87aB3s/OkORj3S1bwfvA6mVrvTKQdPYJwNC
         RYBMvHJz43J9CTOFDGNQIl6qreTXMDhz5oVVfINrp579CTlEGclzUJdwsJIO92PYbBfS
         F1hbhxa6jKjEVfYSiWgmQN46h2zUH0hvV785IHgrusfQ/WebV4yTgRrQ+S1K9Ov4jl9P
         1AZx7U+ejN+tqFSmAaQoFIRo8w5n4Z8gGCUZEfzxnC9FYSwguvMmFhi2xXheC2JCz4k6
         dqfZ+EV8CmA+n3kSci3r2p5RcYuj2o9JFffbzY7Zxo2Pg8xRnmyfs/iX6QLX+QOjsFsy
         dwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3pXhWe7F9oOinM5AqENivKksMTvJBPlQ9aYfvlTgok=;
        b=qjCV5C47+MT22M69/cB3+hvUKn56c635D1q8JShr9UilWoahk6Z6KznkQkon2NbmwQ
         wIgobeooXDDeanHgugSdMFzmk4MbqWmCAqyQ8hLBOTh7jxfLfDSdImW4C1aDjbRy8ZQz
         Xe4KD1MB7NWnpxUuo5sljCn0Bj9ifZDnIeNNknDUgw4ldcsU3kd2+/2ZxczsU1NhK1XK
         T3cjyGKgGrxQvqA8gFO5JXfM+u0pVbrXD4HzjvdgeKLT2wOM42Op/14ZgDICdNYQhW4k
         xKA90ApTAFGclxoNX/Ajl0QqGBh2Yh0suFQppzok6PbmnOcdFIBeRnMIbggRBBOjRz8y
         2PiQ==
X-Gm-Message-State: AJIora+YpbchKt6OP4y3zb5rWS74B4qNulPsUbw1k3XMQ1dMcF06iuVJ
        GIjPGQd+eXLcDML5HVEDiLwOYA==
X-Google-Smtp-Source: AGRyM1skFmBxWLp/tFnapm7KNoGg2rYhpOq/GHWZX5QvOt68rJbKLI/PlYfrLLADmwITxtiaboTdWQ==
X-Received: by 2002:a2e:b8d5:0:b0:25e:18ef:bb57 with SMTP id s21-20020a2eb8d5000000b0025e18efbb57mr3917294ljp.37.1659008288328;
        Thu, 28 Jul 2022 04:38:08 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id l12-20020a2ea80c000000b0025e0396786dsm98192ljq.93.2022.07.28.04.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 04:38:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH v2 11/11] arm64: dts: qcom: sdm845: add LLCC BWMON
Date:   Thu, 28 Jul 2022 13:37:48 +0200
Message-Id: <20220728113748.170548-12-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220728113748.170548-1-krzysztof.kozlowski@linaro.org>
References: <20220728113748.170548-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The SDM845 comes with few instances of Bandwidth Monitor.  The already
supported one monitors traffic between CPU and Last Level Cache
Controller (LLCC) and in downstream sources is called BWMON v4 (or v4 of
register layout).

SDM845 also has also BWMON instance measuring traffic between LLCC and
memory with different register layout: called v5.

Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 37 ++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index e318c3f8aee0..6ae0288eb384 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2053,6 +2053,43 @@ llcc: system-cache-controller@1100000 {
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pmu@114a000 {
+			compatible = "qcom,sdm845-llcc-bwmon";
+			reg = <0 0x0114a000 0 0x1000>;
+			interrupts = <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
+			interconnects = <&mem_noc MASTER_LLCC 3 &mem_noc SLAVE_EBI1 3>;
+
+			operating-points-v2 = <&llcc_bwmon_opp_table>;
+
+			llcc_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				/*
+				 * The interconnect path bandwidth taken from
+				 * cpu4_opp_table bandwidth for gladiator_noc-mem_noc
+				 * interconnect.  This also matches the
+				 * bandwidth table of qcom,llccbw (qcom,bw-tbl,
+				 * bus width: 4 bytes) from msm-4.9 downstream
+				 * kernel.
+				 */
+				opp-0 {
+					opp-peak-kBps = <800000>;
+				};
+				opp-1 {
+					opp-peak-kBps = <1804000>;
+				};
+				opp-2 {
+					opp-peak-kBps = <3072000>;
+				};
+				opp-3 {
+					opp-peak-kBps = <5412000>;
+				};
+				opp-4 {
+					opp-peak-kBps = <7216000>;
+				};
+			};
+		};
+
 		pmu@1436400 {
 			compatible = "qcom,sdm845-bwmon", "qcom,msm8998-bwmon";
 			reg = <0 0x01436400 0 0x600>;
-- 
2.34.1


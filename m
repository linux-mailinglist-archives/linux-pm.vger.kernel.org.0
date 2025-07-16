Return-Path: <linux-pm+bounces-30899-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACE6B0759B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 14:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16E5F1AA5FAD
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 12:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AB92F5318;
	Wed, 16 Jul 2025 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jylo+3qD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECDA3C33;
	Wed, 16 Jul 2025 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752668768; cv=none; b=aA+66WjfuF1F+iw2B9U+m/Svcoe2bvzHHmECBv/Ug9qN+wOwk+Qezbc6fIQyScyKHmOYrdlMrM8tN7ndknn/nNhrgdHhs9nDmi6dIkUpEZKrXgLWinjMp9rWrXTYBMyudutnvefBZcMqDWH9XIGL3U21yY6XGSM9/ipPk+Mg30E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752668768; c=relaxed/simple;
	bh=dn9lR5FWABKGVpMTuPc0ddrkqUBlRT4kbmz/swpsa7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eOCYZeJuhwijg8xQ5u8V8apzGhyLSj5/WMgUbyogYKgExxnRZrxosxZKWLlTG416ldLkF4tQk5/F7C5St6TkJVASEVlaD+gaBWw9zPL+aTOn7Qf+kRgib2MykWbHiRbAOYLkBra5v5qt4rCJN+VfbZRMi7vWiicTloNyZgQyqjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jylo+3qD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1195CC4CEF0;
	Wed, 16 Jul 2025 12:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752668767;
	bh=dn9lR5FWABKGVpMTuPc0ddrkqUBlRT4kbmz/swpsa7w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jylo+3qD3WArU1Lqq0T6oQ3z6pUn9mKIbXBUndV/chkQCtxJXKY9ggUGyrT2UI9AQ
	 8CKn48/vBocOnzLKUOJjoOfoO+juTMrmIt26yS4zx7PaT5MWzHTQQ+4h+CcEPpgwgg
	 fw4uKMI7Al5ZEZvmT/89LINr5O4kY3G+mbt8nX3/5elVrFfQlXtt+vh7h0Hej4j7Gp
	 HIAF9yfdaEFhFTgQ3dpoJQTCGn4JY8ImT4sx3Vatwi8CF7jzE6MZtZ+UKflMijukct
	 2OC+ZdUuuPf4xNnXIjUkCujrgWoe7bngRz3shHdUS5NdyMEceqwX5ZM5Q6i4tMkp1v
	 XWai4p1m4HuCw==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 16 Jul 2025 14:25:47 +0200
Subject: [PATCH v4 2/2] arm64: dts: qcom: sm8750: Add BWMONs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-8750_cpubwmon-v4-2-12212098e90f@oss.qualcomm.com>
References: <20250716-8750_cpubwmon-v4-0-12212098e90f@oss.qualcomm.com>
In-Reply-To: <20250716-8750_cpubwmon-v4-0-12212098e90f@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Shivnandan Kumar <quic_kshivnan@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752668753; l=2579;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=e8Tn4SYV5rKK6nevRmqForcihoYnzFXcnwD9VcRt8Vo=;
 b=uQEzUOG2aIHL2x81JLh00rLpD+I6cI0f20ZjNGGXHkfegqdeMHpi7BQToPzFbtYde6W8/aELe
 WLFb0aXn3NAAIf3Y3wADzEtg4FJPjQtAcmCx/NiD0CNHbxAA/DIddj9
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Shivnandan Kumar <quic_kshivnan@quicinc.com>

Add the CPU BWMONs for SM8750 SoCs.

Notably, the one related to cluster0 requires that it's mapped with
the nE memory attribute. This is specific to a single instance, on this
platform only and should not be mimicked elsewhere.

Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
[konrad: add nonposted-mmio where necessary, re-sort nodes]
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 76 ++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 4643705021c6ca095a16d8d7cc3adac920b21e82..79ca262f58115ccc4b0bd91d4efa75715e2b7397 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -3617,6 +3617,82 @@ frame@1680d000 {
 			};
 		};
 
+		/* cluster0 */
+		pmu@240b3400 {
+			compatible = "qcom,sm8750-cpu-bwmon", "qcom,sdm845-bwmon";
+			reg = <0x0 0x240b3400 0x0 0x600>;
+
+			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+			nonposted-mmio;
+
+			cpu_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <800000>;
+				};
+
+				opp-1 {
+					opp-peak-kBps = <2188000>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <5414400>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <6220800>;
+				};
+
+				opp-4 {
+					opp-peak-kBps = <6835200>;
+				};
+
+				opp-5 {
+					opp-peak-kBps = <8371200>;
+				};
+
+				opp-6 {
+					opp-peak-kBps = <10944000>;
+				};
+
+				opp-7 {
+					opp-peak-kBps = <12748800>;
+				};
+
+				opp-8 {
+					opp-peak-kBps = <14745600>;
+				};
+
+				opp-9 {
+					opp-peak-kBps = <16896000>;
+				};
+
+				opp-10 {
+					opp-peak-kBps = <19046400>;
+				};
+			};
+		};
+
+		/* cluster1 */
+		pmu@240b7400 {
+			compatible = "qcom,sm8750-cpu-bwmon", "qcom,sdm845-bwmon";
+			reg = <0x0 0x240b7400 0x0 0x600>;
+
+			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+		};
+
 		gem_noc: interconnect@24100000 {
 			compatible = "qcom,sm8750-gem-noc";
 			reg = <0x0 0x24100000 0x0 0x14b080>;

-- 
2.50.1



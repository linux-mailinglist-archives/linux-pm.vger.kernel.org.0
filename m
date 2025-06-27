Return-Path: <linux-pm+bounces-29700-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BC3AEC01E
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 21:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C832C1890AC4
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 19:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A8421146B;
	Fri, 27 Jun 2025 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmMunYD7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382F320B807;
	Fri, 27 Jun 2025 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751053114; cv=none; b=eYFPsSblj6nyzkc3wUzPEIZBBBYdyy6DMtTU9HUFYNN8Bc3mkuZSozBE2C6+7TJN8+q0hZX4wGHaou2DcjJtTHYFbA3Ds/Wi0JStie1m5ZuwJwGar7uaif9YwLA9zgZHcep+t2/zTVN8bbPVcOfU+HEMl0ypT3+IpUveu26kS10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751053114; c=relaxed/simple;
	bh=Z4bXk+K7HGhcZ3jRRdhi+bm00lnqL7iBbZ8AYPfHi2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SRzEP/MnDYh0lSwU1Ly7e7A1fVoYWef4AJgw4PNSPiDOOsLTtiJF/1+TNgZGS4dESHgQGrCbSPQzayuVQUqL5qg4fvID+ClIc1ZpHjs9i4xQYMb+3Qo5QxY7HxaGx7wR4aJoKXiWSmqDp2fFRdwayfKGwI6p/oKk9K9VsIzWzxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmMunYD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A66C4CEE3;
	Fri, 27 Jun 2025 19:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751053113;
	bh=Z4bXk+K7HGhcZ3jRRdhi+bm00lnqL7iBbZ8AYPfHi2U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GmMunYD7J5wygdJ49HzPugaCH+fyM0eA4hXfzvOJO2c30Tv+i/WjPKhbJcTgQxwcp
	 +lzZN8Fi/cCYFpcN6pHPcHaye8wYN10aNV+KQ9EfgaWS+hQIl+8l5oq7XNp1qK7orY
	 XC05BT9f6cJAuND7ccbWOm4c0DLwmAswbLHXgqhwHrK4syXoiY/hK57k4aIAzv/wJ/
	 xMGpM+dKr7PXHRGWVq7btxw4m9V5c8SsQBJHUPxEo+17FNcE9Iqo1d3ijdA990KAbS
	 GD5xjqR9TUIlA3LTbTZ/90H9LNtLSohBFrncj9zf9NRxqMIzlhKWXKzpyGY/BJYLq0
	 95A7A6R43hyaQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 27 Jun 2025 21:37:55 +0200
Subject: [PATCH 1/4] arm64: dts: qcom: qcs615: Drop IPA interconnects
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-topic-qcs615_icc_ipa-v1-1-dc47596cde69@oss.qualcomm.com>
References: <20250627-topic-qcs615_icc_ipa-v1-0-dc47596cde69@oss.qualcomm.com>
In-Reply-To: <20250627-topic-qcs615_icc_ipa-v1-0-dc47596cde69@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
 Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
 Taniya Das <quic_tdas@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-clk@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751053092; l=984;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=NDq6uJfiYMdlz/SdTL7UiQwX4Kzji9ugdbh4tCSUIf0=;
 b=AY1AFmBxuY3yEmOEJ3eLhamGO+nnaosSv59PBGfOe7QrOoDdxHFpy0voY3ntP/oWkhlhLIjwA
 Q+a1r0/hsPKDn0HlZWCipj3GyV7SHcKhHpG0Rpm+KM6OkIe++OiZXwc
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

In the same spirit as e.g. Commit 6314184be391 ("arm64: dts: qcom:
sc8180x: Drop ipa-virt interconnect") drop the resources that should
be taken care of through the clk-rpmh driver.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs615.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
index bfbb210354922766a03fe05e6d117ea21d118081..b554471175de88fd96d12dd5183ee9bf61532bbf 100644
--- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
@@ -320,12 +320,6 @@ camnoc_virt: interconnect-0 {
 		qcom,bcm-voters = <&apps_bcm_voter>;
 	};
 
-	ipa_virt: interconnect-1 {
-		compatible = "qcom,qcs615-ipa-virt";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
 	mc_virt: interconnect-2 {
 		compatible = "qcom,qcs615-mc-virt";
 		#interconnect-cells = <2>;

-- 
2.50.0



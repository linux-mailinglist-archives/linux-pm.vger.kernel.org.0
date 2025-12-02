Return-Path: <linux-pm+bounces-39094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373F2C9C6DF
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 18:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E643A7E30
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 17:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE62C2C0F9C;
	Tue,  2 Dec 2025 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1WslJjW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713EC2C15A8;
	Tue,  2 Dec 2025 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697016; cv=none; b=nODdp3suTnxh2FYPQijzpOzO6lxEoN9Mr88Kobcm/upTBNz4fiPobMIfw5Gni1s4dBg/QZj50Acz5mZC6I5wugAoNjcEyUD7IS8ZX4Y7bxy5TJceNMcR/2Gi0lGyOjpBiKjf65s8palnnocEWmm2LxKqTQBB71qD9WwPYV7MJJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697016; c=relaxed/simple;
	bh=Osd/+dLwf+emrEqGi6mbQhzltUndMTaIVjgBdIIWp50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ou2p7Bc4xEzyIxEShDIE4sLRBGCHoGMYx7983cwhMFnem5MT1ccADDScxGj2zrDvNv7W6LKiOhe7zKAZoPQXtImuek+v3Iss9XZcXNhWkB3RIdWRZ+lv8hJbYnQY5UUZBkYmkHKAkWJSP/GG1TuAm11ykZ/d5mnVzN769/VcmfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1WslJjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9221EC4CEF1;
	Tue,  2 Dec 2025 17:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764697016;
	bh=Osd/+dLwf+emrEqGi6mbQhzltUndMTaIVjgBdIIWp50=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A1WslJjWIMyM5vgqXkEtiXzs833daXmlxw86hBQr/I6UyG22zGQQ9KgeoHrpEOq3j
	 q1Hs9f48I3djiAQO/sFxgUgH5vYWQZU+pDsXw+XeD7KQQsbFuu9UlSJbIj7h3zZb0O
	 XW9bgEoqluMwtSFqzdK2O+goiAgSX1ive113jGhQwW0RUxLIQMncPy8xbIBUU3A76D
	 FGmD86Qv7VN0OKqpnzKw7ReG7CjUNkBok1l/4Tsgowq03qs+QEI3Mdhu1QFbIu3tXs
	 SO+3bXgJ/GmXlevmywcZmU2c9dGItFLXgUULjNtMN9CokV1XQTK+UhWa0jEQRo7ecB
	 0QrpwZtm1HvQQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Tue, 02 Dec 2025 18:36:22 +0100
Subject: [PATCH v2 3/3] arm64: dts: qcom: sc8280xp: Add missing VDD_MXC
 links
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-topic-8280_mxc-v2-3-46cdf47a829e@oss.qualcomm.com>
References: <20251202-topic-8280_mxc-v2-0-46cdf47a829e@oss.qualcomm.com>
In-Reply-To: <20251202-topic-8280_mxc-v2-0-46cdf47a829e@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Imran Shaik <quic_imrashai@quicinc.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764696985; l=1420;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=HYXtOMvv9i2sz5XDKARcwKlUFUyXuRdAodCPiWpvS/I=;
 b=YMQLwFmNHWSjAyFuLELvapYGWcZRaa7QaCineg3voyWrqcYnLgZ4tJTB0vDh0mlgPKa6k7ttn
 pADbJclsiZJBBzbz/yvjrbdqJ6Sk0tDqOmkrZUenlWV0fLtWeMfxcox
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

To make sure that power rail is voted for, wire it up to its consumers.

Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 5334adebf278..b9e0d9c7c065 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -5788,8 +5788,12 @@ remoteproc_nsp0: remoteproc@1b300000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SC8280XP_NSP>;
-			power-domain-names = "nsp";
+			power-domains = <&rpmhpd SC8280XP_NSP>,
+					<&rpmhpd SC8280XP_CX>,
+					<&rpmhpd SC8280XP_MXC>;
+			power-domain-names = "nsp",
+					     "cx",
+					     "mxc";
 
 			memory-region = <&pil_nsp0_mem>;
 
@@ -5919,8 +5923,12 @@ remoteproc_nsp1: remoteproc@21300000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SC8280XP_NSP>;
-			power-domain-names = "nsp";
+			power-domains = <&rpmhpd SC8280XP_NSP>,
+					<&rpmhpd SC8280XP_CX>,
+					<&rpmhpd SC8280XP_MXC>;
+			power-domain-names = "nsp",
+					     "cx",
+					     "mxc";
 
 			memory-region = <&pil_nsp1_mem>;
 

-- 
2.52.0



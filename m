Return-Path: <linux-pm+bounces-38508-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B765C82963
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 22:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BE6A4E38D7
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 21:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C4F330324;
	Mon, 24 Nov 2025 21:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gg+twld5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E635332FA09;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764021219; cv=none; b=ieqjYvh0IY0HeG9Tygo2H8z/0nqvdrV/xmZswBGch5WzdyHA0rgXivF7SXJzQemNBkVLM3+ahHrjne+HX4hfGrWljecY/49Qa8PW2Nfc8liegQ1nGx9MqRr20zGo++GaKHqEhT3YB0GrNqdwJkLhHUekgm6ttWJ15uoh1m4qpfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764021219; c=relaxed/simple;
	bh=Al8V6HMtter/SRb4oyaFfSbSGkkMcZGStdBXyd2IwqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fEHnSi8fHQ0gUgI/beujrD6FH8E8LbC1vWxNrl4fflhErTs30K1RdwPyDIlwnWzjBACp0ng0Nk6XOila5YO07gaOcOk2BmvWgjKUJFbGIGZj+P5uGGVoPkWi4gSpQ5B8cIX4FFIVu7xokGBuXpvDDWTMzTuYOVnb8K/VV9WbJAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gg+twld5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55150C2BC86;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764021218;
	bh=Al8V6HMtter/SRb4oyaFfSbSGkkMcZGStdBXyd2IwqA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gg+twld5v5M9s/bv4OWHbveKTeyDju91JqQ0QKBduHYRzfHCtYlq/A0TZAFCE7EiR
	 V5046dhbhMR+/U8ENbt0lUuh/z56dl5CTCVgXlHdp8CJcU71BSZpZ3FRmdd/B187st
	 RVYXPD6wyS1+ZEf9xsyuj/USGD/QdR9BT80THIAMhRCaD/6rthMhI3Q07aJ0y4w1Zi
	 wPN86CJUMUEPgyEWfVa+O/4uZ0yxm+X2oY/2P7bHwca0ngZJi/g1wptKqjcy1d3RT9
	 dxywfpxAQPsybmaS+m3PcrnkVxnN75lo7TdfcCLyBkVAnkbkDgEFY8CmeRP4Wcim7D
	 a/BAX+Qa2TR7w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EEDCFD362;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 24 Nov 2025 22:53:36 +0100
Subject: [PATCH RFC 3/8] arm64: dts: qcom: pmi8998: Add fuel gauge
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-pmi8998_fuel_gauge-v1-3-dd3791f61478@ixit.cz>
References: <20251124-pmi8998_fuel_gauge-v1-0-dd3791f61478@ixit.cz>
In-Reply-To: <20251124-pmi8998_fuel_gauge-v1-0-dd3791f61478@ixit.cz>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Casey Connolly <casey@connolly.tech>, Joel Selvaraj <foss@joelselvaraj.com>, 
 Yassine Oudjana <y.oudjana@protonmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Alexander Martinz <amartinz@shiftphones.com>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Richard Acayan <mailingradian@gmail.com>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=802; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=3NH+XDRf7boZ2ZmNb3Bl1vms6aKp3xOCdIZF3YQ+0F0=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpJNPg55+d8XT532qjbGQqchmayDZA+eMWof6+X
 UhVu69VKuaJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaSTT4AAKCRBgAj/E00kg
 cmIkD/9vn0ydEfm5TSte0rhonIcjJ75d0IPSoApYAqj7a0JXnks5F8oeRsqXevA4dWjzJTEtsr0
 8TgfpB+I0TaPlku/gG+ygcXN0KZ8C7BCKChSQFeh2pFuVxjNgwCmdGUvz+Yl8+lGYO8kb8jooa5
 ZzNU50kl8IaOvj/xv0U6urmvutjMPugV7x+r7XpCBO3joSPKWSVOvBx6YBJhZiS1Yp2Ywxupk+B
 sCRSpA82oUlEnQxrKDNMSXXgsTs6j6u69slgRAjQJkSRKJdI0dpEEGhe/wuIYfQhQSujLCENPb5
 fdELrOegE8b2Gd+tS/rIItpdZRTSVlDWFl+fGRtAMc+Z+IrJAEDAqDjIIM6Gl9fL/lsVwP7YqB3
 rVmgagRgM4sY0aBl0zLkYYmsywAFPezUSk3BeKyEctfWX3y61GbvxdezPzBOon2+3VRXpBa5h0y
 N4TN4BNTXnWMzWczO4SVnDxUUiYAObJzBin7k12eFsgLWN3POw90lEkcg3ef7v+0d0KJnUkSS8O
 bNnkdfwcJQX1lZ9gQymokImssKfZTiHCoNfIkXZVy9e/44aiJROOgMNZ28KSKtJYxzd9LEMefTS
 RCBEJAk439MOb6MD3ha7wGfKOwuJJUMaTg8siYfipF3QOBAY2dGM06QK+XOsKp/PCYnW7QMgFWM
 aRBL+N19XB5s59w==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Casey Connolly <casey.connolly@linaro.org>

Introduce the fuel gauge node for pmi8998.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index cd3f0790fd420..ab3bc66502657 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -44,6 +44,17 @@ pmi8998_rradc: adc@4500 {
 			reg = <0x4500>;
 			#io-channel-cells = <1>;
 		};
+
+		pmi8998_fg: fuel-gauge@4000 {
+			compatible = "qcom,pmi8998-fg";
+			reg = <0x4000>;
+
+			interrupts = <0x2 0x40 0x3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "soc-delta";
+
+			status = "disabled";
+		};
+
 	};
 
 	pmi8998_lsid1: pmic@3 {

-- 
2.51.0




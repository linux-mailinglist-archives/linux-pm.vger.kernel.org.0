Return-Path: <linux-pm+bounces-38510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 246EDC82978
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 22:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B954B4E3927
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 21:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB19330D22;
	Mon, 24 Nov 2025 21:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtCX7vl6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C93132FA28;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764021219; cv=none; b=aPnoSkh3i1Ntdga5tG4swRueMqVJCT57TQ8L7+GHoGBY8eh3aW0YzPItXWyb4XWF3V3rHIEZHjI7tku9pdu+LIxJDCURbEBMPrhp2ztlfmTbf+pLI2PW9M9r0ulRayqPxA6NXwxnkCthF1/cTrhgcW/o87T8yVLR9pPn1B7k1Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764021219; c=relaxed/simple;
	bh=ZTO1VmzdNMhc0BgtZT7Hj8ZjO+FqcNP8ddbdak5mk8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tT9JWrqaiREe5ZXzTJwFZ2pzfvUN0UKeqWiPugkZUf+RMNNh1q5iX5IdjxhACDnY617tq4hu84rKoDcMoDP8opADmeINaTv3fhZM4bKMnyjMQ/oc5zn3xSXJj5wQf8sKyx248qQ+OHyQjcIC8gLuNb9YwqNUH+mxguO0L5BZEwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtCX7vl6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EF5AC2BCB3;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764021218;
	bh=ZTO1VmzdNMhc0BgtZT7Hj8ZjO+FqcNP8ddbdak5mk8Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CtCX7vl64L/SyNYYkXy2lahWjWKAyJJqRszZ7gS7N6yc3CGnGAdSLu5y0dg/uf+BO
	 1b4gk3MlupU211UTs5PXy501V0lTw5LOmEKV4of1+fPrTKsxPcCEEWwWueyMXCdVbL
	 KHNnaTyZp0DRYC6Utz/7QeUIJKn9CRNKqks9JeHwT8Btxo5+2gcWnd47AlkHMJeupd
	 09pcjfp0Jk0DMG7ercerAe6MC2McdLfpkAXW0V99QwIanDgp8iW6MDvQz8q2A7LJSA
	 LKae3AIvMGlkimHDJnmWC4GzqCW8qNGLfrIbegK+WubLhtGJ5RTHGzPFQ98Cwr7Pbb
	 QJkYlFkvMqGeQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F6ACFD35F;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 24 Nov 2025 22:53:38 +0100
Subject: [PATCH RFC 5/8] arm64: dts: qcom: sdm845-xiaomi-beryllium: Enable
 fuel gauge
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-pmi8998_fuel_gauge-v1-5-dd3791f61478@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=864; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=Re+K+Vl4ZWKmEaGB1PbuYTeVVGS0LWdIYqQ7l+1dIAI=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpJNPgfC0P7L5HwD7n3cXr0nX8wAQIe/gu8Sdt7
 OSfwTLO7yaJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaSTT4AAKCRBgAj/E00kg
 cqOVEACA6gKbkiaPb7CMA/iUgj6STdqPRAi/V9BHUqxSlKcWhjlcnzSqhhNWe0SzqqFeSmi5Zoa
 yt17IyjfPUm+SLoWvtCklMerADVx7pIrEq8gVf1dWwVKNtAoz3IHr6v0Z2DHMNtYcSmrhWZaaB3
 DZ9/y3itT1ew+3eICVmS3+CtrELd7MeZ19dwFfmIXbpnpBtpWeeLo+sCREzlbWDNx8Jlq3Nk1qO
 BylNY1pwf/4v8R5NnMnHsHYMEQyzOwZKUv28e6afb37Bnmptng6+WcTUUSyyIE/08n3g+pkince
 yNtCJADoNXolSNGXHM6pF64BX9G5iQoC8yQdP9zoqck2PyvLhQnVzoIU+L5tfb4lofile53BpGS
 oIBj6Qzaz5zMNImMaIr28ykDwQ/0nThRDk0VhZkSY7BIIvFiES/sX3YE5daeCbJ3W/S8TySupKs
 GQeaKxjy51vSHu6dFauPL1vKMi/JeSacJGzKiPzqTitQK+QDWsJMiIJNUfy1q69TUP9ZdBPe6ea
 WplkSMec+9a5hb3zIxvFllZ2Ve8qhwDuRX1kaoqnx6PzutPbOctUMs2HUswVOrfVVn/PPH6qCbF
 hpeMUDWkFaD4c2APyPQ7asaf9T1K6XHbi+uBOfFKsts5kJOfXAie5IueYfI1f/3F23o3Q8VCiCb
 sPmizpjdlI0Wgcw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Joel Selvaraj <foss@joelselvaraj.com>

Enable the fuel gauge and configure the associated charger and battery.

Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index 785006a15e979..bb6448f4e036b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -377,6 +377,13 @@ led-1 {
 	};
 };
 
+&pmi8998_fg {
+	power-supplies = <&pmi8998_charger>;
+	monitored-battery = <&battery>;
+
+	status = "okay";
+};
+
 &pm8998_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 	status = "okay";

-- 
2.51.0




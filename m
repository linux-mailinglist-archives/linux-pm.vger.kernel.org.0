Return-Path: <linux-pm+bounces-38511-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBC4C82972
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 22:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57DB3A8BFD
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 21:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01765330D51;
	Mon, 24 Nov 2025 21:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RO5CXKCO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D9332FA31;
	Mon, 24 Nov 2025 21:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764021219; cv=none; b=gvIcQjclTayDs1JXBvaC7AJgvliFOrpRhXOxX4MApS8Rvinxth3kVKbLiAH/Ynybqm+Udzfw5BwBcEc2ctu/FkW0QFJlvT6/P+lxETp9fsSFhz1Ov0JVW/SPQTsBZRhoTHtpGRTSx8/iIAgknYdZRm0cldb2hUCOd298pO4tjjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764021219; c=relaxed/simple;
	bh=iNnu8NdOtVkVeXBIGUy+//lZW2PoS4dtCcSNdHnk5KQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UdFvZGnLuGfbgENbkW0Az5NZVGP40KG48ZjrmvU5K8hZW+oJEpuXjdAnXir+g2i5fWOp0JxTtO7pOUDyZHfFpTiAcd4N7zMbVArgR2i6Dw7oZia6Jgki+RJjscY4dXlh7NoLVQNXArBTSVfcaNa2OtUutETQgkX0zVXB8ZQjUVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RO5CXKCO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F422C2BC87;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764021218;
	bh=iNnu8NdOtVkVeXBIGUy+//lZW2PoS4dtCcSNdHnk5KQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RO5CXKCOC8cYEMuH61U9QH3lvY8aOdQDaEauJxwGURZJasL74yl0GNfQ6UHy8WMkP
	 iZ/71tegWrQD2lvRURWXOgHzpyCweaeBrZUDfODvXie04Gqf0DO6gM8Ygjj7IMtLKT
	 TLA+yIxM6K1n3v/Fvayj6t2S5xNyC8IRw9Y07fJ4aEchUrFZheaYqPas6IeEsc2HA+
	 SWk1UZrz88ANVtYvAQwvJGk0IdAxlC2boxGG63Zq98KHjReNoaluYNV74q7LUJraaf
	 /lUeelt3aKlyxJ0mR55cTy5WaDSJMorAUgVeeqDVKGEiU7Yc/ZDMPNKPsOl6Xbn1S1
	 sIgoZEkBcEY8A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C18CFD364;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 24 Nov 2025 22:53:39 +0100
Subject: [PATCH RFC 6/8] arm64: dts: qcom: sdm845-shift-axolotl: Enable
 fuel gauge
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-pmi8998_fuel_gauge-v1-6-dd3791f61478@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=839; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=rWr9w6N0g0uoz/ni0a7604nlr6yXoa+VTp7KmyJxlrg=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpJNPgFlWsPm3iSNWe01qiE1zdx1ltKOFn190HJ
 Ko0UM3Acv2JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaSTT4AAKCRBgAj/E00kg
 clyfD/97XwPy2exVdqPOI880Z1tW0zR9atPBY9VnosC07OH1VVQcky95MsrBcCE/fBhCW8aX7nj
 RCOWtBkbF5zvq7wYDMQK36Y9VlXLgCdLDTGzWdF2rHsYgKNX38QqarS+H4ZsSF1Cm99ZDCoxbYd
 meBvz/QARBVI6tbe7kZlRoGw1koasx1e666/IrVD7LxmnmwttuMHw6DIUiFqwOXyhUMZ2eVMS+y
 mUjtlm52nsvAbIqjJKNAjjVDvZTsPOr5kFQeKEVnJSYkrZT363haXBlm4ej6j9KjoyO+iij5jOE
 i5pnBtu/RU9IHSyqmeYK+JkyPLJJEeybhgXpB0Y5lP/iVmJUm4ULWXo95vM3yJROdrbxyMX8IGi
 PXP1bfG7Q1Mu44WghOg9oE6c9Gx0GGhJKwF4h3Y8aHqrUwbbA2k+m9vj5+/a4WRLGAdhctrpBTm
 nrVZ67rqaVGJnpBpdsd0NUnon9j9deQo3beU7q6wXl84gavQ1Ab+Og9/89oya9TgSM4d0ObMHeq
 3k/D4Saa3SACtsZht6Pbs6XQnVeVc0OC8y7i55pQwBrwPR3CPmPkIQVcGPZvv4MLA3TOxxvgogM
 pPdAu59AadhcElCCa42nKLdlLJfJk8Z9F3VFjE02PAYMBIcp3zhbdvZOISrAKzlwa2uRO5jGbI4
 YAQe9Eatm5bGZbg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Casey Connolly <casey.connolly@linaro.org>

Enable the fuel gauge and configure the associated charger and battery.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index ddc2b3ca3bc57..f1fea39972e8c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -524,6 +524,13 @@ &pmi8998_charger {
 	status = "okay";
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




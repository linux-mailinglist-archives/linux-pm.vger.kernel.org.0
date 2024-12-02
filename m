Return-Path: <linux-pm+bounces-18350-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EB69E02E3
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 14:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE33167853
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 13:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AAD1FF5FB;
	Mon,  2 Dec 2024 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpOC24Xg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E165D1FC7FF;
	Mon,  2 Dec 2024 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144902; cv=none; b=Z2Yg72YbgtnLrPgMp4CdOxoVVvj3CWY3c9vDzBBmrG8CL8IDGNf6HdhKftU7NP78hYdm7ZN0ziUya0Gz3zy6x9mp877Y0zbF1VWWLazKiHC2Nm/JRPsjKlwMatpyzbe/zLd//n2DQu1Vkvv1fdfUgyBWwRRTU5ODZbqjvJ2snGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144902; c=relaxed/simple;
	bh=cXYTMS1lyw5zl7xOiAP9Dpko8FpjZMGOckLkVavurEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cSIrrz0ZyW24BvN1vGNGpEWmvMi0Ybp0GyEAYsikFAvjauei0DDHPsAwWlEu0fVT/woVrTkvQCbIMmnS8Uf/o+JR2KBEjUeioQio4GC1mPIR4Q302m+0TnX77tizkMKMNlsor0A2kjLL4JSruLM+f13NYX+jAAswR9gmpYDrYe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpOC24Xg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 842AEC4CEE3;
	Mon,  2 Dec 2024 13:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733144901;
	bh=cXYTMS1lyw5zl7xOiAP9Dpko8FpjZMGOckLkVavurEY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cpOC24Xg4W2ndtFkgwlm2AeF9Yv90uBvHYCBgOEVjUSZoXYzT15uHj4BRFhtcBvpG
	 PyJWebaESQNK8jDU4t5yhDnx7uKrxjWLU96//NUXRfcJV9LXtcuP1q4heINdpaAuLT
	 hjEFXKRJP6m14j9WvSPX0TPJm1QYXJ4EFY+dOB097McQLMYqt4CHui5rfZcoXPtWFd
	 5ubXky7WfPDUAxPQyNRk8m4jzKRNh0mE5Zvzq1hncqxUJKrf1tAfL07wn/oraJfZCx
	 EGcNscCJmdNaKvRRf0y4h8ktQdn8iJaHgfnfEa9N0JaKKFm6lYnoH2GCH7rr4IrX2/
	 UhLTom6hIMyUg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA05D7831B;
	Mon,  2 Dec 2024 13:08:21 +0000 (UTC)
From: Thomas Antoine via B4 Relay <devnull+t.antoine.uclouvain.be@kernel.org>
Date: Mon, 02 Dec 2024 14:07:18 +0100
Subject: [PATCH 4/4] arm64: dts: exynos: gs101-oriole: enable Maxim
 max77759 fuel gauge
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-b4-gs101_max77759_fg-v1-4-98d2fa7bfe30@uclouvain.be>
References: <20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be>
In-Reply-To: <20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, Thomas Antoine <t.antoine@uclouvain.be>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733144859; l=1033;
 i=t.antoine@uclouvain.be; s=20241202; h=from:subject:message-id;
 bh=C6G2HNmCWsR7T7ZeSn//curscN+6Mz2Xd6Jnx+k56sQ=;
 b=fA9D6CBCX7gFNZtMJUgL0dFcwNCYI4mlMT8MAW2SwI7p3XgJFaWYEPyx7u68on+520i20JHid
 sicaCn2SzJGABlQm0g5TkuRvsBAZOKtxj5LMxDQNSbhwKrusQCJaTxs
X-Developer-Key: i=t.antoine@uclouvain.be; a=ed25519;
 pk=sw7UYl31W1LTpgWRiX4xIF5x6ok7YWZ6XZnHqy/d3dY=
X-Endpoint-Received: by B4 Relay for t.antoine@uclouvain.be/20241202 with
 auth_id=289
X-Original-From: Thomas Antoine <t.antoine@uclouvain.be>
Reply-To: t.antoine@uclouvain.be

From: Thomas Antoine <t.antoine@uclouvain.be>

Add the node for the max77759 fuel gauge as a slave of the i2c.

The fuel gauge has been tested and seems to give coherent results.
Manual activation of the charger via i2cset shows that the sign of
the current does indicate charging/discharging status.

Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
---
 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
index 387fb779bd29ea3812331a7951f03b181c5fe659..4c45dd6fd0173889234b7b04d7abb4b382c7706c 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
+++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
@@ -90,6 +90,13 @@ eeprom: eeprom@50 {
 &hsi2c_12 {
 	status = "okay";
 	/* TODO: add the devices once drivers exist */
+
+	fuel-gauge@36 {
+		compatible = "maxim,max77759-fg";
+		reg = <0x36>;
+		reg-names = "m5";
+	};
+
 };
 
 &pinctrl_far_alive {

-- 
2.47.1




Return-Path: <linux-pm+bounces-8326-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281FB8D2B4B
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 05:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C117B23830
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 03:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A92E15B127;
	Wed, 29 May 2024 03:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBfjnfyR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABE34DA08;
	Wed, 29 May 2024 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716952237; cv=none; b=Kv6hcEHsnOqfJKMVdx+jtQFK6nfWpTlYZz4sg5U99/32rlGV0/L/bxihNaZWYhQ4Pef9QgVD7bW6WXSzEcmeXuAmcwqBffx95RKPwxE/Yb+zWmARHR3oGeDEQ1Za3R6Nr51zsNsmcIal6vRnRmJWjty4EEX+cKRE728ttdVU6vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716952237; c=relaxed/simple;
	bh=uo0PCDDoky5dhGl+bpeCvO6ft78yeRE4RUqFKCEKRSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KlV97OosACR9Tup9xbLROvbEcvjjFVKR56K/qzUC9OH2eOmS5cBO/L2IZUfovzs+rVMqCQUkWInIEGzPB0sm3d4E9UR1TgfQ9v/Eh5OStGutWiUplXVU6EOgHmDxP9CfXtxhSzrgT2M867dazp4SerfAh3kzvX/b7wgYmZrJZ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBfjnfyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96362C4AF07;
	Wed, 29 May 2024 03:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716952236;
	bh=uo0PCDDoky5dhGl+bpeCvO6ft78yeRE4RUqFKCEKRSg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EBfjnfyREu6VyCSQTdq3JiOWwwrKtS2oIB7s9ggRQWvPBJEpGDP9j+AhRwBX44OU0
	 WVG/EbuYJdNo5lbE7/V8lBJXcBhu/GbMP+eMQF2niaGt0yEAPv/sfvGyfAY3Bc2vIp
	 O4z9stj06m2YxVW9S+X2xsQ/tJObCt4w08ZWlTeKKtcuHilHxs/pNecwwxc9Atsgjd
	 0q0Ndl5lKyyskMEybnhl3hv6EIXa3qv0WDIuMJJF/XXulIWUQAq8/m1EKcwaWfZrEH
	 RO+yxyRIWdSGhosrUTlCY8RnlmivNLZt1UD86/vrHW4Djh2DTbZpnQsEwIM9MiiFJC
	 Zu4ou05JPtW7w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DCFC27C4F;
	Wed, 29 May 2024 03:10:36 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 29 May 2024 11:10:34 +0800
Subject: [PATCH v2 2/3] pmdomain: amlogic: Add support for A4 power domains
 controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-a4_secpowerdomain-v2-2-47502fc0eaf3@amlogic.com>
References: <20240529-a4_secpowerdomain-v2-0-47502fc0eaf3@amlogic.com>
In-Reply-To: <20240529-a4_secpowerdomain-v2-0-47502fc0eaf3@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716952234; l=2626;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=xHQwoF0xxtI+C2XFx/t3frUsHcsxAgorsw6ZKo8der0=;
 b=mLQ4AfvdscxxLVeNIfgZB2VnyugTUuQbZSysS6LAb0zTrB6XFaWMZjTWc1AJaCsGV4ZfjMElU
 2BkqNjElNNQAPlxrDtG6tIaVTi8PEHVq+JF/CTJ9r4FZFrkaQSt00YX
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add support for A4 power controller. A4 power control
registers are in secure domain, and should be accessed by SMC.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/pmdomain/amlogic/meson-secure-pwrc.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pmdomain/amlogic/meson-secure-pwrc.c b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
index 4d5bda0d60fc..3a84d8a74a5e 100644
--- a/drivers/pmdomain/amlogic/meson-secure-pwrc.c
+++ b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
@@ -14,6 +14,7 @@
 #include <dt-bindings/power/amlogic,c3-pwrc.h>
 #include <dt-bindings/power/meson-s4-power.h>
 #include <dt-bindings/power/amlogic,t7-pwrc.h>
+#include <dt-bindings/power/amlogic,a4-pwrc.h>
 #include <linux/arm-smccc.h>
 #include <linux/firmware/meson/meson_sm.h>
 #include <linux/module.h>
@@ -136,6 +137,24 @@ static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
 	SEC_PD(RSA,	0),
 };
 
+static struct meson_secure_pwrc_domain_desc a4_pwrc_domains[] = {
+	SEC_PD(A4_AUDIO,	0),
+	SEC_PD(A4_SDIOA,	0),
+	SEC_PD(A4_EMMC,	0),
+	SEC_PD(A4_USB_COMB,	0),
+	SEC_PD(A4_ETH,		0),
+	SEC_PD(A4_VOUT,		0),
+	SEC_PD(A4_AUDIO_PDM,	0),
+	/* DMC is for DDR PHY ana/dig and DMC, and should be always on */
+	SEC_PD(A4_DMC,	GENPD_FLAG_ALWAYS_ON),
+	/* WRAP is secure_top, a lot of modules are included, and should be always on */
+	SEC_PD(A4_SYS_WRAP,	GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(A4_AO_I2C_S,	0),
+	SEC_PD(A4_AO_UART,	0),
+	/* IR is wake up trigger source, and should be always on */
+	SEC_PD(A4_AO_IR,	GENPD_FLAG_ALWAYS_ON),
+};
+
 static struct meson_secure_pwrc_domain_desc c3_pwrc_domains[] = {
 	SEC_PD(C3_NNA,		0),
 	SEC_PD(C3_AUDIO,	0),
@@ -311,6 +330,11 @@ static struct meson_secure_pwrc_domain_data meson_secure_a1_pwrc_data = {
 	.count = ARRAY_SIZE(a1_pwrc_domains),
 };
 
+static struct meson_secure_pwrc_domain_data amlogic_secure_a4_pwrc_data = {
+	.domains = a4_pwrc_domains,
+	.count = ARRAY_SIZE(a4_pwrc_domains),
+};
+
 static struct meson_secure_pwrc_domain_data amlogic_secure_c3_pwrc_data = {
 	.domains = c3_pwrc_domains,
 	.count = ARRAY_SIZE(c3_pwrc_domains),
@@ -331,6 +355,10 @@ static const struct of_device_id meson_secure_pwrc_match_table[] = {
 		.compatible = "amlogic,meson-a1-pwrc",
 		.data = &meson_secure_a1_pwrc_data,
 	},
+	{
+		.compatible = "amlogic,a4-pwrc",
+		.data = &amlogic_secure_a4_pwrc_data,
+	},
 	{
 		.compatible = "amlogic,c3-pwrc",
 		.data = &amlogic_secure_c3_pwrc_data,

-- 
2.37.1




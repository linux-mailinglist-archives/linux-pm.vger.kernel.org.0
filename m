Return-Path: <linux-pm+bounces-10111-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C513F91A5A3
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 13:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE951F218F5
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 11:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9FC14EC4E;
	Thu, 27 Jun 2024 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdtOQfOu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFA514A4DD;
	Thu, 27 Jun 2024 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719488875; cv=none; b=p46azNv27k5VzYPlUGNMiyXbBJtJSXANjcTxbRIC2B2SzSP4ByWDgTQEdJd6HR8BnNLROf0YfrREE/ZRAE4Wyu4VACwyYw9JPxRKv/SeIyL3PtqipwSNxoBaPLhrWwmmXwD3dzs47dItV78TtIzuxAj+wXv5xPUFMqMekF03NIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719488875; c=relaxed/simple;
	bh=lpXzYkzUB9eFRCkMDQeOFIvUniE98WzHWrrhrNYqR4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=py6kIy4LkCOx77/ot3O0RT6zRlyDys9UbNmBcmP+tSTaxjdoNNjVHoedJ48vYkEjqqsAPbv1K7o0pqp8+iPY09HLjrlGGfcNQLY6MsaTkzQow4y32Np63sLRbNlKn6Yy43x/209HFpXhcXfvuXpKQ7gNVcsZZpGTr8TT5fTleq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdtOQfOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33546C32786;
	Thu, 27 Jun 2024 11:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719488875;
	bh=lpXzYkzUB9eFRCkMDQeOFIvUniE98WzHWrrhrNYqR4M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IdtOQfOuJhAvYLJcKkItpR2JNUMnu8FvdlDaqtG+BmnlDs85bh0jDHBIjeh/qk/IH
	 ugMPXtt3jccb6nsSBr9pcAh+vVc3OnfTY0MGNA0/yoIOZxTs2bDSSLFwgAdWuxHaKk
	 3rclwG+s9QSMAZgZDeiMX4k8Cyr7WzOIsIG/R8gUKrQU0by1riqPBlFMo6WJZ7T06W
	 9Cvu8W8A0PxigiyVYldkFNHsbC/AKcZU7zdx4RCLiOOCXNCNrNkswyD4e251NsZuI0
	 Gj6JN7jrg9H9IybEGEshUZKoGZTX7QOp57YEzq7YeJdU+OUvIj947b1ZDgL/izGWZM
	 AYBMtjvo5kHUQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216DEC30659;
	Thu, 27 Jun 2024 11:47:55 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 27 Jun 2024 19:47:52 +0800
Subject: [PATCH 2/3] pmdomain: amlogic: Add support for A5 power domains
 controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-a5_secpower-v1-2-1f47dde1270c@amlogic.com>
References: <20240627-a5_secpower-v1-0-1f47dde1270c@amlogic.com>
In-Reply-To: <20240627-a5_secpower-v1-0-1f47dde1270c@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Hongyu Chen <hongyu.chen1@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719488872; l=2530;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=zWxLtelNKu19heqKs9wOyiplUpI+DyeIV7xOkfT+HwI=;
 b=Q2fjW+FoiPk3SlMyEGT1KOBPCDtlv+iKtLDF1wDDMNTEdR1UsHTAvXROY6xZNm5ch7gAtubOt
 ARKBdI22iOlC0SFpCvBkVGmqTg5pB0id21KF/i0mvBc3B9PmbWAxM+p
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add support for the A5 power controller, whose registers are
in the secure domain and should be accessed via SMC.

Signed-off-by: Hongyu Chen <hongyu.chen1@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/pmdomain/amlogic/meson-secure-pwrc.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pmdomain/amlogic/meson-secure-pwrc.c b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
index df5567418226..f6729eea6b8c 100644
--- a/drivers/pmdomain/amlogic/meson-secure-pwrc.c
+++ b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
@@ -15,6 +15,7 @@
 #include <dt-bindings/power/meson-s4-power.h>
 #include <dt-bindings/power/amlogic,t7-pwrc.h>
 #include <dt-bindings/power/amlogic,a4-pwrc.h>
+#include <dt-bindings/power/amlogic,a5-pwrc.h>
 #include <linux/arm-smccc.h>
 #include <linux/firmware/meson/meson_sm.h>
 #include <linux/module.h>
@@ -155,6 +156,22 @@ static struct meson_secure_pwrc_domain_desc a4_pwrc_domains[] = {
 	SEC_PD(A4_AO_IR,	GENPD_FLAG_ALWAYS_ON),
 };
 
+static struct meson_secure_pwrc_domain_desc a5_pwrc_domains[] = {
+	SEC_PD(A5_NNA,		0),
+	SEC_PD(A5_AUDIO,	0),
+	SEC_PD(A5_SDIOA,	0),
+	SEC_PD(A5_EMMC,		0),
+	SEC_PD(A5_USB_COMB,	0),
+	SEC_PD(A5_ETH,		0),
+	SEC_PD(A5_RSA,		0),
+	SEC_PD(A5_AUDIO_PDM,	0),
+	/* DMC is for DDR PHY ana/dig and DMC, and should be always on */
+	SEC_PD(A5_DMC,		GENPD_FLAG_ALWAYS_ON),
+	/* WRAP is secure_top, a lot of modules are included, and should be always on */
+	SEC_PD(A5_SYS_WRAP,	GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(A5_DSPA,		0),
+};
+
 static struct meson_secure_pwrc_domain_desc c3_pwrc_domains[] = {
 	SEC_PD(C3_NNA,		0),
 	SEC_PD(C3_AUDIO,	0),
@@ -335,6 +352,11 @@ static struct meson_secure_pwrc_domain_data amlogic_secure_a4_pwrc_data = {
 	.count = ARRAY_SIZE(a4_pwrc_domains),
 };
 
+static struct meson_secure_pwrc_domain_data amlogic_secure_a5_pwrc_data = {
+	.domains = a5_pwrc_domains,
+	.count = ARRAY_SIZE(a5_pwrc_domains),
+};
+
 static struct meson_secure_pwrc_domain_data amlogic_secure_c3_pwrc_data = {
 	.domains = c3_pwrc_domains,
 	.count = ARRAY_SIZE(c3_pwrc_domains),
@@ -359,6 +381,10 @@ static const struct of_device_id meson_secure_pwrc_match_table[] = {
 		.compatible = "amlogic,a4-pwrc",
 		.data = &amlogic_secure_a4_pwrc_data,
 	},
+	{
+		.compatible = "amlogic,a5-pwrc",
+		.data = &amlogic_secure_a5_pwrc_data,
+	},
 	{
 		.compatible = "amlogic,c3-pwrc",
 		.data = &amlogic_secure_c3_pwrc_data,

-- 
2.37.1




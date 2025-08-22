Return-Path: <linux-pm+bounces-32877-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BB0B30E37
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 07:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF0A16B729
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 05:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E18C2E267D;
	Fri, 22 Aug 2025 05:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dty9wqER"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF3B29346F;
	Fri, 22 Aug 2025 05:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755841289; cv=none; b=rAfmqnh8ksJjlWvt/Yd+TgKSxpHR6KqsOrA0fQ/keTZUPg9e0W/caXSmRz7JNeTm/fU/h7qV87+wK4MatbcFgRx73N4e0W4t6gPcKYbbO9thkwKBv16/eELWa7a0CIE+noA1DZ6JxfXwRaZO9blwEcRL1pmJC1cW7c8wQOV64uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755841289; c=relaxed/simple;
	bh=MQ9NuAWPDpPyLjcRYr12dzgmrw8Z7IvytBTk8yXQ46c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pAjJYW13i92vNYUYX3SuBAuYyWoC4UdeQtM8qiFPaevfzM49TdYeb7qTMUeUjEA3HZ59s4qo6xdvMyVJBMUZSoEofCEKohsTWIsUdgcBs1RvmWSWbQUGDCYKHhRsGYDLPk/6SmV1Lie/ECqROewU+VPXk7YzWyM92szkmx/1NQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dty9wqER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12898C116B1;
	Fri, 22 Aug 2025 05:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755841289;
	bh=MQ9NuAWPDpPyLjcRYr12dzgmrw8Z7IvytBTk8yXQ46c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Dty9wqERTz8vOs3UY0ho/3Q4MGtTRVuuy2iHbUKQiqalYrpnhSZHOP1xJB48b/Xbt
	 gH/jDqKwi47QrvPCt0qF02zlWWL2L0PF+iIkG/7Gy8dEsRp22LcHqRODiKgq9BAg1F
	 dBChAPqDNG3z+f9J3MA05C981C4N+P6nEXt4JZIOA6s+Jwjkb9mAbHbNJsNH0DkLhB
	 /q32TYECsMOtrlLCd0JLY9OlugYwpASGn9BiTbZsu5YfNe5D0I6kmtu4A4Qi3lUgrS
	 ti/iqNcftmftxYNUriYYkEAjMDJ5MK3COi20xLGMLwLLVMH1Xc1iwN9vTuSzcP1iRG
	 VLJzfPKsmk8ag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AC6CA0FE4;
	Fri, 22 Aug 2025 05:41:29 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 22 Aug 2025 13:39:56 +0800
Subject: [PATCH 2/5] pmdomain: amlogic: Add support for S6 S7 S7D power
 domains controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-pm-s6-s7-s7d-v1-2-82e3f3aff327@amlogic.com>
References: <20250822-pm-s6-s7-s7d-v1-0-82e3f3aff327@amlogic.com>
In-Reply-To: <20250822-pm-s6-s7-s7d-v1-0-82e3f3aff327@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 "hongyu.chen1" <hongyu.chen1@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755841286; l=4719;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=f2m0nsIUf/owC+/pGLzsEn5pyQIYJ6wrUlxsJFTx2lE=;
 b=pwitmZC4ygGsQN/beTX1T2nbDqayrzpNTwBhuxE50uUBEkMZv8EqkL5nsYtHy9Vdkv1dgMiy9
 RdOGT7HWMBPDcBeSx54/4CPNhf8ng0FiM8VoH5ixsmzJLEe5bvfICsR
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: "hongyu.chen1" <hongyu.chen1@amlogic.com>

Add support for the S6 S7 S7D power controller, whose registers are
in the secure domain and should be accessed via SMC.

Signed-off-by: hongyu.chen1 <hongyu.chen1@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/pmdomain/amlogic/meson-secure-pwrc.c | 95 ++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/pmdomain/amlogic/meson-secure-pwrc.c b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
index e8bda60078c4..1d2f371d2d7f 100644
--- a/drivers/pmdomain/amlogic/meson-secure-pwrc.c
+++ b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
@@ -16,6 +16,9 @@
 #include <dt-bindings/power/amlogic,t7-pwrc.h>
 #include <dt-bindings/power/amlogic,a4-pwrc.h>
 #include <dt-bindings/power/amlogic,a5-pwrc.h>
+#include <dt-bindings/power/amlogic,s6-pwrc.h>
+#include <dt-bindings/power/amlogic,s7-pwrc.h>
+#include <dt-bindings/power/amlogic,s7d-pwrc.h>
 #include <linux/arm-smccc.h>
 #include <linux/firmware/meson/meson_sm.h>
 #include <linux/module.h>
@@ -201,6 +204,71 @@ static const struct meson_secure_pwrc_domain_desc s4_pwrc_domains[] = {
 	SEC_PD(S4_AUDIO,	0),
 };
 
+static const struct meson_secure_pwrc_domain_desc s6_pwrc_domains[] = {
+	SEC_PD(S6_DSPA,		0),
+	SEC_PD(S6_DOS_HEVC,	0),
+	SEC_PD(S6_DOS_VDEC,	0),
+	SEC_PD(S6_VPU_HDMI,	0),
+	SEC_PD(S6_U2DRD,	0),
+	SEC_PD(S6_U3DRD,	0),
+	SEC_PD(S6_SD_EMMC_C,	0),
+	SEC_PD(S6_GE2D,		0),
+	SEC_PD(S6_AMFC,		0),
+	SEC_PD(S6_VC9000E,	0),
+	SEC_PD(S6_DEWARP,	0),
+	SEC_PD(S6_VICP,		0),
+	SEC_PD(S6_SD_EMMC_A,	0),
+	SEC_PD(S6_SD_EMMC_B,	0),
+	/* ETH is for ethernet online wakeup, and should be always on */
+	SEC_PD(S6_ETH,		GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(S6_PCIE,		0),
+	SEC_PD(S6_NNA_4T,	0),
+	SEC_PD(S6_AUDIO,	0),
+	SEC_PD(S6_AUCPU,	0),
+	SEC_PD(S6_ADAPT,	0),
+};
+
+static const struct meson_secure_pwrc_domain_desc s7_pwrc_domains[] = {
+	SEC_PD(S7_DOS_HEVC,	0),
+	SEC_PD(S7_DOS_VDEC,	0),
+	SEC_PD(S7_VPU_HDMI,	0),
+	SEC_PD(S7_USB_COMB,	0),
+	SEC_PD(S7_SD_EMMC_C,	0),
+	SEC_PD(S7_GE2D,		0),
+	SEC_PD(S7_SD_EMMC_A,	0),
+	SEC_PD(S7_SD_EMMC_B,	0),
+	/* ETH is for ethernet online wakeup, and should be always on */
+	SEC_PD(S7_ETH,		GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(S7_AUCPU,	0),
+	SEC_PD(S7_AUDIO,	0),
+};
+
+static const struct meson_secure_pwrc_domain_desc s7d_pwrc_domains[] = {
+	SEC_PD(S7D_DOS_HCODEC,	0),
+	SEC_PD(S7D_DOS_HEVC,	0),
+	SEC_PD(S7D_DOS_VDEC,	0),
+	SEC_PD(S7D_VPU_HDMI,	0),
+	SEC_PD(S7D_USB_U2DRD,	0),
+	SEC_PD(S7D_USB_U2H,	0),
+	SEC_PD(S7D_SSD_EMMC_C,	0),
+	SEC_PD(S7D_GE2D,	0),
+	SEC_PD(S7D_AMFC,	0),
+	SEC_PD(S7D_EMMC_A,	0),
+	SEC_PD(S7D_EMMC_B,	0),
+	/* ETH is for ethernet online wakeup, and should be always on */
+	SEC_PD(S7D_ETH,		GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(S7D_AUCPU,	0),
+	SEC_PD(S7D_AUDIO,	0),
+	/* SRAMA is used as ATF runtime memory, and should be always on */
+	SEC_PD(S7D_SRAMA,	GENPD_FLAG_ALWAYS_ON),
+	/* DMC0 is for DDR PHY ana/dig and DMC, and should be always on */
+	SEC_PD(S7D_DMC0,	GENPD_FLAG_ALWAYS_ON),
+	/* DMC1 is for DDR PHY ana/dig and DMC, and should be always on */
+	SEC_PD(S7D_DMC1,	GENPD_FLAG_ALWAYS_ON),
+	/* DDR should be always on */
+	SEC_PD(S7D_DDR,		GENPD_FLAG_ALWAYS_ON),
+};
+
 static const struct meson_secure_pwrc_domain_desc t7_pwrc_domains[] = {
 	SEC_PD(T7_DSPA,		0),
 	SEC_PD(T7_DSPB,		0),
@@ -367,6 +435,21 @@ static const struct meson_secure_pwrc_domain_data meson_secure_s4_pwrc_data = {
 	.count = ARRAY_SIZE(s4_pwrc_domains),
 };
 
+static const struct meson_secure_pwrc_domain_data amlogic_secure_s6_pwrc_data = {
+	.domains = s6_pwrc_domains,
+	.count = ARRAY_SIZE(s6_pwrc_domains),
+};
+
+static const struct meson_secure_pwrc_domain_data amlogic_secure_s7_pwrc_data = {
+	.domains = s7_pwrc_domains,
+	.count = ARRAY_SIZE(s7_pwrc_domains),
+};
+
+static const struct meson_secure_pwrc_domain_data amlogic_secure_s7d_pwrc_data = {
+	.domains = s7d_pwrc_domains,
+	.count = ARRAY_SIZE(s7d_pwrc_domains),
+};
+
 static const struct meson_secure_pwrc_domain_data amlogic_secure_t7_pwrc_data = {
 	.domains = t7_pwrc_domains,
 	.count = ARRAY_SIZE(t7_pwrc_domains),
@@ -393,6 +476,18 @@ static const struct of_device_id meson_secure_pwrc_match_table[] = {
 		.compatible = "amlogic,meson-s4-pwrc",
 		.data = &meson_secure_s4_pwrc_data,
 	},
+	{
+		.compatible = "amlogic,s6-pwrc",
+		.data = &amlogic_secure_s6_pwrc_data,
+	},
+	{
+		.compatible = "amlogic,s7-pwrc",
+		.data = &amlogic_secure_s7_pwrc_data,
+	},
+	{
+		.compatible = "amlogic,s7d-pwrc",
+		.data = &amlogic_secure_s7d_pwrc_data,
+	},
 	{
 		.compatible = "amlogic,t7-pwrc",
 		.data = &amlogic_secure_t7_pwrc_data,

-- 
2.37.1




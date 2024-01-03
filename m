Return-Path: <linux-pm+bounces-1793-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8908231AC
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jan 2024 17:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF311B2257E
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jan 2024 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1151C694;
	Wed,  3 Jan 2024 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYOVHk2X"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89DC1C290;
	Wed,  3 Jan 2024 16:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EA1C433C8;
	Wed,  3 Jan 2024 16:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704301032;
	bh=Dg2dDaPNZtNW//yG71kg8XZ8E7Hu6Q4eVI6C38LDthI=;
	h=From:Date:Subject:To:Cc:From;
	b=iYOVHk2XhpQokWq7/u1JypdHbjqJIiozmZIPP46+vKl8+c5MNTwZ6lIeawQdtTHlV
	 fD/GNag5+BHJ3/XEBKZ3BU3o036DXxaNh+5e+43uCAJq6l8sBZedNQmiO+XtajmUV9
	 fCBitXICxXvR2TVg8YtfB2MjhLHc7sLAZSYCFMcrWb2WrAIXYYKmQ113Vw5m2m9rHz
	 o/GeuEn1DesYlKAWVMgrpROoZySLAsZwhabV9haMU4APb5I6MSdePpHfCgha9sfVM5
	 5NecWyk06XBBXjdFEdq95t21rkwffHIloaFf5YhpyfgWsftyXx+XgHBDIV9kfMux5D
	 A0IKqSxubn/Sw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 03 Jan 2024 09:57:07 -0700
Subject: [PATCH] power: supply: bq24190_charger: Fix "initializer element
 is not constant" error
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-fix-bq24190_charger-vbus_desc-non-const-v1-1-115ddf798c70@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOKRlWUC/x2N0QqDMAxFf0XyvEBaRXC/MoasaXR9SbdkE0H89
 5U9HrjnngNcrIjDtTvAZCteqjYIlw74+dBVsOTGECkOFKjHpeyY3nEIE81tYasYbunrcxZn1Kr
 IVf2DPKaFKGQepwzt7WXS1H/pdj/PHxCHbTp5AAAA
To: sre@kernel.org
Cc: chenhuiz@axis.com, linux-pm@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5503; i=nathan@kernel.org;
 h=from:subject:message-id; bh=Dg2dDaPNZtNW//yG71kg8XZ8E7Hu6Q4eVI6C38LDthI=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKlTJ74w+KGgfPuA2GGRZGmtJnFX1sCTLfPF89kTBesaf
 0nwf77WUcrCIMbFICumyFL9WPW4oeGcs4w3Tk2CmcPKBDKEgYtTACbiO5nhf2Cw+8YJE3meun/0
 trPeHP7hkEg663+bHsYk7nvWam3vPRkZ+lVfdFmtn2Te5xzC9vn95czL5/vPbpKOuFWgVcWztXY
 yCwA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building with a version of GCC prior to 8.x, there is an error
around non-constant initializer elements:

  drivers/power/supply/bq24190_charger.c:1978:16: error: initializer element is not constant
     .vbus_desc = bq24190_vbus_desc,
                  ^~~~~~~~~~~~~~~~~
  drivers/power/supply/bq24190_charger.c:1978:16: note: (near initialization for 'bq24190_chip_info_tbl[0].vbus_desc')
  drivers/power/supply/bq24190_charger.c:1989:16: error: initializer element is not constant
     .vbus_desc = bq24190_vbus_desc,
                  ^~~~~~~~~~~~~~~~~
  drivers/power/supply/bq24190_charger.c:1989:16: note: (near initialization for 'bq24190_chip_info_tbl[1].vbus_desc')
  drivers/power/supply/bq24190_charger.c:2000:16: error: initializer element is not constant
     .vbus_desc = bq24190_vbus_desc,
                  ^~~~~~~~~~~~~~~~~
  drivers/power/supply/bq24190_charger.c:2000:16: note: (near initialization for 'bq24190_chip_info_tbl[2].vbus_desc')
  drivers/power/supply/bq24190_charger.c:2011:16: error: initializer element is not constant
     .vbus_desc = bq24190_vbus_desc,
                  ^~~~~~~~~~~~~~~~~
  drivers/power/supply/bq24190_charger.c:2011:16: note: (near initialization for 'bq24190_chip_info_tbl[3].vbus_desc')
  drivers/power/supply/bq24190_charger.c:2022:16: error: initializer element is not constant
     .vbus_desc = bq24296_vbus_desc,
                  ^~~~~~~~~~~~~~~~~
  drivers/power/supply/bq24190_charger.c:2022:16: note: (near initialization for 'bq24190_chip_info_tbl[4].vbus_desc')

Clang versions prior to 17.x show a similar error:

  drivers/power/supply/bq24190_charger.c:1978:16: error: initializer element is not a compile-time constant
                  .vbus_desc = bq24190_vbus_desc,
                               ^~~~~~~~~~~~~~~~~
  1 error generated.

Newer compilers have decided to accept these structures as compile time
constants as an extension. To resolve this issue for all supported
compilers, change the vbus_desc member in 'struct bq24190_chip_info' to
a pointer, as it is only ever passed by reference anyways, and adjust
the assignments accordingly.

Closes: https://github.com/ClangBuiltLinux/linux/issues/1973
Fixes: b150a703b56f ("power: supply: bq24190_charger: Add support for BQ24296")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/power/supply/bq24190_charger.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index a8995a21fadb..2b393eb5c282 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -246,7 +246,7 @@ struct bq24190_dev_info {
 struct bq24190_chip_info {
 	int ichg_array_size;
 #ifdef CONFIG_REGULATOR
-	const struct regulator_desc vbus_desc;
+	const struct regulator_desc *vbus_desc;
 #endif
 	int (*check_chip)(struct bq24190_dev_info *bdi);
 	int (*set_chg_config)(struct bq24190_dev_info *bdi, const u8 chg_config);
@@ -728,7 +728,7 @@ static int bq24190_register_vbus_regulator(struct bq24190_dev_info *bdi)
 	else
 		cfg.init_data = &bq24190_vbus_init_data;
 	cfg.driver_data = bdi;
-	reg = devm_regulator_register(bdi->dev, &bdi->info->vbus_desc, &cfg);
+	reg = devm_regulator_register(bdi->dev, bdi->info->vbus_desc, &cfg);
 	if (IS_ERR(reg)) {
 		ret = PTR_ERR(reg);
 		dev_err(bdi->dev, "Can't register regulator: %d\n", ret);
@@ -1975,7 +1975,7 @@ static const struct bq24190_chip_info bq24190_chip_info_tbl[] = {
 	[BQ24190] = {
 		.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
 #ifdef CONFIG_REGULATOR
-		.vbus_desc = bq24190_vbus_desc,
+		.vbus_desc = &bq24190_vbus_desc,
 #endif
 		.check_chip = bq24190_check_chip,
 		.set_chg_config = bq24190_battery_set_chg_config,
@@ -1986,7 +1986,7 @@ static const struct bq24190_chip_info bq24190_chip_info_tbl[] = {
 	[BQ24192] = {
 		.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
 #ifdef CONFIG_REGULATOR
-		.vbus_desc = bq24190_vbus_desc,
+		.vbus_desc = &bq24190_vbus_desc,
 #endif
 		.check_chip = bq24190_check_chip,
 		.set_chg_config = bq24190_battery_set_chg_config,
@@ -1997,7 +1997,7 @@ static const struct bq24190_chip_info bq24190_chip_info_tbl[] = {
 	[BQ24192i] = {
 		.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
 #ifdef CONFIG_REGULATOR
-		.vbus_desc = bq24190_vbus_desc,
+		.vbus_desc = &bq24190_vbus_desc,
 #endif
 		.check_chip = bq24190_check_chip,
 		.set_chg_config = bq24190_battery_set_chg_config,
@@ -2008,7 +2008,7 @@ static const struct bq24190_chip_info bq24190_chip_info_tbl[] = {
 	[BQ24196] = {
 		.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
 #ifdef CONFIG_REGULATOR
-		.vbus_desc = bq24190_vbus_desc,
+		.vbus_desc = &bq24190_vbus_desc,
 #endif
 		.check_chip = bq24190_check_chip,
 		.set_chg_config = bq24190_battery_set_chg_config,
@@ -2019,7 +2019,7 @@ static const struct bq24190_chip_info bq24190_chip_info_tbl[] = {
 	[BQ24296] = {
 		.ichg_array_size = BQ24296_CCC_ICHG_VALUES_LEN,
 #ifdef CONFIG_REGULATOR
-		.vbus_desc = bq24296_vbus_desc,
+		.vbus_desc = &bq24296_vbus_desc,
 #endif
 		.check_chip = bq24296_check_chip,
 		.set_chg_config = bq24296_battery_set_chg_config,

---
base-commit: b150a703b56fb6eb282d059b421652ccd9155c23
change-id: 20240103-fix-bq24190_charger-vbus_desc-non-const-c6bf001dc69d

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>



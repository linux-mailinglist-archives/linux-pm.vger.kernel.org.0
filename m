Return-Path: <linux-pm+bounces-30772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F06B0396D
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 10:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5BD16EC2D
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 08:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47CB23E35F;
	Mon, 14 Jul 2025 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UX/8FocX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB33C23BD1F;
	Mon, 14 Jul 2025 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481396; cv=none; b=Eu4YzAqcd8Vtrz7udjA7R25sFOb8SudhGVzx4xQBVhXK8KA8OIPaHAT+APeb4rDB7yakZ8XccYmID0hk22BHg1VARXd33H97sJvmWQd1XAiIuEF5vXR4Q4pM0Z0mzIfc/DQmQVi44DIpoqVKndPawGgBrHup8o/UEFgDHefv/IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481396; c=relaxed/simple;
	bh=TgtXIAr3IGEHvtydhEWp8c7auiDqocGddu9PnevEWY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsocCvNkKEirJVmeJaUVumpDRZu+xfa1UDKRlRHCFTOdVSxxazTqunS7DLws7W63IgxCGN/p3Ek/sJ+sQaYqyPxPgudYXTbG8H08aEV8IKWVc1wyXDbP1zKhw99IjmWg85C+lrlvz5uiXCh/0FiE7z/JjAzOguZyFmgTM2ETIMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UX/8FocX; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5562838ce68so3698052e87.2;
        Mon, 14 Jul 2025 01:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752481393; x=1753086193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miny/PoDyZMHIwzlLhKH1Yc3uh/Hp6mfXYgqs94khEQ=;
        b=UX/8FocXfhuym/E851IPv7eGG5zhUEmNfNz4hqcgoCKjuuJdnoWAde1BxPm9bhO9gD
         dZBirmp5uYoy44lcclbmFPpE826m9tCGLHAiGAAOPyFoBtjGxb3NKHa6cbFAznzgAesR
         JMwyDQRtxHW1oiTEjnjFQ1jxyUgZMeca6+eJNEaCESvV5I+2eJ380G3Te2Lj7btXr9Tu
         FfM7Y02nRoszTT3x7yHdZWrS/hvHgbw+iT6kygD43RPvtq8+kVU3GSlPuzjkO9dqcXJb
         2t2ZF5SaA7HTqbzJLgKdp8+GIidO8q61sTNnO3jy+mdnoso7ZfJ3nEr6aPK19YX42bg7
         U4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752481393; x=1753086193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miny/PoDyZMHIwzlLhKH1Yc3uh/Hp6mfXYgqs94khEQ=;
        b=EUkEhhyOxGzbcTNnmt/uhdyCCvhkedroSolvdn9EDc/0c57cqLWNDGY6RLU17BPJ43
         bdZlUItr3syTFtYJm5C3muJIp/Qi02eui0pDL5hszhiEN+FqEjelzvOmeAJ2ljWlbpH2
         IfqljXVZJ1dQuQ1zZxo9gSjxIQexXJ6W7K4jNaX/kUU8bxuhRUazowaH9sviClxBqfki
         CZ+CIHgekjTp6tYkSIREglk2xLbnz92ijHqXR5OHMFcwd9kubQnpjYDsQq9iuJZ47yB2
         ySMuie0/g7RYhF1368/atUfPxyQUWWDgdTrSk3i6e8H78x1foQvW8IzmrjPfZnCtfecL
         665w==
X-Forwarded-Encrypted: i=1; AJvYcCUQgLv9gTLisfNlX2U32hyntEpgM0QWphfNb5qbwWB2DB/27O1X3dr1skOpBy28Ivt8kpD/5GvcuISJ@vger.kernel.org, AJvYcCUtc0l/4tueDnw6+VuzmzldIbVG0n5ehFZ+vb9XXlygwIKXP1r45JdHd1WY2eny5zNpILdeQBGoyRjL9wk=@vger.kernel.org, AJvYcCW1Y30QpkOnO8XIrNZwuekj3U14RAqV/urWLgTvxZmrvvf7BzWq3oBXABWzE01DbCvEhA21IwScx58CYOsh@vger.kernel.org
X-Gm-Message-State: AOJu0YwTn4q8/Xvszt//wRCiP8zb1vA1JqMEcGee0+a1//g+YxDaUAI4
	yhrKQcBuY9OqK9AuOM4DzGmaw/jEzhq5JsNDyRZ1BxhkOFXRTjVNE7lN
X-Gm-Gg: ASbGncvKed0pCrf7ARhtY/RS/scdiDvQseLXzS+UaZEBGtz9wM4FpOQ4FlMe1T5cv0H
	gzKQH81R/kgQ2Q6zUWco2WvDhWUFeXiFsaL69HXEsyyohrh6i4cwpmWdu1t8A7UWJSlYi5RhlBK
	1skvpl+UJQhsRTEos8DBk/Qpk/yuxyb8vIOeb8bY7Qw+HWU6jW6OA9otDM/kQvlgf08edS5tCLr
	15KPqNI1qWbujyZXhECyYbysu6wP/LaSsbEp3RuW3lh9600uBBdddFtyyECBRrSx1jPZgPyxeQ3
	pYeTmMKo4vZ9EaXbgo/waQjKK+4sUDs1SyySz/KTwdH96x4Zp1bCJNrc7N4y3IG6FlpzfSMORg1
	ffOOHGEa4mLcrGA==
X-Google-Smtp-Source: AGHT+IEc0k/25lJHfPH/NAZGPwTE3tsVDZzLNsCMdRivHyYK6OkyC24M55OLkdNlSvsBdaqBoCnu0g==
X-Received: by 2002:ac2:4c45:0:b0:553:2c65:f1ca with SMTP id 2adb3069b0e04-55a044e902cmr3118686e87.19.1752481392570;
        Mon, 14 Jul 2025 01:23:12 -0700 (PDT)
Received: from xeon.. ([188.163.112.60])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7bbd55sm1885717e87.23.2025.07.14.01.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 01:23:12 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] thermal: tegra: soctherm-fuse: parametrize configuration further
Date: Mon, 14 Jul 2025 11:22:50 +0300
Message-ID: <20250714082252.9028-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714082252.9028-1-clamor95@gmail.com>
References: <20250714082252.9028-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare soctherm fuse calibration for Tegra114 support.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/thermal/tegra/soctherm-fuse.c     | 33 ++++++++++++++++-------
 drivers/thermal/tegra/soctherm.h          | 13 ++++++++-
 drivers/thermal/tegra/tegra124-soctherm.c |  8 ++++++
 drivers/thermal/tegra/tegra132-soctherm.c |  8 ++++++
 drivers/thermal/tegra/tegra210-soctherm.c |  8 ++++++
 5 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm-fuse.c b/drivers/thermal/tegra/soctherm-fuse.c
index 190f95280e0b..3b808c4521b8 100644
--- a/drivers/thermal/tegra/soctherm-fuse.c
+++ b/drivers/thermal/tegra/soctherm-fuse.c
@@ -9,15 +9,10 @@
 
 #include "soctherm.h"
 
-#define NOMINAL_CALIB_FT			105
-#define NOMINAL_CALIB_CP			25
-
 #define FUSE_TSENSOR_CALIB_CP_TS_BASE_MASK	0x1fff
 #define FUSE_TSENSOR_CALIB_FT_TS_BASE_MASK	(0x1fff << 13)
 #define FUSE_TSENSOR_CALIB_FT_TS_BASE_SHIFT	13
 
-#define FUSE_TSENSOR_COMMON			0x180
-
 /*
  * Tegra210: Layout of bits in FUSE_TSENSOR_COMMON:
  *    3                   2                   1                   0
@@ -44,6 +39,13 @@
  * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
  * |---------------------------------------------------| SHIFT_CP  |
  * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *
+ * Tegra11x: Layout of bits in FUSE_TSENSOR_COMMON aka FUSE_VSENSOR_CALIB:
+ *    3                   2                   1                   0
+ *  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ * | SHFT_FT |       BASE_FT       | SHIFT_CP  |      BASE_CP      |
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
  */
 
 #define CALIB_COEFFICIENT 1000000LL
@@ -77,7 +79,7 @@ int tegra_calc_shared_calib(const struct tegra_soctherm_fuse *tfuse,
 	s32 shifted_cp, shifted_ft;
 	int err;
 
-	err = tegra_fuse_readl(FUSE_TSENSOR_COMMON, &val);
+	err = tegra_fuse_readl(tfuse->fuse_common_reg, &val);
 	if (err)
 		return err;
 
@@ -88,7 +90,7 @@ int tegra_calc_shared_calib(const struct tegra_soctherm_fuse *tfuse,
 
 	shifted_ft = (val & tfuse->fuse_shift_ft_mask) >>
 		     tfuse->fuse_shift_ft_shift;
-	shifted_ft = sign_extend32(shifted_ft, 4);
+	shifted_ft = sign_extend32(shifted_ft, tfuse->fuse_shift_ft_bits);
 
 	if (tfuse->fuse_spare_realignment) {
 		err = tegra_fuse_readl(tfuse->fuse_spare_realignment, &val);
@@ -96,10 +98,21 @@ int tegra_calc_shared_calib(const struct tegra_soctherm_fuse *tfuse,
 			return err;
 	}
 
-	shifted_cp = sign_extend32(val, 5);
+	shifted_cp = (val & tfuse->fuse_shift_cp_mask) >>
+		     tfuse->fuse_shift_cp_shift;
+	shifted_cp = sign_extend32(val, tfuse->fuse_shift_cp_bits);
 
-	shared->actual_temp_cp = 2 * NOMINAL_CALIB_CP + shifted_cp;
-	shared->actual_temp_ft = 2 * NOMINAL_CALIB_FT + shifted_ft;
+	shared->actual_temp_cp = 2 * tfuse->nominal_calib_cp + shifted_cp;
+	shared->actual_temp_ft = 2 * tfuse->nominal_calib_ft + shifted_ft;
+
+	/*
+	 * Tegra114 provides fuse thermal corrections in 0.5C while expected
+	 * precision should be 1C
+	 */
+	if (tfuse->lower_precision) {
+		shared->actual_temp_cp /= 2;
+		shared->actual_temp_ft /= 2;
+	}
 
 	return 0;
 }
diff --git a/drivers/thermal/tegra/soctherm.h b/drivers/thermal/tegra/soctherm.h
index 70501e73d586..6c0e0cc594a5 100644
--- a/drivers/thermal/tegra/soctherm.h
+++ b/drivers/thermal/tegra/soctherm.h
@@ -56,6 +56,13 @@
 #define SENSOR_TEMP2_MEM_TEMP_MASK		(0xffff << 16)
 #define SENSOR_TEMP2_PLLX_TEMP_MASK		0xffff
 
+#define NOMINAL_CALIB_FT			105
+#define T114X_CALIB_FT				90
+#define NOMINAL_CALIB_CP			25
+
+#define FUSE_VSENSOR_CALIB			0x08c
+#define FUSE_TSENSOR_COMMON			0x180
+
 /**
  * struct tegra_tsensor_group - SOC_THERM sensor group data
  * @name: short name of the temperature sensor group
@@ -109,9 +116,13 @@ struct tsensor_group_thermtrips {
 
 struct tegra_soctherm_fuse {
 	u32 fuse_base_cp_mask, fuse_base_cp_shift;
+	u32 fuse_shift_cp_mask, fuse_shift_cp_shift;
 	u32 fuse_base_ft_mask, fuse_base_ft_shift;
 	u32 fuse_shift_ft_mask, fuse_shift_ft_shift;
-	u32 fuse_spare_realignment;
+	u32 fuse_shift_cp_bits, fuse_shift_ft_bits;
+	u32 fuse_common_reg, fuse_spare_realignment;
+	u32 nominal_calib_cp, nominal_calib_ft;
+	bool lower_precision;
 };
 
 struct tsensor_shared_calib {
diff --git a/drivers/thermal/tegra/tegra124-soctherm.c b/drivers/thermal/tegra/tegra124-soctherm.c
index 20ad27f4d1a1..dd4dd7e9014d 100644
--- a/drivers/thermal/tegra/tegra124-soctherm.c
+++ b/drivers/thermal/tegra/tegra124-soctherm.c
@@ -200,11 +200,19 @@ static const struct tegra_tsensor tegra124_tsensors[] = {
 static const struct tegra_soctherm_fuse tegra124_soctherm_fuse = {
 	.fuse_base_cp_mask = 0x3ff,
 	.fuse_base_cp_shift = 0,
+	.fuse_shift_cp_mask = 0x1f,
+	.fuse_shift_cp_shift = 0,
 	.fuse_base_ft_mask = 0x7ff << 10,
 	.fuse_base_ft_shift = 10,
 	.fuse_shift_ft_mask = 0x1f << 21,
 	.fuse_shift_ft_shift = 21,
+	.fuse_shift_cp_bits = 5,
+	.fuse_shift_ft_bits = 4,
+	.fuse_common_reg = FUSE_TSENSOR_COMMON,
 	.fuse_spare_realignment = 0x1fc,
+	.nominal_calib_cp = NOMINAL_CALIB_CP,
+	.nominal_calib_ft = NOMINAL_CALIB_FT,
+	.lower_precision = false,
 };
 
 const struct tegra_soctherm_soc tegra124_soctherm = {
diff --git a/drivers/thermal/tegra/tegra132-soctherm.c b/drivers/thermal/tegra/tegra132-soctherm.c
index b76308fdad9e..926836426688 100644
--- a/drivers/thermal/tegra/tegra132-soctherm.c
+++ b/drivers/thermal/tegra/tegra132-soctherm.c
@@ -200,11 +200,19 @@ static struct tegra_tsensor tegra132_tsensors[] = {
 static const struct tegra_soctherm_fuse tegra132_soctherm_fuse = {
 	.fuse_base_cp_mask = 0x3ff,
 	.fuse_base_cp_shift = 0,
+	.fuse_shift_cp_mask = 0x1f,
+	.fuse_shift_cp_shift = 0,
 	.fuse_base_ft_mask = 0x7ff << 10,
 	.fuse_base_ft_shift = 10,
 	.fuse_shift_ft_mask = 0x1f << 21,
 	.fuse_shift_ft_shift = 21,
+	.fuse_shift_cp_bits = 5,
+	.fuse_shift_ft_bits = 4,
+	.fuse_common_reg = FUSE_TSENSOR_COMMON,
 	.fuse_spare_realignment = 0x1fc,
+	.nominal_calib_cp = NOMINAL_CALIB_CP,
+	.nominal_calib_ft = NOMINAL_CALIB_FT,
+	.lower_precision = false,
 };
 
 const struct tegra_soctherm_soc tegra132_soctherm = {
diff --git a/drivers/thermal/tegra/tegra210-soctherm.c b/drivers/thermal/tegra/tegra210-soctherm.c
index d0ff793f18c5..2877a7b43f2a 100644
--- a/drivers/thermal/tegra/tegra210-soctherm.c
+++ b/drivers/thermal/tegra/tegra210-soctherm.c
@@ -201,11 +201,19 @@ static const struct tegra_tsensor tegra210_tsensors[] = {
 static const struct tegra_soctherm_fuse tegra210_soctherm_fuse = {
 	.fuse_base_cp_mask = 0x3ff << 11,
 	.fuse_base_cp_shift = 11,
+	.fuse_shift_cp_mask = 0x1f,
+	.fuse_shift_cp_shift = 0,
 	.fuse_base_ft_mask = 0x7ff << 21,
 	.fuse_base_ft_shift = 21,
 	.fuse_shift_ft_mask = 0x1f << 6,
 	.fuse_shift_ft_shift = 6,
+	.fuse_shift_cp_bits = 5,
+	.fuse_shift_ft_bits = 4,
+	.fuse_common_reg = FUSE_TSENSOR_COMMON,
 	.fuse_spare_realignment = 0,
+	.nominal_calib_cp = NOMINAL_CALIB_CP,
+	.nominal_calib_ft = NOMINAL_CALIB_FT,
+	.lower_precision = false,
 };
 
 static struct tsensor_group_thermtrips tegra210_tsensor_thermtrips[] = {
-- 
2.48.1



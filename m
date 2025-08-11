Return-Path: <linux-pm+bounces-32135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAE3B2013F
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 10:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57212189C348
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 08:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A6C2DC339;
	Mon, 11 Aug 2025 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAjmLAln"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EF72DA77E;
	Mon, 11 Aug 2025 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899491; cv=none; b=TkhsvbJ2dpEDdNU7u9N/BWKe5mJk9eMXODBuTVjNvD1vM1fmXWXtMaeV1wGocM2TiLPE6axmUbtUDd0fUjfpE4qmXFHEnU6Rrw7i40sZ7BsfuaUlWkTpVctjSGWp7d3nM0N3ZU/08W4isS3Omk1mimo9ZDHOb9onvrj0OXv1V3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899491; c=relaxed/simple;
	bh=TgtXIAr3IGEHvtydhEWp8c7auiDqocGddu9PnevEWY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgEtp0GIqwOcQwjmFpB4FCwgrE46AY5AYM05lfREifE6d+grHz3WQpkw93SX/cdSb7Ng1iKMZn4VBpQ9APzOw/Tbra9t8RqEYb8iKhZL3elmsMyKFfB1c2wmGrIl8IEPQDiOY8FgcD4DhvhjktClw5BFGMJvrRavj6pjfI92Scg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAjmLAln; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-af95ecfbd5bso679418266b.1;
        Mon, 11 Aug 2025 01:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754899488; x=1755504288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miny/PoDyZMHIwzlLhKH1Yc3uh/Hp6mfXYgqs94khEQ=;
        b=BAjmLAln3xIMkz/aoT0q5ClY2FO+XpDRzzOuScEas0Wa6zJkQTCAPQr5QUBfOjYXyy
         kDFtt+x8ahSihLdARy1g3uFZOnper6EEs/yQEJBYeaiQgEF1y+86k224UDl9zczQpx5b
         VxVQi4lawDyysummXrKvEfO2Aizk7RvYEJF/tocwl1ZMQXznCRLl/ZLsZdZ8bvM3daz/
         J1pHjEkoA300t9cL9xWMgtekjtL42fr1Zrt2mN3VmvcmpMKKB5atLCpOBtNjPdVW8Iey
         NvBanjPxiJ4Bmf4Zn/W/nSGDeoouWS7wHVbLMYb2PHkwlpwRR6zvlpQ7NeaQd6O/S8RO
         yV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754899488; x=1755504288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miny/PoDyZMHIwzlLhKH1Yc3uh/Hp6mfXYgqs94khEQ=;
        b=TqIM9F6kGU+4rXC0Tp7V29HW8G/IlgWAZVPeTsAeovR9QpPOBc/zSzjy4LExvhFoVh
         eVPk0rUCB94mw9qHvrpBVTIMgVE3lX6hhH5zlpvH9wfIWS6vJMbNeplpr32v7qJu31UK
         fGEBOU8y6TsbYK+9GbnpzZivOectbfd+AOBj9v+DcOgMG5trMsL0hcEXpnr3qRxPkK1a
         HmBw3v5YLUb43e2r4DPkUh6VZpSJt0BE1mjPkT3Z4YdI8xB4N0CMvgtLht3G2AxXKoPW
         igqXzx++WlWM+8KAUIKmwGJZP43I7Q+iFWHP3/iNX5PeiYGkbQh9ABDmrsBb5FRvRt6Y
         XG7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUs0eCemaSRJ6qnk1f42iT3y+qJ1GwYI5ic6xf2kQXhLO4mFhKiZiGkgVrNhzWVtVRFJMvKv5sg6tcbqIy7@vger.kernel.org, AJvYcCWfv6Ju+UcmMEzr6TVkmn9B3njvO4xdxUSq4iqGAeP7Zsii9l9W3/GznBTIAcAP/i6d43+fbQOUtxoD@vger.kernel.org, AJvYcCXOXvCwpPtw5Pbi/jns33yL5rrJ2mi6VSqSa+NL0Ji2h3Lt5wJrqjOySTTGZX7r4km9aPV/3elltAys8uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnsTXRSIpmHFyMziteEcZDdN4mIKkeLT/CLb+cEESf5BuykJ7a
	ooDiYXPCorTLBOWYa4Qt2BAnkdWAtGcMPObqMEFpjkLDwu/mZ8zLieoZ
X-Gm-Gg: ASbGncv+h+yDogaThSdq+gSVbuiGCqCcwLWXjIn7aHUoHdJwczgsUemuFDSah5X6fr1
	S0arsiAesLnoZhv3oqREKVSp7AeZqkjYO2oKD8c6+/e1FxnXjACRGoTy74t3SFs6/UfGFrpoCej
	dMXwYzDBo77bxJSReY2mRgZ2xA9XdJhoATj01qARfKRfU9/GOcpGgSXbkTwjJvmqs+H0PqMirwL
	2mePj4SgkDiXPdnFwB6v6+rrUowqN6XI4uxOEwfwTYxzUZff1WS5SV45b0/SPBMM6TYTg3V1gzv
	76lbod5BorN06/kHUONIBxvXj4FX17LWOtTBK/EmGCoINzKH/JFN0hCypRIEkhQoqqaHZxjHSti
	FYmb4BaOegx/jJQ==
X-Google-Smtp-Source: AGHT+IHIs9owlKlIFRcYdVp75nuuNgVtyha0a+t1N7FB6jqRj5Ux6wTuHvwXUNZxVivGKpT5YEukRg==
X-Received: by 2002:a17:907:c08:b0:ad8:9a86:cf52 with SMTP id a640c23a62f3a-af9c640db18mr1123840666b.11.1754899487851;
        Mon, 11 Aug 2025 01:04:47 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c081sm1956446566b.97.2025.08.11.01.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 01:04:47 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5 RESEND] thermal: tegra: soctherm-fuse: parametrize configuration further
Date: Mon, 11 Aug 2025 11:04:20 +0300
Message-ID: <20250811080422.12300-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250811080422.12300-1-clamor95@gmail.com>
References: <20250811080422.12300-1-clamor95@gmail.com>
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



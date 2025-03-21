Return-Path: <linux-pm+bounces-24384-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA20CA6BDB4
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 15:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C43172573
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 14:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5431EFF96;
	Fri, 21 Mar 2025 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbiyQVug"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A794D1DE882;
	Fri, 21 Mar 2025 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568836; cv=none; b=tPUWWauEU9WzTLhwRv8RBAPOaWve5DTM28MvmuUUrfPJnWsbaX8Mtp/C/F8Di4NENNQ/WafpaQrbg0td3AcYLOs4/WKM8x1Ehhc3/5UzRCPK+Qlq7z8MhA4wTarRQFGdMeEuryVX+S+Rdaj+uU03vFMR+UmOV7CJyUYkm4xoRyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568836; c=relaxed/simple;
	bh=bXozqz1zbgxcW/1dC2QTCWjrRSGB28IIieO7/kJwCZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FD4nt93fbWn78FbHS2MqejxBqitJ/gg5MRn2h4ZftCfJXKr7W6+aflYTG2ZTbFgBrYAOF+6s/wjCnPx5Ff/6aZ2tIsQgPq2hATUANQl8qEAPm0AcVfoALk2ArY+rV/HCPsU02IIOiKkIZuVwHEtOK1GV36IJgYb/grMVoy133YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbiyQVug; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5cded3e2eso2956574a12.0;
        Fri, 21 Mar 2025 07:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742568833; x=1743173633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROgyACEQa48lDCk5T9eREvPyJ322tIX1J/JDdpDWQ9Q=;
        b=kbiyQVugQsQR+R2ASK0GIW3heLIDwcfQ9YC0hsVfEmj5ZSnnklWsI7zxH76Otk6Cyo
         pLdiLUIX/YagpBm02XUMmwqb1Qng0Y7ZOA+3dvkzs46w7YfSAFBrfSpwaQQYXbEKGnnu
         Y5bxx5ulo750eq+LebjsGkaHUHU85zx+bszqps/Z8WYkz0mwASdHSQmpplLveW9Y9iUB
         7DYnqwbz2wyK3gOnibLdrPnO2IKCL3VJ8PoDg0LRVMaiMvFQVo8569cNiOSwhE6fiC2W
         zoQEMD/LEn/TD98KFpNESDJoEL2CDUSUf8NJdlw4lhy5q09b8DT9V8WXjvIa3NT1D2AO
         Zg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742568833; x=1743173633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROgyACEQa48lDCk5T9eREvPyJ322tIX1J/JDdpDWQ9Q=;
        b=kvRYsyrZDpFdtpNwXxg/VUxAGNCbuzg4F1k1wDLrzFx4d24MZ6nuC1TbN62wEBDNa5
         5+rGqt14CrhP2kikS6ezmLyQnGnatOBokdPU2Ii9RBk8VEIjVfNw3hxQ4LkUKM1MvNGv
         yt9EveWP4EAHtP1qZ3KX1Bk63t3o0iSm30OBuXdi7T2VJwrFguFzIBJLmFrQMj95WT7L
         sCFQzm6rRG91zHAfwHzIA4r5josN/WDHUEOBd80x76SJ0SynjwSKPiyGrCrars1xCldJ
         wDYAzZZp1qQPqms0E09xQWooFAFNma0gYosvic1jarefE+1CeJwD2wqV7JA17k2FBXot
         +Q8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWJ0mGGjLc2YCL5gb5p8K9+YqaXBlqyrts46eG6Wt0oCRRsN60AUTQDXgL0XZzvzQ03Gayn31pFR77xMwo@vger.kernel.org, AJvYcCW7P/Afwq2Cvs3KUCn1Ch2eQryqCNeE+XXBDGSe7xQQhWMefca1f4zxPb9Pt37nd1eSjKWogQjPgWpYnp8=@vger.kernel.org, AJvYcCXPTaK2bvwF4Aa6SsdzADy9row/ROoHZzPRYEqGz9jbLoszEUcy44bMA2AN0Gb1fdXI4eyl1adX/vHC@vger.kernel.org
X-Gm-Message-State: AOJu0YzJuH8fHuzdIpS5hgd1FIxSIjxm3ezUKUghpJP2Gd7Iy8ACuBPh
	BFi5xUUAZt9myKlkM2u1/dhuSYyasNlMGLsTtkoI9yV6RfLuiTso
X-Gm-Gg: ASbGncsntLUD2Nac4nWJgWWe5z34qKyssGaoEHHUyykITHKYf5PIBX6DH1VtCMVc+Me
	7YEPUYF3S6ID15oZITDwRMQoirHXD/2c8F6HVlMcFJBApVTSoDzGS9qMyb5Xlhyy2iMPuro+zxe
	I0GFq2/O//gr65gFEK6MzQGHS6JxJRya11ffBzM48mZgoEmNdNKth+axhmyETQr0UMnxHVfeE36
	aGUCm0y+Fs+svpre89hKNNdqIHXQ6cTZLN8W0Di0nVs+Fq+MNdMllXUxv06J1P9s59C6tpjctRo
	TikEeVT8dxs9HbTui0Vf4aGM8/kecu9UryBJ
X-Google-Smtp-Source: AGHT+IF0GxHEx1dybgdsD9nbFWz2jcD0dSzT7hPIH7uUUPWxq4fUeuv43PUsqPceCV34qwOnLnPqLw==
X-Received: by 2002:a17:907:86a7:b0:ab7:9df1:e562 with SMTP id a640c23a62f3a-ac3f2534b34mr425692166b.48.1742568832721;
        Fri, 21 Mar 2025 07:53:52 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efbe038dsm163224666b.138.2025.03.21.07.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:53:52 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] thermal: tegra: soctherm-fuse: parametrize configuration further
Date: Fri, 21 Mar 2025 16:53:24 +0200
Message-ID: <20250321145326.113211-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321145326.113211-1-clamor95@gmail.com>
References: <20250321145326.113211-1-clamor95@gmail.com>
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
2.43.0



Return-Path: <linux-pm+bounces-33216-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB4EB3935C
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 07:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568774602A7
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 05:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376CC27B32F;
	Thu, 28 Aug 2025 05:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuEdLFN2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D60B27815D;
	Thu, 28 Aug 2025 05:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756360282; cv=none; b=EVEwBvvboEQIAIhGX9mg8PzIeVgHyIh4l6NwJUI+VjdghWb4j5LmKltPcWdQhgxJqB2f59+BIN3+B7iQ3uHSnmVDYbsyrO4kxUl6AYPnYdpY//xNDI0gqtTUq9hUqJvFzcl4c/ouuaX4u+fnWUtjih38r/le4+goxIvY93h84oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756360282; c=relaxed/simple;
	bh=xGghdF+YxHFNw8pSj6c5peKw8Mdr03VEx6crNFDbN/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPmmVzD8jcoF2S04vyOJIdFbsh335S7dnwmGIGHlo2gO/Vt1W2oPPIxgusaKJJzjJpPG9zISEuSrq8IWAtuedrT2R6bXBqiX2iS2aFm8wvMWdPVaWkfjcHk731jVXEtTfEDkTG/F0uCqKcdKfAYVHqNBjA4MPYAbX2snFebc4TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuEdLFN2; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb731caaaso74583966b.0;
        Wed, 27 Aug 2025 22:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756360278; x=1756965078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMo+EaU3wmpd3i1lhwB2ecTxiHAt3bJiMrIf7ufmqXg=;
        b=SuEdLFN2OKvkrcMXIh4/5oCgWFaGUrW5fJjy7R/cORIDs05yny0V6/cMJQnZvGe/+X
         zImKaGfMSU38Ee4IECJtXjgMBamS3a2jutd0PIuycJx92mxLL7Useg6RFrYefC199xFC
         lCXDbEed8EQu3Mun1r0KR8u6D4AO8chPukeJo6OgT0zLlehOp5vhVD2rtPkXBOnMaJxm
         adrecRmillD9XTt7fiUIG0MOOHzNpy8FyxbSiIG2i7UxS7I8XWirWICKDPrKdgbp7aXz
         wyjg8Kz9jybqxI1IwfM0sQ6HmMHTi2Aryq2Emhqdef9GYgolGxzL69BPue8sCHVR3FDe
         5e2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756360278; x=1756965078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMo+EaU3wmpd3i1lhwB2ecTxiHAt3bJiMrIf7ufmqXg=;
        b=NsODyNKnO5GFb6zUHBNBCzKvZwDfepzT802i3oQpN4lMBu3xywdEcvcS/+4eXqLdXX
         o23p1uYk4qikIF4OZg3tFFOml2vi4dbcKYgrqXFLAdmIBa/MfLwGxEbifptutJGJKipa
         qG8QksPMN4PLCOumCFrPEYqhfFfo8eVy1z4IaeFr4x34ywXCpinfd1x26vWdICO+jJ/E
         0976FKOqu2/lbMjZ74PkZASi0bCbtwLNdYfpFc0IoI+O5ekvktE4SajRAIUXosc9SDlM
         RGcftwYHumdAlVm3BWouz5WfSU6Tp7CFmVGFUC0jX/3RZXDf63E+9MEreKg8of6NX3HL
         fgdw==
X-Forwarded-Encrypted: i=1; AJvYcCUezq+iwUgYNcZ4BrdO3VUihduA49kvaoGUKqkn3wL73VJK67TI3Ac3JVeumFqUN2+kY00w48FEB0dFv7A=@vger.kernel.org, AJvYcCWxBr2GVRc57wq3dBt+H7J24q6gFNrfp8tzWc3zRyViLO/kA4UeRB48GP+zicCe7f8a2fdGzRPiO7qlS3c4@vger.kernel.org, AJvYcCXX8GHjq1nY8sxf0ceIonkw/5JcdEqVRAVabMlQf1p642Bpj29RbWiACZUkTShJosgpxabCJq1IEeZ5@vger.kernel.org
X-Gm-Message-State: AOJu0YwhvRo5FwWlEENd/inxgzzUsZ39cAty/1u6FVKLTw+Bjfpj9V5o
	T2bUoa9pDlhz5nZh9YRG70hPS5oidL+ktPu+5CMoV0GqRuYXAAvj11eh
X-Gm-Gg: ASbGncvkB1+cBiB+eM8d2Y2BV4bX43Rypr3ETc3pTTOXmwXjNor+BHISkukkl+pvw67
	F69Cn7kAUDXhzTmCVAkq4zYOK8R1ID/UUInEAyoNHkOdGXEg3wWDe8ZILE3fH+ySHSakgSc/c+P
	7E0DWgbTVyTvxXXyFvgr/ARnSfHH5r2XFJBqngynNXi1pk/OxGnbEnGvm7Vqo36e9H074XVwyu2
	U4yCvHs3Sk0bKmEJYG8G/YCKEE7hlO4V2tIwfdS/T8Lzf4g7sfHXufV4V3OopUZsplQksV+RCoD
	Crab+8EvrT2qcdk8q4QJ5Q0Rt3DdLFYQ/7ayjMPfr/xhetIPlU/mHHwQavo0DIQ+pkNNMJ0vWck
	zJIyu4VMXP+eYeiA1YGetVtEl
X-Google-Smtp-Source: AGHT+IFB16XgyivDqWaSzYi5/lRqPG8sqcjcgXmR97yDLHFXUyKPqRVIXHt/vjTyrAEbkPHoOocF5A==
X-Received: by 2002:a17:907:d29:b0:afe:efa1:75e4 with SMTP id a640c23a62f3a-afeefa1bf34mr25789766b.17.1756360278390;
        Wed, 27 Aug 2025 22:51:18 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe72c35ebdsm927942666b.7.2025.08.27.22.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 22:51:18 -0700 (PDT)
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
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/6] thermal: tegra: soctherm-fuse: prepare calibration for Tegra114 support
Date: Thu, 28 Aug 2025 08:51:01 +0300
Message-ID: <20250828055104.8073-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250828055104.8073-1-clamor95@gmail.com>
References: <20250828055104.8073-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Tegra114 has a different fuse calibration register layout and address
compared to other Tegra SoCs, requiring SOCTHERM shift, mask, register
address, and nominal tf calibration value to be configurable.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/thermal/tegra/soctherm-fuse.c     | 18 ++++++++++++------
 drivers/thermal/tegra/soctherm.h          |  7 ++++++-
 drivers/thermal/tegra/tegra124-soctherm.c |  4 ++++
 drivers/thermal/tegra/tegra132-soctherm.c |  4 ++++
 drivers/thermal/tegra/tegra210-soctherm.c |  4 ++++
 5 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm-fuse.c b/drivers/thermal/tegra/soctherm-fuse.c
index 190f95280e0b..8d37cd8c9122 100644
--- a/drivers/thermal/tegra/soctherm-fuse.c
+++ b/drivers/thermal/tegra/soctherm-fuse.c
@@ -9,15 +9,12 @@
 
 #include "soctherm.h"
 
-#define NOMINAL_CALIB_FT			105
 #define NOMINAL_CALIB_CP			25
 
 #define FUSE_TSENSOR_CALIB_CP_TS_BASE_MASK	0x1fff
 #define FUSE_TSENSOR_CALIB_FT_TS_BASE_MASK	(0x1fff << 13)
 #define FUSE_TSENSOR_CALIB_FT_TS_BASE_SHIFT	13
 
-#define FUSE_TSENSOR_COMMON			0x180
-
 /*
  * Tegra210: Layout of bits in FUSE_TSENSOR_COMMON:
  *    3                   2                   1                   0
@@ -26,7 +23,7 @@
  * |       BASE_FT       |      BASE_CP      | SHFT_FT | SHIFT_CP  |
  * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
  *
- * Tegra12x, etc:
+ * Tegra124:
  * In chips prior to Tegra210, this fuse was incorrectly sized as 26 bits,
  * and didn't hold SHIFT_CP in [31:26]. Therefore these missing six bits
  * were obtained via the FUSE_SPARE_REALIGNMENT_REG register [5:0].
@@ -44,6 +41,13 @@
  * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
  * |---------------------------------------------------| SHIFT_CP  |
  * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *
+ * Tegra114: Layout of bits in FUSE_TSENSOR_COMMON aka FUSE_VSENSOR_CALIB:
+ *    3                   2                   1                   0
+ *  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ * | SHFT_FT |       BASE_FT       | SHIFT_CP  |      BASE_CP      |
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
  */
 
 #define CALIB_COEFFICIENT 1000000LL
@@ -77,7 +81,7 @@ int tegra_calc_shared_calib(const struct tegra_soctherm_fuse *tfuse,
 	s32 shifted_cp, shifted_ft;
 	int err;
 
-	err = tegra_fuse_readl(FUSE_TSENSOR_COMMON, &val);
+	err = tegra_fuse_readl(tfuse->fuse_common_reg, &val);
 	if (err)
 		return err;
 
@@ -96,10 +100,12 @@ int tegra_calc_shared_calib(const struct tegra_soctherm_fuse *tfuse,
 			return err;
 	}
 
+	shifted_cp = (val & tfuse->fuse_shift_cp_mask) >>
+		     tfuse->fuse_shift_cp_shift;
 	shifted_cp = sign_extend32(val, 5);
 
 	shared->actual_temp_cp = 2 * NOMINAL_CALIB_CP + shifted_cp;
-	shared->actual_temp_ft = 2 * NOMINAL_CALIB_FT + shifted_ft;
+	shared->actual_temp_ft = 2 * tfuse->nominal_calib_ft + shifted_ft;
 
 	return 0;
 }
diff --git a/drivers/thermal/tegra/soctherm.h b/drivers/thermal/tegra/soctherm.h
index 70501e73d586..083388094fd4 100644
--- a/drivers/thermal/tegra/soctherm.h
+++ b/drivers/thermal/tegra/soctherm.h
@@ -56,6 +56,9 @@
 #define SENSOR_TEMP2_MEM_TEMP_MASK		(0xffff << 16)
 #define SENSOR_TEMP2_PLLX_TEMP_MASK		0xffff
 
+#define FUSE_VSENSOR_CALIB			0x08c
+#define FUSE_TSENSOR_COMMON			0x180
+
 /**
  * struct tegra_tsensor_group - SOC_THERM sensor group data
  * @name: short name of the temperature sensor group
@@ -109,9 +112,11 @@ struct tsensor_group_thermtrips {
 
 struct tegra_soctherm_fuse {
 	u32 fuse_base_cp_mask, fuse_base_cp_shift;
+	u32 fuse_shift_cp_mask, fuse_shift_cp_shift;
 	u32 fuse_base_ft_mask, fuse_base_ft_shift;
 	u32 fuse_shift_ft_mask, fuse_shift_ft_shift;
-	u32 fuse_spare_realignment;
+	u32 fuse_common_reg, fuse_spare_realignment;
+	u32 nominal_calib_ft;
 };
 
 struct tsensor_shared_calib {
diff --git a/drivers/thermal/tegra/tegra124-soctherm.c b/drivers/thermal/tegra/tegra124-soctherm.c
index 20ad27f4d1a1..d86acff1b234 100644
--- a/drivers/thermal/tegra/tegra124-soctherm.c
+++ b/drivers/thermal/tegra/tegra124-soctherm.c
@@ -200,11 +200,15 @@ static const struct tegra_tsensor tegra124_tsensors[] = {
 static const struct tegra_soctherm_fuse tegra124_soctherm_fuse = {
 	.fuse_base_cp_mask = 0x3ff,
 	.fuse_base_cp_shift = 0,
+	.fuse_shift_cp_mask = 0x3f,
+	.fuse_shift_cp_shift = 0,
 	.fuse_base_ft_mask = 0x7ff << 10,
 	.fuse_base_ft_shift = 10,
 	.fuse_shift_ft_mask = 0x1f << 21,
 	.fuse_shift_ft_shift = 21,
+	.fuse_common_reg = FUSE_TSENSOR_COMMON,
 	.fuse_spare_realignment = 0x1fc,
+	.nominal_calib_ft = 105,
 };
 
 const struct tegra_soctherm_soc tegra124_soctherm = {
diff --git a/drivers/thermal/tegra/tegra132-soctherm.c b/drivers/thermal/tegra/tegra132-soctherm.c
index b76308fdad9e..64c0363b9717 100644
--- a/drivers/thermal/tegra/tegra132-soctherm.c
+++ b/drivers/thermal/tegra/tegra132-soctherm.c
@@ -200,11 +200,15 @@ static struct tegra_tsensor tegra132_tsensors[] = {
 static const struct tegra_soctherm_fuse tegra132_soctherm_fuse = {
 	.fuse_base_cp_mask = 0x3ff,
 	.fuse_base_cp_shift = 0,
+	.fuse_shift_cp_mask = 0x3f,
+	.fuse_shift_cp_shift = 0,
 	.fuse_base_ft_mask = 0x7ff << 10,
 	.fuse_base_ft_shift = 10,
 	.fuse_shift_ft_mask = 0x1f << 21,
 	.fuse_shift_ft_shift = 21,
+	.fuse_common_reg = FUSE_TSENSOR_COMMON,
 	.fuse_spare_realignment = 0x1fc,
+	.nominal_calib_ft = 105,
 };
 
 const struct tegra_soctherm_soc tegra132_soctherm = {
diff --git a/drivers/thermal/tegra/tegra210-soctherm.c b/drivers/thermal/tegra/tegra210-soctherm.c
index d0ff793f18c5..f6e1493f0202 100644
--- a/drivers/thermal/tegra/tegra210-soctherm.c
+++ b/drivers/thermal/tegra/tegra210-soctherm.c
@@ -201,11 +201,15 @@ static const struct tegra_tsensor tegra210_tsensors[] = {
 static const struct tegra_soctherm_fuse tegra210_soctherm_fuse = {
 	.fuse_base_cp_mask = 0x3ff << 11,
 	.fuse_base_cp_shift = 11,
+	.fuse_shift_cp_mask = 0x3f,
+	.fuse_shift_cp_shift = 0,
 	.fuse_base_ft_mask = 0x7ff << 21,
 	.fuse_base_ft_shift = 21,
 	.fuse_shift_ft_mask = 0x1f << 6,
 	.fuse_shift_ft_shift = 6,
+	.fuse_common_reg = FUSE_TSENSOR_COMMON,
 	.fuse_spare_realignment = 0,
+	.nominal_calib_ft = 105,
 };
 
 static struct tsensor_group_thermtrips tegra210_tsensor_thermtrips[] = {
-- 
2.48.1



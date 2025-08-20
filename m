Return-Path: <linux-pm+bounces-32709-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBC3B2DB73
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 13:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 770B05E7C25
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 11:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1E12E5414;
	Wed, 20 Aug 2025 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HILHGdr9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1709F2E7193;
	Wed, 20 Aug 2025 11:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690184; cv=none; b=Ha8SsCF/NbUAb9UsDY7QVgboaGj8KmeiB/k+PYXxgT97j8MXVXKnp3MUFlA0ROirjo37CX4uwFsBkkVzZZkcGj/ylns9zoFTDsDhELXGdA3yAmBeWx6o3kddxGLymoNmHhvXBz+KA+P7aorhI6HihM1LMiL9OmgdexbI7VR9sv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690184; c=relaxed/simple;
	bh=vr7XBH6PzPO3Qxf0eqiCZHcAH+UF+qjDbxW6PCZGkjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JT5zGPNT4Y5k0UnkT8QY+X9jvoLj3gzjUKfm5CHRVLrhr32Yz65mkY/VmpQcVpAwH2XaOnw7gzuO4t6d2O7aXfOnL7hPu3EZp4w46e7Eii+jwdSCnxs/5smV8nDjUogSHAa61flvmexWPfeblBvKa7jReag/EOEiRSNLJExyA1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HILHGdr9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7a0442bso937659766b.2;
        Wed, 20 Aug 2025 04:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755690180; x=1756294980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69DveKJDLTs430j/2s4hdffs4b2nEbpa6FOS1JSfybQ=;
        b=HILHGdr9aa6qInbqyavkB2nD/KmFrTJtuCkjTdMo0POs1TkKQUi2haORHGCrAoc1Pu
         cjdWCt2thjklefMcDh5IMgagMKjkTMU2aKLY0BFOu2soPJHi5ZuaXvokQcnwhPsYaYLO
         govJ6E9wa/EQ+5pBSAfBxAEDuOJKHq96B3l1HdcY4zbEQMFmRZUANO+WeP3/M0Qa0bn3
         iV7AjUSgF0S3o2Ij6SFgRS2t8JyO7rfrg1FY8KOJazQTsb+p8J22va0BL8GG0veBhLs/
         Qw2ibStD0j4O0MiRUCGlDbIH0WLwvtZ8ttXXPiyzf9HmtODOoZqfTWCefWOfvlnkST5j
         qqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755690180; x=1756294980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69DveKJDLTs430j/2s4hdffs4b2nEbpa6FOS1JSfybQ=;
        b=sQR1tKjP15VpJEMZKctcWbgXpqLX9rOhZJtNYrAR61Y2H078qR4Gbb8JtWatDpMLNL
         U56/vicN0Fl23xg5Sywvb1X7wvfQn5e9rTncp9JJXJZoQXN4TbWpXMMEaQKDIL2UVZTB
         Z/3Pyl4lztKgFAphIUBSvyiCr4jtBOS4WbY3LzplJtK8mLGcdVKh3LVVdkfdVyxgliCp
         M20OuBgv8vL1mvHiM0yZcWS48xjFl11YzOSv/+N5ipXB2X//AEIWkeCghuXe/8UsjK1z
         OQoZGOE9c7yozKIIfR1/vKEzkhJ2e2yb1+IeJ+AsKyQc0uJPlOOUhRwNHtVCKH3eTICi
         D+zw==
X-Forwarded-Encrypted: i=1; AJvYcCU3pnbYTc4xLUupOBBh8ijEyDJ9nB9eHFg5/+XcUmvMVBm1xCmTedcnykDdGjOlU8vyuyVNRyUC3ooJ@vger.kernel.org, AJvYcCVCoalpiLoSQtSU1bB7D/5PuEj6i9xdWNjb24DyQ5EwoiFdOEKErzGBEkhbaTHPZXUkV2Q9zdx9dkM97ZQ=@vger.kernel.org, AJvYcCVibUQYuoa+8LRHeFhZ9JEM9QeUoJSrWNHhGuiHd8muO5JJXiACs/Lq+yH04c5Cx2Z+d4mQvImHLzR74wVm@vger.kernel.org
X-Gm-Message-State: AOJu0YzEutCROzMyrPwE9hZY9WSf9mj3CEmP1W7bStCHxpTRPVNHUqCE
	flStZ/ZpybLaDDuKXYPvhLF6JUUMju3OpJhdp0+YaWa6Gpxo1rl5P6yz+szhuA==
X-Gm-Gg: ASbGncs9qgwjqNvbplAsbwCER4Siz+56J0S1Xb9O0QeUXQtluasq0khvZm2bDSigBoh
	4Cv+VIK2PBJSAUJcRr679r8xddxhU+HjMXQf4WGaWTYK9V1lysBotWOaP1oz+QeDbSkYPf7hVpQ
	5xF0dCL/vwRJkeME1WtazchBb+6tUS//pTb4YIDQUGQtRnk4ewY7OfIiN5Xugf4TnoMQT0oJigV
	HeBuceBjDTuNv0kGJrZP6aKzhoarKUAU7qhPFNxWkL3xucJIv3+/bGin64EJsBUAMBjI+L85nug
	VO1GGewKdOD7oYdwyoxMbvit4XeL0NAsGtXWjWnw0RclciKiwNtLzYbtTG+i2rqwsZBEVPpO1B/
	F9bpW7Apo0eNS7w==
X-Google-Smtp-Source: AGHT+IGHo+JPFhs20YuS3LZIR6B2WF52XvvcX9/sNYFrQnHHfTnyNbpalJbzpfzvvivtbUW/OPN8bg==
X-Received: by 2002:a17:906:9fd0:b0:aec:64bf:a393 with SMTP id a640c23a62f3a-afdf01c5451mr169369766b.38.1755690180212;
        Wed, 20 Aug 2025 04:43:00 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded4ca695sm161769566b.90.2025.08.20.04.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:42:59 -0700 (PDT)
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
	Svyatoslav Ryhel <clamor95@gmail.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] thermal: tegra: soctherm-fuse: prepare calibration for Tegra114 support
Date: Wed, 20 Aug 2025 14:42:28 +0300
Message-ID: <20250820114231.150441-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250820114231.150441-1-clamor95@gmail.com>
References: <20250820114231.150441-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Tegra114 has a different fuse calibration register layout and address
compared to other Tegra SoCs, requiring SOCTHERM shift, mask, register
address, and nominal calibration values to be configurable.

Additionally, a use_lower_precision option was implemented to account for
the Tegra114's 0.5C thermal data output, which differs from the 1C
precision of newer SoCs.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/thermal/tegra/soctherm-fuse.c     | 31 ++++++++++++++++-------
 drivers/thermal/tegra/soctherm.h          |  8 +++++-
 drivers/thermal/tegra/tegra124-soctherm.c |  6 +++++
 drivers/thermal/tegra/tegra132-soctherm.c |  6 +++++
 drivers/thermal/tegra/tegra210-soctherm.c |  6 +++++
 5 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm-fuse.c b/drivers/thermal/tegra/soctherm-fuse.c
index 190f95280e0b..d27876dd9b2a 100644
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
@@ -26,7 +21,7 @@
  * |       BASE_FT       |      BASE_CP      | SHFT_FT | SHIFT_CP  |
  * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
  *
- * Tegra12x, etc:
+ * Tegra124:
  * In chips prior to Tegra210, this fuse was incorrectly sized as 26 bits,
  * and didn't hold SHIFT_CP in [31:26]. Therefore these missing six bits
  * were obtained via the FUSE_SPARE_REALIGNMENT_REG register [5:0].
@@ -44,6 +39,13 @@
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
@@ -77,7 +79,7 @@ int tegra_calc_shared_calib(const struct tegra_soctherm_fuse *tfuse,
 	s32 shifted_cp, shifted_ft;
 	int err;
 
-	err = tegra_fuse_readl(FUSE_TSENSOR_COMMON, &val);
+	err = tegra_fuse_readl(tfuse->fuse_common_reg, &val);
 	if (err)
 		return err;
 
@@ -96,10 +98,21 @@ int tegra_calc_shared_calib(const struct tegra_soctherm_fuse *tfuse,
 			return err;
 	}
 
+	shifted_cp = (val & tfuse->fuse_shift_cp_mask) >>
+		     tfuse->fuse_shift_cp_shift;
 	shifted_cp = sign_extend32(val, 5);
 
-	shared->actual_temp_cp = 2 * NOMINAL_CALIB_CP + shifted_cp;
-	shared->actual_temp_ft = 2 * NOMINAL_CALIB_FT + shifted_ft;
+	shared->actual_temp_cp = 2 * tfuse->nominal_calib_cp + shifted_cp;
+	shared->actual_temp_ft = 2 * tfuse->nominal_calib_ft + shifted_ft;
+
+	/*
+	 * Tegra114 provides fuse thermal corrections in 0.5C while newer
+	 * SoCs provide data in 1C
+	 */
+	if (tfuse->use_lower_precision) {
+		shared->actual_temp_cp /= 2;
+		shared->actual_temp_ft /= 2;
+	}
 
 	return 0;
 }
diff --git a/drivers/thermal/tegra/soctherm.h b/drivers/thermal/tegra/soctherm.h
index 70501e73d586..f8d76ae716fe 100644
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
@@ -109,9 +112,12 @@ struct tsensor_group_thermtrips {
 
 struct tegra_soctherm_fuse {
 	u32 fuse_base_cp_mask, fuse_base_cp_shift;
+	u32 fuse_shift_cp_mask, fuse_shift_cp_shift;
 	u32 fuse_base_ft_mask, fuse_base_ft_shift;
 	u32 fuse_shift_ft_mask, fuse_shift_ft_shift;
-	u32 fuse_spare_realignment;
+	u32 fuse_common_reg, fuse_spare_realignment;
+	u32 nominal_calib_cp, nominal_calib_ft;
+	bool use_lower_precision;
 };
 
 struct tsensor_shared_calib {
diff --git a/drivers/thermal/tegra/tegra124-soctherm.c b/drivers/thermal/tegra/tegra124-soctherm.c
index 20ad27f4d1a1..e0a40ca2a6ac 100644
--- a/drivers/thermal/tegra/tegra124-soctherm.c
+++ b/drivers/thermal/tegra/tegra124-soctherm.c
@@ -200,11 +200,17 @@ static const struct tegra_tsensor tegra124_tsensors[] = {
 static const struct tegra_soctherm_fuse tegra124_soctherm_fuse = {
 	.fuse_base_cp_mask = 0x3ff,
 	.fuse_base_cp_shift = 0,
+	.fuse_shift_cp_mask = 0x1f,
+	.fuse_shift_cp_shift = 0,
 	.fuse_base_ft_mask = 0x7ff << 10,
 	.fuse_base_ft_shift = 10,
 	.fuse_shift_ft_mask = 0x1f << 21,
 	.fuse_shift_ft_shift = 21,
+	.fuse_common_reg = FUSE_TSENSOR_COMMON,
 	.fuse_spare_realignment = 0x1fc,
+	.nominal_calib_cp = 25,
+	.nominal_calib_ft = 105,
+	.use_lower_precision = false,
 };
 
 const struct tegra_soctherm_soc tegra124_soctherm = {
diff --git a/drivers/thermal/tegra/tegra132-soctherm.c b/drivers/thermal/tegra/tegra132-soctherm.c
index b76308fdad9e..138d76c67114 100644
--- a/drivers/thermal/tegra/tegra132-soctherm.c
+++ b/drivers/thermal/tegra/tegra132-soctherm.c
@@ -200,11 +200,17 @@ static struct tegra_tsensor tegra132_tsensors[] = {
 static const struct tegra_soctherm_fuse tegra132_soctherm_fuse = {
 	.fuse_base_cp_mask = 0x3ff,
 	.fuse_base_cp_shift = 0,
+	.fuse_shift_cp_mask = 0x1f,
+	.fuse_shift_cp_shift = 0,
 	.fuse_base_ft_mask = 0x7ff << 10,
 	.fuse_base_ft_shift = 10,
 	.fuse_shift_ft_mask = 0x1f << 21,
 	.fuse_shift_ft_shift = 21,
+	.fuse_common_reg = FUSE_TSENSOR_COMMON,
 	.fuse_spare_realignment = 0x1fc,
+	.nominal_calib_cp = 25,
+	.nominal_calib_ft = 105,
+	.use_lower_precision = false,
 };
 
 const struct tegra_soctherm_soc tegra132_soctherm = {
diff --git a/drivers/thermal/tegra/tegra210-soctherm.c b/drivers/thermal/tegra/tegra210-soctherm.c
index d0ff793f18c5..1127b4d28087 100644
--- a/drivers/thermal/tegra/tegra210-soctherm.c
+++ b/drivers/thermal/tegra/tegra210-soctherm.c
@@ -201,11 +201,17 @@ static const struct tegra_tsensor tegra210_tsensors[] = {
 static const struct tegra_soctherm_fuse tegra210_soctherm_fuse = {
 	.fuse_base_cp_mask = 0x3ff << 11,
 	.fuse_base_cp_shift = 11,
+	.fuse_shift_cp_mask = 0x1f,
+	.fuse_shift_cp_shift = 0,
 	.fuse_base_ft_mask = 0x7ff << 21,
 	.fuse_base_ft_shift = 21,
 	.fuse_shift_ft_mask = 0x1f << 6,
 	.fuse_shift_ft_shift = 6,
+	.fuse_common_reg = FUSE_TSENSOR_COMMON,
 	.fuse_spare_realignment = 0,
+	.nominal_calib_cp = 25,
+	.nominal_calib_ft = 105,
+	.use_lower_precision = false,
 };
 
 static struct tsensor_group_thermtrips tegra210_tsensor_thermtrips[] = {
-- 
2.48.1



Return-Path: <linux-pm+bounces-33010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08308B33CF8
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 12:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88053BBD25
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 10:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD8B2DF3C6;
	Mon, 25 Aug 2025 10:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3f3gdp6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C612DC334;
	Mon, 25 Aug 2025 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118455; cv=none; b=ZmmPlTq4e9+8XWmBBE+62JOuMw1p4dztTMHDacXipHXGBlE7W4LzLMeeZFnIj1OHVPILO8dK75yG7TEzl/tn+Ht2TgGAPxkShtbexsMTFQbuBYNhGde9N8tSCrLEiV7+4G4VvlnyD6z+F2GXSynr3V4DcPsrhT2QV24O7e+hdL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118455; c=relaxed/simple;
	bh=Xnt45zbD35wLoTl+5AbCCdKKoirSW1oz8V3Bwu2UoxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMtIx5HxSRI/E36M+JRDj+YrAPfZjCu91tDcyGfSjgf009jyYz5UdqZVjLohBkAt0fSyGGYT+JEs97ZUH8DAjZ1ejtxYYdZXihCTgzG4At+swjwCdjDlUI/lNtklabTli/AcpkIrf966ILU4hHmaqRO2YvPfear7s9mTZ8fgyQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3f3gdp6; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61c7942597fso753411a12.0;
        Mon, 25 Aug 2025 03:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756118451; x=1756723251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyE6oXJ2IS2LcgbbXFvVftjrnRH0L4njKeQQ5fQnHMg=;
        b=K3f3gdp6EJ/USYk/2WbgGDU7KjVtjX9Kfg3ulE5PxZ7Y7Qyss84HDzOVtOLwaODSbK
         qg3xtlesneG/N0aesvXHTcpYRDKS14NiXHdi5v2/hNIkrFJuQDQdJpfAD2grZeL9J4fj
         twFnLVBB0ElvYvrDsdwKbtJSPx2E0pzt8TqEIlTZmaTlKoiHtfhCSqrzaoHbyOkaVu6v
         o+YXB2uZu44eJEgCsey762lqZEEHU6hZTwVRgOAj3z6QY34HcCIP0WiaZ2wjmawwttIn
         2wa1ZYAu7ikihvWpASrPZlgpIlO9GlwYXkppdwLiJ7aq0XKpOBzNgyTrhYBHK3tGZgi9
         brKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756118451; x=1756723251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyE6oXJ2IS2LcgbbXFvVftjrnRH0L4njKeQQ5fQnHMg=;
        b=m5A2fgA1EoUqMPPIRUnwmHDBWReOkX48rr/F7Iau2jZZ51FFADjXadOWbHg1B0W9rg
         fSJF5bQD2BlSQAb+lnJJmhINGa3NDcKEz17rZXmSkUu00K8Ith2LlN9OlJAF5pSXo/Sw
         Cvnp0xPVRfKZ3fJsf7Gkpc/i+JMIp/TK7N6mE7DvAmY1ThjDp8qDWD4hxyDzB4l4sCxP
         cfxuF6+Lh3XIsBHym4zbDAxKVUML+wlzG44MyVK3ixIIV/TyYBhJHTMhD0PgGN8iJqFg
         eaPtjjWeAbuAasSjf+pLDYXIYpvqAOdb+tf5bRyODSOtu3oRH+y3Wx+DuWl7gSCRU7CQ
         KuIg==
X-Forwarded-Encrypted: i=1; AJvYcCUgoNeANTLWFB+O7v2yVe8TagAklS0XRfXW+exQ1EuBoo8KlFIXlsj8ldJelsKZFJtVojaccz3Fd1FmcE4=@vger.kernel.org, AJvYcCWGP/R0roUQPgcRpKT3tZJIqZaitOebUx6zNYI4Y4c2gL9cywRDacYL6qPhwwMfvYbOLR2g8XnWFR8UC2fR@vger.kernel.org, AJvYcCXJ+iGeHrPXGdegI380sdmRgMWDo/sFGj8itaPPuSpdo4N2lNv9E9SlWwYcoemDXQI3RASH01sCsNPT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3zzmyUocNZ/L5fa0G/wJ5RD0dQpreZewxzwZuywndX4r/GOPV
	jmeYHWe/Jq4WRO5Qua5V5rIlbyakctQD+2D0hODoKyg5DnAyyozCsssK
X-Gm-Gg: ASbGncvo0ZoHirmQcBxgIBmezfRr7g0PCvZFtkqS1/0fKoeSK7jAb3k8cbHVjbidgjP
	GtVI4uq0CuEoL0oAvhUduP2HzFcZMHjoc723v1Yo5dGc4yhQn0inPlJpS4Sqv3g5M7ha8VJlt/n
	tM9fkjQljb6qlO9bLlI7xNSlbXgRacqWUFwiSBLD7Lnbq6uAgcy/R66Q7/VxA5obj6yK4nXGQXv
	5BRMWTV7qTygfWL52PhJkbUg+PzE7GnN1IOHbkZy2RmwkrZQc4GclhFL3K4AXrGUHxHwSn0qIyF
	oeTIYCfM0r/kfPQotLStXzQ+Wo3XmsR5jZgY+PZXyjavKY3izWEKo5RFu/1Qdx9RQ66vl1YT8Uj
	FjRnDqkaTIhNxDw==
X-Google-Smtp-Source: AGHT+IHDJZ5eAUFCgeYyRkFXmY57VnWYdlYZ8q/iUOvxKQXhjKrlkA38oVpRnDDM/xZ4QYfXyqJK2w==
X-Received: by 2002:a17:906:bc47:b0:afe:834e:ac6c with SMTP id a640c23a62f3a-afe834eb4e2mr177878866b.7.1756118451285;
        Mon, 25 Aug 2025 03:40:51 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe48fc0912sm531683166b.42.2025.08.25.03.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 03:40:50 -0700 (PDT)
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
Subject: [PATCH v4 3/6] thermal: tegra: soctherm-fuse: prepare calibration for Tegra114 support
Date: Mon, 25 Aug 2025 13:40:23 +0300
Message-ID: <20250825104026.127911-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250825104026.127911-1-clamor95@gmail.com>
References: <20250825104026.127911-1-clamor95@gmail.com>
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



Return-Path: <linux-pm+bounces-30770-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA95B0395F
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 10:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD934A0185
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 08:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B956323BCFA;
	Mon, 14 Jul 2025 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnrPjiH8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BE323A9BB;
	Mon, 14 Jul 2025 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481394; cv=none; b=PQXP9bq203R8qeHIVeZy0E/z/VnBUPZmsfFWghkWoiM5EERzjYyHAouHfrPcdI7OfbgjbetbUVmpDQalAZ8N69dVZnNHFpmnnJdzG3DD0Mw9NieiKdJUnuODfByvS+KZoAB5KSr1E5T0gi2NDR3AMs8sZOlRlf0hXm9VzTqMJuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481394; c=relaxed/simple;
	bh=e/AbcwBM9uIFEwZ/6mpXZP2Y3Z4bGt/eHFgnbobATzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtUcJglQn1RNVlEP0KGZtLQKR8mywQiCU2047d4kwHPuG9UyLXwzWsRqXdaX8XaQ/szyQkjaf315y6JVY8gcBMOksGoR3WcNvgGVhrapX26qgoMaE/ZcboaJC38itI/1KD/nN+UG4d0hHlMciRik7za2rD0x5pkyXwKgvyyr+jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnrPjiH8; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-558facbc19cso3154066e87.3;
        Mon, 14 Jul 2025 01:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752481391; x=1753086191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jv63TPoByrIyI7mUvMKjVHJSZMGf19SIsGRaSMWTF9U=;
        b=EnrPjiH8KzLL5jpO9FLX22VsfMzB95Ul9bxaLH7u6FoB+Sbqdq+OWia1hB+6iBagTd
         hnYTKaTeunyBVbDRnMQLOknYHanXQ2nA96yMe+P0Z511VixCHUENnCvQ8rEHBY8LEuSV
         AVWHIxjot1JaWz9CQPbUaAGEzmDoWhyDhsIQJB+niZLL3qcooe9gNI+XhnHHbDtPfky8
         5Xen0usHwlmaxVyGR4BYTKLmyMBTMP5QTBQbmwO/ebAoSMCWMY6oJ8MXknEqNR/uNQXN
         o56bKgvtYtCrjHM7Ci7/4qmkqr1Mj2HLfmfXUHlc2TQJ6l3nnW/ispLfEUW0RHDVT+XV
         Oqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752481391; x=1753086191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jv63TPoByrIyI7mUvMKjVHJSZMGf19SIsGRaSMWTF9U=;
        b=vDrjr3DDe87Ii5VV4cYs/KeWxL/+IAnnf0lfYbqTCdNuwJG9NNtEZnhkuz0/Y5pBp9
         AEGQJQp9dcua8XmS6FeSToqimbSAx9nmOmb+evovap8Y92Fu2wi/LAPHLkNiJuiCDeJ3
         Z29/9GK8iOBPgHcno5r7CPPiZzjy5ZT01OA/suw6AgWAcuwLm9lEjZ++GjSqsZKOEgEW
         tJStnu5I/HKYcL4Q9efJTuycEUEbu4ryXhNA1lcwaGANGCWfMIBmU+ptEvVULfImsfSe
         xs9tyeRspC1gI3Co+W0pjTNi7F57Yq4Zkp3pQgxy3T9zpIBPzSVl9C/gQ4ed9PCoAj5N
         g8cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiJnsE3ZqMg4vglshjWhLr68Z3Y8UTPI1IR8drW4Jo0+v7nHukjT9gLOpa8ehLkyrtMvZoHYM3bkos7gin@vger.kernel.org, AJvYcCV5uUE2wqmr3qXrXgpqsETyKeQjvKATTBSCdf7bpZ6t0jRVbNbatH8TSvIgRuJXtNnVhb+reM0RoL2D2U0=@vger.kernel.org, AJvYcCW21V60eVHeeZZK6PGabeLaT7xpRQ7r1LByy9sS6QxnZRFZ90KgS8n5XNL9+3/vI3yfDyeFrmPNLdHZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxaEkKsC88wbulj0btQeN2Y1QbYcUZ5ia5GLhxbkir9WSQ2+nSC
	ik/bHWHPLqJIpP00ohVmGBjV1jUG8awVJJ2z1Wrqn43Q47/DuecWdggbjWei9g==
X-Gm-Gg: ASbGnctjo1qApcdFPhgRrYpYXdzuUf85YWem3i4Ik8poziQYnovWSl2JnoKCFzIuhrr
	9/SS6RTZPeaXnY+ODtQ71sUujpjt4f0NhOH/9PWFrMOIZgC29nh+0iFfT985vRyITxP1mm6KXyl
	AwaUIyTlUi7Qg5zwRpF+3ve5Dl/FbNmpeeVAIiKBVf+D9u91QFFExvyESMOMqsNDO/paM4Pk0eo
	47Kp1yhZj2crmvyjsaAo10pI4ZzkLKyrPCA0HMCNzSrQjHhc/dEKlXbR6eIYyqdOcxogvdsycxy
	gDt1L8P9h5vyTkoQfvldjG4KMiQ6CFPg9TGPnm9ZV+xjyBiprCSB960yqyz5Ktsy4UilFpZm3+e
	Mg12FsVqh41Mbfw==
X-Google-Smtp-Source: AGHT+IFWIm/1du1E9goD8K0HMm58wP6nFtbtAkp6kgsVQZapdXpGamxEE2sU+7knP42ZSgmU+w5Pdw==
X-Received: by 2002:a05:6512:a8f:b0:553:2154:7bda with SMTP id 2adb3069b0e04-55a04633fdfmr3678522e87.38.1752481390457;
        Mon, 14 Jul 2025 01:23:10 -0700 (PDT)
Received: from xeon.. ([188.163.112.60])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7bbd55sm1885717e87.23.2025.07.14.01.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 01:23:10 -0700 (PDT)
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
Subject: [PATCH v2 1/5] soc: tegra: fuse: add Tegra114 nvmem cells and fuse lookups
Date: Mon, 14 Jul 2025 11:22:48 +0300
Message-ID: <20250714082252.9028-2-clamor95@gmail.com>
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

Add missing Tegra114 nvmem cells and fuse lookups which were added for
Tegra124+ but omitted for Tegra114.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/soc/tegra/fuse/fuse-tegra30.c | 122 ++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index e24ab5f7d2bf..524fa1b0cd3d 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -117,6 +117,124 @@ const struct tegra_fuse_soc tegra30_fuse_soc = {
 #endif
 
 #ifdef CONFIG_ARCH_TEGRA_114_SOC
+static const struct nvmem_cell_info tegra114_fuse_cells[] = {
+	{
+		.name = "tsensor-cpu1",
+		.offset = 0x084,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-cpu2",
+		.offset = 0x088,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-common",
+		.offset = 0x08c,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-cpu0",
+		.offset = 0x098,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "xusb-pad-calibration",
+		.offset = 0x0f0,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-cpu3",
+		.offset = 0x12c,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-gpu",
+		.offset = 0x154,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-mem0",
+		.offset = 0x158,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-mem1",
+		.offset = 0x15c,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "tsensor-pllx",
+		.offset = 0x160,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	},
+};
+
+static const struct nvmem_cell_lookup tegra114_fuse_lookups[] = {
+	{
+		.nvmem_name = "fuse",
+		.cell_name = "xusb-pad-calibration",
+		.dev_id = "7009f000.padctl",
+		.con_id = "calibration",
+	}, {
+		.nvmem_name = "fuse",
+		.cell_name = "tsensor-common",
+		.dev_id = "700e2000.thermal-sensor",
+		.con_id = "common",
+	}, {
+		.nvmem_name = "fuse",
+		.cell_name = "tsensor-cpu0",
+		.dev_id = "700e2000.thermal-sensor",
+		.con_id = "cpu0",
+	}, {
+		.nvmem_name = "fuse",
+		.cell_name = "tsensor-cpu1",
+		.dev_id = "700e2000.thermal-sensor",
+		.con_id = "cpu1",
+	}, {
+		.nvmem_name = "fuse",
+		.cell_name = "tsensor-cpu2",
+		.dev_id = "700e2000.thermal-sensor",
+		.con_id = "cpu2",
+	}, {
+		.nvmem_name = "fuse",
+		.cell_name = "tsensor-cpu3",
+		.dev_id = "700e2000.thermal-sensor",
+		.con_id = "cpu3",
+	}, {
+		.nvmem_name = "fuse",
+		.cell_name = "tsensor-mem0",
+		.dev_id = "700e2000.thermal-sensor",
+		.con_id = "mem0",
+	}, {
+		.nvmem_name = "fuse",
+		.cell_name = "tsensor-mem1",
+		.dev_id = "700e2000.thermal-sensor",
+		.con_id = "mem1",
+	}, {
+		.nvmem_name = "fuse",
+		.cell_name = "tsensor-gpu",
+		.dev_id = "700e2000.thermal-sensor",
+		.con_id = "gpu",
+	}, {
+		.nvmem_name = "fuse",
+		.cell_name = "tsensor-pllx",
+		.dev_id = "700e2000.thermal-sensor",
+		.con_id = "pllx",
+	},
+};
+
 static const struct tegra_fuse_info tegra114_fuse_info = {
 	.read = tegra30_fuse_read,
 	.size = 0x2a0,
@@ -127,6 +245,10 @@ const struct tegra_fuse_soc tegra114_fuse_soc = {
 	.init = tegra30_fuse_init,
 	.speedo_init = tegra114_init_speedo_data,
 	.info = &tegra114_fuse_info,
+	.lookups = tegra114_fuse_lookups,
+	.num_lookups = ARRAY_SIZE(tegra114_fuse_lookups),
+	.cells = tegra114_fuse_cells,
+	.num_cells = ARRAY_SIZE(tegra114_fuse_cells),
 	.soc_attr_group = &tegra_soc_attr_group,
 	.clk_suspend_on = false,
 };
-- 
2.48.1



Return-Path: <linux-pm+bounces-32133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 012B0B20139
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 10:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E953A2C29
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 08:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D602DAFB1;
	Mon, 11 Aug 2025 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLCf2Q9P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D77626FA54;
	Mon, 11 Aug 2025 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899489; cv=none; b=nMvm+sPVlEyJxR5G4ipAENhIPc7/5bcwFNb88row66gOv6psB3iyxU42+lOFMfPGZFxVIrfV9Xtp5UmMMVVtcX6ACOcWfeo+CBTKUnv+zF7S0yekWyhbkQZ7+462RHwsxj6JtyEv5i+l0l7I2dUZ04J2a/M6vgN4BdtYeGvhgvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899489; c=relaxed/simple;
	bh=e/AbcwBM9uIFEwZ/6mpXZP2Y3Z4bGt/eHFgnbobATzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzxx536nyqV1tSy/EhVFu8FuE7h81DrmN29b/odTh2wAlRt41Y5D3nCBJDodfbiP5GMus+M276fXr6YMdTpeajDFkDeXpgsJ6DapM1E7+reQ9iCh4oZfs5BRs1qkDf5e+xz9ZwGKFjMsW8WgYaVycS2c9mxRaR2HwcoBuwOM34Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLCf2Q9P; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af949bdf36cso644653066b.0;
        Mon, 11 Aug 2025 01:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754899486; x=1755504286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jv63TPoByrIyI7mUvMKjVHJSZMGf19SIsGRaSMWTF9U=;
        b=dLCf2Q9Pa5DXwhYio+KJsjljVVT5v76/58i48A6u4fEMXC1SYLhMQrEZr1fZnK9dmY
         62KcJRlcdm+PKLjanyv2fovvIoQE1Stq7PoB41Y9MwyqKjrCN1hg+171S4jXgjZEvwWF
         np+4dBnpKvqugZh9tvLC2/+Qw+zQ0Gjztx5jRjq8gcNmvNjJ37Ic5TiPWpT15Mo6N/PP
         zkkmDQg7+fUP5zT9O0d0RnJLrvvtDK4m+I+mXM+orrlH0OoCQg6FIbmYUuh0tFRFSiwD
         3DNwPvYDNk679A56Cp1xoaJ3+Xp6ewP99pB/mM0ZfulHBD5UWcCvGeCAtva8e3CxmbJ7
         7hPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754899486; x=1755504286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jv63TPoByrIyI7mUvMKjVHJSZMGf19SIsGRaSMWTF9U=;
        b=Ktedu9UCOaIXRwubPfz66NUW5IY33sRhSCtb4BzFZuzQLlbdaWlPpljplLJYJDXgic
         ftXuKoOjmYJnhqKuvk2RNUV8ZtjypeMctC0mI3gYwv8xpUYyBW0rXjkvkO2FOzrhefvQ
         WQCT4vYmcLMs91TA/KiqaTDW2D+qSWlfbDjC6Cds0RFPmC4KxTTaSLRSW74xjwp3ZsGx
         KGAT4BGlB66Zp4zHQkVAbKyhlugbAHM1yYqe7DhC5LkMSyXOtW8sjK7bGoItl2c1q2K3
         tkh1L+2ToqtUmuoeacBFffcu/7qO2nL1Vcr7xsUhYiHQ44vjxEii+GxDMmiDmC4JLnJ4
         rL5g==
X-Forwarded-Encrypted: i=1; AJvYcCXRe694NJU7ng/BqV8T7fYyfM0fe+KKmDlPz+ZYyxrSnZHn273T8JjYj+sVa6X+Ov+jEVbhUYaOd/daDwvZ@vger.kernel.org, AJvYcCXSonz0q1pUiZh691747mMum9GzuMoeTX1bN4XE/Sl+vSKl1WammsAHkhqCmCj8yZpxZkvT0FGJY+rP@vger.kernel.org, AJvYcCXWinZVU/xXT/Ot/IYRf56O124WZOzHRZ1S2oKNWOS4TkBzFAxKrngC6K9aMMh5aT9oWnkP/rNzANvyqTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBtkCsO08KDBGoxHU/1XKeyhPlPcEb1NZ4JltPnHqSqOC9YwPK
	r8oe5fM9qvzjvBDiBQyk+Zc8JTcjANdguSvzRRxdD6dZnmx+rltHh38b
X-Gm-Gg: ASbGncseVWrAzoKXg8HAxDCY1sAK0SjxHMtDt65rLFVsrBOnQ2gsQ9zDjfs6hLQRGmQ
	VNCCdCP6Vu3hbthqTgZKRwoTNephWzyDiytv/vXUkeLfw3x5PEN0AaUwGRGMhBj6vY5RafQwSZR
	VjONdbv2B/sMcpXXqmVbS/f9P9GELNLKLYEycwdl85ymvKDES3cYHepyqlHHxjQAx9gkGtnx0uP
	064f9ntSFyV29ZVK9wyDwhe4ShjFjcazuLwgUcpL5RfH8VK21l9s4zWz6kXlBX9GP03+gGzKtM/
	q3dUtdrvMht1BiNevEhNOF9ytEc6PIiu/LPWiTw+xl/bJMvzuOudnbUw6SEvpw10cbKeSiKenHU
	jqvCJKaYiTeBiazZkBkvsQque
X-Google-Smtp-Source: AGHT+IGApizmUMTKXXhSiuC+f8FzoBuedHHTP5BaIgAPwZgpqbjFqlVBQzlreBZe3b/Z+nC4/WZynA==
X-Received: by 2002:a17:907:72c7:b0:ade:79c5:21dc with SMTP id a640c23a62f3a-af9c642fb1cmr1189293866b.25.1754899485734;
        Mon, 11 Aug 2025 01:04:45 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c081sm1956446566b.97.2025.08.11.01.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 01:04:45 -0700 (PDT)
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
Subject: [PATCH v2 1/5 RESEND] soc: tegra: fuse: add Tegra114 nvmem cells and fuse lookups
Date: Mon, 11 Aug 2025 11:04:18 +0300
Message-ID: <20250811080422.12300-2-clamor95@gmail.com>
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



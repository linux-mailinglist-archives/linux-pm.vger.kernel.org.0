Return-Path: <linux-pm+bounces-33214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00391B39353
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 07:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1D9189EEE5
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 05:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EBF2773FB;
	Thu, 28 Aug 2025 05:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWtZakR1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA00B222575;
	Thu, 28 Aug 2025 05:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756360279; cv=none; b=mAy3dzx3lpjuDv8y63h4ivDKGuGDCrii5XmgaHluqrv819LvbCCG2YJsqksJiXb0FxkqKG9XxHGvFrtL/NZfM7bAawyZAFMG1rJpwZjxe7tNz3gqQhBG4WNMLSFPetic2EkE80RNpaW1MTzcZHl/zu+kmdZDFIs4wTqYDZZe5Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756360279; c=relaxed/simple;
	bh=TjyhYDQ/zRCXfpTVzRC6ISsclBwUA55fk1Rmf4ipb18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jeXwT+i/RclVhKVMvF+rs8fsCfINaT3aAunRfYBHEZ83YempFgbHgJmpaeiBMU/wLiI1R8xCE63O1xznecSo7WRFcL7GO0pGf1Q/bN/kU6egIp/dmiUHqsolkL6VQ0mJzeDH1hL0hMLBu+1VhxPvV4GX5LDyAwrpM/MqRCho1tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWtZakR1; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afeba8e759eso70757266b.3;
        Wed, 27 Aug 2025 22:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756360276; x=1756965076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN85YgtDrrFHbobx3x/MsgHdStbhFeF97ePi8WMVRQI=;
        b=GWtZakR1I/OCB33PCkdhZ2vgtq6rYK+2WkT2DhiYQN47kx2A3AO9GlhZ1PKoZF+0nh
         7+vEEu6TJBQkvdTfuH8WhMAn/vZ38uGc0fMSw1JmJap62VJMy8NIYkaoMuSTDwSEuvCT
         VcYQ9jreLdI5gsFPCV7Jt81ZrScmwVzA9B4iZml6TdMbXnwWquCSz559Sx1xzA6k2vvV
         F9RM2Cwx4oxxQd62KiPlw1AyWqmoVKnw8650b6cqzB31bkvs8s4dQwKxfyvNrG35QyhH
         tOABVUC3eVUCxLG0EqqasXedIc8m84i0t/yESAJYXKWMic32WROlyCyGHmihf49sydvr
         98Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756360276; x=1756965076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PN85YgtDrrFHbobx3x/MsgHdStbhFeF97ePi8WMVRQI=;
        b=xOR2if/zlM6pdpCdes1D7Bx9LGAhGNkVHaFYThZ4W32zmUUB+WLkJzznotOnAb9DZX
         vdYlx/LcE1x2HX3SAPG0VKuXzLL8ST3bk/AnND1wZiH1I5T+oo490k0RaekSpCaCeFcB
         lvnerTdPyW0xRFkaqMwiYmaT/x82vgqqgdLtWJfJwyEPNBpTGw4Hab+rHbZpmS+LqTtT
         j0hqpKyYE5hfPjQ/77etk9dIiV+JGMToMeyXi44RixAfAzcxU+u3LXuLcWHPZrwvsJK1
         GIac53J9iLOP+S4CF+bNaToimKzgYcadEYo51wE2YpBYxwwG5S4L8XyiZR0rBYS7jbOd
         N20g==
X-Forwarded-Encrypted: i=1; AJvYcCU5I09RHIbPffxvMZxSG4B4QcqEhxNgvNmq5jbjFQwQSx7FYgJy7/7V5AnWIh+HL/sxb9QSZXlLTj3f@vger.kernel.org, AJvYcCV0R3hSOC4RnrQQDvN1p2iT/7+6Ur51ZvjjLeyaRXo7C4jiIp+YLpm6byNmWjGDBS4ywQDJW9IukvUARYnj@vger.kernel.org, AJvYcCWpIvZyrOGqnnvteor+W6AxwYtBomyez3FqAmZurbfLFJNWVsOeyfhl5ATLPpbmk7BINQa4nKAR4NveT+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzqC11BNzhLy+sla6eMFnU++/93qzA6xat7qfdGUXhH8xgc7tx
	bWyGvPNURNfGFuRvpI/Y31INyrVZVXz5Xwy+Xlr/MuqST23Om2ATuF7/
X-Gm-Gg: ASbGncuBhFOsKHrmCtYcUjAbTLNjGlnvR5tSpMk7LLwOY5L2K4x+Q/E2OhScVEDzlBk
	Pbhl+VpkdFQqmB2v0oq2ytixgZ8xJIj7B1eDy84j8a34xY72e8TaRKqfUKQ6/oBvksV4t80xEVk
	8Yz/DlXYqJ2Ia00W+s1nhKyv18TAPp4+WX9FEoF9fYNgnIZBkz92Dx9ifI/NDRCkAKFiB5MnKn8
	bAAexBprsHm/UMQJ99vFoUfHeYuL7kyqxXxYOzRgcTLhVKH4zS8XniUvYaS/0H/F6FnyTgy4EiI
	mYMzp7h6u/+54H3LmPQKmR68cttGCO1XlaJliL290IYVej9A63JzWWi6r7Tzcjpg9GOGD3u98/8
	vQu5aMOnwvU+6aA==
X-Google-Smtp-Source: AGHT+IEELHTAjgzbPuKWtzVU/EJlik6ox5T+iKFLXDYXBkdga34jPkfGqr+00j1CG9kq3AD/NuYSiw==
X-Received: by 2002:a17:907:3cca:b0:afe:f030:ba72 with SMTP id a640c23a62f3a-afef03173e3mr41445066b.28.1756360275967;
        Wed, 27 Aug 2025 22:51:15 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe72c35ebdsm927942666b.7.2025.08.27.22.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 22:51:15 -0700 (PDT)
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
Subject: [PATCH v5 1/6] soc: tegra: fuse: add Tegra114 nvmem cells and fuse lookups
Date: Thu, 28 Aug 2025 08:50:59 +0300
Message-ID: <20250828055104.8073-2-clamor95@gmail.com>
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

Add missing Tegra114 nvmem cells and fuse lookups which were added for
Tegra124+ but omitted for Tegra114.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
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



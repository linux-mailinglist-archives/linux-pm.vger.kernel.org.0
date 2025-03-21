Return-Path: <linux-pm+bounces-24382-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E08A6BDA7
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 15:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79C137A3DD9
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 14:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD481DE2DC;
	Fri, 21 Mar 2025 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDuuQsW6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FE01D61A2;
	Fri, 21 Mar 2025 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568833; cv=none; b=XR3T5rtxfvov5J9+NK3D1iuu/MZ0/QXBgX5gTIIr+A6eghiIO93wHbi4rMzNpl05/UHtFWC6f0qzK+wQkMBTligKgEX4uoMb1VMjj9LtYjnnXkdfaPr3rb4iMOWihD/1wx1eO8fMPB6P52PhZ/krZ/sACMxay39j+kO6gRQcl+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568833; c=relaxed/simple;
	bh=3Qrlke3rV5UrcVx0LmV4fvmS1VaVNlCzegA6mWn9AFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lajfKn5aUm0WboGRNmFJdZZrcCJA2OHAzXD1nRLFc2fQv0hms0hpo8erk+o4UsmfuwEL3r67c5xnbf6RfhBlBG0egyLTp1nbX3ehXkDzxdwyWLgKLRQ4dL6lE7z8MJD82hq3x7bH9sk6YQDD5UbkYjW/18+hQM0MUtvd+rvb4yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDuuQsW6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2c663a3daso416701066b.2;
        Fri, 21 Mar 2025 07:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742568830; x=1743173630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VN46pr8HKLZnZ1CFeU+hmdbKJpGE/eibQxuH2e2XFMg=;
        b=VDuuQsW6NCNMPwGLYP4XQCk2x2ZkhPTb8hitjF6RCtQONkc2WitZT/IGoKdUwD2lkk
         I5lq9eRkz2kHnC585tJmjJofyFKhuBhFvBtwHibc5JiHei74nN2z8WbXM3clh55QdFkh
         pNsEoPayd3zUvkiWzqRbxCBltl/vXkF85Gi+nFHSoylCEk5ZXyyr/WNzJmHYDCWzdDyk
         jsv5LUdsTVWTEuuhhl1QCB8UoFyVtNeCZypvMm/LpN1wtkSQ3yBkmaP59Ub/64d9hre+
         gFfnmKLE/c9Q6cCLFwFtoTBtPkSPwu8RLfRDbys+vTAM/tyGu5KHcRYbzbgOeoIo/mI+
         NVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742568830; x=1743173630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VN46pr8HKLZnZ1CFeU+hmdbKJpGE/eibQxuH2e2XFMg=;
        b=jnB5ad0ST701AJUYNwkO3iNAtSmVYp4UIcu513ikTSW34JEDtW8kXffjDWJbYrcXyH
         lIp9tFkOg7i5aDc2ggusS2d3Yo4qYVUFNGtLmFV+Ve1mtihK6urmzOPMjVqoQ23X6jDD
         Y078Y9mwlDD3cZNry2q758F3KXlsqxC6J4cqLOkjpT0Z5TEV+b3nJwKvF7F6bzMkSzlx
         7bsLkC04zkr4oD3CW3C9xSSj2nhqyx8f22kSMS4D3Gnfl19Kmn0tNN3syYOJXw+NqYNG
         Wo8NDnqvicdns+jS9TDmUCmCuvANAQpduJhJrRv8xL2/IIlUaJJT7JL8NC/5M+Brn+DV
         7qlw==
X-Forwarded-Encrypted: i=1; AJvYcCU3M0RnTD7Fn0Y/Ck3wCLBXYXo/GSUz4PrULP2wMhabSfIpaxRWCO1mR0kKkTxzIIFi+WzOhz4zKdGM@vger.kernel.org, AJvYcCX3oztUgxxmrdI4kyA2W57LibQ89VQTcTqwqnJYUeTR9kZgI07Fd66BQgVLTpMxwlItY9iUd1pUs4RFL5vc@vger.kernel.org, AJvYcCXDH5iCp3aFOMu/GpstIAbO7yR8YVTGnmCzt5RqVOafRSuD9bALkD2hSOceHMS+CTbsXR7aShKxNpLdvsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRs4e2+cncOGkvrODJO6KkFbI3ZBK59/afRp1DLvyic6uXul0s
	oB5eB9Sv4dHIvN2osraIW3vkBLqvLVR+MSSbhXvjyMxgrjQajmjf
X-Gm-Gg: ASbGncsf4hBM6Zn/g6OhZr/V0xqgNSjiMz7sds1erbf5on7eDpmtR4WT/p0h3D53jx5
	15gkkjPqAwVYULvYdGsJPmSshJj4kEZz26YQwNI7kwcLWpyZuRFQ3/sD2AWdZaep/DbHI1gehV7
	fbzsyLsZiDS7y4qv2EEja+/HjxYu/A4GCCHmi7rEd84FpO7S5lM0LkLFfvyiSLIYBtCv0U74XEv
	7ltjDCgccDWL3XlFxqSfLFajuLk7/ZDuWjA0WVVxtDh1MbQ0rXVsSwm61VMUQIHCBEK3ENMMbF4
	PzDWbeujSzX6uJ3OrY7rtQzJpa9JZnswDWGv
X-Google-Smtp-Source: AGHT+IEUpAHBziOa+1Gni4ODGJ6MsL6ry/sr309JKf9G0utzeEBjsJ0p2oWTJWr/qCyNBupFys24SQ==
X-Received: by 2002:a17:907:72c9:b0:ac3:bf36:80eb with SMTP id a640c23a62f3a-ac3f252f83dmr324556766b.48.1742568829910;
        Fri, 21 Mar 2025 07:53:49 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efbe038dsm163224666b.138.2025.03.21.07.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:53:49 -0700 (PDT)
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
Subject: [PATCH v1 1/5] soc: tegra: fuse: add Tegra114 nvmem cells and fuse lookups
Date: Fri, 21 Mar 2025 16:53:22 +0200
Message-ID: <20250321145326.113211-2-clamor95@gmail.com>
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

Add missing Tegra114 nvmem cells and fuse lookups which were added for
Tegra124+ but omitted for Tegra114.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/soc/tegra/fuse/fuse-tegra30.c | 122 ++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index eb14e5ff5a0a..a79f83d175d9 100644
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
2.43.0



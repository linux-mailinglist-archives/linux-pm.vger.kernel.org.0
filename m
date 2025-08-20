Return-Path: <linux-pm+bounces-32707-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7139FB2DB66
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 13:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D35A4E4F10
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 11:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602F32E5B30;
	Wed, 20 Aug 2025 11:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzEdvZ83"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACDE2DD5EF;
	Wed, 20 Aug 2025 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690181; cv=none; b=kt1Ss21hNJUXqFOtWb0NO0945uO/1Tw1ZqaZtssUfL4ANdA9UFWcyUUcIY2szGWKagl526tR0dgFRv93yngGj7I881VBpzb8Ry6V0NFvs0Vx75CqhmFBCTb+hnLOVb0pGfDZEDKoFNWph7NeTI+vT8iMt6Cjy1P9m7WkRE1pju4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690181; c=relaxed/simple;
	bh=e/AbcwBM9uIFEwZ/6mpXZP2Y3Z4bGt/eHFgnbobATzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTh40sulflsbUYjy9HHNciXHNGG/BVqcxVq1KKycwwQXlPZVC3rSKjbawEa65bkZ8bE15DAoyiTBUC2PguRY05yxB/2YU7AqwQQWCuNsTae7d1Obeh0M/Ik4sDVxP7eXGF5wRqIWAjvoJXLhj+hOMSWGydGvTWeC0IZu/aUlEWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzEdvZ83; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7acfde3so916006966b.3;
        Wed, 20 Aug 2025 04:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755690178; x=1756294978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jv63TPoByrIyI7mUvMKjVHJSZMGf19SIsGRaSMWTF9U=;
        b=TzEdvZ83VSizId+Vs/w/j+7/4TAE3PUqtyeL4kX+MoQ5x45o6YcxsQS6ss8YQXjrlP
         dZ20cjJOE+rNnWwSazMrLvPds4kZgD+1RFaWNKzAtIkejrL8rGqak6976jFZFYtp+GnW
         Erb3CI45w7GK8TU7ekiNiuVEVD4tUIHj/J+tkJ7sHYzVVViQv0Y9IdBO2Q8Q58yLGpxo
         AS4qmcCVruemgvIDiKjZghpiZiruBeUDxXolUo7y3Wteh5Lou21m9UZXvUIZIRe5bqea
         KOQH5xcGxQxQSlIzmaZ2BY0iy+FYADhFkYt5ikuefKDQ5VfVJRxcI5PCOi+fPSyThhHH
         3iQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755690178; x=1756294978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jv63TPoByrIyI7mUvMKjVHJSZMGf19SIsGRaSMWTF9U=;
        b=lK9cKNbk15keeYO/UHs0UVEjck5BgqZh1VkZlqDTDB/PEPil2ZGGnOcgIkiZN0YQcN
         d5tsnBpj9vuZNJWUAR4koQ3bPenO1g9h7j8IztWlqUTzQ+OIP/lxPVOVA+3HK3oA4B23
         B+itN5564IjG1ksWVIE5lNxst/Rp4szl9zuVeFhiYUZZgy0R9H4Jp09SwtP1CvXds37L
         Uf9umA/7jpNuu5J5htXDi3NW1Jl/u89VwJ7ASRBz7ptZUmeV9J8JForn+x0eVidu638f
         HDNd1KMCGYGlA6ZsZhx74OzcM93O8JpLN8Ftm7rCcpEX47A8Yzjm7kIl9Wc/ILoVfMxQ
         BwaA==
X-Forwarded-Encrypted: i=1; AJvYcCUIG/gPmxBYsX4WLEsNQkmnwfjAs6pJBK5X7hn6cjWX90zoEHiltb1m3X7L+VVQRy2zneOJi7okzjAe@vger.kernel.org, AJvYcCW46vDOPjg608eqYnfhLBM8u21FhaED1qTDNiZK/O1AuQiKcgzdNUhP+XwgjnR7sZ6PcYhei43CnjLPy38=@vger.kernel.org, AJvYcCX9JeUwGFnxD3A4q26AwqyCs/HRGK/8tgrV+fcivu5TzW1dfIHA9Oqc9Rbn6JtICKPooo2K6BMOIayP/X4l@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9RrWrNTtjS2UcVWynWHkB9Mvk44dbP+l8xg2O8i96APsIuvAG
	fAG5fq1rBVN5LEkttj/dKro1SvjG31OVQeTAB4pq4RPSYUYg/dDwEmjN
X-Gm-Gg: ASbGnctZJTFJ8/s/tj6k9oE5E6Nm9iNx2wLpbFtEXRzzRTA0nFpytPYuPibQn3S+L4p
	ZgtsNRlSEbJMfhux8RUt+JbNCDERspfZrJvFN5oIjMlXo4+S8snQn32XMG0eQbZzXkQr2jF0OjQ
	1YMVsDmNXodGi3sV1UyVIHw6lY9PGajGGHklqhn9s/b0oRk4XDY3cpHV52Il9I2oLE5J3UflYaz
	SEdFp43B/LK3jHilOD9cbhFRVr0r8L2ueQAXgWGPtLSb3vO/jl+irxc+tQlfFWze+QBBLS6/9pe
	/ZwQPOM/21grfy5rcX4uYB5ZK7ZFXwKsTr+Ut0Gwgm5RD0xqVTLAKHDzZD8X+CUqxJVwhzJOZPb
	QFWBSye2ViafsZg==
X-Google-Smtp-Source: AGHT+IEemjcbAw5pzDg8mKxdz5nCDhivdvp1ckrhIMociMsH9aiyopwEmgaHsNiNdzoDltaglocQBQ==
X-Received: by 2002:a17:907:3e02:b0:afa:2775:58b6 with SMTP id a640c23a62f3a-afdf009a870mr245738766b.17.1755690177566;
        Wed, 20 Aug 2025 04:42:57 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded4ca695sm161769566b.90.2025.08.20.04.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:42:57 -0700 (PDT)
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
Subject: [PATCH v3 1/6] soc: tegra: fuse: add Tegra114 nvmem cells and fuse lookups
Date: Wed, 20 Aug 2025 14:42:26 +0300
Message-ID: <20250820114231.150441-2-clamor95@gmail.com>
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



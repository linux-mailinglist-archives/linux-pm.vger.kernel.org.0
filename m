Return-Path: <linux-pm+bounces-33008-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33EFB33CF4
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 12:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52DCA7A549C
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 10:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980002DAFB5;
	Mon, 25 Aug 2025 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icxytZkI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33D72D12EB;
	Mon, 25 Aug 2025 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118452; cv=none; b=qdRxG5kzfM0KdPZKd9EB7uHVEAg275gwc3VMuP7HR6F50YpBKv5bcjg5TKfeGmJuQlUI4/tAauK4N+Vib40PgmotZXdI+eaf5Ag/jAJw9mxWm6LtOMI7TQBbaQAT+4LkIVuS/5tSnq065TyGFYnWgfqPKtGjJm81RQ4TSXAA0jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118452; c=relaxed/simple;
	bh=TjyhYDQ/zRCXfpTVzRC6ISsclBwUA55fk1Rmf4ipb18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtA8wCLNJ1IgLAgUDvmKwWqpbDwZtaKuSmB7Hp38c64KqArQ9IX1iWXIVX8RIKkuUUylY7U7u3a2m+FwHgqjy9BjIAoIBDnVbG8JrknENZ5NEYmfeQXWzYv64dfP+1eGWwBHOJdy2lfDP+SYD0JP2H7stELbH7yZ08e4eX6P5V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icxytZkI; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7a7bad8so575236266b.3;
        Mon, 25 Aug 2025 03:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756118449; x=1756723249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN85YgtDrrFHbobx3x/MsgHdStbhFeF97ePi8WMVRQI=;
        b=icxytZkIM5322vOvEW0mrHMvlntLH6xniDDu/Dn0/g0qvQBoP2CUmI+rGIbL2MmtYa
         MxeVnGYm+DUEqP5HFSIU3rt3RCJEGxsCsBcjdH3XXe+8ms8+hzjjyiGrYM1ZchImsPlb
         bUSY3rOQa1Qr/7sZFLlNzcP247jjuL7kKPkCek9RIbFYj+jhV2T2Zqa6ZnhJup0JIRYS
         R4B4yXcaQH8OO/galKCaAbSliUFC/tMi/vxYkesBXPvgEcROsf/ni70zynDGe7e6EFDS
         sDpC+HF7u/fLY85llerVRZwY2viYXi1vryCcREuARk2i6BkdB3OtiyLb9EFe5mhpTSX6
         yQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756118449; x=1756723249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PN85YgtDrrFHbobx3x/MsgHdStbhFeF97ePi8WMVRQI=;
        b=pjR/2SV9/wUP0As4JcPoQVJ7QpHu+Tyove6ajSXYO2rfwqjK8w2G4i8TxyPxFnM0xu
         SPQPE7G9nQWENJ0qt/Gkb1L/5rSOYc+eyL77G/QJoNgAD87ymhN/NSOl+arRB/Qjb1yN
         MmSu3/RunbZ7PVbBAD/cyznmB8xm4RsKp3F2xVFQFyJTFPsFJ/OqZrOz3slCNK+oDbjO
         nw21Rv7OMF4bPk0P0GabCUR9dGeS6eaO2OhR+mMrvjbN57qzxBi3s+Uaazsk8TOSLFg2
         9wJGLHplwNV5v82834nh1LG7fAOLxymPnSa36Lp5GRSs7DLpPnQ1a0aaOq24OGRVKr4+
         C0+g==
X-Forwarded-Encrypted: i=1; AJvYcCUARv2FB/ANd7U1I1wz3y6PydsLRcg3UC0xSmrSfZ7esgAua0oI8ZddzoGgREOEqmvTX2LabnMyi5OY@vger.kernel.org, AJvYcCUJo+in5uc2dw6kU2XFLa4Bo1yQfNoeDuSNMuCWci0DHInqR2w0GiNz2MaVf8R8M1dIRn37vStjJ5GJhKU=@vger.kernel.org, AJvYcCUgF/hDHlSWy1muB+QOJzAs0HHkHKECiRFNaViPcZvQtifxhxRCd1L+tKkHe1vrrPV1y965wEzP4SYYQp4e@vger.kernel.org
X-Gm-Message-State: AOJu0YzQpCyYgHsxizsqw8mqkA8drFQ8A66wStDkhK+7fA71tlYKbiKX
	3oxvbLJ1kIWYQC4hMskGP2YvFC15Tf7yUVLDUq/SZZrYvj6XtU2/fZCr
X-Gm-Gg: ASbGnctilbUHfwZH3/nJIggcj2jenbEJKXHexmHAqormC47nWcGgXsPo/KiX0/8aPHK
	upTw7AcQzJPjh5lO4Ifdy0GVMuM0MpUx2XwqezlGtzDHOF7ElzK0s2KOsH/mehC5MQExZmwxXCX
	nJ4SjUNBoEl6fX+/i3fHo4yEbEHzSwAMjgXpx49Itu/iNRn93Bj0qfWXPNSMnQYd5FZPxRdMVxE
	x5lTShcjFyuWRqULzioHnrfX8n1PLr9fJSVlA1K2hYwxO/q2a3tBzeYy4VO27W5crke+nFS0DZS
	gQS82UqG7G6PwyKD+H5pBS+vs3vbPBiOgdW39Djr2oJK+JjgkyElm14zJkVcHjyZhHrhtI6A0w8
	5o9nxage3jZw44xX+wrsg2S9R/bGV9jLp0A8=
X-Google-Smtp-Source: AGHT+IEG43zwHszteWNKNTJH6z5etcz29R+4YFsUtGmKxlmAqSwMGWO5sE/lRYdBJIz4zR/n2kGQZw==
X-Received: by 2002:a17:907:985:b0:afe:6648:a24c with SMTP id a640c23a62f3a-afe6648c0damr429613466b.52.1756118448494;
        Mon, 25 Aug 2025 03:40:48 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe48fc0912sm531683166b.42.2025.08.25.03.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 03:40:47 -0700 (PDT)
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
Subject: [PATCH v4 1/6] soc: tegra: fuse: add Tegra114 nvmem cells and fuse lookups
Date: Mon, 25 Aug 2025 13:40:21 +0300
Message-ID: <20250825104026.127911-2-clamor95@gmail.com>
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



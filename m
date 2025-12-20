Return-Path: <linux-pm+bounces-39725-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 166D9CD3563
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 19:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C4A53007972
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 18:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6411430FC1C;
	Sat, 20 Dec 2025 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Z/HN/Uek"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33C67261C;
	Sat, 20 Dec 2025 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766256656; cv=pass; b=PYIpvGoFa+lapX0b4KIec6FPMQ7UBmTNkNfm42yadbtrlsdCwrZ2ZgDgcGjSx3cOlHuSfYIFxQLuKgAmuP9YYZrCQ03buZM2Ul2wpRFdiYCSvPKHMNzjewGLzy7w6o9n4SiRACjkjp2p0FK9WzbAs+vv3eco4wLfpDLyu5++7TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766256656; c=relaxed/simple;
	bh=FGUuUEShtBHDKhcrFNCYIki+M7jOvSSScNRR+v39wbM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rQyEnaLMUneRANUKKcQSz5TGnKAhu2R4KdxdE6/XPzTqkoIAKNlL/M5Ss4Zn4i1UVNg6kTVaQ+Cxj1JkyOz6edoqS1hrjotuuSjx8EY8ktb1niOdC2SRkRbpxw8V8CznnNWwABWsOGS+o7u51Ht0LGp967FB32D292f4JAlo9H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Z/HN/Uek; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1766256623; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nc+bpHUqO3akszbIQOAVQ2c/UgKIF9WoiM0TygwVRmiF7sOdpWY29x+6qzu5f/eqUVNXmb0yKISnbFku9l4p6Iv/eiReb5NBVCpLhsWbNOU4WtFm8HZhB+3ozUw5S3x12XP3wBokkMeltCTduI37yVyS2eZinfd1PPC4a6cw/8U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766256623; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8ZSVY3KLNoEae4fCTRliOjZfdWRvSMnTf7vfGcKNjSI=; 
	b=XTxnaUoeL4NU2j1FibI5tJAlERx/F05peZ3di8KRZp07pg5Pd1Kjy6OE14Ad04PVmoQg0ZkXXEZKxSpFDV/0lVAL0CM3WFa+qlXBjyDlr2O02aNhssZBqoiUTO4KUgzzFNQnGpn/bQxDGAew1hh2uSOeInXHlaV1fy5Xt0g4/0c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766256623;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=8ZSVY3KLNoEae4fCTRliOjZfdWRvSMnTf7vfGcKNjSI=;
	b=Z/HN/UekzVsb0dBD5AKn00716tT6o8BCVCucj9qrnh7yOM7EConle4Xaygfq4lkD
	tRszBJGUFpF9Yje3ysbfQp5rFZatnhMUVQiSxyxNcYG9/eeYu0K8hTZzE+/0id0B2p8
	gxn9o0i7E2m+LFYApbzfLbwQTFEXFVvHLpGDU6qM=
Received: by mx.zohomail.com with SMTPS id 1766256622429134.8394294983167;
	Sat, 20 Dec 2025 10:50:22 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v2 0/4] Make MT8196 get its Mali GPU shader_present from
 nvmem
Date: Sat, 20 Dec 2025 19:49:51 +0100
Message-Id: <20251220-mt8196-shader-present-v2-0-45b1ff1dfab0@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM/vRmkC/4WOyw6CMBBFf4XM2lFalNfK/zAsSjuVJkCxrURD+
 HcruHc1OTc5d+4CnpwhD3WygKPZeGPHCPyQgOzEeCc0KjLwlF8YZwUOoWRVjr4TihxOjjyNAYk
 rmemq0LI4Q3Rjrs1r6701Ozt6PGN92ENohSeUdhhMqBPlBgxmOv0ufJXO+GDde1s2s835M2Jmm
 KLOdakzIRhV2VXavhetdeIYP0GzrusH68ZF0fEAAAA=
X-Change-ID: 20251217-mt8196-shader-present-e2dc3f97fc74
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
 kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.3

The MediaTek MT8196 SoC's Mali SHADER_PRESENT register does not list
only functional shader cores, but also those that are fused off to
improve yield.

The SHADER_PRESENT bitmask with the one fused off core omitted is to be
found in an efuse. However, the efuse address is considered
confidential, and is not public knowledge.

The MT8196 GPUEB MCU, which does the power management for the Mali GPU
on this SoC, knows and reads the efuse however, and exposes it in the
shared memory intended to communicate state to the application
processor. Reading the bitmask from this shared memory area is the
vendor's intended solution.

This series models this in the binding and implements it in the
corresponding Linux drivers:
- the mali-valhall-csf binding gets an nvmem-cells/nvmem-cell-names
  property to declare that shader-present is in a different castle
- the mt8196-gpufreq binding requires nodes to expose the shader-present
  cell
- panthor checks for the presence of the shader-present cell and uses it
  as the shader-present value if it's found, instead of the Mali GPU
  register contents
- mtk-mfg-pmdomain becomes an nvmem provider and will happily serve
  queries for the shader-present cell

While it would be preferable if we could read the efuse directly, it's
not possible as things stand, and insisting on it will just keep this
hardware from working in mainline. Running a GPU workload with a
SHADER_PRESENT bitmask that includes a faulty core results in corrupt
GPU rendering output.

Modelling the mt8196-gpufreq device as a nvmem-cell provider however is
not lying about the hardware's capabilities, as it truly does provide
access to the nvmem-cell, even if it acts as a proxy.

From a bindings and panthor perspective, this is also generic enough to
where hypothetical other vendors doing the same thing (even with direct
efuse access) can rely on the same cell name and implementation.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Changes in v2:
- panthor: move to nvmem_cell_read_variable_le_u64
- mtk-mfg-pmdomain: put of_node in error path
- mtk-mfg-pmdomain: remove leftover stray of_node_put on NULL
- Link to v1: https://lore.kernel.org/r/20251217-mt8196-shader-present-v1-0-f6f8f3aa1e93@collabora.com

---
Nicolas Frattaroli (4):
      dt-bindings: gpu: mali-valhall-csf: Add shader-present nvmem cell
      dt-bindings: power: mt8196-gpufreq: Describe nvmem provider ability
      drm/panthor: Implement reading shader_present from nvmem
      pmdomain: mediatek: mtk-mfg: Expose shader_present as nvmem cell

 .../bindings/gpu/arm,mali-valhall-csf.yaml         | 14 +++++
 .../bindings/power/mediatek,mt8196-gpufreq.yaml    | 13 +++++
 drivers/gpu/drm/panthor/panthor_hw.c               | 36 ++++++++++---
 drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c       | 59 ++++++++++++++++++++++
 4 files changed, 116 insertions(+), 6 deletions(-)
---
base-commit: 638148c6ffa31d2e4958d51708ff3675221e2da7
change-id: 20251217-mt8196-shader-present-e2dc3f97fc74

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>



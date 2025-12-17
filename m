Return-Path: <linux-pm+bounces-39660-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4E9CC910F
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 18:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DFE6300985D
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 17:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ED629B8E5;
	Wed, 17 Dec 2025 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="j+BnazpP"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C2D256D;
	Wed, 17 Dec 2025 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765991062; cv=pass; b=SkGmM02Umv79zIa/qGTfITv3siC4DsIu2NQxQUj1PiL3QYXl1m2Gve1MXKNuTHsXepdTwQf01SB+xfRW0MiQM3y+etM9WJ6JDLbE1vAV71lZLdkyFraUMTTIoUtK8Nhy4TiGWSHR1V7MgrTiPxAdyilZfuQrso+Yh819kXt8zLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765991062; c=relaxed/simple;
	bh=HcVMM7uCap4kOpsSPqtdRCka0r0Ow0OUk/KVGq08d1Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hv05KnVrK6ehC0FKdFDI1Nh5QTvjvEbog1Dah0u6BmWa8keg65EA8PgcI1zZGeudej43K4rdtSRNweMUfSUXkY6YiOmJHrJlwcl8dTcB87ksf+d/wK6reDIGJJztkQCPcX7gAzV8C94dSxna6sOfaO6XSNcGifoIoMio70nusz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=j+BnazpP; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1765991040; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QQtrRqPJfkIzhiR99d1xVv8x5pTsrIGwCZinM1rQVj8uXhEkbZDdMP2WZ+AAZu/gkZlzt8P+W74puhPA5RnVtGFACRm9lzrfiefZARyCcxeKEn2anwkGXH83vdSycpMMp4Nfdr1ZcuAc30/53XVBZm+4aO7bkkUPS8lVoOKogb4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765991040; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gk8N5vqQY6cvukhg7xoBpaUYZclsUp62GPYaQQXQv/c=; 
	b=Q86VlC/LO65zATvVKUgOHaKbR+Vnifa0h/uScna5pVFDnTYZXnGd2Wf23d3znyKAibnOpkSODWQZjpFJUpz3iLW/2WKFbkymV1NQ5PKaEEVwEOviUVFDuSELtlXIkx6rgUVafyMX/3irYjIsb+nizobtFYjFHNsjhwPwbJdDmHA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765991040;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=gk8N5vqQY6cvukhg7xoBpaUYZclsUp62GPYaQQXQv/c=;
	b=j+BnazpPrwF27LpmCixibF9xPk1nIB9HozKnyES4WbkRZIkXYD2mB/kMFKlLf8KQ
	dVS9JH1XsPPiqP6UG8enECMlY5iXJYUYuW2rZtJ+ozX2EvO/caFKbn82QrMhySWTjv6
	pkGOjc5TFZX6cs29RahPde7O1U4dw9NdBCC0vL4g=
Received: by mx.zohomail.com with SMTPS id 1765991038674334.3696027621247;
	Wed, 17 Dec 2025 09:03:58 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH 0/4] Make MT8196 get its Mali GPU shader_present from nvmem
Date: Wed, 17 Dec 2025 18:03:26 +0100
Message-Id: <20251217-mt8196-shader-present-v1-0-f6f8f3aa1e93@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF7iQmkC/y2Myw7CIBBFf4XM2omCD2x/xXSBMNhZQCuDxqTpv
 0usq5tzknsWECpMAr1aoNCbhafcQO8U+NHlByGHxmAO5qyNtpjqVXcXlNEFKjgXEsoVyQR/jJ2
 N3p6gfZuP/Pl1b8PGhZ6vlq+bhLsTQj+lxLVXoSSsPO//C8O6fgFNz9d3mgAAAA==
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
Nicolas Frattaroli (4):
      dt-bindings: gpu: mali-valhall-csf: Add shader-present nvmem cell
      dt-bindings: power: mt8196-gpufreq: Describe nvmem provider ability
      drm/panthor: Implement reading shader_present from nvmem
      pmdomain: mediatek: mtk-mfg: Expose shader_present as nvmem cell

 .../bindings/gpu/arm,mali-valhall-csf.yaml         | 14 +++++
 .../bindings/power/mediatek,mt8196-gpufreq.yaml    | 13 +++++
 drivers/gpu/drm/panthor/panthor_hw.c               | 63 +++++++++++++++++++---
 drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c       | 57 ++++++++++++++++++++
 4 files changed, 141 insertions(+), 6 deletions(-)
---
base-commit: 16f014a645fb35303b8fd3305f23f8ecd3f2f2a6
change-id: 20251217-mt8196-shader-present-e2dc3f97fc74

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>



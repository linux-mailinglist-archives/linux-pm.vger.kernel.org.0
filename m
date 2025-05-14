Return-Path: <linux-pm+bounces-27122-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DEDAB65B7
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 10:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C021B64BC4
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 08:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3B6219A93;
	Wed, 14 May 2025 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dIl+o/2L"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC39A4A0F;
	Wed, 14 May 2025 08:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747210810; cv=none; b=nm/ky/LcS8q0czKmKCoHKRFenMmEvMOpE5YUbrEt0zLk6R+3ahKtaDK8Yh17YRLW9fmgUBe266cl5fwauUM03XElM0krxeBF3VtBFm4o1LCIccXXkGFAB0gSL+0m/jdrjcqtGSoOrkzc1IqHRngqkErhHP8G+GRjLHRk9GggM5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747210810; c=relaxed/simple;
	bh=spSxSPnHfT8j3gFUgdV4jcQ82RfiWdTdZwOzzqjDKeg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MkYLOdbfAgUbfdt2Z5BCVgS3dKDG+whbjzieYqpACarvDP5Yg6gNSHocvtJeSXYrd4BCOUYGqiCn5f2nj5uZ85XKoBoemxIXyLFq65Sk6mOL48hCRGhuRpPQDRV0w94BGYdDuS+tQ9cyflJebGifr47LXhNNYsqxQ+8dYQXLeVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dIl+o/2L; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747210807;
	bh=spSxSPnHfT8j3gFUgdV4jcQ82RfiWdTdZwOzzqjDKeg=;
	h=From:Subject:Date:To:Cc:From;
	b=dIl+o/2LJx476ANV8IrjeCCWD5gmWhkmXByNl1ZaXGX7iv5Ek7uHcWZBy08D3fOpS
	 8o8jaZl2salMFyvcV8kVpKLbWZE4T5M2eBGtbpNf9dWk1/CzsCrPUDhd+MrjkK513Q
	 0N1xfv7ijxE1sK0zwOEdXYLADl0ab4QoxrtsA8eCoZ1Bmn/gaSDb8WabAMqwEG9QPQ
	 xaTJ4zolos/hom6r3iDofYV8Z5wqXMXJ6rYBBbf9zwrgs6YJRhnHx8y8Ny5l1hwfoo
	 FH1xuk/4lFddpbkWO1AR5mebbzcXUsZ+b6UXOw+rvM7mQy/WCbtg8aApIL45HDa18K
	 OIsM0V1FNximQ==
Received: from apertis-1.home (2a01cb0892F2D600c8F85Cf092d4AF51.ipv6.abo.wanadoo.fr [IPv6:2a01:cb08:92f2:d600:c8f8:5cf0:92d4:af51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E4A1817E05F0;
	Wed, 14 May 2025 10:20:05 +0200 (CEST)
From: Julien Massot <julien.massot@collabora.com>
Subject: [PATCH v2 0/3] mt8395/mt6359: Fix several dtb-check errors
Date: Wed, 14 May 2025 10:19:55 +0200
Message-Id: <20250514-mt8395-dtb-errors-v2-0-d67b9077c59a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACtSJGgC/32NTQqDMBSEryJv3VeSNKJ21XsUF/mtATXyEqRFc
 vemHqDM6huYbw5IjoJLcG8OILeHFOJaQVwaMJNaXw6DrQyCiZbV4JL729CizRodUaSErJed94Y
 LLyXU3UbOh/fpfI6Vp5BypM95sfNf+8+2c2Q4GNlxaU2Nfpg4z0pHUlcTFxhLKV9EHxKwtgAAA
 A==
X-Change-ID: 20250505-mt8395-dtb-errors-0847ffc12f44
To: kernel@collabora.com, Sen Chu <sen.chu@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Hui Liu <hui.liu@mediatek.com>, Yong Wu <yong.wu@mediatek.com>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Tinghan Shen <tinghan.shen@mediatek.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, iommu@lists.linux.dev, 
 Julien Massot <julien.massot@collabora.com>
X-Mailer: b4 0.14.2

Hi,
This patch series addresses several dtb-check errors reported for the mt8395-genio-1200-evk.dtb and mt8395-radxa-nio-12l.dtb device trees.

The fixes include:
- Adding the missing #sound-dai-cells property in the mt6397 binding.
- Allowing 5 interrupts in the MediaTek IOMMU binding to support MT8395 properly.
- Renaming the rtc node to match expected schema naming.

Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
Changes in v2:
- Patch 1/3: Add ref to dai-common as suggested by Krzysztof
- Patch 2/3: Only accept 5 interrupts for mt8195 infra IOMMU
- Patch 3/3: Add missing S-o-B
- I did not include the 'Reviewed-by' from Angelo and Nicolas since the 1/3 and
2/3 changed from v1
- Link to v1: https://lore.kernel.org/r/20250505-mt8395-dtb-errors-v1-0-9c4714dcdcdb@collabora.com

---
Julien Massot (3):
      dt-bindings: mfd: mediatek: mt6397: Add #sound-dai-cells property
      dt-bindings: iommu: mediatek: Support 5 IRQs on MT8195 infra IOMMU
      arm64: dts: mt6359: Rename RTC node to match binding expectations

 .../devicetree/bindings/iommu/mediatek,iommu.yaml      | 18 +++++++++++++++++-
 .../devicetree/bindings/mfd/mediatek,mt6397.yaml       |  6 ++++++
 arch/arm64/boot/dts/mediatek/mt6359.dtsi               |  2 +-
 3 files changed, 24 insertions(+), 2 deletions(-)
---
base-commit: ed61cb3d78d585209ec775933078e268544fe9a4
change-id: 20250505-mt8395-dtb-errors-0847ffc12f44

Best regards,
-- 
Julien Massot <julien.massot@collabora.com>



Return-Path: <linux-pm+bounces-26641-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 027C7AA9467
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 15:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACB2167B4D
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 13:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E027C2580D0;
	Mon,  5 May 2025 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LKvNofME"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030D2258CDC;
	Mon,  5 May 2025 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451436; cv=none; b=hd84qW2qTaCh+uL6/e/zgZGXAK72ycw9SQINHqI6ICrGJ/FtqV718Fe8/G8YYxdTHhjTIRvlVUP1Pp+LpP+/gl4uG6eq4b1SPvdJTWBRUksZIvTtCysa9mJ5031FYkkM5J/s0o6UHpC/bgNI/GqqruebQoRt9s5lwQPMO5U+Tgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451436; c=relaxed/simple;
	bh=QbkkmaHyuZnAj+y3SRqnQ7lx5DMjnVPYMxS1NGgHdQs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=m81VEVSD/+p2tgS8gPPYkvYnsbWTUl7TbISHyKZCmLMVDOVdCzRoDPZCMtLVV/Zx6iQWrfUHg1G0gQ4O6ttmFOQIR6lfIMZn6JtSxQ4dcIkKjh9dtqMMNniF8/oZvuPU/i9UIXVIEi9SXNcRIyOnArFITtN2lyzEcSzTCipHRl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LKvNofME; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1746451432;
	bh=QbkkmaHyuZnAj+y3SRqnQ7lx5DMjnVPYMxS1NGgHdQs=;
	h=From:Subject:Date:To:Cc:From;
	b=LKvNofMEwOWJfNjV8DSgo3WC7lqIRzc+emoZdyzefyZvjBPQs7q8EfbnQ4xsS26tY
	 rfYPeEMTYjDyV786Bfgmp4DoPpoutZP73w1DaZHxMQUNf8awO7oz4Q4N2ytYm3qLme
	 7ezsdHGfYjuC+/xD83kH38J4JJhtNCiyqgMeeXWbjnWyoIQVNqbkxwMSS9IUvySuL3
	 J49viIy3cBJEvpa5HE91d5dFVqronQyeBGDSt9sCfQ92R974VUQOzD7/LTMmFP1fuj
	 uGjlohK3cM6h5aEX+yiJVEyfzFu8DnGaCb6l9G5bNTbXe0ghvfsiAXK13j/xiDP1bG
	 WP9aKbXs3HKqA==
Received: from apertis-1.home (2a01cb0892F2D600C8f85CF092d4aF51.ipv6.abo.wanadoo.fr [IPv6:2a01:cb08:92f2:d600:c8f8:5cf0:92d4:af51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0CCDF17E02BE;
	Mon,  5 May 2025 15:23:51 +0200 (CEST)
From: Julien Massot <julien.massot@collabora.com>
Subject: [PATCH 0/4] mt8395/mt6359: Fix several dtb-check errors
Date: Mon, 05 May 2025 15:23:36 +0200
Message-Id: <20250505-mt8395-dtb-errors-v1-0-9c4714dcdcdb@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANi7GGgC/x2MuwqAMAwAf0UyG2hrxeqviIOPVDPYSioiiP9uk
 ZtuuHsgkTAl6IoHhC5OHEMWXRYwb2NYCXnJDkaZWmVwP13V1ricE5JIlITK2cb7WRtvLeTuEPJ
 8/89+eN8PmWY0omMAAAA=
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
- Allowing up to 5 interrupts in the MediaTek IOMMU binding to support MT8395 properly.
- Defining the required compatible property in the regulators node of the mt6359.dtsi.
- Renaming the rtc node to match expected schema naming.

Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
Julien Massot (4):
      dt-bindings: mfd: mediatek: mt6397: Add #sound-dai-cells property
      dt-bindings: iommu: mediatek: mt8195 Accept up to 5 interrupts
      arm64: dts: mt6359: Add missing 'compatible' property to regulators node
      arm64: dts: mt6359: Rename RTC node to match binding expectations

 Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml | 3 ++-
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml  | 3 +++
 arch/arm64/boot/dts/mediatek/mt6359.dtsi                    | 4 +++-
 3 files changed, 8 insertions(+), 2 deletions(-)
---
base-commit: 407f60a151df3c44397e5afc0111eb9b026c38d3
change-id: 20250505-mt8395-dtb-errors-0847ffc12f44

Best regards,
-- 
Julien Massot <julien.massot@collabora.com>



Return-Path: <linux-pm+bounces-26723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADC3AABD8D
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 10:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE553A9A29
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 08:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B10A2512C8;
	Tue,  6 May 2025 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Rv++PX5Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858AA24C075;
	Tue,  6 May 2025 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746520978; cv=none; b=VhEzWqSKj1HqV0xZG/goXeJHssyARPRJZZwRCOD5vAMLx1u09baX2NA/IraNugvJHbEUr9VIYKMR618Z9N4qyFmNPefukbu6B+KW1F1BZLy31Dcu+yqsQ8dR7fBE/mKiKSxBAVW9wb0vm1vM/R/U4LGua3vXQ2T6qukCUO+/RJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746520978; c=relaxed/simple;
	bh=F3dtZtfd8sl1XZfT8M5NMHOnj5cKiMAgsEOR1aqdr6U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O3I6GJwnKKvpAgv2pALq4tOXaXtwHfOFcttdPxYgFN7nlN8vZlQ6jpHtoYMZfPax2iRn4PzAusAJ9AhviykTAULyRPPg3KEYc/tFgsk+Ib6aTJjzuPxBfBdVcLZTMUYZG2+3jDGW7/X6dYELl26W3x5SJZ3KkQr90iBY0wQSKog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Rv++PX5Y; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1746520974;
	bh=F3dtZtfd8sl1XZfT8M5NMHOnj5cKiMAgsEOR1aqdr6U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Rv++PX5YnRbe1dXiOufvraYla5D0NWb/6s+6JD5AA3B6FoN/SegaGrRC6IHGdxVD0
	 TNIsIj0OE9zu65/1Qpmjhpj8lhBjHCcLa+ceewQZFQ1CgK0CHjob1zBMDC25c17rIc
	 pzod58fsLIUPj6W/LkxLNKrVmY6r29JBY+BDKT/xslesJ9oS0EMgswwM1vmbKdJujI
	 fDN2xvIH2Jpey+9r1zRx1jfA5TZAcvIegh5NyubUmaohozZ00Utw9tzE6KcdSDuFBQ
	 juSiKrI+o82NKlLKgqWUo2C3qe98W0abkcAxWDsfz3DNrcIYGP35Y1W4nFd5/TQb+0
	 dPg2LT6M9+17Q==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 75C2C17E153D;
	Tue,  6 May 2025 10:42:53 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: kernel@collabora.com, Sen Chu <sen.chu@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Hui Liu <hui.liu@mediatek.com>, Yong Wu <yong.wu@mediatek.com>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Tinghan Shen <tinghan.shen@mediatek.com>, 
 Julien Massot <julien.massot@collabora.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, iommu@lists.linux.dev
In-Reply-To: <20250505-mt8395-dtb-errors-v1-0-9c4714dcdcdb@collabora.com>
References: <20250505-mt8395-dtb-errors-v1-0-9c4714dcdcdb@collabora.com>
Subject: Re: (subset) [PATCH 0/4] mt8395/mt6359: Fix several dtb-check
 errors
Message-Id: <174652097340.119919.13115180921625978268.b4-ty@collabora.com>
Date: Tue, 06 May 2025 10:42:53 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 05 May 2025 15:23:36 +0200, Julien Massot wrote:
> This patch series addresses several dtb-check errors reported for the mt8395-genio-1200-evk.dtb and mt8395-radxa-nio-12l.dtb device trees.
> 
> The fixes include:
> - Adding the missing #sound-dai-cells property in the mt6397 binding.
> - Allowing up to 5 interrupts in the MediaTek IOMMU binding to support MT8395 properly.
> - Defining the required compatible property in the regulators node of the mt6359.dtsi.
> - Renaming the rtc node to match expected schema naming.
> 
> [...]

Applied to v6.15-next/dts64, thanks!

[3/4] arm64: dts: mt6359: Add missing 'compatible' property to regulators node
      commit: 1fe38d2a19950fa6dbc384ee8967c057aef9faf4

Cheers,
Angelo




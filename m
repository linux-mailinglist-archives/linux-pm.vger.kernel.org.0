Return-Path: <linux-pm+bounces-27405-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC83ABD495
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 12:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288431BA25EA
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 10:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF9E26AABD;
	Tue, 20 May 2025 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HMx1bEbr"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948252690FA;
	Tue, 20 May 2025 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747736756; cv=none; b=K5/XN4+O+0Q+0l27MzmAO+368JaRfZCqrqe90keqclWYauNUVE9RueVlCDR4OLUQZEwmXo4y8yFd8qSv5oFmdx+nNOz6YY1QMRaQyEpaPYsnc13E/SXv78DqeA1Alk1U1nQR4Nuhfqp8gB1iJ9/rTeuIZB9jpeKNAR7Qm/xt3wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747736756; c=relaxed/simple;
	bh=wryatFIkuLCQN1Tc9+q9e8Buj5FBmAx9YvgucNUuu8k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pDEqb63k/h/qDVArM6vWejUvvq1XmSPUrZqNHrFtUhdlFTW6Of8Xxeb7TVvNiWePkeFs9j5dS0sBAHn13lnPU+ENcMkOoekhIjALuxr/k3x/ew6BM1LIa0zsOz1yOeFSdZjCykiqZDNvhxse+w6fRQ8905xqt/jIRMU2u/TXZWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HMx1bEbr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747736746;
	bh=wryatFIkuLCQN1Tc9+q9e8Buj5FBmAx9YvgucNUuu8k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HMx1bEbrCHVfTNhtkwmAQnyGH+cil8ZJjLu7WM0axeM4Xu6mwkPfUgeggucWqIw/J
	 DTB1Rw0v97BVUqV/lNXMMSLh55Qbwg35dNShVzzSYiuEp1gh55VO8wUWBvcGmLLWUP
	 RWnzqBZ68Np+s0Yy8VT5VX09Qk9jpi086CCt87j5WGWYICB1rS3cSwExPUR6apiosq
	 ggIlHMiZqRTW2Xz4DckzQayhwoHxM8fAIEMzq1AKNb099yfKsYJ1zm0g+DYhCVg/+4
	 rZxLtZeYc6EPZ+WvD3FGWPBwx/BiDazpKHj8HnAvFYjKZlPQfw4Y16abt+PXJvoRO7
	 W/UBaYHYTkl7Q==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A6E4917E0393;
	Tue, 20 May 2025 12:25:45 +0200 (CEST)
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
In-Reply-To: <20250514-mt8395-dtb-errors-v2-0-d67b9077c59a@collabora.com>
References: <20250514-mt8395-dtb-errors-v2-0-d67b9077c59a@collabora.com>
Subject: Re: (subset) [PATCH v2 0/3] mt8395/mt6359: Fix several dtb-check
 errors
Message-Id: <174773674561.3414755.11029706067816008255.b4-ty@collabora.com>
Date: Tue, 20 May 2025 12:25:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 14 May 2025 10:19:55 +0200, Julien Massot wrote:
> This patch series addresses several dtb-check errors reported for the mt8395-genio-1200-evk.dtb and mt8395-radxa-nio-12l.dtb device trees.
> 
> The fixes include:
> - Adding the missing #sound-dai-cells property in the mt6397 binding.
> - Allowing 5 interrupts in the MediaTek IOMMU binding to support MT8395 properly.
> - Renaming the rtc node to match expected schema naming.
> 
> [...]

Applied to v6.15-next/dts64, thanks!

[3/3] arm64: dts: mt6359: Rename RTC node to match binding expectations
      commit: e19de38cca6d037bf3ab5b9908d49e230f817062

Cheers,
Angelo




Return-Path: <linux-pm+bounces-23247-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDC1A4B366
	for <lists+linux-pm@lfdr.de>; Sun,  2 Mar 2025 17:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44101890DC4
	for <lists+linux-pm@lfdr.de>; Sun,  2 Mar 2025 16:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C705C1F1301;
	Sun,  2 Mar 2025 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gMRm2RCw"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A951EB1BF;
	Sun,  2 Mar 2025 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740933172; cv=none; b=kALCtawNTA/0Nxkh9fSV8VcUpYUaI31BH0qNWyIc5TiOhCmidQpnXdw9VQTvZ/RjwturpbjUi1XTeh1gGAb4yZQ6qlzLkzeRPqhYuC5kG6BLuhQFydJw4/znnhtqc89U8YmVqv5/OMH0RS8ZvWVO/iUMA/eAtQtirUqQzBMixXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740933172; c=relaxed/simple;
	bh=vy7W4XMABxoxejxdW3NIH5jjNnEdXu3h8szhJ30eV5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YYZcggLbzoUnQP+rqYfBxLtV4dcak8PZ9o4L+nohlnziKU4400y2VSIw39rScDHZ6DweYHCxwNlDE9J5B9DBUcO9gyB+gNvqOzj6Wd8l/z+ofvVhkFFXRL/PuVlQRacSqeORgqBx9By5IwfxgfL8DRpkZF7xFQtDfN4TID34TWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gMRm2RCw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740933169;
	bh=vy7W4XMABxoxejxdW3NIH5jjNnEdXu3h8szhJ30eV5s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gMRm2RCwsPFGw7WJ7Tn7/ZFH8fpan3ZHxSy5CkP7HU11qyYX9nHj0STvUe93UMPFX
	 iTpEwzTB+MhioplZOqrgARamas0vuKGEDyKkCJpp0AcCGVX2WA6hf15W96A2IWG3wN
	 nCCrWqoU0i0w0nyLef8wgC0YkAymZpWGEhP4a2mUpUQRXom7covdScFFnOxFUED4V+
	 YZsFqHg2ul7FW7Bpk10AoVEJiWeWGGZrIb/nQ/nAJn1w622V52pfn9fjegxSN3YrlS
	 A1GT3YZR4bS/4OJjkgBrSKsg8fuMnxUct//F45XNmdebYq7N/oxdVKGzGkUSOrj96/
	 FLSc+gCOFZ5JQ==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1002])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A570517E023F;
	Sun,  2 Mar 2025 17:32:44 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Sun, 02 Mar 2025 13:30:59 -0300
Subject: [PATCH v2 20/20] arm64: defconfig: Enable MT6359 ACCDET
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250302-mt6359-accdet-dts-v2-20-5bd633ee0d47@collabora.com>
References: <20250302-mt6359-accdet-dts-v2-0-5bd633ee0d47@collabora.com>
In-Reply-To: <20250302-mt6359-accdet-dts-v2-0-5bd633ee0d47@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Enable support for the ACCDET block in the MT6359 PMIC, which provides
jack detection capabilities to MediaTek platforms.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e675bedbc170ccb191f4991e348e36b5de0707a7..dec4708d5e946fc890751cab8de2cf3f302e9447 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1065,6 +1065,7 @@ CONFIG_SND_SOC_WM8978=m
 CONFIG_SND_SOC_WSA881X=m
 CONFIG_SND_SOC_WSA883X=m
 CONFIG_SND_SOC_WSA884X=m
+CONFIG_SND_SOC_MT6359_ACCDET=m
 CONFIG_SND_SOC_NAU8822=m
 CONFIG_SND_SOC_LPASS_WSA_MACRO=m
 CONFIG_SND_SOC_LPASS_VA_MACRO=m

-- 
2.48.1



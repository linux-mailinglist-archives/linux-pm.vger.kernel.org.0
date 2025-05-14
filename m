Return-Path: <linux-pm+bounces-27125-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A42AB65C1
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 10:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C61176AEB
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 08:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410F8221572;
	Wed, 14 May 2025 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FbIksy41"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A8521D3CD;
	Wed, 14 May 2025 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747210814; cv=none; b=YK0+JuBHCLul9UMkedTOnscQpD2hLu2UhINEmDStfkgyP1nvBtzsbt3E2qk8gyK6+I0H0BhY/54RcnmglINYR00DtHKTNCpfjw8zySTwfYuXA556RbkC/FQVdT8vXDe4zhMaHgFIBQJFf78toLW/+KQlSdwyGa0m5wHUpqd/hRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747210814; c=relaxed/simple;
	bh=Zu2ghSu2kt9/8uiiXqMjSaX/ZzpuEjE3fucBPzK/Mh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xn0Mxw9wMyrnz5P+WjJXhC6TQBVr0/J+evjd53TUZdB6HWMK3RuYrpLA4r67ci0SxVjRQzUMqZm1wq+8bmoFl6AIg5j9anNzgN8DchTSp/JHb0+6uqVjuDaaaOC1T75oMQR0tGvbGd6F5/f11VK41dhF1oWnZHaRqmmO8hjq7k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FbIksy41; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747210810;
	bh=Zu2ghSu2kt9/8uiiXqMjSaX/ZzpuEjE3fucBPzK/Mh8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FbIksy41gayjGfbnDbwUgJ+VWVum8h3wOBQf5wn6CT0+RkA6RtNGoEIoyARNVoT9f
	 aY2uJHsQpxCoXJ2cl2Gz9BB7zh/VYW6LaF+ISC36AtiB3isxMeYFew++lgGjf/wYyF
	 Ea5XT71ZmbC9dMIQFN9X2W5DbOYbfWvb44TXZkmKsKzifZ3O17pAlnNTOfIH9OqDRu
	 zKa47yzPfoO/8vHu+FDKulWmJKI0ZiLFP65rEMjr1v6RfX6fYy1PEHRDEvrStTpQh7
	 eDBdWVnEb9VuBr57i6QwzsX9Cl8J98BJUeaqlT0QUSRReiZ0dmQ2WrmFtcmSh+aRUk
	 /6xZMFokYMTeQ==
Received: from apertis-1.home (2a01cb0892F2D600c8F85Cf092d4AF51.ipv6.abo.wanadoo.fr [IPv6:2a01:cb08:92f2:d600:c8f8:5cf0:92d4:af51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8B75117E361D;
	Wed, 14 May 2025 10:20:09 +0200 (CEST)
From: Julien Massot <julien.massot@collabora.com>
Date: Wed, 14 May 2025 10:19:58 +0200
Subject: [PATCH v2 3/3] arm64: dts: mt6359: Rename RTC node to match
 binding expectations
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250514-mt8395-dtb-errors-v2-3-d67b9077c59a@collabora.com>
References: <20250514-mt8395-dtb-errors-v2-0-d67b9077c59a@collabora.com>
In-Reply-To: <20250514-mt8395-dtb-errors-v2-0-d67b9077c59a@collabora.com>
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

Rename the node 'mt6359rtc' to 'rtc', as required by the binding.

Fix the following dtb-check error:

mediatek/mt8395-radxa-nio-12l.dtb: pmic: 'mt6359rtc' do not match
any of the regexes: 'pinctrl-[0-9]+'

Fixes: 3b7d143be4b7 ("arm64: dts: mt6359: add PMIC MT6359 related nodes")
Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6359.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6359.dtsi b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
index 0c479404b3fe3adc9789386e34bda4dc580b5abd..467d8a4c2aa7f16ade92a287ecdeed5089302045 100644
--- a/arch/arm64/boot/dts/mediatek/mt6359.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
@@ -300,7 +300,7 @@ mt6359_vsram_others_sshub_ldo: ldo_vsram_others_sshub {
 			};
 		};
 
-		mt6359rtc: mt6359rtc {
+		mt6359rtc: rtc {
 			compatible = "mediatek,mt6358-rtc";
 		};
 	};

-- 
2.49.0



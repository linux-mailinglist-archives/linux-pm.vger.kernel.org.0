Return-Path: <linux-pm+bounces-26644-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F1DAA9471
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 15:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D71179990
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 13:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E11325B66A;
	Mon,  5 May 2025 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Q4Tn2UJQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347E8259C87;
	Mon,  5 May 2025 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451439; cv=none; b=loee0XZwiFFGcH3w2wOxsMQ3D+kY5i7afZEJmB0BvjUynKpRkwYMV4x6DAQSiXA7N6JfchV45t/2WTi7a634HQLF1EC0dkhKUeZuCiklFVTv+GvfU3ONkdKabZCgZ+vEJ3lBWegls3VH0x+PkUNe0w1msHqEmHUeBPYads0CvbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451439; c=relaxed/simple;
	bh=UUF6OZ9i9Tm/nhtDH7uONCtGgsGZwxjobJ9R/ceAdZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SnkvZEBPRitrJ1PoJS1AoyK7H2LHqeP7IKjZY2pu81D1YxryuSgfzimY3ZiOUJzS02kylFb5owxkvGGPjqWtfc3pUU2B4SN/w9MqHgAF+Z8JQHbdF4GCS+xMMHsAR6w6u3mK8YHZx1gP/tCndszru5qV6vZiXO9z4Jry9kv3qOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Q4Tn2UJQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1746451435;
	bh=UUF6OZ9i9Tm/nhtDH7uONCtGgsGZwxjobJ9R/ceAdZY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q4Tn2UJQV6TYUvvnHDC1FOSpPYqJHiuotCFrAjGc8KzTebBPOAbvcxtRDuQdoInh8
	 +/Lxh7rarAEDU6kD21+1ssi0Sj2rYOn73U6IYOpCm4bx2ruKwibQQD20zsnKFx3fpW
	 aplKlKS6leqLBRrHgW8TPONL9E2LkGtFpjriZ2q4pYF42bmtypf+YdDnw4jXyDNOzj
	 Xi290W50r3DeVEyr4F1t3E3lvMUoSznajHeAPHr/I7uWc5R8FZKVIy8IdW97IlSGg2
	 dkyCSN6wvs3e9DyBGQt9K2xciTLtgCtJeXnalC9EAgK2jJi2SVYXjIm61Vzy2teSe0
	 C5PoQCQShMBmQ==
Received: from apertis-1.home (2a01cb0892F2D600C8f85CF092d4aF51.ipv6.abo.wanadoo.fr [IPv6:2a01:cb08:92f2:d600:c8f8:5cf0:92d4:af51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7920D17E1503;
	Mon,  5 May 2025 15:23:54 +0200 (CEST)
From: Julien Massot <julien.massot@collabora.com>
Date: Mon, 05 May 2025 15:23:39 +0200
Subject: [PATCH 3/4] arm64: dts: mt6359: Add missing 'compatible' property
 to regulators node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-mt8395-dtb-errors-v1-3-9c4714dcdcdb@collabora.com>
References: <20250505-mt8395-dtb-errors-v1-0-9c4714dcdcdb@collabora.com>
In-Reply-To: <20250505-mt8395-dtb-errors-v1-0-9c4714dcdcdb@collabora.com>
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

The 'compatible' property is required by the
'mfd/mediatek,mt6397.yaml' binding. Add it to fix the following
dtb-check error:
mediatek/mt8395-radxa-nio-12l.dtb: pmic: regulators:
'compatible' is a required property

Fixes: 3b7d143be4b7 ("arm64: dts: mt6359: add PMIC MT6359 related nodes")
Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6359.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6359.dtsi b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
index 7b10f9c59819a9ad02319f00938f35c931091f9f..0c479404b3fe3adc9789386e34bda4dc580b5abd 100644
--- a/arch/arm64/boot/dts/mediatek/mt6359.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
@@ -20,6 +20,8 @@ mt6359codec: audio-codec {
 		};
 
 		regulators {
+			compatible = "mediatek,mt6359-regulator";
+
 			mt6359_vs1_buck_reg: buck_vs1 {
 				regulator-name = "vs1";
 				regulator-min-microvolt = <800000>;

-- 
2.49.0



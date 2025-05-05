Return-Path: <linux-pm+bounces-26645-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D43DDAA9474
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 15:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5F93BC2E1
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 13:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644CA25C803;
	Mon,  5 May 2025 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Aa1aXxax"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB812561DC;
	Mon,  5 May 2025 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451440; cv=none; b=j4gm8lnj3phIWukzAlyHto51WzTwNFtgLJpWXyfC1G9TuboNDkvXryFa8YIr3Kg7YZC1uRye+MGe0tuWsovrQ9BLgZJW2AB/7hyUx+C3oUi+oJXJb74cQlPbI7nFzCVrqiBuWB7pRyV1rD4EFJQBwRjSUjy+yLVfnP9gIU28k7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451440; c=relaxed/simple;
	bh=7O9MG4jLgcmyrOt4F5nMHZqam/0Tzlc42nAmvdBjKHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XcBEzHMJ+2YtoV9bNjXjZ4aqn5xAc4RB6EcR5MtJX9PPXJ/5X16kRKi1xuBJqa5Tto9EuiykY7eqobd4Zj6u5GOQb5YjAkV9ziSWOlRwgv4H388C+MHvBqz4touINFPFVpIcQGTW4cDIGDSnpRNvlRcJhpbypTKzYQHubacKUAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Aa1aXxax; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1746451436;
	bh=7O9MG4jLgcmyrOt4F5nMHZqam/0Tzlc42nAmvdBjKHI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Aa1aXxaxIfsv5TclC5/Rdb0MizLcJFGWmTAHN0twVD93jt5+aN6GGAbcZ/FVdmTPl
	 Riz9oMEZncSfgg2VAOS89wpuZ4OtBtU463bG7b6DGsL49OR/ZK/GxjoWpP8EK4jUD9
	 kCTVP6LtlpwqIcmnZAz2LRojLmw/kgpf434REwIRLXeT9+Vqu4JQiW2fGSblEcrEd9
	 ajy8LtZzl+HMWLeMgv4E5WfRBv4k3fS6VeHpYW8vHPq7ThP9tXEoGX17xrNiQ4tTu6
	 6d2croLDHEXTHMg1APvs2mQuZWU4eFguCg+/44hRzinCQhsTZa0sD7xXER4jS0WFJS
	 jF91XSa5pUsPw==
Received: from apertis-1.home (2a01cb0892F2D600C8f85CF092d4aF51.ipv6.abo.wanadoo.fr [IPv6:2a01:cb08:92f2:d600:c8f8:5cf0:92d4:af51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9954E17E1504;
	Mon,  5 May 2025 15:23:55 +0200 (CEST)
From: Julien Massot <julien.massot@collabora.com>
Date: Mon, 05 May 2025 15:23:40 +0200
Subject: [PATCH 4/4] arm64: dts: mt6359: Rename RTC node to match binding
 expectations
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-mt8395-dtb-errors-v1-4-9c4714dcdcdb@collabora.com>
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

Rename the node 'mt6359rtc' to 'rtc', as required by the binding.

Fix the following dtb-check error:

mediatek/mt8395-radxa-nio-12l.dtb: pmic: 'mt6359rtc' do not match
any of the regexes: 'pinctrl-[0-9]+'

Fixes: 3b7d143be4b7 ("arm64: dts: mt6359: add PMIC MT6359 related nodes")
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



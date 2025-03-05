Return-Path: <linux-pm+bounces-23517-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D78AA50ADB
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 20:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83F73B13A3
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 19:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ACF25D8E3;
	Wed,  5 Mar 2025 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IuXf3BtY"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532F025D54F;
	Wed,  5 Mar 2025 19:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201266; cv=none; b=lkXD1wkglLNrfJmdQ9q05QkM/4rQhtom7trOdmlY1+ihkMbc4DfoI9XeWUoYXMQVkFapEkHkxeeBHUVJWhafA9yWg7d485LzZ6t2wna3uAn6l2Y6uFqIdH9Zxhbf00jyi11W37ZwYntcCzpk/TQM5Bj6WRy0rz0ugTtOb6ovSzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201266; c=relaxed/simple;
	bh=LBdY8EkTk1rXFVfcF9dktYOACXoiU+urwy0jL5VUVpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BDL08u3KL2QphWwk2zuVLZaDLU2P2Pg3npE6DKp+X+/iEiwBlmJqISvXogpw/lSlzQiaUepsIPgL3ymXqZeyzp2IcsXQorc8wvrBQW0lCgVoLbLOF9TaINXN0OsKfBDyN5edUZknjoe+Bv6SzTQgKLUFhb/4fVW8j/nBqYR3bF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IuXf3BtY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741201262;
	bh=LBdY8EkTk1rXFVfcF9dktYOACXoiU+urwy0jL5VUVpg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IuXf3BtYf76XRQvTBO3BSzS9ZgxSL5VE37LgFa1d0QSD+NtAGUaDeuTDK2Usk4rsL
	 Qsw/zFrUoNS9nskW9RYtucozQNvq2gd1DfkNt5rgkLkAQOrYV72GqtESEzSliQpMJs
	 MLxce7Dl84zmGr9Q67Yqa0lpjr5Y/7ud/7ZmUU326t/om+BdGXTCkLZyOntbpUYGju
	 EBO7cm4IGURvJbMCVkGq2crXnYHHpK2QsyE4cx4BuUqpQQtu/i4GPp12w7LCZY0m/H
	 17I7RJm3XpqZREIfVR00ezZlh1/jrjlDmxm9wiick9HGot7v5igYdmL+zHv/Zmmc9z
	 rQiBsd0CtdYVg==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1004])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 62CF817E0343;
	Wed,  5 Mar 2025 20:00:57 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 05 Mar 2025 15:58:33 -0300
Subject: [PATCH v4 18/19] arm64: dts: mt6359: Add accessory detect node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250305-mt6359-accdet-dts-v4-18-e5ffa5ee9991@collabora.com>
References: <20250305-mt6359-accdet-dts-v4-0-e5ffa5ee9991@collabora.com>
In-Reply-To: <20250305-mt6359-accdet-dts-v4-0-e5ffa5ee9991@collabora.com>
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
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Andrew Perepech <andrew.perepech@mediatek.com>
X-Mailer: b4 0.14.2

Add audio jack detection node. PMIC accessory detect driver will
create an input device that will send key events on jack
insertion/removal or accessory device key presses.

Co-developed-by: Andrew Perepech <andrew.perepech@mediatek.com>
Signed-off-by: Andrew Perepech <andrew.perepech@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6359.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6359.dtsi b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
index 7b10f9c59819a9ad02319f00938f35c931091f9f..e24e4aeb3b9cafa2af56c62bc4c549df27d0ec73 100644
--- a/arch/arm64/boot/dts/mediatek/mt6359.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
@@ -15,6 +15,10 @@ pmic_adc: adc {
 			#io-channel-cells = <1>;
 		};
 
+		accdet: accdet {
+			compatible = "mediatek,mt6359-accdet";
+		};
+
 		mt6359codec: audio-codec {
 			compatible = "mediatek,mt6359-codec";
 		};

-- 
2.48.1



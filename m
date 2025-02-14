Return-Path: <linux-pm+bounces-22094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 815B9A36456
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 18:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1D118970C1
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 17:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA39D2690CD;
	Fri, 14 Feb 2025 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gIesuFvp"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0566E268FE3;
	Fri, 14 Feb 2025 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553578; cv=none; b=EeahvIXYCg7oPasmEEmKXQmi+TrR6qoHNp5/tE/rdtc3UV0klPi6i0vaSLVVmxAzw/wfLs+fvMyW/6TyXXZtgOD6Ffg02nwU2oFUwTBcf3yul9K1yC0Bk0C3rP9MtQsh7XcNVukZOSk5rMxsA9powRGwCQ2LVVmxJ6t/0gaql8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553578; c=relaxed/simple;
	bh=lPL1S5SCW1+PI23N/jcgP12hMhBfoTHib8FSUQooe88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YVAFbOOdOE9UJKxHKNAf4AXLiN7aYKbAwtIPOpVtRmLb8NZ2ywsiI+flu6NnO7meIMtkfNoydOU1uQ1fzdaMfwmFFsPdDI/WUxEcZ0zYxZRyr1S+69QbRvR2prid1tB5DUBbI46A8iVm8iOxanJ7Q8pxbwlKPasRZURBFbDmbuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gIesuFvp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739553575;
	bh=lPL1S5SCW1+PI23N/jcgP12hMhBfoTHib8FSUQooe88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gIesuFvpOQ7/iFIFngOzZTm6MMmukdjPv3X0ec+jjsVWTpHWiOj8ZTRn4iHbg8i6n
	 lkHkV3Gk83RNtg/wMlqz+n34f+cNavlirn+ucU7LgH3qNPZIQ/byWB7VHvRFpy6asJ
	 /0awctKwFeOOnw7M5HSD16qVlUHQQiG2NRMlP5bb8QndM4gG4fbhUKOo9cUlYKKrd+
	 XKjboOZrfkQVV4KWAsMK018sUEq2pj77ABcw33a7Xg9JlZGdYeoU20IGYXP8YJPNkY
	 Fya6ZtvLW8cMLAxUaGFpiDqtOBwbe1z0iDECm6R2IJ4c6jGAg39NeV6qZbCvq5rAFV
	 fjnRMsE8Wp+sA==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1003])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B7F8417E1551;
	Fri, 14 Feb 2025 18:19:30 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 14 Feb 2025 14:18:35 -0300
Subject: [PATCH 04/13] ASoC: mediatek: mt6359-accdet: Add compatible
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250214-mt6359-accdet-dts-v1-4-677a151b9b4c@collabora.com>
References: <20250214-mt6359-accdet-dts-v1-0-677a151b9b4c@collabora.com>
In-Reply-To: <20250214-mt6359-accdet-dts-v1-0-677a151b9b4c@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Andrew Perepech <andrew.perepech@mediatek.com>
X-Mailer: b4 0.14.2

Add a compatible property and add it to the module device table for the
mt6359-accdet platform driver to allow automatic module loading and
probing when the compatible is present in DT.

Co-developed-by: Andrew Perepech <andrew.perepech@mediatek.com>
Signed-off-by: Andrew Perepech <andrew.perepech@mediatek.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/codecs/mt6359-accdet.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index ed34cc15b80e856356c07fd53af22207124e0d19..6f07db879c6a56ce4843954f51bb9602373e4aa5 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -1047,9 +1047,19 @@ static int mt6359_accdet_probe(struct platform_device *pdev)
 	return ret;
 }
 
+const struct of_device_id accdet_of_match[] = {
+	{
+		.compatible = "mediatek,mt6359-accdet",
+	}, {
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, accdet_of_match);
+
 static struct platform_driver mt6359_accdet_driver = {
 	.driver = {
 		.name = "pmic-codec-accdet",
+		.of_match_table = accdet_of_match,
 	},
 	.probe = mt6359_accdet_probe,
 };

-- 
2.48.1



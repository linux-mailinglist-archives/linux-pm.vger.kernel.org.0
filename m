Return-Path: <linux-pm+bounces-23385-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D754A4E361
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229ED17CBCE
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8526828628D;
	Tue,  4 Mar 2025 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TSwChb+3"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B296528FFC2;
	Tue,  4 Mar 2025 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101393; cv=none; b=euahwObhZI2FBZIUa0hcgkUY1xwdilz11eofQwZchfYqAwDXUBkz/PBJaFtVHmAlR92IECKPI53xOw+XKdgbtw2cNHg07DIq7hykV5UlCQp46SR+JTPbIjx4whL4Je2Hy+Kwj+rN8cvLtYRaXW/abh602e/ubDpapjWnkniYP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101393; c=relaxed/simple;
	bh=7unty8UXqbw+pOftMZfZMEYJgXbtayExa3QUkhZmST8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jIFAAdSsvHw9Dwytf+appJnvEDUJ6ZvIeEjeiPogX6vhCjWZ4x7sM8ZhCbRIuVqd98qhpWAgYssaeb3XPqT+MQacrzaDfjt9yrNEF8D+cnxeUMa+STolEi1h8CGIC4Ru4qmGPJn1GsEx9CSLKoVRQsZ02oSKxlwm5k1boZfiIro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TSwChb+3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741101389;
	bh=7unty8UXqbw+pOftMZfZMEYJgXbtayExa3QUkhZmST8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TSwChb+3bLIpuXS2XzsT7LKfEc6aZ1CJoFcIGvJhgyQryqHwc/ZrIHImF10+xHcW4
	 vLprAnU9GuMUhz2192BR5bFmzBCe5SCG1bYdJGNmruwnzgP0hCXQyc/nQOi3hsInsd
	 fo0hD9Qq/S8vAuGv0pXcbyjB4C+WUz0z7Bds8iY0Ceq8Dvwbevbt/qjbg7t6EbTTon
	 tQhvBxOYC5oTH1m6jompMQm9nCQkyIIj8c2mU86MuueWOdJ26ex8smg0fSaMV0gsT/
	 OaDk/wGnumNBU2vnMEYCkF97KY0sB0s7xGt65PYWWulLJRF2fzsYEIumZDkWrGteZo
	 gft8++3QbfnPw==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BA50017E0A4E;
	Tue,  4 Mar 2025 16:16:24 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 04 Mar 2025 12:15:45 -0300
Subject: [PATCH v3 04/20] ASoC: mediatek: mt6359-accdet: Add compatible
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-mt6359-accdet-dts-v3-4-5b0eafc29f5b@collabora.com>
References: <20250304-mt6359-accdet-dts-v3-0-5b0eafc29f5b@collabora.com>
In-Reply-To: <20250304-mt6359-accdet-dts-v3-0-5b0eafc29f5b@collabora.com>
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

Add a compatible property and add it to the module device table for the
mt6359-accdet platform driver to allow automatic module loading and
probing when the compatible is present in DT.

Co-developed-by: Andrew Perepech <andrew.perepech@mediatek.com>
Signed-off-by: Andrew Perepech <andrew.perepech@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/codecs/mt6359-accdet.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index ed34cc15b80e856356c07fd53af22207124e0d19..9bbd4497e8d481ee125693be2fc576b439574b39 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -1047,9 +1047,16 @@ static int mt6359_accdet_probe(struct platform_device *pdev)
 	return ret;
 }
 
+const struct of_device_id accdet_of_match[] = {
+	{ .compatible = "mediatek,mt6359-accdet", },
+	{ /* sentinel */ },
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



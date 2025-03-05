Return-Path: <linux-pm+bounces-23502-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4B9A50AA2
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 20:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C243B127D
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 19:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC68D2566F2;
	Wed,  5 Mar 2025 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Gnu5ek0j"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C54253329;
	Wed,  5 Mar 2025 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201182; cv=none; b=sF7P6JdRUiyEmbrqYaQ+G/oEfiUj5rXd0Zq/Hm5IuSHbLUgXUVD3mKBO9uJpATG7y5x12pEQYgt5Y+pKtE5GOVlR2Cr1GfSB8Xk8XG7UWWw/vQMQbd7Rn0/nN34aAJar3aVQXWrHvxcIRfVIk2lcbRWIh/k5h1aIR37VVVoEjNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201182; c=relaxed/simple;
	bh=7unty8UXqbw+pOftMZfZMEYJgXbtayExa3QUkhZmST8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EBFf6LvZKp9y7e5DCzo2nqTFQkbNDCVBIJEr2fu/cmGtLMAvb79YDK7kwpWvShvQ3S+9mc/OZ5pcmOs+M8vz9PK6VHyp19ivXIpty+wSbr52vwbELdZNfpPwdsKxg4RNUnlIaMSpbF50FYVLi2DewQLLnweXJeNRl6yzq6kI27Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Gnu5ek0j; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741201178;
	bh=7unty8UXqbw+pOftMZfZMEYJgXbtayExa3QUkhZmST8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gnu5ek0jDhwqQz4n+vs9wTNjmYg3IM26mbEuFo3m8l3nRPaKX3AeZAusjqQG7tDkJ
	 /9a7OEOXimGE8mCBRt3fxArsWloBx2pw7JG+q/+XGgKI0z65Ef0XHaIgx6BNwcTJiw
	 Zo2xlj0MQJyA+DiMhwD1LvFKIRB8kf8i+OrLardIGzieceOgdLlAvcN8mMuuGRwXgw
	 TERFcB7rOjy02xiw29kjFORyyl+Y4GQjjYKvhmDSqp7omzk+U/Vo1ohDzL12BGCo9q
	 Ow15ERJ9oSpeoXQmnt5RcjcsTRP7LfEiI47JwVnAZ7YplsvZmOnQtW0rIa2Fin2ej2
	 ZLhKHkV74hg4g==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1004])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4C0E617E05E7;
	Wed,  5 Mar 2025 19:59:32 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 05 Mar 2025 15:58:18 -0300
Subject: [PATCH v4 03/19] ASoC: mediatek: mt6359-accdet: Add compatible
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250305-mt6359-accdet-dts-v4-3-e5ffa5ee9991@collabora.com>
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



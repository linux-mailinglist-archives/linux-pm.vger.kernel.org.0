Return-Path: <linux-pm+bounces-43056-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOG+MPeNnGmdJQQAu9opvQ
	(envelope-from <linux-pm+bounces-43056-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 18:27:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F9A17ACBF
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 18:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A8CE31BF8F7
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 17:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F231330B30;
	Mon, 23 Feb 2026 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvOnwKlP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3CC329C60
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867104; cv=none; b=KgFzZRs0BOVRS53xSiV/tTzO1vnPRj22busz589/vQB4ww+dM78K/12l8A80dQgZ4gp+CjvLOPzX8RiqEqKbij4BJS4yy5zTBG1oxLcgPYJ5//GGgUlzH1JLMGzPGMWvXbleMUT7dLh/jLVv5GyVDrIyI53OB/PAAmoGq46eDwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867104; c=relaxed/simple;
	bh=af/yagtcX4I0+3jtdjbr6gdjXxsaceuEo/D9CvQnsQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIQYGBbY46B4Q7OqhHGAHS6LpHG9z+dlam/PPHGUL3Fk3hU/DCVtXBX3nl3bYKaN6KHrA2TArBAvuLfUMLgxnuHi0rAKUAYwDnCRacLQLiJ7qHnXAZHY3cKOo4LGjWiFRib+hJs52CIXYSdh9GmfX+RacuHw/cR9b/URO6jTOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvOnwKlP; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4359249bbacso3377903f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 09:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771867101; x=1772471901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePW5oPXSIMZFrvCYy2NgcvqQ/NoHzPv8EJgBsrDZt6s=;
        b=VvOnwKlPcTfODKE8OuLwU0SCRgptBaK1x9DFWHdKOxgOM5eohJPF3rxQqAiGMqh4XG
         ffK0IbGGWexEj2p9+bnW6EMwZeblXZZIx8UZRaVIEs0E9kCw+X0uJYZ7RUn4FPc6UxSo
         j0kytO7zGvas01hyQV/KHGry6Gk/3nzvYku3l4Cbi2pNylE6igGbooruV8exWgglaAnl
         uPi4ehAE3pVhrfH5So9vHKWQZaaOjYnFnSrjXJ1rbc7J4y4JbPQFYxqJ4q2FC/xtSbVz
         kATorzwNqg5VdAqRk2o8tvNorW1iRbyyMW055bI0ewHOKQHqG6ZIa16Mlj/kWTTAwRAu
         XtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867101; x=1772471901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ePW5oPXSIMZFrvCYy2NgcvqQ/NoHzPv8EJgBsrDZt6s=;
        b=uFEZIkpk4Aihyjt0naXVQ8qV83MO2c+h1ItgWw4RZCdodB5W9P7Vjk15mH0QD59riC
         Fmcle9H654a1Uu8vkxU1xpdGjZjCiCzb0dZBbSOO71dgkZJBJXmLe/a73fcZtTQmwiT5
         4P7E6oo1SVkGjr6BnVZIflibXOxwvLAWq96wWzt73UriBt1Kiw9WrBWYnS6gJmSwqLjE
         06Mle6X9zC7GZtfJp386w8egN31iCrj5kL7McGtTppjjlSP2HuMJoBN8eqo9lAsbjc31
         9bScimY9YgTzgZ7/FMWsKLP3a8V5eJ5EQtih5fYMMJtCBQtH2uahp1mdznNUZijF87Qd
         xqDg==
X-Forwarded-Encrypted: i=1; AJvYcCWvfwwqZSBvHRdr5uGMbgjoZtj8Pkt1XHlVDmx16q68ugN8HjsQXHApQXiffmx7bgzqKGT1wmQU1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRSwmdc3CQ7N/Z0SzxGPF/cW9ZzLypqdV4CdzrkYx4woDHliDu
	U7zYclCPAB1785tofNzQOYI57sLDMkPfv0MEWf0Tn4HjTX1RttEsOMvI
X-Gm-Gg: ATEYQzy4mHjnsWfyAqIiTQV1pLG8jERlxUvmJbTedMc2Kw0j4XLN2jaKHp4Q+BWyx+D
	xbyMLZpr2MVo71h2uL+fslKMv2gH7sC9hGzRXKhtyfcIokwhK0dBov33m1gLZwMqQcVk/r50D0z
	pGMjKg2LfjtKJT0Ne8zhK210EZ7KSbsoq+5rIGVglirCNpUhkVKYsxLVLfWP1XHplkgpWDLKme1
	Lo3hmv8WEejJY4UzGF3ZGawjd9zDOoCNVUMLCgBg89uB4PDB4RW+T9CtCXq8E9L1VDab3WcG5Ud
	u+8gKaIMA9l+ll8oQKLlXcAWH/aE9LXDBoyeTBrjS2SLfQj+w0xo/nEA4o/kdp3H2lEF1osbHao
	10aS+r/0F2T/OdfH5V7LWg3FIwBZtbV1kkkd0B/du4NZ/Bl7B3SjSPqNsD1aSq1B6TjXcqsBV8B
	ZOQ7YVYYbKRIYre8KcszE=
X-Received: by 2002:a05:6000:22c5:b0:436:549:e15d with SMTP id ffacd0b85a97d-4396ffd6befmr18768227f8f.18.1771867100114;
        Mon, 23 Feb 2026 09:18:20 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c982sm20871454f8f.31.2026.02.23.09.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:18:19 -0800 (PST)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Eddie Huang <eddie.huang@mediatek.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 7/9] input: keyboard: mtk-pmic-keys: add MT6392 support
Date: Mon, 23 Feb 2026 17:12:46 +0000
Message-ID: <2c96591313084d240ac94b9d42d91d984fa9bce7.1771865015.git.l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1771865014.git.l.scorcia@gmail.com>
References: <cover.1771865014.git.l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[packett.cool,gmail.com,kernel.org,mediatek.com,collabora.com,bootlin.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43056-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lscorcia@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[packett.cool:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 65F9A17ACBF
X-Rspamd-Action: no action

From: Val Packett <val@packett.cool>

Add support for the MT6392 PMIC to the keys driver.

Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index c78d9f6d97c4..3b9a5b6bc470 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -13,6 +13,7 @@
 #include <linux/mfd/mt6357/registers.h>
 #include <linux/mfd/mt6358/registers.h>
 #include <linux/mfd/mt6359/registers.h>
+#include <linux/mfd/mt6392/registers.h>
 #include <linux/mfd/mt6397/core.h>
 #include <linux/mfd/mt6397/registers.h>
 #include <linux/module.h>
@@ -69,6 +70,17 @@ static const struct mtk_pmic_regs mt6397_regs = {
 	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
 };
 
+static const struct mtk_pmic_regs mt6392_regs = {
+	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
+		MTK_PMIC_KEYS_REGS(MT6392_CHRSTATUS,
+		0x2, MT6392_INT_MISC_CON, 0x10, MTK_PMIC_PWRKEY_RST),
+	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
+		MTK_PMIC_KEYS_REGS(MT6392_CHRSTATUS,
+		0x4, MT6392_INT_MISC_CON, 0x8, MTK_PMIC_HOMEKEY_RST),
+	.pmic_rst_reg = MT6392_TOP_RST_MISC,
+	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
+};
+
 static const struct mtk_pmic_regs mt6323_regs = {
 	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6323_CHRSTATUS,
@@ -301,6 +313,9 @@ static const struct of_device_id of_mtk_pmic_keys_match_tbl[] = {
 	{
 		.compatible = "mediatek,mt6397-keys",
 		.data = &mt6397_regs,
+	}, {
+		.compatible = "mediatek,mt6392-keys",
+		.data = &mt6392_regs,
 	}, {
 		.compatible = "mediatek,mt6323-keys",
 		.data = &mt6323_regs,
-- 
2.43.0



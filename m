Return-Path: <linux-pm+bounces-43804-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GGTL7nDqmnVWwEAu9opvQ
	(envelope-from <linux-pm+bounces-43804-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 13:08:25 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 435192202D0
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 13:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE99F303DDD0
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 12:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F9838F250;
	Fri,  6 Mar 2026 12:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1mzJZkG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A7E38E5D9
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798819; cv=none; b=bDL9wt/CL3RV28Y0b40JbjtBMUSDMJ+B0fUweRoBLYf2ioqbyEUCu1ucSQzOQK/eBauB11SlUe9/VwJ2IiOVqgNtlntaeRuGgVG8AtK49F+WmO9E4bb9fmeAt8L62mvq+Bl3Gh1PyitGnJhWg4lPUCTa2Fs1LoT0G6AKBSsZRac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798819; c=relaxed/simple;
	bh=BMyjA2CmGChdg1HJ8bO7//vNQzLWGBKCzzTI2pGO3F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a16i8WwAV/YFhSxZ9umy8XHH1/gcaR4c1Nvce7lUKALN6w9YeRS6l48fE3W8L62oc3Hmck6Hsiz63tiHzcpE/jIFZHu3DVOte07YK8ehgSnU+gVNgb2G18Yr+VUSMdRfV9DGmR3nxqhdx044GUlTo85CfDltOW4qF+JiD2Lv3Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1mzJZkG; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439b6d9c981so3935176f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 04:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772798817; x=1773403617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97jIgM6P/d9EfNIE9WeYwD3m3n8Lqle2XokpQhzkWdM=;
        b=Q1mzJZkGgzNN/vrE9aIIUsbD/BQUXkx+ieGWACw3XHC32AeNzB1GCM2pt5507q0d40
         X+8nzqwLOX3NM6pAR7T7yL6u+d8+qMJyKo1KmRrSX/aVQLoLT5y1VOPBi5yjGqJCrFG1
         WN+yAVkWyo9evBheTg16N9BaFr+SsgSSr47sMA4sdg9iARthEuyk1qSsxGRArpi36f9O
         amKRK7ZegQDRLekrEVMloxi15IpSFyzDv1T8thn1wIOe8AUd5ocMGzdVST18qm1PPYbQ
         vF0T5XPbm5j1YrACuYOQH5XOqUi/Rsj0pTzfJHpuJlqH3MQSl+q/M9LLUmr1VCQfESUR
         ngaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772798817; x=1773403617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=97jIgM6P/d9EfNIE9WeYwD3m3n8Lqle2XokpQhzkWdM=;
        b=bOzd0uiSKDC5VY5LwxvPksspULubJp9QZdl3OKgskvQXICpqikk9WDhE2aWE8B88V2
         QccU7GzxDiRXZc0w8fVZMo9XDkTk1jFdBpciB+pwUKKKK4qsxfWksT6NFzm+zF8BEwaW
         mMTOPwwZV/gmSZ8z3xuSxXLpI7v6iS9bjZ2RHyiK+rfUGMb5AhreTgLlm9rZvPLT/1OK
         LxdwJMOCas6HVxo4I9kwxpGKmr5fpFGuLDkFIthEX3xM+wwmTkt8S8oqB3rFLJd+aOON
         4k1BbV2CIVWBTHOdJhTz4QU7frZdpVw4n/K2VbDIMVMj2GM/wTNao6MdsOo78JNvrsqN
         pW3A==
X-Forwarded-Encrypted: i=1; AJvYcCWbOGNbnt7g8o9HWKKeUNDCS4n8dBcGMlpZW1KnUxCXCO1QLrJV1gqf4sjY2KeTMOKwqW3W/vI7aQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMso8PZYtRMSNhmoCdVuq1lJmDvg/bQkE8tHr4ytF+Evg6Vi9l
	1nYmAMChd/nD15OgDdbkr1BLD6/wHn5YLRGHIRKx04h8XPuZWLBkKyp6
X-Gm-Gg: ATEYQzz9juGpcbLbE3Ao3K3zCVthctz5XFvNG9mrRozZ5SRK68F9BL22vDpbSrA+Lmj
	iYBRB5nzqz+5s/wfGoJbNPBrpuo56bo/pCC8SCxiTV3ewpHrPeC1saicATCsL+d+8wDyyyZGIUZ
	1d7GzB+4jniJyEModwMVak4oy/SypVtM9yg0bVu9Eja0o4L3LEbFl8aZjJrNgInyncB1fxPoKum
	84ku/i2RFXJvwbnc1AHEy/sYYpt8wkq2iyR73ok66qpE/yuuLf/UTd9DoWxxOffrFHJesobthQ9
	ATOMdt0HaatkpO9vnz72mSwLYMePqQhtgzAe57oU7THBxHE93o/U32/ZMQU5eyXlGBJkGWktYH8
	QaOzj4+S2jQNLMdaSbn1B0s5Tz6zI1nuIlkvFaa//uKt0XiVfCV1Nm00gJnWsmdqxbwMbDTU5Os
	wxctJIOaeCgilA2cS7ATw=
X-Received: by 2002:a05:6000:40df:b0:439:c018:60e1 with SMTP id ffacd0b85a97d-439cfd76d02mr10149414f8f.21.1772798816912;
        Fri, 06 Mar 2026 04:06:56 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2b9d8sm3457225f8f.21.2026.03.06.04.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:06:56 -0800 (PST)
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
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Julien Massot <julien.massot@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 6/7] input: keyboard: mtk-pmic-keys: add MT6392 support
Date: Fri,  6 Mar 2026 12:03:10 +0000
Message-ID: <20260306120521.163654-7-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306120521.163654-1-l.scorcia@gmail.com>
References: <20260306120521.163654-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 435192202D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43804-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[packett.cool,gmail.com,kernel.org,mediatek.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lscorcia@gmail.com,linux-pm@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,packett.cool:email]
X-Rspamd-Action: no action

From: Val Packett <val@packett.cool>

Add support for the MT6392 PMIC to the keys driver.

Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
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



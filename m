Return-Path: <linux-pm+bounces-19749-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFE89FC843
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 06:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225C31882E64
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 05:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA3716F8E5;
	Thu, 26 Dec 2024 05:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="fPkCdAQ/"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335BF7711F;
	Thu, 26 Dec 2024 05:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735189910; cv=none; b=me/o3HFLS409RWGXH+XTeYi+rgjcywLQE098dOE5wxA9BCTyH+e+cru89n7wBAI9rQBM8JY/O2gzPusDg8CM7DPGW4rr8zmJJ9AgUVjkSPYVcL3xw68/ZJcM15E+cQ1bWGsGQ8ByXhIBlhNxpbFEgtZ+9vHSyOP3PJ3Ofbp7ZSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735189910; c=relaxed/simple;
	bh=+Sb/sJjICe5iy+4s4TZANwNNBw2R+74S7xkHnEfohuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOCHjiuYp+OLkbExT6+mJ/Z508B6s9qG/Mdo0+fA9zQVuteHLbxKW8pZ3jec9E1u7K5XBY2OUnlnxYxnRxiqxihhO/6gh/orJGZd/03hxvriinvkTY2xnuMo+gplPAQNP18EBY9I6iKpFNUJ8+zwZP+LBp6QRJKKrFcgiVH9lSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=fPkCdAQ/; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1735189907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vwQ4N1e+TBjnM5P/3WcPIc4WkvpX1QuMyXV+3IuUEkA=;
	b=fPkCdAQ/vP86/E35KgJIAWs1gu/guAcpRuxfTWJn5tNwJ7CCcAUJ0Cbts08Bk0vsfgLbR3
	z9WhpBpo2Wp2QWQP6ixhx2U4DyA2xsePwxYpVvEeS5IhOIXS6vGq0v3yTSQ96U+0NGRLKt
	L+TmhvpPqKoZNOa6/tr4N7PwJs8Kdi1ODdp13rZYYSMGxg8j0SYRgslr7KyeVCFEfY/dP+
	028JqnX46gNCjCjVwLn0VAoXXKVnZO2UwfEEy4DOLQbLLmZYDy7F1LDdp6AHHj/MeQfEa6
	f9shY0qwbm5G0TAlQyAwU6G7+bUIdoXSZw5l4bE1azmhL4wFRyHCFpzGoD276Q==
From: Val Packett <val@packett.cool>
To: 
Cc: Val Packett <val@packett.cool>,
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
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Fabien Parent <parent.f@gmail.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 7/9] input: keyboard: mtk-pmic-keys: add MT6392 support
Date: Thu, 26 Dec 2024 01:58:07 -0300
Message-ID: <20241226050205.30241-8-val@packett.cool>
In-Reply-To: <20241226050205.30241-1-val@packett.cool>
References: <20241226050205.30241-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add support for the MT6392 PMIC to the keys driver.

Signed-off-by: Val Packett <val@packett.cool>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index 5ad6be9141603..94fa0f316edc6 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -12,6 +12,7 @@
 #include <linux/mfd/mt6331/registers.h>
 #include <linux/mfd/mt6357/registers.h>
 #include <linux/mfd/mt6358/registers.h>
+#include <linux/mfd/mt6392/registers.h>
 #include <linux/mfd/mt6397/core.h>
 #include <linux/mfd/mt6397/registers.h>
 #include <linux/module.h>
@@ -67,6 +68,17 @@ static const struct mtk_pmic_regs mt6397_regs = {
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
@@ -284,6 +296,9 @@ static const struct of_device_id of_mtk_pmic_keys_match_tbl[] = {
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
2.47.1



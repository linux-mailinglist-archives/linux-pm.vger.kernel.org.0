Return-Path: <linux-pm+bounces-38066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB3FC5E5EB
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 17:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id EF4EF2410D
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 16:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472CF33BBC7;
	Fri, 14 Nov 2025 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="X1hJA4li"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A783033B6D7;
	Fri, 14 Nov 2025 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763139294; cv=pass; b=HZoV9uXAP9/sA2OrrmZe4ngwMoRduOXzJl/7OpsICm5la+yPl8mUvYakfdpap0RAoY/MqH3Uab102o56zTLE40d08QHmrC/c5oVKpsGdvsMxkkXnuNB2h25RiF2anXTPv4TILk5qc4Wb5coQxiWN1KUi4DnzkM6fcmPkk1yaI0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763139294; c=relaxed/simple;
	bh=618gvFIbOWvfcBF6Z04rR7SChkLJAKC5ZC/JQtxOneA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aD5DpL25JeE33MwwYg0MBOujPQoHsnuuqYmp1H9oaHoM/aA8XGd1UvMWYdWBLzsPBvpXEKYlF2IsQ6hOOHpjU3/OBHUayOSfQmMbCcQjmZVSK1Is6WHLtwQHf1iGD9ajtSI3qMaAwF3PvHLLQ61dSH7FGRQwOU0ae0dSOS8a8QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=X1hJA4li; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763139280; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aWox+0/dpxSiwxOr/KBKbzSwWASbf366rjLPxqtdLHpiIzadQoqL5VZpgT5Sqab8DlCwYhus7B1k1zpkWpVDd7/AobTdoMYkubFcOvgZekFECT7ou38aEKJK8l+PV2Col/4Sl9cStzN0T2iIC5hvlfXOILbSwAto0kVKTQHC0SA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763139280; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1m9nLXhYlMrvlKNG2+wG+g956IXYnkkF+1lH0Nb/twY=; 
	b=muDXdH6zKIKIDg0z9LzCAQqPmp3V+NllIb/i2pxLflBH/HJnPIw79kw3oAo/TrhEtLbptpjTJrkZ+6Z/TmukX6/iGfFhXNZqE1GMaKRthrmp9rUwqVepwr1m62TAUL2M5IJ0iz3G+KU2G+1WNsFpWZ/h7RsRUwqhBwwSz9Nv/X8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763139280;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=1m9nLXhYlMrvlKNG2+wG+g956IXYnkkF+1lH0Nb/twY=;
	b=X1hJA4li0w6zqNmZBRWzA7uq2zthzTnVrXIOLDBRdFplzgr0aS29LW+EfS1Y3t60
	pu4JTgSIm+qmLDlYVgnivvKBBtkTcNsAhuqBykkJAwxyZfQX59zneTpr9gj09o4LdkN
	lD3vAE6ESToZVYbW+Y7H4/Ci11ngYIzxXSx8sYaI=
Received: by mx.zohomail.com with SMTPS id 1763139278832560.3899297951552;
	Fri, 14 Nov 2025 08:54:38 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 14 Nov 2025 17:54:03 +0100
Subject: [PATCH 09/13] soc: mediatek: mtk-dvfsrc: Get and Enable DVFSRC
 clock
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-mt8196-dvfsrc-v1-9-b956d4631468@collabora.com>
References: <20251114-mt8196-dvfsrc-v1-0-b956d4631468@collabora.com>
In-Reply-To: <20251114-mt8196-dvfsrc-v1-0-b956d4631468@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Henry Chen <henryc.chen@mediatek.com>, Georgi Djakov <djakov@kernel.org>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.3

The DVFSRC has a clock on all platforms.

Get and enable it in the probe function, so that Linux's common clock
framework knows we're a user of it.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/soc/mediatek/mtk-dvfsrc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-dvfsrc.c b/drivers/soc/mediatek/mtk-dvfsrc.c
index 3a83fd4baf54..a43d6f913914 100644
--- a/drivers/soc/mediatek/mtk-dvfsrc.c
+++ b/drivers/soc/mediatek/mtk-dvfsrc.c
@@ -7,6 +7,7 @@
 
 #include <linux/arm-smccc.h>
 #include <linux/bitfield.h>
+#include <linux/clk.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -83,6 +84,7 @@ struct dvfsrc_opp_desc {
 struct dvfsrc_soc_data;
 struct mtk_dvfsrc {
 	struct device *dev;
+	struct clk *clk;
 	struct platform_device *icc;
 	struct platform_device *regulator;
 	const struct dvfsrc_soc_data *dvd;
@@ -650,6 +652,11 @@ static int mtk_dvfsrc_probe(struct platform_device *pdev)
 	if (IS_ERR(dvfsrc->regs))
 		return PTR_ERR(dvfsrc->regs);
 
+	dvfsrc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(dvfsrc->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(dvfsrc->clk),
+				     "Couldn't get and enable DVFSRC clock\n");
+
 	arm_smccc_smc(MTK_SIP_DVFSRC_VCOREFS_CONTROL, MTK_SIP_DVFSRC_INIT,
 		      0, 0, 0, 0, 0, 0, &ares);
 	if (ares.a0)

-- 
2.51.2



Return-Path: <linux-pm+bounces-38448-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602A5C80201
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 12:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF603A89FE
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DAF2FCBF7;
	Mon, 24 Nov 2025 11:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="NE6wb5oH"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F852FC891;
	Mon, 24 Nov 2025 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982467; cv=pass; b=WQd0E57nk2VzGHQRSQwzDu9FthlAEwfIKU3WaReFYSB6yPjohq+DbxsxhwdjnvCT7Wca/7i/7+5XkdSCLORxN/NMDk3v27wUOMEjvF5iZgkzNTwAgTy2J1X/unU/X1QEhcOr419b5/rfDpjuWS6J14Lm/kbTcGxPKIONXfvN+rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982467; c=relaxed/simple;
	bh=BtODfoHUWJ2VpnwsgnInnskEvhVeok20tlmLapE9Oxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=joGxKFmedvLHldDepyuiyqX8OrKVZXkBqzz5g9Y+Q/6Mrd7kUZMW+nhvLXa7qmqEvKcsXXiY7E2khLWF+Wu2aTFGYutoRjdJToCaW7w+ZCyHwxOXcAATY5Ueg2S+zc/g+bysKSXOZiXF32KT2EGQ7QpJfVZsx0DQcf6cUjhyFlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=NE6wb5oH; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763982449; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NUytUdA+SGSrlE63zS/zfKXRiZ1BMSC4p5R5zgwMLh+p4kk192xRuD1LZiEfiETf599/mhCdWFwf56efIffQd0IzTnk3x+4l/wKJNC0YveAQt82Yr+lnv5pnbOza88rDpgQpNqyHtlgmTwJAqchcdAMGc+9IVS1dkr7gHNfvi7c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763982449; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/xhXPP3gRLRrtXGINvdfz74DYVPN12DyX86RwS57Epc=; 
	b=ZrYTzB4aiMCVcWODLe6FBUB0jF+HCIz2uW/tW/0O8v2elk1hGLCvmLUMI3xdPtblCVYO6BOOhOLu3X7Ir9cvhRVY4jGs3lzQoBG6JoW2S99SLgakutwUr+T1KZbazWnPdoS2I3rLXrUGlR0aR4KKVSTnJ0i3ZrSq6sfBSTPdOyE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763982449;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=/xhXPP3gRLRrtXGINvdfz74DYVPN12DyX86RwS57Epc=;
	b=NE6wb5oHc1Tdel5K1oA7ijdBR7yq8P2ILdqZFw2RHEqgBSBUsmD1sIqjsQr6YX67
	LhfH99ZTQTFMV+eLuX+PayzAyw2nMEyMIH5nGI7SJXF7qWAOzdnG5u/AaR9HjuBPVZo
	iXMHS9n6dIqCo2ME41ebNSS+zKhCEZmyX2nH3iT8=
Received: by mx.zohomail.com with SMTPS id 1763982447257830.5724130617974;
	Mon, 24 Nov 2025 03:07:27 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 24 Nov 2025 12:06:58 +0100
Subject: [PATCH v2 09/13] soc: mediatek: mtk-dvfsrc: Get and Enable DVFSRC
 clock
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-mt8196-dvfsrc-v2-9-d9c1334db9f3@collabora.com>
References: <20251124-mt8196-dvfsrc-v2-0-d9c1334db9f3@collabora.com>
In-Reply-To: <20251124-mt8196-dvfsrc-v2-0-d9c1334db9f3@collabora.com>
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

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
2.52.0



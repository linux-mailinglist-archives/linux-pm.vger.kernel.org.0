Return-Path: <linux-pm+bounces-38063-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E87EC5E9C6
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 18:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C9103A4704
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 16:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38BC337BAC;
	Fri, 14 Nov 2025 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="B0Vu3EsN"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA85D337111;
	Fri, 14 Nov 2025 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763139281; cv=pass; b=MiGmmf7nku0+YbZPkP6sSlNIEBSda8ekcrcpCff6OIU06dHWeeepC8yHsHZGnvYx/ODalJQ9ryvtnaf16HBLzA0Nm9PmYn8AnpnH0BRUI5X53nd6Bq0J2G3UzInFxmqWffzFoI42KfVXBM0Bfpm17K7eOZCxHSZLxnI/DoHSABw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763139281; c=relaxed/simple;
	bh=V2nx+E59MoRZ+z4sLtQuSMYqiFs4eRakMDQ80E3RF+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DhmrVYfdSRH8xxeB5ATrQRtGLHJ5S2Qn+Vc+W34maUIgSaAeaz4F6gB4hr4R1W51QbUjrIamwBuhbPrFD9vdT/tHCPEZTY9lphtK3Jg9dgEN6E/3k6a5mzwNBqwZQxeoJ5l+Wg/ecq84TBKGmmht6X/P5pIHCGuwHkJiuPyE9Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=B0Vu3EsN; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763139260; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ac2q3Q+dYjA6zavR7I4Q4nebD5BkUZ7iuSRl66TGZDmNN6Myvwjy/fZ/ZKaeduIInLAnhqCzi9an/pini76iJo403zO4sGkA7fsMmVG7P/rW5xluzXPIxGuaSOrpcNXo2bdTE4ZmiTeR/zpdUEpjGw/OyLKZEBIGJYqOGfUir/o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763139260; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hUMIb9y9wVXtiwc+9+yjUEpvI/XwAAeCzmUhTxPX28g=; 
	b=P15eVxZXSw5OYE4LaaJ5mrm1S2YhZgqykLNpFnBoWvr4hX9WndJr4P4uqV1h4WX08bDyi4XT+GF7whYO/gCgvovewoViM8cwwF0x8E2y8MB28oZFTdWQPIHKWVupj0OkWjj5K3sqyBKfLMyGMbmK+Q9McDfcbuB+B5V08CKEnk4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763139260;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=hUMIb9y9wVXtiwc+9+yjUEpvI/XwAAeCzmUhTxPX28g=;
	b=B0Vu3EsN1ToxHBjcmI5S0g4nvX/JC5SEwKcwGSr/wYgOkV2zUIZlv1Wcr5Ye0tT+
	WgUJ1g40W+xIin2ZehiIgB/Zym2u+MZqafq9TQxllAM/AHtZ3oh0sW6bEKiiY+aoMXz
	6LXJPjO/XtnphwY/YIGA1eAZXCxMshW+X2fGEmD8=
Received: by mx.zohomail.com with SMTPS id 1763139259572869.2446106413408;
	Fri, 14 Nov 2025 08:54:19 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 14 Nov 2025 17:53:58 +0100
Subject: [PATCH 04/13] soc: mediatek: mtk-dvfsrc: Change error check for
 DVFSRCv4 START cmd
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-mt8196-dvfsrc-v1-4-b956d4631468@collabora.com>
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

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

In preparation for adding support for DVFSRC Version 4, change the
error check for the MTK_SIP_DVFSRC_START command in the probe
function to error out only if BIT(0) is set: this is still valid
for the previous DVFSRC versions, as those always set this bit in
a fail reply anyway.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-dvfsrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-dvfsrc.c b/drivers/soc/mediatek/mtk-dvfsrc.c
index 41add5636b03..7708b07ab2d6 100644
--- a/drivers/soc/mediatek/mtk-dvfsrc.c
+++ b/drivers/soc/mediatek/mtk-dvfsrc.c
@@ -440,7 +440,7 @@ static int mtk_dvfsrc_probe(struct platform_device *pdev)
 	/* Everything is set up - make it run! */
 	arm_smccc_smc(MTK_SIP_DVFSRC_VCOREFS_CONTROL, MTK_SIP_DVFSRC_START,
 		      0, 0, 0, 0, 0, 0, &ares);
-	if (ares.a0)
+	if (ares.a0 & BIT(0))
 		return dev_err_probe(&pdev->dev, -EINVAL, "Cannot start DVFSRC: %lu\n", ares.a0);
 
 	return 0;

-- 
2.51.2



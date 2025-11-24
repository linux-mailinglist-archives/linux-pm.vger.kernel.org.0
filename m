Return-Path: <linux-pm+bounces-38446-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C7EC801EC
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 12:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5FC23AAE3F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B022FDC3E;
	Mon, 24 Nov 2025 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="KmZwvMFr"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B352FBE0F;
	Mon, 24 Nov 2025 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982457; cv=pass; b=E6odrqPHL91LIrA7VRN/XqH7p7g9TVJh9u/VZTcy/n45C4WTsrIvHhxaQF5A305qQpXelpeVi7g5HEhlY83sibnzUYFzH2tyOU5sY5aUfuvkxOjc+i17Xor7BZLBd+cGcf4Q4cTh1I72VZe1V7XBsvXtyHicLE6EnGRShkzXLFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982457; c=relaxed/simple;
	bh=bDefho51Ly/MOjRWfAzw7rqsqszclECUY7m0unTVEg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dx4SmydfyNBcHRjQb0uTb/cuHxWL3btKotKagaJv28asRMI3+fRmmRnTUhzIoQqmPWbadduU/DsPTu5Eon5m1UmeM5CxwcUoELpRJqhkSVAA45twqcHx4oQtpwn0Ydh90WwD72U31QFDY9kvnynM7YAENDZENxUdHFXC1UI88aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=KmZwvMFr; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763982433; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IXS8IHBlRkcxzbrqOTzjgOfUGwHgAeNekmQt1A56O8FmgN29sqvy+RBK5umlrJwt7srj03ctCnkYy6vjpLGhvMKHl25X620EkQzd0BCP9YXPQaSbKWIPTzWTJnzrchnBC1VeMPcv0vXJC22dLwVVmFiVfJwPTy8ceyYWIuMeVhs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763982433; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qSGx250uhdjdakZcPHoX8Nbq5J4cWyRmd4SLOgVrrcg=; 
	b=EjNhvEdyxDbs/2bwxjR2DwjWci/LOks7rzSYdsVfv/xKZrHfarjhKE4NQ6qJOWbgLkv4uMEw3WltDmWeytXs0zsaBiloWhbbij7AC91gCsfDMYkc3VqZ7jGm4F8ganM+iXLikrnbBV34/P2vgkbvK8isz5C9L3eamqdpnOqvogQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763982433;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=qSGx250uhdjdakZcPHoX8Nbq5J4cWyRmd4SLOgVrrcg=;
	b=KmZwvMFrlZHV0mUn6TEmW8GPNOzPiVgf1uruk15TGaZwaVIqiDuh6abQ1aihVGgF
	ibLFU2sEz51fQy1Yxn/JAwspmO5VUb42f2yUcTl5l7uQAN5tkeLx75vbp5ygLGphK3D
	MGC7rMq+gPdTd/mirTF7ZHZORoew461w9nxU1bsw=
Received: by mx.zohomail.com with SMTPS id 1763982430549222.18364403003534;
	Mon, 24 Nov 2025 03:07:10 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 24 Nov 2025 12:06:53 +0100
Subject: [PATCH v2 04/13] soc: mediatek: mtk-dvfsrc: Change error check for
 DVFSRCv4 START cmd
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-mt8196-dvfsrc-v2-4-d9c1334db9f3@collabora.com>
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

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

In preparation for adding support for DVFSRC Version 4, change the
error check for the MTK_SIP_DVFSRC_START command in the probe
function to error out only if BIT(0) is set: this is still valid
for the previous DVFSRC versions, as those always set this bit in
a fail reply anyway.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
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
2.52.0



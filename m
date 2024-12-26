Return-Path: <linux-pm+bounces-19745-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9879FC827
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 06:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C63197A0657
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 05:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5A4155759;
	Thu, 26 Dec 2024 05:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="nTTDPQRb"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171C71531D2
	for <linux-pm@vger.kernel.org>; Thu, 26 Dec 2024 05:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735189801; cv=none; b=siQ6+1DtEUKctgM+mbxmV3OFUjiDx3PmK9uCRGXg9VKhU83vaIb0li4PaX3KHR6NEiDTB5qq90GXRFQAXMMF0Ca+oMn+DMyvFbTcDD7n6+lpgEk6W+Odhyza0oT04NZhrpOSHO/Ey+EdwfL/3nwGDdrXyshHGihL03fUhMGtRho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735189801; c=relaxed/simple;
	bh=3wO9k50vCpXwoJN+dC6Ue7uZuUg12IDYSxz5yZF45D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lR+YChI1xzWrixlGQhARyynX4GyqIdwXcrTihlLW1885TOfwWwLu0M7K/rbOF76L6bn1Vnxp9lem+uKy/WFr5h/FkHjxRjY6b3FG/GWk2A/Rci8qOQOLa4rJ8jMi0WL6C989VkzOG2L4h2Q/qFITMHB1C1IUzYaqL3ikCgBCgq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=nTTDPQRb; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1735189796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0D5npsDI8iXbhIUUM/dj63aVNlFAoEQXooWigDRnPe0=;
	b=nTTDPQRbmBi6Huy14ecpoysSPY0QU5vsc3yBgLkMs7zTd9fhU/gp+OlhYuE3S1sV21tuYf
	db+UVEBrLbCW2Zb2N6YHhzRUdNDxag8NG6lrlkZ6jCxrR/gOotdLS8F2+MoDbeAdfK78UY
	gYgLh/mYxQyNrAdi+XfR4rWhBTKEAvAl4eaU02k5asVAasR1OnqqgXmj4HPekrnfbv8py8
	F2S3SYbwrBeRn+Fx0VqHiFjpa29vzDLTXBvTdIyRik6u2WQTCi9tnepRVWOh4bUSfwnoBG
	53roAP82tp5LtkqV0XjreU2JomJAxbjLv/Ecm/hbjVHK4eXRyoxPgo0RcIJxHg==
From: Val Packett <val@packett.cool>
To: 
Cc: Fabien Parent <parent.f@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
	Val Packett <val@packett.cool>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 3/9] dt-bindings: input: mtk-pmic-keys: add MT6392 binding definition
Date: Thu, 26 Dec 2024 01:58:03 -0300
Message-ID: <20241226050205.30241-4-val@packett.cool>
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

From: Fabien Parent <parent.f@gmail.com>

Add the binding documentation of the mtk-pmic-keys for the MT6392 PMICs.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
index 60f09caa0e4c7..5da4fbce33970 100644
--- a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
@@ -29,6 +29,7 @@ properties:
       - mediatek,mt6357-keys
       - mediatek,mt6358-keys
       - mediatek,mt6359-keys
+      - mediatek,mt6392-keys
       - mediatek,mt6397-keys
 
   power-off-time-sec: true
-- 
2.47.1



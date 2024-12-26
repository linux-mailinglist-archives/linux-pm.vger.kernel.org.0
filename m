Return-Path: <linux-pm+bounces-19744-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702069FC820
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 06:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBF516287F
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 05:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89BD15B111;
	Thu, 26 Dec 2024 05:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="tUPp2ZCg"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AD3156230
	for <linux-pm@vger.kernel.org>; Thu, 26 Dec 2024 05:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735189770; cv=none; b=epCe0YI1M/Kh9BTm5f3guFXUuWUh9+N2l6r3uKWn2vztyZ9/Hhj3pXXtIhW/JBb72dl1tdfdTFkFclreMGFjLPDIdgKd0XAuaDZMlPdMJJ9JYZ3uPoRdBaxTFKM/DcNiuiMJ4pKaCa7+seIlcKvZS960U6WHipoRW05r3BTox98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735189770; c=relaxed/simple;
	bh=X/7Q4M5tAsiOvJnpDsIh28xyfzzHR6adoNO6ZepxIfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hblv/vDraerzj7Ch8h51dhhV86xvRgV8rcprCsHoIuwrnaubUfQHwPCJm3OMzkLezTNc33AMGAn+LT8+HvL9MrK2nYlWHglzuDtSVTsL+mt+v4YY9hH0PpljK7tFixi1wVLGifI1Nudm37G1QgtfSPbjqI0qFgIjQqOX6KSYmd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=tUPp2ZCg; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1735189766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wEHn5u5CBSS63bXiRM0JWdDZPFIQiqFgCShleupUKQI=;
	b=tUPp2ZCg9ofEQXvHbGoT85kEwn21T20dnx+bwZ6mLn80nrZKY0To/866ayoBMx1+Mkv7N4
	1dFAWz6Vvi0rYySu8cqnWOd7glewOuCxcDnJ3rDlyvW1IcVHDv/s9irW7PN+i+7hFdY5sF
	+RpFcUEyY0Qg1dyghoQ/0qWwnSF7iMWCCKqpduN3gH8UmhnycykCCkRAJjrc3/QpUancI9
	z+kQerAwunDmWjeXWxW/Tcf6sjSjNUlHoN7N5kMN+tYvNFZtKUDYcQJl6uD7r9G5TM2dx6
	yo1/wLXUVDmfC2/b2Hc39xMfbQfhTTt1gXtzRat6tX2HCIg5LrmltBS19iYGoQ==
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
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Val Packett <val@packett.cool>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 2/9] dt-bindings: regulator: add support for MT6392
Date: Thu, 26 Dec 2024 01:58:02 -0300
Message-ID: <20241226050205.30241-3-val@packett.cool>
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

Add binding documentation of the regulator for MT6392 SoCs.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 73103922978f7..f047844782c4d 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -92,6 +92,7 @@ properties:
               - mediatek,mt6323-regulator
               - mediatek,mt6358-regulator
               - mediatek,mt6359-regulator
+              - mediatek,mt6392-regulator
               - mediatek,mt6397-regulator
           - items:
               - enum:
-- 
2.47.1



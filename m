Return-Path: <linux-pm+bounces-19743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EBB9FC816
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 06:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931261880504
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 05:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3F1150981;
	Thu, 26 Dec 2024 05:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="F+SNPbVh"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52EC14A4E1;
	Thu, 26 Dec 2024 05:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735189744; cv=none; b=Rxsgm+sTFFBuCyT4mAuUL6SZSt7YOgoRPNqX/6cy7n48Ix7m8jkWwptL/zsyqGSfQo4ba+MdEZRWSAgrF9aRf0yNXgShibJTWnEQv37zWMHrocy0JwwROTADPbbnwQYy3QjWc0sVIIDZ8F59noY/jEA84Yc9oN4FmY+jtS7N/uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735189744; c=relaxed/simple;
	bh=ZG3E/CjJTpTgTtdD12Q1NielMS0GqVLbTb6vQ26Mo0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUxOdspVrOq5K+rucWxg4Q8DjXKhVrEMyLUzXBE3Uzy0jbpRqXytPeUmDsMbSnFvByD+QGeatV8L/yuNd7RfIKiSgSKkML423xbsGMap5RrP4q6NHC/LMIKkvUPorY1BexRKo8ygPXQKHkeH6Ylxox5NXEquUFErvBSk6oHuWZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=F+SNPbVh; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1735189739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yZRP9EHYiDMQSE40KS4tBLSjVo3dw24UwSYUpDAW6ko=;
	b=F+SNPbVh4FdD9yMy1bAbihcAIbPtkt2JBR5WmXnwwuKaAOgpJCkHP5DeoQLyYfTCFWxtQU
	0pzScr+1qMK315KnWelMxeL2unZjvukBMFM0No3D4SItsfW4fxkimOGpGBqBsDg2rzdeTl
	k+VHNc0ImSufNn5nQhvveMQ3tlIej/rqIvSmxZdu+HZ1XTBbH9eI41Cc0+hoyZdru9ZaIE
	2e9gjOmiTbDaEyixvKhXX8b9YjTZIYB+gzXLLxNMaYqQp/Xjy6RBN3PxK7xmkTP1wv4aPo
	KUFWj7a0zRLuNSYWlb8cpoQ3zl701Gsk+AMEG9+jCDFgf2txg+Rxvk+km3EtjQ==
From: Val Packett <val@packett.cool>
To: 
Cc: Fabien Parent <parent.f@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
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
Subject: [PATCH 1/9] dt-bindings: mfd: mt6397: Add bindings for MT6392 PMIC
Date: Thu, 26 Dec 2024 01:58:01 -0300
Message-ID: <20241226050205.30241-2-val@packett.cool>
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

Add the currently supported bindings for the MT6392 PMIC.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 86451f151a6ae..73103922978f7 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -38,6 +38,7 @@ properties:
           - mediatek,mt6331 # "mediatek,mt6331" for PMIC MT6331 and MT6332.
           - mediatek,mt6358
           - mediatek,mt6359
+          - mediatek,mt6392
           - mediatek,mt6397
       - items:
           - enum:
@@ -66,6 +67,7 @@ properties:
               - mediatek,mt6323-rtc
               - mediatek,mt6331-rtc
               - mediatek,mt6358-rtc
+              - mediatek,mt6392-rtc
               - mediatek,mt6397-rtc
           - items:
               - enum:
-- 
2.47.1



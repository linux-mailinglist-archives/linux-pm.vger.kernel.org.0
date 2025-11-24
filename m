Return-Path: <linux-pm+bounces-38451-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767DCC8021C
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 12:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A7C3AC2E3
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65562FFFBF;
	Mon, 24 Nov 2025 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="BJtohHxv"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5362FFFA4;
	Mon, 24 Nov 2025 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982480; cv=pass; b=MON6SA8QVXikS9fzWcoc5KcrTPLwn5yCqKl7i5RxQog/2QUuaw7MeEg8g5r79EK5UYqrqCz0/lBQrpG2FgMT7Qz8x6yCMA6Y2wRw83ju0bETmfVXjOZgFA96wZyOCkea1+WablCY00cCZwVgChOhBHVYYp5znBuMQCNAoTDxfKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982480; c=relaxed/simple;
	bh=YvM7R8E45NSo7o8x096Qdk4d+R71z5b0gmTaWzltjrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hwvEFyqu3DZNvh49jY0Y0dvLi4JCGIA2aeGAPFM6eCRubTXwvDs7QNNGaSpJo/eHi5O8FhYWqQjenEXWqWxFSmTSJosQzyXy2HptlM9ji7fHQSdia7CDHzwtBRIbzfSSUQxuzF/eFyidFFV9ZsCl3BcAp7mmfkvYEbkJekuRX2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=BJtohHxv; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763982459; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ex3jGzV73lIUVhhi9LP/QgpWjmoa5ygJYj4xrlQrHBHS1eFv6ifCiokLOIi/jgLUBBkc9IcrG/hYOH/hGBJF0O78S88FQkaWbQ9pf5ImCF2s2FXfphHBPw4cfutnaeI7GoeUsgA6KB3+jgMgpOuLJjjet6DF6LmNaykNY5K6JrM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763982459; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qoo4mVM5kwudM7/8ap4xpMpg2C8udD4BnzAHqgC7CL8=; 
	b=Jfl9EzPGfi8WwdmKVnZzgqQtA1O96g7+H/+VoIH7/G22Yu4wvFszIY1kinnFoQnnb+XU6iPqs/qIyyBNJFkv0zgZ48FUIRqsA6AjQ3T67bN0TuMvwDVVbOyvykmYxDouh1PrJicsw5NXTjk/r3yRbr2z38nOyxdmLgpX6S16h0A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763982459;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=qoo4mVM5kwudM7/8ap4xpMpg2C8udD4BnzAHqgC7CL8=;
	b=BJtohHxvDVDXP2GbJtXjc50uSSPNEYr6MkjblxkDeFJi2rqoKFS2mcGlf1AjLDa+
	z7Id6HehKs/kHLvImNOYlhowRuF2+dzSfC2WSy4yXQEv7p70siafgbePQ4X1vRxvgLS
	5h9LolKdHFOwhdOtboV/XsWyFKvtMG5DBt6fG77c=
Received: by mx.zohomail.com with SMTPS id 1763982457081364.29471024039515;
	Mon, 24 Nov 2025 03:07:37 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 24 Nov 2025 12:07:01 +0100
Subject: [PATCH v2 12/13] interconnect: mediatek: Don't hijack parent
 device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-mt8196-dvfsrc-v2-12-d9c1334db9f3@collabora.com>
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

If the intention is that users of the interconnect declare their
relationship to the child icc_emi node of the dvfsrc controller, then
this code never worked. That's because it uses the parent dvfsrc device
as the device it passes to the interconnect core framework, which means
all the OF parsing is broken.

Use the actual device instead, and pass the dvfsrc parent into the
dvfsrc calls.

Fixes: b45293799f75 ("interconnect: mediatek: Add MediaTek MT8183/8195 EMI Interconnect driver")
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/interconnect/mediatek/icc-emi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/mediatek/icc-emi.c b/drivers/interconnect/mediatek/icc-emi.c
index 7da740b5fa8d..182aa2b0623a 100644
--- a/drivers/interconnect/mediatek/icc-emi.c
+++ b/drivers/interconnect/mediatek/icc-emi.c
@@ -40,7 +40,7 @@ static int mtk_emi_icc_set(struct icc_node *src, struct icc_node *dst)
 	if (unlikely(!src->provider))
 		return -EINVAL;
 
-	dev = src->provider->dev;
+	dev = src->provider->dev->parent;
 
 	switch (node->ep) {
 	case 0:
@@ -97,7 +97,7 @@ int mtk_emi_icc_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	provider->dev = pdev->dev.parent;
+	provider->dev = dev;
 	provider->set = mtk_emi_icc_set;
 	provider->aggregate = mtk_emi_icc_aggregate;
 	provider->xlate = of_icc_xlate_onecell;

-- 
2.52.0



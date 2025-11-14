Return-Path: <linux-pm+bounces-38058-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A59C5E73F
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 18:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 215FE4F5AF0
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 16:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C432C2353;
	Fri, 14 Nov 2025 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="HSls78np"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514252C2ACE;
	Fri, 14 Nov 2025 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763139267; cv=pass; b=Gft6hXzDgSastzQIOZE55QpENgGs/v/DCDG8VAauqaurLDBBY1+dCSd+lb7T0OWJzHwywwn+kT3iGkhz18cK6LVEKkGgeBGA60el8ODysYb5EH+HYUcmuky73o6Z5yzrjoSsp6CyF7d3TbfR+v3nqzZbKxKamU8lOMHQcE+RPvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763139267; c=relaxed/simple;
	bh=y+5N2pTW/HxKAQvAJArWI07n080C3dwGUClBuIfpW9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WNo7ckq86Tlb3i2TrP5ZVKB/7A93lPGmq42+M4pPJnbg61oV/TZ4O/LrKopJxpI6YlnxohUhNijlogSrG4/rZEcwVegF+iLks6k16RqqdrLbP701ToHzp0CeuQspaCgC+Lt7yGynjqir+xu6MZr8K5oj5OuEdmb7XVy5LQARWDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=HSls78np; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763139250; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NmvcRZSPfaGMRc8DNap//plM9dKMLWASis9qhJHwtUvm2LjEpeQ5LtkrppPML+5j8kG0cBfOoEYI10N47TZ9ZAXIEGy8tvX21QjiqTXL/L/P+T/YiER9sZWhoEXzSFtN7R8PqIk+GcHD0T+Tj3+Ita4KsETXbz/NzSWMrChJ7zs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763139250; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bCCaO//8Fi8M/CmV2wALRGjZAU2gsguJwp6rcmq26zU=; 
	b=nUCcSWxA+eO05iF0RerE7f407BFcpg4L5bVAzCnlSsjtqHcocXjvYYhsIfwqNA/ZLIcrd9IizU1x21FOLmCGdRw3n5B9ZRQa6iSeL7WmlS9Nl4QoQYV38TmrI1yoyd6pvqlNRWsKG+fhg3gfVBwW6I4ERkuL+0P6KSVTMwuqmZs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763139250;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=bCCaO//8Fi8M/CmV2wALRGjZAU2gsguJwp6rcmq26zU=;
	b=HSls78npMhKse8lMvEAolewI7LbrjtJPfW3skx7sWMPrtCNYtINXSwpWVLM6MPcR
	TIffzwsFnCwPrCRerVWREJ/6E4eU+MsVZYDiYGCIra8i2+qzniLjgTr25A2jUSvr+VN
	wb3cRK0kv201Dw0cCKj4QSFjOA4vMTXuwy7FnJKM=
Received: by mx.zohomail.com with SMTPS id 1763139247761662.8223746100324;
	Fri, 14 Nov 2025 08:54:07 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 14 Nov 2025 17:53:55 +0100
Subject: [PATCH 01/13] dt-bindings: soc: mediatek: dvfsrc: Add support for
 MT8196
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-mt8196-dvfsrc-v1-1-b956d4631468@collabora.com>
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

Add a compatible for the MediaTek MT8196 Chromebook SoC's
DVFSRC hardware, introducing capability to communicate with it.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml
index 4c96d4917967..5673d242afcb 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml
@@ -26,6 +26,7 @@ properties:
           - mediatek,mt6893-dvfsrc
           - mediatek,mt8183-dvfsrc
           - mediatek,mt8195-dvfsrc
+          - mediatek,mt8196-dvfsrc
       - items:
           - const: mediatek,mt8192-dvfsrc
           - const: mediatek,mt8195-dvfsrc

-- 
2.51.2



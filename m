Return-Path: <linux-pm+bounces-38442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727BBC801AC
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 12:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C963A8840
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBD92FB99A;
	Mon, 24 Nov 2025 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="GZfYb0dS"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E582F9DA7;
	Mon, 24 Nov 2025 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982445; cv=pass; b=hOib8Lkog7dCQGbCt9/lCQLscOFZoVG73YMilHuUGzH+QLNn6+JoYQbKJapv+RwrvCWz6K7Di20tUDcFGjOdmD0h4RfTd7pbXoBWwDsg/d86pKJ5U7TJ6gG5ZXXY67+dltGuWZtraR0X0i9vjpvR0ZOgSjB8n5qYgWfWPIHfmy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982445; c=relaxed/simple;
	bh=9sBWUAD9Rp7utymPqRbVk0RbV6Y/g/789ihlXW4tctY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lGzMHofeKeEHxOVV92RvOxle0RLMf3uMC3WnUFsKKg2xLQMYJjimWZHcIP43IkwE+/+kHAsOGMNDAvF9AlgDFEyNlhzpX4M1gocf+AH5+fUtUe7qkDjKSeBrCxDXVsVScGFax8i8Ar6bz9EgrelHhJNrs/xtjshpwf7B5wknlKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=GZfYb0dS; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763982423; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=i7rP5ZjLeSO6nkbgxYOUQhkXldO7qcIj8jfu4BaZygcBW2lyHvVzEGO1AAeXRVLnSzNBxjwYNDPSxi/r1Z3IadFR4HTLYMNsYMAqjXO98e5LRlrC7SCcLah/u22ret6lcPIPBLCi1+pm4PweQt8Lt2DdzHQ97GusNKpKp1LbDlg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763982423; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XRJ33nglbvtBwNNO/vd3aaiLejhNH8NgBEXyiE+AIfw=; 
	b=P2JZpc9IwDkX2SfKrG5C25051/c7wzpTRHzAYGPSaSThNN1CWUM5fssxaD5pRvVVeC0sM9vsJRL91DuMDRDnfaY6x2Pcn8yE6fW/ZQag6Rif3mas9QrUBPrQ/XlNG0z91sM6Kp2BliySKv6DAD2K+pZGDQiSnbq+auOB5vnPFXI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763982422;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=XRJ33nglbvtBwNNO/vd3aaiLejhNH8NgBEXyiE+AIfw=;
	b=GZfYb0dSk6gySdxdr2gGHFe+onQijhcbzKet3XpTZafQKzK3LN264xLd5NOWCcI/
	9YmcWw3RMOhhnllS3DKizVJ1FueRqwiuYAbD2yuiebLgScNflG3986pLzSkMSbnTZp6
	B0iCw3Nlpp4NhlTcaDa6cTKJBGk46qnT3pc3JLTU=
Received: by mx.zohomail.com with SMTPS id 1763982420631856.0946779508707;
	Mon, 24 Nov 2025 03:07:00 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 24 Nov 2025 12:06:50 +0100
Subject: [PATCH v2 01/13] dt-bindings: soc: mediatek: dvfsrc: Add support
 for MT8196
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-mt8196-dvfsrc-v2-1-d9c1334db9f3@collabora.com>
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

Add a compatible for the MediaTek MT8196 Chromebook SoC's
DVFSRC hardware, introducing capability to communicate with it.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
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
2.52.0



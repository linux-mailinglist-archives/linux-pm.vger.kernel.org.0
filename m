Return-Path: <linux-pm+bounces-22092-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86191A3644B
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 18:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566A1189519D
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 17:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90985267F5F;
	Fri, 14 Feb 2025 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jKmhFCT4"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3262686B6;
	Fri, 14 Feb 2025 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553568; cv=none; b=lehUp1GHu8MjgQoSlrt3Npe1OXx/EVd3WYJFng5Fwr1a+dUUhNF8oqOxVGQyKuvtEqMJ3pqHkdHP5hOaiXMlxMUtxVGdS+kbv8G3ihTsJHmgvJ7622Gx8FTRo7Wr+IOPdzgdum4OHF95/210ngFNDJUmRV5vyO37+F1dWbTBTzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553568; c=relaxed/simple;
	bh=EjrwtqxQ5bYCEJ01b8/loccYAmWqyhZVlY3k8ihmFqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gps+kuMmmjyUbWSGC5NRtJEhVM8SiUE8g8Kndixbp4fQvIeLOL4jkIlDErtEHhsiRDzpXimNJrd/WG+Bak27VmEx4dQfaRoihHAg9/PevqWLBQV2Yb8DOONch52KRldNwmeqWiPfa6T6EZXaWGyJrjbP2JIEselzGAI4gcKEsBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jKmhFCT4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739553564;
	bh=EjrwtqxQ5bYCEJ01b8/loccYAmWqyhZVlY3k8ihmFqI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jKmhFCT46G4ZE7VKoaQa1t7STDOnJBGHbZz5o2FD5c26nn3bYRQTHsxFyI842N1cS
	 3U2IAhk+gjlqqF3bK4f2Bm2izUkzaB6yb9XecmSNgfC7kBnVK8LSdivk5DF7z+wtxv
	 iaqkAej46RbvRahRMOT4SEgv1iqQVm/4FuEjH1bKEcU5Eo0LWM6VKgQjeB+fZV2A11
	 RINMMuvTSvk6qAomCfWRS38Cjeus1m9t7Hpfn50h+WNc0C3UlJcNdN2AzAfla683sF
	 SWVxlbZmH+xNaS9qXEvJisd6DlPy4Tp3o/AozJgDUgDVMGWvMIBJvoeDl4Xa4lItEu
	 8dokj70spGieQ==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1003])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 63F0E17E1507;
	Fri, 14 Feb 2025 18:19:20 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 14 Feb 2025 14:18:33 -0300
Subject: [PATCH 02/13] dt-bindings: mfd: mediatek: mt6397: Add accdet
 subnode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250214-mt6359-accdet-dts-v1-2-677a151b9b4c@collabora.com>
References: <20250214-mt6359-accdet-dts-v1-0-677a151b9b4c@collabora.com>
In-Reply-To: <20250214-mt6359-accdet-dts-v1-0-677a151b9b4c@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Describe the accdet as a possible subnode of the MT6359 PMIC.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 6a89b479d10fad3c8b61cab5a3af1453baca4d1a..1a8c5748a28da6ad8aa091f8c0a74bc1dc709644 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -224,6 +224,13 @@ properties:
     description:
       Pin controller
 
+  accdet:
+    type: object
+    $ref: /schemas/sound/mediatek,mt6359-accdet.yaml
+    unevaluatedProperties: false
+    description:
+      Accessory Detection
+
 required:
   - compatible
   - regulators

-- 
2.48.1



Return-Path: <linux-pm+bounces-27738-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBA9AC6B0D
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 15:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2DF617DC7A
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 13:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8E02882A7;
	Wed, 28 May 2025 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="ZSdRO8sm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3E686323;
	Wed, 28 May 2025 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748440398; cv=none; b=GSZYXw6/4dQGWcjzSfPS71WyL3nFtpMv05+fIsIj1Uk9PzD5odgoyZsjHFut6cul0gV8s35SYliDpew98jF0vgCy3K8A4fdcBh7mZqdYqnoJdrgpTbXlQGUt5FEyxnfeZAd8s7hrPQYSdf2q/eujq6mivVqzRPeGNeQyzAPYrHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748440398; c=relaxed/simple;
	bh=KIQK8+ItF9LQsxxYe8mbJmOP1jp7O83BOKoxqnMSxNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SK2OPoyboUQG78Oh1gmvC6Scjf5f5MOLCuWGptnJW5ICg2swa/m+YOD3CmWU0IAplZsJ85mgCH4KjSu4dogn7buZQQBo9omVdGc0gbOCtlC3MRxdDjr0+fPgNc92vqBU8+cPZjeG6L26cMediGZzrfNA9qnfwBXBlv+YQ8RDGkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=ZSdRO8sm; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout3.routing.net (Postfix) with ESMTP id 073AD604DC;
	Wed, 28 May 2025 13:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1748440387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/IYn+Ak3aJNTaLzk0CMzwKGukq1D6rOsByjE7CfES9I=;
	b=ZSdRO8smi2hWk/PzPnGVQxbayF0NO5QBIO9DbjkNur9j5VDSieATcAPjRC3DQ+wceS9DaQ
	rv4V45NILSzZeZUyvVZnFX/AymgbAuYd3mJK90Ht7hpcE9XfeK6MUnHEsLGxnte/hLYlHD
	zihODtfXtsWxaipmiIzQd/5pq60qyT8=
Received: from frank-u24.. (fttx-pool-194.15.80.234.bambit.de [194.15.80.234])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id BE1B21226F1;
	Wed, 28 May 2025 13:53:06 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jia-Wei Chang <jia-wei.chang@mediatek.com>,
	Johnson Wang <johnson.wang@mediatek.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [RFC v1] dt-bindings: interconnect: add mt7988-cci compatible
Date: Wed, 28 May 2025 15:52:49 +0200
Message-ID: <20250528135251.6492-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Add compatible for Mediatek MT7988 SoC with mediatek,mt8183-cci fallback
which is taken by driver.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 .../bindings/interconnect/mediatek,cci.yaml          | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
index 58611ba2a0f4..2c6785c588e9 100644
--- a/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
+++ b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
@@ -17,9 +17,15 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - mediatek,mt8183-cci
-      - mediatek,mt8186-cci
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt8183-cci
+              - mediatek,mt8186-cci
+      - items:
+          - enum:
+              - mediatek,mt7988-cci
+          - const: mediatek,mt8183-cci
 
   clocks:
     items:
-- 
2.43.0



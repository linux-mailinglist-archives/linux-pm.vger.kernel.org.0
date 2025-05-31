Return-Path: <linux-pm+bounces-27901-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7385AC9AAE
	for <lists+linux-pm@lfdr.de>; Sat, 31 May 2025 13:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45DD217B568
	for <lists+linux-pm@lfdr.de>; Sat, 31 May 2025 11:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BCB239562;
	Sat, 31 May 2025 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="Sqc5sypC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADF118E20;
	Sat, 31 May 2025 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748691140; cv=none; b=mcW6qxFMF0+0IJOPX+CmUbA7yHXDsco3VxKusvw1U/QT/okBSidkzaUb89m0/qafDv8jkFHFeL1nG9RPSOyOL+sGB+watw2JBCz0E0juQk08XEkLaZ5Eq4+7eE6suDkKwXMhyyp2EMatsBZOSyb6MeCzHq0LdU35wfc3tBfmqiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748691140; c=relaxed/simple;
	bh=A2DHo1HywB/qwxABiJK0abopHwRYGfy7HmZJoH0S/ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n9En52mGvRYJ8iHyije9sDx+v2VRK6Qe5qr6Fkw0c/9jJ42WCF3cVzADpkWBbZ2NHqTYUejJ5AVDHFNJaw3UoD3mzvf+uXNub70f/t1DuZGLxPQPz3l1wM3Jm1lgWc9Sllvnm0YVb3gaFKSDZjaRhC8JLgZcbRVQnzqVUl8Bnxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=Sqc5sypC; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout1.routing.net (Postfix) with ESMTP id 076673FD38;
	Sat, 31 May 2025 11:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1748690673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fWlDJZFGibouXI9Xxl4L3ttSojMBpE6uWpsKddJDyoY=;
	b=Sqc5sypCBpxJrJDNGjSFApEEtY22xuSJ5xLurDITmfc/4AYyfZl/euSGGlmGJoB9ow6hh9
	mb6pe6aNOMCXRZzFKZEW0VaIdC2tcbIFwPdm9phfyBp6t8bzEI0Sdc5mzlXneLd88t1YRm
	KWtAC5fcXUNU0f7qKQgN5z6X1xx4gXU=
Received: from frank-u24.. (fttx-pool-217.61.150.8.bambit.de [217.61.150.8])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id BB9171226A5;
	Sat, 31 May 2025 11:24:32 +0000 (UTC)
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
Subject: [PATCH v2] dt-bindings: interconnect: add mt7988-cci compatible
Date: Sat, 31 May 2025 13:24:23 +0200
Message-ID: <20250531112425.10525-1-linux@fw-web.de>
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
v2:
- no RFC
- drop "items" as sugested by conor
---
 .../bindings/interconnect/mediatek,cci.yaml           | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
index 58611ba2a0f4..4d72525f407e 100644
--- a/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
+++ b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
@@ -17,9 +17,14 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - mediatek,mt8183-cci
-      - mediatek,mt8186-cci
+    oneOf:
+      - enum:
+          - mediatek,mt8183-cci
+          - mediatek,mt8186-cci
+      - items:
+          - enum:
+              - mediatek,mt7988-cci
+          - const: mediatek,mt8183-cci
 
   clocks:
     items:
-- 
2.43.0



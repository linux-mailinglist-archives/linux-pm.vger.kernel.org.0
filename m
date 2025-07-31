Return-Path: <linux-pm+bounces-31692-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAD6B1725A
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 15:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1901896C3D
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 13:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C102D0C76;
	Thu, 31 Jul 2025 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CQT61DjK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747F72C324D
	for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969823; cv=none; b=dIRmyzahw8+UJaymr/qpOm/n7JwoOKOzNxYoSdBvIF8e0T/eWGcZkIrjSZHvAOVi2ttlH76VPWcvxfL6LmLV22XHKUawieyWIWHbEAbM1ym6SsShfc6E6/f8wIzL6HRPA9y2aZhLL3betuzHTavrn2UpcvkE6ZHoHUPzDjWAhLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969823; c=relaxed/simple;
	bh=nt9WXl70jNXZ92RmyXR9xdR0VxISjP6PVLPZGJzG8+o=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=L/Vkc0LuNUjpZ2KY7+YFPN8vMcdKEprQBiiodIgGrXe0a8SyhMOx85toO6YCPi8c849mMJvDk+scb5dbz3Tc1zB8xxxGK6lNxHkFOiDn9ti1rewjaPZJXekZvIPXQU2VoWimQTJeGRZ7hbsY3lwCZR/9agskqUa/YDEQksPD8qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CQT61DjK; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250731135019euoutp0179ed292f68191d5511f2fc9823e516f9~XWkIXvKKK0212602126euoutp01F
	for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 13:50:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250731135019euoutp0179ed292f68191d5511f2fc9823e516f9~XWkIXvKKK0212602126euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753969819;
	bh=GqjP+sqWnHbA9FEjGQX5W1M8XprOwuwRbOKks19Q5zo=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=CQT61DjKDH9WRSh8myB97dE1/g8DAVsU9D9+ai5yjHRtsAdr/rb+D+ifmps7fwzuy
	 h2Sms18vutJSLZU4zTZaibzZonCKchHN9fa647kzAaPoR4DJhLhXBbXEib6jvhX5k9
	 f5YnfLF96qpbX3Fx9OiHw1bE1IDe0ikXMrCzT6DE=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250731135019eucas1p1239902cf5a5a8fa40ea35722e6feb965~XWkH4ziN20233102331eucas1p1O;
	Thu, 31 Jul 2025 13:50:19 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250731135018eusmtip23c074c65c850d0ecb3aa1102bd2a0903~XWkG7Qs0A2644626446eusmtip2L;
	Thu, 31 Jul 2025 13:50:18 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Thu, 31 Jul 2025 15:50:12 +0200
Subject: [PATCH v9 2/5] dt-bindings: gpu: img,powervr-rogue: Define power
 domains per variant
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-apr_14_for_sending-v9-2-c242dc1ffc14@samsung.com>
In-Reply-To: <20250731-apr_14_for_sending-v9-0-c242dc1ffc14@samsung.com>
To: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,  Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
	<conor+dt@kernel.org>,  Michal Wilczynski <m.wilczynski@samsung.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson
	<ulf.hansson@linaro.org>,  Marek Szyprowski <m.szyprowski@samsung.com>, 
	Drew Fustini <fustini@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250731135019eucas1p1239902cf5a5a8fa40ea35722e6feb965
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250731135019eucas1p1239902cf5a5a8fa40ea35722e6feb965
X-EPHeader: CA
X-CMS-RootMailID: 20250731135019eucas1p1239902cf5a5a8fa40ea35722e6feb965
References: <20250731-apr_14_for_sending-v9-0-c242dc1ffc14@samsung.com>
	<CGME20250731135019eucas1p1239902cf5a5a8fa40ea35722e6feb965@eucas1p1.samsung.com>

Rework the PowerVR Rogue GPU binding to use an explicit, per variant
style for defining power domain properties.

The generic `if` block for `img,img-rogue`, is removed. It is replaced
with self-contained `if/then` blocks for each existing GPU variant. Each
block now explicitly defines power domain properties and requirements
for that specific variant, making the rules easier to read and
maintain.

This addresses feedback from the maintainer to explicitly list items
for each variant [1].

Link: https://lore.kernel.org/all/4d79c8dd-c5fb-442c-ac65-37e7176b0cdd@linaro.org/ [1]

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 36 ++++++++++------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index 4450e2e73b3ccf74d29f0e31e2e6687d7cbe5d65..24ce46ba0b7015fca799f045ee2ccdd258088068 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
@@ -57,10 +57,8 @@ properties:
     maxItems: 2
 
   power-domain-names:
-    items:
-      - const: a
-      - const: b
     minItems: 1
+    maxItems: 2
 
   dma-coherent: true
 
@@ -77,18 +75,6 @@ required:
 additionalProperties: false
 
 allOf:
-  # Constraints added alongside the new compatible strings that would otherwise
-  # create an ABI break.
-  - if:
-      properties:
-        compatible:
-          contains:
-            const: img,img-rogue
-    then:
-      required:
-        - power-domains
-        - power-domain-names
-
   - if:
       properties:
         compatible:
@@ -97,9 +83,14 @@ allOf:
     then:
       properties:
         power-domains:
-          maxItems: 1
+          items:
+            - description: Power domain A
         power-domain-names:
-          maxItems: 1
+          items:
+            - const: a
+      required:
+        - power-domains
+        - power-domain-names
 
   - if:
       properties:
@@ -109,9 +100,16 @@ allOf:
     then:
       properties:
         power-domains:
-          minItems: 2
+          items:
+            - description: Power domain A
+            - description: Power domain B
         power-domain-names:
-          minItems: 2
+          items:
+            - const: a
+            - const: b
+      required:
+        - power-domains
+        - power-domain-names
 
   - if:
       properties:

-- 
2.34.1



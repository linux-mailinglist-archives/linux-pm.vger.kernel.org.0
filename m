Return-Path: <linux-pm+bounces-33761-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE50B42A29
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 21:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 864F04843F5
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 19:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775EF368095;
	Wed,  3 Sep 2025 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGVvQtKS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4872529D0E;
	Wed,  3 Sep 2025 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929082; cv=none; b=ZDEE9ygRJEMzhQo71rCvl7W4zi9706GzOWTK8hGVLcZT634lbUZZmDiLSi2RUIn2WjFMqiyhPwzGLskw+P+c6S2ScKNkAcX52HsjqKv2Mf6AQd5qE/sNyBTM2V7kxFyHA0/WYZdI9Pkuw/+zlrRDQ+ksxScot/s5mNzFjfW4B2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929082; c=relaxed/simple;
	bh=ZrwUlWy03isuqvxOKByHbLLf2ZTO8JbgUT7l+eh/EMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YVWfrUa2ywCq18glUHWQj1mEd1hacBIwFUubDX8yAieTHmEpF2RQpQDkL2KH3m3KmwQtgJr7odYzGl0nLuefvPNmzarL6NzSes2rIE7zhF1Cd6ratVruysYOJdNuYXWYvShTP9KaSGurr0I9icIMIlsGjOJxbsUtk3yO+ES0LtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGVvQtKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EF7DC4CEF8;
	Wed,  3 Sep 2025 19:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756929082;
	bh=ZrwUlWy03isuqvxOKByHbLLf2ZTO8JbgUT7l+eh/EMs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eGVvQtKSS9kq+xKK46dWUv4K2mbKg38OYZ7PP/hYsQi3O2XwZNhVOa9PMMpYI3yvc
	 2Rz2vo7BJUQNRZV50Kbts+rg7NhlOMZLATWi0ncMavOO4ScWj14AgMkRyFO3qrhtLv
	 u/srz+EUpZmxT+RXGkdEjrqDucLf6enr56hd2yXap00UsPueUGVN+qpDok2cSJNjSa
	 SJNLJ9IBsrydUOzfSt3Nui6w99BOvjgJUPGHkKt9VInr71djPve7/tW9wJR2n+/2bI
	 it3M6JRG4QAzbOvHws5AcPCsZbeS4cQUr5nsmbzQVALUuQv4i2A6DXk91bd3K4NlYF
	 jYt/511dAZwTg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016C6CA1012;
	Wed,  3 Sep 2025 19:51:22 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Wed, 03 Sep 2025 14:50:09 -0500
Subject: [PATCH v2 3/8] dt-bindings: memory: tegra210: emc: Document OPP
 table and interconnect
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-t210-actmon-v2-3-e0d534d4f8ea@gmail.com>
References: <20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com>
In-Reply-To: <20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Osipenko <digetx@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756929080; l=1636;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=K2FiUX5RaQ8JIyiwJYROz1L0fIFkHw1QV6kZZgZpZpE=;
 b=a3XwoxVKj3KIyN1sfx6WAt8dO8deBXsuTH5RUBeN0rOiebE0O1Zz2wuV/4gKo49fXFAUf5JWN
 2x/8w2pD+N/CQYstWrDslVvNpu4CAJJWftTSeahU49I0yG4VKGcG2nK
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

These are needed for dynamic frequency scaling of the EMC controller.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra210-emc.yaml    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-emc.yaml
index bc8477e7ab193b7880bb681037985f3fccebf02f..6cc1c7fc7a328bd18c7c0beb535c1ff918bcdb2a 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-emc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-emc.yaml
@@ -33,6 +33,9 @@ properties:
     items:
       - description: EMC general interrupt
 
+  "#interconnect-cells":
+    const: 0
+
   memory-region:
     maxItems: 1
     description:
@@ -44,12 +47,19 @@ properties:
     description:
       phandle of the memory controller node
 
+  operating-points-v2:
+    description:
+      Should contain freqs and voltages and opp-supported-hw property, which
+      is a bitfield indicating SoC speedo ID mask.
+
 required:
   - compatible
   - reg
   - clocks
   - clock-names
+  - "#interconnect-cells"
   - nvidia,memory-controller
+  - operating-points-v2
 
 additionalProperties: false
 
@@ -79,4 +89,7 @@ examples:
         interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
         memory-region = <&emc_table>;
         nvidia,memory-controller = <&mc>;
+        operating-points-v2 = <&dvfs_opp_table>;
+
+        #interconnect-cells = <0>;
     };

-- 
2.50.1




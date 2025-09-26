Return-Path: <linux-pm+bounces-35483-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E928BA4A80
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 18:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3444C2509
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 16:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEB32F8BF1;
	Fri, 26 Sep 2025 16:34:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C63025FA13;
	Fri, 26 Sep 2025 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904476; cv=none; b=sgqpZJzW3reyXZhvBL0zMvYAP/gwOCkej3ffYIvLZ5GEZPNy1rCdzjbskH4nj/Js+afyXGKddBbsLd9TIShMc1B62GgwbodgZqT/S1+kbXye/bmHJEkadEbAxrYKSHSLl/ttOLvEW/Q1qC8eWhKLq18Yn5qmGoTAnOkKjI4C4rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904476; c=relaxed/simple;
	bh=oXkc1mfL4g8qM9nxD4BWhq+wPzuIHLgEwoVPEI/0SdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=laLACBB9fOCMcJocd6NepHeItYJYIDkNjMKDZDv2v+Cn2QFV35tp4I3QC//79E5Xq9QwIkKlDYUzb7Jd3lFeeqhyj47WA47wJ72fI7nRwqc7gCr6q8VyuBcErkIOJv6mboM8avDk80xi6JvVTRYES2n3a11QC2UfWJCi2V9U5Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id D88CA1C2506;
	Fri, 26 Sep 2025 18:27:06 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdf8:0:ec51:b786:a581:3dd1])
	by srv01.abscue.de (Postfix) with ESMTPSA id 3544E1C24F2;
	Fri, 26 Sep 2025 18:27:06 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Fri, 26 Sep 2025 18:23:23 +0200
Subject: [PATCH 1/5] dt-bindings: power: reset: Add SC27xx series PMIC
 poweroff
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250926-sc2730-reboot-v1-1-62ebfd3d31bb@abscue.de>
References: <20250926-sc2730-reboot-v1-0-62ebfd3d31bb@abscue.de>
In-Reply-To: <20250926-sc2730-reboot-v1-0-62ebfd3d31bb@abscue.de>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.2

Add power off bindings for the Unisoc SC27xx series PMICs, such as
SC2731 and SC2730.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 .../bindings/power/reset/sprd,sc2731-poweroff.yaml | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/sprd,sc2731-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/sprd,sc2731-poweroff.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..2db8bee47e17863b9a0d7af4945d3c32e67122ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/sprd,sc2731-poweroff.yaml
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/sprd,sc2731-poweroff.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc SC27xx series PMIC power off
+
+maintainers:
+  - Otto Pflüger <otto.pflueger@abscue.de>
+
+properties:
+  compatible:
+    enum:
+      - sprd,sc2730-poweroff
+      - sprd,sc2731-poweroff
+
+required:
+  - compatible
+
+additionalProperties: false
+...

-- 
2.50.0



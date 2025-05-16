Return-Path: <linux-pm+bounces-27238-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C4CABA31F
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 20:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88D6506F38
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 18:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A4B278E6B;
	Fri, 16 May 2025 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="rJ0hJckl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E30221FC9;
	Fri, 16 May 2025 18:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421268; cv=none; b=HaiAWWwuFE9hK0scqqwR/3YnJg56mg1/yCzooVD/OXKPM6ck/b8XR4gHfjS6uAkoRKUwVvTjHu2yUR6pqNqof5V1XKMd1XGOunZCkNGJlWj67vt8MB5KMmG0MQTh9J5ZF09uzO2r7jXxbA/CjQrTtYwQYe1AlhODNLvvYGUv8CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421268; c=relaxed/simple;
	bh=AxPJvm0FQ0jefqPO0WREeRAuJuPS67Jv84UZGd6Rk5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUCCXE/tZdSLuXDb93SZIKpK62IYKcMjE6ZbHk4X/f411oIB/HMqlH/35gtWpQiIC1hmI7/s1eem3a619eXpidc6NyGtHe1rnF9o3ETO6x7kawkt9V26dzvk4mXWGM2/Nx/EI/Xu/TL3QTg4E4pcgBzncv9LagnLCTiv826HdEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=rJ0hJckl; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 954ED9C8DB5;
	Fri, 16 May 2025 14:47:44 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id bRob_rRLX19x; Fri, 16 May 2025 14:47:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 131A49C8DBE;
	Fri, 16 May 2025 14:47:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 131A49C8DBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1747421264; bh=u+SI7YO3huugnHnGaiAAHUUQSVwwcqVrH+3aKJw6igA=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=rJ0hJcklXEaHKw/3g7ftTLPZgkxSzlAXJ874cgYdznVzB7UwRKgZgfCvw0JfFVTF2
	 14mFRfPwbD1Xyq4tdxDRw7H2M99Hs/FiOHWsVfwSqruTQt8efdtlEs6Hip4UsVT3j2
	 nTafqYS8/TW9SA+3S90zKf598aY/5DBQ+MI7h1BykT4Kv1VlloFujBvQbBmE2A0sqm
	 Vk3yplJFbTxuzfwS10zd/837mY+QKruY0AVBySOWASLubtBXRZnfiNM0NrhhZz6BHB
	 0NY9T+yAMwjJB4w+62OP8vQ2bpqDBZSFO5qHGQ+xkL1kMXjuoS7I5L/dPmwMc0yLZe
	 bh9n6nZuczaHg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id ZxFcXrFd6owZ; Fri, 16 May 2025 14:47:43 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id CED529C8DB5;
	Fri, 16 May 2025 14:47:43 -0400 (EDT)
Date: Fri, 16 May 2025 14:47:42 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Robin Gong <yibin.gong@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-imx@nxp.com, linux-input@vger.kernel.org,
	Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>,
	Robin Gong <b38343@freescale.com>,
	Enric Balletbo Serra <eballetbo@gmail.com>
Subject: [PATCH v2 1/9] dt-bindings: power: supply: add pf1550
Message-ID: <21b1bc2ba4d266b0d69e447e60927d5985c8ae74.1747409892.git.samuel.kayode@savoirfairelinux.com>
References: <cover.1747409892.git.samuel.kayode@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747409892.git.samuel.kayode@savoirfairelinux.com>

Add the DT binding document for the battery charger module of pf1550.

Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
 .../bindings/power/supply/pf1550_charger.yaml | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/pf1550_charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/pf1550_charger.yaml b/Documentation/devicetree/bindings/power/supply/pf1550_charger.yaml
new file mode 100644
index 000000000000..10fc0b35917c
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/pf1550_charger.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/pf1550_charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Battery charger driver for PF1550 PMIC from NXP.
+
+maintainers:
+  - Samuel Kayode <samuel.kayode@savoirfairelinux.com>
+
+description: |
+  This module is part of the PF1550 MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/pf1550.yaml.
+
+  The charger is represented as a sub-node of the PMIC node on the device tree.
+
+properties:
+  compatible:
+    const: fsl,pf1550-charger
+
+  fsl,constant-microvolt:
+    description:
+      Constant charge voltage (in microvolts).
+    minimum: 3500000
+    maximum: 4400000
+
+  fsl,min-system-microvolt:
+    description:
+      Minimum charge voltage (in microvolts).
+    enum: [ 3500000, 3700000, 4300000 ]
+
+  fsl,thermal-regulation:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Temperature (in degrees Celsius) threshold past which the charging
+      current is reduced.
+    enum: [ 60, 75, 90, 105 ]
+
+required:
+  - compatible
+additionalProperties: false
+
+...
-- 
2.49.0



Return-Path: <linux-pm+bounces-27240-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C88EABA332
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 20:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF84716DC9B
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 18:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3323F278E6B;
	Fri, 16 May 2025 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="BLyzrMt1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB1D2E628;
	Fri, 16 May 2025 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421526; cv=none; b=trCZyu+hW3BfbfjLgKl33KNJYmxhfA7Lwx/jv1665tTEJ0fomTt62tYmcZLyRy9yBQJqGWtYpMi99NgV1ioWnfNe3Km5L/+ksOG2HHozDNY6qHWH8HKzES0c7vqO8jraMRIR1BZ/AQGPIdL7QdmnICnTRW1kxGX8ZqOr0VY0VFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421526; c=relaxed/simple;
	bh=3E09u6U7E2io67Ymr2RG+oHARDJaNwa8aO5y50uDuqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7QuGW7gy3rrrLCrFP6hHId5G60XZvs98LVXEGiBqJs2tHGtjQvydfXKJlf4cZTa6VU0DQR4f6bmY18Mk+V+z9CTIjKEydDis5VLsbp4pVKeQD12x8c00YG3RCj2xxPUpUecG+ev+kOrzaIBuPyhob3M9E5SrTyhNgFS4J7hykQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=BLyzrMt1; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 73B0D9C9060;
	Fri, 16 May 2025 14:52:03 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id F1PiPYXGVcmr; Fri, 16 May 2025 14:52:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id EB6AB9C905E;
	Fri, 16 May 2025 14:52:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com EB6AB9C905E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1747421523; bh=EDrtCERjeggy1F5Mvt3jo+Ghmjeat8adSrQGsX/ghDo=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=BLyzrMt14szf/1NYzft8El3sE1JTMfudKedONm+J5C6lMfwzrrqGzgC5E035sg2Sh
	 vZ25JRhp1dh4EWq3gY6JvPHlFGMyY63hmkoeyqssr1alz9BlVHGWtACuBBQrHqvmLL
	 dUEk7RW2c820n4bkxydf9LmDW53bIRQcS7aC6T/8lQvW/j9G6OqfQTnY9NKDlHrVxW
	 lW7Mb/WA36V0s8IT86KXiFAUkv52k4+XlYbDNW1ObKU5y8b7EbtHb8XYqQgMfGhmG8
	 v3e/KatWt5YJ2VBcS6eBaXOdizar472rcksN37vOUDa0Cr9yaDl+ECuqpg+5oS39G/
	 koM7rwBBJpPRw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id dbK4OqA5uaHS; Fri, 16 May 2025 14:52:02 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id B69149C905D;
	Fri, 16 May 2025 14:52:02 -0400 (EDT)
Date: Fri, 16 May 2025 14:52:01 -0400
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
Subject: [PATCH v2 3/9] dt-bindings: input: add pf1550
Message-ID: <ceed690bd200eb03bc47c0d462292a5230aa2fbf.1747409892.git.samuel.kayode@savoirfairelinux.com>
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

Add the DT binding document for the onkey module of pf1550.

Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
 .../bindings/input/pf1550_onkey.yaml          | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/pf1550_onkey.yaml

diff --git a/Documentation/devicetree/bindings/input/pf1550_onkey.yaml b/Documentation/devicetree/bindings/input/pf1550_onkey.yaml
new file mode 100644
index 000000000000..7079f5284b73
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/pf1550_onkey.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/pf1550_onkey.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Onkey for PF1550 PMIC from NXP.
+
+maintainers:
+  - Samuel Kayode <samuel.kayode@savoirfairelinux.com>
+
+description: |
+  This module is part of the pf1550 MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/pf1550.yaml.
+
+allOf:
+  - $ref: input.yaml#
+
+properties:
+  compatible:
+    const: fsl,pf1550-onkey
+
+  linux,keycodes:
+    description: Keycode to emit
+    default: 116  # KEY_POWER
+
+required:
+  - compatible
+additionalProperties: false
+
+...
-- 
2.49.0



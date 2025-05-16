Return-Path: <linux-pm+bounces-27239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE86ABA32D
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 20:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0957A1899113
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 18:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB24727A47E;
	Fri, 16 May 2025 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="hkA+trwf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C144F1C07C4;
	Fri, 16 May 2025 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421444; cv=none; b=uurRKFC6t2bUQb0eNH1T2upP3ZZFCuxyZgWRnoQpW/nGMpxmiRtJjKKZH25dq0hLcHv8tCsnt5D+8Q1moUvYRavt7FaBEgUFWd5TtPeaB78az8n4doXeXPufU92ei6m984zrxLnULXU67PJzcFUeTyHvlA9Pv81Z5YrnrROydgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421444; c=relaxed/simple;
	bh=hAiZr/LrH8Xjb2ZGwWO9jhrBh+oBiAjAWL90TRbTYoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMrFbZWBxyQmwzzZNYPIsor4iQizIA0uIcGzHc6fMlu3RKwR5wpJFlzpIJBtbPfqpCg2W4kB7+bs8s/qbtHeMFvn4inpHAEmI6kY/f7P96okks9bOSDcvY/Xd4csfkq91J0AhtEPmmZ2XeI5qKxP2bq2lyQMuWoEr5+hAXDdP+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=hkA+trwf; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id BEBC29C904D;
	Fri, 16 May 2025 14:50:40 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id aSn8XPjRTwdz; Fri, 16 May 2025 14:50:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3B9779C904E;
	Fri, 16 May 2025 14:50:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 3B9779C904E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1747421440; bh=rd2/deZALZ3wtz5IdGVW0BxEhJ80xK8S7SFDzAOgLFo=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=hkA+trwfCtDlqD5I16ihcNBH/U2BCKLuyN8efmeA5EepjC8YIG2etWQh+Ge2ir8CC
	 D571Kxt9IHCfKyNB0zpmRYk2LpSMnuJqb/fqigpJdV3xFcvcptZDrk0cxuzL5df0mP
	 Kg1TXlgaPLQ2cKi15bh9CGy4p366vy+5BIQbS7QbUK1K09RAFnWcn5ivxgaMv8yBOh
	 EY8UittGcg0Ry8B9CgQjO5DeIpWXbvQy6Xvtk+r55TU24732nZQhB4dSTS2CfiSMI3
	 i+Hl9ryOwjnQCGqB7HgA7VnJAuwBuP7R4aPtnK61rENz4Ky/JACVh94kG6EWebskRN
	 HUZh7pajUmDtQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id w8gP9-8bJzAQ; Fri, 16 May 2025 14:50:40 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id EE9069C904D;
	Fri, 16 May 2025 14:50:39 -0400 (EDT)
Date: Fri, 16 May 2025 14:50:38 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokho <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Robin Gong <yibin.gong@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-imx@nxp.com, linux-input@vger.kernel.org,
	Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>,
	Robin Gong <b38343@freescale.com>,
	Enric Balletbo Serra <eballetbo@gmail.com>
Subject: [PATCH v2 2/9] dt-bindings: regulator: add pf1550
Message-ID: <7c8ceab2aa66bf221981f689025d0bd29df8d596.1747409892.git.samuel.kayode@savoirfairelinux.com>
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

Add the DT binding document for pf1550 regulators.

Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
 .../devicetree/bindings/regulator/pf1550.yaml | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/pf1550.yaml

diff --git a/Documentation/devicetree/bindings/regulator/pf1550.yaml b/Documentation/devicetree/bindings/regulator/pf1550.yaml
new file mode 100644
index 000000000000..a684ab974496
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/pf1550.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/pf1550.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Regulators for PF1550 PMIC from NXP.
+
+maintainers:
+  - Samuel Kayode <samuel.kayode@savoirfairelinux.com>
+
+description: |
+  This module is part of the PF1550 MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/pf1550.yaml.
+
+  The regulator controller is represented as a sub-node of the PMIC node
+  on the device tree.
+
+  The device has three LDO regulators, three buck converters and a DDR
+  termination reference voltage.
+
+properties:
+  compatible:
+    const: fsl,pf1550-regulator
+
+patternProperties:
+  "^(LDO[1-3]|SW[1-3]|VREFADDR)$":
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+additionalProperties: false
+
+...
-- 
2.49.0



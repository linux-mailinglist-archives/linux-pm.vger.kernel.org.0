Return-Path: <linux-pm+bounces-23880-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4342AA5CBEE
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 18:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764B816A81A
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 17:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928342620E5;
	Tue, 11 Mar 2025 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UhHX40Dw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA932261597
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713636; cv=none; b=JHdAJCSHznOczC3HzEMa6RzWBwH+DiiZ8jzYPPAWSL0slTUpV4Ym6LLm47lXVQcrHUg2mV5xh1mHGRKh/hW2O+hw5TZXmvaworplzyBVtG9PYluG7yuKbpDoCE8/7JvIsMj0+ZC09WpsFQ6gabBAEq6KkOMnfJ8NV65Yyzbj6s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713636; c=relaxed/simple;
	bh=vPotdmFer/KkJRpHM1CgVgBvDOaBH+eHeIhoiFUXj7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=uLsSmd01sXW4qsbXNCmAD4JsxxH5AlCgLxoVPoHdgWJ0okjQEOVT0dZpxBzQGYcrHtivmqfdqj3f099mAumasCF8wE8rfWGfLNO3RgnwHzp/mgAgd6PwOEN6qb/NZODYlH3+0be9HrulY5W4KNCHhV0D9TOBj90je8zN0by/uII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UhHX40Dw; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250311172033euoutp021a5609933eec17f571ce9d15909faa1e~rz1JH3bBk2933529335euoutp02Z
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 17:20:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250311172033euoutp021a5609933eec17f571ce9d15909faa1e~rz1JH3bBk2933529335euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741713633;
	bh=QlOPvGKaMPU/idJug/zylqhE7fvuqnxP/B0lxZPddds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UhHX40DwQucVLhjvIbSrvFhjQ7936ySzcc7DpMEVg7B9NxOg1aosEWKhcJE6oqAvu
	 3tvbm1ydTa+q7JQDSwHSrAbDzAXBj36EIFWkrde0Ol5NXlgxHrKfBV/dNhUcXNnVzW
	 IKQ+pHIyPUkBFY8PLvTDwi2JkxC7PnzfUiRnP9VE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250311172032eucas1p272dbcb39b06cfaba109d88eac6bdfada~rz1IOqrdM1827018270eucas1p2_;
	Tue, 11 Mar 2025 17:20:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 79.A9.20397.0E070D76; Tue, 11
	Mar 2025 17:20:32 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250311172031eucas1p25256401173265078fd016773cbba7aeb~rz1HuFwZp2714427144eucas1p2f;
	Tue, 11 Mar 2025 17:20:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250311172031eusmtrp281f60f05c4d81bd9d02304b2687d4489~rz1HtaJtF1824318243eusmtrp2O;
	Tue, 11 Mar 2025 17:20:31 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-93-67d070e005a2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 51.A4.19920.FD070D76; Tue, 11
	Mar 2025 17:20:31 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250311172030eusmtip2050731d0fb05b006d60984d713cbc03b~rz1Gy8bkb1861018610eusmtip2k;
	Tue, 11 Mar 2025 17:20:30 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	jszhang@kernel.org, ulf.hansson@linaro.org, m.szyprowski@samsung.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Michal
	Wilczynski <m.wilczynski@samsung.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 1/5] dt-bindings: firmware: thead,th1520: Add support for
 firmware node
Date: Tue, 11 Mar 2025 18:18:56 +0100
Message-Id: <20250311171900.1549916-2-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311171900.1549916-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7djPc7oPCi6kG7Sf4LR4ducrq8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFm82NvIYtF8bD2bxctZ99gs9r7eym5xedccNovPvUcYLbZ9bmGz
	WHvkLrvF+q/zmSxeXu5htmibxW/xf88Odovja8MtWvZPYXEQ9njz8iWLx+GOL+we905MY/XY
	tKqTzePOtT1sHpuX1Hu0rD3G5PF+31U2j74tqxg9LjVfZ/f4vEkugDuKyyYlNSezLLVI3y6B
	K+NUwxL2glXiFS/nT2VuYFwi3MXIySEhYCLx9V8XSxcjF4eQwApGiZkdvWwQzhdGiRsTG5gg
	nM+MEhcuHGWEaTlzcidUYjmjRP+uvVD9bxglPp64wAJSxSZgJPFg+XxWkISIQD+TRN+R/2AO
	s8BDRonXL5tYQaqEBWIklq89DmRzcLAIqEp8vAi2glfAXuLLqdOsEOvkJfYfPMsMYnMKOEh8
	3rYCqkZQ4uTMJ2DLmIFqmrfOZoao380psahZCsJ2kbj1ZTPUHGGJV8e3sEPYMhL/d85ngrDz
	JR5s/QTVWyOxs+c4lG0tcefcLzaQ05gFNCXW79KHCDtK7F/1hwUkLCHAJ3HjrSDEBXwSk7ZN
	Z4YI80p0tAlBVKtJTO3phVt6bsU2qKUeEs/nnmSZwKg4C8kvs5D8Mgth7wJG5lWM4qmlxbnp
	qcXGeanlesWJucWleel6yfm5mxiBifH0v+NfdzCuePVR7xAjEwfjIUYJDmYlEd7VthfShXhT
	EiurUovy44tKc1KLDzFKc7AoifMu2t+aLiSQnliSmp2aWpBaBJNl4uCUamBi49xXqxJ6+lH1
	icMC9daacxuOr9h4oT830U0qsHDynzy/b2tffV1xvrJ4X2VQ2aldxVNYZym9/ubyaRPn15zG
	mWkLXtuEXLD3KuqRK7W9smVV+I3GmsRb1Yd2/ZO/syzd1fH1xTc932qi3oueL/rXq7Ch5+Mi
	gw2tHw/4h3oetSp6KzGTRfZ8TWH9pBsKrfZxOz+Y/d9XusXtm86u11M+MjWrnTpVl1W1zUsj
	yLK05YmaheTLWV96X/Ssq56iftn+4cWrUmpNt05bf0k4O8M7eYr8St99jE29lXd8FY/taTyV
	wh82Z1rN6zmfjhx4lW9j0sElvDXAmVPSheM5h8/6uRNMXx2a72Sod99nvmS8EktxRqKhFnNR
	cSIA6KmRZPsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7r3Cy6kG3x5q2rx7M5XVoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbJ4sbeRxaL52Ho2i5ez7rFZ7H29ld3i8q45bBafe48wWmz73MJm
	sfbIXXaL9V/nM1m8vNzDbNE2i9/i/54d7BbH14ZbtOyfwuIg7PHm5UsWj8MdX9g97p2Yxuqx
	aVUnm8eda3vYPDYvqfdoWXuMyeP9vqtsHn1bVjF6XGq+zu7xeZNcAHeUnk1RfmlJqkJGfnGJ
	rVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsaphiXsBavEK17On8rcwLhE
	uIuRk0NCwETizMmdTF2MXBxCAksZJeYdX8AKkZCRuNb9kgXCFpb4c62LDcQWEnjFKDF7kSiI
	zSZgJPFg+XxWkGYRgYVMElenbGAGSTALPGWU2HZDHMQWFoiSWHV5NlARBweLgKrEx4uMIGFe
	AXuJL6dOQ+2Sl9h/8CxYK6eAg8TnbSsYIXbZS2yb3MUMUS8ocXLmExaI8fISzVtnM09gFJiF
	JDULSWoBI9MqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwAjeduzn5h2M81591DvEyMTBeIhR
	goNZSYR3te2FdCHelMTKqtSi/Pii0pzU4kOMpkBnT2SWEk3OB6aQvJJ4QzMDU0MTM0sDU0sz
	YyVxXrfL59OEBNITS1KzU1MLUotg+pg4OKUamLhttutvb5/6qln1wjFNU1aD1Prq+48UN8Za
	PPZymLLYrHlDxm+Fubb9x2NYO6fIKcvttfS/U7Wj7lDJ8TaeIC72PxFi0aq8C/+vvSvqfieR
	JbnSQOfRKb2JWxJfVQXXb+8X9/+5RerAkjnZe1R0bLNPnApQzNEw4Hq6dK3E93ObLu6S+8ik
	9TFB5W98dd4TwWln/1267LitXtfh6qoZ/0+Ha80/KeNl4c/odvbHkZ0Wl765JxeHSP3/yxQu
	FDlb5J+BtMH3i2EhGipFQb1b3bo2uwXfzug4vGv2u5jmjn9rE+scdS+fqd5uZcK4RvHZq9iT
	el5/IjNXRSmKGP21mnHHuPVz4o8SP0/xmTOtlFiKMxINtZiLihMBejCsA2kDAAA=
X-CMS-MailID: 20250311172031eucas1p25256401173265078fd016773cbba7aeb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250311172031eucas1p25256401173265078fd016773cbba7aeb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250311172031eucas1p25256401173265078fd016773cbba7aeb
References: <20250311171900.1549916-1-m.wilczynski@samsung.com>
	<CGME20250311172031eucas1p25256401173265078fd016773cbba7aeb@eucas1p2.samsung.com>

The kernel communicates with the E902 core through the mailbox
transport using AON firmware protocol. Add dt-bindings to document it
the dt node.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 .../bindings/firmware/thead,th1520-aon.yaml   | 53 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml

diff --git a/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
new file mode 100644
index 000000000000..bbc183200400
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/thead,th1520-aon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-HEAD TH1520 AON (Always-On) Firmware
+
+description: |
+  The Always-On (AON) subsystem in the TH1520 SoC is responsible for managing
+  low-power states, system wakeup events, and power management tasks. It is
+  designed to operate independently in a dedicated power domain, allowing it to
+  remain functional even during the SoC's deep sleep states.
+
+  At the heart of the AON subsystem is the E902, a low-power core that executes
+  firmware responsible for coordinating tasks such as power domain control,
+  clock management, and system wakeup signaling. Communication between the main
+  SoC and the AON subsystem is handled through a mailbox interface, which
+  enables message-based interactions with the AON firmware.
+
+maintainers:
+  - Michal Wilczynski <m.wilczynski@samsung.com>
+
+properties:
+  compatible:
+    const: thead,th1520-aon
+
+  mboxes:
+    maxItems: 1
+
+  mbox-names:
+    items:
+      - const: aon
+
+  "#power-domain-cells":
+    const: 1
+
+required:
+  - compatible
+  - mboxes
+  - mbox-names
+  - "#power-domain-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    aon: aon {
+        compatible = "thead,th1520-aon";
+        mboxes = <&mbox_910t 1>;
+        mbox-names = "aon";
+        #power-domain-cells = <1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ed7aa6867674..15f4bc618064 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20427,6 +20427,7 @@ L:	linux-riscv@lists.infradead.org
 S:	Maintained
 T:	git https://github.com/pdp7/linux.git
 F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
+F:	Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
 F:	Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
 F:	Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
 F:	Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
-- 
2.34.1



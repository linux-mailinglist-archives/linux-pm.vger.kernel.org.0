Return-Path: <linux-pm+bounces-23317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EF2A4C403
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 15:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B5316F715
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 14:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFBA2144A4;
	Mon,  3 Mar 2025 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JlU6XuDs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EC8212FA7
	for <linux-pm@vger.kernel.org>; Mon,  3 Mar 2025 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013964; cv=none; b=dE82cNATOMxAdGI7d1o3ZkjyD5fKgxl6QZevWKlqe3IDrjfSpmKTGCMjLwVl6A29R4tK/LT6723+2rMYxGZKNQzA920S18/nIJbjQHWm7BwJ9R7LNzN0AHwM+3Wk2RFCENsy4TIXb1RC+nlV7wGLMo4c/x4FLMgF1kT9rwbXcX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013964; c=relaxed/simple;
	bh=nNzzTaiGCKNDT1ckBGJ+pIobFR2EcC4C0zDoSPv+uSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=DWId1GFz7wQKRFbhZFJMWT3C0ymFAAFxA9uJyTe6dXiw+ojg9egNH6nAvhnwLltDZxAv4H0ng1X7hB/IvQDJrTfTEDuLtoN3X9lZptZIa1eK28+9cSIEi5Kmpmj69UQ+ZGZELuvst+O7bN1+q6iUezFFy6/Pom+fczHzISWShMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JlU6XuDs; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250303145919euoutp026b26554b6a10685bfb0b9c86e532c572~pUvjaYmq02210222102euoutp02b
	for <linux-pm@vger.kernel.org>; Mon,  3 Mar 2025 14:59:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250303145919euoutp026b26554b6a10685bfb0b9c86e532c572~pUvjaYmq02210222102euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741013959;
	bh=OMMV00WbWhNa/Ps+eLKL8dWNWeRsbM+HUjc2tzFfM4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JlU6XuDsF8bR3vQdoedHysSWgR9Pu+GRDkORd0ZhH/B0/IRPkkFQ3V5i7n1B3hrUD
	 nI0V6y9nmgFVlS+YI5hv2s+7ef2RQ2aQLeudfhkmsBTwW+EU0EVoZ/v2mJgQWNOg78
	 1qNqpnytiridCvU0x7iC2HNGjFh22wVgAuhVBd34=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250303145919eucas1p28911195be19b71d3b8aa3fcacc78740d~pUvi7zYpx1701417014eucas1p2B;
	Mon,  3 Mar 2025 14:59:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 6E.C1.20409.7C3C5C76; Mon,  3
	Mar 2025 14:59:19 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250303145918eucas1p10f64b2ce75e395ce208439307daa8a8f~pUviZtV3S0762307623eucas1p1C;
	Mon,  3 Mar 2025 14:59:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250303145918eusmtrp18841a15b616fc7e4a2bdbb4e56e3ccbf~pUviZDDaa2312323123eusmtrp1a;
	Mon,  3 Mar 2025 14:59:18 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-b2-67c5c3c7ba34
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 21.2D.19654.6C3C5C76; Mon,  3
	Mar 2025 14:59:18 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250303145917eusmtip262401cb62e98a1cb3c10584e5559065b~pUvhfIk212997429974eusmtip2E;
	Mon,  3 Mar 2025 14:59:17 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	jszhang@kernel.org, ulf.hansson@linaro.org, m.szyprowski@samsung.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Michal
	Wilczynski <m.wilczynski@samsung.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v1 1/5] dt-bindings: firmware: thead,th1520: Add support for
 firmware node
Date: Mon,  3 Mar 2025 15:58:57 +0100
Message-Id: <20250303145901.446791-2-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303145901.446791-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djP87rHDx9NN7j2kN3i2Z2vrBZbf89i
	t1iz9xyTxfwj51gt7l3awmTxYm8ji0XzsfVsFi9n3WOz2Pt6K7vF5V1z2Cw+9x5htNj2uYXN
	Yu2Ru+wW67/OZ7J4ebmH2aJtFr/F/z072C2Orw23aNk/hcVB2OPNy5csHoc7vrB73DsxjdVj
	06pONo871/aweWxeUu/RsvYYk8f7fVfZPPq2rGL0uNR8nd3j8ya5AO4oLpuU1JzMstQifbsE
	rowb6+cyFawSr7i8WK2BcYlwFyMHh4SAicT+M/ldjJwcQgIrGCWatpd0MXIB2V8YJY5MXsQG
	4XxmlJhybhYLTEPnV0mI+HJGiQWLXjNBOG8YJXpudTKDjGITMJJ4sHw+K0hCRKCfSaLvyH8w
	h1ngIaPE65dNrCBVwgIxEq8/rWAHsVkEVCX2z5sI1s0rYCexc3IHE4gtISAvsf/gWWaQ1ZwC
	9hKfGjQhSgQlTs58wgJiMwOVNG+dzQwyX0JgN6fE9k3XoXpdJBrOX2eDsIUlXh3fwg5hy0ic
	ntzDAmHnSzzY+okZwq6R2NlzHMq2lrhz7hcbyF5mAU2J9bv0IcKOEhNetzFBQoJP4sZbQYgT
	+CQmbZvODBHmlehoE4KoVpOY2tMLt/Tcim1QnR4Ss5fZTmBUnIXkl1lIfpmFsHYBI/MqRvHU
	0uLc9NRio7zUcr3ixNzi0rx0veT83E2MwIR4+t/xLzsYl7/6qHeIkYmD8RCjBAezkgjvrfaj
	6UK8KYmVValF+fFFpTmpxYcYpTlYlMR5F+1vTRcSSE8sSc1OTS1ILYLJMnFwSjUwZVzkc/v6
	bFXDmeTP2j+/uKcZX7p0I07c7r2ygu2aMzEqSi1WPjpu71rjijcmF/8zen2G53eQo6fd55QJ
	T/l3s24qiP7u+FTPOFDsuMWcsLfLz95gnCr8e9uWiTtWZ9wNSjov/mSr+5SPDJlVK+ymbL4k
	uzvfzf9hxtdv95c+XXW8d5t9T8XarzIf/q39OOnps5Io52l8Z3nvdFsu2FsXIcyzWdXi8Iae
	8MWzEve4uriXeXw7kr58+yPReS5lca96twBDVGevre9EXaWJUrXO57afc/tiMTuy/FYxy8p6
	yV07BcRPz992M2ql8vxO341f/++YkPW9LsBbetXlsKNneRezrXp78G5H3+vm29rXMpRYijMS
	DbWYi4oTAfQv4Q33AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7rHDh9NN/hwRcni2Z2vrBZbf89i
	t1iz9xyTxfwj51gt7l3awmTxYm8ji0XzsfVsFi9n3WOz2Pt6K7vF5V1z2Cw+9x5htNj2uYXN
	Yu2Ru+wW67/OZ7J4ebmH2aJtFr/F/z072C2Orw23aNk/hcVB2OPNy5csHoc7vrB73DsxjdVj
	06pONo871/aweWxeUu/RsvYYk8f7fVfZPPq2rGL0uNR8nd3j8ya5AO4oPZui/NKSVIWM/OIS
	W6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYwb6+cyFawSr7i8WK2BcYlw
	FyMHh4SAiUTnV8kuRi4OIYGljBIPzjeydzFyAsVlJK51v2SBsIUl/lzrYoMoesUoMXFdEyNI
	gk3ASOLB8vmsIAkRgYVMElenbGAGSTALPGWU2HZDHMQWFoiS+PGyHWwqi4CqxP55E8FqeAXs
	JHZO7mCC2CAvsf/gWWaQizgF7CU+NWiCmEJAJa8+cUBUC0qcnPmEBWK6vETz1tnMExgFZiFJ
	zUKSWsDItIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwercd+7llB+PKVx/1DjEycTAeYpTg
	YFYS4b3VfjRdiDclsbIqtSg/vqg0J7X4EKMp0NUTmaVEk/OB6SOvJN7QzMDU0MTM0sDU0sxY
	SZyX7cr5NCGB9MSS1OzU1ILUIpg+Jg5OqQam6NnbLbuXPoxb+vpw5u9P91z+1qyRjn8/v/7x
	wnrB1+zyNpLruVKzeBhMNvp7KPAvatKfHHTDL1k6hCstcqGLYd6dcrYL/R8evZZa/kBGtP39
	xN81Ku8l2T9E3LftYXd7dmeicHNVqUbGjMYkd5UVXFvCXNuXL7t5p3+T1qxJce2fBI431FRN
	klnx3fCdVvs112n+Ga4/eM8X8N2IvPnj8OPpfVZr/jwwXp/SrzXHnaEs5JTyzx1XP0+fIvTG
	14j36d/4HTXPDmkFlZ26L31ggXnUSRMDCasDFhbPnJQPe78sb/rMJBSx+HbRo7eadZNun9EW
	XdLmoPd38v2Al7s715z1PqNTe23ezm18QScmKrEUZyQaajEXFScCABK364RnAwAA
X-CMS-MailID: 20250303145918eucas1p10f64b2ce75e395ce208439307daa8a8f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250303145918eucas1p10f64b2ce75e395ce208439307daa8a8f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250303145918eucas1p10f64b2ce75e395ce208439307daa8a8f
References: <20250303145901.446791-1-m.wilczynski@samsung.com>
	<CGME20250303145918eucas1p10f64b2ce75e395ce208439307daa8a8f@eucas1p1.samsung.com>

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
index 8e0736dc2ee0..46745cfe9d1f 100644
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



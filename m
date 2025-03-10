Return-Path: <linux-pm+bounces-23743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9157A58ECE
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 10:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 090D57A357D
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 09:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376AE2248A4;
	Mon, 10 Mar 2025 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CGjpLjrh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BCC223705
	for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741597348; cv=none; b=oGZDu2fCxpbpaqcBYbNuxmm5KXBNH9AwbQsoDvSqIhIk5TZK38uD9Nm+iDSqzU1KbaoPkrtd6eEzJc/mNFNzGcd3JAvBrQIZEJ9aNtVi367YB7oZi5ZVPKOKWv8z7MsmBiAuu0TGXV6tZpWRLvIuur5wfyZye0t/l/zkEuFD7/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741597348; c=relaxed/simple;
	bh=vPotdmFer/KkJRpHM1CgVgBvDOaBH+eHeIhoiFUXj7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Jxux49qAgCf59EG/GlNXFc5FNc9gcg+VUvYiqrHRAM8gYlYyHZQ4GHRlIjeygkuBcBirFljqhNRinesHu/tB83aF6hlnMqWetNyFbwo9ke8Z0d3DHvYuLmZXaEgP2BWpN0054CSkelGAxwO8xvQ7pyooiz14H2e00rImD2xhqZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CGjpLjrh; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250310090218euoutp022449cfd7cfaa2b794e506541ce244c45~rZY1U6EXh2542725427euoutp02x
	for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 09:02:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250310090218euoutp022449cfd7cfaa2b794e506541ce244c45~rZY1U6EXh2542725427euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741597338;
	bh=QlOPvGKaMPU/idJug/zylqhE7fvuqnxP/B0lxZPddds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CGjpLjrhg8y/z3a9e6bcpvc2VZ89s5gpeJ7R3QXQf3KY9rzj20wotdOokLIb7ziOS
	 wzdLPp0KAJYrEjAAxUgDJ4gmlB5rrUo9NHkxKCX5npCKF27VWvQuHY/qT+0pJtkVwC
	 OphXZiNP0Q0Cjund6vpDgvdWdjrzl6RYAHMxrllI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250310090217eucas1p100fc3752de49bb7a7b1ed0e67e1cf273~rZY0wb_bE2282522825eucas1p1F;
	Mon, 10 Mar 2025 09:02:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 03.86.20409.99AAEC76; Mon, 10
	Mar 2025 09:02:17 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250310090217eucas1p2051d00809a53d8daca663c8ef8d78dc8~rZY0UoIW22912429124eucas1p2i;
	Mon, 10 Mar 2025 09:02:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250310090217eusmtrp25434d7b666433bb05eb197ed40b200eb~rZY0T27pH2373823738eusmtrp2Z;
	Mon, 10 Mar 2025 09:02:17 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-c5-67ceaa99e909
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 30.E5.19920.99AAEC76; Mon, 10
	Mar 2025 09:02:17 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250310090216eusmtip224d54353dec5bb0b78398c86006803f3~rZYzQVSZl2674426744eusmtip2b;
	Mon, 10 Mar 2025 09:02:16 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	jszhang@kernel.org, ulf.hansson@linaro.org, m.szyprowski@samsung.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Michal
	Wilczynski <m.wilczynski@samsung.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/5] dt-bindings: firmware: thead,th1520: Add support for
 firmware node
Date: Mon, 10 Mar 2025 10:02:07 +0100
Message-Id: <20250310090211.286549-2-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310090211.286549-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7djPc7ozV51LN1iz2Mzi2Z2vrBZbf89i
	t1iz9xyTxfwj51gt7l3awmTxYm8ji0XzsfVsFi9n3WOz2Pt6K7vF5V1z2Cw+9x5htNj2uYXN
	Yu2Ru+wW67/OZ7J4ebmH2aJtFr/F/z072C2Orw23aNk/hcVB2OPNy5csHoc7vrB73DsxjdVj
	06pONo871/aweWxeUu/RsvYYk8f7fVfZPPq2rGL0uNR8nd3j8ya5AO4oLpuU1JzMstQifbsE
	roxTDUvYC1aJV7ycP5W5gXGJcBcjJ4eEgInE7v/n2bsYuTiEBFYwSvR2b2UESQgJfGGUOLcl
	HiLxmVFi0d8DTDAd++b1s0IkljNKTNjVBdX+hlHiQuNNNpAqNgEjiQfL54NViQj0M0n0HfkP
	5jALPGSUeP2yCcjh4BAWiJG41RAJ0sAioCox6+ljdhCbV8BOYse95VDr5CX2HzzLDGJzCthL
	vNi4iRGiRlDi5MwnLCA2M1BN89bZzCDzJQS2c0pce/uKGaLZReLW1XVQtrDEq+Nb2CFsGYn/
	O+dDLciXeLD1E1RNjcTOnuNQtrXEnXO/2EDuZBbQlFi/Sx8i7Chx718nE0hYQoBP4sZbQYgT
	+CQmbZvODBHmlehoE4KoVpOY2tMLt/Tcim1QSz0k9u25zjqBUXEWkmdmIXlmFsLeBYzMqxjF
	U0uLc9NTi43yUsv1ihNzi0vz0vWS83M3MQIT4+l/x7/sYFz+6qPeIUYmDsZDjBIczEoivGrb
	T6UL8aYkVlalFuXHF5XmpBYfYpTmYFES5120vzVdSCA9sSQ1OzW1ILUIJsvEwSnVwNTHcCdm
	e4jPhSfKXptzGa0mMJZtY+76sqzNJGuzwpHr2fYzOeZMiP9p90g9lnu1oknmkx053i/K5U1j
	/11n1O9Yu9iXJSvkxDof/RMX+kq0OpynfQr7G1WbLXrkzqQ7e96eenXu46aU365LuL516i98
	LNDx+Ld/yfuN8SwvTp85duRqcgtfvZ/0FscmCZP+7DWC4p9/esktf6yrszb2vfNtsaMTBdo4
	DYRu/jW6wypSeu9uLMeK6wyLTkrUX2OOVIzLOMClKCNSqPpz4bnFHPOdLCdt4j1RzvH2Ymjd
	6XtuL2uuFX6tXab8a5GJhy3zjMRGp/Zv/RPeb76Y3Lp2p0De1tyz7fUptdGH77ocP6fEUpyR
	aKjFXFScCACf+9n0+wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xe7ozV51LN2g8IGbx7M5XVoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbJ4sbeRxaL52Ho2i5ez7rFZ7H29ld3i8q45bBafe48wWmz73MJm
	sfbIXXaL9V/nM1m8vNzDbNE2i9/i/54d7BbH14ZbtOyfwuIg7PHm5UsWj8MdX9g97p2Yxuqx
	aVUnm8eda3vYPDYvqfdoWXuMyeP9vqtsHn1bVjF6XGq+zu7xeZNcAHeUnk1RfmlJqkJGfnGJ
	rVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsaphiXsBavEK17On8rcwLhE
	uIuRk0NCwERi37x+1i5GLg4hgaWMEg/bl7NBJGQkrnW/ZIGwhSX+XOtigyh6xSix8fpmRpAE
	m4CRxIPl88G6RQQWMklcnbKBGSTBLPCUUWLbDXEQW1ggSmL9jrtMIDaLgKrErKeP2UFsXgE7
	iR33ljNBbJCX2H/wLFgvp4C9xIuNm8AWCIHUdL9jhagXlDg58wkLxHx5ieats5knMArMQpKa
	hSS1gJFpFaNIamlxbnpusaFecWJucWleul5yfu4mRmAUbzv2c/MOxnmvPuodYmTiYDzEKMHB
	rCTCq7b9VLoQb0piZVVqUX58UWlOavEhRlOguycyS4km5wPTSF5JvKGZgamhiZmlgamlmbGS
	OK/b5fNpQgLpiSWp2ampBalFMH1MHJxSDUxht1PXVvDb767p5i9RKqzKOewo9u9AvELoFD/T
	uli9gz+CDKKu28/bJfp32zWFkvNPs63ZuNOTl2hVHPnKdTDVaMPH2zLGdv1WS2tSd1UsWyj8
	z0F+wjeegEkxEcx2Qi+X5dg1+L0Tf5nZfitCa14nv6ilqaTthfJbLV8V+JcWik+e4zfTp3tP
	o1z9svX3d8RfatfnFio7Pzs+lq3a1yN0yZPkmikLz82z7fmc8alT76vgrE/KexulW36eVw1h
	N9syN/i1/3ybvkZuzRveArf2fS+9ZmkVuVVrluwvTaNWw8eWoX3PNt/hqdB+0WBzz3bG1tDD
	j0O/879YPX2F5KGX1axnZd3spJW3z9R7rMRSnJFoqMVcVJwIAC/heFhrAwAA
X-CMS-MailID: 20250310090217eucas1p2051d00809a53d8daca663c8ef8d78dc8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250310090217eucas1p2051d00809a53d8daca663c8ef8d78dc8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250310090217eucas1p2051d00809a53d8daca663c8ef8d78dc8
References: <20250310090211.286549-1-m.wilczynski@samsung.com>
	<CGME20250310090217eucas1p2051d00809a53d8daca663c8ef8d78dc8@eucas1p2.samsung.com>

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



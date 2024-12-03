Return-Path: <linux-pm+bounces-18462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F7C9E1DEE
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 14:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6F31665A3
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 13:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACED91F7074;
	Tue,  3 Dec 2024 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZiXqqoMU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B7E1F6669
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233328; cv=none; b=htzwkbL93WLdKFYsXeu8sKIfsh1HKHXvL3nfsS5olqdZlvRZNiKtz8UfSUgLSH8PLFKNgxwLX2IVU5g+TOoFSnJmJinBnqGxc3FEudd1a0nR1YkdLwd/pH0qYhg6UP+yprqaYw6a5nREY46NMfgeeoay/BI60NpEqSV88vEunSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233328; c=relaxed/simple;
	bh=sDKPvWGxnHxVC0T32lC0HUTaPXo+NU3d+tnf4J88OFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=D9mC9/+oPcezsyvJ3WCjt9UBbqAX7ZFZKlEw/HwMqYoh2I2BgkhvNx5fiGSnnrlzjKOXFeqQndayzVBTloICzwQCWQpVcuqT8+gdtGUdwrzwsFW1AuHoh9Sw7Hrm1Z5hfOLVe9XEm6P6cURMZQugS9EegAFmLH9jjGJTT7grgOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZiXqqoMU; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241203134200euoutp028749a3cb47f702acf437ac94b339ad60~NroWwnGG53035230352euoutp02h
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:42:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241203134200euoutp028749a3cb47f702acf437ac94b339ad60~NroWwnGG53035230352euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733233320;
	bh=EW8C3FY5YdJjEkS2Yc5HPO77Vz/fd2iQK7q2W6SPoFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZiXqqoMUsPzAfHBAntt7aChmN5c8gU+R25xY/qjqpocjOwKUXeP9mRPV02ummPTNm
	 ectZrtBcLmx6PPfSDvWyisOHasRG7XKcTjHo+WrXYsF6aJ4frzg9TBAH62pWcWegFX
	 Xh4JggojA3qConjIk/8f4uAsMbQ5hZ1R3bvn8lmw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241203134159eucas1p2e233c85ff41d2e0af5ab47c7dd4287db~NroV7J0at1157511575eucas1p2s;
	Tue,  3 Dec 2024 13:41:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 89.CA.20821.7AA0F476; Tue,  3
	Dec 2024 13:41:59 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241203134159eucas1p1eafefef0dfe7f2b6343a639733012bcf~NroVaZC7t3119131191eucas1p1D;
	Tue,  3 Dec 2024 13:41:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241203134159eusmtrp180a93901ed8e82f9f619033779cce93c~NroVZgGeV0887308873eusmtrp1Q;
	Tue,  3 Dec 2024 13:41:59 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-78-674f0aa7012c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id B1.07.19654.7AA0F476; Tue,  3
	Dec 2024 13:41:59 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241203134157eusmtip2c106e0c8996c77f30060740310e5e13f~NroUGITQL2454624546eusmtip2M;
	Tue,  3 Dec 2024 13:41:57 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com,
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	ulf.hansson@linaro.org, jszhang@kernel.org, m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, Michal Wilczynski
	<m.wilczynski@samsung.com>
Subject: [RFC PATCH v1 08/14] dt-bindings: power: thead,th1520: Add support
 for power domains
Date: Tue,  3 Dec 2024 14:41:31 +0100
Message-Id: <20241203134137.2114847-9-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203134137.2114847-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTZxjG851zes6hpnAobHxjGJFFic6BNSz7jKCyuOVMXNRdMmFLsIGz
	ygaFtYLbNBsIlMsKkxVYrJbb5CIRmFwqVC4ZFCpjwICBZQNEw60ULVejc5FRDm7+93ve93m/
	532Tj8bF1aQ7HSE/zSnk0kgvUkjoOx73vlYqPCrbPXltN7p1uwhDdU+0FLrW1IOhfGOPAI31
	12LojxUbiSonf6fQTFMCgYbKdBRK7KgikUU7RqIF9ZgADRguk2gpwwiQfimJRBXGUQpVreRj
	qHChjkBX6g0AqdJKBKjv17eQZUCNI5XWCa021lPo6dB1Al160EKh2rksATJVfISSWrKJg5tZ
	mzmZYucsFoJtS12m2KaHBQTboB2lWHXDb4CtLk8j2ZGhRpLN6zzO3vnOhLE1V75lkyo6MNbW
	PEiymbXlgO1PvE2xNV1njzmHCP3DuciIOE7hu/+k8NTcXxpBzEX45dXVaUE8eOySDhxoyPjB
	G20pWDoQ0mKmDECV8QLJi2UA8yaSN8QSgOd1d8lnIzMZowK+UQrgdG87xYu5NfGggbK7SGYP
	HC/NX3e5MlYcmleG19/CmWkA9ROX1wRNuzChcKQP2QcIZhtMuN+G21nEHICaJ8M4H7cFtvzS
	vc4OzEFozUkX8B5n2HlxgrAzvuZJrLuE29+HTLEQpsxrCX74EMybslI8u8BZU+0Ge8AujXrD
	Ew3H6xY3ws7BBrVpg/fBkZ6/1/fEmR2wyuDLlwNh9/cDmL0MGUdovu/Mr+AIf9D/iPNlEUxV
	iXn3dpijzvgvtKdMj/HMwqo7DeAC2Kp97hjtc8do/88tAHg5cONilVEyTimRc2d8lNIoZaxc
	5hMWHVUN1r5111PTYj3QzS74tAKMBq0A0riXq6i0KkgmFoVLv/qaU0SHKmIjOWUreJkmvNxE
	28K3cGJGJj3Nfc5xMZziWRejHdzjsa0l9ErzVPBeTzyiaVDmZ/buWz7cUQwkFmfh3ojscIsR
	Sx4bzCqyxaTqg47uElbuFO9iNscz71+nvjhUzD26keu90viO5qfFb4JD5o980P3q/Op7MCtL
	/WF83DnLWVl/pSh4v9M/V41Li+M5ryso0myajNyz6e6B5pa3zwe046JPA8Lu6QL+tDk4eX+W
	e0Iip/0Kgtp9U7Je8bD6F4Ub3I94Fr5ofeT6QljKJl3g1PLsjqnUNDdD93xIEHRUTXr0fvJz
	YM3NhMXg46Djlj/mf6ZQAl76+N3hsdz5kDdPusY9zHSZGddr9g3dC02nOyeydZ2ZA/Jl7zfA
	4RLPm1aVsvCEF6E8JZXsxBVK6b+K2htPRQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsVy+t/xe7rLufzTDeZcFLQ4cX0Rk8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFlc+fqezWLd0wvsFi/2NrJYXFsxl92i+dh6NouXs+6xWXzsucdq
	cXnXHDaLz71HGC22fW5hs1h75C67xfqv85ksFn7cymKxZMcuRou2zmWsFhdPuVq8vNzDbNE2
	i9/i/54d7Bb/rm1ksZj9bj+7xZY3E1ktjq8Nt2jZP4XFQdbj/Y1Wdo83L1+yeBzu+MLusffb
	AhaPnbPusnv07DzD6LFpVSebx51re9g85p0M9LjffZzJY/OSeo+WtceYPN7vu8rm0bdlFaPH
	pebr7B6bT1cHCEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSW
	pRbp2yXoZby5PZm1YKZExcr/z1kbGH8KdzFyckgImEi86L3L2sXIxSEksJRRom/XTHaIhIzE
	te6XLBC2sMSfa11sEEWvGCVaWn+zgiTYBIwkHiyfD9YtItDJIvF281pGEIdZ4C2jxPWZG8Ha
	hQViJRZe38oMYrMIqEo0vj0MZvMK2EtM/n2TGWKFvMT+g2fBbE4BB4nXU7vANggB1ez4e5gV
	ol5Q4uTMJ2AzmYHqm7fOZp7AKDALSWoWktQCRqZVjCKppcW56bnFRnrFibnFpXnpesn5uZsY
	gYll27GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRHe5eu904V4UxIrq1KL8uOLSnNSiw8xmgLdPZFZ
	SjQ5H5ja8kriDc0MTA1NzCwNTC3NjJXEedmunE8TEkhPLEnNTk0tSC2C6WPi4JRqYLIOVjlb
	9v606exyy4MTbvH+X8/zVXKnbXLVvg2p6ur5Qle6mz6VBdR87A86y880i/tdSYlXitKGpj2/
	bT0F1myIS/y55muOaU99uV2oPoNtYKv0TYYJ0/eH9f1ld51lvuCU+M9t62SCZzEa5N6+FTXn
	tFfng683UgUmXLE65nU3jL/lIfM3DZXE8wyS2sfLu3iibuceNbS/M1fvyu7DfgzzZ+epbA2r
	teW0yPmf9PTnycY8YxHtUJb/0pKiur3fvTbvK7RysDBdp3JhesM9KzuDnT5mSivWdU4pND63
	Un/Kyk277mzUPmuk+SdgqVgYe8xC6Uem/l0bdy9xdy2c3Za50UZbdtPmNNUM5SfnlViKMxIN
	tZiLihMB3TtOWLUDAAA=
X-CMS-MailID: 20241203134159eucas1p1eafefef0dfe7f2b6343a639733012bcf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241203134159eucas1p1eafefef0dfe7f2b6343a639733012bcf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241203134159eucas1p1eafefef0dfe7f2b6343a639733012bcf
References: <20241203134137.2114847-1-m.wilczynski@samsung.com>
	<CGME20241203134159eucas1p1eafefef0dfe7f2b6343a639733012bcf@eucas1p1.samsung.com>

Add power domain support to the Thead TH1520 clock controller bindings.
This enables devices to specify their power domain dependencies,
improving power management for components like the GPU.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 .../bindings/power/thead,th1520-power.yaml    | 52 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/thead,th1520-power.yaml

diff --git a/Documentation/devicetree/bindings/power/thead,th1520-power.yaml b/Documentation/devicetree/bindings/power/thead,th1520-power.yaml
new file mode 100644
index 000000000000..528af54f4ca6
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/thead,th1520-power.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/thead,th1520-power.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-HEAD TH1520 Power Domain Controller
+
+maintainers:
+  - Michal Wilczynski <m.wilczynski@samsung.com>
+
+description: |
+  The T-HEAD TH1520 SoC includes a power domain controller responsible for
+  managing the power states of various hardware domains such as the GPU.
+
+  This binding describes the power domain controller node, which can be used by
+  devices to manage their power domains.
+
+properties:
+  compatible:
+    const: "thead,th1520-pd"
+
+  thead,vosys-regmap:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      Phandle to a syscon node representing the shared register space of the VO (Video Output) subsystem.
+      This register space includes both clock control registers and other control registers used for
+      operations like resetting the GPU. Since these registers reside in the same address space,
+      access to them is coordinated through a shared syscon regmap provided by the specified syscon node.
+
+  '#power-domain-cells':
+    const: 1
+
+required:
+  - compatible
+  - thead,vosys-regmap
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    vosys_regmap: vosys@ffef528000 {
+        compatible = "syscon";
+        reg = <0xff 0xef528000 0x0 0x1000>;
+    };
+
+    power-controller {
+        compatible = "thead,th1520-pd";
+        thead,vosys-regmap = <&vosys_regmap>;
+        #power-domain-cells = <1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 16fb58aa74b1..acbe311087ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20187,6 +20187,7 @@ F:	Documentation/devicetree/bindings/clock/thead,th1520-clk.yaml
 F:	Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
 F:	Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
 F:	Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
+F:	Documentation/devicetree/bindings/power/thead,th1520-power.yaml
 F:	arch/riscv/boot/dts/thead/
 F:	drivers/clk/thead/
 F:	drivers/mailbox/mailbox-th1520.c
-- 
2.34.1



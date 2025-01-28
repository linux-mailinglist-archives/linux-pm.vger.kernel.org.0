Return-Path: <linux-pm+bounces-21049-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34719A2127E
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 20:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE991884DDC
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 19:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510771EEA5C;
	Tue, 28 Jan 2025 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qS5DRe38"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CBA1E47A5
	for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2025 19:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738093716; cv=none; b=SSbbc3pMlKvE0Aw7ixQHRLqUqV8exj3hfD3lWsI9zyqeFmFqRSsdFJ2AieknIWmONQ0XSod6dTCZLtA5Q6l/0CiY06TK4Ar1BIadtm9gmdlW4Lm7XoiQiLvEZdyvMh6E9B+m2aX+rK6DAEVFjOyfb0W291tTWshoLnR/lgNj+RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738093716; c=relaxed/simple;
	bh=7GvnlKY7IY0TpKvnw6W6I+xX8PTHAMeuZ2PxASoDe1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=ibat8dBzMXv02vvwjUFic2DWpqdYIm3HOLtY5HIojevUwSck2n9E/vw7VSfRcJ4q6fb9EIOlg4cN79UoFHOvD4SqXHp88NJGRkEwH5rlEjbOH7xbbf3dSyTaDAVs9dv+FR4xdf/wEg3Ck9Ionzi7QoeeyUE97GRPNyZcBMq2FDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qS5DRe38; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250128194830euoutp02f587d49e097105111fdc0e4d1900f8b6~e8wVmWbgM0761907619euoutp02H
	for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2025 19:48:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250128194830euoutp02f587d49e097105111fdc0e4d1900f8b6~e8wVmWbgM0761907619euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738093710;
	bh=UZmLNHwkp5An2gfrKXyP2UO7KRHVPMtn3l7qtY0FnQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qS5DRe38FnTZgOWJ9m/8ctj23/2TNqDeX74zn9iGGmmEsp9DOSbQQjV9iOXqR0UlG
	 RQsiN6NLdDPC1/N0P2MdXfLdWxcXuuJbxug0xCcpXJkyq6UN8ceI9kp8MpwGHwqO6o
	 HW0lidiTgmPcZeKj6qGRy93zCQLTaAGLVhpJiqC0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250128194830eucas1p19e60d5d1c749080edcc60c746d65ca25~e8wU9agvz1989019890eucas1p1n;
	Tue, 28 Jan 2025 19:48:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id F5.A2.20397.D8439976; Tue, 28
	Jan 2025 19:48:29 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250128194829eucas1p279fb146417854b28366378793087694a~e8wUHvrau2286822868eucas1p2E;
	Tue, 28 Jan 2025 19:48:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250128194829eusmtrp23ababadc0aa08aba01aa8daedab8f098~e8wUG9bs_3008430084eusmtrp2W;
	Tue, 28 Jan 2025 19:48:29 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-cb-6799348d6ff9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 52.E0.19920.C8439976; Tue, 28
	Jan 2025 19:48:28 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250128194827eusmtip138f2cc589f7df90985241c3815b21534~e8wSu4kgR0819608196eusmtip1J;
	Tue, 28 Jan 2025 19:48:27 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com,
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	ulf.hansson@linaro.org, jszhang@kernel.org, p.zabel@pengutronix.de,
	m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, Michal Wilczynski
	<m.wilczynski@samsung.com>
Subject: [PATCH v4 03/18] dt-bindings: firmware: thead,th1520: Add support
 for firmware node
Date: Tue, 28 Jan 2025 20:48:01 +0100
Message-Id: <20250128194816.2185326-4-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128194816.2185326-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGd+69vffSrXotRM/YdIGBKTMUcARPsgUlaLwuS9T9s2xGoNFr
	ISsfa2HI3IYMyhCBuUYUykdZ12nDBFIolRKxsTJAlPLhQBalYARKCeNDrJsoMErr5n+/53nf
	c573PTk0LrxK+tNJKemcPEUiCyT5hKnjmS20OLJcGr6yGoW67mkx1PxcTaErbTYMadptPGQf
	MGLoD9ccieon+ig01ZZDoCF9FYVyOxpI5FTbSbRQZOehu62VJFosbgfItJhHorr2EQo1uDQY
	+nmhmUC6llaA8s9c4qH+7n1oxN5FIOfdIhzlqzei1WstFFoZMhCoYtZCIePMTzzUWfcpyrOc
	J/ZsY+eGlRQ743QS7M2CJxTb9rSGYM3qEYotMt8BbGPtGZJ9MHSNZKtvHWZHz3ZibJMum82r
	68DYH5fD2bnrgyRbYqwF7EDuPeqQ8HP+h8c5WdJXnDwsOoGfWOPqINMcm09OWFvAaTApLAQ+
	NGQiYYFjEi8EfFrI6AE0WQu94gmA1Sol5RGLADZcMJAvj/SaR7yFywD+M16GecQMgBX1Ksrd
	RTI74dhlDc9d8GOUBFT+ngPcAmccaynjlet3+TJx0KFrwNxMMMHQaleu+TQtYHbD0amtnrh3
	oOVGD+5mH2YPbFzWE24WMJvgrfLxdcbXenKbK9YHh4yBD00TS5jn8F5Y3dTlZV843WmkPPw2
	XDVrvH4qHGt+jHv4G2gu6vTyB/CBbWl9HpwJgQ2tYR47Bqp671NuGzIb4PBfmzwjbIAq00Xc
	YwtgQb73fbfD0qLi/0JtepM3lIUFTcW8cyBA/coy6leWUf+fWwPwWrCFy1AkSznF+ylcplgh
	SVZkpEjFx1KTG8Ha37690ulqAfrpBbEVYDSwAkjjgX6Co7YyqVBwXJL1NSdPjZdnyDiFFbxF
	E4FbBFqLUipkpJJ07guOS+PkL6sY7eN/Gruk+4Q29517HlFQefPU0n1UFjJ/1H5qav5G1Yni
	0vnEN198tPrL/je2kYLY2Jhs/8K/H+2IjhIuZsrlIKn5qvNjlTCoJvS1XZs3Pi7UH0m1zB6O
	qRLZStO+z37YO3ww+E8jr/v2Z1fKmF8jOBCp1QSMXeftp7VqR2RYvL6Jl1kTGRwkmwuaFpUd
	ELUdTNv7ZdS+Y/p3e7Jazhqe1gu+dQaUhN05eTFCNuv7g9EgW46eKc+LS48fDH496/xgd+hv
	hx7tyhlcGEo4sDNjJee7Ha7dowM9D1+E+NTPzGeLSjIsz8LjJhsFfQn9tdpV2ag+S6TsES+K
	lQid6PXzc8Ru36o70h9IKBIlEe/hcoXkXx5ox0RKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsVy+t/xu7o9JjPTDS6/tLY4cX0Rk8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFlc+fqezWLd0wvsFi/2NrJYXFsxl92i+dh6NouXs+6xWXzsucdq
	cXnXHDaLz71HGC22fW5hs1h75C67xfqv85ksFn7cymKxZMcuRou2zmWsFhdPuVrcvXeCxeLl
	5R5mi7ZZ/Bb/9+xgt/h3bSOLxex3+9kttryZyGpxfG24Rcv+KSwOch7vb7Sye7x5+ZLF43DH
	F3aPvd8WsHjsnHWX3aNn5xlGj02rOtk87lzbw+Yx72Sgx/3u40wem5fUe7SsPcbk0f/XwOP9
	vqtsHn1bVjF6XGq+zh4gFKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
	k5Kak1mWWqRvl6CXseDrMbaC52IVTw/tYGxgfCbUxcjJISFgInF+5132LkYuDiGBpYwSpxbN
	YYNIyEhc637JAmELS/y51sUGUfSKUeLH/oOMIAk2ASOJB8vns4LYIgKLWST27qsEKWIWeMso
	cX3mRrBuYYEYid/7X4FNZRFQlTh0rxXI5uDgFbCXuP9CFmKBvMT+g2eZQWxOAQeJTX9XgLUK
	AZU8ejsDrJVXQFDi5MwnYHFmoPrmrbOZJzAKzEKSmoUktYCRaRWjSGppcW56brGhXnFibnFp
	Xrpecn7uJkZgetl27OfmHYzzXn3UO8TIxMF4iFGCg1lJhDf23Ix0Id6UxMqq1KL8+KLSnNTi
	Q4ymQGdPZJYSTc4HJri8knhDMwNTQxMzSwNTSzNjJXFet8vn04QE0hNLUrNTUwtSi2D6mDg4
	pRqYhAwn61f6dzW4qqp8k7cqXyPwZ/uuJVdubfyw2MZMS53717R9Wy5xdF+vynp8aZrQFBU/
	U3YrA0PbY8veGs057S1ndcQ7ISWLW2rel8Vy0bXHGW50Zu4+E/xd48fZFONjyr0r/9vU8923
	+R07daX9n8XW4h3hDCyiUadrHJdOn5q+dFq/ZaKmsmwgm1SS2UZGT/Hb11gz71yOFL0jdWiT
	ZaKZ/rk66T1POnMZPviGR946sHyCnr0X84LkAlOHKaLxv8+zfHkQ8ue01onSZxwGTGqRUdyt
	6iURd10nNvH1dYutPWdeeffExT023m2aO15taVple/fk+qWTevzlrDprA5bfWd56ctv27Vo9
	nyYpsRRnJBpqMRcVJwIAC3U0PbgDAAA=
X-CMS-MailID: 20250128194829eucas1p279fb146417854b28366378793087694a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250128194829eucas1p279fb146417854b28366378793087694a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250128194829eucas1p279fb146417854b28366378793087694a
References: <20250128194816.2185326-1-m.wilczynski@samsung.com>
	<CGME20250128194829eucas1p279fb146417854b28366378793087694a@eucas1p2.samsung.com>

The kernel communicates with the E902 core through the mailbox
transport using AON firmware protocol. Add dt-bindings to document it
the dt node.

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
index d49306cc17e3..002eaae363aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20340,6 +20340,7 @@ L:	linux-riscv@lists.infradead.org
 S:	Maintained
 T:	git https://github.com/pdp7/linux.git
 F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
+F:	Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
 F:	Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
 F:	Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
 F:	Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
-- 
2.34.1



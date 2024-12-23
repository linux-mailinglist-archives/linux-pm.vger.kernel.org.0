Return-Path: <linux-pm+bounces-19667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80919FAE7D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 13:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F391883ACC
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 12:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF6F1B2191;
	Mon, 23 Dec 2024 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KYeaQ5/3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750471AF0A4
	for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2024 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734958578; cv=none; b=Wmf9C3WkA9JMLfLdMC3zPneTZwBth6sZZtqyIro06h6jeMo70h6c6J/dercfsPLV9nI2Tb4A8iMlCWLENkR7wNQZeHNbIPqcxrJvPAm1aCnYl+h7GxEy8VTIB2Y3yVcU1UP1R7drLgifQF5vSfH48RzjVsAprz7BmFB9+6BN0Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734958578; c=relaxed/simple;
	bh=OWhboeYcll83oIwY1jTl97x/CdBVkL122juGkap11q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=lPYinUvIb9wschpRCGYmp7gQTmdyWGRwcGdq00U86X4yLWhhBzVUs/WWmFBEr8U+P35Y6WngAXAs6dXrN4FPGk91jKNkB28bSqX4oyXScMGlICRuaCriDfp8qcyiDwhUayFUjqA3QuO3VaVDCo2FaC/jwhdE3o6ywz9wxbUwn7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KYeaQ5/3; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241223125607euoutp012683fbffb6a67deadfb963cd559e7316~Tz5-poI9f3222032220euoutp01u
	for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2024 12:56:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241223125607euoutp012683fbffb6a67deadfb963cd559e7316~Tz5-poI9f3222032220euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1734958567;
	bh=D4lM7B2/iCVC4CscVm8P3ZR/5UI7jNuFSCiGUYsAspU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KYeaQ5/3ppxRmdQyZRdNCrSPfMsuRVX30zae/cVP3ui25RllMkxdrz9liaIKaBQNl
	 rG7brqlkklvvB5kZkaz1n+UC605ASjNn6QztHyU68dGQZ0lH1pEJge9YDVGe+8RMBZ
	 JlZ0fRksus9RGD3Ac1vATiKjs32ls10X0Lrv8DuE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241223125606eucas1p1c1a3bca8f01da71f2baab6b44eb05e56~Tz5-IsJvX1135011350eucas1p16;
	Mon, 23 Dec 2024 12:56:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 7A.0C.20409.6ED59676; Mon, 23
	Dec 2024 12:56:06 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241223125606eucas1p10ca3adc99322ff33d617a227733e5e67~Tz5_rew5o1525815258eucas1p1m;
	Mon, 23 Dec 2024 12:56:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241223125606eusmtrp10692a7863b89f024a243127ad297fe96~Tz5_qfvvC2051220512eusmtrp1O;
	Mon, 23 Dec 2024 12:56:06 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-c5-67695de685ba
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 38.73.19654.5ED59676; Mon, 23
	Dec 2024 12:56:05 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241223125604eusmtip2399344dbdd237bafb93583527f56654c~Tz59OUaFT1804418044eusmtip2R;
	Mon, 23 Dec 2024 12:56:04 +0000 (GMT)
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
Subject: [RFC PATCH v2 04/19] dt-bindings: firmware: thead,th1520: Add
 support for firmware node
Date: Mon, 23 Dec 2024 13:55:38 +0100
Message-Id: <20241223125553.3527812-5-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241223125553.3527812-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0xTZxjmO+f0nLah7FjI+MIWRBy6S4ZC/PGZza0Mxs6SuWjMpjNOV8YR
	CbeuBcaIRpBLoFaYTEdoUXBjXEqRKG0D1YItjAIq46LAhBbZ1AnWcZUxZ9lsT7f57/ne53nf
	53nffHxcbCCD+Imp6aw8VZocSgoJY/ef/a/f+zQxYfM9TSjqGf0OQ4a/1BTSmfsxVNXVz0OO
	IT2GbjyaJdH5uwMUum/OJdBI/RkK5XU3k2ha7SDRvMrBQ8OmShItnugCyLiYT6KmLjuFmh9V
	YejcvIFANa0mgAqLa3losO9dZHf0EGh6WIWjQvVz6O/LrRRaHblAIM3vHRTSO0/ykK1pN8rv
	OEVIgpnZsQKKcU5PE0xn0RLFmJerCaZNbacYVds1wFzUFpPMxMhlkjnbu5OZPG7DmJaao0x+
	UzfGlLo2M7PtN0mmRK8FzFDeKLVDvFf4ZjybnJjJyje99Znw0OnBTkxmhFmV89UgB/T5KwGf
	D+kt8Ho9UAIhX0zXA5hTbMe4xxKA41OFXmYRwKKFckIJBJ6OFV0X6cZiug7AXy3JnMgJYP6p
	KY+IpCPh7boqnpsIoAsIWPBjrmcUTv8GoPFOpafdn46DFlcD4Q5C0GFwzhriLovot2FzawPg
	3NbCDst13I0FtATqlGOA06yBvRV3PGb4U02eQYO750O6QQgnlye8zTFwVFWKcdgfztj0FIdf
	hFe/UXnXSYO3DQs4hw/DNpXNi9+AE/2PSXc2nH4FNps2ceUouGo6hnG384NjD9dwEfxgmbEc
	58oiWFQo5tQb4GnVif9M++uN3jAMdJmc+NdgnfqZZdTPLKP+37ca4FoQyGYoUhJYRWQq+2W4
	QpqiyEhNCP88LeUiePqzr67allpB3cx8uBVgfGAFkI+HBois4sQEsShe+lU2K087IM9IZhVW
	8AKfCA0UhcWvZcV0gjSdTWJZGSv/l8X4gqAc7HtR/Gx25DH6QlzJteEQycjUesx3cPmT4MmV
	kQ9e+lD7cLxFz9P4+HS7jktNHY2ydxYUjUk73pux+pllQeO8gNRdMcaY6LuuAwLrvufTjSXB
	Tz7ec4u3kFse7jtmyRo8su/gL5JOsSbW9yfT+Lfbbq1Mxn2htZTJP4oz/HB0dmvYwKWTEVf2
	yiJ2wv3jkdt8/tCZJO1zTQ51hU66cXdIfeBcFHlEubQ9nTkbXVNoe3xYEJW5XW9u2VUu7D3o
	jJ/OXL81K3bgwf3SWlVjsDDRFJu9euPnda6MK9qbFUFJC9HyBy/vL4ldfq3HMLTBvvH8+0V7
	qLw+oj1py0yt9knZpbSW6NxQQnFIGvEqLldI/wH9qAJLSAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsVy+t/xe7rPYjPTDdYbW5y4vojJYuvvWewW
	a/aeY7KYf+Qcq8W9S1uYLK58fc9mse7pBXaLF3sbWSyurZjLbtF8bD2bxctZ99gsPvbcY7W4
	vGsOm8Xn3iOMFts+t7BZrD1yl91i/df5TBYLP25lsViyYxejRVvnMlaLi6dcLe7eO8Fi8fJy
	D7NF2yx+i/97drBb/Lu2kcVi9rv97BZb3kxktTi+NtyiZf8UFgc5j/c3Wtk93rx8yeJxuOML
	u8febwtYPHbOusvu0bPzDKPHplWdbB53ru1h85h3MtDjfvdxJo/NS+o9WtYeY/Lo/2vg8X7f
	VTaPvi2rGD0uNV9nDxCK0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
	Sc3JLEst0rdL0MuYevEwU8E2iYo5HxcwNjCeEu5i5OSQEDCR+LHmCFsXIxeHkMBSRon/3+4y
	QSRkJK51v2SBsIUl/lzrgip6xSixu7sDrIhNwEjiwfL5rCC2iMBiFom9+ypBipgF3jJKXJ+5
	EaxbWCBBYnLjMyCbg4NFQFXiwyEFkDCvgL3E+h0rGSEWyEvsP3iWGcTmFHCQWNN1AywuBFTz
	79QHNoh6QYmTM5+AjWQGqm/eOpt5AqPALCSpWUhSCxiZVjGKpJYW56bnFhvpFSfmFpfmpesl
	5+duYgQml23Hfm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeA8JZaYL8aYkVlalFuXHF5XmpBYfYjQF
	Onsis5Rocj4wveWVxBuaGZgamphZGphamhkrifOyXTmfJiSQnliSmp2aWpBaBNPHxMEp1cA0
	9ctxV9/vBdE2q91ZtJza/xgHr/x5brb4GWt1w8mL/z9gSRKqWa3RpHLmHHNA6LSZM5tMRA7v
	CY2ezRmySPSNqLG/auY05o4jXB6ncuZyTuZ8JrFiZuJ933n1Rkuy1T+aSr0uCv154Gzt1NTa
	hsrWpKU8M2c7b7hVy2r5amXTKtZzqztqE87v+3rpSYNoAU/EhhyrB3X8P5i9/Hpfe1yWfKF4
	OMI4TWTbTdmW1JXOq5+1Xt13Yo/yhiD73K4Vxzd9l/fjcCqSeyCXvDNG3ajCpXRJT/3rAAlN
	pbISmXa9lcq3q57yeF9vTnUNb4gQnn6oKb3Lbk+KyYcHAR+vVmlfCwn1jT7CZmL+70lyuRJL
	cUaioRZzUXEiAIXen9a3AwAA
X-CMS-MailID: 20241223125606eucas1p10ca3adc99322ff33d617a227733e5e67
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241223125606eucas1p10ca3adc99322ff33d617a227733e5e67
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241223125606eucas1p10ca3adc99322ff33d617a227733e5e67
References: <20241223125553.3527812-1-m.wilczynski@samsung.com>
	<CGME20241223125606eucas1p10ca3adc99322ff33d617a227733e5e67@eucas1p1.samsung.com>

The kernel communicates with the E902 core through the mailbox
transport using AON firmware protocol. Add dt-bindings to document it
the dt node.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 .../bindings/firmware/thead,th1520-aon.yaml   | 59 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml

diff --git a/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
new file mode 100644
index 000000000000..ca4c276766a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/thead,th1520-aon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-HEAD TH1520 AON (Always-On) Firmware Node
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
+  power-domain:
+    $ref: /schemas/power/thead,th1520-power.yaml#
+    description: Subnode representing the hardware power domain of the AON subsystem.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - mboxes
+  - mbox-names
+
+examples:
+  - |
+    firmware {
+        aon: aon {
+            compatible = "thead,th1520-aon";
+            mboxes = <&mbox_910t 1>;
+            mbox-names = "aon";
+
+            pd: power-domain {
+                compatible = "thead,th1520-pd";
+                #power-domain-cells = <1>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index c0e9639ac210..7705d1b6dd7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20188,6 +20188,7 @@ M:	Fu Wei <wefu@redhat.com>
 L:	linux-riscv@lists.infradead.org
 S:	Maintained
 T:	git https://github.com/pdp7/linux.git
+F:	Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
 F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
 F:	Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
 F:	Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
-- 
2.34.1



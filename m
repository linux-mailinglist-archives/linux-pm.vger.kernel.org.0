Return-Path: <linux-pm+bounces-24995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B6CA8210E
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 11:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 675E27AB2B4
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 09:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8AB25D52D;
	Wed,  9 Apr 2025 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Bnkei+oO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A98424501C
	for <linux-pm@vger.kernel.org>; Wed,  9 Apr 2025 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744191042; cv=none; b=D5TlfBSs7bxTQB6S5QeBJKnEzLGZOY18M7Vp0bS6YPVHJj+zoiIAEeMzQczwu+OzqbDnnWxQ4Gx6yZaz8OEqamb9ICLC15EI5kuBisAk9PYLgH8qe5PwFJAsZ7N7Ed33nYoRavtNclOjE5sGJ/PjryiJdcIBzkUlROjx3wgo0ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744191042; c=relaxed/simple;
	bh=Mf+28q3WmUD8VBP45a+nQHuOyBG9+NNtyiwZR1QcA6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=uHSQ2tMaRi5IiJ/Keochhli1AUPShDsXkL0Q6atB7yni+1fg2/X4XWnDPIK8JBR5CKT1uYFhjJDkugPqAxn5PsM7Z5xhrR7ZPjPYaZIXVilJwTDdINSh4raqpdYO+wxoKqogKzBP3EeDEw9aaCs3iD/16ztGCXQSoQUDpTtnf48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Bnkei+oO; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250409093032euoutp01cd36e7b02d739e841840874ab71eb022~0nIC1Z36d0307603076euoutp01B
	for <linux-pm@vger.kernel.org>; Wed,  9 Apr 2025 09:30:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250409093032euoutp01cd36e7b02d739e841840874ab71eb022~0nIC1Z36d0307603076euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744191032;
	bh=84CX4mPXzhvt6jZ4xCM8idWzEtVXSfS2MtWhIx9Nzwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bnkei+oOUdKNoH4sf7uyHS5UDX8gUv6gxzUIGBW3XFJqL7U1xzfgTEfB5JPedI58m
	 SHASIwzAO8BhToaqNFhssstWYYyaKQkoz9ANRmPSocnXaSkaWorBmgPoYfrqL66oym
	 OrcpgM8TJle6QaeH9tk8LtuY1C1q7djqwM4s/QZQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250409093031eucas1p2961ba97b62454ce4bb51d6663bcd5428~0nICglOsS0998709987eucas1p2W;
	Wed,  9 Apr 2025 09:30:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 48.4A.20397.73E36F76; Wed,  9
	Apr 2025 10:30:31 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250409093031eucas1p2222e9dc4d354e9b66b7183922c0fb3cf~0nIByCFsf1023010230eucas1p2R;
	Wed,  9 Apr 2025 09:30:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250409093031eusmtrp1c091b027f744040d7f056718b50f2a0b~0nIBxXYi_1346513465eusmtrp10;
	Wed,  9 Apr 2025 09:30:31 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-ef-67f63e3727a4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id C4.35.19920.73E36F76; Wed,  9
	Apr 2025 10:30:31 +0100 (BST)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250409093030eusmtip2d8cd87a82f5916eb2fc3e94379087b87~0nIBHVz3h2948829488eusmtip2F;
	Wed,  9 Apr 2025 09:30:30 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, ulf.hansson@linaro.org,
	p.zabel@pengutronix.de, m.szyprowski@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v1 1/2] dt-bindings: firmware: thead,th1520: Add clocks and
 resets
Date: Wed,  9 Apr 2025 11:30:24 +0200
Message-Id: <20250409093025.2917087-2-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409093025.2917087-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7djPc7rmdt/SDaZ3mlus2XuOyeLepS1M
	Fi/2NrJYvJx1j83i8q45bBafe48wWmz73MJmsfbIXXaL9V/nM1ncvXeCxeL/nh3sFsfXhlu0
	7J/C4sDrsWlVJ5vHnWt72Dw2L6n3aFl7jMmj/6+Bx/t9V9k8+rasYvT4vEkugCOKyyYlNSez
	LLVI3y6BK+PU2W72ggUiFbM+XWVvYDzE38XIwSEhYCJx9YFHFyMXh5DACkaJ3vn7WbsYOYGc
	L4wSbRv4IRKfGSV2zGtmA0mANHz73M4OkVjOKLHk9TQo5w2jxOPFi9lBqtgEjCQeLJ/PCpIQ
	EdjLKNF56gMziMMs0M0osXbbDVaQ5cICIRJPPvKCNLAIqEqcWXMWbAWvgL3EpVkTWCDWyUvs
	P3iWGcTmFHCQONRzgh2iRlDi5MwnYDXMQDXNW2eDzZcQ+MIhMWHZNyaIZheJeZPuskLYwhKv
	jm9hh7BlJE5P7oFakC/xYOsnZgi7RmJnz3Eo21rizrlfbCB3MgtoSqzfpQ8RdpTofL2JFRJ2
	fBI33gpCnMAnMWnbdGaIMK9ER5sQRLWaxNSeXril51ZsgzrMQ2LDt5esExgVZyF5ZhaSZ2Yh
	7F3AyLyKUTy1tDg3PbXYOC+1XK84Mbe4NC9dLzk/dxMjMHmd/nf86w7GFa8+6h1iZOJgPMQo
	wcGsJML7duKXdCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8i/a3pgsJpCeWpGanphakFsFkmTg4
	pRqYJL5PlVP4cv2imNf5YObiyza+sTxsxi3CZ/wk1fcJrUlZXXdvrlqrfaRdLGdLQMuz2JS+
	l83e8edf1V7vtrLptDnMxtfGfj/DaPqzjTPiGmr9C1XudRjVFqxnPhI3obHs1v0febrzpgmf
	kbi4pDpeO8vBMtjsJWf9O745/Iu9PNpkmP8rZ/zKTGd0MLp9uzH6hKVBruPdpdskpssKRK54
	p9y6dseNypmGhx9/m9ZcN8er8Pcv26f6RyzF1nJtf1Q7dc8m5xTnwrlCezU3f1edq9Pf+Nt1
	4s2lqrM25jMLqv4JnybW8OprgqRn9OpjXud0f3/59OYyZ9H9n+2hvx5Pie68dJiRr2XLYoZY
	08dKLMUZiYZazEXFiQBQW9lezQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xe7rmdt/SDRZcYbNYs/cck8W9S1uY
	LF7sbWSxeDnrHpvF5V1z2Cw+9x5htNj2uYXNYu2Ru+wW67/OZ7K4e+8Ei8X/PTvYLY6vDbdo
	2T+FxYHXY9OqTjaPO9f2sHlsXlLv0bL2GJNH/18Dj/f7rrJ59G1ZxejxeZNcAEeUnk1RfmlJ
	qkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsaps93sBQtEKmZ9
	usrewHiIv4uRk0NCwETi2+d29i5GLg4hgaWMEief/2WGSMhIXOt+yQJhC0v8udbFBlH0ilHi
	yLOljCAJNgEjiQfL57OC2CICJxkl7r6qAyliFuhnlJj68QpYQlggSOLChSNgU1kEVCXOrDnL
	BmLzCthLXJo1AWqDvMT+g2fBajgFHCQO9ZxgB7GFQGrerGGCqBeUODnzCVg9M1B989bZzBMY
	BWYhSc1CklrAyLSKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMNa2Hfu5eQfjvFcf9Q4xMnEw
	HmKU4GBWEuF9O/FLuhBvSmJlVWpRfnxRaU5q8SFGU6C7JzJLiSbnA6M9ryTe0MzA1NDEzNLA
	1NLMWEmc1+3y+TQhgfTEktTs1NSC1CKYPiYOTqkGJi+V5I18Wgbr9x7VnnjP76C24QaFa99T
	Rebdz+fKa3XQW7jd76vGM8XeLSX66zcfil7smzzzw7+lX3fMll1RPftlj+xXmZiwDccaVmWw
	TJ27SFd1143Ppx7fqintKHjLK+M8IfQZw63+DS/Levjn8sdfv3eedy+rZolP658bhXnbIjU+
	5tvclHcrFdWWMvsgd8s/+qUXb2HJyhnsm1ZFiFzdYnHa9503n9yGUsPbK3ovimyWOGRvlNQd
	afVBevnGyTc+L5seor2je7FAcPqxmbOvHcxjXXX6xaKsHJtlRhc0slWqLaWv12jI7+zwqXwQ
	O02Iz3CHro5frun+TJE76QlHrNcvKP7//bDb2YqG70osxRmJhlrMRcWJAPkESq8+AwAA
X-CMS-MailID: 20250409093031eucas1p2222e9dc4d354e9b66b7183922c0fb3cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250409093031eucas1p2222e9dc4d354e9b66b7183922c0fb3cf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250409093031eucas1p2222e9dc4d354e9b66b7183922c0fb3cf
References: <20250409093025.2917087-1-m.wilczynski@samsung.com>
	<CGME20250409093031eucas1p2222e9dc4d354e9b66b7183922c0fb3cf@eucas1p2.samsung.com>

Prepare for handling GPU clock and reset sequencing through a generic
power domain by adding clock and reset properties to the TH1520 AON
firmware bindings.

The T-HEAD TH1520 GPU requires coordinated management of two clocks
(core and sys) and two resets (GPU and GPU CLKGEN). Due to SoC-specific
requirements, the CLKGEN reset must be carefully managed alongside clock
enables to ensure proper GPU operation, as discussed on the mailing list
[1].

Since the coordination is now handled through a power domain, only the
programmable clocks (core and sys) are exposed. The GPU MEM clock is
ignored, as it is not controllable on the TH1520 SoC.

This approach follows upstream maintainers' recommendations [1] to
avoid SoC-specific details leaking into the GPU driver or clock/reset
frameworks directly.

[1] - https://lore.kernel.org/all/38d9650fc11a674c8b689d6bab937acf@kernel.org/

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 .../bindings/firmware/thead,th1520-aon.yaml   | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
index bbc183200400..8075874bcd6b 100644
--- a/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
+++ b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
@@ -25,6 +25,16 @@ properties:
   compatible:
     const: thead,th1520-aon
 
+  clocks:
+    items:
+      - description: GPU core clock
+      - description: GPU sys clock
+
+  clock-names:
+    items:
+      - const: gpu-core
+      - const: gpu-sys
+
   mboxes:
     maxItems: 1
 
@@ -32,13 +42,27 @@ properties:
     items:
       - const: aon
 
+  resets:
+    items:
+      - description: GPU reset
+      - description: GPU CLKGEN reset
+
+  reset-names:
+    items:
+      - const: gpu
+      - const: gpu-clkgen
+
   "#power-domain-cells":
     const: 1
 
 required:
   - compatible
+  - clocks
+  - clock-names
   - mboxes
   - mbox-names
+  - resets
+  - reset-names
   - "#power-domain-cells"
 
 additionalProperties: false
@@ -47,7 +71,11 @@ examples:
   - |
     aon: aon {
         compatible = "thead,th1520-aon";
+        clocks = <&clk_vo 0>, <&clk_vo 1>;
+        clock-names = "gpu-core", "gpu-sys";
         mboxes = <&mbox_910t 1>;
         mbox-names = "aon";
+        resets = <&rst 0>, <&rst 1>;
+        reset-names = "gpu", "gpu-clkgen";
         #power-domain-cells = <1>;
     };
-- 
2.34.1



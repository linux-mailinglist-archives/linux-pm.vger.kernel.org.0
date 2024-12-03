Return-Path: <linux-pm+bounces-18461-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FDE9E2177
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 16:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0727EB3F23D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 13:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055671F7063;
	Tue,  3 Dec 2024 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aznlbACL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E155D1F4736
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233328; cv=none; b=lMiqmTZjGt2EPsqk57fdX3LQqTIFZ+oUO1MaTQupRE8Ywll9FlSd/Dn2cpZPRMKBdtQxEEc16vLWhpV8HlSsJe3VKpMgWwbv8J0mkoqY+yP0n0tuzsN3Q+J4W/wfL1JDmCnMVdK7JJhxhDYv2cn/CxoJiKMOz6PJv9zNki8EazE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233328; c=relaxed/simple;
	bh=3iaMTps/zUYAo1YPwfiTddvUGRMQeQVJMHNtJDXnPtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=d4JoKqrAMyfxKl1q/0y9cDIskb9kQOkiAtR/DTVXkTk+GXteEPFjdJLzNBPtX1552yBOkEgyuB76ABH1PSI0czlF+c68oq4KeFtkz3/EE4qe/rTmYAOexiTgsgQbiWMGs+bAon+ytU/MIMrVRD8ymLzU/vCxMpjiGsADR7IT/0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aznlbACL; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241203134157euoutp02bd819f838d4b1c58629415ea7a675b0a~NroT9FzoU3035030350euoutp02S
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:41:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241203134157euoutp02bd819f838d4b1c58629415ea7a675b0a~NroT9FzoU3035030350euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733233317;
	bh=5rBePMS44xnD+OwXpDSSPcmNCrh1lKWMdJ1IYE/6SpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aznlbACLHvSNxstEGzxKWl2jAngBf1qfe63+gZ89x5jroyRBtIF7tpXQdsJ2vHVVH
	 F4nwZ6NHcr5fNqnPbMGkCJrVbujeizc/V65Qkt2BZAPZEdelVkFa1TS1Z1pV1FlngL
	 g1xUCclib6E0AjJ1RpdJ3I4YIspJR0PdsfWumnAs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241203134157eucas1p2b259dbaaa19422fc4d713764e4c39d94~NroTVhodu0738707387eucas1p2s;
	Tue,  3 Dec 2024 13:41:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 7D.51.20397.5AA0F476; Tue,  3
	Dec 2024 13:41:57 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241203134156eucas1p2326d84fcef2ee0914586122520b18dcc~NroS8-_QU1693616936eucas1p2b;
	Tue,  3 Dec 2024 13:41:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241203134156eusmtrp2bf0d371dc92520a7b853fc19affbb0ad~NroS7316B3035030350eusmtrp2z;
	Tue,  3 Dec 2024 13:41:56 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-3a-674f0aa55bf7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 6F.C8.19920.4AA0F476; Tue,  3
	Dec 2024 13:41:56 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241203134155eusmtip23d5cc2bd36f9dc0fb0e7adc5825ec3a0~NroRnuaU93133331333eusmtip2d;
	Tue,  3 Dec 2024 13:41:55 +0000 (GMT)
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
Subject: [RFC PATCH v1 06/14] dt-bindings: clock: thead,th1520: Rename YAML
 schema file
Date: Tue,  3 Dec 2024 14:41:29 +0100
Message-Id: <20241203134137.2114847-7-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203134137.2114847-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxbZRTGfe+9vfdSU7iUTd5At4U60GnskBXzOsnAZMabzAQ1i5MNlSpX
	NuRjaYHNwQRXRD4K2ZYxt1KgLGArGdaND2kD8illsBaBjbXKgBm2UehE6Fh0LiDlMt1/v3PO
	8z7POclL4+IfyCD6UFoGp0xTpEhJIdHS97f9pTphbFJ4l16A+m9cwFDzP1oKXWy3Y6i61y5A
	EyNNGLq2NE+i72//QqGZ9i8JNGaspJC6z0Qil3aCRAuaCQEatehI5CntBajFk0+iht6bFDIt
	VWOoZqGZQLWtFoAKir4VoOGBN5BrVIOjAq0fWmlrpdDy2CUCVfzRQaEm9ykBsjbsQ/kdZ4iY
	Tey84yuKdbtcBNtTeJ9i2x/oCdasvUmxGvNVwF6uLyLZ8bE2kq268g47WWLF2MbaXDa/oQ9j
	53+6TrJlTfWAHVHfoNjGwey3/fcLoxK5lENZnHL7rgThwaLhrYcLxUd1HhueB371KwY+NGTk
	sMBxEi8GQlrMGAG81TdH8MV9AKea1OuFB8DhqjLy8ZN+o5rkBwYAf/7Ts164V59Y7AKvimQi
	4JShWuAdbGDmcOhYcq6pcOYugC3TujWvACYONvaXrjJNE0wobHyU622LmGg4OFMO+LgtsKPL
	hnvZh4mBc+XFAl7jD6+cnya8jK9q1M0Va1dA5jshHBgwE15PyOyGt64n8D4BcNbaRPEsgSvm
	aozndDjVvIjznAPNGus6vwbH7Q/XVsOZbdBk2c63X4ejlmKSd/eFjnv+/Aa+8HTLNzjfFsHC
	AjGvDoPlmtL/Qu3GlvVQFva4e7GTIET7xC3aJ27R/p+rB3g9COQyValJnGpHGndEplKkqjLT
	kmSfpKdeBqufenDZutQKjLMLsm6A0aAbQBqXbhAZTHuSxKJExefHOGX6R8rMFE7VDYJpQhoo
	Ck3cwomZJEUG9xnHHeaUj6cY7ROUh7HZmqyttWfbIsNLyg+AjtyKyuL5nj553FObsuTHlyLu
	2nrC74SqK6ej9HXSjt8kVRLRSuV71wjHqaG8t44snE7xnFi2fZER+WLAPZ1kZ4hub4OtzDmq
	B+Gd88fuhIVN+Fhdw+aC1geN0RFRF3aEbm4dkXWWRJ4Iqskx7fpx+dy2+Nqjzzsl8mTD3kvR
	UrDTsni85vyjuCwUfO7ieHxwXbb+tmRjHRE/m6Ytiv1QEvr1w/3v25wJbosiZuDq7k+NnQMo
	+5Vu35BJv+cCZXv+MkwOHXi6x/nBDEu7kmf31X1MWoZ+dxgDn3k2SJr76sZY7WZdd9GbTNcZ
	/bs5ZxflyeauGimhOqh4+QVcqVL8CyvUVdlDBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsVy+t/xe7pLuPzTDU7dVLU4cX0Rk8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFlc+fqezWLd0wvsFi/2NrJYXFsxl92i+dh6NouXs+6xWXzsucdq
	cXnXHDaLz71HGC22fW5hs1h75C67xfqv85ksFn7cymKxZMcuRou2zmWsFhdPuVq8vNzDbNE2
	i9/i/54d7Bb/rm1ksZj9bj+7xZY3E1ktjq8Nt2jZP4XFQdbj/Y1Wdo83L1+yeBzu+MLusffb
	AhaPnbPusnv07DzD6LFpVSebx51re9g85p0M9LjffZzJY/OSeo+WtceYPN7vu8rm0bdlFaPH
	pebr7B6bT1cHCEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSW
	pRbp2yXoZXReVCnoEKqY8/kscwPjLf4uRk4OCQETiRMrmtm6GLk4hASWMkpM6tjICpGQkbjW
	/ZIFwhaW+HOtC6roFaPEpeOtzCAJNgEjiQfL57OCJEQEOlkk3m5eywjiMAu8ZZS4PnMjWLuw
	QLjEu0fTmboYOThYBFQlNv+pBwnzCthLnH4xlRFig7zE/oNnwYZyCjhIvJ7aBXaFEFDNjr+H
	WSHqBSVOznwCNpIZqL5562zmCYwCs5CkZiFJLWBkWsUoklpanJueW2yoV5yYW1yal66XnJ+7
	iRGYVLYd+7l5B+O8Vx/1DjEycTAeYpTgYFYS4V2+3jtdiDclsbIqtSg/vqg0J7X4EKMp0NkT
	maVEk/OBaS2vJN7QzMDU0MTM0sDU0sxYSZzX7fL5NCGB9MSS1OzU1ILUIpg+Jg5OqQYmptks
	DJPNDUP0/zr0fmcKWPTOT9csyPaZ3OPp0zKsDjR/VljNWZ358RDvwtqWvyUN82X2Bj5fwhmz
	ZlHPF9OYuF0LClfOVc14/8TUJXqXaE3v8ZB70bU/Fv03L05SDwteHjtVsk+pi7XZaYVhhpVL
	WdTR26Znv1SGLuF/1OT2v4N1W/4PG39tiQmcm6rPZ8ge55stxpHqPMv7uNACf5dN1nLVRlt4
	d4qWTWRa59x4RDBTMt8t58Ks3Y2lm/qNNnx/7hf+MJX5zoIfi7wLGGJzWX+98PU+O/eaUPWM
	U/yPeeYLV35bXad5tYEx32bbDJslgk8XdKTcSy+YPnXHsYVPag3k9CoU/juKfot8Z6LEUpyR
	aKjFXFScCADRXE+gswMAAA==
X-CMS-MailID: 20241203134156eucas1p2326d84fcef2ee0914586122520b18dcc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241203134156eucas1p2326d84fcef2ee0914586122520b18dcc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241203134156eucas1p2326d84fcef2ee0914586122520b18dcc
References: <20241203134137.2114847-1-m.wilczynski@samsung.com>
	<CGME20241203134156eucas1p2326d84fcef2ee0914586122520b18dcc@eucas1p2.samsung.com>

As support for clocks from new subsystems is being added to the T-Head
TH1520 SoC, the Device Tree binding YAML schema file name should reflect
this broader scope.  The existing schema file 'thead,th1520-clk-ap.yaml'
includes the '-ap' suffix, indicating it's specific to the Application
Processor (AP) subsystem.

Rename the YAML schema file to 'thead,th1520-clk.yaml' to generalize it
for all subsystems. Update all references to this schema file
accordingly.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 .../clock/{thead,th1520-clk-ap.yaml => thead,th1520-clk.yaml}   | 2 +-
 MAINTAINERS                                                     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/clock/{thead,th1520-clk-ap.yaml => thead,th1520-clk.yaml} (96%)

diff --git a/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml b/Documentation/devicetree/bindings/clock/thead,th1520-clk.yaml
similarity index 96%
rename from Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
rename to Documentation/devicetree/bindings/clock/thead,th1520-clk.yaml
index 5a8f1041f766..416c8882942e 100644
--- a/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
+++ b/Documentation/devicetree/bindings/clock/thead,th1520-clk.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/clock/thead,th1520-clk-ap.yaml#
+$id: http://devicetree.org/schemas/clock/thead,th1520-clk.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: T-HEAD TH1520 sub-systems clock controller
diff --git a/MAINTAINERS b/MAINTAINERS
index bd4bbf07d588..2f8f529e6a31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20183,7 +20183,7 @@ M:	Fu Wei <wefu@redhat.com>
 L:	linux-riscv@lists.infradead.org
 S:	Maintained
 T:	git https://github.com/pdp7/linux.git
-F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
+F:	Documentation/devicetree/bindings/clock/thead,th1520-clk.yaml
 F:	Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
 F:	Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
 F:	Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
-- 
2.34.1



Return-Path: <linux-pm+bounces-18464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B418A9E1DF7
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 14:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9321663D7
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 13:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00E31F754C;
	Tue,  3 Dec 2024 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gNlUsS+Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E3E1F6697
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233331; cv=none; b=YaRl/K4Ys2p5CrY5OmO0xJUenVp4eTKc0T/n3RMD7vMasUp/GVXKYa9xl7yWSoJjF7etqAKV1xEoG7HsgKBEYbk0fHJ6Rr2MIOYU/gBpObZW2YKWrHjapnXuhejuJmXEzfl+1HSVgcVzqRmfwWid7bQ0TvMUbzEppSyldXYHC8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233331; c=relaxed/simple;
	bh=yGV+pHT8Eu+bW/k22z4ah+jmkMn/dSKIhyug2nfL/QM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=ofNDRPOvt6yjL1EngRCVCuZvfWSQrChSsn6YsRBEF6Vlgl8kXk8eST8fkTjFr2vdKFLihTRAh5ynF6hYm7gLFzPbZAJ1rd06c42kmFSnxTnoYhmXEpaKKAypM6uQsWEJA9KLDprLz9qP5PBTw8BE9rmry6VL2C9FAUmKR5IMf+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gNlUsS+Z; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241203134205euoutp0129fa681f94686d64208310032a6422d0~NrobSipcc2577425774euoutp01L
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:42:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241203134205euoutp0129fa681f94686d64208310032a6422d0~NrobSipcc2577425774euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733233325;
	bh=Y3IPk+omdIsYG1TGGWrZ/T1oqXdwsq6W+jVj4/QfyRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gNlUsS+Z9h2yWFNZS2nNcX57QOifuflBK55wqPStgWPKkB5qMT2k7Uy7NoPFAbtig
	 JVHJMAhhso50rEcAZ0k7BBJqs1bytJLWCgdC6SQFq7m3Dr26Ng0GRsoi1VclxllZ1i
	 3oEKagF1qyroHxPI1Y6j48gcuHMvKboQQeNWyJrM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241203134205eucas1p1ff5c636d9a33263759a1ac385dc8f85b~NroayyaeB2130021300eucas1p1D;
	Tue,  3 Dec 2024 13:42:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id FE.8F.20409.DAA0F476; Tue,  3
	Dec 2024 13:42:05 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241203134204eucas1p1d0df90a265637542f0652fd407dc7989~NroaVss8-3146231462eucas1p1G;
	Tue,  3 Dec 2024 13:42:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241203134204eusmtrp1ac1235c6c147940e07b68dcf5c7030b5~NroaU3SMa0888908889eusmtrp1Y;
	Tue,  3 Dec 2024 13:42:04 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-a3-674f0aad0002
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id BC.D8.19920.CAA0F476; Tue,  3
	Dec 2024 13:42:04 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241203134203eusmtip219f716cf08acc535a4afb581580bd4b1~NroZCcx8K0887608876eusmtip2C;
	Tue,  3 Dec 2024 13:42:03 +0000 (GMT)
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
Subject: [RFC PATCH v1 12/14] riscv: dts: Add Video Output clock and syscon
 regmap nodes
Date: Tue,  3 Dec 2024 14:41:35 +0100
Message-Id: <20241203134137.2114847-13-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203134137.2114847-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGd+69vfe2Ce7SEjniDJMFdYvCxlx2NhcncdMb/AM/FtyYRptx
	VxlQWGun4jbEYqWsMN0gmy1IHfIZKhNaQiuMAE0B0c6VTxXQZjipLRK+JGjEUS5u/vc7z/O8
	5zlvcmhcXEuG0Inyw5xCLk0OI0VEvWPOucEkipW96WwmUEf/bxiyPNFTqLrJiaFiu1OAhl1m
	DPXMjJPo0r0bFBptyiRQX0URhdSOGhJ59MMkmtANC1C3rZBEU7l2gOqnskhksg9RqGamGEMX
	JiwEuthgA0ijLROgv65+jDzdOhxp9C+jZ40NFJrvu0wgw8NmCpl9ZwWo3bQXZTXnE1tWseMD
	pyjW5/EQbFv2NMU2PTISrFU/RLE66zXA1lZpSXawr5Fkz3fuYu/80I6xdRcz2CyTA2PH/+gl
	2TxzFWBd6n6Kres6vjMwXvRBApec+A2niNx8UHTIcHlUkHZLdHTW4KROAA+dA4Q0ZDZCdVkP
	yAEiWsxUAPh76STlN8TMNIBXb0HemAJwUKsVPJ/QuasEvFEO4NPbVpI/+AB8+MyK+1MkEwXv
	lhcvpoIYLw4HZm4upnDmPoD1I4WkPyVh4uHpuaHFewkmHHa32YGfA5gtsMN7ZakvFDa3XF+8
	VbigewtyBHwmEHaeGyH8jC9k1BYD7i+ATKUI2u/kLg1/BEvb3CTPEvig3Uzx/Ars+llH8JwK
	71omcZ6/hVZd+xJvgoPOxwuz9ELB67DGFsnL0bDl75u4X4bMMjgwFsg/YRn8qf6XJTkAZmvE
	fHoNLNDl/lfqrKjHeGbhmRIXdQas1r+wjP6FZfT/9xoBXgWCOZUyRcYpo+TckQilNEWpkssi
	vkhNqQUL37prvn26AZQ/mIhoBRgNWgGk8bCggPKaHTJxQIL0WDqnSD2gUCVzylawkibCggPC
	E0I5MSOTHuaSOC6NUzx3MVoYcgIzzYVKC/allzjN6mhJTPcG+awk7H13wu3T/bHvdrvWjmkU
	uxu8az+JXr2c3J+5Qrht/1Te8v6iWZtkX6d5249jhd9tOisOOp462qrfMTj7jjFvuqDjRlFS
	RjW3q3cVRgeHzMRtVk5+3+uJvwZaHLg4/LXPtqY1ZMc8Ss5X5WxfY8HV6dWx8lbpvG/K2HRv
	T4fV3VV3cvjVFSW/bg8/2vOpsNCp9pa4d3749p9O+dd1X9U9XpnjW1/Z9KXN0OiKOphxpOtK
	cL8WJnpGikHNSVlc+TmJJvLz8+YLKvfW97Qb508dM5b+E3UgZt36dfOZ9586HMKkvXE9fU/0
	+S9Vll2ypIdcDyOUh6RvvYErlNJ/ASKbB4pFBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsVy+t/xe7pruPzTDbbMVbQ4cX0Rk8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFlc+fqezWLd0wvsFi/2NrJYXFsxl92i+dh6NouXs+6xWXzsucdq
	cXnXHDaLz71HGC22fW5hs1h75C67xfqv85ksFn7cymKxZMcuRou2zmWsFhdPuVq8vNzDbNE2
	i9/i/54d7Bb/rm1ksZj9bj+7xZY3E1ktjq8Nt2jZP4XFQdbj/Y1Wdo83L1+yeBzu+MLusffb
	AhaPnbPusnv07DzD6LFpVSebx51re9g85p0M9LjffZzJY/OSeo+WtceYPN7vu8rm0bdlFaPH
	pebr7B6bT1cHCEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSW
	pRbp2yXoZcze+IK14BZXxffZ59gbGF9ydDFyckgImEj0PFzF2sXIxSEksJRR4sChbjaIhIzE
	te6XLBC2sMSfa11gcSGBV4wS8ydpgdhsAkYSD5bPB2sWEehkkXi7eS0jiMMs8JZR4vrMjWDd
	wgIREod+7mIHsVkEVCUuHz7CCGLzCjhInHi9mxVig7zE/oNnmUFsTqD466ldrBDb7CV2/D3M
	ClEvKHFy5hOwmcxA9c1bZzNPYBSYhSQ1C0lqASPTKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxN
	jMC0su3Yz807GOe9+qh3iJGJg/EQowQHs5II7/L13ulCvCmJlVWpRfnxRaU5qcWHGE2B7p7I
	LCWanA9MbHkl8YZmBqaGJmaWBqaWZsZK4rxul8+nCQmkJ5akZqemFqQWwfQxcXBKNTAZfEsQ
	kGq9I7b9nqhD9a2LK7qOZzvOEUrdWydetlT8hOis5LX9jA9lZ3jZXuXJ+v5TSlVh7lM3hnn1
	59jP653Z9VdQ9NL6UzPNP4g3XnngtKax6PNM3Syxoglbw+Zs3cfIdfbI48iTG1J+K0svT/ZP
	7fD2cZI9c+aw+4+WZ/ls1hMUJktMdHvN/7vDwMfs4I+CS8s6wmoW964y/Vq7dEfA/qi1W6VX
	rO6MZ71xq1Nt36z4pg2bnk5bdHjHj1S1vQqRrMck2s4bMXlNL30ttajrQsLEFb1sFw9yBrKd
	Nfp6a07k/ZlxRd1nrVqkcr69O/eqavPna7Ipj6Linmyf2bT2wD6JtdeWLy7XPfKqryi/UIml
	OCPRUIu5qDgRAK6j0Gq0AwAA
X-CMS-MailID: 20241203134204eucas1p1d0df90a265637542f0652fd407dc7989
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241203134204eucas1p1d0df90a265637542f0652fd407dc7989
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241203134204eucas1p1d0df90a265637542f0652fd407dc7989
References: <20241203134137.2114847-1-m.wilczynski@samsung.com>
	<CGME20241203134204eucas1p1d0df90a265637542f0652fd407dc7989@eucas1p1.samsung.com>

The address space controlling the Video Output (VO) subsystem clocks
also contains control registers for GPU resets. To properly synchronize
access to this shared address space, create a syscon Device Tree node
for the VO registers and reference it in the clock controller node.

This change ensures coordinated access to the VO registers between the
clock controller and other drivers, preventing conflicts and maintaining
system stability.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index dc2d554b4a71..39d39059160d 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -489,6 +489,18 @@ clk: clock-controller@ffef010000 {
 			#clock-cells = <1>;
 		};
 
+		vosys_clk: clock-controller {
+			compatible = "thead,th1520-clk-vo";
+			thead,vosys-regmap = <&vosys_reg>;
+			#clock-cells = <1>;
+		};
+
+		vosys_reg: vosys@ffef528000 {
+			compatible = "thead,th1520-vosys", "syscon";
+			reg = <0xff 0xef528000 0x0 0x1000>;
+			status = "okay";
+		};
+
 		dmac0: dma-controller@ffefc00000 {
 			compatible = "snps,axi-dma-1.01a";
 			reg = <0xff 0xefc00000 0x0 0x1000>;
-- 
2.34.1



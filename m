Return-Path: <linux-pm+bounces-18468-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24DA9E1DFD
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 14:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9522B166611
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 13:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6C61F7589;
	Tue,  3 Dec 2024 13:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="buQaAvFV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1FD1F666B
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233331; cv=none; b=MD11kHqiGJjddY8dQsL6wAAhBbhb0AtxqqFjBqfDaWK/QL2ulu64E97Omd66mOgC7o9ewUCCafifSXTtwgGi197lyVNLTat6nW+3ZaPef/W+9yI/39d6MpiDyq7fx30BZjfh6f5naeEkMbV/rqfxReg/giDYfeNQbRf1gLXhXfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233331; c=relaxed/simple;
	bh=8am2sNNGYymVLoCZUo4DyJ1RjPVHV0dlNov/PfNPXAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=uYludj5zAuIBR1GeeUnoC3ca4vuALaMwspJlFh2O/Xfc4OqAN8Mwk4y4+TP0D2WLQpEXzpfbzrACAr5xkmD+V6yUrAmxWPQP2ytUaSau+Pnf8srxeccigy3y1XUZf182v7hQfRk7TOPhI3vpLxRTWwa4YRkvO1w3MCdybZvapoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=buQaAvFV; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241203134207euoutp01469bf8d67ee3dda8f324e038becc3dc6~NroclkIk_2494924949euoutp017
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:42:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241203134207euoutp01469bf8d67ee3dda8f324e038becc3dc6~NroclkIk_2494924949euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733233327;
	bh=ZqpyrIT86+Z8L3YqwKLe85srHGtjvwzJ0vOwcnFYImg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=buQaAvFVRA7WSxR8+9UA4nqe6ICxaPlEI7B7IHMTEbKf0AD4e52JDxyZInd6tXB0W
	 0aaTky6JVwQZd0LZIABsegi9WA1uVPWfSCuiHBCA9cmirTVBpNSBnLeLFYLHRpwYEz
	 s9w/JDHWvqplqFB1gBEXwmzs6dt/Fno9t8TyVK48=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241203134206eucas1p2a0fb21d525d99d2d325e76361f1aaf57~NrocJH4B91761117611eucas1p2Z;
	Tue,  3 Dec 2024 13:42:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id E8.61.20397.EAA0F476; Tue,  3
	Dec 2024 13:42:06 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241203134206eucas1p10ca2d7bb12afbd082d5f8a9ad85f94bd~NroblO0rD3124331243eucas1p1M;
	Tue,  3 Dec 2024 13:42:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241203134205eusmtrp19989158973803a352ab1e40187820453~NrobkLLd_0888908889eusmtrp1d;
	Tue,  3 Dec 2024 13:42:05 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-5b-674f0aae148c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id F8.07.19654.DAA0F476; Tue,  3
	Dec 2024 13:42:05 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241203134204eusmtip28aa0d75a1ff497816e13d85995da3d09~NroaPqseC0866008660eusmtip2F;
	Tue,  3 Dec 2024 13:42:04 +0000 (GMT)
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
Subject: [RFC PATCH v1 13/14] riscv: dts: Introduce power domain node with
 simple-bus compatible
Date: Tue,  3 Dec 2024 14:41:36 +0100
Message-Id: <20241203134137.2114847-14-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203134137.2114847-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTZxjHfc85PefQrHhaEN+BTKzRXeLQFU3ebcIkcclJdBsSLxsfJnUc
	ixkU1oqDbYk6GANs2bR2aLlZ0nCLeKK9DBiXCQ3lImwoFDCALOJmlUm41GUqsJbDNr/9nuf5
	P5f/m5fGZVfJUPqY+jinUStT5KSYcHT8/cvrV8QfqLZ1dwejzqEKDNmfmih0ubkPQ+XOPhEa
	v2nD0IB3mkRX7v1KofvNpwnkri6lUHYHTyKPaZxEM7pxEbrVWEKiOb0TIMdcDonqnGMU4r3l
	GDLP2AlkqW8EKDe/UoT6u99Fnls6HOWaVqOlpnoKLbqvEqj4USuFbFNnRchVdwjltJ4ndoWz
	08PfUOyUx0Ow7XnzFNv8+BLBNpjGKFbXcAOw12rzSXbU3USyZV372DtnXBhrtZxkc+o6MHa6
	ZZBkC221gL2ZPUSx1p4v46QJ4p1JXMqxE5xma0yiONltKsTT51/I/L1Mcgr0iwtAAA2Z7dDx
	2CUqAGJaxlQDyLvshBDMA3jasQSEYA7AudJZX4VeblkqDRTyVQB29HZSQjDl62gfwfxzSUYB
	J6rKl+cGMw9xOOwdIf0BzvwBoGOyhPSrgpgjkNePLjPBbILV1oZlljC74KzLhQkXroet13tx
	Pwf48g+NBSJBI4VdFycJP+M+Tba9GPcvgEydGJY1nwdC827Y26MnBQ6CD1w2SuB1sMegIwRO
	gxP2WVzgr2CDzrXCb8PRviek3zPOvAr5xq1COha2DUzgwlMEwuE/pcIJgfCco2glLYF5uTJB
	vRkadfr/lvZVO1ZcsdCwmA++BxtMz5kxPWfG9P/eSwCvBWu5DG2qitNGqbnPI7XKVG2GWhX5
	SVrqNeD71T2LLm89qH4wE9kGMBq0AUjj8mBJFb9HJZMkKbO+4DRphzUZKZy2DYTRhHytZFPS
	ek7GqJTHuU85Lp3T/FvF6IDQU1hJf3TNYFbYlvu/SV8xh9mjVe/9+FFIaETL2aQbbxkqX6qP
	+frZ4tO6prE1cRN/lQQNrIt6R3Hi4lDORrJiYUEauhHnupI7DfJZS33XIYVBj4r4ws6yy59Z
	T/LtHvNuW1pLf82QI5/+0OhWbLmQ/nK47eOaN6vU2Zk2SfZO6cGF/e9HLlDyveqx+ejBFxOK
	nqTckxUXBfDjIc6fLEZn/Gpx1JrMozsqIwqeHR39uTvaYiAKZFnbW24fTIxI/05hBjQfviq3
	PC4h8duQCnJH47693VXxGm/8D7Wxk4qcu7Y7klW51gMb1IfzNhuj8kCS+QweeCF2z/XbRx6d
	G/Fuc9+N4eWENln5xmu4Rqv8B2fHr1lEBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsVy+t/xe7prufzTDZ5fMbM4cX0Rk8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFlc+fqezWLd0wvsFi/2NrJYXFsxl92i+dh6NouXs+6xWXzsucdq
	cXnXHDaLz71HGC22fW5hs1h75C67xfqv85ksFn7cymKxZMcuRou2zmWsFhdPuVq8vNzDbNE2
	i9/i/54d7Bb/rm1ksZj9bj+7xZY3E1ktjq8Nt2jZP4XFQdbj/Y1Wdo83L1+yeBzu+MLusffb
	AhaPnbPusnv07DzD6LFpVSebx51re9g85p0M9LjffZzJY/OSeo+WtceYPN7vu8rm0bdlFaPH
	pebr7B6bT1cHCEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSW
	pRbp2yXoZVyb1cdc8IWn4tk83gbGi1xdjBwcEgImEv/n8nUxcnEICSxllPixr4exi5ETKC4j
	ca37JQuELSzx51oXG0TRK0aJF4v3MIMk2ASMJB4sn88KkhAR6GSReLt5LSOIwyzwllHi+syN
	LCArhAUSJFom+4A0sAioSqzYvJMNxOYVcJD4dPw4E8QGeYn9B8+CDeUEir+e2sUKYgsJ2Evs
	+HuYFaJeUOLkzCdgFzED1Tdvnc08gVFgFpLULCSpBYxMqxhFUkuLc9Nzi430ihNzi0vz0vWS
	83M3MQJTyrZjP7fsYFz56qPeIUYmDsZDjBIczEoivMvXe6cL8aYkVlalFuXHF5XmpBYfYjQF
	unsis5Rocj4wqeWVxBuaGZgamphZGphamhkrifOyXTmfJiSQnliSmp2aWpBaBNPHxMEp1cBU
	vD+7do6LvtfUbxtmzCx57tVYPVdLy+8gz/JiZ0HDtZPLbkfVJV9IeZHRH9AuHRI5Sfe+Z+zC
	+wucGdI7sv4Et8ve9d3xX25C6qOLUQ++fLvxcqrqpdD9E9ZunB0QO6ma9+GGVxWW/qf9Xkb7
	SQq6z/zNYP/ZO9muOOjG8iU/1a6mKrsZ2krYPLMSDKi6vD4nun7Nw3yDwjmnGcq52YW21Xec
	Dlus/cDIc5a58Sfj9k9CEQy23JGGjmt+Hi1S+yX66Pnj2xKmJ4qnHG4zzGXTdn1uohVybnZq
	1a3FrT6ndracu7tue4GLfNLvC3daReLln3NcO9Tx8I3R5zVli7c8e7wxabZIV6Cf7vWFVkxK
	LMUZiYZazEXFiQCORnAisgMAAA==
X-CMS-MailID: 20241203134206eucas1p10ca2d7bb12afbd082d5f8a9ad85f94bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241203134206eucas1p10ca2d7bb12afbd082d5f8a9ad85f94bd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241203134206eucas1p10ca2d7bb12afbd082d5f8a9ad85f94bd
References: <20241203134137.2114847-1-m.wilczynski@samsung.com>
	<CGME20241203134206eucas1p10ca2d7bb12afbd082d5f8a9ad85f94bd@eucas1p1.samsung.com>

The DRM Imagination GPU requires a power-domain driver, but the driver
for "thead,th1520-aon" is not yet available. To ensure that the 'aon'
node and its child 'pd' node are properly recognized and probed by the
kernel, add "simple-bus" to the compatible property of the 'aon' node.

This change allows the kernel to treat the 'aon' node as a simple bus,
enabling the child nodes to be probed and initialized independently. It
ensures that the power domain can be managed appropriately until the
specific AON driver is developed.

This commit introduces some errors while running dtbs_check, as the aon
doesn't have the dt-bindings yet.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 39d39059160d..58f93ad3eb6e 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/thead,th1520-clk.h>
+#include <dt-bindings/power/thead,th1520-power.h>
 
 / {
 	compatible = "thead,th1520";
@@ -229,6 +230,16 @@ stmmac_axi_config: stmmac-axi-config {
 		snps,blen = <0 0 64 32 0 0 0>;
 	};
 
+	aon {
+		compatible = "thead,th1520-aon", "simple-bus";
+
+		pd: power-domain {
+			compatible = "thead,th1520-pd";
+			thead,vosys-regmap = <&vosys_reg>;
+			#power-domain-cells = <1>;
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
-- 
2.34.1



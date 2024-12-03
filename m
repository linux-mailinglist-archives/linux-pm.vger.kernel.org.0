Return-Path: <linux-pm+bounces-18469-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72869E1FD8
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 15:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A49CB440D2
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 13:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3C61F76A8;
	Tue,  3 Dec 2024 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LzKmSEpZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82F31F130C
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233333; cv=none; b=awZVGk4H7arzq+CscjxqtYHZlxD3n8g10MmPb4DY8VuRQUkyje/F9qmF2Rlq7WwTyURHdN+Ohnh/05VkhsW/JSuuhcET13uii32ibQhveWWZkvkS/ULH8fDz2ukiDXYf3O0xzQkNNovOSpSS2+OwXZinT275/YpK0uvTfD4UTUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233333; c=relaxed/simple;
	bh=Q09K24s6mZGeMftMhbsRCZSwqpl712NwsEN3b5mMKQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=kzyM3mZXPn5vyhT41wQQTJ9FHCc4OoC0z/RK1MqZqgeLq3XxvL9Gwz63bBbU03f3MjFATy97eMfAtDWUMP5i5mqdu8CjyZP5HmCiRJM1V5kiPCLFI3ojW9EKR3hs4PiLXqnJZrBlfHhshzKdrjVO3jzNhWt7EK5sKqjEObL+Hqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LzKmSEpZ; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241203134208euoutp0165b6437d16e42615cd1897f28b9d92a8~NrodvNB5H2577425774euoutp01P
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:42:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241203134208euoutp0165b6437d16e42615cd1897f28b9d92a8~NrodvNB5H2577425774euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733233328;
	bh=asLRQbzZayMb9yjHqxeg3uy1MkPJO2HP86mTn2EInqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LzKmSEpZlf1ut93GLgZgZkL5DvwA9/s4Z4tXQvpfizc1ptHHgyzvlvncYlfq23/kH
	 koSmiIRIpYqjRAwjaBCHioczuiP5BFvOXVnOeS6DKnKMjxEEZZQlXAbLP71fAOB5w5
	 2dIsgkMX7v142vE668YZEtP1iuEE35338SBxkwes=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241203134207eucas1p2192873d281269b06d9a62beceeba8f3d~NrodRG3hq2525825258eucas1p2T;
	Tue,  3 Dec 2024 13:42:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id EA.61.20397.FAA0F476; Tue,  3
	Dec 2024 13:42:07 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241203134207eucas1p29a2d095c527858729ae706d2a9027a5c~NrocvXTNQ0681706817eucas1p27;
	Tue,  3 Dec 2024 13:42:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241203134207eusmtrp1bbfbc45095ec0d11460c41a654f8dea7~NrocuVBR50888908889eusmtrp1h;
	Tue,  3 Dec 2024 13:42:07 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-5e-674f0aaf06f9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id FA.07.19654.FAA0F476; Tue,  3
	Dec 2024 13:42:07 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241203134205eusmtip25691c9bf5366d4112ecb39c2227629f5~Nrobfx7Vv3160631606eusmtip2L;
	Tue,  3 Dec 2024 13:42:05 +0000 (GMT)
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
Subject: [RFC PATCH v1 14/14] riscv: dts: Add GPU node to TH1520 device tree
Date: Tue,  3 Dec 2024 14:41:37 +0100
Message-Id: <20241203134137.2114847-15-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203134137.2114847-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CTdRzH7/s8z55nWzd6GJjfdMRBJ3cSoQjFlzSlu8qn1My6wyv/sBFP
	g+KHt4ml0AXxQwdT1MXQgfLzxkLmANnip+C2YyoG6nQCAZFJBix2gOwuMojxWPnf6/t+vz/3
	+XFfPi5uJNfwk1IPsvJUaXIwKSTMPX/2v2wU7pZttLrC0NV7VRgy/aWlUH1nH4bKbX08NHq7
	GUN35t0kujh+k0K/d2YTyKk/R6GcHiOJJrSjJJpRjfKQo62MRHPHbQCZ53JJZLCNUMg4X46h
	yhkTgWpa2gDKV+p46Nb1t9CEQ4WjfO2zaKmjhUKLzkYClU53UajZdYqH7Ia9KLfrOyI2gHEP
	5FGMa2KCYKzHHlFMp6eCYFq1IxSjar0BmKY6JckMOztI5vy1PczPhXaMuVTzDZNr6MEY9+W7
	JHOiuQ4wt3PuUcyl3oz3fT8Wbklgk5MOsfINWz8RJi643MSBxWe+0tU/BllgXlAABHxIR8Gs
	kiZQAIR8Ma0H8IZRQ3kNMf0IwG9toZwxB+BpXf6ywV+psDiiOb0WwJs9lST3cAHYPraEeatJ
	ehMcqy3neQ1/egqHA/ODKymcfgig+UEZ6U350TthSdEQ8DJBr4PnbIsrLKJj4W/TwzxuwEDY
	deVH3MuCZX2quIDHZXzhtbMPCC/jy5kcUynubQDp74Uwz9aAc8VvQtP9LMCxH5y0N1McS2Cv
	WkVwnAbHTLNP8pmwVWV/wpvhcN8C6d0Zp9dDY9sGTn4DapU5PO4UPnDgD19uBB942lyCc7II
	HssXc+kQWKw6/l/TPr0Z45iBP3kawEkQpH1qGe1Ty2j/71sB8Dqwmk1XpMhYRWQq+2W4Qpqi
	SE+VhX+altIEln9176J9vgXoJ2fCLQDjAwuAfDzYX1Rr3CETixKkh4+w8rT98vRkVmEBa/lE
	8GrRuoRAVkzLpAfZL1j2ACv/18X4gjVZWAw5npy5R22K9OiqPI4GZcogDxktiWyRRZtR2K0+
	HFKl+XBG927IZ5c/Oro9MiT+6rZSkTM2Ptr6nr9j1vP2viPmM1vW9jddeG0pu6Px632FqyL4
	1ovZuqXNSUPMc67uU8UT1RF+kib3xvCzC2EvadSBZb/MWarPKKdiVlX7Lr3op38n6EKFtT4v
	UdJQ5KwRZRCS9hfuB1yJuivatd41XTwlid5bF58XFxfwOTa+/+/z2300/duU7A+e0nrDkDa/
	Ky7q+SqX5PXqyhL1bLs6raMxc2T40C3HY81kdOjI1lFBN3N999HkXTHWQcP0naCwE8WvOj/Y
	9DA37pXYX7vaRgf9M4IJRaI0IhSXK6T/AGsy6TFEBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsVy+t/xe7rrufzTDeY+57Q4cX0Rk8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFlc+fqezWLd0wvsFi/2NrJYXFsxl92i+dh6NouXs+6xWXzsucdq
	cXnXHDaLz71HGC22fW5hs1h75C67xfqv85ksFn7cymKxZMcuRou2zmWsFhdPuVq8vNzDbNE2
	i9/i/54d7Bb/rm1ksZj9bj+7xZY3E1ktjq8Nt2jZP4XFQdbj/Y1Wdo83L1+yeBzu+MLusffb
	AhaPnbPusnv07DzD6LFpVSebx51re9g85p0M9LjffZzJY/OSeo+WtceYPN7vu8rm0bdlFaPH
	pebr7B6bT1cHCEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSW
	pRbp2yXoZfx6856l4B93xbI1fxgbGL9ydjFycEgImEgcumzexcjFISSwlFHix9Jeli5GTqC4
	jMS17pdQtrDEn2tdbBBFrxglXp+cA5ZgEzCSeLB8PitIQkSgk0Xi7ea1jCAOs8BbRonrMzeC
	VQkL+EhM77/FCGKzCKhKzD3yD8zmFXCQePbuDivECnmJ/QfPMoPYnEDx11O7wOJCAvYSO/4e
	ZoWoF5Q4OfMJ2ExmoPrmrbOZJzAKzEKSmoUktYCRaRWjSGppcW56brGRXnFibnFpXrpecn7u
	JkZgWtl27OeWHYwrX33UO8TIxMF4iFGCg1lJhHf5eu90Id6UxMqq1KL8+KLSnNTiQ4ymQHdP
	ZJYSTc4HJra8knhDMwNTQxMzSwNTSzNjJXFetivn04QE0hNLUrNTUwtSi2D6mDg4pRqYNmlv
	imsyitncuSiw/uS3jUEn5/Wtli65ePHAZrdDclxBhg4Fc68G2Ehnvk7lYTQxnLk4ifn0iuMH
	bvHn5Zd/sv8XNV1fjFFqn9prPr5ZTDYTPF0W83/TtVNdkjmtQmHe5jkbsz81P87eOcPa3yT6
	oM8Ocau+Yvc6G9am75ct5PN1Er4z6qRxnpo6ifv15FyTyA/7ijbqWUzo6TtYoXGQb5maxe4V
	mY415refeZ3bf10v9aZT0859Uttn7zRi3Ls08dprE+27nL//fPsS039LvS7lk2TiDnW9d9MP
	H536Sb1MSsvhhcf7GYesXKoV+Yu4DNokFqxIV1ZUapA50bArUfuM1uzD63Mrtl9zl+ZTYinO
	SDTUYi4qTgQACEKcjLQDAAA=
X-CMS-MailID: 20241203134207eucas1p29a2d095c527858729ae706d2a9027a5c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241203134207eucas1p29a2d095c527858729ae706d2a9027a5c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241203134207eucas1p29a2d095c527858729ae706d2a9027a5c
References: <20241203134137.2114847-1-m.wilczynski@samsung.com>
	<CGME20241203134207eucas1p29a2d095c527858729ae706d2a9027a5c@eucas1p2.samsung.com>

Add a device tree node for the IMG BXM-4-64 GPU present in the T-HEAD
TH1520 SoC used by the Lichee Pi 4A board. This node enables support for
the GPU using the drm/imagination driver.

By adding this node, the kernel can recognize and initialize the GPU,
providing graphics acceleration capabilities on the Lichee Pi 4A and
other boards based on the TH1520 SoC.

This commit is following convention introduced here [1].

Link: https://lore.kernel.org/all/20241118-sets-bxs-4-64-patch-v1-v2-1-3fd45d9fb0cf@imgtec.com/ [1]

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 58f93ad3eb6e..5023c0c29168 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -500,6 +500,18 @@ clk: clock-controller@ffef010000 {
 			#clock-cells = <1>;
 		};
 
+		gpu: gpu@ffef400000 {
+			compatible = "img,img-bxm-4-64", "img,img-rogue";
+			reg = <0xff 0xef400000 0x0 0x100000>;
+			interrupt-parent = <&plic>;
+			interrupts = <102 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&vosys_clk CLK_GPU_CORE>,
+				 <&vosys_clk CLK_GPU_CFG_ACLK>;
+			clock-names = "core", "sys";
+			power-domains = <&pd TH1520_AON_GPU_PD>;
+			status = "okay";
+		};
+
 		vosys_clk: clock-controller {
 			compatible = "thead,th1520-clk-vo";
 			thead,vosys-regmap = <&vosys_reg>;
-- 
2.34.1



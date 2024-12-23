Return-Path: <linux-pm+bounces-19678-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C36FB9FAEAB
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 13:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3239A7A1985
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 12:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0187F1C3C0F;
	Mon, 23 Dec 2024 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="egYVZrbF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F111BCA19
	for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2024 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734958586; cv=none; b=YXQshSlJFH8ts9o4hLY0tMZMQZuBSwDPv6hgtRh5iYEDVQyeBDyrLN/vYNekOESrEIgxLbRwZXUUwD//zqMHSs31nvYul8nbijyssHJaopngDndASVviL7oDvBdjrhfyXRfQtdsMshk/0zKLb2kUaNmzKoLd8tMot1NeNUtPF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734958586; c=relaxed/simple;
	bh=wyU9FHPOCuF8hVv9kuE3dTezCc2FeP8r6FVRFl9RKh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Bclh/RIHzvJDJWj3Kk0oH0NVfXPPYXTQcQTfNSucOVgSyvSKKtuOxKmK9UzjyNHJ9ipAeiQfZpIpiGOhrcMCEmQeam5dubzCf54JK8YUYPGQrOo02LU3BjnuA/s5o9yj2NGm/9tKGNSoPzTfO2OsuMZ0HsfFIDafry+amTGZ/EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=egYVZrbF; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241223125623euoutp02d1a9d5f939485efb7e514121e4dc5a75~Tz6OaSvZK1017710177euoutp02t
	for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2024 12:56:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241223125623euoutp02d1a9d5f939485efb7e514121e4dc5a75~Tz6OaSvZK1017710177euoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1734958583;
	bh=TT5PYViS2FlrtkYrikHfHy0j9KFZRyYdlPXAvfagDlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=egYVZrbFipoyRjd1IDqYXPgWKxwBmJjDzjz9W6trIFavsmH92IHUTF2KwiAahi90Y
	 s/Kt3SwlfnJFYuxjCbGV9r3mCb2a6271bBd3EP3d1elql891X+ish0EHkZj41lGsyp
	 x2OlYxDojcz/kXtDSHrn1DUCvrKoCFyqtgXe9v2g=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241223125621eucas1p267c72a8ae7ee3f39044d785ff93048b3~Tz6NA5os91741317413eucas1p2T;
	Mon, 23 Dec 2024 12:56:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id CB.C6.20821.5FD59676; Mon, 23
	Dec 2024 12:56:21 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241223125621eucas1p17ecf251c74bc60e69323afe1ffc0c8fb~Tz6MpBcue1526215262eucas1p1n;
	Mon, 23 Dec 2024 12:56:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241223125621eusmtrp1f35668defb4e97d2d7e21ebcd9fdd466~Tz6MoA7fS2059320593eusmtrp1L;
	Mon, 23 Dec 2024 12:56:21 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-9e-67695df53a8b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id F9.83.19654.5FD59676; Mon, 23
	Dec 2024 12:56:21 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241223125619eusmtip2ab38953511df3eb9315de3ee195d00a1~Tz6LRqXkh3149631496eusmtip2G;
	Mon, 23 Dec 2024 12:56:19 +0000 (GMT)
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
Subject: [RFC PATCH v2 15/19] riscv: dts: thead: Extend device tree clk with
 VO reg
Date: Mon, 23 Dec 2024 13:55:49 +0100
Message-Id: <20241223125553.3527812-16-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241223125553.3527812-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxbVRjGc+69vfe22O1SphwZEUfCIpox5lxydK6ZBMzddIsLM0Si0So3
	BQdltsVthmRAgRQoQ0EmFirModQ6xhjQUFxpKB8dQztGR2EDypx82MogwFg2DEPKRd1/v/M8
	73Pe9z05NC5pIUPoFIWaUypkqeGkiDD3PHLuWPogRR5dYAxFV4e+x1DL33oKXbA6MVTd5RQg
	z0Azhm4uzZHo4mQ/hf60ZhPIbTRQSNPTQCKv3kOieZ1HgFxtVSRaLO4CyLyYS6L6rjEKNSxV
	Y+jcfAuBalvbAMov+FGAblyLQ2OeqwTyunQ4ytdvRqtXWin02N1IoMpZG4WaZ74SIEd9Asq1
	fU3sf46dG86j2Bmvl2A7tfcp1vqghmAt+jGK1Vl+BexlUwHJjrqvkOx3vUfY8SIHxjbVnmZz
	63swtmQlmp1rHyTZM80mwA5ohqh3JImi15O41JTPOeVO6Uei5OmROuy4gTrpnGmissCCoBAI
	aci8Akcu6rBCIKIljBHAilkP5TckzH0Aa3NO8MYigN2/OMhCQK8nvDczeb0OwNXyHMAfZgBc
	HLeR/jTJvAzv1FUL/MYWJo+Aed3Z61U4Mw2geaJq/aog5l34+/UEf4BgIqDbpl0Pi5n9cGrl
	NsXPFwZtHb/hfhau6RcKhwFfEwh7v50g/Iyv1WhaKnH//ZBpFMGyoo6NcCycqTy7wUHQ52je
	4FDYV6YjeE6Hd1oWcJ4zoUXn2OC9cNS5vD4nzkTChradvPwGLF+xC/iX2ASH7wXyI2yCpeZv
	cF4WQ22+hK/eDst1xf81dRrNGM8sXNK7wZdgm/6JZfRPLKP/v28NwE0gmMtQpck51S4FdyJK
	JUtTZSjkUZ+kp10Gaz+777FjoRUYfPNRdoDRwA4gjYdvEdslKXKJOEl26gtOmf6hMiOVU9nB
	VpoIDxZHJIVxEkYuU3PHOO44p/zXxWhhSBaWn3wgVhj5Pl3y0lMr+8piLFmHoj2yR5Hk3We9
	o0r7z4FHRP3b9hw9ey84/tKtxEO2EHlx9gtx8eeqOsTS3LnXuMGH4hpXGVPN5gTNifr7ig63
	ZsRrlrmD+x6ejHm6ApcugYDk0tm/JEZjhfnS5O3Nz5zZ4ZL78qVbS917ym6pwgxTjZ/1lnhV
	JnHA4YT+3b67SSnT8I+YY9oRaeB8bI5avXyqPZWqT1gVT2nrfhjpPn/aZBl8K9znbfde6zz6
	sXX11dQJ19uSOClt1UwKHsTObxeuvlmb+NPQuFdNmqgBRYcBhX46srtTbjgvf2/UKo5osrum
	914/4AxYyCy68XxyOKFKlu16EVeqZP8Aj2OFO0gEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsVy+t/xe7pfYzPTDW5eZbY4cX0Rk8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFlc+fqezWLd0wvsFi/2NrJYXFsxl92i+dh6NouXs+6xWXzsucdq
	cXnXHDaLz71HGC22fW5hs1h75C67xfqv85ksFn7cymKxZMcuRou2zmWsFhdPuVrcvXeCxeLl
	5R5mi7ZZ/Bb/9+xgt/h3bSOLxex3+9kttryZyGpxfG24Rcv+KSwOch7vb7Sye7x5+ZLF43DH
	F3aPvd8WsHjsnHWX3aNn5xlGj02rOtk87lzbw+Yx72Sgx/3u40wem5fUe7SsPcbk0f/XwOP9
	vqtsHn1bVjF6XGq+zh4gFKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
	k5Kak1mWWqRvl6CX8fz2cqaCuewV595sZm9g/MTaxcjBISFgIvHySk0XIxeHkMBSRol7Z64z
	dzFyAsVlJK51v2SBsIUl/lzrYoMoesUocWzzBXaQBJuAkcSD5fNZQWwRgcUsEnv3VYIUMQu8
	ZZS4PnMjWLewQLDEpL4zYA0sAqoS1/Z3sIHYvAIOEs/+3mKH2CAvsf/gWbDNnEDxNV03GEFs
	IQF7iX+nPkDVC0qcnPkEbCYzUH3z1tnMExgFZiFJzUKSWsDItIpRJLW0ODc9t9hIrzgxt7g0
	L10vOT93EyMwvWw79nPLDsaVrz7qHWJk4mA8xCjBwawkwntIKDNdiDclsbIqtSg/vqg0J7X4
	EKMp0N0TmaVEk/OBCS6vJN7QzMDU0MTM0sDU0sxYSZyX7cr5NCGB9MSS1OzU1ILUIpg+Jg5O
	qQYmd18xpVwV4fW7uabviiq6ft950fwHe6dcaJZOds81uL5kraXuhO92NnzH12fMPKFvP2Pt
	apE17G/EK5+H35P1sNl+ftkSrpK+d4+Z/W+s/6cmPr/Y+pbSTJWEgFVfn9q43fn74Lhe4jvV
	UOe91522Cgaz2JadYQ8V33njs9Nj4VVq+yte9PGvZtW4alX/f9d7s5IqB4cJ3q77Dl16u+FH
	wJ1Fyef38KblPj/EWyscuWfezETTn58mOrXkF/XfeDqhO6B2Rcr8e+3qq1hf/GScHF2TaG/+
	dK/JzUvCnc9PnP//3vOXwg93W7mKh5ODL6/vDHZzKlb0YMnRfbir4ANzzpu2pzfrAuo37mZJ
	aNtmqcRSnJFoqMVcVJwIAJkrhoi4AwAA
X-CMS-MailID: 20241223125621eucas1p17ecf251c74bc60e69323afe1ffc0c8fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241223125621eucas1p17ecf251c74bc60e69323afe1ffc0c8fb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241223125621eucas1p17ecf251c74bc60e69323afe1ffc0c8fb
References: <20241223125553.3527812-1-m.wilczynski@samsung.com>
	<CGME20241223125621eucas1p17ecf251c74bc60e69323afe1ffc0c8fb@eucas1p1.samsung.com>

VO clocks reside in a different address space from the AP clocks on the
T-HEAD SoC. Extend the device tree node of a clock-controller to handle
VO address space as well.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index acfe030e803a..d823b6da75df 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -484,7 +484,9 @@ uart2: serial@ffec010000 {
 
 		clk: clock-controller@ffef010000 {
 			compatible = "thead,th1520-clk-ap";
-			reg = <0xff 0xef010000 0x0 0x1000>;
+			reg = <0xff 0xef010000 0x0 0x1000>,
+			      <0xff 0xef528050 0x0 0xfb0>;
+			reg-names = "ap-clks", "vo-clks";
 			clocks = <&osc>;
 			#clock-cells = <1>;
 		};
-- 
2.34.1



Return-Path: <linux-pm+bounces-19673-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 630EE9FAE9A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 13:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E7F1883A92
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 12:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106981B87E5;
	Mon, 23 Dec 2024 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y9zZlokr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224B41B392B
	for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2024 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734958583; cv=none; b=k+/KO8mWUeE+TpojSiYdyfQGqVh/QuD5QspHnw/9B+KqSnw+9/gJdcBlEkTFAJqGe6l/Lb6jpzkR3m+gr60jX8bnOZ67YbAzlF6wpODqRG3ZxEDTMZghJqnorvUIEpOFzLw+yjbngoL3UZ0UV6SnPGhjh10lJOACOLGBi/hXSU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734958583; c=relaxed/simple;
	bh=AvOuBhpS/RO4n/V2TKEgU+sci1oVNo2VYWPMwnRe7lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=D7UEcvujPuV6SzGC5thMC9tPJhJuQS4xpmVxmeZAi1gOVh8+02c+YOmM9xeCX8OhrNu2YGssNs1rJ7GkXNSpqIKELC18yxHicfM9u2vv83llPN5IACOslXsLUY65YDaufJdeUsfa6odBQIT9PaMpxSzT0XtElagDRI3isIkYD+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Y9zZlokr; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241223125611euoutp0143600111c318aa067e0d4e85dcb6df66~Tz6DVt3-D3053030530euoutp01X
	for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2024 12:56:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241223125611euoutp0143600111c318aa067e0d4e85dcb6df66~Tz6DVt3-D3053030530euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1734958571;
	bh=db70OtbkcGzgNDsJliSTwbkZ7rSF5HHS/kqbDimn6GA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y9zZlokrpLTziVg1m4j/Btvq0GaSoSfnUc0S/tyAiwExPV/d+NqkV7vKLrg4rHCTN
	 yLx9VaZSIYc821nuw9dV0xIz1ZWuJrR1IB+vUVXNJw9uBSvzijsahksPc0u0a/d7c/
	 +XhmPN+g9MI7PI5GD2REIq8WQJwQvcr+a/XwccNs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241223125610eucas1p13d0d6c558e8d20ca73db6b12a36a956c~Tz6C1Q7an1526615266eucas1p1e;
	Mon, 23 Dec 2024 12:56:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 1C.B6.20821.AED59676; Mon, 23
	Dec 2024 12:56:10 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241223125610eucas1p2721f8a199bc6ff16345b3b46fc44dd63~Tz6Cc7BJ81252912529eucas1p2_;
	Mon, 23 Dec 2024 12:56:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241223125610eusmtrp1f47963956bbde8dc246f60cfda0af461~Tz6CcIyqW2051220512eusmtrp1V;
	Mon, 23 Dec 2024 12:56:10 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-79-67695dea61f5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 27.F3.19920.AED59676; Mon, 23
	Dec 2024 12:56:10 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241223125608eusmtip21b1fb906d48b2037ed6ae100eecaa9fb~Tz6BEXflX2259822598eusmtip2J;
	Mon, 23 Dec 2024 12:56:08 +0000 (GMT)
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
Subject: [RFC PATCH v2 07/19] riscv: Enable PM_GENERIC_DOMAINS for T-Head
 SoCs
Date: Mon, 23 Dec 2024 13:55:41 +0100
Message-Id: <20241223125553.3527812-8-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241223125553.3527812-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxiHd+69vbd0AS+FjRM3J3ZxiSwiGhZPokPn2HI1ZGFzzulGpMod
	spVi2jJhKQ7WUj6sQ1RkFBwfIdqwYofQSsvX7IBC6yofo4ICugyDZZ2ICBEGOGjr5n+/877P
	Oe/zJoeL8xvJ1dwksYyViIUiAckjjJ1zjo0TcUmJEfVn1qGum1UYMvyjoZCuxYGh8nYHB432
	NWDo95lJEl2+10Oh+y1ZBHJqL1BI0aknkUszSqIp9SgH9ZvLSDR9qh0g47SSRLXtIxTSz5Rj
	qHLKQKDqRjNAqryLHNRrew+NjHYRyNWvxpFKswo9bW6k0JKzjkClD9oo1OAu5CBr7X6kbDtH
	7HyNmRzMphi3y0Uwv+Y+ppiW2QqCMWlGKEZtug6YKzV5JDPsbCaZH7s/ZO6ctGJMffW3jLK2
	E2MKFiOYydYBkvm+oQYwfYqbVCz/IG97AitK+pqVbIqK5x3tMOrwY+f80pTFOioT2Kl84MeF
	dCS0WcZBPuBx+bQWwJnzObj38BhATWGrrzMN4MPmJuzZFbPiDsfbuATgoj3XR7kB7G7X4ysU
	SW+Bdy+Ve6hgOpuA2R1ZHgqnxwE0jpWRK1QQHQudeUMeFYJeD+f6mzkr2Z/eAZUKtU9xLWy7
	9pvnVT96J9TlDwIvEwi7S8aIlYwvMwpDqccc0nU8eNle6pONhj9c7/DlIDhhbfA9+iq0n1UT
	3pwC7xoe4d4shya11Ze3wWHH/LIod3nABqg3b/KW34Hls05PGdIBcPDvQK9CADxjLMa9ZX+Y
	q+J76TdgkfrUf0MdWqNPhoFN+SXYabBO89wymueW0fw/twLgNSCETZUmJ7LSzWL2eLhUmCxN
	FSeGH0lJvgKWP7d9yfqoEVyYmAq3AIwLLABycUGwv4WflMj3TxCmf8NKUg5JUkWs1AJe4RKC
	EP/1CWtZPp0olLFfsewxVvKsi3H9Vmdi+ecH5rc+2fu+zbHQEz8VHz0mTTse2poHX2J3Xc2z
	f64NvRF6q2BhNyO/rzo9XDdH3JYGhRugWfTmvq7cPZknUqoWsjIG9C+c/LIhzX4kveTwwcjY
	t1TFcWG9J2ziHseOyrQhXoU5RGablz+59jaeU7BvJmYpurd/Va741usHYiwo6N2KLz7Z8KlL
	tKgd+OVGVJUuchuGZuVr3Kqz83GWj3/O2aX8bvuLEZKn4qKLe7aQKfEBw+Hj1ca+n+TCj+o3
	ake35gTXK/ZXynIkuiFd4OHFB1fvhe2dFrz8x233X1F9TZzgNY7CBfMHMapWmfNQQPFn6QfU
	fwpCi3rLdhdmPDRlmASE9KhwcxgukQr/BfWoE0ZLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsVy+t/xe7qvYjPTDXZ/ZLY4cX0Rk8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFlc+fqezWLd0wvsFi/2NrJYXFsxl92i+dh6NouXs+6xWXzsucdq
	cXnXHDaLz71HGC22fW5hs1h75C67xfqv85ksFn7cymKxZMcuRou2zmWsFhdPuVrcvXeCxeLl
	5R5mi7ZZ/Bb/9+xgt/h3bSOLxex3+9kttryZyGpxfG24Rcv+KSwOch7vb7Sye7x5+ZLF43DH
	F3aPvd8WsHjsnHWX3aNn5xlGj02rOtk87lzbw+Yx72Sgx/3u40wem5fUe7SsPcbk0f/XwOP9
	vqtsHn1bVjF6XGq+zh4gFKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
	k5Kak1mWWqRvl6CXcXTbGuaCKZwVLdPXsDcwnmbvYuTkkBAwkdjVfJ+1i5GLQ0hgKaPE1UOz
	mCASMhLXul+yQNjCEn+udbFBFL1ilPg3dw0jSIJNwEjiwfL5rCC2iMBiFom9+ypBipgF3jJK
	XJ+5EaxbWMBP4vy0uWANLAKqEj8v7wFr4BWwl2hp7oE6Q15i/8GzzCA2p4CDxJquG2D1QkA1
	/059YIOoF5Q4OfMJ2ExmoPrmrbOZJzAKzEKSmoUktYCRaRWjSGppcW56brGhXnFibnFpXrpe
	cn7uJkZggtl27OfmHYzzXn3UO8TIxMF4iFGCg1lJhPeQUGa6EG9KYmVValF+fFFpTmrxIUZT
	oLsnMkuJJucDU1xeSbyhmYGpoYmZpYGppZmxkjiv2+XzaUIC6YklqdmpqQWpRTB9TBycUg1M
	Ur82Sx+ev+PgTNW5/30s3kpMcHNM0F176/vefr5i1cu3tOVe/s09oSu5+rfcpuOei09deTHZ
	vzmc736E65eyz77PzDLWG53Le/7fYn6HHJfFi787am+wtC1mjmZefuvS638ptZ/+SL0IPPG0
	cnOMm7Duc8cT66Y5r2+YVlV8PbL8mtiRi+vuCJp82OOU+GFLz+xSDamdJ5x4lTP23H3Co7ho
	z8I9LzcZHw+91Ckzr0jtLduOSjGFdRVTzsxQ6vRbfsmb9fTLU5fZvPOiD/2tKj3tvVmA+8BU
	+Yh9GZc2rX419U4v+8WauA0a7P7zFSZEbRWN8I+PPOi65FrfZrYp8Yq7FkZcu+jnvXttS7x3
	ywUlluKMREMt5qLiRADvTtLnuQMAAA==
X-CMS-MailID: 20241223125610eucas1p2721f8a199bc6ff16345b3b46fc44dd63
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241223125610eucas1p2721f8a199bc6ff16345b3b46fc44dd63
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241223125610eucas1p2721f8a199bc6ff16345b3b46fc44dd63
References: <20241223125553.3527812-1-m.wilczynski@samsung.com>
	<CGME20241223125610eucas1p2721f8a199bc6ff16345b3b46fc44dd63@eucas1p2.samsung.com>

T-Head SoCs feature separate power domains (power islands) for major
components like the GPU, Audio, and NPU. To manage the power states of
these components effectively, the kernel requires generic power domain
support.

This commit enables `CONFIG_PM_GENERIC_DOMAINS` for T-Head SoCs,
allowing the power domain driver for these components to be compiled and
integrated. This ensures proper power management and energy efficiency
on T-Head platforms.

By selecting `PM_GENERIC_DOMAINS`, we provide the necessary framework
for the power domain drivers to function correctly on RISC-V
architecture with T-Head SoCs.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/Kconfig.socs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index f51bb24bc84c..c414dc618b66 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -48,6 +48,7 @@ config ARCH_THEAD
 	bool "T-HEAD RISC-V SoCs"
 	depends on MMU && !XIP_KERNEL
 	select ERRATA_THEAD
+	select PM_GENERIC_DOMAINS if PM
 	help
 	  This enables support for the RISC-V based T-HEAD SoCs.
 
-- 
2.34.1



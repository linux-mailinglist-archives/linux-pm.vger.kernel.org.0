Return-Path: <linux-pm+bounces-23881-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10EBA5CBF8
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 18:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C9C43A66BC
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 17:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC8E262D10;
	Tue, 11 Mar 2025 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IiOQlHtN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94972627EA
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713639; cv=none; b=Bc9FLClOvDcjdtI3rVZE9GZ3oYCmSMPQIY6vfFGYbtdJ7KfrJT4LwtgWW5Ud4ATXrdZst/F1WKLjOqerzaLNyXS4v9PJ8BjWpcac9MW3pP+OvjB/o55G/O8y0X/oaZZiA/rsMoeITCj8ZQJkxaRBKOov8cgi+sMYdtFHzzxIym0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713639; c=relaxed/simple;
	bh=LjNeeGPZTSfwAfwVgmY6/aONFof+BNi8pWf8VZUD+9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=gbxwOJq4XZu8DZrVu+qHrda48DtUlaGfyb8Qdb5841z0xzbBMDpC9Ffzq44bKtZwfTnu+DFz2rgVcPGmGaYkUPZQFV5dg5lCXI91Nwf/3iyf9jhINjz7fNuHXYZ19Tqfco4YR4mzlaiEEFfPQlqsVjdytC+SXaJuXwJbSHpP8RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IiOQlHtN; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250311172036euoutp01f38483077b58a87116909668fb23fff4~rz1Lz4jDA1502815028euoutp01n
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 17:20:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250311172036euoutp01f38483077b58a87116909668fb23fff4~rz1Lz4jDA1502815028euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741713636;
	bh=GvH+KGxOLMWPvCT3kvkzzW6sq/iRIHCpZUQmHgtdxxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IiOQlHtNB51SC7eX8KYn8qWCoQTHXB/XyjAZ9WBbzwZX4iYOg4hm1ougDaRQt3t65
	 x5vca79kVf9HNMadosTT5Qzp8Cw7eZmRAKORs6lUMeewZy3k0GX7kqTMFmK6voSpxm
	 pj8qG39IunaWK/MEabniNl+6G9gAZnCcSglWGSW0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250311172035eucas1p2f546acc75978c00e060391728e270e44~rz1Lc-kkL1590515905eucas1p2J;
	Tue, 11 Mar 2025 17:20:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id F8.A8.20821.3E070D76; Tue, 11
	Mar 2025 17:20:35 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250311172035eucas1p104dcbae706bec735194a1dc4a30db969~rz1LD3aGT0275502755eucas1p1t;
	Tue, 11 Mar 2025 17:20:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250311172035eusmtrp1c23ab61a4f5a1e521b1aaed8e93190f4~rz1LDPBge1317913179eusmtrp1T;
	Tue, 11 Mar 2025 17:20:35 +0000 (GMT)
X-AuditID: cbfec7f2-b11c470000005155-4c-67d070e38e80
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id A5.BD.19654.3E070D76; Tue, 11
	Mar 2025 17:20:35 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250311172034eusmtip2064f8a52aed6e394724f5720883fe29c~rz1KHZEfr1726717267eusmtip2-;
	Tue, 11 Mar 2025 17:20:34 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	jszhang@kernel.org, ulf.hansson@linaro.org, m.szyprowski@samsung.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Michal
	Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v8 5/5] riscv: Enable PM_GENERIC_DOMAINS for T-Head SoCs
Date: Tue, 11 Mar 2025 18:19:00 +0100
Message-Id: <20250311171900.1549916-6-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311171900.1549916-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djPc7qPCy6kG0z9rGbx7M5XVoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbJ4sbeRxaL52Ho2i5ez7rFZXN41h83ic+8RRottn1vYLNYeuctu
	sf7rfCaLl5d7mC3aZvFb/N+zg93i+Npwi5b9U1gchDzevHzJ4nG44wu7x70T01g9Nq3qZPO4
	c20Pm8fmJfUeLWuPMXm833eVzaNvyypGj0vN19k9Pm+SC+CO4rJJSc3JLEst0rdL4MqYvfYM
	U8EUzoqe3RfYGhhPs3cxcnJICJhITJ//hq2LkYtDSGAFo8Sbjs2sEM4XRomJL09DZT4zShzZ
	1MME0zL73AF2iMRyRomtlz4wQThvGCXOtB1gA6liEzCSeLB8PtgsEYF+Jom+I//BHGaBlYwS
	9y+cZe5i5OAQFvCQ6HirDtLAIqAqcfnhU0YQm1fAXuJVwzUWiHXyEvsPgpRzcnAKOEh83rYC
	qkZQ4uTMJ2A1zEA1zVtnM4PMlxDYzCkxY/Y8NohmF4mZ0x5AvSos8er4FihbRuL05B6oBfkS
	D7Z+YoawayR29hyHsq0l7pz7xQZyJ7OApsT6XfoQYUeJR9s+s4KEJQT4JG68FYQ4gU9i0rbp
	zBBhXomONiGIajWJqT29cEvPrdgGDUQPiZnv97JOYFScheSZWUiemYWwdwEj8ypG8dTS4tz0
	1GLDvNRyveLE3OLSvHS95PzcTYzAhHj63/FPOxjnvvqod4iRiYPxEKMEB7OSCO9q2wvpQrwp
	iZVVqUX58UWlOanFhxilOViUxHkX7W9NFxJITyxJzU5NLUgtgskycXBKNTBFhDv0/3Q/f2jr
	LU5/g129z/X6Lq79YptUUaWf3vtr6aadrnMPmYmwJ7b+Wf9tX80Hhuc322VyeEU7eLR+3416
	wtkn2LDH9VPSnuk/XBzymPlMN54IiH8WVXJ0xcXLv7jfCv0PS/9eI7tcYz1rsfpszcyV1rf1
	Akr1FvE1Sxk4fPl855XTst8HVDzXbIi5Mk/lQWf1e5dtiwyfSTbd0IgXvRfExnhZaeoe2+Mu
	f3mfPV8rkhinY+b16wSvD2vjJzWPa4w7a1bcDIl9cXX64xkx3IK19dMfd59qlu1sk1p54cfN
	s4khIf7pZYG1LMd/Ls75PK3nmceJp/E/mhhSeyWTmferyzv57e7b80nMfJ8SS3FGoqEWc1Fx
	IgDPs1jA9wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xe7qPCy6kGzSf5bB4ducrq8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFm82NvIYtF8bD2bxctZ99gsLu+aw2bxufcIo8W2zy1sFmuP3GW3
	WP91PpPFy8s9zBZts/gt/u/ZwW5xfG24Rcv+KSwOQh5vXr5k8Tjc8YXd496Jaawem1Z1snnc
	ubaHzWPzknqPlrXHmDze77vK5tG3ZRWjx6Xm6+wenzfJBXBH6dkU5ZeWpCpk5BeX2CpFG1oY
	6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GXMXnuGqWAKZ0XP7gtsDYyn2bsYOTkk
	BEwkZp87AGRzcQgJLGWU+PfoGhNEQkbiWvdLFghbWOLPtS42iKJXjBIzZjxkBEmwCRhJPFg+
	nxUkISKwkEni6pQNzCAOs8BaRonDVy8BzeXgEBbwkOh4qw7SwCKgKnH54VOwZl4Be4lXDdeg
	NshL7D94lhnE5hRwkPi8bQVYjRBQzbbJXcwQ9YISJ2c+AatnBqpv3jqbeQKjwCwkqVlIUgsY
	mVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIExu62Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIryr
	bS+kC/GmJFZWpRblxxeV5qQWH2I0Bbp7IrOUaHI+MHnklcQbmhmYGpqYWRqYWpoZK4nzsl05
	nyYkkJ5YkpqdmlqQWgTTx8TBKdXApCwYyeJv/snyqzZ3h4Z0ns+6xLmSt2yrdq31+9HYu/lN
	pezqDRVz914wr4hcMvMdX6BiyfPehJ193x8vZt+1JPeJ+pNPykv37HU6v7X/7I2tl8r3HxHb
	yj/fdsIapbxPoSInJnNHGvJmJ/Q5HHr86avY/bdhk7r0Gi3bnqX3+xbsEJA2f6nS/v/2yVMp
	K375uApJW9/7zviifVlOD8usq5OmRkY+9/Ra4N+6n3FlEdfdWyu+H29ISBVhU1j3j/dGXkCk
	kWwd/wX+UrcL3cEGkcnH+XYsWuhu4/tMX+d+wG/WusnKmV3T327+8OrozbK9d87OabveNzdn
	s1mXDsP7963aif0TpxZvF/eaGCVzRYmlOCPRUIu5qDgRABO51fhmAwAA
X-CMS-MailID: 20250311172035eucas1p104dcbae706bec735194a1dc4a30db969
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250311172035eucas1p104dcbae706bec735194a1dc4a30db969
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250311172035eucas1p104dcbae706bec735194a1dc4a30db969
References: <20250311171900.1549916-1-m.wilczynski@samsung.com>
	<CGME20250311172035eucas1p104dcbae706bec735194a1dc4a30db969@eucas1p1.samsung.com>

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
index 1916cf7ba450..83833ded8908 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -53,6 +53,7 @@ config ARCH_THEAD
 	bool "T-HEAD RISC-V SoCs"
 	depends on MMU && !XIP_KERNEL
 	select ERRATA_THEAD
+	select PM_GENERIC_DOMAINS if PM
 	help
 	  This enables support for the RISC-V based T-HEAD SoCs.
 
-- 
2.34.1



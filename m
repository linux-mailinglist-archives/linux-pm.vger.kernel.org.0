Return-Path: <linux-pm+bounces-21053-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0131AA2128E
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 20:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56249165ABB
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 19:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3251F5609;
	Tue, 28 Jan 2025 19:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SnxOy01i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA071F37DC
	for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2025 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738093719; cv=none; b=WKF8weDSyLRP77YwQJCicDuZd6M43iMcjXaD1WiJEu3Lg6MA4jD4QdcpOlpu02qdIMpHMiniKUweuT+uLdH9ntm5gTLNovlk9K+L40KXbjYAi0gx0I5oDDMQJOsBL5kW1TjF8ApQnmf9nqMwKkwEMtZCg4WAeJc/hgVKuHbOSmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738093719; c=relaxed/simple;
	bh=LjNeeGPZTSfwAfwVgmY6/aONFof+BNi8pWf8VZUD+9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=sQbSiXjkJ3eYtTt9blbBMEmQXpx5CACKP+ej0zlmVG/l0jsBOFz45arjKZVrawetMok+JiWvKcsCQQVS0r0IOCVIlBcSouZz9C1+Papc4ivv8W6HCHJP0majsRCeMpaBUT07qLAlEYajJXBrsuSKOzk6iqlEMxyqRYZe3WXnSXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SnxOy01i; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250128194836euoutp024861c0cbaf9a85840f60680dde069d70~e8waugsdb0278302783euoutp02v
	for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2025 19:48:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250128194836euoutp024861c0cbaf9a85840f60680dde069d70~e8waugsdb0278302783euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738093716;
	bh=GvH+KGxOLMWPvCT3kvkzzW6sq/iRIHCpZUQmHgtdxxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SnxOy01idwZCQxjeXu7oZRZ7JQAMpImZaVmqn9sOcpKPuE8Mb8ngRrGctAQ5dukqQ
	 vAfRN/uPLIuHSHprhDunijGzTJB2ywljUHH5eXQH9XTpDzkE+LGny+UjZsbdmLF53s
	 lTnXvnbRhZqjO9bLSBCqUkhLl6M/h8ZpZkfwNiiA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250128194835eucas1p1706e00ae514b5bd95ce262b8a094ea95~e8wZoHDCE1601116011eucas1p1v;
	Tue, 28 Jan 2025 19:48:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 4A.A2.20397.29439976; Tue, 28
	Jan 2025 19:48:34 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250128194834eucas1p2f7581075b9f238c84e83c5fa210bc3ea~e8wY5FQXD2210922109eucas1p28;
	Tue, 28 Jan 2025 19:48:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250128194834eusmtrp20cde8efdfd5ef2c18bb7078830b7e71c~e8wY4VdD23008430084eusmtrp2a;
	Tue, 28 Jan 2025 19:48:34 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-d5-67993492d94c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 36.E0.19920.29439976; Tue, 28
	Jan 2025 19:48:34 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250128194832eusmtip167a13b0c44d313dc80857f97a9e2a371~e8wXlE_jb0756107561eusmtip1P;
	Tue, 28 Jan 2025 19:48:32 +0000 (GMT)
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
Subject: [PATCH v4 07/18] riscv: Enable PM_GENERIC_DOMAINS for T-Head SoCs
Date: Tue, 28 Jan 2025 20:48:05 +0100
Message-Id: <20250128194816.2185326-8-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128194816.2185326-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTVxjHc+69vfe2irtUFo5u2QJRiS68qR9OguJL3Hb34sL8gA7YpBmX
	wqAFWsDh2AShiFA2ZCxqYRYdgwZBoEKlCHYitBWx4Z1uA8YGysoYjFGMgwCjtG5++53/eZ7z
	e57k0LhQR26lY6XJnEwqivcmBYTO+I/Ft2jvZXFApTYImYeuYahxSUWh6lYLhtTtFh4a7W3A
	UP/CLIluPOqm0O+tmQQa1HxLoSxjLYlsqlESzSlHeaivuZRE8wXtAOnms0lU0z5CodoFNYau
	zjUSqLypGaCc8xU81NP5OhoZNRPI1qfEUY7qBbTa0kShlcF6ApXMGCjUMH2Bh0w1x1G2oZg4
	+Ao7a1VQ7LTNRrD3cu0U2/qkjGD1qhGKVeq7AKutOk+yw4MtJHvl/vvsL/kmjL1ZfobNrjFi
	7FfLAezsnQGS/bKhCrC9WUNUiDBMsC+Ki49N5WT+wZGCmJKaLiyxmP+p8nY3mQEeUHmAT0Nm
	L6xQn8XygIAWMhoAzyluAOfBDuBS05DrMA+g9soM71nL6k8a0sFCphJAdZWvk6cB1PzxmoNJ
	Zjccq1TzHM0ejIKAio7M9ZdwZhJA3UTpevdm5m1oHn+KO5hgtsOicj1wsBtzALbkqXCn7VVo
	uPtwnfnMQahd1hDOGnd4//LEOuNrNVmNJbhDAJkaAexSDri2OwJ7hjMxJ2+GU6YGV/4yXNWr
	XXkCHGv82yVLh3qlycVBcNiyuDYovSbYCWub/Z3xITjQVIA7YshsgtY/3Z0jbIJFuouu2A3m
	5gid1TvgN8qC/6QWjc4lZeF0tY1XCLxUzy2jem4Z1f/eMoBXAU8uRS4Rc/I9Uu6Un1wkkadI
	xX4fJ0i0YO1rP1gxLTQBzdScXxvAaNAGII17e7h9aLkkFrpFidJOc7KEk7KUeE7eBl6iCW9P
	t2sGhVjIiEXJXBzHJXKyZ7cYzd+agXmNn4v1ayO8L0Qv/9Wx+11ayJYvhayEfNSvL46+VGst
	Hqh/x55U8ES68bA9hjt5avG01DPp64sH8O6wrp5K02SRwB5+yxCwz+rrM7njRL2pL+NWp7ni
	i6XryIcOjPtxZUyTNBif9uLGMUPoYVFmWeJURODots+5laPcrmiyk+91PGJmIKrNf3wu7Q6z
	4ZPC5WMPk0O7fMKrfSMm76lvA2vdZ28FbK/79aw9/Y069oMOw6HFUFi4IcNmjezwcG/RbMv/
	XiYx9Dc/nYiN/CHuveuB+9ONN+35Yd89ku1/M2hLakyuR/dvfElw75GRE0cfW86E73wMkHEL
	2vPzXT1RmmoODvcm5DGiwF24TC76F71bPNJJBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsVy+t/xu7qTTGamG/xew2Fx4voiJoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbK48vU9m8W6pxfYLV7sbWSxuLZiLrtF87H1bBYvZ91js/jYc4/V
	4vKuOWwWn3uPMFps+9zCZrH2yF12i/Vf5zNZLPy4lcViyY5djBZtnctYLS6ecrW4e+8Ei8XL
	yz3MFm2z+C3+79nBbvHv2kYWi9nv9rNbbHkzkdXi+Npwi5b9U1gc5Dze32hl93jz8iWLx+GO
	L+wee78tYPHYOesuu0fPzjOMHptWdbJ53Lm2h81j3slAj/vdx5k8Ni+p92hZe4zJo/+vgcf7
	fVfZPPq2rGL0uNR8nT1AKErPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/O
	JiU1J7MstUjfLkEvY/baM0wFUzgrenZfYGtgPM3excjJISFgIvH/1gq2LkYuDiGBpYwSn76t
	gUrISFzrfskCYQtL/LnWBVX0ilHi7oMfbCAJNgEjiQfL57OC2CICi1kk9u6rBCliFnjLKHF9
	5kawbmEBL4kTj38wg9gsAqoSk5bsZASxeQXsJfZ0zWKG2CAvsf/gWTCbU8BBYtPfFWC9QkA1
	j97OYIOoF5Q4OfMJWJwZqL5562zmCYwCs5CkZiFJLWBkWsUoklpanJueW2yoV5yYW1yal66X
	nJ+7iRGYYLYd+7l5B+O8Vx/1DjEycTAeYpTgYFYS4Y09NyNdiDclsbIqtSg/vqg0J7X4EKMp
	0N0TmaVEk/OBKS6vJN7QzMDU0MTM0sDU0sxYSZzX7fL5NCGB9MSS1OzU1ILUIpg+Jg5OqQam
	jFeKB1Wv1AilM2jsDtYP/NBQtV9o4e0cvdApQesdDxRzvBd8devrkn3/G0p2Tfr7K3yDVGFl
	H+OOI7rGniceFTdtW/FISu0Re87Ts7Nb+mYZZjMZTwwrX/w62/hL+BT1ZWmTHn49uINrY+Kk
	cLGFzTY/DWtklmyrurvDavKU30EezEfvfD+yZb0xW/1U1V+7WlUlYyf9eXYoeC7XCd3+XcLT
	TN835i0+XC9kYPTmaOPefbve/Z3OySL7Rfjhe5GFz+PYcq5v0O/j9TMUED+z8YpH9OLftg3N
	ZueTGc+sOmVRcv5R8ZesIGbhsg/6p55N3vEy9PnGV2sWS60VaE3j0Tz+4XD9DhfXGqEo/xcX
	pZRYijMSDbWYi4oTAWPpytO5AwAA
X-CMS-MailID: 20250128194834eucas1p2f7581075b9f238c84e83c5fa210bc3ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250128194834eucas1p2f7581075b9f238c84e83c5fa210bc3ea
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250128194834eucas1p2f7581075b9f238c84e83c5fa210bc3ea
References: <20250128194816.2185326-1-m.wilczynski@samsung.com>
	<CGME20250128194834eucas1p2f7581075b9f238c84e83c5fa210bc3ea@eucas1p2.samsung.com>

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



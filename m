Return-Path: <linux-pm+bounces-23742-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1008A58ECB
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 10:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46C237A1583
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 09:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBADA224258;
	Mon, 10 Mar 2025 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j2/vNt6U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929D52236EE
	for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741597346; cv=none; b=i+HLZUPSKCp6qwXHS3Dw6BCJxZkRAwRAdCNNRnM01WAxZ4lX25Qchy48zeErSvaw7+bjUou4fI3kgSwq9vUJ9anP47D/DqE8iNwq63ylh+/d+AUGDDUIm4lsHwQ/k4oudJ5pz/5HS4Pn9CGwppoceXEoZzJZpnXPImwMylkMqSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741597346; c=relaxed/simple;
	bh=pGNvpqXz4dk2wpA68JlN4uRCgnPpRJDnASYBe9j8/IE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=UoFET/gLT6kFSk/JhysMwyo2K92P/VCemgbTEy2nH72cIJV64XFJpyHY1in8nurHJQv4y+voN20lw2XVi9l4VT+Qu1w0jCy1uxVLng13yAxcrjKk+LQ7V1JElxHnfCGa9sSPUNSLP1aIFLbtvxhduIQRx100E9gWD9MRw+rsGmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=j2/vNt6U; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250310090217euoutp01e623da7306acc435a8d0f59a4b293f53~rZY0Ncuu70939009390euoutp01T
	for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 09:02:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250310090217euoutp01e623da7306acc435a8d0f59a4b293f53~rZY0Ncuu70939009390euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741597337;
	bh=lWi4k7LoXBXBjEqfyhissO8ACphrRBwedlkg/6BKx6o=;
	h=From:To:Cc:Subject:Date:References:From;
	b=j2/vNt6U0hd/yovHuh0bdpiBqdyFVUaCqR4aCmpHe56O/HZ7Q8fkS53e3Vx0SbhBX
	 EezQtA3hXWtG8b0LqJrZEa8FUageb9gtzbY7xfiBk9Xtx4itTEjPeTmrRbl4R3fLRo
	 x5kj0qHc2J3mLg9heGWAjwYR7umjAYe7oG7M6lho=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250310090216eucas1p174d4234a585a6d02aff24b7e758e7059~rZYzxjHK40821608216eucas1p1o;
	Mon, 10 Mar 2025 09:02:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 0F.87.20397.89AAEC76; Mon, 10
	Mar 2025 09:02:16 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250310090216eucas1p1b2f476904cad548ebe9066b10c43a0a0~rZYzYwDuC0649306493eucas1p1t;
	Mon, 10 Mar 2025 09:02:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250310090216eusmtrp2b069f674cd1cb62f20abc594b3a1af01~rZYzX-jbh2373823738eusmtrp2Y;
	Mon, 10 Mar 2025 09:02:16 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-d6-67ceaa98b0f7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id ED.D5.19920.89AAEC76; Mon, 10
	Mar 2025 09:02:16 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250310090215eusmtip23dc7fd24a78cbed62d1d8ab2411b8342~rZYyWcdKW2591825918eusmtip2H;
	Mon, 10 Mar 2025 09:02:15 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	jszhang@kernel.org, ulf.hansson@linaro.org, m.szyprowski@samsung.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Michal
	Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v7 0/5] TH1520 SoC: Add AON firmware & power-domain support
Date: Mon, 10 Mar 2025 10:02:06 +0100
Message-Id: <20250310090211.286549-1-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7djP87ozVp1LN3j10cTi2Z2vrBZbf89i
	t1iz9xyTxfwj51gt7l3awmTxYm8ji0XzsfVsFi9n3WOzuLxrDpvF594jjBbbPrewWaw9cpfd
	Yv3X+UwWLy/3MFu0zeK3+L9nB7vF8bXhFi37p7A4CHm8efmSxeNwxxd2j3snprF6bFrVyeZx
	59oeNo/NS+o9WtYeY/J4v+8qm0ffllWMHpear7N7fN4kF8AdxWWTkpqTWZZapG+XwJXRtW82
	W8EMqYplEw+wNDAeFeli5OSQEDCRmHF1P3MXIxeHkMAKRolTv/oYQRJCAl8YJbYtCoGwPzNK
	HLukCNNwovUBG0TDckaJhpe7obrfADW8/QTWzSZgJPFg+XxWkISIQD+TRN+R/2AOs8BKRon7
	F84CtXBwCAt4S2x4FAzSwCKgKrHo4V4mEJtXwE5i1ror7BDr5CX2HwQpB4kLSpyc+YQFxGYG
	ijdvnQ22WUJgPqfEpadLGCEaXCT+TbnBBGELS7w6vgVqkIzE/53zoeL5Eg+2fmKGsGskdvYc
	h7KtJe6c+8UGchuzgKbE+l36EGFHiYNdC9hBwhICfBI33gpCnMAnMWnbdGaIMK9ER5sQRLWa
	xNSeXril51Zsg1rqIfF3w2tWSIDGSlxZMZFxAqPCLCSPzULy2CyEGxYwMq9iFE8tLc5NTy02
	zkst1ytOzC0uzUvXS87P3cQITIan/x3/uoNxxauPeocYmTgYDzFKcDArifCqbT+VLsSbklhZ
	lVqUH19UmpNafIhRmoNFSZx30f7WdCGB9MSS1OzU1ILUIpgsEwenVANT7XkhiVlb7dde/nGn
	58UUxYVMTxZIPbx16ebZHXeEd+69s7lQtEVse9LVE1demyxQkBGJcXiYvTPobblE1tSFRb5p
	tnfYG/sV+09cOzg96rLQhzcbbyprNH0KTWjxn2Hi/XhGpojM0uYnJfoJ+38oZGRPe7uhu05Y
	vM5GkUk6o7JsU5v5FnXd+5PXPZ/cw6U9bYNFv/w0mT3Wy0tDfP2eSJR6aoeomF/UfbtX9PY9
	pRDBVvdVixr74vZMtry4THeS5dIXk64c4d7w7H7JapXns9IUXM4sMNA6nrTDformD87Jos+k
	7Av/PujUP5+/jlEtfNvP69GnizbkZT8yvy1a6jB35Q6h3oyiuYvaWQ7IKbEUZyQaajEXFScC
	AA9LPUT1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xe7ozVp1LN2i+KGrx7M5XVoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbJ4sbeRxaL52Ho2i5ez7rFZXN41h83ic+8RRottn1vYLNYeuctu
	sf7rfCaLl5d7mC3aZvFb/N+zg93i+Npwi5b9U1gchDzevHzJ4nG44wu7x70T01g9Nq3qZPO4
	c20Pm8fmJfUeLWuPMXm833eVzaNvyypGj0vN19k9Pm+SC+CO0rMpyi8tSVXIyC8usVWKNrQw
	0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mvo2jebrWCGVMWyiQdYGhiPinQxcnJI
	CJhInGh9wNbFyMUhJLCUUWLu6X2MEAkZiWvdL1kgbGGJP9e6oIpeMUp83/eTCSTBJmAk8WD5
	fFaQhIjAQiaJq1M2MIM4zAJrGSUOX73E3sXIwSEs4C2x4VEwSAOLgKrEood7wZp5BewkZq27
	wg6xQV5i/8GzzBBxQYmTM5+AbWYGijdvnc08gZFvFpLULCSpBYxMqxhFUkuLc9Nziw31ihNz
	i0vz0vWS83M3MQJjcduxn5t3MM579VHvECMTB+MhRgkOZiURXrXtp9KFeFMSK6tSi/Lji0pz
	UosPMZoC3TeRWUo0OR+YDPJK4g3NDEwNTcwsDUwtzYyVxHndLp9PExJITyxJzU5NLUgtgulj
	4uCUamDybvnzTHtRQS7/th2T0r51xO/ftXblGaEuBRn9juuJRbsV5m+/wjYlze3xgXCGArv9
	3PbnfZfKRFwzOyFrvnWGiGnCDgfVJp03Gy467ZpidrR1Q/nujNXxl++2lZcyJQS5t98Od1bl
	/Moe9MP8wYsbLX0OB9YsnfmnSq3mpXaeovVen7NxT/nFFFLnFE46aFG9YPrTsmypeVGX5E06
	5i5+ZvRPwmKvj6fSsS0LXv2Llzu5gK3z2qxnvO+WJ+0L1t0sbJum8mxJs+W9K+Ill0vjKnas
	uTJDOUP7RZEEK/Oj9rRzjX2LM+zWJSjy9nR8yLad6jh9pt0T14rYCAWHZam55/je8PIKh+d2
	Pb057Y0SS3FGoqEWc1FxIgDD2wo5TgMAAA==
X-CMS-MailID: 20250310090216eucas1p1b2f476904cad548ebe9066b10c43a0a0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250310090216eucas1p1b2f476904cad548ebe9066b10c43a0a0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250310090216eucas1p1b2f476904cad548ebe9066b10c43a0a0
References: <CGME20250310090216eucas1p1b2f476904cad548ebe9066b10c43a0a0@eucas1p1.samsung.com>

This patch series introduces and documents power management (PM) support and
the AON firmware driver for the T-Head TH1520 SoC, as used on the LicheePi 4A
board. While part of a larger effort to enable the Imagination BXM-4-64 GPU
upstream, these patches can merge independently.

Bigger series cover letter:
https://lore.kernel.org/all/20250219140239.1378758-1-m.wilczynski@samsung.com/

This series is versioned to maintain continuity with the bigger patchset it is
a subseries of. Please find below a changelog for the AON & power-domain:

v7:
- add '#include <linux/slab.h", due to kernel robot issue

v6:
- split the firmware & power-domain patches into a separate series

v5:
- changed the AON driver to be a set of library functions rather than a
  standalone driver

v4:
- added workaround to disable AUDIO power domain to prevent firmware crashes

v3:
 - consolidated device tree representation by merging aon and power-domain nodes
   while maintaining separate drivers internally
 - power-domain driver is now instantiated from within the aon driver
 - fixed optional module dependencies in Kconfig
 - added kernel-doc comments for all exported functions
 - implemented th1520_aon_remove() to properly clean up mailbox channel
   resources

v2:
 - introduced a new firmware driver to manage power-related operations.
 - rewrote the power-domain driver to function alongside the firmware driver.
   These nodes in the device tree lack direct address spaces, despite
   representing HW blocks. Control is achieved via firmware protocol messages
   transmitted through a mailbox to the E902 core.
 - added new dt-bindings for power and firmware nodes.
 - ran dtbs_check and dt_binding_check to ensure compliance.

Michal Wilczynski (5):
  dt-bindings: firmware: thead,th1520: Add support for firmware node
  firmware: thead: Add AON firmware protocol driver
  dt-bindings: power: Add TH1520 SoC power domains
  pmdomain: thead: Add power-domain driver for TH1520
  riscv: Enable PM_GENERIC_DOMAINS for T-Head SoCs

 .../bindings/firmware/thead,th1520-aon.yaml   |  53 ++++
 MAINTAINERS                                   |   5 +
 arch/riscv/Kconfig.socs                       |   1 +
 drivers/firmware/Kconfig                      |   9 +
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/thead,th1520-aon.c           | 248 ++++++++++++++++++
 drivers/pmdomain/Kconfig                      |   1 +
 drivers/pmdomain/Makefile                     |   1 +
 drivers/pmdomain/thead/Kconfig                |  12 +
 drivers/pmdomain/thead/Makefile               |   2 +
 drivers/pmdomain/thead/th1520-pm-domains.c    | 209 +++++++++++++++
 .../dt-bindings/power/thead,th1520-power.h    |  19 ++
 .../linux/firmware/thead/thead,th1520-aon.h   | 200 ++++++++++++++
 13 files changed, 761 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
 create mode 100644 drivers/firmware/thead,th1520-aon.c
 create mode 100644 drivers/pmdomain/thead/Kconfig
 create mode 100644 drivers/pmdomain/thead/Makefile
 create mode 100644 drivers/pmdomain/thead/th1520-pm-domains.c
 create mode 100644 include/dt-bindings/power/thead,th1520-power.h
 create mode 100644 include/linux/firmware/thead/thead,th1520-aon.h

-- 
2.34.1



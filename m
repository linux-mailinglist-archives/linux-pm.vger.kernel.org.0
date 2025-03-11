Return-Path: <linux-pm+bounces-23879-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CE1A5CBEC
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 18:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858E8189AEFE
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 17:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57302620D3;
	Tue, 11 Mar 2025 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NgsMK19h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8102525FA33
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713635; cv=none; b=Sgsi2S04q1UYyK49K7izYVXHYY0znn7uV+ZHnm8nYf1E19UxCiaB9/ffIhnvYdorGMXBIYjYsSTZczepRQ4qqimADuCx1DvBroQehLMS3uQ88fsL/qMHN26bD+97dao899IVQJGKgieaqAvoEdVd0ub+WLdTKmV8pfDEhrAFw/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713635; c=relaxed/simple;
	bh=cqRDQk49pQnCNBdduEN2ViIUnnwVn+gFTorUUat7c3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=OCW0Z+KltJbBoXRfWeBwUNIfOwwZl1RJR3BSyWSGIpXdLQuveYareQzJmQPyT0OzYIJNH4hgkc7BPXlZqXwUamGSm8vC+uV243xv/Ofjo6cvRabQhcFs72JyuUYj21G9RPUxgX3szMuc0SJHNYeyidkY83byXNOllx9clEBZSRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NgsMK19h; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250311172031euoutp023ec7a3c82ce41c0ac45fd3780b1e37ea~rz1Hz-gAX0088300883euoutp02a
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 17:20:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250311172031euoutp023ec7a3c82ce41c0ac45fd3780b1e37ea~rz1Hz-gAX0088300883euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741713631;
	bh=Qlohb9JKbtO4uiZFuAyCmdw6tJUigC1Uh/invtMSMJA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=NgsMK19hRdWDbWIZ0t+4Wq7XG2HMejSvLQOqi2ke8THrCd9MZag3eYwsParVIhoeT
	 ky6J+1JF/tEy2zDGbWYadEnX6g3rQUM5ouCG9GGopRNSj0PIxt7cEAClep0jQrRJ3W
	 dlMLpjvUrllAccJIynDFx9/jJ5ohb44Z0O/wu7Xs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250311172031eucas1p2cced726be6dbab4d63f977670e923f2b~rz1HWABJu1590515905eucas1p2F;
	Tue, 11 Mar 2025 17:20:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id D1.A8.20821.FD070D76; Tue, 11
	Mar 2025 17:20:31 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250311172030eucas1p12dda42760f751174e774b8d1a3d3f4cd~rz1G4ZCRe2505725057eucas1p1b;
	Tue, 11 Mar 2025 17:20:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250311172030eusmtrp2b41e2f7814b51931b2532a8959ed23da~rz1G3nWEs1824318243eusmtrp2M;
	Tue, 11 Mar 2025 17:20:30 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-3d-67d070df0856
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 00.A4.19920.ED070D76; Tue, 11
	Mar 2025 17:20:30 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250311172029eusmtip29abd30e5b1d03c2dd59efc6d75075b3b~rz1F62c0Z1727317273eusmtip2a;
	Tue, 11 Mar 2025 17:20:29 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	jszhang@kernel.org, ulf.hansson@linaro.org, m.szyprowski@samsung.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Michal
	Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v8 0/5] TH1520 SoC: Add AON firmware & power-domain support
Date: Tue, 11 Mar 2025 18:18:55 +0100
Message-Id: <20250311171900.1549916-1-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djPc7r3Cy6kGyw4ym3x7M5XVoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbJ4sbeRxaL52Ho2i5ez7rFZXN41h83ic+8RRottn1vYLNYeuctu
	sf7rfCaLl5d7mC3aZvFb/N+zg93i+Npwi5b9U1gchDzevHzJ4nG44wu7x70T01g9Nq3qZPO4
	c20Pm8fmJfUeLWuPMXm833eVzaNvyypGj0vN19k9Pm+SC+CO4rJJSc3JLEst0rdL4MqY83Yq
	a8F76YpVq1waGD+LdjFyckgImEj83POfvYuRi0NIYAWjxJVVe9kgnC+MEjsef2CBcD4zSlw/
	epIVpqXj8VFGiMRyRon+Ew+hWt4wSiw718AMUsUmYCTxYPl8VpCEiEA/k0Tfkf9gDrPASkaJ
	+xfOglUJC3hLHLrXDGRzcLAIqEr8nKkFEuYVsJf4uPIiG8Q6eYn9ByHKeQUEJU7OfMICYjMD
	xZu3zmYGmSkhsJhT4tLvG4wQDS4S7//NgLpVWOLV8S3sELaMxP+d85kg7HyJB1s/MUPYNRI7
	e45D2dYSd879YgO5h1lAU2L9Ln2IsKPEw8sNTCBhCQE+iRtvBSFO4JOYtG06M0SYV6KjTQii
	Wk1iak8v3NJzK7ZBLfWQ2H3zJlhcSCBWYs/PS0wTGBVmIXlsFpLHZiHcsICReRWjeGppcW56
	arFhXmq5XnFibnFpXrpecn7uJkZgOjz97/inHYxzX33UO8TIxMF4iFGCg1lJhHe17YV0Id6U
	xMqq1KL8+KLSnNTiQ4zSHCxK4ryL9remCwmkJ5akZqemFqQWwWSZODilGphSbona/guqrtc5
	6Tvp9oFPq013WCkHv3p8QOJrw5qy8/d4v5QeP7hx7YkHZx/2Klzpm1h14c9WXV31gDMe6+/N
	yH0ortV2LcMojt9S80F+0MaOTz+tOD68ux0QdX7SirQP37+Jvs90/vq/c7dl3p5Mp3imlTUc
	xuIaAYpX1qoFCNdOY6+4NfHNbKWg/ipFwzcOe7cWsh3jeaC6J7blkazItj/2DSsPsUQJ5Md8
	+HJ1SajEVuUTr8Odvfic32TfXfR0bra1y96ImzXZV9mE70nInAx84v9ExlVJoKnjk9mjOG6j
	c1+nKhv7lh+8Nu96otdX6X3Fp9VvuCTE2y7UOZEw/d/ne8s7Tx+X3z/53rl7SizFGYmGWsxF
	xYkA84kkRfYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xe7r3Ci6kG5y7q2nx7M5XVoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbJ4sbeRxaL52Ho2i5ez7rFZXN41h83ic+8RRottn1vYLNYeuctu
	sf7rfCaLl5d7mC3aZvFb/N+zg93i+Npwi5b9U1gchDzevHzJ4nG44wu7x70T01g9Nq3qZPO4
	c20Pm8fmJfUeLWuPMXm833eVzaNvyypGj0vN19k9Pm+SC+CO0rMpyi8tSVXIyC8usVWKNrQw
	0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MuY83Yqa8F76YpVq1waGD+LdjFyckgI
	mEh0PD7K2MXIxSEksJRRovnuVkaIhIzEte6XLBC2sMSfa11sEEWvGCV2H3nPBpJgEzCSeLB8
	PitIQkRgIZPE1SkbmEEcZoG1jBKHr15iB6kSFvCWOHSvGSjBwcEioCrxc6YWSJhXwF7i48qL
	bBAb5CX2HzzLDBEXlDg58wnYZmagePPW2cwTGPlmIUnNQpJawMi0ilEktbQ4Nz232FCvODG3
	uDQvXS85P3cTIzAStx37uXkH47xXH/UOMTJxMB5ilOBgVhLhXW17IV2INyWxsiq1KD++qDQn
	tfgQoynQeROZpUST84GpIK8k3tDMwNTQxMzSwNTSzFhJnNft8vk0IYH0xJLU7NTUgtQimD4m
	Dk6pBqYN7h/0I0I+q0VVZ6+5smBWy8TMm1sfvZ5rLfIv2e3wybi002fLaz7Ux1tPmP6XNTOV
	68kkrrVz0hceOnA2Rbs5UHLt0ynVW4pZ15quW35mo+CtTecbJ5mdO3by/o3m5X+WKG1pyWfw
	2Xlgk/O5JxEXtK5yr+e/vaV1Rs1P6Z9nxBbua1QwiW0WjuZYv0Wcd+6yf95hZU9+BuxfP5F1
	i9uizC89TJtynPJY9rb/tfuqz3p3t+ZzzStsk46YTFhxyrhD5J3EwUsTmQ9GGXy3mm/zfu/M
	+fV77c3qdt9xtdyU/5NBvtb8QsBx3xWHPqg1/Cw6vyHyRtw8jYdr5hf9UKtQOOkr5V+pcEP4
	4Ns9ZUf8byuxFGckGmoxFxUnAgAEMTNKTQMAAA==
X-CMS-MailID: 20250311172030eucas1p12dda42760f751174e774b8d1a3d3f4cd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250311172030eucas1p12dda42760f751174e774b8d1a3d3f4cd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250311172030eucas1p12dda42760f751174e774b8d1a3d3f4cd
References: <CGME20250311172030eucas1p12dda42760f751174e774b8d1a3d3f4cd@eucas1p1.samsung.com>

This patch series introduces and documents power management (PM) support and
the AON firmware driver for the T-Head TH1520 SoC, as used on the LicheePi 4A
board. While part of a larger effort to enable the Imagination BXM-4-64 GPU
upstream, these patches can merge independently.

Bigger series cover letter:
https://lore.kernel.org/all/20250219140239.1378758-1-m.wilczynski@samsung.com/

This series is versioned to maintain continuity with the bigger patchset it is
a subseries of. Please find below a changelog for the AON & power-domain:

v8:
- add proper cleanup in the th1520_pd_probe()
- add "suppress_bind_attrs = true", since there is no need to unbound the driver
  during runtime. This simplifies the code by eliminating the remove function

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
 drivers/pmdomain/thead/th1520-pm-domains.c    | 218 +++++++++++++++
 .../dt-bindings/power/thead,th1520-power.h    |  19 ++
 .../linux/firmware/thead/thead,th1520-aon.h   | 200 ++++++++++++++
 13 files changed, 770 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
 create mode 100644 drivers/firmware/thead,th1520-aon.c
 create mode 100644 drivers/pmdomain/thead/Kconfig
 create mode 100644 drivers/pmdomain/thead/Makefile
 create mode 100644 drivers/pmdomain/thead/th1520-pm-domains.c
 create mode 100644 include/dt-bindings/power/thead,th1520-power.h
 create mode 100644 include/linux/firmware/thead/thead,th1520-aon.h

-- 
2.34.1



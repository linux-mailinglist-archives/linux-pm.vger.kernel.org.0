Return-Path: <linux-pm+bounces-24994-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A509A8210D
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 11:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84A887AB3EE
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 09:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B0A25C6F1;
	Wed,  9 Apr 2025 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UnBUVMvP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D3E2B2DA
	for <linux-pm@vger.kernel.org>; Wed,  9 Apr 2025 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744191041; cv=none; b=U8sCZpQVjDMg9sMvp90WiCi5mZ6eusY7eeJ4QMcapSQgSYM85k2u0V4m0AiLUItJG36kjYy7HGjLPZheWDI7PUoK9hE49N/jbmrXGnVBJ05NHulkPbUcV/h7v5/POgk3TqK9r2jJ77tGq7TXrv4KyY/epEKfPdX6LTjar3SMblE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744191041; c=relaxed/simple;
	bh=4vxC+5eNcwZIu0PwTnXch0E3sKvKER5yxktwxbFDE6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=KU/Vln/5xBqiCOViJUfk40NJn3j4C1mLGQG3D2vyCf7i5PblWWfmwRxdi31xKGMhPhzFR3I1x0T/eB1O5ru6D6LVTNycP4gkNg+A+c2z6qD0lGsydLj2aKztoliYYujBCMe8Pvy6ZgDC9YK3vfDyhPV5Y2oYTPcUgzWK+apJ3qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UnBUVMvP; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250409093031euoutp02aa58cea33ae5e095ff2a55ccace26fbd~0nICM6ixN2373223732euoutp02R
	for <linux-pm@vger.kernel.org>; Wed,  9 Apr 2025 09:30:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250409093031euoutp02aa58cea33ae5e095ff2a55ccace26fbd~0nICM6ixN2373223732euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744191031;
	bh=Y0arb6a2cUUbDBbem7ZVwaSlN4egRmPACY0ozOv7H2w=;
	h=From:To:Cc:Subject:Date:References:From;
	b=UnBUVMvPJQCsyrgqpMkYrX0AQwrOn875k7k+BfYO8WChGmr7KT8nknhUEO96uQlSc
	 305ZPEV3zK/BYoStBjNyTnPBL4Q5HzJ2bjXWPcST1bymHufWk3DMx61PMBr1G3JKYX
	 y5cxxyMqH8fNGL7LaPpBiQT43JH4pMnwPDzp1/fo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250409093031eucas1p18aeaff17a1a24ce28a96f976ab1644d1~0nIBv9TF62724127241eucas1p1S;
	Wed,  9 Apr 2025 09:30:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 2E.6D.20409.73E36F76; Wed,  9
	Apr 2025 10:30:31 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250409093030eucas1p174de911d268d13d4aef336117d3c326f~0nIBLCLzq2501725017eucas1p1a;
	Wed,  9 Apr 2025 09:30:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250409093030eusmtrp22036d8199d64ed5d39d4e9bd4a972ba7~0nIBKMh3h2888728887eusmtrp2T;
	Wed,  9 Apr 2025 09:30:30 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-45-67f63e3775b4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 72.2D.19654.63E36F76; Wed,  9
	Apr 2025 10:30:30 +0100 (BST)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250409093029eusmtip28b871a7be9c1416042d89926617617a7~0nIAh6GCJ0408304083eusmtip2l;
	Wed,  9 Apr 2025 09:30:29 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, ulf.hansson@linaro.org,
	p.zabel@pengutronix.de, m.szyprowski@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v1 0/2] Add GPU clock/reset management for TH1520 in genpd
Date: Wed,  9 Apr 2025 11:30:23 +0200
Message-Id: <20250409093025.2917087-1-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djPc7rmdt/SDT5/YLFYs/cck8W9S1uY
	LF7sbWSxeDnrHpvF5V1z2Cw+9x5htNj2uYXNYu2Ru+wW67/OZ7K4e+8Ei8X/PTvYLY6vDbdo
	2T+FxYHXY9OqTjaPO9f2sHlsXlLv0bL2GJNH/18Dj/f7rrJ59G1ZxejxeZNcAEcUl01Kak5m
	WWqRvl0CV8ahq2eYC77xVRw+9oexgfEUTxcjJ4eEgInEhOnPWboYuTiEBFYwSqy58okNwvnC
	KPHz9gYmCOczo8TLO5MZYVq6f+6EalnOKHF81xNGCOcNo8TU37vYQKrYBIwkHiyfzwqSEBHY
	yyjReeoDM4jDLNDNKLF22w1WkCphAS+JJ103wOayCKhKXJ90HqybV8Be4uKnVmaIffIS+w+e
	ZYaIC0qcnPmEBcRmBoo3b50NNlRC4AGHREtnGztEg4tEx90eVghbWOLV8S1QcRmJ/zvnM0HY
	+RIPtn6CWlAjsbPnOJRtLXHn3C+gIziAFmhKrN+lDxF2lHjy6Cg7SFhCgE/ixltBiBP4JCZt
	m84MEeaV6GgTgqhWk5ja0wu39NyKbVBLPSQuHu4Fs4UEYiXeH3rPMoFRYRaSx2YheWwWwg0L
	GJlXMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBKaw0/+Of9nBuPzVR71DjEwcjIcYJTiY
	lUR43078ki7Em5JYWZValB9fVJqTWnyIUZqDRUmcd9H+1nQhgfTEktTs1NSC1CKYLBMHp1QD
	k5b2+8kfraW1rXsa7k/ebMdeyc08vTBmZoCgvt7sw1XbhJ7Obs7cJX9Gcbukn/UzQV2pFYeE
	ivf8LF2WPPdGlKBY7zX2/p7DcuKFMTd3bsvs3bR/Qc/Bs35b9QPN7ictXVu1kz/BZNdak/DH
	oRkZh61zOe6mpX9kt7aU8NPg9ElZzB6YY7Dn002pPTtyj/t0fLZkyhaaWt9lVnjwbfeRjXze
	t0+5H793M0z20J36cEbTiVk1zRrsh4ujbbY+bevUfFA3e4vBwn3M55l6ba6wesxt3udbv69w
	23z33Ju9O4+Z1AWevlQx5+3L1/Y5WTf3clbZpGrrRl90sWW7y+afUtvEN/nX+Y33n2aoCvoo
	sRRnJBpqMRcVJwIAGULQDtADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsVy+t/xe7pmdt/SDfoPS1us2XuOyeLepS1M
	Fi/2NrJYvJx1j83i8q45bBafe48wWmz73MJmsfbIXXaL9V/nM1ncvXeCxeL/nh3sFsfXhlu0
	7J/C4sDrsWlVJ5vHnWt72Dw2L6n3aFl7jMmj/6+Bx/t9V9k8+rasYvT4vEkugCNKz6Yov7Qk
	VSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+PQ1TPMBd/4Kg4f
	+8PYwHiKp4uRk0NCwESi++dOli5GLg4hgaWMEttWzWGDSMhIXOt+yQJhC0v8udbFBlH0ilHi
	1uYbrCAJNgEjiQfL54PZIgInGSXuvqoDKWIW6GeUmPrxClhCWMBL4knXDUYQm0VAVeL6pPNg
	G3gF7CUufmplhtggL7H/4FlmiLigxMmZT8A2MwPFm7fOZp7AyDcLSWoWktQCRqZVjCKppcW5
	6bnFRnrFibnFpXnpesn5uZsYgbGz7djPLTsYV776qHeIkYmD8RCjBAezkgjv24lf0oV4UxIr
	q1KL8uOLSnNSiw8xmgLdN5FZSjQ5Hxi9eSXxhmYGpoYmZpYGppZmxkrivGxXzqcJCaQnlqRm
	p6YWpBbB9DFxcEo1MEkvCg1R6U8O8VWo+mLpnVPXvq6n68i7V5M0mVtVfpc++/jcSK1qzh2X
	VJaJm+wXHDQImfTTRG/6W5fQWs7KigMHzshERrxxE9pQUi3kdOQV2/7kvqQ+F22hUxF72Pc/
	yXQMTOuYx7RLTPvXz5rTlzhraqW3iE79IT3x1+QNOlcqQ9+EXbRWe9B7fevrLLE/q4xdt3ra
	LVGLjTv9rSztZIUDQ9bS/9knpZSeCM3hWvnmwsofBcUptS7zQ9d+F5O9uTjR4OBJe4mUNa8i
	pp5YoeJ05bugiILL5Oqke1Vnep+fnN15derOg8vPcPydoHz56U8//k0r1M6/arevET6qLNHz
	KFTJ/+PRrXdvZO+xyFBiKc5INNRiLipOBACHESraJgMAAA==
X-CMS-MailID: 20250409093030eucas1p174de911d268d13d4aef336117d3c326f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250409093030eucas1p174de911d268d13d4aef336117d3c326f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250409093030eucas1p174de911d268d13d4aef336117d3c326f
References: <CGME20250409093030eucas1p174de911d268d13d4aef336117d3c326f@eucas1p1.samsung.com>

This small patch series adds clock and reset support for the GPU in the
T-HEAD TH1520 SoC through the generic power domain (genpd) framework.

The TH1520 GPU requires a special sequence involving multiple clocks and resets
to safely bring it out of reset. Coordinating this sequence properly is
necessary for correct GPU operation. Following discussions on the mailing list
with kernel maintainers [1], the recommended approach is to model this
complexity inside a power domain driver, keeping SoC-specific details out of
the GPU driver, clock framework, and reset framework.

The first patch updates the AON firmware bindings to describe the clocks
and resets that the PM domain needs to control.

The second patch implements GPU-specific handling inside the TH1520 PM domain
driver, using the genpd start/stop callbacks to sequence the clocks and resets
at runtime.

This approach aligns with recent efforts to treat PM domains as SoC-specific
power management drivers, as presented at OSSEU 2024 [2].

This patchset continues the work started in bigger series [3] by moving the GPU
initialization sequence for the TH1520 SoC into a generic PM domain driver,
specifically handling clock and reset management as part of GPU bring-up.

[1] - https://lore.kernel.org/all/CAPDyKFqsJaTrF0tBSY-TjpqdVt5=6aPQHYfnDebtphfRZSU=-Q@mail.gmail.com/
[2] - https://osseu2024.sched.com/event/1ej38/the-case-for-an-soc-power-management-driver-stephen-boyd-google
[3] - https://lore.kernel.org/all/20250219140239.1378758-1-m.wilczynski@samsung.com/

Michal Wilczynski (2):
  dt-bindings: firmware: thead,th1520: Add clocks and resets
  pmdomain: thead: Add GPU-specific clock and reset handling for TH1520

 .../bindings/firmware/thead,th1520-aon.yaml   |  28 +++++
 drivers/pmdomain/thead/th1520-pm-domains.c    | 119 ++++++++++++++++++
 2 files changed, 147 insertions(+)

-- 
2.34.1



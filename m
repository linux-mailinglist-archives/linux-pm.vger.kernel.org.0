Return-Path: <linux-pm+bounces-14434-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E31D97C5DB
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 10:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786B21C216B7
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 08:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D0E198E9E;
	Thu, 19 Sep 2024 08:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PzAkvBmY"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C16198E78;
	Thu, 19 Sep 2024 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726734671; cv=none; b=W5dMRyQ7IU2Bkg2v7P7h9yuqTi/CMRl5ermjcDjtwJCtKcfhr6+c+vadeCgxJkfRCxKQ+Fefaj0WXcU5oiRC222TNL6lA4ZMu0Ov5UDSIrvTK5TtejkIpDwHDwRW0aCnM7Wjd4F0VGtBLLt8as6JBDJ5eEY3gUW+UubTfW235jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726734671; c=relaxed/simple;
	bh=zrn4yFkZQC+UehhqyDGkm9szCflb3unFHmD8WqDK6g0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cN4Ol8o+xPn0T4uBXXnwDZruvij3mgkgEp1VPSLjI+ROIE5tulMygaCyXBBRf04k7Komnv0SgoA/S7ixGoo4GoggKA+xJoVBWZ4P0Y4AACpc0m5DmaHY2UYrIRS8ZlJJxNyWvfMvvewkrLep+YH2I4IpRmmItMbboTGlrK+Ue4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PzAkvBmY; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48J8UvmK109485;
	Thu, 19 Sep 2024 03:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726734657;
	bh=ga4U+Rt8g7Rn5xYLKC31kkz28CZRnzagL2yVJuL7g0A=;
	h=From:To:CC:Subject:Date;
	b=PzAkvBmYw5yn6JJzv0qWpCE8EFWjY9KYNIlmvSiXX+tRzWBiNn1L0utzL0ZGMWJBI
	 fhsqDpCGvI+SOe/j1NrYzxozTp7D3uWzRRgEeAJ+CjSn2DTCHxyPbr44GjQMtxP7aA
	 MgCdtARQZkJn3OZT/U9FjhMyE1o/255Ym37KTzUE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48J8Uvac003399
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 19 Sep 2024 03:30:57 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Sep 2024 03:30:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Sep 2024 03:30:57 -0500
Received: from lcpd911.dhcp.ti.com (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48J8UrgV042798;
	Thu, 19 Sep 2024 03:30:53 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J
 . Wysocki" <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Dhruva Gole <d-gole@ti.com>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>
Subject: [PATCH V4 0/6] ti: k3-am62{a,p}x-sk: add opp frequencies
Date: Thu, 19 Sep 2024 13:58:04 +0530
Message-ID: <20240919082809.174589-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello everyone

This series adds in the OPPs for the Cortex-A53s on the AM62Ax and 
AM62Px SoC families along with the defining the 
WKUP_MMR0_WKUP0_CTRL_MMR0_JTAG_USER_ID which we can use to properly 
limit the OPPs available for that variant.

Moreover, it also adds a driver cleanup where we can finally get rid of
the rev_offsets and zero the efuse_offsets as they are now taken from socinfo and
DT efuse node register respectively. This series has been tested on all
devices that it affects and has been confirmed to cause no known regressions.

Test logs:
https://gist.github.com/DhruvaG2000/63f5e28636d52787488f776e5bf39498

**NOTE:** Special attention needed on the driver patch 6/6. I have left
a note for the maintainers there on how they would prefer to send it.

Changelog:
---

Changes in v4:
- Add 2 more patches to this series:
	- Driver cleanup as described above.
	- AM625 DT fixups
- Link to v3: https://lore.kernel.org/all/20240826-opp-v3-0-0934f8309e13@ti.com/

Changes in v3:
- Miscellaneous spelling fixes in commit body
- Link to v2: https://lore.kernel.org/r/20240823-opp-v2-0-e2f67b37c299@ti.com

Changes in v2:
- Expanded on commit descriptions
- Split board file and SoC fdt changes into different patches
- Link to v1: https://lore.kernel.org/r/20240809-opp-v1-0-fea8efeaf963@ti.com

---

Bryan Brattlof (4):
  arm64: dts: ti: k3-am62a: add opp frequencies
  arm64: dts: ti: k3-am62a7-sk: add 1.4ghz opp entry
  arm64: dts: ti: k3-am62p: add opp frequencies
  arm64: dts: ti: k3-am62p5-sk: add 1.4ghz opp entry

Dhruva Gole (2):
  arm64: dts: ti: k3-am62: use opp_efuse_table for opp-table syscon
  cpufreq: ti-cpufreq: Update efuse/rev offsets in AM62 family

 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi    |  7 ++-
 arch/arm64/boot/dts/ti/k3-am625.dtsi          |  2 +-
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi   |  5 ++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts       |  9 ++++
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi         | 51 +++++++++++++++++++
 .../dts/ti/k3-am62p-j722s-common-wakeup.dtsi  |  5 ++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       |  9 ++++
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi         | 47 +++++++++++++++++
 drivers/cpufreq/ti-cpufreq.c                  |  5 +-
 9 files changed, 134 insertions(+), 6 deletions(-)


base-commit: 55bcd2e0d04c1171d382badef1def1fd04ef66c5
-- 
2.34.1



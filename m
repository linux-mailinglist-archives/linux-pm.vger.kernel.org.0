Return-Path: <linux-pm+bounces-14603-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FBF9842A8
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 11:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AE04B272D0
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 09:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5975115B56E;
	Tue, 24 Sep 2024 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oEvMqQbT"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF9180C04;
	Tue, 24 Sep 2024 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171488; cv=none; b=GdH5zuc7FtbpI4fdJQgshcxkTIyb8y+O8bDjRFZxEQ6Sdxqnw3s4Nr1Fjw0bAZDy6rSKuU9OAh0kB+cplzc3daflPftROSKjlXxVIZyvQkGryo8w+FrJRUfn59yQl27DbW0FNs27t6tSsueto3h0OARPyNw4DPjBzWmVLv9qhbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171488; c=relaxed/simple;
	bh=wsy4VuWlWCWiwuLeUvDVMNXTk4Izkw42hm7B9/z6TAo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=pfQGrNVtHMc5gF1TfJZov6PnIQpjDeHkNAaYD6k6IEY+pzqQClvM5MzC9Qqhu2QwfArt0GOfYvNquGcfRx2lf/N1SJxLY7blnhkOnHOLDMgdYxA/QjUgqjQ19zfpBzMQzCVU0ME0KjP8rgiEgzwSrQEmOTHmpuDrTI5tZ36faCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oEvMqQbT; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48O9p4g2003146;
	Tue, 24 Sep 2024 04:51:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727171464;
	bh=6NebSt8Wdrgk6Di3RsSEE+fY6ux4r4XoR+rlakITjhA=;
	h=From:Subject:Date:To:CC;
	b=oEvMqQbTs3spbyUKIhExPLCvbp4LFHe9vnCsiA7OR1wndHjAOwRg3xAz1eBIVScQC
	 bIHrCe7PAzdFf9IRL4hLRl5scBnX2jaanB69MjqEUzAhK9+xEi6I89QX9WnORBFyqH
	 G+1p+kcex9dFJqDVC2bynJnEBh65sQ8xR4YJyTgc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48O9p32F000749
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 24 Sep 2024 04:51:03 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 24
 Sep 2024 04:51:02 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 24 Sep 2024 04:51:02 -0500
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48O9owSp017217;
	Tue, 24 Sep 2024 04:50:59 -0500
From: Dhruva Gole <d-gole@ti.com>
Subject: [PATCH v5 0/6] ti: k3-am62{a,p}x-sk: add opp frequencies
Date: Tue, 24 Sep 2024 15:20:40 +0530
Message-ID: <20240924-ti-cpufreq-fixes-v5-v5-0-cbe16b9ddb1b@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHCL8mYC/03MQQ6CMBCF4auQWTukrRRbV97DuIB2CpMIxRaJC
 eHuNq5cfnn53w6ZElOGa7VDoo0zx7lAnypwYzcPhOyLQQnVCKsaXBnd8g6JXhj4Qxk3jb7vz6S
 FbvvWQSmXRL+thPdHcUhxwnVM1P19SSuMMsLW8tJoY1GixyE+6bZy7eIEx/EFiXtPrp0AAAA=
X-Change-ID: 20240924-ti-cpufreq-fixes-v5-dbb3e5056b6c
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael
 J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>, Bryan Brattlof <bb@ti.com>,
        Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727171458; l=5099;
 i=d-gole@ti.com; s=20240919; h=from:subject:message-id;
 bh=wsy4VuWlWCWiwuLeUvDVMNXTk4Izkw42hm7B9/z6TAo=;
 b=V0JVGEhrNtFHg5lCiG8sRPmhROBUrER+xn+dqv904c2lZj1y5BltoEOwxUD/ruXdtfaG7R5F0
 SbbixlKGPELCyeTbkHq0JmIVsLqv1hWhFzejRFWCcKBIXq3f2H/bQRi
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=k8NnY4RbxVqeqGsYfTHeVn4hPOHkjg7Mii0Ixs4rghM=
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

**NOTE:** Special attention needed on the driver patch 5/6 & 6/6:

Viresh and Vignesh,

The driver fix needs to go with PATCH 5/6.

Subject: [PATCH V4 5/6] arm64: dts: ti: k3-am62: use opp_efuse_table for
 opp-table syscon

That patch fixes the efuse offset in the AM625 DT.
Without it, the driver will read from an incorrect efuse offset, and end
up breaking things in -next till all the DT changes make it in.
Hence, it would be preferrable if this entire series goes via a single
maintainer's tree.
Viresh, perhaps if you can ack this single patch, then Vignesh could take it up
if there are no objections?

I am sorry that this breaks compatibility with older AM625 devicetree.
However, the old devicetree was marking the entire wkup_conf as "syscon",
"simple-mfd" which was wrong and needed to be fixed.

This series finally tries to bring order to DT and the driver.

However, if there is still any way to maintain the backward
compatibility, then I am open to suggestions. Please try
and understand here that the ask for backward compatibility here
is to ask the driver to support a case where the register offset itself
was to be picked from a different node. I am not sure if there's any
cleaner way to do this.

Changelog:

---
Changes in v5:
- Based on Andrew's review on v4 of "arm64: dts: ti: k3-am62: use opp_efuse_table for opp-table syscon",
	- s/syscon@43000000/bus@43000000/
	- Drop the "reg = <>;" line
- Link to v4: https://lore.kernel.org/all/20240919082809.174589-1-d-gole@ti.com/

Changes in v4:
- Add 2 more patches to this series:
	- Driver cleanup as described above.
	- AM625 DT fixups (Link to v1 of that patch: https://lore.kernel.org/all/20240902093222.2828345-2-d-gole@ti.com/)
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

---
Bryan Brattlof (4):
      arm64: dts: ti: k3-am62a: add opp frequencies
      arm64: dts: ti: k3-am62a7-sk: add 1.4ghz opp entry
      arm64: dts: ti: k3-am62p: add opp frequencies
      arm64: dts: ti: k3-am62p5-sk: add 1.4ghz opp entry

Dhruva Gole (2):
      arm64: dts: ti: k3-am62: use opp_efuse_table for opp-table syscon
      cpufreq: ti-cpufreq: Update efuse/rev offsets in AM62 family

 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi         | 10 +++--
 arch/arm64/boot/dts/ti/k3-am625.dtsi               |  2 +-
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi        |  5 +++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts            |  9 ++++
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi              | 51 ++++++++++++++++++++++
 .../boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi  |  5 +++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts            |  9 ++++
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi              | 47 ++++++++++++++++++++
 drivers/cpufreq/ti-cpufreq.c                       |  5 +--
 9 files changed, 135 insertions(+), 8 deletions(-)
---
base-commit: 55bcd2e0d04c1171d382badef1def1fd04ef66c5
change-id: 20240924-ti-cpufreq-fixes-v5-dbb3e5056b6c

Best regards,
-- 
Dhruva Gole <d-gole@ti.com>



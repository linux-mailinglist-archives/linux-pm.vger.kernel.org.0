Return-Path: <linux-pm+bounces-14787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3562D986ED9
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 10:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D44691F21A4A
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 08:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01CA18C34C;
	Thu, 26 Sep 2024 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XbVyG2C2"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E062614A62A;
	Thu, 26 Sep 2024 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339747; cv=none; b=ZXXg18j2x51dyaigZk1/hPdkGGENfFW+V67J04ftar5QRAZ/KspcXfKowRc80hycavY8jaDw0a6mdjyYSz5W/Qp/TdkGH6r/ccI5Pg7ZUIMYO8aT7UkMIhSTwn7CYPqg2fSveqiSeIIuGpgYcGYM3LxMsTeCDaNPbyQWTVzXofQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339747; c=relaxed/simple;
	bh=9yJ4rJJAn2xv4XKv/BH8/DKQz2TWaYgreH6iE5ehkn4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=aXyANeSnGMCsVeeXyaOMLBwra3TTZXVS10Tdcxot1KwXZneAw0GH3P4rmm5+IeTYZeYbd0b5UxUPx10/Y5heTvzmgF2Bv3SQv7OWhqevqVhVrXIBZqOXodHDvtc808ExEtqG7oO4KLguW56o/rCWun2ZTYDl5HISaHwDGlyA80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XbVyG2C2; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48Q8ZVTw042324;
	Thu, 26 Sep 2024 03:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727339731;
	bh=5602h+BkR8s8mkz21R6/t9OTGFCcXa0UKY1vZhpJF2k=;
	h=From:Subject:Date:To:CC;
	b=XbVyG2C2OaNqACuEmkqKtMIWVNUhfJR8hexLgma2bKYy19hMlx72bU4iPHhHf50+v
	 IldDpPQZGDmxoh5wul46evRN+eRQBRZSbw0M3IOSqKhpUxlsLbFdXimuHhqDcIS31S
	 ozQkA4xJv3zrAnc1fAhQNEhwOHV29uQv5rrj75jk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48Q8ZVgD053751
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 26 Sep 2024 03:35:31 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 26
 Sep 2024 03:35:30 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 26 Sep 2024 03:35:30 -0500
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48Q8ZPK4064456;
	Thu, 26 Sep 2024 03:35:26 -0500
From: Dhruva Gole <d-gole@ti.com>
Subject: [PATCH v7 0/6] ti: k3-am62{a,p}x-sk: add opp frequencies
Date: Thu, 26 Sep 2024 14:04:51 +0530
Message-ID: <20240926-ti-cpufreq-fixes-v5-v7-0-3c94c398fe8f@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKwc9WYC/33OQQrCMBAF0KtI1o4kaZI2rryHuGiSaRuwTU1qU
 aR3NxUUFyLM5jP8x3+QhNFjIvvNg0ScffJhyKHcbojt6qFF8C5nwikXVHMBkwc7XpuIF2j8DRP
 MEpwxBUoqlVGW5OYY8fXLxeMp5yaGHqYuYv1lMU0rXlG9Y6WQlQYGDtpwxsPkdzb0q9P5NIV4f
 42b5ar935GPgjXIlNHOGWbe1jpiVt+A/A2oDAjVCFZrWiBlH2BZlicnlUtmLAEAAA==
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
        Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Markus Schneider-Pargmann
	<msp@baylibre.com>,
        Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727339725; l=4850;
 i=d-gole@ti.com; s=20240919; h=from:subject:message-id;
 bh=9yJ4rJJAn2xv4XKv/BH8/DKQz2TWaYgreH6iE5ehkn4=;
 b=TFr3GIa8a8Ae/navYQPfHz9aZIG0ASQGLEainsLTpk4pMZH6LRvhBuwjmOT5x0QC5nFqxv9uZ
 mK8+wt9zAQ9BlhQiRzmsC3YYGz4U30qkZ/meC2nQH/t1XWcOJlQzstJ
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

It also tries to fix the AM625 devicetree syscon nodes, while also ensuring that
within the driver we don't end up breaking the older DT. Prints a warning incase
older DT is detected.

Test logs:
https://gist.github.com/DhruvaG2000/63f5e28636d52787488f776e5bf39498

Changelog:

---
Changes in v7:
- Based on Andrew's comments, re-worded the comment in the driver and also
  used a different approach for finding old DT, this way it's less error prone
  than how things were done in v6.
- Added a warning print when using old DT:
https://gist.github.com/DhruvaG2000/63f5e28636d52787488f776e5bf39498#file-am62x-cpufreq-test-log-old-dt-txt-L220
- Link to v6: https://lore.kernel.org/r/20240925-ti-cpufreq-fixes-v5-v6-0-46f41a903e01@ti.com

Changes in v6:
- Ensure backward compaibility for AM625 DT, by handling the old DT in a special
way inside the cpufreq driver itself. This is based on feedback from Nishanth
where we are not okay to break the old DT working with new kernels.
- Link to v5: https://lore.kernel.org/r/20240924-ti-cpufreq-fixes-v5-v5-0-cbe16b9ddb1b@ti.com

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
 drivers/cpufreq/ti-cpufreq.c                       | 24 +++++++---
 9 files changed, 152 insertions(+), 10 deletions(-)
---
base-commit: 55bcd2e0d04c1171d382badef1def1fd04ef66c5
change-id: 20240924-ti-cpufreq-fixes-v5-dbb3e5056b6c

Best regards,
-- 
Dhruva Gole <d-gole@ti.com>



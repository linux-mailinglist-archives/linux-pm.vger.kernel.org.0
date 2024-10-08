Return-Path: <linux-pm+bounces-15331-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFCE994F25
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 15:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044152850CF
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 13:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D511E0481;
	Tue,  8 Oct 2024 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Hxf4swEa"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF99C1DF727;
	Tue,  8 Oct 2024 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393815; cv=none; b=fMY0hiiZfALJyWP/E1n+pUAbNYj0aS1a0IEGswlRs5Q2HOLeeXq15Y4U1IydZwVdscfgJJIJdr6sUPaOdmR2Kn/ue4X2VeaU6YQhwses0EJQwTZJ0Um1/Ofo6AqiG6fh7AQYyf3RL+qcib856D7ZnfiQPAt8tanzB6nezUWPEss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393815; c=relaxed/simple;
	bh=gZI4zFHa2e3Jdn+kJosnAimGicEmqHUGxYA00Iu9Bwg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PiF40lzLV4zgVupb+zsteuuDruEA8zLbUAJt0nAd7Pvu3xxYt1LDTcMyH6JVwmQtpkh3OzmdJnvSOGA7yuG38BIdkZjVhhMbtnRH/YhfYr9zo98mDdkHLxUAq18LdulueSJCe0neSvbv7Cex0SPk0Iga6elv9PKA6ls34G5p8fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Hxf4swEa; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 498DNCoK089883;
	Tue, 8 Oct 2024 08:23:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728393792;
	bh=eOUyiXZrWUlgS0aqjqNzddLEJrGYEGZYP5a/M8Xpl08=;
	h=From:To:CC:Subject:Date;
	b=Hxf4swEaaKX4z+w5N1I/CHucF28eg/Mo8KdALbCCJigp/SqMBP56Bzk6CjazCJNi+
	 yge5IfaN1pTsP9b7ZuRUaH416mJYSENKGsjGih7KHFWuDomUfsRSxICEhmGyIpIMKY
	 E3WvPqsQpERzpepnV/HsD11DwXux+ZSmvnfdWfj8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 498DNCMh097903
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 8 Oct 2024 08:23:12 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Oct 2024 08:23:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Oct 2024 08:23:12 -0500
Received: from lcpd911.dhcp.ti.com (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 498DN82C098273;
	Tue, 8 Oct 2024 08:23:09 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Dhruva Gole <d-gole@ti.com>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH V8 0/4] arm64: dts: ti: k3-am62{a,p}x-sk: add opp frequencies
Date: Tue, 8 Oct 2024 18:50:49 +0530
Message-ID: <20241008132052.407994-1-d-gole@ti.com>
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
WKUP_MMR0_WKUP0_CTRL_MMR0_JTAG_USER_ID which we can use to to properly 
limit the OPPs available for that variant.

Signed-off-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>

Changelog:
---

Changes in v8:
- Split the driver fixes out and sent a separate series for that.
- This series is now the same as it was in v3. Just rebased on 6.12-rc1
- Link to v7: https://lore.kernel.org/all/20240926-ti-cpufreq-fixes-v5-v7-0-3c94c398fe8f@ti.com/

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

 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi   |  5 ++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts       |  9 ++++
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi         | 51 +++++++++++++++++++
 .../dts/ti/k3-am62p-j722s-common-wakeup.dtsi  |  5 ++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       |  9 ++++
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi         | 47 +++++++++++++++++
 6 files changed, 126 insertions(+)


base-commit: 33ce24234fca4c083e6685a18b460a18ebb5d5c1
-- 
2.34.1



Return-Path: <linux-pm+bounces-13331-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 806BF968344
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 11:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75547B2116B
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 09:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951BF1D175A;
	Mon,  2 Sep 2024 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X/7mquf0"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10791D0DE8;
	Mon,  2 Sep 2024 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269564; cv=none; b=pzH5ABK07kVAqxFZWa3U4ltNwcIiml65bLhSZW2GbQSpD3phY/H3eFhLabm0p+XHGGRDlI3n5m6Zs+8HxXbrbugVfVOlYr1T9o7TWH8ajM5YvBSB0aASsMZUsQJNlTwFaaeTA+RrI7xFTku3e2fqcUfqYnZvbmwtfpEwfgDatPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269564; c=relaxed/simple;
	bh=cX6K0AajsFZded9QaHzCh1gcQ/9zu1ZmGmOGM+EKaUQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BM+zrj6VTl6k0uURcnLtozp9qo1FCs5WcVB1XucUmkzsOS8W4kh2e98Z4GrkzvbuduAHWRhIoe09HX3ghLG9qobio7EjDgk7PLrJ4s7RWI5h2kP5PHJfNPOWm+aI6QmgBwjf1SGkSaYjDW4XwcF6HZLg6+eW68WMqx2AWMQyLhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=X/7mquf0; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4829WYpG095887;
	Mon, 2 Sep 2024 04:32:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725269554;
	bh=qGR5Suw3bxGeH27ygkrIWMgplkwjOYQ/SHeEzhji8cM=;
	h=From:To:CC:Subject:Date;
	b=X/7mquf0NpTT6SUrAeZSfOTZZ8bq3TL4GokAdK9b7KlSSE+M+cNW8he/DQLBK5Hek
	 1m3MUFfzg3WNTnuu/Pjt6sg15Tc7D+wiAKPNPov/3/sQDXTkCfFfvEX0WevUQgishz
	 knVjovLkLbkpBFuj1o5IEp573mLkmpGXYXrFjeJs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4829WYg3009974
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Sep 2024 04:32:34 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Sep 2024 04:32:33 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Sep 2024 04:32:33 -0500
Received: from lcpd911.dhcp.ti.com (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4829WT7J109047;
	Mon, 2 Sep 2024 04:32:30 -0500
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        <bb@ti.com>, <vibhore@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Dhruva Gole <d-gole@ti.com>
Subject: [PATCH 0/2] dts: ti: k3-am62: Use opp_efuse_table for opp-table
Date: Mon, 2 Sep 2024 15:02:20 +0530
Message-ID: <20240902093222.2828345-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

In this series, I add another entry in the wkup_conf for the syscon node,
and then use that for the syscon in opp-table. Then, since the driver
can now pick the efuse reg directly, we no longer need the old offset, hence
make it 0 here itself.

This series has 2 patches that need to go in at the same time, hence
preferrably via your tree Viresh if that's fine by all the concerned
maintainers.

It also depends on the series previously sent [1]

[1] Message-Id: <20240902092135.2826470-1-d-gole@ti.com>

Cc: Bryan Brattlof <bb@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>
Cc: Nishanth Menon <nm@ti.com>

Dhruva Gole (2):
  arm64: dts: ti: k3-am62: use opp_efuse_table for opp-table syscon
  cpufreq: ti-cpufreq: Make the AM625 efuse_offset 0

 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 7 ++++++-
 arch/arm64/boot/dts/ti/k3-am625.dtsi       | 2 +-
 drivers/cpufreq/ti-cpufreq.c               | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)


base-commit: ecc768a84f0b8e631986f9ade3118fa37852fef0
-- 
2.34.1



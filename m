Return-Path: <linux-pm+bounces-9041-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B93905F05
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 01:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EBD82846AE
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 23:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC8012D750;
	Wed, 12 Jun 2024 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GgRWnbIU"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9169E12CDAE;
	Wed, 12 Jun 2024 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718234275; cv=none; b=K5G6SxlsocqbAknTnQn+RI8+Gp4dDV4VbUBNZwYK65XVCB+qC8DpITTfJ8JMI9NHWshaK4r9ILrbvxvGvkNAtnIH5lCUQrCnQkSucs1N4SWzczrDpsz7yBFpM/j+rPyJe6vi8EWJXC6UlHHvPl/KI6rxiw2KttVUB9qQTukL++0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718234275; c=relaxed/simple;
	bh=HiQpuoVRJsTqG9rR8RGGpBIYnldnimCU2HFCr5ymI54=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=FkkUNvpy5NW2/UNbGMWe2/xfKGqUCVUi+8rXu0B03cV04la6DIqxiEkaoM+Qj1rAZp9tqWKWiUgzoD/jO1DKKHzosolWTXt0IwQpkPHe9VZsgPfgf6LIdPSjqphVzIGiv+jyoOStQam9cp1ufVB8C3OjSvV8NPK5wwXxp1bUJxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GgRWnbIU; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CNHeB9128866;
	Wed, 12 Jun 2024 18:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718234260;
	bh=gAsDI6PxYUSosDdb1lxDRWdTnS3etyrA2Yu/MfOwd7Q=;
	h=From:Subject:Date:To:CC;
	b=GgRWnbIUUY/q4NZz7uzO9ct6fD+vYvNkO+NRkeyBSO+HuA78iDc8FnKdxfByNgOp2
	 CIL6PXIZE+ff3bLivvIauT/uUdgyZmjU7MXUz6n959HRRMvnLH1qDkUI15qj+Dcdqc
	 V60H6kVMJPMJwgMZ4q1Li0DRhdIGnzYCWvw9jwiU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CNHe9i008010
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 18:17:40 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 18:17:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 18:17:40 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CNHesj019510;
	Wed, 12 Jun 2024 18:17:40 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 0/5] Update OPP table and add entries for AM62Ax &
 AM62Px SoCs
Date: Wed, 12 Jun 2024 18:17:33 -0500
Message-ID: <20240612-ti-opp-updates-v2-0-422b6747a254@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI4samYC/13MQQ7CIBCF4as0s3YMQ4tKV97DdFEB7SwsBLDRN
 NxdrDuX/0vet0JykV2CvlkhuoUT+7mG3DVgpnG+O2RbG6SQnVBCY2b0IeAz2DG7hKQNCT1eqVU
 d1FOI7savDbwMtSdO2cf35i/0XX/UgeQ/tRAKbJUi05LVp6M8Z94b/4ChlPIBrAJUOqkAAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>, Lee Jones <lee@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC: Vibhore Vardhan <vibhore@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642; i=bb@ti.com;
 h=from:subject:message-id; bh=HiQpuoVRJsTqG9rR8RGGpBIYnldnimCU2HFCr5ymI54=;
 b=owNCWmg5MUFZJlNZnfwcbAAAbX///r//v7u3D9a9HcfWe/ZHb3p/7YXTD/ev79t/r3/BvO+wA
 Rtgx2oGgxDQ0ZA0GQAA0HqABo0BpoNABkMgxMjQDQA0NMjQ0aaZBk9QHpMm09KHCaYjQYQZAZGQ
 0BpkGE0GmQGhkyADRoYIyBkNAyDRtQGQyGEaDINBk00HIaaaaMj1DTBDIA0DCaaZAaaAAGEGmAm
 RgRghgE0BoAAAAMmhoBpoECK9cOYukHiwDqgA0s/A7RR6qW0oaZ3b3QhiY8AEgO9YMeluDU+2l2
 YryB16xAtNGWpGPlXoknGOKz69F7sdhHdm53x0jLdqGXbqebay1wIPh3VMBq4Ogw+wgG4fpvR1E
 YI2zKFV5Yc2sJP+IH6tNWKVkEiMQ6uZfORoqGHNvEehpmrQKgK+z33GUHXFV04K1bcmkUYEFRw8
 OYOwvFl+a925jhFveJ3f3o4v20mmaXpJvIpF8JCmcbrNLPJ9Rt2cG0gCVEms3g1W/eLV4XOFlrA
 Doi7/Z5Ei7nLhSeJhJXiNmGCgpYJJ5CiCewrfDqPdyltEMjoXp5TJFDRh18Nuz4mEE79FDwdSxL
 mAc/4uCT21jvvU84E7W7pO4qiyFQAVlZBBp3qC+HNuxphmMOAAByQrdj/GV4SSHPpoRZz1BBy7h
 lQX+LuSKcKEhO/g42A=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Everyone

This series starts off the process of updating the OPP decoding tables 
to align with the new speed grade schemes for TI's AM62Ax and AM62Px SoC 
families.

Following this update is the updated binding and the OPPv2 entries we 
will be using for the SoC including the 1.4GHz frequency for our 
reference boards when the VDD_CORE allows.

Thanks for reviewing
~Bryan

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v2:
- removed errant DONOTMERGE tag 
- Link to v1: https://lore.kernel.org/r/20240612-ti-opp-updates-v1-0-3551c31d9872@ti.com

---
Bryan Brattlof (5):
      cpufreq: ti: update OPP table for AM62Ax SoCs
      cpufreq: ti: update OPP table for AM62Px SoCs
      dt-bindings: mfd: syscon: add TI's opp table compatible
      DONOTMERGE: arm64: dts: ti: k3-am62p: add in opp tables
      DONOTMERGE: arm64: dts: ti: k3-am62a: add in opp table

 Documentation/devicetree/bindings/mfd/syscon.yaml |  1 +
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi       |  5 ++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts           |  9 +++
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi             | 51 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi       |  6 ++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts           |  9 +++
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi             | 47 ++++++++++++
 drivers/cpufreq/ti-cpufreq.c                      | 94 ++++++++++++++++++++++-
 8 files changed, 220 insertions(+), 2 deletions(-)
---
base-commit: 629b57597ab52cef2ac5dd16042183c298cc52ed
change-id: 20240509-ti-opp-updates-19c109ab1354

Best regards,
-- 
Bryan Brattlof <bb@ti.com>



Return-Path: <linux-pm+bounces-9773-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B52912BAE
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 18:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD46B2ABBD
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 16:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12511684BD;
	Fri, 21 Jun 2024 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rsUUqWDy"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2FB1662FE;
	Fri, 21 Jun 2024 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718987998; cv=none; b=dvnJFqsLrtjw71Lzv/5i7uLgG1RlXKDu1fAHzusNQufr+wNzWb7Gfbh7QvK8i62eXn0Y+95yZyllBOl5HWmZWZYhr+EtsfBTNYCKQfElg9QB1HkYFIAulhmERbdrkWtTfXv9BeRNxdMxTzs6+WetSEimYMUVZd3/22lk/EAurDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718987998; c=relaxed/simple;
	bh=kv/SqCRziBr1ZtYrROxs06B90ZZZEZZm9BgfjzEMULM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=fMFDhYCMD5QjMzKRvffY6bgD66AZEVNU5YByjgaaA4zAsb3FKcn4XjgdyxlVlAzF3XLzm2qqJ1WGzyC2eIr3OjkPfhWrt78Yj2QqLfHZbSIilCkH0OPMRqDBQVthaEMfbXewR5UM/ZO1JUZR4u8KP+LgHHX8sPlsww6szrVregQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rsUUqWDy; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45LGdkhl055949;
	Fri, 21 Jun 2024 11:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718987986;
	bh=yU92LoPc1BMT03gRYZSwgvtMaWSu4XTIGEMAMGD2Rjc=;
	h=From:Subject:Date:To:CC;
	b=rsUUqWDyN7WKd2+B6K9tod+jF26Ehjc1FmyTAQpMS6EwEdcIRBKDxUfQ7m+RFLZ4/
	 FhshMKXBTeS9MR/r6i89LwlP6eyn3CdYLgmtYmGz0W7vUdOGrwtuT0pFcd2z1jxxMl
	 LwXt9/n9kkJa/Ok6rE2WU4bFaVmjC6FyP/hQStKI=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45LGdk49020991
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Jun 2024 11:39:46 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jun 2024 11:39:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jun 2024 11:39:46 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45LGdkOo080071;
	Fri, 21 Jun 2024 11:39:46 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH v3 0/5] Update OPP table and add entries for AM62Ax &
 AM62Px SoCs
Date: Fri, 21 Jun 2024 11:39:36 -0500
Message-ID: <20240621-ti-opp-updates-v3-0-d857be6dac8b@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMisdWYC/33MsQ7CIBSF4VdpmMXABVpx8j2MA6Vo72AhgETT9
 N2lNXFwcDwn+b+ZJBfRJXJsZhJdwYR+qkPsGmJHM90cxaFuAgwkU0zTjNSHQB9hMNklyrXlTJu
 eCyVJjUJ0V3xu4PlS94gp+/ja/MLX90O1HH6pwimjQiluBR/0oYNTxr31d7I6Bf63UFsJ0Led7
 Awo+W2XZXkDiWgyheUAAAA=
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
        <linux-arm-kernel@lists.infradead.org>, Bryan Brattlof <bb@ti.com>,
        Dhruva
 Gole <d-gole@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1828; i=bb@ti.com;
 h=from:subject:message-id; bh=kv/SqCRziBr1ZtYrROxs06B90ZZZEZZm9BgfjzEMULM=;
 b=owNCWmg5MUFZJlNZKJ0zKQAAav/////9z/13W376jaf9c8u/e9v6Tn73/usL/p9+ml3j78+wA
 RsYGKaAABoAAAAAANBoB6nqaABoGj1NGgBoNNGgABoBkZG0gNpA0xNGHooZQA0AA09TQAAeoAPU
 aek0NAA0DQAGQAaNAGymT1GnqA0PUaaBo9RoGnqBo9QyAcmEDTQA00xAaaGQaNMBA0AaYgYRkGE
 GjEMCGEAABpkGamgAAAaAAYMAIPiMVZB5ISBihMWTjh4dxmbtdrddXiIYiXkY0F/NOYFXwAQox5
 DKmZAqAKw0waM2bSiiFCcBvlcjXutR62SWUgsy0VNkMV6LYmeMp5QkiDSisfnvF7ayqVTDXUeK0
 rrUl6upTzBDHPTzVQP9Mg2ZAaV29AvMg7HW6AeiR2hwAFs7E58H1WLAhWatMhJD329c+4mFP6ZI
 zWpMGBh0mCfACOqtlcZ3GeACQXyhCuk27qO2FRm7geVVLU/usxcfqYnSZ1FEnFSUt0kWXypIViZ
 aYRYvMsBcTKLM0qd15wDBBPoTJugGfgUcrgfH4t6NdauTSJ3aRexc8k5V/C26YFx9JUOxcce3/s
 AshJ2XBgbFD0lzNRSHxCA721UKzQzRkga4MP9fxDSlCLLRBR7JAES8drEADNC0p7oBQaMobPQLP
 8XckU4UJAonTMpA
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
Changes in v3:
- s/calc_efuse/calculated_efusse/ 
- place compatible string alphabetically
- Link to v2: https://lore.kernel.org/r/20240612-ti-opp-updates-v2-0-422b6747a254@ti.com

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
base-commit: eb9c77d3294d119197f6ad2ddbc2adb41922ee4f
change-id: 20240509-ti-opp-updates-19c109ab1354

Best regards,
-- 
Bryan Brattlof <bb@ti.com>



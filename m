Return-Path: <linux-pm+bounces-32689-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC78B2D6A4
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 10:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA0C3B1B1D
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 08:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0871327147D;
	Wed, 20 Aug 2025 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Km6Cim3A"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF36231826;
	Wed, 20 Aug 2025 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678854; cv=none; b=EG/P6eNkabzACrgYYT7yopnh4sBnTapfuiCpZYZd1yfhDzGqHo6yI/fANCDfjCTza/I2hRz0E2DZy1iZRgy+ltBUWt79Yr3raEnD4IrKtZCgUfMY+ESFRTsUHoQyg1AF9dGgQyy2IEnjuxLQyTNSnvcTw1HR5uFoaq/AwXzSC00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678854; c=relaxed/simple;
	bh=CH4BeaS478hobY3clDlX9i4IzgiW+s/PwZ/7muoC3Zc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MVqlnBrkJkdqJh9mB9dqUSqyYZLur9YfvpUfv+tnfSb9Fz7chwGLtjA/viiqXZFlV9mF9wylaKBoM1fmNg/Lxgi1ANiu6JWn7H3HtRIhvGLdsUA7wBKpZT0S5L4VTlqPOne2a7CywM8EZ6BVwQKIs2M2shqF+XZA5ph39nFsLWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Km6Cim3A; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57K8Xx3P3154182;
	Wed, 20 Aug 2025 03:33:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755678839;
	bh=PnhKc8g8H0kWfIoMnf2P/Giz7+/dSwkw4FZNG9iIes4=;
	h=From:To:CC:Subject:Date;
	b=Km6Cim3AdlaexZ7iEUPrWAEzfAlC2vTcPFUXnEtQxEPhDIeOnGIX+p6pz12dSSZVP
	 1S0M7KomD0YNN8QAhXAa9pWf3iQx0pi150ccUvRPHBWvZVPp//s+hfrJROI7lHkLC8
	 3pKoqCCYADtvK/YfpVxmuWJmhUau51AhX3Yi8cV4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57K8XxC91919840
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 20 Aug 2025 03:33:59 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 20
 Aug 2025 03:33:59 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 20 Aug 2025 03:33:59 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57K8Xvku4133408;
	Wed, 20 Aug 2025 03:33:58 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 0/4] Add cpufreq and USB support for AM62D2
Date: Wed, 20 Aug 2025 14:03:27 +0530
Message-ID: <20250820083331.3412378-1-p-bhagat@ti.com>
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

This patch series introduces following changes:

* Patch 1 fixes the register length in main_pmx/padconfig for AM62D
 and AM62A.

* Patch 2 enables USB support for AM62D2-EVM by adding pinmux and device
 tree nodes.

* Patch 3 adds AM62D2 SoC to cpufreq-dt-platdev blacklist so that
 cpufreq is handled by the ti-cpufreq driver instead of the
 generic cpufreq-dt driver.

* Patch 4 extends ti-cpufreq to register AM62D2 SoC support by
 reusing the am62a7_soc_data.

Boot Logs-
https://gist.github.com/paresh-bhagat12/e29d33c3fd92ff17580edf1441ece9f9

Tech Ref Manual-https://www.ti.com/lit/pdf/sprujd4
Schematics Link-https://www.ti.com/lit/zip/sprcal5

Paresh Bhagat (3):
  arm64: dts: ti: k3-am62d2-evm: Enable USB support
  cpufreq: dt-platdev: Blacklist ti,am62d2 SoC
  cpufreq: ti: Add support for AM62D2

Vibhore Vardhan (1):
  arm64: dts: ti: k3-am62a-main: Fix pinctrl properties

 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi |  2 +-
 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts  | 21 +++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c      |  1 +
 drivers/cpufreq/ti-cpufreq.c              |  2 ++
 4 files changed, 25 insertions(+), 1 deletion(-)

-- 
2.34.1



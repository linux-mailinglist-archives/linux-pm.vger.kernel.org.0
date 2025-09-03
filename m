Return-Path: <linux-pm+bounces-33690-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CD6B416F6
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 09:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295F95640C0
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 07:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0D62DE6FA;
	Wed,  3 Sep 2025 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w58D3xj1"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ACE2DCF73;
	Wed,  3 Sep 2025 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885225; cv=none; b=LWD0gG7MN8RM0ZAQq5HRs1Z9LIg90yi3PaFp//OXxCj+XDVgjYjtcKt4e2cJY+bwyoKEOJuQowAWPPgfTurygmuHTkEcMWmdpvrprqiKHn8iplpomdunuI0OFgz2/5dD3e26yvQdiXkG5Zl/q6g/QIXFA2e9PzZd7Nf1qUpn1bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885225; c=relaxed/simple;
	bh=aTgLHvvF6JmGVGZt/bk1emsLPAjdFT4gzAm4X5FjEIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UGQ0SdPaSgbWSsMyNPOW0dnO3YCz6yuV2XgkX1/uIVu8hxMH8QAxWYSnwAFzZ87v/tjNpqEv63AHV/Z3kigihHUgQr0IPIDE02FrwklBVJRPF6bkt7Tb/6CU1Hwgs/UNVlrDbjlsa5iEhxDOL83ISOhC0QRJZqWL4V73J7UIbJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=w58D3xj1; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5837dm2Q3175100;
	Wed, 3 Sep 2025 02:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756885188;
	bh=imb31yK7pF8UIKtXY+8IGVFXWstsGVcDs9Q0NngwkRA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=w58D3xj10tbK9xE+TD/MiieAlFBvEbquPglqKnPkQaMMDJodxdKza6m1Pkn8BDGGP
	 hEuhBhk1XLXnu5tkvw9s95R2aKr9m8naEdpnCn8JlGKim5NwiQaSJTK6fS3vruE4vG
	 SCZkeyjbgu8DPTNMGTyk9CwyIQbkMW1YZUbXYbWY=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5837dmoW3432825
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 02:39:48 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 02:39:48 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20; Wed, 3 Sep
 2025 02:39:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 02:39:47 -0500
Received: from [172.24.233.14] (shark.dhcp.ti.com [172.24.233.14])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5837df5u919737;
	Wed, 3 Sep 2025 02:39:42 -0500
Message-ID: <97231ac9-5cde-49bf-931b-d5baf6d2d2d1@ti.com>
Date: Wed, 3 Sep 2025 13:09:41 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/24] pmdomain: Add generic ->sync_state() support to
 genpd
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan
	<saravanak@google.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-pm@vger.kernel.org>
CC: "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>,
        Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>,
        Johan Hovold <johan@kernel.org>,
        "Maulik
 Shah" <maulik.shah@oss.qualcomm.com>,
        Michal Simek <michal.simek@amd.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Thierry Reding
	<thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Hiago De
 Franco" <hiago.franco@toradex.com>,
        Geert Uytterhoeven
	<geert@linux-m68k.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
Content-Language: en-US
From: Sebin Francis <sebin.francis@ti.com>
In-Reply-To: <20250701114733.636510-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Ulf,

On 01/07/25 17:17, Ulf Hansson wrote:
> Changes in v3:
> 	- Added a couple of patches to adress problems on some Renesas
> 	platforms. Thanks Geert and Tomi for helping out!
> 	- Adressed a few comments from Saravanna and Konrad.
> 	- Added some tested-by tags.
> 
> Changes in v2:
> 	- Well, quite a lot as I discovered various problems when doing
> 	additional testing of corner-case. I suggest re-review from scratch,
> 	even if I decided to keep some reviewed-by tags.
> 	- Added patches to allow some drivers that needs to align or opt-out
> 	from the new common behaviour in genpd.
> 
> If a PM domain (genpd) is powered-on during boot, there is probably a good
> reason for it. Therefore it's known to be a bad idea to allow such genpd to be
> powered-off before all of its consumer devices have been probed. This series
> intends to fix this problem.
> 
> We have been discussing these issues at LKML and at various Linux-conferences
> in the past. I have therefore tried to include the people I can recall being
> involved, but I may have forgotten some (my apologies), feel free to loop them
> in.
> > I have tested this with QEMU with a bunch of local test-drivers and 
DT nodes.
> Let me know if you want me to share this code too.
> 
> Please help review and test!

During testing on a TI platform, I observed new kernel warnings after 
applying this patch series:

ti_sci_pm_domains 44043000.system-controller:power-controller: 
sync_state() pending due to fd00000.gpu

These warnings occur when a device (in this case, the GPU) has no driver 
bound to it. The fw_devlink_dev_sync_state[0] in the core has a check 
before printing this warning. It checks whether the device driver has a 
sync_state handler OR the device bus has a sync_state handler in the 
dev_has_sync_state[1]. If both conditions are false, 
fw_devlink_dev_sync_state[0] performs an early return before printing 
the warning.

Before this patch series, both handlers were absent for device driver 
ti_sci_pm_domains and the device bus, so both conditions failed and no 
warnings were printed.

This patch series adds a sync_state handler for the bus, which now 
satisfies the second condition. So it doesn't do an early return and 
proceeds to print the warning.

[0]: https://elixir.bootlin.com/linux/v6.16/source/drivers/base/core.c#L1777
[1]: 
https://elixir.bootlin.com/linux/v6.16/source/include/linux/device.h#L909

Thanks
Sebin

> Finally, a big thanks to Saravana for all the support!
> 
> Kind regards
> Ulf Hansson
> 
> 
> Saravana Kannan (1):
>    driver core: Add dev_set_drv_sync_state()
> 
> Ulf Hansson (23):
>    pmdomain: renesas: rcar-sysc: Add genpd OF provider at
>      postcore_initcall
>    pmdomain: renesas: rmobile-sysc: Move init to postcore_initcall
>    pmdomain: renesas: rcar-gen4-sysc: Move init to postcore_initcall
>    pmdomain: core: Prevent registering devices before the bus
>    pmdomain: core: Add a bus and a driver for genpd providers
>    pmdomain: core: Add the genpd->dev to the genpd provider bus
>    pmdomain: core: Export a common ->sync_state() helper for genpd
>      providers
>    pmdomain: core: Prepare to add the common ->sync_state() support
>    soc/tegra: pmc: Opt-out from genpd's common ->sync_state() support
>    cpuidle: psci: Opt-out from genpd's common ->sync_state() support
>    cpuidle: riscv-sbi: Opt-out from genpd's common ->sync_state() support
>    pmdomain: qcom: rpmpd: Use of_genpd_sync_state()
>    pmdomain: qcom: rpmhpd: Use of_genpd_sync_state()
>    firmware/pmdomain: xilinx: Move ->sync_state() support to firmware
>      driver
>    firmware: xilinx: Don't share zynqmp_pm_init_finalize()
>    firmware: xilinx: Use of_genpd_sync_state()
>    driver core: Export get_dev_from_fwnode()
>    pmdomain: core: Add common ->sync_state() support for genpd providers
>    pmdomain: core: Default to use of_genpd_sync_state() for genpd
>      providers
>    pmdomain: core: Leave powered-on genpds on until late_initcall_sync
>    pmdomain: core: Leave powered-on genpds on until sync_state
>    cpuidle: psci: Drop redundant sync_state support
>    cpuidle: riscv-sbi: Drop redundant sync_state support
> 
>   drivers/base/core.c                         |   8 +-
>   drivers/cpuidle/cpuidle-psci-domain.c       |  14 --
>   drivers/cpuidle/cpuidle-riscv-sbi.c         |  14 --
>   drivers/firmware/xilinx/zynqmp.c            |  18 +-
>   drivers/pmdomain/core.c                     | 211 ++++++++++++++++++--
>   drivers/pmdomain/qcom/rpmhpd.c              |   2 +
>   drivers/pmdomain/qcom/rpmpd.c               |   2 +
>   drivers/pmdomain/renesas/rcar-gen4-sysc.c   |   2 +-
>   drivers/pmdomain/renesas/rcar-sysc.c        |  19 +-
>   drivers/pmdomain/renesas/rmobile-sysc.c     |   3 +-
>   drivers/pmdomain/xilinx/zynqmp-pm-domains.c |  16 --
>   drivers/soc/tegra/pmc.c                     |  26 ++-
>   include/linux/device.h                      |  13 ++
>   include/linux/firmware/xlnx-zynqmp.h        |   6 -
>   include/linux/pm_domain.h                   |  17 ++
>   15 files changed, 291 insertions(+), 80 deletions(-)
> 


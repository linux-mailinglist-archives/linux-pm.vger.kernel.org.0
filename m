Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77EA01E9E2F
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jun 2020 08:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgFAG2N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 02:28:13 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33120 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgFAG2M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2020 02:28:12 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200601062811euoutp02b053d396b0d5ee3f72d02af8f9e17bde~UV5rvFzIE1934419344euoutp02_
        for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2020 06:28:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200601062811euoutp02b053d396b0d5ee3f72d02af8f9e17bde~UV5rvFzIE1934419344euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590992891;
        bh=FQG00QV5OxUCxh7dnJby8mkSl6gBbMS+/yygn2pYDU4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ApjbKjcUAYGUGiNHVWUZOSRwYBCPvMNi+aMuRHxd1uq4NyFPMTOHYwbwNurnhef2Q
         EJs8YWQajTooZWmwV1y5FqJZkGsdfykYIIuvJgulnquvlJ/NEcF9PIACI1Q+1Ndbh5
         hd3wG/iDNcR5fNIpps1+z2LcHwH1ZjI6DUdUYTmY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200601062810eucas1p2a6f200be44d52c5206d3b5ce2fc0f949~UV5rNSKFV0985409854eucas1p2S;
        Mon,  1 Jun 2020 06:28:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DE.75.60698.AFF94DE5; Mon,  1
        Jun 2020 07:28:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200601062810eucas1p15133a2af025fe51b04af79a3eccb28de~UV5quBZBj1846918469eucas1p1e;
        Mon,  1 Jun 2020 06:28:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200601062810eusmtrp164b8f5155898f4777317b95ac46a96f5~UV5qtPDak1725617256eusmtrp1A;
        Mon,  1 Jun 2020 06:28:10 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-36-5ed49ffa8c6f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 88.49.07950.AFF94DE5; Mon,  1
        Jun 2020 07:28:10 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200601062809eusmtip2706e0e26a4e661f2bf01555cf714e7d1~UV5p8x2hF2192721927eusmtip2S;
        Mon,  1 Jun 2020 06:28:09 +0000 (GMT)
Subject: Re: [PATCH 2/2] soc: samsung: Add simple voltage coupler for
 Exynos5800
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>, peron.clem@gmail.com,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <57cf3a15-5d9b-7636-4c69-60742e8cfae6@samsung.com>
Date:   Mon, 1 Jun 2020 08:28:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200529174314.GB20540@kozik-lap>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbVBMYRj13nv37q2x5m2LnokyNglR+ZxXTBOTcX/4gf6YZlqWbmVUslv5
        +tNoaEvkq1ErKhqS9DXVUqZJGStbLUUfSBobg0JTW1Ki3Vv075zznGfOc955OVr+UeLCHYiO
        FdTRqkgFa89UPhk1rfyV/VLpW9q4jJRmFEtIeo+ZJe1DnyTk7sAHREymEil5f62TIsMvtRRp
        rcpiyeDZx4hkmGoo0veziSJvrrcypNHYIiETbaUM0T4epkmphQ/A/ANdl5QvK0hm+bdtD1k+
        7bcvX/4qieHPlRcg3tChp/jBMrcdXLD9plAh8kC8oPbx32sfMVqipWMKvI7m5N2kE1C9ewqy
        4wCvhcKzTyQpyJ6T43wEreYfrEiGEFR3X6VFMoigIrePml6xXH425bqNIK+nBonkO4I/eQap
        1eWId0Hm13HWip3wMmj/PWILoXEeA536U7YBi1dBSn/KJOY4GfaH9FvhVpnBi+F7d60tbS4O
        gdTuL7QVy7ADNGSaGSu2wz5wdfynDdN4Iej7s2gRO8NrczZlzQKczMGLStPU2YFwIT+XFbEj
        fDGUS0W8AIyXUhlxIRFBT/M9qUhSJ5/jZAYSXRvhbfMv26X0ZJ3iKh9R3gxfh5poqwx4DnT0
        O4hHzIGLlVemZBloT8tF9xLQGYr+xT563kKfRwrdjGq6GXV0M+ro/ufmIKYAOQtxmqhwQbMm
        WjjirVFFaeKiw733H4oqQ5O/zzhhsNxHNeP76hDmkGK2bGlLq1IuUcVrjkXVIeBohZNsS5NR
        KZeFqo4dF9SH9qjjIgVNHZrPMQpn2Zobn0PkOFwVKxwUhBhBPT2lODuXBCRNbOgfflMUtJ48
        3bbgzLzUQqWnFHuucHrmXntE61JtPuHN+o+NbEnfrvf7dNjB0bV3dd/WRZ/DKkY2b8KB/mFo
        524PS0BSTPGpSN/cLq87A+sGqoJLOhM63TIs7wKMwvHEsSQv7y4omrXUQxXnru/l69O+Zb3w
        K7frTQyiwja4KhhNhGrVclqtUf0Fwe9My3kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsVy+t/xe7q/5l+JM+jq4bLYOGM9q8XUh0/Y
        LK5/ec5qsfrjY0aL8+c3sFs8mHuTyeLblQ4mi8u75rBZfO49wmgx4/w+Jos3P84yWdyed5nF
        4szpS6wW/65tZLHoOPKN2WLjVw8HAY+ds+6ye2xa1cnmcefaHjaP/r8GHluutrN49G1Zxehx
        /MZ2Jo/Pm+QCOKL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLL
        Uov07RL0Mn5u6GAuWKVdsWDJYuYGxsPKXYycHBICJhJfp5xi62Lk4hASWMooMflaMxtEQkbi
        5LQGVghbWOLPtS6ooreMEjvmTgErEhYIkpj5+g+YLSKgKXH973dWkCJmgWUsEjsWzGOG6HjF
        KPHo9BFmkCo2AUOJrrcgozg4eAXsJKYuSwcJswioSLy/f4AJxBYViJXoXvyDHcTmFRCUODnz
        CQuIzSmgLzH7zw8wm1nATGLe5ofMELa8xPa3c6BscYlbT+YzTWAUmoWkfRaSlllIWmYhaVnA
        yLKKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMNa3Hfu5ZQdj17vgQ4wCHIxKPLwXzl+OE2JN
        LCuuzD3EKMHBrCTC63T2dJwQb0piZVVqUX58UWlOavEhRlOg5yYyS4km5wPTUF5JvKGpobmF
        paG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBkbHdvvypZoX309V3Oq2yE+ht82r
        u3Tznf583Zt7DPUC7BYLaHGLr9y7j72qNPxC6+OPO+T5dhrK7NimNis4tyU4f67msc7GTOeC
        894vLf5Vz7its2lDzNyoHWu5sqO/OXUYHXE2a31Xrvqc30f6UwL/60ofXc3SyemFGnt2+O/S
        nK2u/UJ6hhJLcUaioRZzUXEiAHeFVgULAwAA
X-CMS-MailID: 20200601062810eucas1p15133a2af025fe51b04af79a3eccb28de
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200529124952eucas1p2565c598c3c0164b5dec6ed83e19148b8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200529124952eucas1p2565c598c3c0164b5dec6ed83e19148b8
References: <20200529124940.10675-1-m.szyprowski@samsung.com>
        <CGME20200529124952eucas1p2565c598c3c0164b5dec6ed83e19148b8@eucas1p2.samsung.com>
        <20200529124940.10675-3-m.szyprowski@samsung.com>
        <20200529174314.GB20540@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 29.05.2020 19:43, Krzysztof Kozlowski wrote:
> On Fri, May 29, 2020 at 02:49:40PM +0200, Marek Szyprowski wrote:
>> Add custom voltage regulator coupler for Exynos5800 SoCs, which require
>> coupling between "vdd_arm" and "vdd_int" regulators. This coupler ensures
>> that coupled regulators voltage balancing is done only when clients for
>> each regulator (cpufreq for "vdd_arm" and devfreq for "vdd_int") apply
>> their constraints, so the voltage values don't go beyond the
>> bootloader-selected operation point during the boot process. This also
>> ensures proper voltage balancing if any of those drivers is missing.

I've intentionally didn't add any new properties nor bindings, because I 
assume that the generic regulator coupling bindings fully describe what 
is needed for Exynos5800 SoCs. This driver 'fixes' only the issue (or 
lets it call undefined behavior) in the regulator core, which is fatal 
for Exynos5800.

Please note that this "attach" callback is called only for the 
regulators, which are marked as coupled, so for all existing board it 
might be even enough to simply return 0 without any check. IMHO for all 
existing Exynos5422/5800 the name-based check is enough. I can change it 
to a check for particular DT path peculiar for Exynos5422/5800 (the 
check if the given regulator mathes the phandle specificied in the 
exynos-bus node for "wcore" or A15's CPU).

>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   arch/arm/mach-exynos/Kconfig                  |  1 +
>>   drivers/soc/samsung/Kconfig                   |  3 +
>>   drivers/soc/samsung/Makefile                  |  1 +
>>   .../soc/samsung/exynos-regulator-coupler.c    | 59 +++++++++++++++++++
>>   4 files changed, 64 insertions(+)
>>   create mode 100644 drivers/soc/samsung/exynos-regulator-coupler.c
>>
>> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
>> index 76838255b5fa..f185cd3d4c62 100644
>> --- a/arch/arm/mach-exynos/Kconfig
>> +++ b/arch/arm/mach-exynos/Kconfig
>> @@ -118,6 +118,7 @@ config SOC_EXYNOS5800
>>   	bool "Samsung EXYNOS5800"
>>   	default y
>>   	depends on SOC_EXYNOS5420
>> +	select EXYNOS_REGULATOR_COUPLER
>>   
>>   config EXYNOS_MCPM
>>   	bool
>> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
>> index c7a2003687c7..264185664594 100644
>> --- a/drivers/soc/samsung/Kconfig
>> +++ b/drivers/soc/samsung/Kconfig
>> @@ -37,4 +37,7 @@ config EXYNOS_PM_DOMAINS
>>   	bool "Exynos PM domains" if COMPILE_TEST
>>   	depends on PM_GENERIC_DOMAINS || COMPILE_TEST
>>   
>> +config EXYNOS_REGULATOR_COUPLER
>> +	bool "Exynos SoC Regulator Coupler" if COMPILE_TEST
>> +	depends on ARCH_EXYNOS || COMPILE_TEST
>>   endif
>> diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
>> index edd1d6ea064d..ecc3a32f6406 100644
>> --- a/drivers/soc/samsung/Makefile
>> +++ b/drivers/soc/samsung/Makefile
>> @@ -9,3 +9,4 @@ obj-$(CONFIG_EXYNOS_PMU)	+= exynos-pmu.o
>>   obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)	+= exynos3250-pmu.o exynos4-pmu.o \
>>   					exynos5250-pmu.o exynos5420-pmu.o
>>   obj-$(CONFIG_EXYNOS_PM_DOMAINS) += pm_domains.o
>> +obj-$(CONFIG_EXYNOS_REGULATOR_COUPLER) += exynos-regulator-coupler.o
>> diff --git a/drivers/soc/samsung/exynos-regulator-coupler.c b/drivers/soc/samsung/exynos-regulator-coupler.c
>> new file mode 100644
>> index 000000000000..54445918bd75
>> --- /dev/null
>> +++ b/drivers/soc/samsung/exynos-regulator-coupler.c
>> @@ -0,0 +1,59 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2020 Samsung Electronics Co., Ltd.
>> + *	      http://www.samsung.com/
>> + * Author: Marek Szyprowski <m.szyprowski@samsung.com>
>> + *
>> + * Samsung Exynos SoC voltage coupler
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/of.h>
>> +#include <linux/regulator/coupler.h>
>> +#include <linux/regulator/driver.h>
>> +
>> +static int exynos_coupler_balance_voltage(struct regulator_coupler *coupler,
>> +					  struct regulator_dev *rdev,
>> +					  suspend_state_t state)
>> +{
>> +	struct coupling_desc *c_desc = &rdev->coupling_desc;
>> +	int ret, cons_uV = 0, cons_max_uV = INT_MAX;
>> +	bool skip_coupled = false;
>> +
>> +	/* get coupled regulator constraints */
>> +	ret = regulator_check_consumers(c_desc->coupled_rdevs[1], &cons_uV,
>> +					&cons_max_uV, state);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* skip adjusting coupled regulator if it has no constraints set yet */
>> +	if (cons_uV == 0)
>> +		skip_coupled = true;
>> +
>> +	return regulator_do_balance_voltage(rdev, state, skip_coupled);
>> +}
>> +
>> +static int exynos_coupler_attach(struct regulator_coupler *coupler,
>> +				 struct regulator_dev *rdev)
>> +{
>> +	if (strcmp(rdev_get_name(rdev), "vdd_arm") == 0 ||
>> +	    strcmp(rdev_get_name(rdev), "vdd_int") == 0)
> Thanks for the patch!
>
> You hard-coded specific names of regulators existing
> only in DTS. They do not come from any driver nor bindings, therefore
> they could change making driver unusable. Someone could add a new DTS
> with different names and expect this to work as well.
>
> You need bindings for this. Something like:
> Documentation/devicetree/bindings/regulator/nvidia,tegra-regulators-coupling.txt
> But better in YAML, if possible.
>
> Best regards,
> Krzysztof
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


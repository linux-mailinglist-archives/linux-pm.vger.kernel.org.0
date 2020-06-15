Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784261F941C
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 11:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgFOJ6j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 05:58:39 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35525 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbgFOJ6i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 05:58:38 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200615095835euoutp02da179d0efc37dab92ca0a4f0a0f6e715~YrzYbb9NE0587905879euoutp02G
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 09:58:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200615095835euoutp02da179d0efc37dab92ca0a4f0a0f6e715~YrzYbb9NE0587905879euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592215115;
        bh=U+AnHz1rO63CtA/0dA78jHW57Oj3EK9i5YC/cBb6Suw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qdZzvgfkJtwrt4L9Xf4r/EpQXrUogI1QRoROwVf7Crb1QyWhgljmKsYE5jWhc+Wnl
         f90VrUFeCiH5smCZ7SLIdtrGBSmb76kekMUTNjwS9M49FfR1QX23ASg3fnxSjeWPJR
         zTwjBb4KmbqycGYnIDrFspqmB4T+fMvYA8aZkuWU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200615095834eucas1p10a0b1db0276d32f0bdd3e77bc345269a~YrzYBCrY70835308353eucas1p1p;
        Mon, 15 Jun 2020 09:58:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9A.2B.60698.A4647EE5; Mon, 15
        Jun 2020 10:58:34 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200615095834eucas1p1de03de3f6e2f10a75b0aa8e692b6c9fd~YrzXadc6A0833808338eucas1p1x;
        Mon, 15 Jun 2020 09:58:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200615095834eusmtrp1234cb486d8fbb69c8d016f3d378ac126~YrzXZmmxK1380713807eusmtrp14;
        Mon, 15 Jun 2020 09:58:34 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-65-5ee7464aef81
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AE.E3.08375.94647EE5; Mon, 15
        Jun 2020 10:58:33 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200615095832eusmtip19a87fb7097b5629a79213cb1f7adc7f8~YrzWJHzWH0533005330eusmtip1D;
        Mon, 15 Jun 2020 09:58:32 +0000 (GMT)
Subject: Re: [PATCH v3] soc: samsung: Add simple voltage coupler for
 Exynos5800
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>, peron.clem@gmail.com,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <67106b1a-a612-c471-b934-1b51a07a5750@samsung.com>
Date:   Mon, 15 Jun 2020 11:58:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200610070811.GB3716@kozik-lap>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0gUURjlzszOzi6tjavhl0nFitGD1sJ+XCgso2IowfoRpaW55uAuvne0
        h0FIZeqippZlS+VqaGqZuflKttcmSllqmvYyUpKkh+T61rLSHS3/nXO+891zPrgMqRyQuDK6
        qDheH6WJUNFyqrphomXtzh19QesseStxRW65BOf09NL49XCfBN+0fUK4peWOFHdffUvg0Vcp
        BG6vu0LjofR6hHNbHhD4+/gLAr+/1k7h501tEmywTtH4d2cFhVPqR0lcMcJtceTuGT9IOZM5
        njOXptJcV6eF5s5NreMqO5IpLqOyFHGNb2oIbsi8dLcsQL4plI/QHeH1nt7Bcu3FAask5u2e
        Y3eLa4lE9NnHgGQMsBsguWhcYkByRskWIyi3DJMiGUZQ9KOVEMkQgsKULHJuxXYxH4mDGwjy
        LNW0SH4gGCx+Jp1xObF74H7bc3oGO7Or4PXUmD2EZJspmBi9L5kZ0Ox6MPQb7CYF6w0FX67b
        dYr1gJ6Xk/aHFrGBkFFomvU4wtPLvdQMlrFqSHz60V6JZJdBTf+VWewC73rz7L2BzWHglsk8
        23sbdAwmEiJ2gq+NlVIRu0HT+TRKXDiNoKe5TCqSNATtp3KR6NoIXc2T0zWY6YhVUF7nKco+
        UDLRYZeBdYA3/Y5iCQfIrr5EirICUs4qRfcKMDbe/hf7uLWNzEQq47zTjPPOMc47x/g/14So
        UuTCxwuRYbzgFcUfVQuaSCE+Kkx9ODrSjKb/YdPvxpFa9OBXiBWxDFItUGTu+xyklGiOCMcj
        rQgYUuWs2PqiKUipCNUcT+D10Yf08RG8YEVLGErlovAq+BKoZMM0cXw4z8fw+rkpwchcExFt
        XfNzsiD9XUPssaRHmVpdT0DWr28ejk/Ue93UGbFV2qDBoWdHufSEkuV+4Zu3u+30+/NwpESe
        SlmqdN/y/AXdGRuXM+yfy1YNunsGBvu+R+4HvPyiPc6VXSg7EbfrYFZS92T+fkOmMdo3u6u7
        zRaiVY1+WFzbbJSdXDlmW7ggWUUJWs361aRe0PwFACDuAoMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42I5/e/4XV1Pt+dxBjde21hsnLGe1WLqwyds
        Fte/PGe1WP3xMaPF+fMb2C0ezL3JZPHtSgeTxeVdc9gsPvceYbSYcX4fk8WbH2eZLG7Pu8xi
        ceb0JVaLrkN/2Sz+XdvIYtFx5BuzxcavHg6CHjtn3WX3WLCp1GPTqk42jzvX9rB59P818Nhy
        tZ3Fo2/LKkaP4ze2M3l83iQXwBmlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2Vk
        qqRvZ5OSmpNZllqkb5eglzHtwyHWgpuBFZtX7GBqYHzm2MXIySEhYCLxcdpCxi5GLg4hgaWM
        Equ33GSGSMhInJzWwAphC0v8udbFBlH0llHi1ZNpTCAJYYFAib2XzrCB2CICmhLX/35nBSli
        FjjHIvFzXx87RMdWRonpb9aDjWUTMJToetsF1sErYCex6OVisBUsAqoSDy/+YgexRQViJb7d
        2wJVIyhxcuYTFhCbU0BPouHkfbA5zAJmEvM2P4Sy5SW2v50DZYtL3Hoyn2kCo9AsJO2zkLTM
        QtIyC0nLAkaWVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIHxv+3Yz807GC9tDD7EKMDBqMTD
        axH6LE6INbGsuDL3EKMEB7OSCK/T2dNxQrwpiZVVqUX58UWlOanFhxhNgZ6byCwlmpwPTE15
        JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYa8/us/Rd0CHWoe1p
        8XOe3v4Pf5YeOc1bvWnKjD6vH3MvO5rvXs0rkfgst8xmX8On8zwNVYF7ra30Pwqlb80w4T2n
        pvH2yN02adFgrhIt8/vT9t5J5+Jca5GmVeF+9BZL66JtGnPPRJybr7tlL4uX/o32wCumew5H
        p06QOXfzK1PKBOWoPq+PSizFGYmGWsxFxYkAdl1oBxUDAAA=
X-CMS-MailID: 20200615095834eucas1p1de03de3f6e2f10a75b0aa8e692b6c9fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200609104230eucas1p2efc14b59c4ccdcb839b54a62fbd8a31c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200609104230eucas1p2efc14b59c4ccdcb839b54a62fbd8a31c
References: <CGME20200609104230eucas1p2efc14b59c4ccdcb839b54a62fbd8a31c@eucas1p2.samsung.com>
        <20200609104221.21243-1-m.szyprowski@samsung.com>
        <20200610070811.GB3716@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 10.06.2020 09:08, Krzysztof Kozlowski wrote:
> On Tue, Jun 09, 2020 at 12:42:21PM +0200, Marek Szyprowski wrote:
>> Add a simple custom voltage regulator coupler for Exynos5800 SoCs, which
>> require coupling between "vdd_arm" and "vdd_int" regulators. This coupler
>> ensures that the voltage values don't go below the bootloader-selected
>> operation point during the boot process until a the clients sets their
>> constraints. It is achieved by assuming minimal voltage value equal to
>> the current value if no constraints are set. This also ensures proper
>> voltage balancing if any of the client driver is missing.
>>
>> The balancing code comes from regulator core.c with the
> You cut the sentence.

Right, looks like a copy/paste issue. I will fix this in v4.


>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>> This patch is yet another attempt to fix the regulator coupling on
>> Exynos5800/5422 SoCs. Here are links to the previous attempts and
>> discussions:
>>
>> https://lore.kernel.org/linux-samsung-soc/20191008101709.qVNy8eijBi0LynOteWFMnTg4GUwKG599n6OyYoX1Abs@z/
>> https://lore.kernel.org/lkml/20191017102758.8104-1-m.szyprowski@samsung.com/
>> https://lore.kernel.org/linux-pm/cover.1589528491.git.viresh.kumar@linaro.org/
>> https://lore.kernel.org/linux-pm/20200528131130.17984-1-m.szyprowski@samsung.com/
>> https://lore.kernel.org/linux-samsung-soc/57cf3a15-5d9b-7636-4c69-60742e8cfae6@samsung.com/
>> https://lore.kernel.org/lkml/20200605063724.9030-1-m.szyprowski@samsung.com/
>>
>> The problem is with "vdd_int" regulator coupled with "vdd_arm" on Odroid
>> XU3/XU4 boards family. "vdd_arm" is handled by CPUfreq. "vdd_int" is
>> handled by devfreq. CPUfreq initialized quite early during boot and it
>> starts changing OPPs and "vdd_arm" value. Sometimes CPU activity during
>> boot goes down and some low-frequency OPPs are selected, what in turn
>> causes lowering "vdd_arm". This happens before devfreq applies its
>> requirements on "vdd_int". Regulator balancing code reduces "vdd_arm"
>> voltage value, what in turn causes lowering "vdd_int" value to the lowest
>> possible value. This is much below the operation point of the wcore bus,
>> which still runs at the highest frequency.
>>
>> The issue was hard to notice because in the most cases the board managed
>> to boot properly, even when the regulator was set to lowest value allowed
>> by the regulator constraints. However, it caused some random issues,
>> which can be observed as "Unhandled prefetch abort" or low USB stability.
>>
>> Handling this case in the generic code has been rejected, so the only way
>> to ensure the desired behavior on Exynos5800-based SoCs is to make a
>> custom regulator coupler driver. I've tried hard to extract some common
>> code to simplify the exynos-regulator-coupler driver as much as possible,
>> but the difference between it and the generic code is so deep that this
>> approach failed, so indead I simply copied and modified the balancing
>> code.
>>
>> Best regards
>> Marek Szyprowski
>> ---
>>   arch/arm/mach-exynos/Kconfig                  |   1 +
>>   drivers/soc/samsung/Kconfig                   |   3 +
>>   drivers/soc/samsung/Makefile                  |   1 +
>>   .../soc/samsung/exynos-regulator-coupler.c    | 221 ++++++++++++++++++
>>   4 files changed, 226 insertions(+)
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
>> index 19c4d3f1437b..5d7819b52eed 100644
>> --- a/drivers/soc/samsung/Kconfig
>> +++ b/drivers/soc/samsung/Kconfig
>> @@ -43,4 +43,7 @@ config EXYNOS_PM_DOMAINS
>>   	bool "Exynos PM domains" if COMPILE_TEST
>>   	depends on PM_GENERIC_DOMAINS || COMPILE_TEST
>>   
>> +config EXYNOS_REGULATOR_COUPLER
>> +	bool "Exynos SoC Regulator Coupler" if COMPILE_TEST
>> +	depends on ARCH_EXYNOS || COMPILE_TEST
>>   endif
>> diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
>> index 31db65cb7aa3..93285faec416 100644
>> --- a/drivers/soc/samsung/Makefile
>> +++ b/drivers/soc/samsung/Makefile
>> @@ -10,3 +10,4 @@ obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)	+= exynos3250-pmu.o exynos4-pmu.o \
>>   					exynos5250-pmu.o exynos5420-pmu.o
>>   obj-$(CONFIG_EXYNOS_PMU_ARM64_DRIVERS)	+= exynos-pm.o exynos5433-pmu.o
>>   obj-$(CONFIG_EXYNOS_PM_DOMAINS) += pm_domains.o
>> +obj-$(CONFIG_EXYNOS_REGULATOR_COUPLER) += exynos-regulator-coupler.o
>> diff --git a/drivers/soc/samsung/exynos-regulator-coupler.c b/drivers/soc/samsung/exynos-regulator-coupler.c
>> new file mode 100644
>> index 000000000000..3cafc1738eb6
>> --- /dev/null
>> +++ b/drivers/soc/samsung/exynos-regulator-coupler.c
>> @@ -0,0 +1,221 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2020 Samsung Electronics Co., Ltd.
>> + *	      http://www.samsung.com/
>> + * Author: Marek Szyprowski <m.szyprowski@samsung.com>
>> + *
>> + * Simplified generic volatage coupler from regulator core.c
>> + * The main difference is that it keeps current regulator voltage
>> + * if consumers didn't apply their contraints yet.
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/of.h>
>> +#include <linux/regulator/coupler.h>
>> +#include <linux/regulator/driver.h>
>> +#include <linux/regulator/machine.h>
>> +
>> +static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
>> +					 int *current_uV,
>> +					 int *min_uV, int *max_uV,
>> +					 suspend_state_t state)
>> +{
>> +	struct coupling_desc *c_desc = &rdev->coupling_desc;
>> +	struct regulator_dev **c_rdevs = c_desc->coupled_rdevs;
>> +	struct regulation_constraints *constraints = rdev->constraints;
>> +	int desired_min_uV = 0, desired_max_uV = INT_MAX;
>> +	int max_current_uV = 0, min_current_uV = INT_MAX;
>> +	int highest_min_uV = 0, target_uV, possible_uV;
>> +	int i, ret, max_spread, n_coupled = c_desc->n_coupled;
>> +	bool done;
>> +
>> +	*current_uV = -1;
>> +
>> +	/* Find highest min desired voltage */
>> +	for (i = 0; i < n_coupled; i++) {
>> +		int tmp_min = 0;
>> +		int tmp_max = INT_MAX;
>> +
>> +		lockdep_assert_held_once(&c_rdevs[i]->mutex.base);
>> +
>> +		ret = regulator_check_consumers(c_rdevs[i],
>> +						&tmp_min,
>> +						&tmp_max, state);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		if (tmp_min == 0) {
>> +			ret = regulator_get_voltage_rdev(c_rdevs[i]);
>> +			if (ret < 0)
>> +				return ret;
>> +			tmp_min = ret;
>> +		}
>> +
>> +		/* apply constraints */
>> +		ret = regulator_check_voltage(c_rdevs[i], &tmp_min, &tmp_max);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		highest_min_uV = max(highest_min_uV, tmp_min);
>> +
>> +		if (i == 0) {
>> +			desired_min_uV = tmp_min;
>> +			desired_max_uV = tmp_max;
>> +		}
>> +	}
>> +
>> +	max_spread = constraints->max_spread[0];
>> +
>> +	/*
>> +	 * Let target_uV be equal to the desired one if possible.
>> +	 * If not, set it to minimum voltage, allowed by other coupled
>> +	 * regulators.
>> +	 */
>> +	target_uV = max(desired_min_uV, highest_min_uV - max_spread);
>> +
>> +	/*
>> +	 * Find min and max voltages, which currently aren't violating
>> +	 * max_spread.
>> +	 */
>> +	for (i = 1; i < n_coupled; i++) {
>> +		int tmp_act;
>> +
>> +		tmp_act = regulator_get_voltage_rdev(c_rdevs[i]);
>> +		if (tmp_act < 0)
>> +			return tmp_act;
>> +
>> +		min_current_uV = min(tmp_act, min_current_uV);
>> +		max_current_uV = max(tmp_act, max_current_uV);
>> +	}
>> +
>> +	/*
>> +	 * Correct target voltage, so as it currently isn't
>> +	 * violating max_spread
>> +	 */
>> +	possible_uV = max(target_uV, max_current_uV - max_spread);
>> +	possible_uV = min(possible_uV, min_current_uV + max_spread);
>> +
>> +	if (possible_uV > desired_max_uV)
>> +		return -EINVAL;
>> +
>> +	done = (possible_uV == target_uV);
>> +	desired_min_uV = possible_uV;
>> +
>> +	/* Set current_uV if wasn't done earlier in the code and if necessary */
>> +	if (*current_uV == -1) {
>> +		ret = regulator_get_voltage_rdev(rdev);
>> +		if (ret < 0)
>> +			return ret;
>> +		*current_uV = ret;
>> +	}
>> +
>> +	*min_uV = desired_min_uV;
>> +	*max_uV = desired_max_uV;
>> +
>> +	return done;
>> +}
>> +
>> +static int exynos_coupler_balance_voltage(struct regulator_coupler *coupler,
>> +					  struct regulator_dev *rdev,
>> +					  suspend_state_t state)
>> +{
>> +	struct regulator_dev **c_rdevs;
>> +	struct regulator_dev *best_rdev;
>> +	struct coupling_desc *c_desc = &rdev->coupling_desc;
>> +	int i, ret, n_coupled, best_min_uV, best_max_uV, best_c_rdev;
>> +	unsigned int delta, best_delta;
>> +	unsigned long c_rdev_done = 0;
>> +	bool best_c_rdev_done;
>> +
>> +	c_rdevs = c_desc->coupled_rdevs;
>> +	n_coupled = c_desc->n_coupled;
>> +
>> +	/*
>> +	 * Find the best possible voltage change on each loop. Leave the loop
>> +	 * if there isn't any possible change.
>> +	 */
>> +	do {
>> +		best_c_rdev_done = false;
>> +		best_delta = 0;
>> +		best_min_uV = 0;
>> +		best_max_uV = 0;
>> +		best_c_rdev = 0;
>> +		best_rdev = NULL;
>> +
>> +		/*
>> +		 * Find highest difference between optimal voltage
>> +		 * and current voltage.
>> +		 */
>> +		for (i = 0; i < n_coupled; i++) {
>> +			/*
>> +			 * optimal_uV is the best voltage that can be set for
>> +			 * i-th regulator at the moment without violating
>> +			 * max_spread constraint in order to balance
>> +			 * the coupled voltages.
>> +			 */
>> +			int optimal_uV = 0, optimal_max_uV = 0, current_uV = 0;
>> +
>> +			if (test_bit(i, &c_rdev_done))
> Add a sanity check at beginning that you have enough of bits for this...
> or use bitmap.
Frankly, even regulator core uses this simple approach. I doubt that 
there will be more than 32 coupled regulators ever...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


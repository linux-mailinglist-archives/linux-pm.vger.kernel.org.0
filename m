Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE042EB3F8
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 21:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbhAEUPg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jan 2021 15:15:36 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51992 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbhAEUPg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2021 15:15:36 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 105KDuiU122204;
        Tue, 5 Jan 2021 14:13:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1609877636;
        bh=JkE8Bp/xOwwiFkoNjtFeuE2nXoQc50zBmN0lhx/HY2A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YRNMAG481ZjANDHi9eAeXxtQqa8Qu9XPvphOzMRwiWlhIlpYj2xqh0Smj8469ICj7
         VPKDr2CGDWRdzozah4TIYEl8oPx/qdjM0PUFHW+9J+xP6HdN66ksrJ1JjbyJIYz5Mq
         9wEd3S8orA2Nw9WqdfOlZaUJHED1qPLbKRYoFemE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 105KDusX079163
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Jan 2021 14:13:56 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 5 Jan
 2021 14:13:56 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 5 Jan 2021 14:13:56 -0600
Received: from [10.250.36.125] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 105KDuWR029366;
        Tue, 5 Jan 2021 14:13:56 -0600
Subject: Re: [EXTERNAL] Re: [PATCH v8 2/2] power: supply: bq256xx: Introduce
 the BQ256XX charger driver
To:     Sebastian Reichel <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kbuild-all@lists.01.org>, <dmurphy@ti.com>
References: <20210104202450.9669-3-r-rivera-matos@ti.com>
 <202101051158.UxB5IFs7-lkp@intel.com>
 <20210105141805.vhf7wrgcwujr7uwn@earth.universe>
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Message-ID: <26235205-f28a-e836-7863-bed2e9cb6f25@ti.com>
Date:   Tue, 5 Jan 2021 14:13:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210105141805.vhf7wrgcwujr7uwn@earth.universe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian,

On 1/5/21 8:18 AM, Sebastian Reichel wrote:
> Hi Ricardo,
>
> On Tue, Jan 05, 2021 at 11:24:18AM +0800, kernel test robot wrote:
>> Hi Ricardo,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on power-supply/for-next]
>> [also build test WARNING on robh/for-next v5.11-rc2 next-20210104]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Ricardo-Rivera-Matos/Introduce-the-BQ256XX-family-of-chargers/20210105-043028
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
>> config: powerpc64-randconfig-r034-20210105 (attached as .config)
>> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 5c951623bc8965fa1e89660f2f5f4a2944e4981a)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install powerpc64 cross compiling tool for clang build
>>          # apt-get install binutils-powerpc64-linux-gnu
>>          # https://github.com/0day-ci/linux/commit/82436c2c6d99c4effb187bbd09b47c4dc59a1f3d
>>          git remote add linux-review https://github.com/0day-ci/linux
>>          git fetch --no-tags linux-review Ricardo-Rivera-Matos/Introduce-the-BQ256XX-family-of-chargers/20210105-043028
>>          git checkout 82436c2c6d99c4effb187bbd09b47c4dc59a1f3d
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>     drivers/power/supply/bq256xx_charger.c:1644:29: warning: variable 'psy_cfg' is uninitialized when used here [-Wuninitialized]
>>             ret = bq256xx_parse_dt(bq, psy_cfg, dev);
>>                                        ^~~~~~~
>>     drivers/power/supply/bq256xx_charger.c:1618:37: note: initialize the variable 'psy_cfg' to silence this warning
>>             struct power_supply_config *psy_cfg;
>>                                                ^
>>                                                 = NULL
> bah, I missed this serious issue during review :(
>
> FWIW the compiler provided wrong solution. It would result in
> dereferencing a NULL pointer afterwards since you never allocate
> any memory for psy_cfg. You could of course allocate memory for
> it, but power_supply_config is only needed during device
> registration.
>
> Proper solution is to initialize it as variable instead of pointer,
> so that it ends up on the stack. Also you should initialize it with
> {} to make sure any fields not explicitly configured are 0.
ACK
>
>>>> drivers/power/supply/bq256xx_charger.c:1720:36: warning: unused variable 'bq256xx_acpi_match' [-Wunused-const-variable]
>>     static const struct acpi_device_id bq256xx_acpi_match[] = {
> For this one just change
>
> .acpi_match_table = ACPI_PTR(bq256xx_acpi_match),
>
> into
>
> .acpi_match_table = bq256xx_acpi_match,
ACK
>
>>     2 warnings generated.
>>
>>
>> vim +/bq256xx_acpi_match +1720 drivers/power/supply/bq256xx_charger.c
>>
>>    1719	
>>> 1720	static const struct acpi_device_id bq256xx_acpi_match[] = {
>>    1721		{ "bq25600", BQ25600 },
>>    1722		{ "bq25600d", BQ25600D },
>>    1723		{ "bq25601", BQ25601 },
>>    1724		{ "bq25601d", BQ25601D },
>>    1725		{ "bq25611d", BQ25611D },
>>    1726		{ "bq25618", BQ25618 },
>>    1727		{ "bq25619", BQ25619 },
>>    1728		{},
>>    1729	};
>>    1730	MODULE_DEVICE_TABLE(acpi, bq256xx_acpi_match);
>>    1731	
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> Thanks,
>
> -- Sebastian
Thanks for the feedback on this!

Ricardo

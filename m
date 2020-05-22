Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149371DDDC9
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 05:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgEVDSf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 May 2020 23:18:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4837 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727024AbgEVDSf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 21 May 2020 23:18:35 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B4F8F87925602EB79EAD;
        Fri, 22 May 2020 11:18:30 +0800 (CST)
Received: from [127.0.0.1] (10.74.219.194) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Fri, 22 May 2020
 11:18:23 +0800
Subject: Re: [PATCH] base:power:sysfs: Remove redundant attribute
 runtime_status in runtime_attrs
To:     kbuild test robot <lkp@intel.com>, <rafael@kernel.org>,
        <pavel@ucw.cz>, <sre@kernel.org>
References: <1590053147-32207-1-git-send-email-chenxiang66@hisilicon.com>
 <202005212049.sWN89Bjc%lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, <john.garry@huawei.com>,
        <linux-pm@vger.kernel.org>, <linuxarm@huawei.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <63c077bb-53a2-c41e-bd94-9dcbd224f39c@hisilicon.com>
Date:   Fri, 22 May 2020 11:18:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <202005212049.sWN89Bjc%lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.219.194]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

OK, please ignore the patch.

在 2020/5/21 21:05, kbuild test robot 写道:
> Hi chenxiang,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on pm/linux-next]
> [also build test WARNING on pavel-linux-leds/for-next v5.7-rc6 next-20200519]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/chenxiang/base-power-sysfs-Remove-redundant-attribute-runtime_status-in-runtime_attrs/20200521-173130
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> config: arm-eseries_pxa_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
> In file included from drivers/base/power/sysfs.c:3:
> include/linux/device.h:132:26: warning: 'dev_attr_runtime_status' defined but not used [-Wunused-variable]
> 132 |  struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
> |                          ^~~~~~~~~
>>> drivers/base/power/sysfs.c:177:8: note: in expansion of macro 'DEVICE_ATTR_RO'
> 177 | static DEVICE_ATTR_RO(runtime_status);
> |        ^~~~~~~~~~~~~~
>
> vim +/DEVICE_ATTR_RO +177 drivers/base/power/sysfs.c
>
> 0fcb4eef829449 Alan Stern      2010-07-08  176
> 47acbd77e6e481 Andy Shevchenko 2017-11-10 @177  static DEVICE_ATTR_RO(runtime_status);
> 15bcb91d7e607d Alan Stern      2010-09-25  178
>
> :::::: The code at line 177 was first introduced by commit
> :::::: 47acbd77e6e481abf2f41d3a99cb3762f296b2e6 PM / sysfs: Convert to use DEVICE_ATTR_RO / DEVICE_ATTR_RW
>
> :::::: TO: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> :::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



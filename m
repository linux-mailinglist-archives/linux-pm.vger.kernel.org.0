Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CCD430D6C
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 03:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbhJRB2h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Oct 2021 21:28:37 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:29893 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbhJRB2g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Oct 2021 21:28:36 -0400
Received: from dggeml757-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HXfH50Qxqzbn7S;
        Mon, 18 Oct 2021 09:21:53 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 dggeml757-chm.china.huawei.com (10.1.199.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Mon, 18 Oct 2021 09:26:24 +0800
Subject: Re: [PATCH v2] thermal/core: fix a UAF bug in
 __thermal_cooling_device_register()
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211015024504.947520-1-william.xuanziyang@huawei.com>
 <CAJZ5v0h5-P+br-+44hv82jKdd=5Y-46daXMWLwsg9WDoEfG17g@mail.gmail.com>
From:   "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <88e43530-7b5e-4190-a5dc-961cf2df8c23@huawei.com>
Date:   Mon, 18 Oct 2021 09:26:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0h5-P+br-+44hv82jKdd=5Y-46daXMWLwsg9WDoEfG17g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeml757-chm.china.huawei.com (10.1.199.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> On Fri, Oct 15, 2021 at 4:46 AM Ziyang Xuan
> <william.xuanziyang@huawei.com> wrote:
>>
>> When device_register() return failed, program will goto out_kfree_type
>> to release 'cdev->device' by put_device(). That will call thermal_release()
>> to free 'cdev'. But the follow-up processes access 'cdev' continually.
>> That trggers the UAF bug.
>>
>> ====================================================================
>> BUG: KASAN: use-after-free in __thermal_cooling_device_register+0x75b/0xa90
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>> Call Trace:
>>  dump_stack_lvl+0xe2/0x152
>>  print_address_description.constprop.0+0x21/0x140
>>  ? __thermal_cooling_device_register+0x75b/0xa90
>>  kasan_report.cold+0x7f/0x11b
>>  ? __thermal_cooling_device_register+0x75b/0xa90
>>  __thermal_cooling_device_register+0x75b/0xa90
>>  ? memset+0x20/0x40
>>  ? __sanitizer_cov_trace_pc+0x1d/0x50
>>  ? __devres_alloc_node+0x130/0x180
>>  devm_thermal_of_cooling_device_register+0x67/0xf0
>>  max6650_probe.cold+0x557/0x6aa
>> ......
>>
>> Freed by task 258:
>>  kasan_save_stack+0x1b/0x40
>>  kasan_set_track+0x1c/0x30
>>  kasan_set_free_info+0x20/0x30
>>  __kasan_slab_free+0x109/0x140
>>  kfree+0x117/0x4c0
>>  thermal_release+0xa0/0x110
>>  device_release+0xa7/0x240
>>  kobject_put+0x1ce/0x540
>>  put_device+0x20/0x30
>>  __thermal_cooling_device_register+0x731/0xa90
>>  devm_thermal_of_cooling_device_register+0x67/0xf0
>>  max6650_probe.cold+0x557/0x6aa [max6650]
>>
>> Do not use 'cdev' again after put_device() to fix the problem like doing
>> in thermal_zone_device_register().
>>
>> Fixes: 584837618100 ("thermal/drivers/core: Use a char pointer for the cooling device name")
>> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> ---
>>  drivers/thermal/thermal_core.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 97ef9b040b84..d2c196b298c1 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -888,7 +888,7 @@ __thermal_cooling_device_register(struct device_node *np,
>>  {
>>         struct thermal_cooling_device *cdev;
>>         struct thermal_zone_device *pos = NULL;
>> -       int ret;
>> +       int id, ret;
>>
>>         if (!ops || !ops->get_max_state || !ops->get_cur_state ||
>>             !ops->set_cur_state)
>> @@ -901,7 +901,7 @@ __thermal_cooling_device_register(struct device_node *np,
>>         ret = ida_simple_get(&thermal_cdev_ida, 0, 0, GFP_KERNEL);
>>         if (ret < 0)
>>                 goto out_kfree_cdev;
>> -       cdev->id = ret;
>> +       cdev->id = id = ret;
> 
> I'd prefer this to be two statements, but I can fix it up.
> 
> Daniel, would there be any issues if I applied it?
> 
OK, no problem.

>>
>>         cdev->type = kstrdup(type ? type : "", GFP_KERNEL);
>>         if (!cdev->type) {
>> @@ -942,8 +942,9 @@ __thermal_cooling_device_register(struct device_node *np,
>>  out_kfree_type:
>>         kfree(cdev->type);
>>         put_device(&cdev->device);
>> +       cdev = NULL;
>>  out_ida_remove:
>> -       ida_simple_remove(&thermal_cdev_ida, cdev->id);
>> +       ida_simple_remove(&thermal_cdev_ida, id);
>>  out_kfree_cdev:
>>         kfree(cdev);
>>         return ERR_PTR(ret);
>> --
>> 2.25.1
>>
> .
> 

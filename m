Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01E666BDF7
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jan 2023 13:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjAPMiZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Jan 2023 07:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjAPMiX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2023 07:38:23 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEC11BAC7
        for <linux-pm@vger.kernel.org>; Mon, 16 Jan 2023 04:38:22 -0800 (PST)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NwWfk0PFvzJqnJ;
        Mon, 16 Jan 2023 20:34:06 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm100007.china.huawei.com (7.185.36.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 16 Jan 2023 20:38:18 +0800
Subject: Re: [PATCH v3] thermal/core: fix error paths in
 __thermal_cooling_device_register()
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>
CC:     Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <yangyingliang@huawei.com>
References: <20230112154721.452292-1-caleb.connolly@linaro.org>
 <20230116042326.l3kyd55lbw4dfocm@vireshk-i7>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <24afe142-f835-29af-fca6-d00e864b0c82@huawei.com>
Date:   Mon, 16 Jan 2023 20:38:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230116042326.l3kyd55lbw4dfocm@vireshk-i7>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100007.china.huawei.com (7.185.36.116)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 2023/1/16 12:23, Viresh Kumar wrote:
> On 12-01-23, 15:47, Caleb Connolly wrote:
>> There is in invalid call to thermal_cooling_device_destroy_sysfs() and
>> another to put_device() in the error paths here. Fix them.
>>
>> Fixes: c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>> Changes since v2:
>>   * Rework and simplify into one patch following Yang's suggestions.
>>
>> V2: https://lore.kernel.org/all/20230103171811.204196-1-caleb.connolly@linaro.org/
>> ---
>>   drivers/thermal/thermal_core.c | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
> Replied to an earlier version by mistake. Should it be like this ?
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index f17ab2316dbd..18db011d4d68 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -910,17 +910,15 @@ __thermal_cooling_device_register(struct device_node *np,
>
>          ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
>          if (ret)
> -               goto out_kfree_type;
> +               goto out_cdev_type;
>
>          thermal_cooling_device_setup_sysfs(cdev);
>          ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
> -       if (ret) {
> -               thermal_cooling_device_destroy_sysfs(cdev);
> -               goto out_kfree_type;
> -       }
> +       if (ret)
> +               goto out_cooling_dev;
>          ret = device_register(&cdev->device);
>          if (ret)
> -               goto out_kfree_type;
> +               goto out_put_device;
>
>          /* Add 'this' new cdev to the global cdev list */
>          mutex_lock(&thermal_list_lock);
> @@ -939,11 +937,12 @@ __thermal_cooling_device_register(struct device_node *np,
>
>          return cdev;
>
> -out_kfree_type:
> +out_put_device:
> +       put_device(&cdev->device);
> +out_cooling_dev:
>          thermal_cooling_device_destroy_sysfs(cdev);
> +out_cdev_type:
>          kfree(cdev->type);
The 'cdev' will be freed after calling put_device(), it can not be 
accessed anymore.

Thanks,
Yang
> -       put_device(&cdev->device);
> -       cdev = NULL;
>   out_ida_remove:
>          ida_free(&thermal_cdev_ida, id);
>   out_kfree_cdev:
>

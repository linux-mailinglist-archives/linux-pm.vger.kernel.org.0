Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5CE66BE3B
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jan 2023 13:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjAPMyz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Jan 2023 07:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjAPMyh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2023 07:54:37 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D74B1EFC5
        for <linux-pm@vger.kernel.org>; Mon, 16 Jan 2023 04:52:12 -0800 (PST)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NwX1S2T8lzRr1J;
        Mon, 16 Jan 2023 20:50:20 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm100007.china.huawei.com (7.185.36.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 16 Jan 2023 20:52:09 +0800
Subject: Re: [PATCH v3] thermal/core: fix error paths in
 __thermal_cooling_device_register()
To:     Caleb Connolly <caleb.connolly@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
CC:     <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <yangyingliang@huawei.com>
References: <20230112154721.452292-1-caleb.connolly@linaro.org>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <910ee6b9-c65d-0808-9667-db442a335aeb@huawei.com>
Date:   Mon, 16 Jan 2023 20:52:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230112154721.452292-1-caleb.connolly@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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


On 2023/1/12 23:47, Caleb Connolly wrote:
> There is in invalid call to thermal_cooling_device_destroy_sysfs() and
> another to put_device() in the error paths here. Fix them.
>
> Fixes: c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Changes since v2:
>   * Rework and simplify into one patch following Yang's suggestions.
>
> V2: https://lore.kernel.org/all/20230103171811.204196-1-caleb.connolly@linaro.org/
> ---
>   drivers/thermal/thermal_core.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index f17ab2316dbd..321d2a6300c4 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -909,15 +909,16 @@ __thermal_cooling_device_register(struct device_node *np,
>   	cdev->devdata = devdata;
>   
>   	ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
> -	if (ret)
> -		goto out_kfree_type;
> +	if (ret) {
> +		kfree(cdev->type);
> +		goto out_ida_remove;
> +	}
>   
>   	thermal_cooling_device_setup_sysfs(cdev);
>   	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
> -	if (ret) {
> -		thermal_cooling_device_destroy_sysfs(cdev);
> +	if (ret)
>   		goto out_kfree_type;
> -	}
> +
Before device_initialize() which is called in device_register(), we can 
not call put_device().
So we can not use 'out_kfree_type' lable before calling device_register().

How about like fix it this:
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index f17ab2316dbd..b57a6db0efdf 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -909,14 +909,17 @@ __thermal_cooling_device_register(struct 
device_node *np,
         cdev->devdata = devdata;

         ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
-       if (ret)
-               goto out_kfree_type;
+       if (ret) {
+               kfree(cdev->type);
+               goto out_ida_remove;
+       }

         thermal_cooling_device_setup_sysfs(cdev);
         ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
         if (ret) {
                 thermal_cooling_device_destroy_sysfs(cdev);
-               goto out_kfree_type;
+               kfree(cdev->type);
+               goto out_ida_remove;
         }
         ret = device_register(&cdev->device);
         if (ret)

Thanks,
Yang
>   	ret = device_register(&cdev->device);
>   	if (ret)
>   		goto out_kfree_type;

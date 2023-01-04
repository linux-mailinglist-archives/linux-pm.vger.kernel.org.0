Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B322A65CBDF
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jan 2023 03:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjADC1v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Jan 2023 21:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbjADC1u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Jan 2023 21:27:50 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC40C1869E
        for <linux-pm@vger.kernel.org>; Tue,  3 Jan 2023 18:27:48 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Nmth30hHczJprZ;
        Wed,  4 Jan 2023 10:23:47 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 4 Jan 2023 10:27:46 +0800
Subject: Re: [PATCH v2 1/2] thermal/core: fix unbalanced put_device in
 register error path
To:     Caleb Connolly <caleb.connolly@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
CC:     <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <yangyingliang@huawei.com>
References: <20230103171811.204196-1-caleb.connolly@linaro.org>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <66cd7574-ce32-006d-7a0b-062b97a1736e@huawei.com>
Date:   Wed, 4 Jan 2023 10:27:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230103171811.204196-1-caleb.connolly@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 2023/1/4 1:18, Caleb Connolly wrote:
> Commit c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
> causes device_put() to be called if the get_max_state() callback fails
> during __thermal_cooling_device_register().
>
> Fix the cleanup ordering to only call device_put() if initialization
> fails after the matching device_register() call.
>
> Fixes: c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
This commit introduced two unnecessary 
callings(thermal_cooling_device_destroy_sysfs and put_device)
in the error path, I think they should be fixed in one patch. How about 
fix like this:
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -909,8 +909,10 @@ __thermal_cooling_device_register(struct 
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

Thanks,
Yang
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Changes since v1:
>   * Add second patch.
>
> V1: https://lore.kernel.org/all/20221231210301.6968-1-caleb.connolly@linaro.org/
> ---
>   drivers/thermal/thermal_core.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index f17ab2316dbd..2c6995b5dcb0 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -920,7 +920,7 @@ __thermal_cooling_device_register(struct device_node *np,
>   	}
>   	ret = device_register(&cdev->device);
>   	if (ret)
> -		goto out_kfree_type;
> +		goto out_put_device;
>   
>   	/* Add 'this' new cdev to the global cdev list */
>   	mutex_lock(&thermal_list_lock);
> @@ -939,10 +939,11 @@ __thermal_cooling_device_register(struct device_node *np,
>   
>   	return cdev;
>   
> +out_put_device:
> +	put_device(&cdev->device);
>   out_kfree_type:
>   	thermal_cooling_device_destroy_sysfs(cdev);
>   	kfree(cdev->type);
> -	put_device(&cdev->device);
>   	cdev = NULL;
>   out_ida_remove:
>   	ida_free(&thermal_cdev_ida, id);

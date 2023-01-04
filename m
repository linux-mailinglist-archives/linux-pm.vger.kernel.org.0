Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5238465CBE0
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jan 2023 03:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjADC2y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Jan 2023 21:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjADC2x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Jan 2023 21:28:53 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4699617E3C
        for <linux-pm@vger.kernel.org>; Tue,  3 Jan 2023 18:28:52 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Nmtm70T61zRqfj;
        Wed,  4 Jan 2023 10:27:19 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 4 Jan 2023 10:28:49 +0800
Subject: Re: [PATCH v2 2/2] thermal/core: fix unbalanced destroy_sysfs error
 path in register
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
 <20230103171811.204196-2-caleb.connolly@linaro.org>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <ca471ae1-bc95-cce1-9c6b-627ff607cf1d@huawei.com>
Date:   Wed, 4 Jan 2023 10:28:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230103171811.204196-2-caleb.connolly@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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


On 2023/1/4 1:18, Caleb Connolly wrote:
> Commit 4748f9687caa ("thermal: core: fix some possible name leaks in error paths")
> causes thermal_cooling_device_destroy_sysfs() to be called incorrectly
> in __thermal_cooling_device_register() if ->get_max_state() fails. It
> also causes it to get called twice if dev_set_name() fails.
>
> Adjust the error paths to ensure thermal_cooling_device_destroy_sysfs()
> is only called for a matching thermal_cooling_device_setup_sysfs().
>
> Fixes: 4748f9687caa ("thermal: core: fix some possible name leaks in error paths")
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/thermal/thermal_core.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 2c6995b5dcb0..28864f14b01c 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -914,10 +914,9 @@ __thermal_cooling_device_register(struct device_node *np,
>   
>   	thermal_cooling_device_setup_sysfs(cdev);
>   	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
> -	if (ret) {
> -		thermal_cooling_device_destroy_sysfs(cdev);
> -		goto out_kfree_type;
> -	}
> +	if (ret)
> +		goto out_destroy_sysfs;
> +
>   	ret = device_register(&cdev->device);
>   	if (ret)
>   		goto out_put_device;
> @@ -941,8 +940,9 @@ __thermal_cooling_device_register(struct device_node *np,
>   
>   out_put_device:
>   	put_device(&cdev->device);
> -out_kfree_type:
> +out_destroy_sysfs:
>   	thermal_cooling_device_destroy_sysfs(cdev);
The 'cdev' is freed in thermal_release() while calling put_device(), it 
causes UAF here.

Thanks,
Yang
> +out_kfree_type:
>   	kfree(cdev->type);
>   	cdev = NULL;
>   out_ida_remove:

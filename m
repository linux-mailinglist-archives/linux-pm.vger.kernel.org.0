Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F50335510C
	for <lists+linux-pm@lfdr.de>; Tue,  6 Apr 2021 12:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242809AbhDFKiY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Apr 2021 06:38:24 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37952 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhDFKiX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Apr 2021 06:38:23 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 136Ac6bf078390;
        Tue, 6 Apr 2021 05:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617705486;
        bh=cDx/BwVmTsGaf5kP1m/T9FAofm5zp1u5vU0B5W3CTHs=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=ABkS/SKlqsRcbCliGG7T9RnRYUkShhDqgYSm9NfXTWValsqPvPUxwdwweFQBhKTk9
         UIhLx1GwLtQPCvhqKMz7FEaYE0bKoMgaaNLKmr4lHc7XZRXHx3NK9/1tn49oeXU8dk
         gqdJKPq8ci4lu2S5zdZhZg0KSVuk1oAxFUEfLJPM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 136Ac5Be026725
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Apr 2021 05:38:06 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 6 Apr
 2021 05:38:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 6 Apr 2021 05:38:05 -0500
Received: from [10.250.232.146] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 136Ac1k7038264;
        Tue, 6 Apr 2021 05:38:02 -0500
Subject: Re: [PATCH v2 1/1] thermal: ti-soc-thermal: Remove duplicated header
 file inclusion
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210406091912.2583-1-thunder.leizhen@huawei.com>
 <20210406091912.2583-2-thunder.leizhen@huawei.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <a8471ca7-461d-2b78-1d95-cda8e384bd9e@ti.com>
Date:   Tue, 6 Apr 2021 16:08:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210406091912.2583-2-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/6/2021 2:49 PM, Zhen Lei wrote:
> Delete one of the header files <linux/of_device.h> that are included
> twice, all included header files are then rearranged alphabetically.

Reviewed-by: Keerthy <j-keerthy@ti.com>

> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/thermal/ti-soc-thermal/ti-bandgap.c | 35 ++++++++++++++---------------
>   1 file changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> index 8a3646e26ddd208..5e7e80b4a8171c4 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -9,30 +9,29 @@
>    *   Eduardo Valentin <eduardo.valentin@ti.com>
>    */
>   
> -#include <linux/module.h>
> +#include <linux/clk.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
>   #include <linux/export.h>
> +#include <linux/gpio/consumer.h>
>   #include <linux/init.h>
> -#include <linux/kernel.h>
>   #include <linux/interrupt.h>
> -#include <linux/clk.h>
> -#include <linux/gpio/consumer.h>
> -#include <linux/platform_device.h>
> -#include <linux/err.h>
> -#include <linux/types.h>
> -#include <linux/spinlock.h>
> -#include <linux/sys_soc.h>
> -#include <linux/reboot.h>
> -#include <linux/of_device.h>
> -#include <linux/of_platform.h>
> -#include <linux/of_irq.h>
>   #include <linux/io.h>
>   #include <linux/iopoll.h>
> -#include <linux/cpu_pm.h>
> -#include <linux/device.h>
> -#include <linux/pm_runtime.h>
> -#include <linux/pm.h>
> -#include <linux/of.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
>   #include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reboot.h>
> +#include <linux/spinlock.h>
> +#include <linux/sys_soc.h>
> +#include <linux/types.h>
>   
>   #include "ti-bandgap.h"
>   
> 

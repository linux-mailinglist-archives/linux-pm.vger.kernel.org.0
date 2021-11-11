Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F0844D89A
	for <lists+linux-pm@lfdr.de>; Thu, 11 Nov 2021 15:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhKKOyS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Nov 2021 09:54:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:61742 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233676AbhKKOyS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 11 Nov 2021 09:54:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="230382926"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="230382926"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 06:51:29 -0800
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="501886225"
Received: from kgovindx-mobl.gar.corp.intel.com ([10.215.132.152])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 06:51:25 -0800
Message-ID: <b91c26d828b24479369fa1f17d8d03c324b5bebd.camel@linux.intel.com>
Subject: Re: [PATCH -next] thermal: int340x: processor_thermal: Fix build
 error
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     YueHaibing <yuehaibing@huawei.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 11 Nov 2021 06:51:21 -0800
In-Reply-To: <20211111070716.20260-1-yuehaibing@huawei.com>
References: <20211111070716.20260-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2021-11-11 at 15:07 +0800, YueHaibing wrote:
> drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c: In
> function ‘send_mbox_cmd’:
> drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c:79:16:
>  error: implicit declaration of function ‘readq’; did you mean
> ‘readl’? [-Werror=implicit-function-declaration]
>     *cmd_resp = readq((void __iomem *) (proc_priv->mmio_base +
> MBOX_OFFSET_DATA));
>                 ^~~~~
>                 readl
> 
> Add missing include to fix this.
Have you checked a patch titled "thermal/drivers/int340x: limit Kconfig
to 64-bit"?

Thanks,
Srinivas

> 
> Fixes: aeb58c860dc5 ("thermal/drivers/int340x: processor_thermal:
> Suppot 64 bit RFIM responses")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
> index a86521973dad..01008ae00e7f 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
> @@ -7,6 +7,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
>  #include "processor_thermal_device.h"
>  
>  #define MBOX_CMD_WORKLOAD_TYPE_READ    0x0E



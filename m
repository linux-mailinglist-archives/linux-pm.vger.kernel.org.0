Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C599325D6D
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 07:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhBZGJD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 01:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhBZGJB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 01:09:01 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A115FC061574;
        Thu, 25 Feb 2021 22:08:21 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id ba1so4766083plb.1;
        Thu, 25 Feb 2021 22:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=veBng1mAuJ4SODrmS5u/GO4AEOA3NFFcdFwKeTiCPqw=;
        b=imS9E6f0cKH37G4/pJBghQJIRfaFYqbPgc/uDk/Cb84/2lxnLPn5gw2sjgnriHfbna
         X1nbzoAqWsh0cz/8TTHSQGqiZyn0qGohBwaTiz5VRAvtRmrA+u+yowDmWCaMBaqoFJ2f
         sEI9ccD0EfkymIWPal+gTh5OAnSMHcaX3vtuNclGsZ5BgwEsqOZmrY89gVabcIReH/pz
         JTX7zUdhh4Yr9xyXnZmmEIWuZ8blyKjWGdbtJVmMbfwiTK+n3QcGU0DSsTeLbuqRux3d
         Zq26A2ppStyhoj9KVxHNQIX/gpddWY4H5UZ7H/Jj76ru+ixrz2wj7UdLcz+1R8PBr4Bg
         4hNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=veBng1mAuJ4SODrmS5u/GO4AEOA3NFFcdFwKeTiCPqw=;
        b=dj7yG3dCTi2FzwPu8xWyzMQUMFQTuH616g1KJw4OS9OcnCoR2PtphI+WobXxqlOBux
         YgBeHaTM5B45dLYfwgDfZS37h++/7r9MqB8Mg+KsfR7DwC73HuQHO8RF1ZQhlH0OdEzj
         0/Czp+f5G0gItI861ucHZnzRflSgrY33qj3bHAbqqX1glxsiTsZn446NT65OsWPfXC9T
         FPDNtgyNk11g/8LPP9U3BDgZu0uToLBUB8qr5OnfhcR2BNYc0Iz+82Vu1/KCPSjvdM5t
         RxpvOGgqI4rd4pgldsLA3QqbyBwVWGuCLTb9ypJom85+M0RrGu4gGYWfjUxYadnLPc/4
         Ai4Q==
X-Gm-Message-State: AOAM530nscukfKDyQQM5re2PZEdE69Jpcujw4tjkqjeAcS7j6pc7qU4S
        r5qkEoNHkEmj/CJrYre+UBragzUvhhwstg==
X-Google-Smtp-Source: ABdhPJzs3SHNsIs9pVK0Q669l1yQaooGtPba2zpx6ofMuc9x3CIEHHfa6ZEbD9hpr/HKDYc40D/xnA==
X-Received: by 2002:a17:902:b598:b029:e2:daa2:161c with SMTP id a24-20020a170902b598b02900e2daa2161cmr1785961pls.20.1614319700667;
        Thu, 25 Feb 2021 22:08:20 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id p26sm8419064pfn.127.2021.02.25.22.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 22:08:20 -0800 (PST)
Subject: Re: [PATCH v2 3/9] devfreq: Use HZ macros
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>
References: <20210224144222.23762-1-daniel.lezcano@linaro.org>
 <20210224144222.23762-3-daniel.lezcano@linaro.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <0db79cd7-f062-b31b-2a6c-ecf8dadaf572@gmail.com>
Date:   Fri, 26 Feb 2021 15:08:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210224144222.23762-3-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 21. 2. 24. 오후 11:42, Daniel Lezcano wrote:
> HZ unit conversion macros are available in units.h, use them and
> remove the duplicate definition.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Christian Eggers <ceggers@arri.de>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>   drivers/devfreq/devfreq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index bf3047896e41..b6d63f02d293 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -26,6 +26,7 @@
>   #include <linux/hrtimer.h>
>   #include <linux/of.h>
>   #include <linux/pm_qos.h>
> +#include <linux/units.h>
>   #include "governor.h"
>   
>   #define CREATE_TRACE_POINTS
> @@ -33,7 +34,6 @@
>   
>   #define IS_SUPPORTED_FLAG(f, name) ((f & DEVFREQ_GOV_FLAG_##name) ? true : false)
>   #define IS_SUPPORTED_ATTR(f, name) ((f & DEVFREQ_GOV_ATTR_##name) ? true : false)
> -#define HZ_PER_KHZ	1000
>   
>   static struct class *devfreq_class;
>   static struct dentry *devfreq_debugfs;
> 

I changed the patch title with 'PM /' prefix as following
in order to keep the consistent patch style if there are no any special 
objection.
- PM / devfreq: Use HZ macros

Applied it.

Thanks,
Chanwoo Choi

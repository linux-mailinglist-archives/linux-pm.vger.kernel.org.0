Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFEDB417C
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2019 22:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732982AbfIPUAu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Sep 2019 16:00:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41923 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391155AbfIPUAu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2019 16:00:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id h7so703638wrw.8
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2019 13:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W9GHG9L+PJe6rz7gjfTPABno1n+l1egsuHFsXnCvjWs=;
        b=oXEEfhEpb9g2ZPMy+bdOQjLcE7Bj7bz6AqhH6VDkGL/1LnzLBoBH/OXTHn2OcaHua0
         oY3EhbyXi0c8eh0AS2yN6VEawcodFGedbl9672fKW3UoJ2n0nzRmfs5wngwTGguw0jxd
         Zlpxd921J2NN8MPoLTwjPeNdoaFcPAp21djY06hqoU3Eq19oI0tESylL1epfghyk5mJN
         y/1Q/bdRAXrRXDsyhkxX1cdWeYkOq3Ul5ofSufkVx78bWPkqqCMkOLjtJ9M/jNdhko9/
         OeRam7qrLbGSuY+iMJ6AMe4YoYoIJrRdnsRyxuVxXLUPgeWb5eVnOkL3SMnsXAcpCkC6
         F3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=W9GHG9L+PJe6rz7gjfTPABno1n+l1egsuHFsXnCvjWs=;
        b=YcUJ0iN/maSR5iMkXTS1OFx9TWf2LW+/B1MytpGAhVpBcFLPAn6EkGUs5pe3tB8cFp
         wO7LNXzDfNooJ4IlRAP4COt5yrmNhEq7mDcyJRJBhkdv/Mqa0hieVOnCyz5UvqWYz3H/
         yA02/yAUUBuU76feE5YhSL4NlQxKnqPmH5d+20epf3YCj4V0A8FVyPwONOu7eLB9AuEg
         v+D3wMuwpALNIizw/QLcFtJyuMyDG//qtySq1PIz1+7nWQfEFvkL/EkVMTa4rl1ey1xd
         Qk8uCU/zB+EWQVVLKNAYuLIjNCa4iLR+eQ7AacsmFnRKvYQWAt2aOz11zj2EGyw7RknQ
         ffbQ==
X-Gm-Message-State: APjAAAUQ98WcwZlnY6GU6w1oRUszr8OzFyrfYeSygqUH8QtWVMLhx3Oa
        Smxvu8j7k+a+EDwMY22K8P4gDvTFOmc=
X-Google-Smtp-Source: APXvYqyVVs9Wfd9LXe773rKxXqu1Qexfn+wvG4JAq1vkFVqMBApoVtX3OOJqkvzG6AP7RgkgbvrGxQ==
X-Received: by 2002:adf:d08b:: with SMTP id y11mr109427wrh.50.1568664045504;
        Mon, 16 Sep 2019 13:00:45 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:95e8:e043:e3b5:5d1f? ([2a01:e34:ed2f:f020:95e8:e043:e3b5:5d1f])
        by smtp.googlemail.com with ESMTPSA id n1sm44784807wrg.67.2019.09.16.13.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 13:00:44 -0700 (PDT)
Subject: Re: [PATCH 1/5] thermal: Initialize thermal subsystem earlier
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        tdas@codeaurora.org, swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
References: <cover.1568240476.git.amit.kucheria@linaro.org>
 <97b6f861e6e6a2ac7b50efb7211f3c8e7fe872b0.1568240476.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6920d231-73cf-d83d-2cc7-f29e5f73192c@linaro.org>
Date:   Mon, 16 Sep 2019 22:00:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <97b6f861e6e6a2ac7b50efb7211f3c8e7fe872b0.1568240476.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/09/2019 00:32, Amit Kucheria wrote:
> From: Lina Iyer <ilina@codeaurora.org>
> 
> Now that the thermal framework is built-in, in order to facilitate
> thermal mitigation as early as possible in the boot cycle, move the
> thermal framework initialization to core_initcall.
> 
> However, netlink initialization happens only as part of subsys_initcall.
> At this time in the boot process, the userspace is not available yet. So
> initialize the netlink events later in fs_initcall.

Why not kill directly the netlink part, no one is using it in the kernel?


> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> [Rebased, refactored and moved to core_initcall]
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 41 ++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 6bab66e84eb5..b13e8a9298cc 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1468,6 +1468,8 @@ static struct genl_family thermal_event_genl_family __ro_after_init = {
>  	.n_mcgrps = ARRAY_SIZE(thermal_event_mcgrps),
>  };
>  
> +static bool allow_netlink_events;
> +
>  int thermal_generate_netlink_event(struct thermal_zone_device *tz,
>  				   enum events event)
>  {
> @@ -1482,6 +1484,9 @@ int thermal_generate_netlink_event(struct thermal_zone_device *tz,
>  	if (!tz)
>  		return -EINVAL;
>  
> +	if (!allow_netlink_events)
> +		return -ENODEV;
> +
>  	/* allocate memory */
>  	size = nla_total_size(sizeof(struct thermal_genl_event)) +
>  	       nla_total_size(0);
> @@ -1533,16 +1538,18 @@ EXPORT_SYMBOL_GPL(thermal_generate_netlink_event);
>  
>  static int __init genetlink_init(void)
>  {
> -	return genl_register_family(&thermal_event_genl_family);
> -}
> +	int ret;
>  
> -static void genetlink_exit(void)
> -{
> -	genl_unregister_family(&thermal_event_genl_family);
> +	ret = genl_register_family(&thermal_event_genl_family);
> +	if (!ret)
> +		allow_netlink_events = true;
> +	return ret;
>  }
> +
>  #else /* !CONFIG_NET */
>  static inline int genetlink_init(void) { return 0; }
> -static inline void genetlink_exit(void) {}
> +static inline int thermal_generate_netlink_event(struct thermal_zone_device *tz,
> +						 enum events event) { return -ENODEV; }
>  #endif /* !CONFIG_NET */
>  
>  static int thermal_pm_notify(struct notifier_block *nb,
> @@ -1591,19 +1598,15 @@ static int __init thermal_init(void)
>  	mutex_init(&poweroff_lock);
>  	result = thermal_register_governors();
>  	if (result)
> -		goto error;
> +		goto init_exit;
>  
>  	result = class_register(&thermal_class);
>  	if (result)
>  		goto unregister_governors;
>  
> -	result = genetlink_init();
> -	if (result)
> -		goto unregister_class;
> -
>  	result = of_parse_thermal_zones();
>  	if (result)
> -		goto exit_netlink;
> +		goto exit_zone_parse;
>  
>  	result = register_pm_notifier(&thermal_pm_nb);
>  	if (result)
> @@ -1612,13 +1615,11 @@ static int __init thermal_init(void)
>  
>  	return 0;
>  
> -exit_netlink:
> -	genetlink_exit();
> -unregister_class:
> +exit_zone_parse:
>  	class_unregister(&thermal_class);
>  unregister_governors:
>  	thermal_unregister_governors();
> -error:
> +init_exit:
>  	ida_destroy(&thermal_tz_ida);
>  	ida_destroy(&thermal_cdev_ida);
>  	mutex_destroy(&thermal_list_lock);
> @@ -1626,4 +1627,10 @@ static int __init thermal_init(void)
>  	mutex_destroy(&poweroff_lock);
>  	return result;
>  }
> -fs_initcall(thermal_init);
> +
> +static int __init thermal_netlink_init(void)
> +{
> +	return genetlink_init();
> +}
> +core_initcall(thermal_init);
> +fs_initcall(thermal_netlink_init);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


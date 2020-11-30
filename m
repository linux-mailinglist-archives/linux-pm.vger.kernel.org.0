Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D489C2C7F6C
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 08:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgK3H6k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 02:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgK3H6i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 02:58:38 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8776CC0613D2
        for <linux-pm@vger.kernel.org>; Sun, 29 Nov 2020 23:57:58 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id e25so4354164wme.0
        for <linux-pm@vger.kernel.org>; Sun, 29 Nov 2020 23:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V0CDXKuLozXjhXcBQBmMbRd7ZZ/O71fg8ffP+P4Shm4=;
        b=LJJsVkD4/qL3CwL+0yuRVvBg2cAb8AkbAIXghbYWrbazovXABi5ROy6IA+QjqmSmen
         WyrgQMABKv0loc8sz90wxLE3WFRaZ+M+Bxt+TrecekfYFsXGYE+fLNCGWvsV6vO/Rfn7
         CB1iS0xR98BBOLCkgw+MGUzoB4Ii9bfhZpsUnKfSL08sPtMQlOswQxGjR+jAkykyf61Q
         w91Fx1Qe7KBoeYkpXQ+e7Fz2XyDuT3Df/6ri4uZ+rhngSkQ2mon6ULnw0EsZ1LdFOYSe
         Yia8bWpN1Ay/oe9v6fjIi2FplY3aJSMqRr4OpXJCgod4ika8/tIewOhu9Z6J5CT3uOp9
         7qDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V0CDXKuLozXjhXcBQBmMbRd7ZZ/O71fg8ffP+P4Shm4=;
        b=rGmBXkI/YYG21I+RrUI7BUrO/veOoLp8C7202L4ZG67XyAYy0iZj/5T72X6sNqOH65
         aculK6FeafMzv06TX/ndw44Am4tOsAUz6fiGxacIMmsqwUiy0/NLdLt4ZVJQ0/sRJMGO
         57/L4EBIKOEHXxRMH8ehshhoO5Rk6vdhqUivOdgQw1FYq2rh/26f0GI5XKP8hlXlZ87L
         j5jFwgrcfRXHpnZF4c9EtO7/EkLNzuv9tWnpJusyCfKXlwIHk1ZAcrKmbbpJEM29sxUQ
         iVt4In50FBT1nnxTqk4gZxHfKop1CxXyDFtsIS/DyA8KPLybtFfJfXp6gRJ2fMADg8yb
         PuCw==
X-Gm-Message-State: AOAM530tibG6qvwl172qKFtGX398Bn1+zU8QHdJYCmsMX2sWGQ/ZUKx7
        jYoot5Y4Vk96U2KCpUG3jxWzkg==
X-Google-Smtp-Source: ABdhPJysnaWKPrsGc5wrxoxN1GbeW452RPruvjezGfpM4trTqIm1yehTdfcSSlrI19JZE0KBGKJsGw==
X-Received: by 2002:a1c:1dd4:: with SMTP id d203mr3904405wmd.118.1606723076938;
        Sun, 29 Nov 2020 23:57:56 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:a9e1:bc04:469:f21b? ([2a01:e34:ed2f:f020:a9e1:bc04:469:f21b])
        by smtp.googlemail.com with ESMTPSA id w15sm26834820wrp.52.2020.11.29.23.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Nov 2020 23:57:56 -0800 (PST)
Subject: Re: [PATCH 1/3] thermal: core: Add indication for userspace usage
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, rui.zhang@intel.com,
        amitk@kernel.org
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <20201128175450.12456-1-kai.heng.feng@canonical.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <004fe225-1009-06d8-b297-c03a4c67550f@linaro.org>
Date:   Mon, 30 Nov 2020 08:57:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201128175450.12456-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


[Added Srinivas]

On 28/11/2020 18:54, Kai-Heng Feng wrote:
> We are seeing thermal shutdown on Intel based mobile workstations, the
> shutdown happens during the first trip handle in
> thermal_zone_device_register():
> kernel: thermal thermal_zone15: critical temperature reached (101 C), shutting down
> 
> However, we shouldn't do a thermal shutdown here, since
> 1) We may want to use a dedicated daemon, Intel's thermald in this case,
> to handle thermal shutdown.
> 
> 2) For ACPI based system, _CRT doesn't mean shutdown unless it's inside
> ThermalZone. ACPI Spec, 11.4.4 _CRT (Critical Temperature):
> "... If this object it present under a device, the device’s driver
> evaluates this object to determine the device’s critical cooling
> temperature trip point. This value may then be used by the device’s
> driver to program an internal device temperature sensor trip point."
> 
> So a "critical trip" here merely means we should take a more aggressive
> cooling method.

Well, actually it is stated before:

"This object, when defined under a thermal zone, returns the critical
temperature at which OSPM must shutdown the system".

That is what does the thermal subsystem, no ?

> So add an indication to let thermal core know it should leave thermal
> device to userspace to handle.

You may want to check the 'HOT' trip point and then use the notification
mechanism to get notified in userspace and take action from there (eg.
offline some CPUs).

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/thermal/thermal_core.c | 3 +++
>  include/linux/thermal.h        | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index c6d74bc1c90b..6561e3767529 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1477,6 +1477,9 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>  			goto unregister;
>  	}
>  
> +	if (tz->tzp && tz->tzp->userspace)
> +		thermal_zone_device_disable(tz);
> +
>  	mutex_lock(&thermal_list_lock);
>  	list_add_tail(&tz->node, &thermal_tz_list);
>  	mutex_unlock(&thermal_list_lock);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index d07ea27e72a9..e8e8fac78fc8 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -247,6 +247,8 @@ struct thermal_zone_params {
>  	 */
>  	bool no_hwmon;
>  
> +	bool userspace;
> +
>  	int num_tbps;	/* Number of tbp entries */
>  	struct thermal_bind_params *tbp;
>  
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

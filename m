Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A62D11579A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 20:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfLFTPs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Dec 2019 14:15:48 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41669 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfLFTPs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Dec 2019 14:15:48 -0500
Received: by mail-pf1-f196.google.com with SMTP id s18so3800852pfd.8
        for <linux-pm@vger.kernel.org>; Fri, 06 Dec 2019 11:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dWXpOimTwenaVBdKiG9dZ3FcmpYa3OZhkX/d4LqtYMY=;
        b=R4THKPT9e2z0+N0yWZKPw/8yGeOLtcWd8zEIwU/WVcengfgiuqzJ7MVVnq2qw+Brji
         +oo22CBINwDdoHamQKCVERZo0y5sc6U8L4nWLEzWFokuaSiy4I0u2RcbAg/twolkUK6m
         +m4dB9uDgCh4IqOxVSOH+FHWpQQu6YwlwB+cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dWXpOimTwenaVBdKiG9dZ3FcmpYa3OZhkX/d4LqtYMY=;
        b=WZ5kyxweGDdXmNxg1H+s7yAYhwDAZwXe0bxGcE5B6UCWCOEVSY8VDs1578TJNDHEbf
         30jnslPjfDMT4U3jMlEYrGa81T0lEF8N9FD6XzXJXFYXbOsJyMi7g4eQ84wXKGdnigYG
         CnuHhSDEraZ0rFOyZlfGcszOKUPwT0biTOlPj7cTI1f7drc8e/NfSla5Q3o/wUz17VTD
         p3D8uw6eSmfj1E/363aqIhiKy/jUAPATE4TWa8z/etWKNlUGFsmPev/pMmP1yj9ZQtQc
         DL9FUGCKRz3eJo8wSrU2Y7mb3sl0eQoGPXhxLxqczpB8QMlgho6ffFYNhFRRRWFx0TUM
         gGrA==
X-Gm-Message-State: APjAAAUqngc3N0yQY9uP1h9e7M5ljsqXid/0JebpgWMOBW3uGU8XJHhL
        25aYpV9PI66UhQdTNOfYiiLhwg==
X-Google-Smtp-Source: APXvYqzIZtCOzPKJBrdfjSYj8H80B6OJE2Mxs7uyZAYFiCkW3Mzbwoiv6KnRBgy2hbm7XIvX1a7Z6g==
X-Received: by 2002:a63:cf41:: with SMTP id b1mr5207454pgj.53.1575659747397;
        Fri, 06 Dec 2019 11:15:47 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id u1sm16718126pfn.133.2019.12.06.11.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 11:15:46 -0800 (PST)
Date:   Fri, 6 Dec 2019 11:15:45 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v3 3/3] thermal: create softlink by name for thermal_zone
 and cooling_device
Message-ID: <20191206191545.GO228856@google.com>
References: <20191205071953.121511-1-wvw@google.com>
 <20191205071953.121511-4-wvw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191205071953.121511-4-wvw@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 04, 2019 at 11:19:53PM -0800, Wei Wang wrote:
> The paths thermal_zone%d and cooling_device%d are not intuitive and the
> numbers are subject to change due to device tree change. This usually
> leads to tree traversal in userspace code.
> The patch creates `tz-by-name' and `cdev-by-name' for thermal zone and
> cooling_device respectively.

This is useful, especially for systems with plenty of thermal zones :)

> Signed-off-by: Wei Wang <wvw@google.com>
> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 9db7f72e70f8..7872bd527f3f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -22,6 +22,7 @@
>  #include <net/netlink.h>
>  #include <net/genetlink.h>
>  #include <linux/suspend.h>
> +#include <linux/kobject.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/thermal.h>
> @@ -46,6 +47,8 @@ static DEFINE_MUTEX(poweroff_lock);
>  
>  static atomic_t in_suspend;
>  static bool power_off_triggered;
> +static struct kobject *cdev_link_kobj;
> +static struct kobject *tz_link_kobj;
>  
>  static struct thermal_governor *def_governor;
>  
> @@ -999,9 +1002,15 @@ __thermal_cooling_device_register(struct device_node *np,
>  		return ERR_PTR(result);
>  	}
>  
> -	/* Add 'this' new cdev to the global cdev list */
> +	/* Add 'this' new cdev to the global cdev list and create link*/
>  	mutex_lock(&thermal_list_lock);
>  	list_add(&cdev->node, &thermal_cdev_list);
> +	if (!cdev_link_kobj)
> +		cdev_link_kobj = kobject_create_and_add("cdev-by-name",
> +						cdev->device.kobj.parent);
> +	if (!cdev_link_kobj || sysfs_create_link(cdev_link_kobj,
> +						&cdev->device.kobj, cdev->type))
> +		dev_err(&cdev->device, "Failed to create cdev-by-name link\n");
>  	mutex_unlock(&thermal_list_lock);
>  
>  	/* Update binding information for 'this' new cdev */
> @@ -1167,6 +1176,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
>  			}
>  		}
>  	}
> +	if (cdev_link_kobj)
> +		sysfs_remove_link(cdev_link_kobj, cdev->type);
>  
>  	mutex_unlock(&thermal_list_lock);
>  
> @@ -1354,6 +1365,12 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>  
>  	mutex_lock(&thermal_list_lock);
>  	list_add_tail(&tz->node, &thermal_tz_list);
> +	if (!tz_link_kobj)
> +		tz_link_kobj = kobject_create_and_add("tz-by-name",
> +						tz->device.kobj.parent);
> +	if (!tz_link_kobj || sysfs_create_link(tz_link_kobj,
> +						&tz->device.kobj, tz->type))
> +		dev_err(&tz->device, "Failed to create tz-by-name link\n");
>  	mutex_unlock(&thermal_list_lock);
>  
>  	/* Bind cooling devices for this zone */
> @@ -1425,6 +1442,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>  			}
>  		}
>  	}
> +	if (tz_link_kobj)
> +		sysfs_remove_link(tz_link_kobj, tz->type);
>  
>  	mutex_unlock(&thermal_list_lock);
>  

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>


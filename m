Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAE112759C
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 07:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfLTGRm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 01:17:42 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43404 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfLTGRm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2019 01:17:42 -0500
Received: by mail-pl1-f196.google.com with SMTP id p27so3639483pli.10
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 22:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y/VwZZiAktPRsPlg7z3TfsUsPtzRVqVqEaZ9WF2lDAQ=;
        b=lI1MJNM4B1B4trhjV7SS/pdjdGPyfxLJeao3OzcO96yVxmp4Z+bvEvAcPjbyWXW2So
         Em5LR6F8omNNfqdbXFtkXsNYo58SXEm0AyrncaqFMf+1IuC+w6zbrs9OXxHHki7U6gFQ
         cwZ5yiPJC8kXR5+rdR3sZ/hrXoCPyhL6YcY2kDyqrDg0fK8aXm0sdidvOr5FK/WCpBbD
         QyHt3JKK3ASDgpZ+qQtYxuvnx9IaIVmUcjAFIx1Ve5TquoFi2t5Oecwye0g4zx3kwoY4
         bwkh6CvhnF3nntciS5j+FCgLxAgmLj4RO8AwmVL31FI7cVWdmDwx+r8zrRqF7e7Vi1yW
         iZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y/VwZZiAktPRsPlg7z3TfsUsPtzRVqVqEaZ9WF2lDAQ=;
        b=Qv3aB9+f3DGmHD701wx3kCpKYN5J9+FLSCaiQjUhHKV9b19Dq9qPdRNzoC0TuR+SEf
         s66NO5C2MX4UBkNdnMNZFsDS5YMX0POmppXDzGt3jmqULqvsri3jrZL6sKLeXYwJ6tMm
         mMrySl2mddWdHrZoe6svjmtlvViGWHB/pLUEx2ERHSrAkGXK8POWuZk79exCsFPbwHAx
         h4ucg6v7+dnez9I9qKAysIkje5fhLRsYEXZPI7YJ1oJ98AqWByIoECz12zO59nWvz8Mc
         Ds0zAoCY17u3ikrReGP4kf1xDgYhNzEMCrNZKS1YbWP+AjEKS+rAtpi3LKqiR/O7NyzF
         ayWw==
X-Gm-Message-State: APjAAAUyiDEJByEZnLAhZIgQKZ2hgJ2EzDUI5IEiGtbFADA7EN4XCFPN
        NGErUY+5sEE8Hjfun9p+kaying==
X-Google-Smtp-Source: APXvYqypqw/ur4GeHFoIAL5efmFJPOtc8xI8QfLi9ehafysp8Pe46O9YOZWxgdZCEdwJm4Y4rS+6CA==
X-Received: by 2002:a17:902:b68c:: with SMTP id c12mr13212978pls.126.1576822661504;
        Thu, 19 Dec 2019 22:17:41 -0800 (PST)
Received: from localhost ([122.171.234.168])
        by smtp.gmail.com with ESMTPSA id w66sm11240696pfw.102.2019.12.19.22.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 22:17:40 -0800 (PST)
Date:   Fri, 20 Dec 2019 11:47:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] thermal/drivers/cpu_cooling: Fix an IS_ERR() vs NULL bug
Message-ID: <20191220061738.jf6iiaddnaqtrqqs@vireshk-i7>
References: <20191220053750.4wcxgieqmceyhwo5@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220053750.4wcxgieqmceyhwo5@kili.mountain>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-12-19, 08:40, Dan Carpenter wrote:
> The idle_inject_register() function returns NULL on error, it never
> returns error pointers.
> 
> Fixes: 1e044f70e5c2 ("thermal/drivers/cpu_cooling: Introduce the cpu idle cooling driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/thermal/cpuidle_cooling.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
> index 6d778acefeec..ab48387ce868 100644
> --- a/drivers/thermal/cpuidle_cooling.c
> +++ b/drivers/thermal/cpuidle_cooling.c
> @@ -187,8 +187,8 @@ __init cpuidle_of_cooling_register(struct device_node *np,
>  	}
>  
>  	ii_dev = idle_inject_register(drv->cpumask);
> -	if (IS_ERR(ii_dev)) {
> -		ret = PTR_ERR(ii_dev);
> +	if (!ii_dev) {
> +		ret = -ENOMEM;
>  		goto out_id;
>  	}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

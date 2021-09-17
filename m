Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5779240F39B
	for <lists+linux-pm@lfdr.de>; Fri, 17 Sep 2021 09:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241682AbhIQH4P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Sep 2021 03:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240424AbhIQH4P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Sep 2021 03:56:15 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446F9C061574
        for <linux-pm@vger.kernel.org>; Fri, 17 Sep 2021 00:54:53 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id b21-20020a1c8015000000b003049690d882so9237441wmd.5
        for <linux-pm@vger.kernel.org>; Fri, 17 Sep 2021 00:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LP/nR2wrSCDTCNFg6NRQ+EsjmJhvj+ejZsNPI94Lo9E=;
        b=Pxsn4BdQMlfN5op/yr08+NUcafKAMtWcx0LeeIEtVudrFtfyoTa0RqzD23barfiq+T
         lhRA9VIzR/cdUp2udK+kRijIP0IyIXPS4kwLbfzPgMzVd63GHiLkhR6EScoOVt4T0siQ
         4qLPjsL9s9Hz+YACnWYuutdrsHYvtzfGSGjtvoBo9zOFRt7Ue+YeQOBBQm95L3T5gN8q
         9dwz9R/vFR7p7y3lKUZYswjYhFaJopB9CT/Td84F5Ul5KagDO2qc3E440Rf2GqyPN+71
         eTDGH4yRckXmatk8Qqm/a8W85KdLw5GCLB0B/C/vTyeuVU2IVB+edbRkeYxOJRDMFH7C
         +KOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LP/nR2wrSCDTCNFg6NRQ+EsjmJhvj+ejZsNPI94Lo9E=;
        b=ADqS+eFsO9kYIVULZH3yEGVr5NXTq36N6vhbM7h8d45bLGe740i5hDHa5Trnv6PI0+
         IfHhuC/Tr7bQ0OwNqtagWdw7Dj2HB12v4wf8vd0tNEwTIxridcny8a8oTCs8/vRiU6tL
         hvGgFyOc5+9HFcrBBrDc5OQB/AM8Tplz0/EzMB8XJTnoOEs/AxkwEitgGPIYmvfw1oo2
         Aa3VZ0MSxDJOuJv/KKlzBlYL6JsJ+Qvyov3AeCzWI6ORGpPaPbN6sSVZHzL7gD0xJhwV
         Q7yezdzqhmbqBtlHw6G9fD1eCcG+6zVhmz4/FzCIMVj5QvUzfreDHLpijRKHiy1xdDMJ
         bVKg==
X-Gm-Message-State: AOAM530zjAv5u0I8g8iSEsM108jef0d57TbbPCz51C36wQz49U7hIkyp
        VKmZzVdrn7blXn82U7a0SHYUZg==
X-Google-Smtp-Source: ABdhPJysPGOo/lvaX7O5c4g+Qnf2gaXGYWBFGRJJmdxCuurYabTrg8AO+dbdXZldwLJpeA0sOs11Yw==
X-Received: by 2002:a7b:c40f:: with SMTP id k15mr13452952wmi.127.1631865291737;
        Fri, 17 Sep 2021 00:54:51 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:cf95:6508:8470:7171? ([2a01:e34:ed2f:f020:cf95:6508:8470:7171])
        by smtp.googlemail.com with ESMTPSA id b204sm7622009wmb.3.2021.09.17.00.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 00:54:51 -0700 (PDT)
Subject: Re: [PATCH] thermal/core: Potential buffer overflow in
 thermal_build_list_of_policies()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20210916131342.GB25094@kili>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <819b1be3-851a-e5ac-95f4-53a94a5dd457@linaro.org>
Date:   Fri, 17 Sep 2021 09:54:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210916131342.GB25094@kili>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/09/2021 15:13, Dan Carpenter wrote:
> After printing the list of thermal governors, then this function prints
> a newline character.  The problem is that "size" has not been updated
> after printing the last governor.  This means that it can write one
> character (the NUL terminator) beyond the end of the buffer.
> 
> Get rid of the "size" variable and just use "PAGE_SIZE - count" directly.
> 
> Fixes: 1b4f48494eb2 ("thermal: core: group functions related to governor handling")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---

Applied, thanks


>  drivers/thermal/thermal_core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 97ef9b040b84..51374f4e1cca 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -222,15 +222,14 @@ int thermal_build_list_of_policies(char *buf)
>  {
>  	struct thermal_governor *pos;
>  	ssize_t count = 0;
> -	ssize_t size = PAGE_SIZE;
>  
>  	mutex_lock(&thermal_governor_lock);
>  
>  	list_for_each_entry(pos, &thermal_governor_list, governor_list) {
> -		size = PAGE_SIZE - count;
> -		count += scnprintf(buf + count, size, "%s ", pos->name);
> +		count += scnprintf(buf + count, PAGE_SIZE - count, "%s ",
> +				   pos->name);
>  	}
> -	count += scnprintf(buf + count, size, "\n");
> +	count += scnprintf(buf + count, PAGE_SIZE - count, "\n");
>  
>  	mutex_unlock(&thermal_governor_lock);
>  
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

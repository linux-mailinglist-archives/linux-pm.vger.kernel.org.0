Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7624245F71E
	for <lists+linux-pm@lfdr.de>; Sat, 27 Nov 2021 00:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343730AbhKZXQJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 18:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbhKZXOI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 18:14:08 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBDBC061574
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 15:10:55 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t9so4696019wrx.7
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 15:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I1bnnvK5wCwVjL86xgRIW2/MDvYRm/MnqOfx6UDxmrQ=;
        b=T6ef6UAKkY19Ifq8AqrjGV1EeKLhBcdgOYCwUD/WVnctdIWJ9OzISCRt9Yh4dbDNxq
         0UsDkHzbxTz92F69HS3HuNzkcoQ4wC8hRDcXRzVmuHqDdReNOkx282gr/ZJjoUQsOK8n
         8bShUZIDd9JI31oc1TPhZI1GjHCWnf0Dpav0GqL6ISC2VqDo4oMLqK1916iNlNbUFOdv
         +pC8qka5h97zojyqm7AzYsgWfm/o1+eSUTnD7qkX0J02v1/CQMgH1LvZmAW0kLxfeJy1
         7bCxsRcaBIMQ0lyV76k6/gn8NVjNDwpNJt58XUJEGtB9nTynov0s+u3o5PLBB/y3nDcL
         YAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I1bnnvK5wCwVjL86xgRIW2/MDvYRm/MnqOfx6UDxmrQ=;
        b=RliQ+oQs9WAl5l5tfNP4kW+ngTaGNAZdQ21KSen2cRGnuZXRYQNOEIHFkuHegh9KTS
         i7xhdnBs/6QFu+E1xpoxWxwt8e3RI1bqDGQTU7Edoolnf9Y8V48gbuodKwh7OqOWZGwm
         9rUj4IU4nEnleKrVUNVzngLGYqkanKM2ik7SKYq6RTcy9VyE2Ngs90RsHyKeG2inDcpC
         uNX1r+hk6e5+q+mauR3t3YpclbaGbHYEFfc8WN5pnvehPPW0OPNaGV/Wj+9X23mcT76c
         pzYAxsKaYf5BLsAIN/yY2+pR3N63fWyOAMgIW+a9H9HpK2r1g4CPsUriYq/4eTJ6N/y+
         J9qw==
X-Gm-Message-State: AOAM531Y/5mFZS4oB6G4FzRR7KnNSIo0HaPakPjTxyKFvQHV8u9a7WBk
        KESwtXf6pW/lGPT391PO6BWoEQ==
X-Google-Smtp-Source: ABdhPJwQ3wg2Max5sdq9qjeBJdpZmbw5Z5OWoDy+xKtNjGlOKVmlIZ+lIwohIj9U+snxnQdyIYUyoA==
X-Received: by 2002:adf:fc90:: with SMTP id g16mr16905199wrr.53.1637968253574;
        Fri, 26 Nov 2021 15:10:53 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:70b:e5b5:f868:20cf? ([2a01:e34:ed2f:f020:70b:e5b5:f868:20cf])
        by smtp.googlemail.com with ESMTPSA id p5sm7054872wrd.13.2021.11.26.15.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 15:10:52 -0800 (PST)
Subject: Re: [PATCH] powercap/drivers/dtpm: Disable dtpm at boot time
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     dsmythies@telus.net, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, gregkh@linuxfoundation.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>
References: <9821f60a-c562-12e8-bdd4-45dbfe88a117@linaro.org>
 <20211126230820.3441863-1-daniel.lezcano@linaro.org>
Message-ID: <9e81f795-6d3a-2078-5ef1-13b965e89a2a@linaro.org>
Date:   Sat, 27 Nov 2021 00:10:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211126230820.3441863-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Doug,

I was unable to reproduce the issue because I don't have an x86 platform.

Is it possible to check if this fix is ok?

  -- Daniel

On 27/11/2021 00:08, Daniel Lezcano wrote:
> The DTPM framework misses a mechanism to set it up. That is currently
> under review but will come after the next cycle.
> 
> As the distro are enabling all the kernel options, the DTPM framework
> is enabled on platforms where the energy model is not implemented,
> thus making the framework inconsistent and disrupting the CPU
> frequency scaling service.
> 
> Remove the initialization at boot time as a hot fix.
> 
> Fixes: 7a89d7eacf8e ("powercap/drivers/dtpm: Simplify the dtpm table")
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/powercap/dtpm.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> index b9fac786246a..fb35c5828bfb 100644
> --- a/drivers/powercap/dtpm.c
> +++ b/drivers/powercap/dtpm.c
> @@ -471,9 +471,6 @@ static int __init init_dtpm(void)
>  		return PTR_ERR(pct);
>  	}
>  
> -	for_each_dtpm_table(dtpm_descr)
> -		dtpm_descr->init();
> -
>  	return 0;
>  }
>  late_initcall(init_dtpm);
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

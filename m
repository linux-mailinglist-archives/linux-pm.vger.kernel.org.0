Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACA12382F7
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 05:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfFGDFv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 23:05:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33655 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfFGDFv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jun 2019 23:05:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id g21so254416plq.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Jun 2019 20:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H7CLFdoBPP7l3IEmTINBabW4dT5YeAQBXDwoCOrfxvs=;
        b=gWJqJqZ/rTPWluupY1DKV0rs4A0c12jlcS2mQCrIgvFlvE4DLaYkH0Mpnaqh6CFTRk
         hQ5vDNYBgxu2Mp6ixcG6H+sfcV7pgJI89ga9Gbii2TFfvWvN+kSVqR8IFnA4xblRNN+V
         0xrL9CLXQNm4N0vSzsdojo6s2BbCNoo2nC9Qm/Sp8qDo2UT6U0XjkalIqnBqaKhVTJKl
         dmriwLNb/yJj5YShFvsJRqGETxyylTOFYNIUf1j8iq1dTvBPYyPDDgWTXhKqsDIXuYCU
         ouPHkzdk4erPChcVHtkKctfxV+MGw/a0OJUQNxgrPH+6eRUHzmcT1c11gypDlW1AXZqb
         kSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H7CLFdoBPP7l3IEmTINBabW4dT5YeAQBXDwoCOrfxvs=;
        b=lil9Kel7t5j/MhMLlbaR6ggJCCCjHenCr1Nr9Nn8VGBSk1LNHJy5E0sX4rxtbu9tEu
         ZbaUY9/aUJqByjpvLAwi2XHTaBEnte3qQNglKvook2s3PvbfJYtMZzz1Hh+CmoHk98aK
         6DWv5egICf9oAZLWk27rtwDU25hEkraha+PlUgBGYuFvULnmTF0JU1qI1VCZZyajocxT
         2LkZrv6iBi2gn2JHyCzfGtpoRwd6tBfnsONsaMs1a4XJnoaYNeDL8kDWr/lClEL6tZwz
         hTvkJjQtlF2u4HnOYZ51B8NxMpot7jmhMi6ksZRh0dnE6uOLOIUer9UfhParPp6UsAqp
         uZ7g==
X-Gm-Message-State: APjAAAWVPMHj7zXUG9zcrhwhk6GZgPu3kMdKEAVftqGNNjzHgSpnmb6P
        HfcLKpMBA8XIIMo2+DBIoA1NXA==
X-Google-Smtp-Source: APXvYqzOsQK1uUlnEwMVs04oCLLIhbjE1dCIGxyd7z/1Wp6i3/lBhIk8qFnzdWcwXwlca7/ZPbULGQ==
X-Received: by 2002:a17:902:2ae6:: with SMTP id j93mr54928338plb.130.1559876750555;
        Thu, 06 Jun 2019 20:05:50 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id n184sm529337pfn.21.2019.06.06.20.05.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 20:05:48 -0700 (PDT)
Date:   Fri, 7 Jun 2019 08:35:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     David Arcari <darcari@redhat.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: pcc-cpufreq: Fail initialization if driver
 cannot be registered
Message-ID: <20190607030546.7kjg466wbkzxfym4@vireshk-i7>
References: <20190606185052.71959-1-darcari@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606185052.71959-1-darcari@redhat.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-06-19, 14:50, David Arcari wrote:
> Make pcc_cpufreq_init() return error codes when the driver cannot be
> registered.  Otherwise the driver can shows up loaded via lsmod even
> though it failed initialization.  This is confusing to the user.
> 
> Signed-off-by: David Arcari <darcari@redhat.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/pcc-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
> index 1e5e64643c3a..fdc767fdbe6a 100644
> --- a/drivers/cpufreq/pcc-cpufreq.c
> +++ b/drivers/cpufreq/pcc-cpufreq.c
> @@ -582,10 +582,10 @@ static int __init pcc_cpufreq_init(void)
>  
>  	/* Skip initialization if another cpufreq driver is there. */
>  	if (cpufreq_get_current_driver())
> -		return 0;
> +		return -EEXIST;
>  
>  	if (acpi_disabled)
> -		return 0;
> +		return -ENODEV;
>  
>  	ret = pcc_cpufreq_probe();
>  	if (ret) {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

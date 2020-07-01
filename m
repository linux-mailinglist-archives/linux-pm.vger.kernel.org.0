Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE47E210320
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 06:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgGAEwc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 00:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGAEwb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 00:52:31 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4389FC03E979
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2020 21:52:31 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l6so7370418pjq.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2020 21:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7eYb9sQ67BQ+n6ANY+Ph2Puop3csMsMIF7Sv6LdAfmE=;
        b=Ew3NrNwW4KiwmImm6a47YMFZgv/8YcShRwIFUCg1sbr33opr6FVq7cshuzjy9Dn1xX
         mg1hGWAzWcdAUA5vIejnimpTrOM+92CsytLaVIbisFUVYe6vWk4JzoYM5FcnNv4VHmOq
         IR3lea0LZIywRrHdCG/i/FBZYv6jZjuSQI5XhNezS1ao71anKq3pnUm+STn0ygZNyNlY
         JbM1ArJqM7QtjVxlj6NyS41jRmmXsd2aa683vEtUcDPHu2XRrxMatf7R3ej1GHPbw4Es
         LG9jH4Hqna7PY4gHCTPaNIR6/DXD7eZbHFE9siIfQnoiulUo3LuGs1w7JQntNgWGGH++
         shQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7eYb9sQ67BQ+n6ANY+Ph2Puop3csMsMIF7Sv6LdAfmE=;
        b=sd29/A4ilX/SrNScU+omNaaWvWeawRWYo1Fo+/uEIOpg2IbgUE1PkVbLrryr3Vqrit
         hTBuzEof8NfNCm89qTJVgg8dZ/Hu8M+nDQ2IGKkUz1m4crhTIwFbjbhKP4FK3CJ+BHTv
         8KLcIFids24OahD7AsiImE/YY6j1uw1ycM2Sn3JjkR4rF7dgv50i9gJwvHJmPPS08ocl
         FAaQjsu/R6cAKawz/bdYe+0DP8FJvIalKW/VU+x/uv0slDkGYU6zObyO07zS3w+HOSWS
         sgzoIK/mqZnkZEJTXrdFjzMpecTMTIyM/vBCiXzMfk5ruiW0m7cv76NfjTETeStdZmN1
         wN6A==
X-Gm-Message-State: AOAM532mH8XHKx43BQYT35ept/Vzg3JXFmd2Xrk6Hew/n2f7t7C/bEv/
        AmZjnqQbC9zqhgoiOpXyh3EW2A==
X-Google-Smtp-Source: ABdhPJw7WLjPrEgQDUgRPosBAR1pD2cN4A1I9ovdVdigC3+ZESc7even4HQ3ZZRxdBZjC1XmipWoOg==
X-Received: by 2002:a17:90a:898a:: with SMTP id v10mr24899274pjn.95.1593579150490;
        Tue, 30 Jun 2020 21:52:30 -0700 (PDT)
Received: from localhost ([122.172.127.76])
        by smtp.gmail.com with ESMTPSA id h9sm3499383pjs.50.2020.06.30.21.52.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2020 21:52:29 -0700 (PDT)
Date:   Wed, 1 Jul 2020 10:22:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3]  cpufreq: CPPC: simply the code access 'highest_perf'
 value in cppc_perf_caps struct
Message-ID: <20200701045227.epojzjwuky5kkdzj@vireshk-i7>
References: <20200701042007.13333-1-xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701042007.13333-1-xhao@linux.alibaba.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-07-20, 12:20, Xin Hao wrote:
>  The 'caps' variable has been defined, so there is no need to get
>  'highest_perf' value through 'cpu->caps.highest_perf', you can use
>  'caps->highest_perf' instead.
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 257d726a4456..051d0e56c67a 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -161,7 +161,7 @@ static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu,
>  		if (!max_khz)
>  			max_khz = cppc_get_dmi_max_khz();
>  		mul = max_khz;
> -		div = cpu->perf_caps.highest_perf;
> +		div = caps->highest_perf;
>  	}
>  	return (u64)perf * mul / div;
>  }
> @@ -184,7 +184,7 @@ static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu,
>  	} else {
>  		if (!max_khz)
>  			max_khz = cppc_get_dmi_max_khz();
> -		mul = cpu->perf_caps.highest_perf;
> +		mul = caps->highest_perf;
>  		div = max_khz;
>  	}

Applied. Thanks.

-- 
viresh

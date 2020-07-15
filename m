Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EC1220284
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 04:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgGOCwz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 22:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgGOCwz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 22:52:55 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F339C08C5C1
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 19:52:53 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b9so1233041plx.6
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 19:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0glwH8EcqSXFTX4S1OVt6no4ymJBSG2idjiGE4hkLiM=;
        b=fNlgkfmDwYPu+1TiJmpDeFF7yvT0rvgUsFCO2nrvBJaQERLj46VXGKvjkn30DcvkQx
         zv2oZ4Tn09R9NJe9ZBdZXwZBwzH3GOIUYa8BpGzc6ce9ukSog16/HMFN2UseUIs6V3lA
         jjDePlp2R50dpqk6z08fu2ddB3kYIAjl3tnVaEiTudbKk4ilWGqHvC4JDmZTlHzZhMYG
         /YfaLq9Zom+2U+6CZgKLQl+T598KbR/cG3WDcXYudSy3hQJiKILRH5MgMksYh5rzQ+Be
         cqW32qVqKgrBPU4LvKh2fbjg0enYvkU0AB5/NJQPnxLlkSq40vK4wZSAgNe6uCcLoYnv
         EaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0glwH8EcqSXFTX4S1OVt6no4ymJBSG2idjiGE4hkLiM=;
        b=B4TiybVVf51Jrg8uNxaXKgNCRmtZarAgyv2aHDiOLFl+SAK+h36+LfiCDnGzYjzL9z
         /SOhPEW0qTp2TcZl0juIuXrnePy5pDgNnoFG6lihtNRFZckSzCsk0qVuW59fUwGa0ta+
         MNY/N8H30W5AhOPMKcezPy6ItKj68SUYo/TcpKmPqZ9/g9X6LgbNC7wBs7AR14P6aKTZ
         QH1RDNHWy8D5l6GfTCFJwIzQ1MN+pTCiyHtKuAT2Lh2KwNsvZxqPnO4VsE21Fq2geu9V
         HSAd9d1tpKsDA20iGaLatfyQjDl90RLYZdzQQG7xVhYIqfKfvNGZuriWbX/XMCZMO2zq
         y+lw==
X-Gm-Message-State: AOAM530in83BvvPyr2yIdWHkAmZ2h3PROSdHCg7Hd2hJJXQq0oZeWT1W
        3tDGOUztAnsmS5wxjQelattMIQ==
X-Google-Smtp-Source: ABdhPJywnJogb+vLoV2wTh6Hylf/9jv+Y4yT1XFZa3VwwHYObsWDA0rKozjggr2ARVQoMr/+ykEg3Q==
X-Received: by 2002:a17:902:7790:: with SMTP id o16mr5915781pll.299.1594781572913;
        Tue, 14 Jul 2020 19:52:52 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id r9sm360441pje.12.2020.07.14.19.52.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 19:52:52 -0700 (PDT)
Date:   Wed, 15 Jul 2020 08:22:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Alexander Clouter <alex@digriz.org.uk>
Subject: Re: [PATCH 03/13] cpufreq: cpufreq_governor: Demote
 store_sampling_rate() header to standard comment block
Message-ID: <20200715025249.ukoqup4piqiz5lim@vireshk-i7>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-4-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714145049.2496163-4-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14-07-20, 15:50, Lee Jones wrote:
> There is no need for this to be denoted as kerneldoc.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/cpufreq/cpufreq_governor.c:46: warning: Function parameter or member 'attr_set' not described in 'store_sampling_rate'
>  drivers/cpufreq/cpufreq_governor.c:46: warning: Function parameter or member 'buf' not described in 'store_sampling_rate'
>  drivers/cpufreq/cpufreq_governor.c:46: warning: Function parameter or member 'count' not described in 'store_sampling_rate'
> 
> Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> Cc: Jun Nakajima <jun.nakajima@intel.com>
> Cc: Alexander Clouter <alex@digriz.org.uk>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index f99ae45efaea7..63f7c219062b9 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -26,7 +26,7 @@ static DEFINE_PER_CPU(struct cpu_dbs_info, cpu_dbs);
>  static DEFINE_MUTEX(gov_dbs_data_mutex);
>  
>  /* Common sysfs tunables */
> -/**
> +/*

This is an important routine with good documentation details already
there, though internal to governors and so I would rather keep it.

>   * store_sampling_rate - update sampling rate effective immediately if needed.
>   *
>   * If new rate is smaller than the old, simply updating
> -- 
> 2.25.1

-- 
viresh

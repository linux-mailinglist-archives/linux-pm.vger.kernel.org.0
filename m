Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE2F389C40
	for <lists+linux-pm@lfdr.de>; Thu, 20 May 2021 05:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhETEAZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 May 2021 00:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhETEAZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 May 2021 00:00:25 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63EDC061574
        for <linux-pm@vger.kernel.org>; Wed, 19 May 2021 20:59:03 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k5so8427692pjj.1
        for <linux-pm@vger.kernel.org>; Wed, 19 May 2021 20:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5DmWgtEYdg1BAX4a133sojX2RWqI9f92J1In5aRH3J8=;
        b=iip6VP1d4MIfMedHTbkAptHJxqrSUnAIqGC7dGRCcrjrQbELrYHIkDluAkK0MQ5cEr
         zRPLkqHFZOLSGVoszfPe67PrUStgZmwxxWOHVNZmgo51kUXAYNSnjQ4BomzZh69gclI5
         bZa1Rk/WkUhtMliRyFxtH+KIGlO8iRoVUc3STrBVAGHTu88l5WadziY3a4feqg3p5zZp
         GMTZwnKqO6Asrc3LCLB3EVQ379KWWGBxna0uiXV1qUfOHV/wMkBivJJC0SgkDcg4jhC/
         zNJ3UA1nrqyWbUCtwrDSEkDp1hmOEdjrU1iXJQenDrC0PB7DbTmVRhmGQxh/TFrWpqzd
         tijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5DmWgtEYdg1BAX4a133sojX2RWqI9f92J1In5aRH3J8=;
        b=prbqUHXB1d0N0og6YlwtTvDEEFJ9sGBmWBKiBD7BpirY+NWRtNsGA4E0vP31rktDpV
         8tePOPEB7bOWWlPrYnqWyoKcZZQCS0oU3XYcC21WPNcrHmVHgW79y3KzOQcEV8Pe3grc
         e5a5Z5DSsvoDUQv2hXXT0ShS9616dxSRIL4B5giZqHuNoyrxPRAzrXxtPNLn/fm0PPg7
         OSh5bBuG3hvaK0xSHMt6gn4a3apzvfWaQHc8Pz7KA/B7cpxUlv6Zvb4PfTNeUgfk0tSO
         UFwaD/rQ/u1GPOiGexX9O8QD+F5YpKknnNZU7rxoJ6m6yGxM3vzrXe9vL5KvQ5izc4XD
         SMBA==
X-Gm-Message-State: AOAM532HHf9x9DFBCnyH0I9uWDvgwJNpKNRlgd3t1E3dtfmxcQ+8M/ut
        xqXkW7yQ6U1/cE/vRUsl54GSsA==
X-Google-Smtp-Source: ABdhPJxDTwiOE6aXEMN09zlHVIX7YBPQdiLP9p/7O69S1nDvlDo4fbGKFAaHpPR1dF1D6nwZjtiGMA==
X-Received: by 2002:a17:90a:1588:: with SMTP id m8mr3008221pja.226.1621483143208;
        Wed, 19 May 2021 20:59:03 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id l20sm731069pjq.38.2021.05.19.20.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 20:59:02 -0700 (PDT)
Date:   Thu, 20 May 2021 09:29:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com, rjw@rjwysocki.net,
        nicola.mazzucato@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cpufreq: scmi: Fix an error message
Message-ID: <20210520035900.5agxp6r6lwpdvl5i@vireshk-i7>
References: <b0c09698216af60d97bfd30b55bad89dc0f70112.1620328067.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0c09698216af60d97bfd30b55bad89dc0f70112.1620328067.git.christophe.jaillet@wanadoo.fr>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-05-21, 21:09, Christophe JAILLET wrote:
> 'ret' is known to be 0 here.
> The last error code is stored in 'nr_opp', so use it in the error message.
> 
> Fixes: 71a37cd6a59d ("scmi-cpufreq: Remove deferred probe")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index c8a4364ad3c2..ec9a87ca2dbb 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -174,7 +174,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>  		nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
>  		if (nr_opp <= 0) {
>  			dev_err(cpu_dev, "%s: No OPPs for this device: %d\n",
> -				__func__, ret);
> +				__func__, nr_opp);
>  
>  			ret = -ENODEV;
>  			goto out_free_opp;

Applied. Thanks.

-- 
viresh

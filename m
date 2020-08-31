Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C40A257853
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 13:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgHaLZu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 07:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgHaLXp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 07:23:45 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52738C0619C8
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2020 04:13:11 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id l9so1236871plt.8
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2020 04:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KBBTUkezzasRfES9/9EFu0N3ZGXxTAErhJcD1zpfrbA=;
        b=GsmnUgWtwwl1EZoPQ4DCbK466aPwzSlmhmKvN0mD52viXD8KxKAI/keY70XEMr1HcO
         COqxrD0yB4v629b7Qrs4yGnswb+yhDBHZyOjP2HcjhM1s0t0qxcibjtzcU3IeAb2uWmW
         daBJSnHB1kfKB0tdb6bLczbDczyMIgM2+r0y+Nqp80/5ckQBI8oqS/07QAWm7B7g2IZz
         y3mojYq4Cz96l9Jl9jt4AB6KtBjCMIJ2GNgpBs3qLQKIcnMGnpleHs8J1pT8ntJ6Djo5
         CTXTrCQ99P3j7IbSg9dvj0E/WftKhwbPooFRW9TUsS8hyftkN1hh9OQjjyYj2D/Nj9Uk
         Y33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KBBTUkezzasRfES9/9EFu0N3ZGXxTAErhJcD1zpfrbA=;
        b=H6K9WPbqVBJUByj8iWOeMMtz+VENaNVZfPzqdVlzJXizYeBDOTHKwDzSflgNwhfoS3
         QNbvrbEsRiiW7QvtE7eAGfjaCwRbSqBH7zxIdy1XKdHmszTIiwvzT26F6PP1TX5B/HoR
         +2VFQYU8EsgOK9U+vyy40BkpNiM2IeYAkCPHC4M6JAu3fadK6ryc+ZgTkYqwCjqWNDUS
         furX5fqJYMgtnBgBvxX3zKU3omCE48HM//neIXQrFTcqPmUTXy4QML0bP+wX9sMhfZP3
         baKvgQ6gsBew+1cDOmuGQYjNH8at+qMQw1idWxB7uyMlWytzx/ihUJln/CZkgitIc0w9
         4LNQ==
X-Gm-Message-State: AOAM53042kXYiQszeUqjQWP816LZJfd+HMtgW2MiZc/VxRa5LreYQjjO
        ZoqmuwME4UmPFWmkANhY13FqNg==
X-Google-Smtp-Source: ABdhPJyNSHB4RYWFClLY78FTQU/D4RuTSKf/1CKsSSYRHXVGC764/n0yGVm5touXPWXJWqZK7xqlsQ==
X-Received: by 2002:a17:90a:9418:: with SMTP id r24mr915488pjo.69.1598872390858;
        Mon, 31 Aug 2020 04:13:10 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id r123sm4166687pfc.187.2020.08.31.04.13.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 04:13:10 -0700 (PDT)
Date:   Mon, 31 Aug 2020 16:43:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] arch_topology: validate input frequencies to
 arch_set_freq_scale()
Message-ID: <20200831111308.h5j652dnpgys2doe@vireshk-i7>
References: <20200828173303.11939-1-ionela.voinescu@arm.com>
 <20200828173303.11939-2-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828173303.11939-2-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-08-20, 18:32, Ionela Voinescu wrote:
> The current frequency passed to arch_set_freq_scale() could end up
> being 0, signaling an error in setting a new frequency. Also, if the
> maximum frequency in 0, this will result in a division by 0 error.
> 
> Therefore, validate these input values before using them for the
> setting of the frequency scale factor.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> ---
>  drivers/base/arch_topology.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 75f72d684294..5708eb724790 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -33,6 +33,11 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
>  	unsigned long scale;
>  	int i;
>  
> +	if (unlikely(!cur_freq || !max_freq)) {
> +		WARN_ON_ONCE(1);
> +		return;
> +	}

This can be written as:

        if (WARN_ON_ONCE(!cur_freq || !max_freq))
                return;

With that.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

> +
>  	/*
>  	 * If the use of counters for FIE is enabled, just return as we don't
>  	 * want to update the scale factor with information from CPUFREQ.
> -- 
> 2.17.1

-- 
viresh

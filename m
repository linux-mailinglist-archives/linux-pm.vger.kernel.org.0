Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959BF2D0B4A
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 08:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgLGHrF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 02:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgLGHrF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 02:47:05 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F6EC0613D4
        for <linux-pm@vger.kernel.org>; Sun,  6 Dec 2020 23:46:19 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t37so8204038pga.7
        for <linux-pm@vger.kernel.org>; Sun, 06 Dec 2020 23:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=siy5k+plcJtXdcMZn6ACu9NpjqM7plnkiw05pK5XU78=;
        b=SDUXu+D0A6hVVfD7s9o8DA/1jQ8Bu8P0p8WJ72Zd8IiPT4Jbd36OkBflzx5nis97e7
         2m+YWrHHdHGVquqwdMRyTXd5AnglaWoSG0eV6tKGxXmzW+a5GwSp7V71wKEwMpJOXHMs
         TIOd0RDwkoVEhMq8PpWQpru6n3UIkct5T95tfzH9yX5AlilLX5Q5Fx5MqoygwCmEwLvB
         FPmFW57vMqXXyrDjZkgJPNRCzYytAvf4cuT/08hU54TWqXSt04STB3EFnpu7qH4X5L1s
         G7pSSFaShvs7GSinDFoY7GMzwoeBgorkdGaPSWmuVKDxcuLpMDcuMN7lNi8DUwG9w8ev
         AFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=siy5k+plcJtXdcMZn6ACu9NpjqM7plnkiw05pK5XU78=;
        b=BD5Ixv6RfN+YtU2uM38kn9WMn+TtESqiSqvEzEhaiPze4/R9XZyjtUVM21eflmf1Xp
         TVRs4HtoRUCFmSIuf1HZhUzr/wAEqCT1AVXAKHxlQ+oQMNn8idc7/gFuv36NeZ+bkWPy
         v0VKrGwg5yngS/KVEaFMdXK67+jND2zItZ5AgMQ6qKJI5X3r+iMTSkHbyGyUOG4iZ1mE
         GAVM8ITG40NKaLsH+92eiA0C+CSG2oOgcKHOhlz142RTKJwC40lL/rKurZ+XKtbbmr5u
         HA3RMbsH+mNnHtiGyFKADKjDAHvZtlDQ54QVl73dxlmfF8IlRDghRbL5wMvSoP4u3o9C
         cWMg==
X-Gm-Message-State: AOAM5322mvEwTC5o6c38sWqL9DtOoZBWd4+jb7EgUh6CjNC3wSuQ1ZiB
        kHsvI36F5SZrEBvSu4oD42ZGBQ==
X-Google-Smtp-Source: ABdhPJz5sQW7nMiLfe5VnS5PY25vhc4Gn/3VRv6D4H965tRx0eW+S7+5lm9b9onKp9q38melEzDkUg==
X-Received: by 2002:a63:c843:: with SMTP id l3mr17438532pgi.202.1607327178597;
        Sun, 06 Dec 2020 23:46:18 -0800 (PST)
Received: from localhost ([122.172.136.109])
        by smtp.gmail.com with ESMTPSA id c184sm521086pfb.11.2020.12.06.23.46.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 23:46:17 -0800 (PST)
Date:   Mon, 7 Dec 2020 13:16:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Subject: Re: [RFC][PATCH 1/2] cpufreq: Add special-purpose fast-switching
 callback for drivers
Message-ID: <20201207074615.kmvy5afoolhv5cgq@vireshk-i7>
References: <1817571.2o5Kk4Ohv2@kreacher>
 <2174134.tL5yAn4CWt@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2174134.tL5yAn4CWt@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-11-20, 19:37, Rafael J. Wysocki wrote:
> Index: linux-pm/include/linux/cpufreq.h
> ===================================================================
> --- linux-pm.orig/include/linux/cpufreq.h
> +++ linux-pm/include/linux/cpufreq.h
> @@ -320,6 +320,15 @@ struct cpufreq_driver {
>  					unsigned int index);
>  	unsigned int	(*fast_switch)(struct cpufreq_policy *policy,
>  				       unsigned int target_freq);
> +	/*
> +	 * ->fast_switch() replacement for drivers that use an internal
> +	 * representation of performance levels and can pass hints other than
> +	 * the target performance level to the hardware.
> +	 */
> +	void		(*adjust_perf)(unsigned int cpu, bool busy,

Maybe this should still take policy as an argument (like other calls)
instead of CPU, even if it is going to be used for single-cpu per
policy case for now.

> +				       unsigned long min_perf,
> +				       unsigned long target_perf,
> +				       unsigned long capacity);

-- 
viresh

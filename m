Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5EE92ACB36
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 03:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbgKJCld (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 21:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730066AbgKJClb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 21:41:31 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFB4C0613D3
        for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2020 18:41:29 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id h6so8866268pgk.4
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2020 18:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WCOY4IMrlHpe9VU35gF/zByAnrSLbBEzV7qQu2kBJd4=;
        b=Lxn/uhOBDwxB83RBFnsrqtlFnW8KbcVFAhrlo9WKhTF4Sz2XTBcjv+xruokz1nKSUy
         A+2QWxXhhSLiMp19Civc3VZy3sfm8KHGlPaSGa+6+LDgNO8rysirWdgZstnsg1SBQo25
         MWk10hJ998bf7gSKgxG9FgmbqsM+xCVH4XVY4ftdG8EAoXZutNwuqct1O2jVtt49g5Op
         ynnEKVB9sEGGazuHz6UzmGTqwT3wezsKNuAfYY3yCB2VdcN9XGrp3BBdnEdjddnHGi2G
         JfWpOXIKcvfs2v37vgoYTLg/HUZ0pQM60fiWzHQPezsc64CnNXHRCEAcrYC4kQS65Gd2
         A7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WCOY4IMrlHpe9VU35gF/zByAnrSLbBEzV7qQu2kBJd4=;
        b=Ezb/oiC+zmNtfABR4hzxM6x+Z4xQ/HsImHU61KD54ry0SdErCK1T+gY3nH3Yf2GP2R
         W8cXFJuZj3xn6haoNkA9Y3o2GU1mYZBtLbyVI7+e9XD6BsDwnQBiAUTKl7a6sec9DPsA
         ECYwNkfFqR04H/RKCHXvl4fj6CoYFOY/DX80BfxbZysL62FbmNUOdj2iE+EBsABsBDKr
         fXZAJqRC88WCra+v9asAhl6som2MkxWx2dtc97GuAGM7dKJfAlCWlUqIOH3z4RNn9+8b
         suMY7tkskyYeaMylSG3mu8HoF4xz414HdIikwjxGwTh2bENLIrJX+N8K909YhelFLJA+
         26hQ==
X-Gm-Message-State: AOAM532gbK/fFLikqpmKGlt4L7p7Vuv0qI2fD3XVU/L72MPK65hnKRYR
        14PiYNIJW3YGcoASXEAEJXTxFQ==
X-Google-Smtp-Source: ABdhPJwhYtOsJXeV0/ou8PbpvaNkFfROJ+N4JJ2Gdt/Jt7Y68WXn6m32bIjMNzk/cSYTrZ/nGz9lQQ==
X-Received: by 2002:a65:50c8:: with SMTP id s8mr8683055pgp.197.1604976089181;
        Mon, 09 Nov 2020 18:41:29 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id z22sm903214pje.16.2020.11.09.18.41.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 18:41:28 -0800 (PST)
Date:   Tue, 10 Nov 2020 08:11:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: Re: [PATCH v2 1/4] cpufreq: Introduce governor flags
Message-ID: <20201110024126.v4yxai5hpguj5p5b@vireshk-i7>
References: <13269660.K2JYd4sGFX@kreacher>
 <1876249.M1ZxxmeKtZ@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1876249.M1ZxxmeKtZ@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-11-20, 17:51, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> A new cpufreq governor flag will be added subsequently, so replace
> the bool dynamic_switching fleid in struct cpufreq_governor with a
> flags field and introduce CPUFREQ_GOV_FLAG_DYN_SWITCH to set for
> the "dynamic switching" governors instead of it.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c          |    2 +-
>  drivers/cpufreq/cpufreq_governor.h |    2 +-
>  include/linux/cpufreq.h            |    9 +++++++--
>  kernel/sched/cpufreq_schedutil.c   |    2 +-
>  4 files changed, 10 insertions(+), 5 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -2254,7 +2254,7 @@ static int cpufreq_init_governor(struct
>  		return -EINVAL;
>  
>  	/* Platform doesn't want dynamic frequency switching ? */
> -	if (policy->governor->dynamic_switching &&

I completely forgot that we had something like this :)

> +	if (policy->governor->flags & CPUFREQ_GOV_FLAG_DYN_SWITCH &&
>  	    cpufreq_driver->flags & CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING) {
>  		struct cpufreq_governor *gov = cpufreq_fallback_governor();
>  
> Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
> +++ linux-pm/drivers/cpufreq/cpufreq_governor.h
> @@ -156,7 +156,7 @@ void cpufreq_dbs_governor_limits(struct
>  #define CPUFREQ_DBS_GOVERNOR_INITIALIZER(_name_)			\
>  	{								\
>  		.name = _name_,						\
> -		.dynamic_switching = true,				\
> +		.flags = CPUFREQ_GOV_FLAG_DYN_SWITCH,			\
>  		.owner = THIS_MODULE,					\
>  		.init = cpufreq_dbs_governor_init,			\
>  		.exit = cpufreq_dbs_governor_exit,			\
> Index: linux-pm/include/linux/cpufreq.h
> ===================================================================
> --- linux-pm.orig/include/linux/cpufreq.h
> +++ linux-pm/include/linux/cpufreq.h
> @@ -565,12 +565,17 @@ struct cpufreq_governor {
>  					 char *buf);
>  	int	(*store_setspeed)	(struct cpufreq_policy *policy,
>  					 unsigned int freq);
> -	/* For governors which change frequency dynamically by themselves */
> -	bool			dynamic_switching;
>  	struct list_head	governor_list;
>  	struct module		*owner;
> +	u8			flags;
>  };
>  
> +/* Governor flags */
> +
> +/* For governors which change frequency dynamically by themselves */
> +#define CPUFREQ_GOV_FLAG_DYN_SWITCH	BIT(0)

Maybe just drop the FLAG_ part as we don't use it for other cpufreq related
flags as well. That will also give us space to write DYN as DYNAMIC (it may be
better as we use the full name in CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING).

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

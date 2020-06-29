Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4EF520CBA5
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 04:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgF2CIr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Jun 2020 22:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgF2CIr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Jun 2020 22:08:47 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E71C03E97A
        for <linux-pm@vger.kernel.org>; Sun, 28 Jun 2020 19:08:46 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e9so7583810pgo.9
        for <linux-pm@vger.kernel.org>; Sun, 28 Jun 2020 19:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MDDCd788rUw0MGM5PSVbNuNM46LDcKL26lH89OKNmYM=;
        b=nwr4GodQACkoeCYNSjdFKRwPAB+Fle2aLkM8RYCYFPfRpUHdvsoeIQiT5dVzcIKhTc
         6BVmu4pm5vMFbEissipgoM3M4RLPnBKCfgCPz4TlAXLIu6TSUf1wgsYUvE0+EvR+ZoaA
         F7Vo2Gu7sJ+4kcceSp7Zin0BdBnu9KOYZTxe6sdxXfwnz6YNq4H0FcaBl5xXQ+FvKpkd
         lXQkkgdLLwD5ce0O+bt4FOQEIjV/3Bj6PdQyjpzesJsbdC9/XXgM5iJG7Nh3DNZsfNzs
         wG5b4xsn8vGFqKlIXEO2QOYZY3kgovpv6NO96SJw6MKr8CKvMxgC3r8SuCyFgbl0bgRb
         xOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MDDCd788rUw0MGM5PSVbNuNM46LDcKL26lH89OKNmYM=;
        b=RnWlueMjmJ4yiiBN/Pi0whhwknGwxgX0mlc11HuYbOfDV/pb9B2GLdSCg7/eJ4KoF/
         fCqzuouEZusVAz4to8FNXTPQI9agab1eXW0cSyAqdUNIHf0n+cGC4UzBLag/DhWiIVy2
         6rCX/DD7dtNI162iPqhovtdyYCn+upnDikuSukXowwk9XPV4GvCGt1YkKwb8CMo0fcmj
         H/h5ySTbAuAPR8JHOInZLWZ9FCHs/7tIWfkRmyBT0XQCsCJtuacFoY4V84aIK4Y/JW0J
         8CjlKS31mY89MYixYBAZdbQMiThsGi6z23++G88SeYuPuc9vG2iR33qgQvPNXEHdq2tT
         razw==
X-Gm-Message-State: AOAM532+lKLPonK7e2DMeLf5D3kVKsif2QUCu+CrRv6e29yKZxsG6YSY
        B8r/pRlOM5CUw7wIWx6RU4IrUw==
X-Google-Smtp-Source: ABdhPJxGGdi2rkcapX678iYFI17fmIJe3uE1LOCpZM7Mv2TGYUWZYnq3VSzXCH7Y/9TNa72WRe8pTg==
X-Received: by 2002:a62:1a87:: with SMTP id a129mr12441612pfa.95.1593396525893;
        Sun, 28 Jun 2020 19:08:45 -0700 (PDT)
Received: from localhost ([122.172.127.76])
        by smtp.gmail.com with ESMTPSA id u12sm16708879pjy.37.2020.06.28.19.08.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jun 2020 19:08:45 -0700 (PDT)
Date:   Mon, 29 Jun 2020 07:38:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 3/3] cpufreq: Specify default governor on command line
Message-ID: <20200629020843.erntkwfprgi5ugqu@vireshk-i7>
References: <cover.1593143118.git.viresh.kumar@linaro.org>
 <7eb38608b2b32c0c72dfb160c51206ec42e74e35.1593143118.git.viresh.kumar@linaro.org>
 <20200626155750.GA540785@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626155750.GA540785@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-06-20, 16:57, Quentin Perret wrote:
> On Friday 26 Jun 2020 at 09:21:44 (+0530), Viresh Kumar wrote:
> > index e798a1193bdf..93c6399c1a42 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -50,6 +50,9 @@ static LIST_HEAD(cpufreq_governor_list);
> >  #define for_each_governor(__governor)				\
> >  	list_for_each_entry(__governor, &cpufreq_governor_list, governor_list)
> >  
> > +static char cpufreq_param_governor[CPUFREQ_NAME_LEN];
> > +static char default_governor[CPUFREQ_NAME_LEN];
> > +
> >  /**
> >   * The "cpufreq driver" - the arch- or hardware-dependent low
> >   * level driver of CPUFreq support, and its spinlock. This lock
> > @@ -1061,7 +1064,6 @@ __weak struct cpufreq_governor *cpufreq_default_governor(void)
> >  
> >  static int cpufreq_init_policy(struct cpufreq_policy *policy)
> >  {
> > -	struct cpufreq_governor *def_gov = cpufreq_default_governor();
> >  	struct cpufreq_governor *gov = NULL;
> >  	unsigned int pol = CPUFREQ_POLICY_UNKNOWN;
> >  	bool put_governor = false;
> > @@ -1071,22 +1073,29 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
> >  		/* Update policy governor to the one used before hotplug. */
> >  		gov = get_governor(policy->last_governor);
> >  		if (gov) {
> > -			put_governor = true;
> >  			pr_debug("Restoring governor %s for cpu %d\n",
> > -				 policy->governor->name, policy->cpu);
> > -		} else if (def_gov) {
> > -			gov = def_gov;
> > +				 gov->name, policy->cpu);
> >  		} else {
> > -			return -ENODATA;
> > +			gov = get_governor(default_governor);
> > +		}
> > +
> > +		if (gov) {
> > +			put_governor = true;
> > +		} else {
> > +			gov = cpufreq_default_governor();
> > +			if (!gov)
> > +				return -ENODATA;
> >  		}
> 
> As mentioned on patch 01, doing put_module() below if gov != NULL would
> avoid this dance with put_governor, but this works too, so no strong
> opinion.

I did it this way because the code looks buggy otherwise, even though
it isn't as put_module() handles it just fine. And so I would like to
keep it this way, unless there are two votes against mine :)

> > +
> >  	} else {
> > +
> >  		/* Use the default policy if there is no last_policy. */
> >  		if (policy->last_policy) {
> >  			pol = policy->last_policy;
> > -		} else if (def_gov) {
> > -			pol = cpufreq_parse_policy(def_gov->name);
> > +		} else {
> > +			pol = cpufreq_parse_policy(default_governor);
> >  			/*
> > -			 * In case the default governor is neiter "performance"
> > +			 * In case the default governor is neither "performance"
> >  			 * nor "powersave", fall back to the initial policy
> >  			 * value set by the driver.
> >  			 */
> > @@ -2796,13 +2805,22 @@ EXPORT_SYMBOL_GPL(cpufreq_unregister_driver);
> >  
> >  static int __init cpufreq_core_init(void)
> >  {
> > +	struct cpufreq_governor *gov = cpufreq_default_governor();
> > +	char *name = gov->name;
> > +
> >  	if (cpufreq_disabled())
> >  		return -ENODEV;
> >  
> >  	cpufreq_global_kobject = kobject_create_and_add("cpufreq", &cpu_subsys.dev_root->kobj);
> >  	BUG_ON(!cpufreq_global_kobject);
> >  
> > +	if (strlen(cpufreq_param_governor))
> > +		name = cpufreq_param_governor;
> > +
> > +	strncpy(default_governor, name, CPUFREQ_NAME_LEN);
> 
> Do we need both cpufreq_param_governor and default_governor?
> Could we move everything to only one of them? Something a little bit
> like that maybe?

No because we want to fallback to the default governor when the
governor shown by the cpufreq_param_governor is valid but missing.

> Also, one thing to keep in mind with this version (or the one you
> suggested) is that if the command line parameter is not valid, we will
> not fallback on the builtin default for the ->setpolicy() case. But I
> suppose one might argue this is a reasonable behaviour, so no objection
> from me.

Right, I did that on purpose.

> Otherwise, apart from these nits, I gave this a go on my setup, with
> builtin and modular governors & drivers, and everything worked exactly
> as expected.

Thanks for testing it out Quentin.

-- 
viresh

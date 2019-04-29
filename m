Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80967DBFE
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 08:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfD2Gfm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 02:35:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35984 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfD2Gfl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 02:35:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id v80so226744pfa.3
        for <linux-pm@vger.kernel.org>; Sun, 28 Apr 2019 23:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+vkHVdjAvn3P7cquxmWBstCw2+EbflFUpipYDFngWe0=;
        b=l1nzf8rBA7g3aJpYL9nhxw4ANySfH9trkB67VWGvE6L7nayrTX1MZughwWG3DhXkzH
         MWSRq3HyQIzNC0fUb116kaODhJx0dlkrjkeMRPi7Onrh/Svu20pQkXYOEuzNnvChoSde
         oeu5MelBRHA+au6i0+KlPc49glxCR5TnXDRZ1WjbJTJBEgQmTvpCQD+5TyWYXER4rGbd
         3sPo6o0Tv+Kuv5zW75EZ/4DbCziNj1A/tP6WKaLI6A8MP2zpbAmAU6qmzArmluQOzPQQ
         1pViQSf4cvxo+a9nc9vn0O9/fod60jwlxBdQeOPhZJqVJ9Z6jMdl2zzPkE1/u1Dn/f+v
         I6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+vkHVdjAvn3P7cquxmWBstCw2+EbflFUpipYDFngWe0=;
        b=DYbkZ7KRMPYbkgWhItNpS76o8NCoG85M89GeGW91zs1PYDC4BB5HBxhbpQZBpkcvqq
         6BuwDJkgmJE6rVMf1oH5jiR2R4EkHZu4QxBPkwud3eevaduKQWNsmqd+eLLODQJlLy8g
         Y2AfzH/R+Eq3sL9L7XOHN/seEUJJkc7i6GvPZ5r/XoqlvekmSJ7jx9rNeWDvs5f36ifO
         L1ZJlQdztddCg+NhLv8rGOSb0s+iZO9sjxAN0xlAeQzqEuUxAHwa1Ope3mpecftRW33N
         YZ3Mm/xpULY2Ck4mUf/PxDcb8TR5muL5s0itCmYZWX2K75q+iRBwXVAN42VvxLfU7YvN
         +tQQ==
X-Gm-Message-State: APjAAAWTgqKw1/N8CHNpa32skPIJK/f0yPsZCTM6uVY1i4B8UdxlGR8j
        7ASVzibPjekWWDaG3MZP200=
X-Google-Smtp-Source: APXvYqxWxbbyVFR/k77cOzf7mTrdds5rKtcOy22DSUq4u36zzuI/gRhEkPhuO9CsNHqVKGenrv1M1A==
X-Received: by 2002:a62:4351:: with SMTP id q78mr59895996pfa.86.1556519741029;
        Sun, 28 Apr 2019 23:35:41 -0700 (PDT)
Received: from localhost ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id 6sm45464769pfp.143.2019.04.28.23.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 23:35:40 -0700 (PDT)
Date:   Mon, 29 Apr 2019 14:35:28 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, rafael.j.wysocki@intel.com,
        linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: Re: [PATCH v2] cpufreq: Don't find governor for setpolicy drivers
 in cpufreq_init_policy()
Message-ID: <20190429143528.00002ae4.zbestahu@gmail.com>
In-Reply-To: <20190429051507.cabsr62rhc5evka5@vireshk-i7>
References: <20190426063135.5200-1-zbestahu@gmail.com>
        <20190429051507.cabsr62rhc5evka5@vireshk-i7>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 29 Apr 2019 10:45:07 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 26-04-19, 14:31, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > In cpufreq_init_policy() we will check if there's last_governor for target
> > and setpolicy type. However last_governor is set only if has_target() is
> > true in cpufreq_offline(). That means find last_governor for setpolicy
> > type is pointless. Also new_policy.governor will not be used if ->setpolicy
> > callback is set in cpufreq_set_policy().
> > 
> > Moreover, there's duplicate ->setpolicy check in using default policy path.
> > Let's add a new helper function to avoid it. Also fix a little comment.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> > v2: fix ->setplicy typo.
> > 
> >  drivers/cpufreq/cpufreq.c | 66 ++++++++++++++++++++++++++++-------------------
> >  1 file changed, 40 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 0322cce..b822a3e 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -578,6 +578,20 @@ static struct cpufreq_governor *find_governor(const char *str_governor)
> >  	return NULL;
> >  }
> >  
> > +static int cpufreq_parse_static_governor(char *str_governor,
> > +					struct cpufreq_policy *policy)
> > +{
> > +	if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
> > +		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
> > +		return 0;
> > +	}
> > +	if (!strncasecmp(str_governor, "powersave", CPUFREQ_NAME_LEN)) {
> > +		policy->policy = CPUFREQ_POLICY_POWERSAVE;
> > +		return 0;
> > +	}
> > +	return -EINVAL;
> > +}
> > +
> >  /**
> >   * cpufreq_parse_governor - parse a governor string
> >   */
> > @@ -585,15 +599,7 @@ static int cpufreq_parse_governor(char *str_governor,
> >  				  struct cpufreq_policy *policy)
> >  {  
> 
> There were only two callers of cpufreq_parse_governor() and one of them you have
> removed already.
> 
> >  	if (cpufreq_driver->setpolicy) {
> > -		if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
> > -			policy->policy = CPUFREQ_POLICY_PERFORMANCE;
> > -			return 0;
> > -		}
> > -
> > -		if (!strncasecmp(str_governor, "powersave", CPUFREQ_NAME_LEN)) {
> > -			policy->policy = CPUFREQ_POLICY_POWERSAVE;
> > -			return 0;
> > -		}
> > +		return cpufreq_parse_static_governor(str_governor, policy);  
> 
> So I will rather remove above completely from here and let
> cpufreq_parse_governor() governor only handle !set_policy.

So, also need update store_scaling_governor() as below if doing that above, right?

        if (cpufreq_driver->setpolicy) {
                if (cpufreq_parse_static_governor(str_governor, &new_policy))
                        return -EINVAL;
        } else {
                if (cpufreq_parse_governor(str_governor, &new_policy))
                        return -EINVAL;
        } 

Moreover, change cpufreq_parse_static_governor() to cpufreq_parse_generic_policy()
should be better?

> 
> >  	} else {
> >  		struct cpufreq_governor *t;
> >  
> > @@ -1020,32 +1026,40 @@ __weak struct cpufreq_governor *cpufreq_default_governor(void)
> >  
> >  static int cpufreq_init_policy(struct cpufreq_policy *policy)
> >  {
> > -	struct cpufreq_governor *gov = NULL;
> > +	struct cpufreq_governor *gov = NULL, *def_gov = NULL;
> >  	struct cpufreq_policy new_policy;
> >  
> >  	memcpy(&new_policy, policy, sizeof(*policy));
> >  
> > -	/* Update governor of new_policy to the governor used before hotplug */
> > -	gov = find_governor(policy->last_governor);
> > -	if (gov) {
> > -		pr_debug("Restoring governor %s for cpu %d\n",
> > +	def_gov = cpufreq_default_governor();
> > +
> > +	if (has_target()) {
> > +		/*
> > +		 * Update governor of new_policy to the governor used before
> > +		 * hotplug
> > +		 */
> > +		gov = find_governor(policy->last_governor);
> > +		if (gov)  
> 
> You must use {} here in the if block as well for two reasons:
> - Below pr_debug is across multiple lines
> - And else part already uses {}
>

Ok, fix it in v3.
 
> > +			pr_debug("Restoring governor %s for cpu %d\n",
> >  				policy->governor->name, policy->cpu);
> > +		else {
> > +			if (!def_gov)
> > +				return -ENODATA;
> > +			gov = def_gov;
> > +		}
> > +		new_policy.governor = gov;
> >  	} else {
> > -		gov = cpufreq_default_governor();
> > -		if (!gov)
> > -			return -ENODATA;
> > -	}
> > -
> > -	new_policy.governor = gov;
> > -
> > -	/* Use the default policy if there is no last_policy. */
> > -	if (cpufreq_driver->setpolicy) {
> > +		/* Use the default policy if there is no last_policy. */
> >  		if (policy->last_policy)
> >  			new_policy.policy = policy->last_policy;
> > -		else
> > -			cpufreq_parse_governor(gov->name, &new_policy);
> > +		else {
> > +			if (!def_gov)
> > +				return -ENODATA;
> > +			cpufreq_parse_static_governor(def_gov->name,
> > +						      &new_policy);
> > +		}
> >  	}
> > -	/* set default policy */
> > +	/* Set new policy */  
> 
> Just drop the comment and make it a blank line.

Ok, fix it in v3.

> 
> >  	return cpufreq_set_policy(policy, &new_policy);
> >  }
> >  
> > -- 
> > 1.9.1  
> 


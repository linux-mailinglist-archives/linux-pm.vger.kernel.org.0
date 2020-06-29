Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A419120CBB0
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 04:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgF2CNN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Jun 2020 22:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgF2CNN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Jun 2020 22:13:13 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC1EC03E97A
        for <linux-pm@vger.kernel.org>; Sun, 28 Jun 2020 19:13:13 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l63so7578542pge.12
        for <linux-pm@vger.kernel.org>; Sun, 28 Jun 2020 19:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4aOh6K38CeMQY1FtFBf/NMwzq86hurcT+zKRKgSbL7A=;
        b=Q6BfHYVpPfL1FFh2ZfrB7Wj1GXHUnk2hK67waJ7nTZqs2xoOEg4R5u6ZE66hvI3ChB
         9y/t13POZWLw0DnXw4kYqydS8unJHBtO/L+HW0LD/1/LOQ6Ya0VAm6APQepzIDcDDvIf
         E8i4sPuHCNuxh9GNK+XMStirw3I0RKPAQ+lv/lGNTFX34UokdgXKiUHE5dUWK8FAsJkY
         r97VaXscL6/YVJTSADWwanhoiTs3Ug2w6CP0cmv29ZRT+MRkVZhcNqsINUqi9QIUlN2q
         5aSwH7Q9op/JauN8yxZE4nNowAYzp5AmeUaf1Zzq4UJkqiYZu6KH1V83v1XIRoG7OjwA
         lsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4aOh6K38CeMQY1FtFBf/NMwzq86hurcT+zKRKgSbL7A=;
        b=K9ZMrt0YSOhxi1HURbQ7pB7CUub7RjdXVZgNsLRKPKJcU656nq3x8iVziJBDqtB4nt
         Kiyk+pwoZ5E15XY7gTf4/1UYKFxKgyp85bqu5HeQZoWqPwOLtwryN64I3Gy3YdTdTnaP
         KsCu+0EzRHxH3u6onD17IdfhcjTPNvJTozRvXTIMdtx+DaOtAA9wT0I+D8p6kGsvXHsC
         seGviT2KDfhDCN2KjGPpnmhB7mSL5+tNHIInp6UE8sjIAZeUC53MaRSerJLF/fK+wb7S
         VufPUK7LGJ1fQzG4ZG/69bhOrSXx0NuzmX3hLH5WWvOkMKxNor6OmuHpMTbj3nsIK/jX
         VidA==
X-Gm-Message-State: AOAM531/WxOHHZQjcOCLFP/+WmCt9Z1osRO/0lFfkSjAw/YWDQKnKI1T
        f1RyJNTewOZSMmMk0j0Ei9Wl7w==
X-Google-Smtp-Source: ABdhPJwvLKD/7lHYEZrVUBEFJx/PRrsLgZ3K2dgI1NYRw7IiiY17jYW0ch4koUrL9on3EpTZRqtayQ==
X-Received: by 2002:a05:6a00:78b:: with SMTP id g11mr11934621pfu.86.1593396792494;
        Sun, 28 Jun 2020 19:13:12 -0700 (PDT)
Received: from localhost ([122.172.127.76])
        by smtp.gmail.com with ESMTPSA id g4sm19166499pgn.64.2020.06.28.19.13.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jun 2020 19:13:11 -0700 (PDT)
Date:   Mon, 29 Jun 2020 07:43:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/3] cpufreq: Fix locking issues with governors
Message-ID: <20200629021309.eleyysuh5f5g52qw@vireshk-i7>
References: <cover.1593143118.git.viresh.kumar@linaro.org>
 <f366ed3dd3dd111e42173b366fe4dd5a0e4647fd.1593143118.git.viresh.kumar@linaro.org>
 <20200626082433.GA284605@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626082433.GA284605@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-06-20, 09:24, Quentin Perret wrote:
> On Friday 26 Jun 2020 at 09:21:42 (+0530), Viresh Kumar wrote:
> > The locking around governors handling isn't adequate currently. The list
> > of governors should never be traversed without locking in place. Also we
> > must make sure the governor isn't removed while it is still referenced
> > by code.
> > 
> > Reported-by: Quentin Perret <qperret@google.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq.c | 59 ++++++++++++++++++++++++---------------
> >  1 file changed, 36 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 0128de3603df..e798a1193bdf 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -621,6 +621,24 @@ static struct cpufreq_governor *find_governor(const char *str_governor)
> >  	return NULL;
> >  }
> >  
> > +static struct cpufreq_governor *get_governor(const char *str_governor)
> > +{
> > +	struct cpufreq_governor *t;
> > +
> > +	mutex_lock(&cpufreq_governor_mutex);
> > +	t = find_governor(str_governor);
> > +	if (!t)
> > +		goto unlock;
> > +
> > +	if (!try_module_get(t->owner))
> > +		t = NULL;
> > +
> > +unlock:
> > +	mutex_unlock(&cpufreq_governor_mutex);
> > +
> > +	return t;
> > +}
> > +
> >  static unsigned int cpufreq_parse_policy(char *str_governor)
> >  {
> >  	if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN))
> > @@ -640,28 +658,14 @@ static struct cpufreq_governor *cpufreq_parse_governor(char *str_governor)
> >  {
> >  	struct cpufreq_governor *t;
> >  
> > -	mutex_lock(&cpufreq_governor_mutex);
> > -
> > -	t = find_governor(str_governor);
> > -	if (!t) {
> > -		int ret;
> > -
> > -		mutex_unlock(&cpufreq_governor_mutex);
> > -
> > -		ret = request_module("cpufreq_%s", str_governor);
> > -		if (ret)
> > -			return NULL;
> > -
> > -		mutex_lock(&cpufreq_governor_mutex);
> > +	t = get_governor(str_governor);
> > +	if (t)
> > +		return t;
> >  
> > -		t = find_governor(str_governor);
> > -	}
> > -	if (t && !try_module_get(t->owner))
> > -		t = NULL;
> > -
> > -	mutex_unlock(&cpufreq_governor_mutex);
> > +	if (request_module("cpufreq_%s", str_governor))
> > +		return NULL;
> >  
> > -	return t;
> > +	return get_governor(str_governor);
> >  }
> >  
> >  /**
> > @@ -815,12 +819,14 @@ static ssize_t show_scaling_available_governors(struct cpufreq_policy *policy,
> >  		goto out;
> >  	}
> >  
> > +	mutex_lock(&cpufreq_governor_mutex);
> >  	for_each_governor(t) {
> >  		if (i >= (ssize_t) ((PAGE_SIZE / sizeof(char))
> >  		    - (CPUFREQ_NAME_LEN + 2)))
> > -			goto out;
> > +			break;
> >  		i += scnprintf(&buf[i], CPUFREQ_NAME_PLEN, "%s ", t->name);
> >  	}
> > +	mutex_unlock(&cpufreq_governor_mutex);
> >  out:
> >  	i += sprintf(&buf[i], "\n");
> >  	return i;
> > @@ -1058,11 +1064,14 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
> >  	struct cpufreq_governor *def_gov = cpufreq_default_governor();
> >  	struct cpufreq_governor *gov = NULL;
> >  	unsigned int pol = CPUFREQ_POLICY_UNKNOWN;
> > +	bool put_governor = false;
> > +	int ret;
> >  
> >  	if (has_target()) {
> >  		/* Update policy governor to the one used before hotplug. */
> > -		gov = find_governor(policy->last_governor);
> > +		gov = get_governor(policy->last_governor);
> >  		if (gov) {
> > +			put_governor = true;
> >  			pr_debug("Restoring governor %s for cpu %d\n",
> >  				 policy->governor->name, policy->cpu);
> >  		} else if (def_gov) {
> > @@ -1089,7 +1098,11 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
> >  			return -ENODATA;
> >  	}
> >  
> > -	return cpufreq_set_policy(policy, gov, pol);
> > +	ret = cpufreq_set_policy(policy, gov, pol);
> > +	if (put_governor)
> > +		module_put(gov->owner);
> 
> Nit: I think you could safely do
> 
> 	if (gov)
> 		module_put(gov->owner);
> 
> and get rid of 'put_governor', given that try_module_get() and
> module_put() are nops if owner is NULL (which is guaranteed for
> the result of cpufreq_default_governor() as it is builtin).

I described why I chose to keep it that way in the other email, but I
am all for dropping the variable. And so what about this ?

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e798a1193bdf..d9e9ae7051bb 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1064,18 +1064,17 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
        struct cpufreq_governor *def_gov = cpufreq_default_governor();
        struct cpufreq_governor *gov = NULL;
        unsigned int pol = CPUFREQ_POLICY_UNKNOWN;
-       bool put_governor = false;
        int ret;
 
        if (has_target()) {
                /* Update policy governor to the one used before hotplug. */
                gov = get_governor(policy->last_governor);
                if (gov) {
-                       put_governor = true;
                        pr_debug("Restoring governor %s for cpu %d\n",
                                 policy->governor->name, policy->cpu);
                } else if (def_gov) {
                        gov = def_gov;
+                       module_get(gov->owner);
                } else {
                        return -ENODATA;
                }
@@ -1099,7 +1098,7 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
        }
 
        ret = cpufreq_set_policy(policy, gov, pol);
-       if (put_governor)
+       if (gov)
                module_put(gov->owner);
 
        return ret;

-- 
viresh

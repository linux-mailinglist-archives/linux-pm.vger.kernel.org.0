Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43F820B573
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 17:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgFZP54 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jun 2020 11:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbgFZP54 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2020 11:57:56 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F56C03E97B
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2020 08:57:55 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so9841298wml.3
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2020 08:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SLVYA+KPlPsy9yYgUjFYIqSkRv4wawTtFWm+qvVkpo4=;
        b=m8J34OgFfXzLvgc2if7QNbh2n9WDF0es4wCI5PdUUYAIWFt1H+DMIQ8TdH8szFYi3Z
         OhziB1Ey6NE4hEfulz5iFal5p5A7Sc7x4SAP5aUJbDfLwn7RhY/7b74L1JLOy9xEXkTB
         HT/ARs/NhMlaXXLdlepTcS1Gr9xCxFnc4KaqGrzKtcw+JFtafDJfyB7nAjQb/sdTQIse
         wd/v6QR7DlZnmNvj8bTL8Rpiwzjx+JuSGn53xTDo7qJbeUpH9kUdnkq39ODpH8H+B1RS
         qOj1vVvu/dzbZXcNvxmIT7D5cQgP8LO1E4K+NcP4IscV6XuNXT9oimRBsqC9SxdlHjxG
         +SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SLVYA+KPlPsy9yYgUjFYIqSkRv4wawTtFWm+qvVkpo4=;
        b=Hq9VUVNj0rWgSAt1nmO4BZuuGe+T4WjxDzhrc610AdQrvR+Fq10ZADM6EfBynqIVTu
         ekmnTg/QO81E4JrslEUaSTaRp9BzrsZ3l9kjbJYHEK/Sv1EBXPe7I9QdGONb6fhq6DD9
         Bnx1HVtoa24HXhqAGpl3FCGVQ8zlXD4JhlitW/gXaBUqnq0ozrPPdWP+oJoLMMWbYCwV
         jc4VnUlpiCP6NZ5Y+0/J2Xff1BaMxXzhIgwsAgOaaZf3w7Smcdi6R9NA6IYIviCD1Tho
         9XC/S8SLM5kWzHkZ8hoOavcZhGQa3M/GdHqo2VFPC8kYvjGoJJGaH8Iy+XAMk5qEoKVW
         dzhw==
X-Gm-Message-State: AOAM533C6jDHsonnbsUadfKeJ6fui9lzc1kkw9dVqf9dpqlTaDAdMV4T
        nU1JOuemmB2Kxqm7ySAt4NU+DQ==
X-Google-Smtp-Source: ABdhPJyN/TqWJB0s+HOEo3+G7pkP5DR7DUqjxT+LOyXk/S8tZH/iVagIQRM3AUWWBY3aR03bTU2d5g==
X-Received: by 2002:a1c:7e49:: with SMTP id z70mr4013279wmc.24.1593187074525;
        Fri, 26 Jun 2020 08:57:54 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id f1sm17429843wmj.12.2020.06.26.08.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 08:57:53 -0700 (PDT)
Date:   Fri, 26 Jun 2020 16:57:50 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 3/3] cpufreq: Specify default governor on command line
Message-ID: <20200626155750.GA540785@google.com>
References: <cover.1593143118.git.viresh.kumar@linaro.org>
 <7eb38608b2b32c0c72dfb160c51206ec42e74e35.1593143118.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eb38608b2b32c0c72dfb160c51206ec42e74e35.1593143118.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday 26 Jun 2020 at 09:21:44 (+0530), Viresh Kumar wrote:
> index e798a1193bdf..93c6399c1a42 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -50,6 +50,9 @@ static LIST_HEAD(cpufreq_governor_list);
>  #define for_each_governor(__governor)				\
>  	list_for_each_entry(__governor, &cpufreq_governor_list, governor_list)
>  
> +static char cpufreq_param_governor[CPUFREQ_NAME_LEN];
> +static char default_governor[CPUFREQ_NAME_LEN];
> +
>  /**
>   * The "cpufreq driver" - the arch- or hardware-dependent low
>   * level driver of CPUFreq support, and its spinlock. This lock
> @@ -1061,7 +1064,6 @@ __weak struct cpufreq_governor *cpufreq_default_governor(void)
>  
>  static int cpufreq_init_policy(struct cpufreq_policy *policy)
>  {
> -	struct cpufreq_governor *def_gov = cpufreq_default_governor();
>  	struct cpufreq_governor *gov = NULL;
>  	unsigned int pol = CPUFREQ_POLICY_UNKNOWN;
>  	bool put_governor = false;
> @@ -1071,22 +1073,29 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
>  		/* Update policy governor to the one used before hotplug. */
>  		gov = get_governor(policy->last_governor);
>  		if (gov) {
> -			put_governor = true;
>  			pr_debug("Restoring governor %s for cpu %d\n",
> -				 policy->governor->name, policy->cpu);
> -		} else if (def_gov) {
> -			gov = def_gov;
> +				 gov->name, policy->cpu);
>  		} else {
> -			return -ENODATA;
> +			gov = get_governor(default_governor);
> +		}
> +
> +		if (gov) {
> +			put_governor = true;
> +		} else {
> +			gov = cpufreq_default_governor();
> +			if (!gov)
> +				return -ENODATA;
>  		}

As mentioned on patch 01, doing put_module() below if gov != NULL would
avoid this dance with put_governor, but this works too, so no strong
opinion.

> +
>  	} else {
> +
>  		/* Use the default policy if there is no last_policy. */
>  		if (policy->last_policy) {
>  			pol = policy->last_policy;
> -		} else if (def_gov) {
> -			pol = cpufreq_parse_policy(def_gov->name);
> +		} else {
> +			pol = cpufreq_parse_policy(default_governor);
>  			/*
> -			 * In case the default governor is neiter "performance"
> +			 * In case the default governor is neither "performance"
>  			 * nor "powersave", fall back to the initial policy
>  			 * value set by the driver.
>  			 */
> @@ -2796,13 +2805,22 @@ EXPORT_SYMBOL_GPL(cpufreq_unregister_driver);
>  
>  static int __init cpufreq_core_init(void)
>  {
> +	struct cpufreq_governor *gov = cpufreq_default_governor();
> +	char *name = gov->name;
> +
>  	if (cpufreq_disabled())
>  		return -ENODEV;
>  
>  	cpufreq_global_kobject = kobject_create_and_add("cpufreq", &cpu_subsys.dev_root->kobj);
>  	BUG_ON(!cpufreq_global_kobject);
>  
> +	if (strlen(cpufreq_param_governor))
> +		name = cpufreq_param_governor;
> +
> +	strncpy(default_governor, name, CPUFREQ_NAME_LEN);

Do we need both cpufreq_param_governor and default_governor?
Could we move everything to only one of them? Something a little bit
like that maybe?

---8<---
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 93c6399c1a42..a0e90b567e1e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -50,7 +50,6 @@ static LIST_HEAD(cpufreq_governor_list);
 #define for_each_governor(__governor)                          \
        list_for_each_entry(__governor, &cpufreq_governor_list, governor_list)
 
-static char cpufreq_param_governor[CPUFREQ_NAME_LEN];
 static char default_governor[CPUFREQ_NAME_LEN];
 
 /**
@@ -2814,13 +2813,11 @@ static int __init cpufreq_core_init(void)
        cpufreq_global_kobject = kobject_create_and_add("cpufreq", &cpu_subsys.dev_root->kobj);
        BUG_ON(!cpufreq_global_kobject);
 
-       if (strlen(cpufreq_param_governor))
-               name = cpufreq_param_governor;
-
-       strncpy(default_governor, name, CPUFREQ_NAME_LEN);
+       if (!strlen(default_governor))
+               strncpy(default_governor, name, CPUFREQ_NAME_LEN);
 
        return 0;
 }
 module_param(off, int, 0444);
-module_param_string(default_governor, cpufreq_param_governor, CPUFREQ_NAME_LEN, 0444);
+module_param_string(default_governor, default_governor, CPUFREQ_NAME_LEN, 0444);
--->8---

Also, one thing to keep in mind with this version (or the one you
suggested) is that if the command line parameter is not valid, we will
not fallback on the builtin default for the ->setpolicy() case. But I
suppose one might argue this is a reasonable behaviour, so no objection
from me.

Otherwise, apart from these nits, I gave this a go on my setup, with
builtin and modular governors & drivers, and everything worked exactly
as expected.

Thanks Viresh for the help!
Quentin

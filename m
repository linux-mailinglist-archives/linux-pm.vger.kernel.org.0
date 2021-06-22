Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6687D3AFCFE
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 08:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhFVGXL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 02:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVGXL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 02:23:11 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6C6C061574
        for <linux-pm@vger.kernel.org>; Mon, 21 Jun 2021 23:20:55 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l11so7140163pji.5
        for <linux-pm@vger.kernel.org>; Mon, 21 Jun 2021 23:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kSF9aTgYhrI1FCuFAOepwOfOP7U6F/CAMgLAI89bsVc=;
        b=L1kbkDcOHG4cyIe5ixNxwOwyBuJlKE086ZC+yInArWVMn/f66ZhNdVffAah8xi/oFD
         7wyQUGyc/Znjarf/mjkZoXsZO9bDoz5quPg8oswf2gyFJKVMjTERmPXzFwJ+eR8o4+SH
         MRVSxyrXCl+ooWxdJgd31Bjbgby41C1+PgVnYLl/MYbr2q1dRhw+rJoSxGmMS0YqLgt7
         semDm9hTtE1mMI28CD0+78taxQb9eS1VXDCicJGMYerztnyFm34txMk2gsuWzsaUP+Q+
         d3pW1PgMfAowG9nQKJfhXP2xMNX8fuSBm6VHdZMrc8HT+MPms9CSUrOExCKYjR+um3At
         airQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kSF9aTgYhrI1FCuFAOepwOfOP7U6F/CAMgLAI89bsVc=;
        b=fwXbcTcOhrEZJZzwioUXokfb9vkbDtOK8RESSUMRSIw63rM9vOQ3rhBy/QxCbuPK9R
         MWQpa6wz/O0buRZy33f3UpvNmAJL+NfZRvmzw4zzAnhXd5Q608rdpabr+/oxBYeGX+nQ
         K6hszbaTBKgwo6Ncsckg8RaL4fC8dy49xGRQqwioJ53cck2UDwqd9uO50n4KUNqCGfKu
         /iLOSTo/vTpFCzQgg5kNjsm2BCgVU9vS2Ep/F+Ugt7GnxNEKDazy3HaQEn6vdLpsR67d
         eC2hGQO+6r37zQtAFAEwai34wrlvhoKRq0Pnr7mg79DRufrmnBnFkcbl//04xqdhJ5F6
         KdcA==
X-Gm-Message-State: AOAM530O9fjaWbQB9mSx8n1cI3bWapxe1R1oAT7sQGu9v89CTcb3OQeK
        qoRdWBbbnkBWtYXiLVndyZlhaw==
X-Google-Smtp-Source: ABdhPJxyoFN6nWGRwCn89Qx1yaTeCqnUTwlwSDExyVkJdPdnEXzNXyXKgWRrmTC4c4DBwWexuyOa1Q==
X-Received: by 2002:a17:90a:740a:: with SMTP id a10mr2320010pjg.162.1624342855419;
        Mon, 21 Jun 2021 23:20:55 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id v67sm17120931pfb.193.2021.06.21.23.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 23:20:54 -0700 (PDT)
Date:   Tue, 22 Jun 2021 11:50:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: Make cpufreq_online() call driver->offline() on
 errors
Message-ID: <20210622062052.jo2by44djlyjpn5w@vireshk-i7>
References: <11788436.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11788436.O9o76ZdvQC@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-06-21, 19:26, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In the CPU removal path the ->offline() callback provided by the
> driver is always invoked before ->exit(),

Note that exit() doesn't get called if offline() is present in the CPU
removal path. We call exit() _only_ when the cpufreq driver gets
unregistered.

> but in the cpufreq_online()
> error path it is not, so ->exit() is somehow expected to know the
> context in which it has been called and act accordingly.

I agree, it isn't very clear.

> That is less than straightforward, so make cpufreq_online() invoke
> the driver's ->offline() callback before ->exit() too.
> 
> This only potentially affects intel_pstate at this point.
> 
> Fixes: 91a12e91dc39 ("cpufreq: Allow light-weight tear down and bring up of CPUs")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -1516,6 +1516,9 @@ out_destroy_policy:
>  	up_write(&policy->rwsem);
>  
>  out_exit_policy:
> +	if (cpufreq_driver->offline)
> +		cpufreq_driver->offline(policy);
> +
>  	if (cpufreq_driver->exit)
>  		cpufreq_driver->exit(policy);

If we want to go down this path, then we better do more and make it
very explicit that ->offline() follows a previous invocation of
->online().

Otherwise, with above we will end up calling ->offline() for two separate
states, ->online() failed (i.e. two calls to offline() one after the other
here) and other generic failures after ->init() passed.

So, better make it clear that online/offline are paired like
init/exit.

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1d1b563cea4b..0ce48dcb2e8a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1347,14 +1347,11 @@ static int cpufreq_online(unsigned int cpu)
        }
 
        if (!new_policy && cpufreq_driver->online) {
-               ret = cpufreq_driver->online(policy);
-               if (ret) {
-                       pr_debug("%s: %d: initialization failed\n", __func__,
-                                __LINE__);
-                       goto out_exit_policy;
-               }
-
-               /* Recover policy->cpus using related_cpus */
+               /*
+                * We did light-weight tear down earlier, don't need to do heavy
+                * initialization here. Just recover policy->cpus using
+                * related_cpus.
+                */
                cpumask_copy(policy->cpus, policy->related_cpus);
        } else {
                cpumask_copy(policy->cpus, cpumask_of(cpu));
@@ -1378,6 +1375,13 @@ static int cpufreq_online(unsigned int cpu)
                cpumask_copy(policy->related_cpus, policy->cpus);
        }
 
+       ret = cpufreq_driver->online(policy);
+       if (ret) {
+               pr_debug("%s: %d: %d: ->online() failed\n", __func__, __LINE__,
+                        ret);
+               goto out_exit_policy;
+       }
+
        down_write(&policy->rwsem);
        /*
         * affected cpus must always be the one, which are online. We aren't
@@ -1518,6 +1522,9 @@ static int cpufreq_online(unsigned int cpu)
 
        up_write(&policy->rwsem);
 
+       if (cpufreq_driver->offline)
+               cpufreq_driver->offline(policy);
+
 out_exit_policy:
        if (cpufreq_driver->exit)
                cpufreq_driver->exit(policy);


-- 
viresh

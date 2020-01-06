Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55E6A130DD4
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 08:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgAFHJN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 02:09:13 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54686 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgAFHJN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 02:09:13 -0500
Received: by mail-pj1-f67.google.com with SMTP id kx11so7194627pjb.4
        for <linux-pm@vger.kernel.org>; Sun, 05 Jan 2020 23:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nWk0OuHhu+M1/eNpjWo6RnDHi691B44p0xwgqH5nuoo=;
        b=Kdi2oGktRrF/QR3ElQpGSTBJi0vYvFbRyPlfdWJEotdmLi1WP8OTz7iQDDvgFKkJzS
         bVcDc8a4wzus0v+FoQfXNbkgqnlW3YOyEh3KY0xieHFBcS1SsHIm510zS/GObOoEc4lE
         ZgjNP652xQaewQUWS9y8t5M/ptJtEt13tiFQL5LI6BKVpr+SjoeMEgyTbvz2vMlaZApq
         QLOMfoZFWLmMXRyM8mzZiAp23kdUBb3DNCWo9OnNJmZ3/u/5P+dJB+glLwhqwcP3pCz6
         P/f8A7ymJcJ8rAMQpWaJfCzf8uBgazwOkBHxYSvQeA6iD43rQyb/rq6TJsTe9XBr54QV
         4FbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nWk0OuHhu+M1/eNpjWo6RnDHi691B44p0xwgqH5nuoo=;
        b=mCM8CXYLk/NQb/KsD0nwA99Fkp6dBlJWh6Z+w2FcVfkaZB3VXQ1t+y4zw1x/idAB4f
         knp36256sYTPm9k3jfykarKZNNMKdcdQq1ddM+fqm1hl6/gJiQKktmPviuPDrvqz/Cvv
         etSNy9Xagr4ZL+ZM0lKsTv3Wm6SLsmzAkW2q8v2eC5VFUG5EQNBt4DnydPdePfe9KiVR
         t0IV91J8LTEFXGlRLDMr+giSCfaa5cqU8Hzyz3MJoREJsVr0fiS1gWnHO/YtJBTqrecb
         UhVIQEbO29b2F8WkgMw/xXbexeYnLIB5hklICI/N1uNO2RzDvctSH5XiseLeWj77FvyW
         Yksw==
X-Gm-Message-State: APjAAAViGMZNWz7l8LnQ5VilXgrRQhMB/blee064U8TKoQ1jsIvluJsr
        4Fyd7saIsx03cjgOWHa94dY=
X-Google-Smtp-Source: APXvYqznxCjoYvbyYBBoCMO3neBFVA0lu5RvGuWfHnR001FH2Q+kZHQjC/k26NqYA/UGjFxQhVaG1A==
X-Received: by 2002:a17:90b:438e:: with SMTP id in14mr40333971pjb.83.1578294552600;
        Sun, 05 Jan 2020 23:09:12 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id 18sm69300092pfj.3.2020.01.05.23.09.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 05 Jan 2020 23:09:12 -0800 (PST)
Date:   Mon, 6 Jan 2020 15:09:10 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        rjw@rjwysocki.net, f.fainelli@gmail.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] cpufreq: brcmstb-avs-cpufreq: avoid potential stuck
 and UAF risk
Message-ID: <20200106070910.GA17897@cqw-OptiPlex-7050>
References: <1578228650-17157-1-git-send-email-qiwuchen55@gmail.com>
 <20200106055637.zq4icl5klg4wpvkx@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106055637.zq4icl5klg4wpvkx@vireshk-i7>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 06, 2020 at 11:26:37AM +0530, Viresh Kumar wrote:
> On 05-01-20, 20:50, qiwuchen55@gmail.com wrote:
> > From: chenqiwu <chenqiwu@xiaomi.com>
> > 
> > brcm_avs_cpufreq_get() calls cpufreq_cpu_get() to get cpufreq policy,
> > meanwhile, it also increments the kobject reference count of policy to
> > mark it busy. However, a corresponding call of cpufreq_cpu_put() is
> > ignored to decrement the kobject reference count back, which may lead
> > to a potential stuck risk that percpu cpuhp thread deadly waits for
> > dropping of kobject refcount when percpu cpufreq policy free.
> > 
> > The call trace of stuck risk could be:
> > cpufreq_online()  //If cpufreq online failed, goto out_free_policy.
> >     ->cpufreq_policy_free()     //Do cpufreq_policy free.
> >         ->cpufreq_policy_put_kobj()
> >             ->kobject_put()       //Skip if policy kfref count is not 1.
> >                 ->cpufreq_sysfs_release()
> >                     ->complete()  //Complete policy->kobj_unregister.
> >                 ->wait_for_completion() //Wait for policy->kobj_unregister.
> > 
> > A simple way to avoid this stuck risk is use cpufreq_cpu_get_raw()
> > instead of cpufreq_cpu_get(), since this can be easily exercised by
> > attempting to force an unbind of the CPUfreq driver.
> > 
> > Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> > ---
> >  drivers/cpufreq/brcmstb-avs-cpufreq.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > index 77b0e5d..6d2bf5c 100644
> > --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > @@ -452,8 +452,15 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
> >  
> >  static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
> >  {
> > -	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> > -	struct private_data *priv = policy->driver_data;
> > +	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
> > +	struct private_data *priv;
> > +
> > +	if (!policy)
> > +		return 0;
> > +
> 
> Since we always reach here after the cpufreq driver is registered, we
> may not need to check the policy pointer at all.
> 
> > +	priv = policy->driver_data;
> > +	if (!priv || !priv->base)
> > +		return 0;
> 
> Can there be a case where priv or priv->base be set to NULL for this
> driver ? I don't think so and so this may not be required.
>

Hi viresh,
There could be a case as the description of this patch besides
brcm_avs_driver unloads. Since cpufreq_policy_free() will free
the mm of cpufreq_policy at the last moment.

Thanks!
Qiwu

> >  
> >  	return brcm_avs_get_frequency(priv->base);
> >  }
> > -- 
> > 1.9.1
> 
> -- 
> viresh


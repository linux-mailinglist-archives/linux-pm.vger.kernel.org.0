Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A52512F2FD
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2020 03:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgACCfR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jan 2020 21:35:17 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42703 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbgACCfQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jan 2020 21:35:16 -0500
Received: by mail-pl1-f195.google.com with SMTP id p9so18526581plk.9
        for <linux-pm@vger.kernel.org>; Thu, 02 Jan 2020 18:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tGEEwbHeUHLQP4Ptti/qDHixIuYd/unHWt5t4Ky3zjg=;
        b=LiuIunQyP8zym26WwockXUORPmoNJDXevkc/8TMfHbIAo8fkNVJ4LDlMkrE/Y43Uv1
         vSWw09goD6zpzLXL911InQKv73Ln7e2c3FT7DSPGtGyF0NdGg3+LPTOvJoDdfSdEIZTS
         +VnAHbHUJrBbXMdzO0xhJvDM88aidW+oPMvBiyM/Tx0SBAVGSUzfjmsutxs20j2NWnbY
         uS+W7DA+3tksOKfcM+T1gIF2IIm5VZYrKXo2YupNLPUjvCemqxxhQoes1pKC3UPz5kN+
         8pUeBnhBji7dEI+QoBbNDQhTRdMAohK2zu1suXtYbDc9LU2ao+ujyipgN8NOYUHgIZ8g
         /X9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tGEEwbHeUHLQP4Ptti/qDHixIuYd/unHWt5t4Ky3zjg=;
        b=At9S4EdcLThHas7/PceOyJ3+uISsSwWbkKgMiUo336KSEICknDoXE8TuoBrGdx2HKq
         pKPiWQ6GebntHPrNvGxsZ9BnAsqumF0LE8xjO+WWcNoCngetMOeUEIdCArSO7thBHqaL
         ZXgJUAnffKqGG7xACuu96dsTCppfXjIVhL+jelL7DSbGfA8yMxNFuE7Um0ILM8L0Vqi4
         Yl7Eg3Ta8D1SmOaXQE6OGioGifMXNEbQoiREeFq17aQSkHrgi1kuT1nlI8bOAH0G1LYq
         /9BX/oNszITIy0xQZ85AQC+lujT6TCf9BwQN7exLJRPLVSk+MveDJON15YegZTOP1je4
         RsxA==
X-Gm-Message-State: APjAAAXXVHrbbgXVpeWui0uikfx/nRdY6I3CRzdKOAVKvKC60mAbMFuU
        Rf1WJTdZXPfP8BzkbBBNvhY=
X-Google-Smtp-Source: APXvYqymLlV7m58zphcHYTAerP/fyjZ3gzvpczJHHzHMOoZE9w0bLKsKWEmyMN4uiUkm/RiW59QPbw==
X-Received: by 2002:a17:902:868e:: with SMTP id g14mr60508979plo.214.1578018916194;
        Thu, 02 Jan 2020 18:35:16 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id g7sm67200526pfq.33.2020.01.02.18.35.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 02 Jan 2020 18:35:15 -0800 (PST)
Date:   Fri, 3 Jan 2020 10:35:13 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     mmayer@broadcom.com, viresh.kumar@linaro.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, chenqiwu@xiaomi.com
Subject: Re: [PATCH] cpufreq: brcmstb-avs-cpufreq: avoid a stuck risk and UAF
 issue in brcm_avs_cpufreq_get()
Message-ID: <20200103023513.GA5021@cqw-OptiPlex-7050>
References: <1577536777-24966-1-git-send-email-qiwuchen55@gmail.com>
 <5ba60a5b-15dc-3420-29ea-f21990ed1c07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ba60a5b-15dc-3420-29ea-f21990ed1c07@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 02, 2020 at 04:08:53PM -0800, Florian Fainelli wrote:
> On 12/28/19 4:39 AM, qiwuchen55@gmail.com wrote:
> > From: chenqiwu <chenqiwu@xiaomi.com>
> > 
> > brcm_avs_cpufreq_get() calls cpufreq_cpu_get() to get cpufreq policy,
> > meanwhile, it also increments the kobject reference count of policy to
> > mark it busy. However, a corresponding call to cpufreq_cpu_put() is
> > ignored to decrement the kobject reference count back, which may lead
> > to a potential stuck risk that cpuhp thread deadly wait for dropping
> > of refcount when cpufreq policy free.
> > 
> > The call trace of stuck risk could be:
> > cpufreq_online()  //If cpufreq initialization failed, goto out_free_policy.
> >     ->cpufreq_policy_free()	//Do cpufreq_policy free.
> >         ->cpufreq_policy_put_kobj()
> >             ->kobject_put()       //Skip if policy kfref count is not 1.
> >                 ->cpufreq_sysfs_release()
> >                     ->complete()  //Complete policy->kobj_unregister.
> >                 ->wait_for_completion() //Wait for policy->kobj_unregister.
> > 
> > A simple way to avoid this stuck risk is use cpufreq_cpu_get_raw()
> > instead of cpufreq_cpu_get(), since brcmstb-avs driver just wants
> > to get cpufreq policy.
> > 
> > What's more, there is a potential UAF issue in cpufreq_notify_transition()
> > that the cpufreq policy of current cpu has been released before using it.
> > So we should make a judgement to avoid it.
> > 
> > Thanks!
> > Qiwu
> > 
> > Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> 
> This can be easily exercised by attempting to force an unbind of the
> CPUfreq driver without your patch, we will indeed be stuck in the code
> sequence you indicated, whereas with your patch, we can successfully unbind.
> 
> You might want to make some changes though, since you return NULL from a
> function whose signature for the return type is unsigned int. If nothing
> else returning 0 would make sure you hit that code path:
> 
>         if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
>                 policy->cur = cpufreq_driver->get(policy->cpu);
>                 if (!policy->cur) {
>                         pr_err("%s: ->get() failed\n", __func__);
>                         goto out_exit_policy;
>                 }
> 
> something like this on top of your patch:
> 
> diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> index f4f0d6b4e77c..be559fc4e7c6 100644
> --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> @@ -488,11 +488,11 @@ static unsigned int brcm_avs_cpufreq_get(unsigned
> int cpu)
>         struct private_data *priv;
> 
>         if (!policy)
> -               return NULL;
> +               return 0;
> 
>         priv = policy->driver_data;
>         if (!priv || !priv->base)
> -               return NULL;
> +               return 0;
> 
>         return brcm_avs_get_frequency(priv->base);
>  }
> 
> With that, you can add:
> 
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Thank you!
> -- 
> Florian
Hi Florian,
I agree your idea, since NULL equals to ((void *)0), return 0 matches
with unsigned int.

Thanks!
Qiwu

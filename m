Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17D081422EB
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 06:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgATF60 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 00:58:26 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41024 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgATF6Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 00:58:25 -0500
Received: by mail-pf1-f196.google.com with SMTP id w62so15274377pfw.8;
        Sun, 19 Jan 2020 21:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=44OvwPqHGhblGpev/Fgsdo0KBCwnSccL+pFHHJODwRA=;
        b=KbeoHMBxGQBM/Im21AP25FrgmZHdXs95J2h6j/+YlJAiPtyRvC/i4UqABBcF1zV/5A
         GlVRgFkkC3+3Xm9aS5svlW4KJUkQGd7c4O2zgLmqSN89gTd95UZqcEc/ZDBdyKd6snkG
         QjZFnq+8tp3HgISoXncj2zYpB7DxwAfDrvQogCRcjWa1j20OZV//rLAzTHlstjAa2HT6
         bgNEyExdJ0A8H8zs2/OcKwyEafaRG7NrxZ39JoQNUxPpX+kVSiF0mqv1QEB05UyXP61n
         VEKy/3akwDV1g62/13f5OCYIQAGO0ac8Ay0N9CIRiJCOqZ2RSLE1RhzyqYuAX3w3FMjF
         ns3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=44OvwPqHGhblGpev/Fgsdo0KBCwnSccL+pFHHJODwRA=;
        b=ehcjCCwefureHUV2BYzQzNTMi5xSszNloWAhg8VUkf0OpQYygXFuIy3G5XM/B3lmpY
         1UANcT6TQiQzsYyhq9IiMmIi8vmncrNjn3sXoicxLOUyemiTGPGRRwCQ3FNL4DNTp4tL
         MacRyvTYicB0hkJKmWaLe2jJxsR6Kdsr/4FLo2QdjsYrTl6v3k+lwQEepzb6VcnMN7Z1
         phQ8f9aQCHxJG0F3tc+C8OkKMLNkYU0umT/xuaUpv2YNsIaTjsYpuihmsQRaFunAV+NM
         EnithFbnUWh3XVif9caxwrGhkL1sTw50T1NXo+N4Q3z3M1+CYCudacKLew7wEJ6X0J5x
         zA1Q==
X-Gm-Message-State: APjAAAWXuorwiFrbL0hcgziWxbZIQk4LkXsSp53TqB7Qm0YNVIWK/BXt
        SaL/OVLam1YVenvoHSC1/QHMLypsEGY=
X-Google-Smtp-Source: APXvYqw9JjQQ6aSCtG0lkpD4uoTTy1UXI9ZPV3n5VK5AoeuRyNfmc4uOarzUHC61VTUXbFXxF7/LtA==
X-Received: by 2002:a63:6787:: with SMTP id b129mr58751152pgc.103.1579499905338;
        Sun, 19 Jan 2020 21:58:25 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id z5sm7976205pfq.3.2020.01.19.21.58.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 19 Jan 2020 21:58:24 -0800 (PST)
Date:   Mon, 20 Jan 2020 13:58:22 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     mmayer@broadcom.com, rjw@rjwysocki.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH v3] cpufreq: brcmstb-avs: fix imbalance of cpufreq policy
 refcount
Message-ID: <20200120055822.GB5185@cqw-OptiPlex-7050>
References: <1579417750-21984-1-git-send-email-qiwuchen55@gmail.com>
 <20200120053250.igkwofqfzvmqb3c3@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120053250.igkwofqfzvmqb3c3@vireshk-i7>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 20, 2020 at 11:02:50AM +0530, Viresh Kumar wrote:
> On 19-01-20, 15:09, qiwuchen55@gmail.com wrote:
> > From: chenqiwu <chenqiwu@xiaomi.com>
> > 
> > brcm_avs_cpufreq_get() calls cpufreq_cpu_get() to get the cpufreq policy,
> > meanwhile, it also increments the kobject reference count to mark it busy.
> > However, a corresponding call of cpufreq_cpu_put() is ignored to decrement
> > the kobject reference count back, which may lead to a potential stuck risk
> > that the cpuhp thread deadly waits for dropping of kobject refcount when
> > cpufreq policy free.
> > 
> > For fixing this bug, cpufreq_get_policy() is referenced to do a proper
> > cpufreq_cpu_get()/cpufreq_cpu_put() and fill a policy copy for the user.
> > If the policy return NULL, we just return 0 to hit the code path of
> > cpufreq_driver->get.
> > 
> > Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> > ---
> >  drivers/cpufreq/brcmstb-avs-cpufreq.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > index 77b0e5d..ee0d404 100644
> > --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > @@ -452,8 +452,16 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
> >  
> >  static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
> >  {
> > -	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> 
> Why can't we just add a corresponding cpufreq_cpu_put() instead of all this ?
> 

cpufreq_get_policy() does a proper cpufreq_cpu_get()/cpufreq_cpu_put(),
meanwhile fills a policy copy for the user. It equals to using
cpufreq_cpu_get() and a corresponding cpufreq_cpu_put() around access
to the policy pointer. I think both methods are fine here.
What do you think?

> > -	struct private_data *priv = policy->driver_data;
> > +	struct cpufreq_policy policy;
> > +	struct private_data *priv;
> > +
> > +	/*
> > +	 * In case cpufreq policy has been released, just return 0.
> > +	 */
> > +	if (cpufreq_get_policy(&policy, cpu))
> > +		return 0;
> 
> Why did you move away from the previous implementation of cpufreq_cpu_get() ?
> 
> > +
> > +	priv = policy.driver_data;
> >  
> >  	return brcm_avs_get_frequency(priv->base);
> >  }
> > -- 
> > 1.9.1
> 
> -- 
> viresh

Qiwu

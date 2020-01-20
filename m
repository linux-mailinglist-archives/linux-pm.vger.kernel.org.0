Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17658142310
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 07:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgATGOA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 01:14:00 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34316 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgATGN7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 01:13:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id c9so7432663plo.1;
        Sun, 19 Jan 2020 22:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HEnK5zOWrM4EtjOOUObaQ50k2YuQm6+zLeTAwK5KuFw=;
        b=rHrnilphdbZXls873AYNAy/Pyu163ib9A5hLLJVruxIy8qlPn78vsdw6+F36xjOgce
         XjdI2PGOVTosulcFr+I0I5kswvr43SJZMn35UnIJTas0+ticPMhCqLCULN2KicOVEwfn
         qXAvCc5CQyI7g4xLpCZ9xC2j8R84/hke00FsZCqQsdXYz31l/7k3F4xLnT74wmJKZg5I
         hy1WemXy5OyVXEZq2zrqKLxzuzGubxV+kdR3gdcoJef86dBgSeHCgXS1cpveLgr6SUW8
         5iTXwX6/ZPItEwg6Z7uBF+4kanfO77E94NKSbqeL9wTWdW1qc2EvtdLE3TvJmMvhKg7S
         pH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HEnK5zOWrM4EtjOOUObaQ50k2YuQm6+zLeTAwK5KuFw=;
        b=BNyztggntpaf99SXwGVptgf3KzqHcyWCf/jZrOkw8Y+ilToURnzknt/tm0K7bEhX46
         BWVMlqzbBUdtzptXtBd6bfrHPAP0nFwkAhPZAw86Z8KGgNhg60hFhQDgc3JcjuSx8bdH
         RUN3RtJJWs0tQCsKGcC/bHSu02yiu4eXMi6wnSIHi1iwZ5UfKjVoBpzcbyDJP8tkLwoG
         EgvEcqYA2mqcpELuNGIadIPXqUka5hnYxeDFQr32TKCYbj3ZlePYhk/pWsVLehFu3Wak
         +bBSUCtiqccdKjJkEaUTbPs/Mdwl/JNyTpYJi9nXHcvVIgBxXo1hLMVkUH/tLHyn0uIN
         HWEA==
X-Gm-Message-State: APjAAAUcGsI80EOxq5JOJvTCEc9BmNy5lnm6NLAak2uhgsLRQmuWHiB2
        ZBDwT4183EdIPu9s/FbK1nA=
X-Google-Smtp-Source: APXvYqy5vJY131Lor3YeVDhjCpeI3gktCtJOpO+P6J1mFr58LYnjO2gN5V2DNmNZVLK3YEshLDX/sA==
X-Received: by 2002:a17:902:b617:: with SMTP id b23mr13530550pls.285.1579500839281;
        Sun, 19 Jan 2020 22:13:59 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id y14sm37008006pfe.147.2020.01.19.22.13.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 19 Jan 2020 22:13:58 -0800 (PST)
Date:   Mon, 20 Jan 2020 14:13:56 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     mmayer@broadcom.com, rjw@rjwysocki.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH v3] cpufreq: brcmstb-avs: fix imbalance of cpufreq policy
 refcount
Message-ID: <20200120061356.GA5605@cqw-OptiPlex-7050>
References: <1579417750-21984-1-git-send-email-qiwuchen55@gmail.com>
 <20200120053250.igkwofqfzvmqb3c3@vireshk-i7>
 <20200120055822.GB5185@cqw-OptiPlex-7050>
 <20200120060134.izotrbzjvzk327zx@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120060134.izotrbzjvzk327zx@vireshk-i7>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 20, 2020 at 11:31:34AM +0530, Viresh Kumar wrote:
> On 20-01-20, 13:58, chenqiwu wrote:
> > On Mon, Jan 20, 2020 at 11:02:50AM +0530, Viresh Kumar wrote:
> > > On 19-01-20, 15:09, qiwuchen55@gmail.com wrote:
> > > > From: chenqiwu <chenqiwu@xiaomi.com>
> > > > 
> > > > brcm_avs_cpufreq_get() calls cpufreq_cpu_get() to get the cpufreq policy,
> > > > meanwhile, it also increments the kobject reference count to mark it busy.
> > > > However, a corresponding call of cpufreq_cpu_put() is ignored to decrement
> > > > the kobject reference count back, which may lead to a potential stuck risk
> > > > that the cpuhp thread deadly waits for dropping of kobject refcount when
> > > > cpufreq policy free.
> > > > 
> > > > For fixing this bug, cpufreq_get_policy() is referenced to do a proper
> > > > cpufreq_cpu_get()/cpufreq_cpu_put() and fill a policy copy for the user.
> > > > If the policy return NULL, we just return 0 to hit the code path of
> > > > cpufreq_driver->get.
> > > > 
> > > > Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> > > > ---
> > > >  drivers/cpufreq/brcmstb-avs-cpufreq.c | 12 ++++++++++--
> > > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > > > index 77b0e5d..ee0d404 100644
> > > > --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > > > +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > > > @@ -452,8 +452,16 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
> > > >  
> > > >  static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
> > > >  {
> > > > -	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> > > 
> > > Why can't we just add a corresponding cpufreq_cpu_put() instead of all this ?
> > > 
> > 
> > cpufreq_get_policy() does a proper cpufreq_cpu_get()/cpufreq_cpu_put(),
> > meanwhile fills a policy copy for the user. It equals to using
> > cpufreq_cpu_get() and a corresponding cpufreq_cpu_put() around access
> > to the policy pointer. I think both methods are fine here.
> > What do you think?
> 
> cpufreq_get_policy() does an extra memcpy as well, which isn't required at all
> in your case.
> 
> -- 
> viresh

Huha..Do you worry about the race conditon with cpufreq policy free path?
If the policy has been released, cpufreq_get_policy() will return -EINVAL,
it won't do an extra memcpy.

Qiwu

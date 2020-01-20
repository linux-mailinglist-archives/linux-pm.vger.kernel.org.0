Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F10E1423D2
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 07:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgATGui (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 01:50:38 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45566 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgATGuh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 01:50:37 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so12750290pls.12;
        Sun, 19 Jan 2020 22:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=19G2hJ0Y5Y+ICc9F9ypBwJspYPvqMAzXv9gjpu0d/Sc=;
        b=Fx2UTjU+CwLoqzW58fI13zN3UMdwrn+NM8Fj244+1by5FD9Yh9NI3xHonpZ4iIQtTT
         8ysJDVphxwpTZCjQoIj8Bpx8j/hnPl7elDBV6FhzG6xOuB8oXF8GxNoszpkDYiUoU3pe
         Z0VfRUlpi60j246MjaoIO3wkWcppjMAJwmXSgIZQqZ27lBXpx9AN9PGU1tVB8ByBMbjN
         Q/9MQgURiZt3Au/0hzpD46uaUuntuUPsPilSqybRs8epxL7FgRiIzAZiT0J5rO9Ilm7K
         Oor0DWcrU95Zg2RoKBbSuvk3vWNvToIclrcdJXGMCWHv9oE6A/btmDd12xjWKek4/Tf2
         NP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=19G2hJ0Y5Y+ICc9F9ypBwJspYPvqMAzXv9gjpu0d/Sc=;
        b=X6dUqJXbIQldSG5LhstvfQEwxRKRpgAPGk+4ZKnzSUVDLOxDzUAKjFnUS+n+FzVFwi
         KbsjmOWnt5y0Dc7yaR20FQErRzf9is3eHDy/Q5R8fFtHoqiDgIjwCroigSG67tePYsyH
         T4F2uByT9pT1t6Hl0OVMlA66aWm1embNrd/gjHaJ263dXLzFKIbFWgRvCG1NipBvUkAZ
         PX4d366Nho5mOmapX/kPBlja75koMstLvcz71vnyWWESwzsDwAlYQBEH+p7AlEYbeZKt
         z7VPLzUlMMtHu3SCKitJ5twAi/9EoSJYmSY5fVUBFsrCtQZ8O9Thb6ENGrU/G8gxV+2V
         UJfQ==
X-Gm-Message-State: APjAAAWejlkSjaCdtH5eQ5yA3LPnjZstL2XfVjMHhdcpfusf3YgjpUce
        QGb3VV7InpEChN4sIyJxWT0=
X-Google-Smtp-Source: APXvYqw+UGLalaEbXYz82H3Vf+GtPUDO8dZIGgFGrasGSS6G+eK+XcLZIajq4hcjdpDOn5PhI/Q1Aw==
X-Received: by 2002:a17:902:ab91:: with SMTP id f17mr13549978plr.172.1579503036952;
        Sun, 19 Jan 2020 22:50:36 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id q21sm36278849pff.105.2020.01.19.22.50.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 19 Jan 2020 22:50:36 -0800 (PST)
Date:   Mon, 20 Jan 2020 14:50:34 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     mmayer@broadcom.com, rjw@rjwysocki.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH v3] cpufreq: brcmstb-avs: fix imbalance of cpufreq policy
 refcount
Message-ID: <20200120065034.GA5874@cqw-OptiPlex-7050>
References: <1579417750-21984-1-git-send-email-qiwuchen55@gmail.com>
 <20200120053250.igkwofqfzvmqb3c3@vireshk-i7>
 <20200120055822.GB5185@cqw-OptiPlex-7050>
 <20200120060134.izotrbzjvzk327zx@vireshk-i7>
 <20200120061356.GA5605@cqw-OptiPlex-7050>
 <20200120062126.nmxaqhcpqcojuihr@vireshk-i7>
 <20200120062756.GA5802@cqw-OptiPlex-7050>
 <20200120063004.zzhep35vfl3urndd@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120063004.zzhep35vfl3urndd@vireshk-i7>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 20, 2020 at 12:00:04PM +0530, Viresh Kumar wrote:
> On 20-01-20, 14:27, chenqiwu wrote:
> > On Mon, Jan 20, 2020 at 11:51:26AM +0530, Viresh Kumar wrote:
> > > On 20-01-20, 14:13, chenqiwu wrote:
> > > > On Mon, Jan 20, 2020 at 11:31:34AM +0530, Viresh Kumar wrote:
> > > > > On 20-01-20, 13:58, chenqiwu wrote:
> > > > > > On Mon, Jan 20, 2020 at 11:02:50AM +0530, Viresh Kumar wrote:
> > > > > > > On 19-01-20, 15:09, qiwuchen55@gmail.com wrote:
> > > > > > > > From: chenqiwu <chenqiwu@xiaomi.com>
> > > > > > > > 
> > > > > > > > brcm_avs_cpufreq_get() calls cpufreq_cpu_get() to get the cpufreq policy,
> > > > > > > > meanwhile, it also increments the kobject reference count to mark it busy.
> > > > > > > > However, a corresponding call of cpufreq_cpu_put() is ignored to decrement
> > > > > > > > the kobject reference count back, which may lead to a potential stuck risk
> > > > > > > > that the cpuhp thread deadly waits for dropping of kobject refcount when
> > > > > > > > cpufreq policy free.
> > > > > > > > 
> > > > > > > > For fixing this bug, cpufreq_get_policy() is referenced to do a proper
> > > > > > > > cpufreq_cpu_get()/cpufreq_cpu_put() and fill a policy copy for the user.
> > > > > > > > If the policy return NULL, we just return 0 to hit the code path of
> > > > > > > > cpufreq_driver->get.
> > > > > > > > 
> > > > > > > > Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> > > > > > > > ---
> > > > > > > >  drivers/cpufreq/brcmstb-avs-cpufreq.c | 12 ++++++++++--
> > > > > > > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > > > > > > > index 77b0e5d..ee0d404 100644
> > > > > > > > --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > > > > > > > +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > > > > > > > @@ -452,8 +452,16 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
> > > > > > > >  
> > > > > > > >  static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
> > > > > > > >  {
> > > > > > > > -	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> > > > > > > 
> > > > > > > Why can't we just add a corresponding cpufreq_cpu_put() instead of all this ?
> > > > > > > 
> > > > > > 
> > > > > > cpufreq_get_policy() does a proper cpufreq_cpu_get()/cpufreq_cpu_put(),
> > > > > > meanwhile fills a policy copy for the user. It equals to using
> > > > > > cpufreq_cpu_get() and a corresponding cpufreq_cpu_put() around access
> > > > > > to the policy pointer. I think both methods are fine here.
> > > > > > What do you think?
> > > > > 
> > > > > cpufreq_get_policy() does an extra memcpy as well, which isn't required at all
> > > > > in your case.
> > > > > 
> > > > > -- 
> > > > > viresh
> > > > 
> > > > Huha..Do you worry about the race conditon with cpufreq policy free path?
> > > 
> > > No. I just worry about an unnecessary memcpy, nothing else.
> > >
> > Is there any question about this extra memcpy?
> 
> What do you mean by that?
> 
> The whole point I am trying to make is that for your specific case, doing an
> explicit cpufreq_cpu_get() and cpufreq_cpu_put() is far more efficient than
> calling cpufreq_get_policy() which has a different purpose and usecase.
>

For efficiency, I agree your idea.
So we have change as follows:
diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 77b0e5d..b2ddde3 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -455,6 +455,11 @@ static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
        struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
        struct private_data *priv = policy->driver_data;

+       if (!policy)
+               return 0;
+
+       cpufreq_cpu_put(policy);
+
        return brcm_avs_get_frequency(priv->base);
 }

Qiwu

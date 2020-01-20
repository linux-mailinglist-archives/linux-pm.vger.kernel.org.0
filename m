Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0D76142340
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 07:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgATG2A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 01:28:00 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33766 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgATG2A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 01:28:00 -0500
Received: by mail-pj1-f65.google.com with SMTP id u63so5925816pjb.0;
        Sun, 19 Jan 2020 22:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ET0q8WYL5rkQ5IzRJ2JKF9s36w4Hlm44GgUbEbrS44E=;
        b=Erj1y32AGIZ/G/ywtpfnwzBkrrKgXEVyIRkm40EDXpAfTpeZ9W+XoFe11MWAqX2DUW
         3ZPwcdJVrvnaNOOVRcOLi73URdiDDZu6Qb5oT+S1mUE5l4f488lKR/tR0EtU2k/+WEuz
         UswaBkpQ4lIMEZwRPRbxdyazKu52nH2naCRGGSvDBqKZGwPp7ee9iOPHTBGcOMMTIBlD
         /itR2YqyOfeYtOJv4DHZVyNgw3zND2hdh2JcrIhbDRtDTT7T3gqPGbRgMTx4z3yEbvSU
         PvQVJjKViJieiTBnCG65q59iOozdkd5RpIe1SDezO4zmZjDsSI/ZGi0ii9DhazxfVkWQ
         SfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ET0q8WYL5rkQ5IzRJ2JKF9s36w4Hlm44GgUbEbrS44E=;
        b=YXpFNBTxPypaVX7s9tPRp0Lj+Y36XIh5+s9Ge1Rn5gozhJGXiP7oKwBlZdcs3rFGJK
         x7hensAxXVCOuo0RUsySR3LjqmNkSMMzL97nivd9LVe2l+k4lu4Ya5JHrIPZ5I6InBiT
         +j3liY2BZvbpu3Aaxk/rjU0gzwHmcrKWhGgDjEFvQQYmLGcrLTYk4coLfYjVT2zICNUF
         tRgDUgip3Yv4ouu2Rb82JRvfJYEFA9MMlcBirNaH/4sG5ONb+MdKqDJazjZDbQVz1lnq
         bouceaRtOlZT/RFOPB+jkUqiVukEza2QczGW9DCzZNSuBlRGm5p0MeZwbcqYfV1Ye+LH
         bw4g==
X-Gm-Message-State: APjAAAVzNlRtNL+4XBKBON0RAH7du5Dj+8JYncJHDbAq4cGwut3wQeib
        ND4YDROVATF1fDD6KwRgGzY=
X-Google-Smtp-Source: APXvYqxJSnRtEDcsAeHFLYuYgmxozPkFuG1tXw2UrBNICvQl0lo4UimdAnbGfJJmfT410oYAEZc8YQ==
X-Received: by 2002:a17:90a:d156:: with SMTP id t22mr21189542pjw.108.1579501679487;
        Sun, 19 Jan 2020 22:27:59 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id x21sm37292863pfn.164.2020.01.19.22.27.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 19 Jan 2020 22:27:58 -0800 (PST)
Date:   Mon, 20 Jan 2020 14:27:56 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     mmayer@broadcom.com, rjw@rjwysocki.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH v3] cpufreq: brcmstb-avs: fix imbalance of cpufreq policy
 refcount
Message-ID: <20200120062756.GA5802@cqw-OptiPlex-7050>
References: <1579417750-21984-1-git-send-email-qiwuchen55@gmail.com>
 <20200120053250.igkwofqfzvmqb3c3@vireshk-i7>
 <20200120055822.GB5185@cqw-OptiPlex-7050>
 <20200120060134.izotrbzjvzk327zx@vireshk-i7>
 <20200120061356.GA5605@cqw-OptiPlex-7050>
 <20200120062126.nmxaqhcpqcojuihr@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120062126.nmxaqhcpqcojuihr@vireshk-i7>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 20, 2020 at 11:51:26AM +0530, Viresh Kumar wrote:
> On 20-01-20, 14:13, chenqiwu wrote:
> > On Mon, Jan 20, 2020 at 11:31:34AM +0530, Viresh Kumar wrote:
> > > On 20-01-20, 13:58, chenqiwu wrote:
> > > > On Mon, Jan 20, 2020 at 11:02:50AM +0530, Viresh Kumar wrote:
> > > > > On 19-01-20, 15:09, qiwuchen55@gmail.com wrote:
> > > > > > From: chenqiwu <chenqiwu@xiaomi.com>
> > > > > > 
> > > > > > brcm_avs_cpufreq_get() calls cpufreq_cpu_get() to get the cpufreq policy,
> > > > > > meanwhile, it also increments the kobject reference count to mark it busy.
> > > > > > However, a corresponding call of cpufreq_cpu_put() is ignored to decrement
> > > > > > the kobject reference count back, which may lead to a potential stuck risk
> > > > > > that the cpuhp thread deadly waits for dropping of kobject refcount when
> > > > > > cpufreq policy free.
> > > > > > 
> > > > > > For fixing this bug, cpufreq_get_policy() is referenced to do a proper
> > > > > > cpufreq_cpu_get()/cpufreq_cpu_put() and fill a policy copy for the user.
> > > > > > If the policy return NULL, we just return 0 to hit the code path of
> > > > > > cpufreq_driver->get.
> > > > > > 
> > > > > > Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> > > > > > ---
> > > > > >  drivers/cpufreq/brcmstb-avs-cpufreq.c | 12 ++++++++++--
> > > > > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > > > > > index 77b0e5d..ee0d404 100644
> > > > > > --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > > > > > +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > > > > > @@ -452,8 +452,16 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
> > > > > >  
> > > > > >  static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
> > > > > >  {
> > > > > > -	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> > > > > 
> > > > > Why can't we just add a corresponding cpufreq_cpu_put() instead of all this ?
> > > > > 
> > > > 
> > > > cpufreq_get_policy() does a proper cpufreq_cpu_get()/cpufreq_cpu_put(),
> > > > meanwhile fills a policy copy for the user. It equals to using
> > > > cpufreq_cpu_get() and a corresponding cpufreq_cpu_put() around access
> > > > to the policy pointer. I think both methods are fine here.
> > > > What do you think?
> > > 
> > > cpufreq_get_policy() does an extra memcpy as well, which isn't required at all
> > > in your case.
> > > 
> > > -- 
> > > viresh
> > 
> > Huha..Do you worry about the race conditon with cpufreq policy free path?
> 
> No. I just worry about an unnecessary memcpy, nothing else.
>
Is there any question about this extra memcpy?

Qiwu

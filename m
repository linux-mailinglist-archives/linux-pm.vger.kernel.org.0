Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFF7142331
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 07:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgATGV3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 01:21:29 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38367 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgATGV3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 01:21:29 -0500
Received: by mail-pj1-f66.google.com with SMTP id l35so6639771pje.3
        for <linux-pm@vger.kernel.org>; Sun, 19 Jan 2020 22:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FnAngPR8gSFbezIM3xfQhGpPmFxWOtFtCSlqS5qfXAo=;
        b=LZSPlN4fD4a4JzgFT2rY/DxxrayfXEV28MoW53pPPBE4ZB6ZELpcd0J6ddJxzdJ1Lm
         BWF62i9RCRKa2LhJGe3bln24ZcljMjs8DHFXsnpP2aGO+SQETcWFI9IgIrOhoh98Ut4r
         gJBlzUaD6vjNlyt/mK5pfltDriHIapLf9HG4/3Qez4gAdpgQYgR/WAqSz5XMGRzulYyU
         ESeOR9osysFnSKfH6xODkRV/xnyaLwLpwM5QGJmS51JZxCVodMaUADOFmOTRsYLbmDJY
         KqwcShmAZQivrlPYaFfBxJj6dQB5w0fBDR1Lo7RL/wD2zGw2Si6XZOfubfwn/6wQFty6
         IPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FnAngPR8gSFbezIM3xfQhGpPmFxWOtFtCSlqS5qfXAo=;
        b=bsHB8aA2hIA75zDPfDEYT6TlnkkWEvRv535g6Vo1rJI1dyDY3jkc4cy9+oW1EAakNq
         DnW5J03IFIOW04C+5GHQoTh7oLGqVGbTk0IBaX2P2zCmK1XrdebmCFQoe9847Uzy40R6
         D4pm724W4Vrt7vMbDi3X3oDz+FPbp29nQgkdmfj/Sk3SvOjUTbkHIFELteM1fTTheC+g
         b4X86itp/owgDVnCuZm0FbVv3E8U6paUoz5altNbbWhqChvAAUsshCqTMr8zPtoGcIAP
         MNsJSZ16zOxpFf7ISdyX7xwKe8Ib/epK/cfEz8txlzRFLh+RHtb8lfcfG/8Bdw0k7DxN
         Dr0g==
X-Gm-Message-State: APjAAAXIvASieSJxUsFTQeWW5a1aVelG0HIvA99M3sX5QoKITvyo7hwo
        eqOEqE9nbYT87cnW1ruk1OUjpw==
X-Google-Smtp-Source: APXvYqziQT15J0JnLljJx6TSSJEg11GZh1WRLm/E/pQZFkqMxREjpH+FuO3kv9KmbyWDMTZpIfomjg==
X-Received: by 2002:a17:90a:246c:: with SMTP id h99mr22045031pje.134.1579501288625;
        Sun, 19 Jan 2020 22:21:28 -0800 (PST)
Received: from localhost ([122.172.71.156])
        by smtp.gmail.com with ESMTPSA id c22sm36979913pfo.50.2020.01.19.22.21.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jan 2020 22:21:27 -0800 (PST)
Date:   Mon, 20 Jan 2020 11:51:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     chenqiwu <qiwuchen55@gmail.com>
Cc:     mmayer@broadcom.com, rjw@rjwysocki.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH v3] cpufreq: brcmstb-avs: fix imbalance of cpufreq policy
 refcount
Message-ID: <20200120062126.nmxaqhcpqcojuihr@vireshk-i7>
References: <1579417750-21984-1-git-send-email-qiwuchen55@gmail.com>
 <20200120053250.igkwofqfzvmqb3c3@vireshk-i7>
 <20200120055822.GB5185@cqw-OptiPlex-7050>
 <20200120060134.izotrbzjvzk327zx@vireshk-i7>
 <20200120061356.GA5605@cqw-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120061356.GA5605@cqw-OptiPlex-7050>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-01-20, 14:13, chenqiwu wrote:
> On Mon, Jan 20, 2020 at 11:31:34AM +0530, Viresh Kumar wrote:
> > On 20-01-20, 13:58, chenqiwu wrote:
> > > On Mon, Jan 20, 2020 at 11:02:50AM +0530, Viresh Kumar wrote:
> > > > On 19-01-20, 15:09, qiwuchen55@gmail.com wrote:
> > > > > From: chenqiwu <chenqiwu@xiaomi.com>
> > > > > 
> > > > > brcm_avs_cpufreq_get() calls cpufreq_cpu_get() to get the cpufreq policy,
> > > > > meanwhile, it also increments the kobject reference count to mark it busy.
> > > > > However, a corresponding call of cpufreq_cpu_put() is ignored to decrement
> > > > > the kobject reference count back, which may lead to a potential stuck risk
> > > > > that the cpuhp thread deadly waits for dropping of kobject refcount when
> > > > > cpufreq policy free.
> > > > > 
> > > > > For fixing this bug, cpufreq_get_policy() is referenced to do a proper
> > > > > cpufreq_cpu_get()/cpufreq_cpu_put() and fill a policy copy for the user.
> > > > > If the policy return NULL, we just return 0 to hit the code path of
> > > > > cpufreq_driver->get.
> > > > > 
> > > > > Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> > > > > ---
> > > > >  drivers/cpufreq/brcmstb-avs-cpufreq.c | 12 ++++++++++--
> > > > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > > > > index 77b0e5d..ee0d404 100644
> > > > > --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > > > > +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > > > > @@ -452,8 +452,16 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
> > > > >  
> > > > >  static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
> > > > >  {
> > > > > -	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> > > > 
> > > > Why can't we just add a corresponding cpufreq_cpu_put() instead of all this ?
> > > > 
> > > 
> > > cpufreq_get_policy() does a proper cpufreq_cpu_get()/cpufreq_cpu_put(),
> > > meanwhile fills a policy copy for the user. It equals to using
> > > cpufreq_cpu_get() and a corresponding cpufreq_cpu_put() around access
> > > to the policy pointer. I think both methods are fine here.
> > > What do you think?
> > 
> > cpufreq_get_policy() does an extra memcpy as well, which isn't required at all
> > in your case.
> > 
> > -- 
> > viresh
> 
> Huha..Do you worry about the race conditon with cpufreq policy free path?

No. I just worry about an unnecessary memcpy, nothing else.

-- 
viresh

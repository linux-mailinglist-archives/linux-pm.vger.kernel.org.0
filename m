Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCF60142344
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 07:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgATGaK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 01:30:10 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43525 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgATGaI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 01:30:08 -0500
Received: by mail-pg1-f194.google.com with SMTP id k197so15011391pga.10
        for <linux-pm@vger.kernel.org>; Sun, 19 Jan 2020 22:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xf1QiuMf0hHigZRu4/cbzAY/tfWYTII9JMzw/Trme34=;
        b=a4KwANnE2EZL0qHoQ+SpxO0bZOErxLwdUS0tR0s7vjU16+pCr7d4tI9/7tAX0OGxeR
         3Ujo0XFEL87E+PdvBn2VRM+jsvPd2lMNk8IRvMi4wKEtsaUefWlemKt1vgyXmV/khhne
         K/u694w8gbMQGifnS1TPubDWXRqBFmXyP0iFa8VZc7u6r/pTclt0FYbOSuJzsuzWmQjX
         mO8hh8Qiy7JFvaE/M8uOtRoHwFt2PaVWVg3QOIP4XQjFZd9AwxSvxo6IRFm7rDzXbTrV
         JZl4NXasmhTp9ep6O0CWO2J2Lakjya3kwlqcOy/eJZfLYJiUkb3R3rE3xLq87vazhNi7
         wANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xf1QiuMf0hHigZRu4/cbzAY/tfWYTII9JMzw/Trme34=;
        b=lTHpS0GZMxKpujBdXV/0pMZQ/hSC0NnKwPVs/2LI2qFTQs2w+87Uac+/IWxF4lNBaH
         2ZcF4pVbGiZxGk7P0hHomY2Rxcuvu95Pz3G8CB4qerqDue4SOiXMk961tOi7cfZMN0W0
         ELe4UatKceWUn/oCQlhzSwwCcTOi/sG4ApyHLa1qz22M7mvE+7EquXom0NEElwXKdErl
         QxSrwCEOwIlpKZwgynUJLKA/vvIe2S7yEBsQfwGgG/fbIF3aEOPYp1U3JvPP5cAItCPe
         RCc6hDJngdlTAi+aH2U3CuRJJAWvOpWFQ8NkkC2rD/XOU0baODIW7M9H5JyZeQS58nN9
         9Y4Q==
X-Gm-Message-State: APjAAAVPOZrLW+gfeB7YqSrrE3H3D0WL+ptXjYeuRX/24HWGD4yclS8H
        MyyR2AsNTPkwF2SDo9+Ri/U3mg==
X-Google-Smtp-Source: APXvYqyLGxswmFQFbRVpKv/a3s/IpKKD3P/z1gJ/ntpqumpKG02JtHNzqYLPbIeBS1DTzCykmYynuw==
X-Received: by 2002:a62:1889:: with SMTP id 131mr15707948pfy.250.1579501807380;
        Sun, 19 Jan 2020 22:30:07 -0800 (PST)
Received: from localhost ([122.172.71.156])
        by smtp.gmail.com with ESMTPSA id g9sm38268658pfm.150.2020.01.19.22.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jan 2020 22:30:06 -0800 (PST)
Date:   Mon, 20 Jan 2020 12:00:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     chenqiwu <qiwuchen55@gmail.com>
Cc:     mmayer@broadcom.com, rjw@rjwysocki.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH v3] cpufreq: brcmstb-avs: fix imbalance of cpufreq policy
 refcount
Message-ID: <20200120063004.zzhep35vfl3urndd@vireshk-i7>
References: <1579417750-21984-1-git-send-email-qiwuchen55@gmail.com>
 <20200120053250.igkwofqfzvmqb3c3@vireshk-i7>
 <20200120055822.GB5185@cqw-OptiPlex-7050>
 <20200120060134.izotrbzjvzk327zx@vireshk-i7>
 <20200120061356.GA5605@cqw-OptiPlex-7050>
 <20200120062126.nmxaqhcpqcojuihr@vireshk-i7>
 <20200120062756.GA5802@cqw-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120062756.GA5802@cqw-OptiPlex-7050>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-01-20, 14:27, chenqiwu wrote:
> On Mon, Jan 20, 2020 at 11:51:26AM +0530, Viresh Kumar wrote:
> > On 20-01-20, 14:13, chenqiwu wrote:
> > > On Mon, Jan 20, 2020 at 11:31:34AM +0530, Viresh Kumar wrote:
> > > > On 20-01-20, 13:58, chenqiwu wrote:
> > > > > On Mon, Jan 20, 2020 at 11:02:50AM +0530, Viresh Kumar wrote:
> > > > > > On 19-01-20, 15:09, qiwuchen55@gmail.com wrote:
> > > > > > > From: chenqiwu <chenqiwu@xiaomi.com>
> > > > > > > 
> > > > > > > brcm_avs_cpufreq_get() calls cpufreq_cpu_get() to get the cpufreq policy,
> > > > > > > meanwhile, it also increments the kobject reference count to mark it busy.
> > > > > > > However, a corresponding call of cpufreq_cpu_put() is ignored to decrement
> > > > > > > the kobject reference count back, which may lead to a potential stuck risk
> > > > > > > that the cpuhp thread deadly waits for dropping of kobject refcount when
> > > > > > > cpufreq policy free.
> > > > > > > 
> > > > > > > For fixing this bug, cpufreq_get_policy() is referenced to do a proper
> > > > > > > cpufreq_cpu_get()/cpufreq_cpu_put() and fill a policy copy for the user.
> > > > > > > If the policy return NULL, we just return 0 to hit the code path of
> > > > > > > cpufreq_driver->get.
> > > > > > > 
> > > > > > > Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> > > > > > > ---
> > > > > > >  drivers/cpufreq/brcmstb-avs-cpufreq.c | 12 ++++++++++--
> > > > > > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > > > > > > index 77b0e5d..ee0d404 100644
> > > > > > > --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > > > > > > +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > > > > > > @@ -452,8 +452,16 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
> > > > > > >  
> > > > > > >  static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
> > > > > > >  {
> > > > > > > -	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> > > > > > 
> > > > > > Why can't we just add a corresponding cpufreq_cpu_put() instead of all this ?
> > > > > > 
> > > > > 
> > > > > cpufreq_get_policy() does a proper cpufreq_cpu_get()/cpufreq_cpu_put(),
> > > > > meanwhile fills a policy copy for the user. It equals to using
> > > > > cpufreq_cpu_get() and a corresponding cpufreq_cpu_put() around access
> > > > > to the policy pointer. I think both methods are fine here.
> > > > > What do you think?
> > > > 
> > > > cpufreq_get_policy() does an extra memcpy as well, which isn't required at all
> > > > in your case.
> > > > 
> > > > -- 
> > > > viresh
> > > 
> > > Huha..Do you worry about the race conditon with cpufreq policy free path?
> > 
> > No. I just worry about an unnecessary memcpy, nothing else.
> >
> Is there any question about this extra memcpy?

What do you mean by that?

The whole point I am trying to make is that for your specific case, doing an
explicit cpufreq_cpu_get() and cpufreq_cpu_put() is far more efficient than
calling cpufreq_get_policy() which has a different purpose and usecase.

-- 
viresh

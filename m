Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A76C130DB8
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 07:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgAFGwx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 01:52:53 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52435 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgAFGwx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 01:52:53 -0500
Received: by mail-pj1-f66.google.com with SMTP id a6so7185893pjh.2;
        Sun, 05 Jan 2020 22:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ILbtPQ49UQ5/z2fgV/Pv/NXVgfndSPVO/Z+iSzamE50=;
        b=TxRMT6EuVhwzU6EmNtGY1bRoMPFMdfiDhDdKhwErLKT61PVaGUf4J9+nhf4SPZTADG
         91+cf6E/ra/fgI7GUqbL2FSkkK1FnEnSP3nLEymeIwXACeq9bWBckwbrmab6uvLr3naJ
         XuQofEyR7tJUvoIM+tbNih5jv8iCnufHolp2GKt6CfWbLgL249AA1EFlsq27lDGTOxnx
         t7NqStB9h6OpMKiEkvSEYpKQRbi4NWZ/di/nETGVQGtQkD2OkTuRWCz/YGXP8QfanuHM
         84CnMFIhKMo+lmf8Y6D/Jy+OApz9Bkt980yDikVxbW3Zs+L4jZuIoVNfZ1Vvlmnd/1jk
         fO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ILbtPQ49UQ5/z2fgV/Pv/NXVgfndSPVO/Z+iSzamE50=;
        b=Ky2ZWvsY4CUZN3KtzBUZZaedvvqiIRMxA0xyoiPesOQJ2/nbb2H4ttGw1yBaiboPXm
         KuSb/BRdnyv6Ln8TtYpB18KmGVkbib6O1+GtWL/BGfxs2A0fzcHq4i7pObca9ZnGduDs
         sLl1EUR4NB0mnFYlzm6Vq/AjfCshXFcaFPxKQtCZa1bOXoUl2A2rkhYQlPtT09tK3W2U
         cb9AqX8ysunKAiYb7QE1cmxn1qdJbZ0pB3yMRulqaxMvKJDlJ0ZOkrje6S/ypGev0sbr
         GXez0Qzg3BqTRNtOdOkfk99Uo+q8m+dbCWNWJLFV9R5r9SBrOgNcKUByFVjL7Hc80y52
         Ylmg==
X-Gm-Message-State: APjAAAXuS5yzUNbVuzr5qdKAq3nmCqaej8uqoO5tmxhyS8BjWLgn8PC/
        NivWT8MrQ361tQCYt4N8tfrFyoY578k=
X-Google-Smtp-Source: APXvYqwOS+lopbhTJeonZU5znewHDoRirY65GOzExc1QuBLtvUvMa4G2mxAEaK1WabMcrppIQ6uaoA==
X-Received: by 2002:a17:90a:8a8f:: with SMTP id x15mr42050937pjn.87.1578293572889;
        Sun, 05 Jan 2020 22:52:52 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id q199sm77129113pfq.163.2020.01.05.22.52.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 05 Jan 2020 22:52:52 -0800 (PST)
Date:   Mon, 6 Jan 2020 14:52:49 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     kgene@kernel.org, krzk@kernel.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: s3c: avoid use after free issue in
 xxx_cpufreq_reboot_notifier_evt()
Message-ID: <20200106065249.GA16392@cqw-OptiPlex-7050>
References: <1577515439-14477-1-git-send-email-qiwuchen55@gmail.com>
 <20200106054811.uduf2qdn5ecvbwrc@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106054811.uduf2qdn5ecvbwrc@vireshk-i7>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 06, 2020 at 11:18:11AM +0530, Viresh Kumar wrote:
> On 28-12-19, 14:43, qiwuchen55@gmail.com wrote:
> > From: chenqiwu <chenqiwu@xiaomi.com>
> > 
> > There is a potential UAF issue in xxx_cpufreq_reboot_notifier_evt() that
> > the cpufreq policy of cpu0 has been released before using it. So we should
> > make a judgement to avoid it.
> 
> There is no UAF problem here, but that we do cpufreq_cpu_get() with a
> corresponding cpufreq_cpu_put().
> 
> > Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> > ---
> >  drivers/cpufreq/s3c2416-cpufreq.c | 11 ++++++++++-
> >  drivers/cpufreq/s5pv210-cpufreq.c | 10 +++++++++-
> >  2 files changed, 19 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/s3c2416-cpufreq.c b/drivers/cpufreq/s3c2416-cpufreq.c
> > index 1069103..0f576ba 100644
> > --- a/drivers/cpufreq/s3c2416-cpufreq.c
> > +++ b/drivers/cpufreq/s3c2416-cpufreq.c
> > @@ -304,6 +304,7 @@ static int s3c2416_cpufreq_reboot_notifier_evt(struct notifier_block *this,
> >  {
> >  	struct s3c2416_data *s3c_freq = &s3c2416_cpufreq;
> >  	int ret;
> > +	struct cpufreq_policy policy;
> >  
> >  	mutex_lock(&cpufreq_lock);
> >  
> > @@ -318,7 +319,15 @@ static int s3c2416_cpufreq_reboot_notifier_evt(struct notifier_block *this,
> >  	 */
> >  	if (s3c_freq->is_dvs) {
> >  		pr_debug("cpufreq: leave dvs on reboot\n");
> > -		ret = cpufreq_driver_target(cpufreq_cpu_get(0), FREQ_SLEEP, 0);
> > +
> > +		memset(&policy, 0, sizeof(policy));
> > +		ret = cpufreq_get_policy(&policy, 0);
> > +		if (ret < 0) {
> > +			pr_debug("cpufreq: get no policy for cpu0\n");
> > +			return NOTIFY_BAD;
> > +		}
> > +
> 
> This doesn't make sense to me, why don't you do cpufreq_cpu_get() and
> put() instead ?
>
Hi viresh,
I can't explain which approach is better, but I think both approaches are
effective for the situation.
By the way, there is a possibility that the cpu0 hotplug thread will call
cpufreq_policy_free() to free cpufreq policy if cpu0 hotplug failed.
I think there should be a judgement to avoid this UAF risk if necessary,
or we just do panic if cpu0's cpufreq policy is free.

> > +		ret = cpufreq_driver_target(&policy, FREQ_SLEEP, 0);
> >  		if (ret < 0)
> >  			return NOTIFY_BAD;
> >  	}
> > diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> > index 5d10030..d99b4b1 100644
> > --- a/drivers/cpufreq/s5pv210-cpufreq.c
> > +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> > @@ -555,8 +555,16 @@ static int s5pv210_cpufreq_reboot_notifier_event(struct notifier_block *this,
> >  						 unsigned long event, void *ptr)
> >  {
> >  	int ret;
> > +	struct cpufreq_policy *policy;
> >  
> > -	ret = cpufreq_driver_target(cpufreq_cpu_get(0), SLEEP_FREQ, 0);
> > +	policy = cpufreq_cpu_get(0);
> > +	if (!policy) {
> > +		pr_debug("cpufreq: get no policy for cpu0\n");
> > +		return NOTIFY_BAD;
> > +	}
> > +
> > +	ret = cpufreq_driver_target(policy, SLEEP_FREQ, 0);
> > +	cpufreq_cpu_put(policy);
> 
> Like what is done here.
> 
> Also add a blank line here.
> 
> >  	if (ret < 0)
> >  		return NOTIFY_BAD;
> >  
> > -- 
> > 1.9.1
> 
> -- 
> viresh

Thanks for your review!
Qiwu


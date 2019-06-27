Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B54557AE3
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 07:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfF0FAw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 01:00:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43638 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0FAw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 01:00:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so569043pfg.10
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2019 22:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/YjRapXiVHHJp2UfW5/xuwSZmx9+J8gT/Qvl98/+zOk=;
        b=pwz41HoH3S7t9IvWdHoKb3JfmUrrKJTNzAE3mIQi9SgJ8h2HJSf3339kEoGdRGW98i
         X91H+THErz7El9JRT1atJY2mQjYWqAPWvndezjrnd4EeWZWlJu6ZF8YXJHYox2A/k4Bx
         xrkKJpMdOns3Nmt/gLyMAk7Q3UG8f0MX8ROYTWetoP2j/uO4v3bvIbaxc61arpC35KwD
         iPVXuW1rJOj5KH7b8e1RcM/HYbu7/m3goZfoqDEwGz0vM9nwkYaBAthEmTZIolU2BITH
         V4Kc8kBB8ZxZO3216cixtL50gfVHSNSJK8coV8x9cYj1Ahz37gi24yfzVwqJfYLQ3bc9
         mu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/YjRapXiVHHJp2UfW5/xuwSZmx9+J8gT/Qvl98/+zOk=;
        b=Js/3FoIu5iNtVtSJe8aD1bpC7NzkNY+K7m5hZu17nI9SDHt+OkTL2wgsXPmViXCqmD
         PrUGi9ECiSDwzIKpTco50+UWsVnbrbyrQr9WB9/eWynVQ/RxKFDPBQBPEbyQatdySrHv
         q/wOpNftbwo0V0ufcnRNnH0mIK7s1b+eH+lVt2pRzbzAg+hXFR9WmnJHEWZtMEiHhBUI
         N/BBcBhX9OBTC7oCIW2uCUUswiVQIh3VFfJft5b9D2zGetq+IOr3G3qnMpQM2yp6sYtY
         EwzEmAO+zklP2QQwcSl6cMDByhdB2a0LVvf9oARPxtuoc0qWttGUdaoOkdA1OcGI3wg7
         Twow==
X-Gm-Message-State: APjAAAXASj0AS0dcE53Vgfrweq7P2fR+9f2DCHpkiCmIIV8LLI4bAcfZ
        /Cv36Aah6He598dt3lECdVfacg==
X-Google-Smtp-Source: APXvYqxKya2Xp2l4I1LR1Zo9cVHMJTXxBCv2Ds6UGBNzJtFoI/Sz7EBki9dV2EzzswIGEs0EvnAdnQ==
X-Received: by 2002:a63:d944:: with SMTP id e4mr1780477pgj.261.1561611651374;
        Wed, 26 Jun 2019 22:00:51 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id m100sm4159761pje.12.2019.06.26.22.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 22:00:50 -0700 (PDT)
Date:   Thu, 27 Jun 2019 10:30:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/5] cpufreq: Replace few CPUFREQ_CONST_LOOPS checks
 with has_target()
Message-ID: <20190627050048.b44kitdfuenxnzfi@vireshk-i7>
References: <cover.1560999838.git.viresh.kumar@linaro.org>
 <88da7cfabad5e19a361fe2843e5ef547d50fd221.1560999838.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88da7cfabad5e19a361fe2843e5ef547d50fd221.1560999838.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-06-19, 08:35, Viresh Kumar wrote:
> > CPUFREQ_CONST_LOOPS was introduced in a very old commit from pre-2.6
> > kernel release commit 6a4a93f9c0d5 ("[CPUFREQ] Fix 'out of sync'
> > issue").
> > 
> > Probably the initial idea was to just avoid these checks for set_policy
> > type drivers and then things got changed over the years. And it is very
> > unclear why these checks are there at all.
> > 
> > Replace the CPUFREQ_CONST_LOOPS check with has_target(), which makes
> > more sense now.
> > 
> > cpufreq_notify_transition() is only called for has_target() type driver
> > and not for set_policy type, and the check is simply redundant. Remove
> > it as well.
> > 
> > Also remove () around freq comparison statement as they aren't required
> > and checkpatch also warns for them.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq.c | 13 +++++--------
> >  1 file changed, 5 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 54befd775bd6..41ac701e324f 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -359,12 +359,10 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
> >  		 * which is not equal to what the cpufreq core thinks is
> >  		 * "old frequency".
> >  		 */
> > -		if (!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
> > -			if (policy->cur && (policy->cur != freqs->old)) {
> > -				pr_debug("Warning: CPU frequency is %u, cpufreq assumed %u kHz\n",
> > -					 freqs->old, policy->cur);
> > -				freqs->old = policy->cur;
> > -			}
> > +		if (policy->cur && policy->cur != freqs->old) {
> > +			pr_debug("Warning: CPU frequency is %u, cpufreq assumed %u kHz\n",
> > +				 freqs->old, policy->cur);
> > +			freqs->old = policy->cur;
> >  		}
> >  
> >  		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
> > @@ -1618,8 +1616,7 @@ static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
> >  	if (policy->fast_switch_enabled)
> >  		return ret_freq;
> >  
> > -	if (ret_freq && policy->cur &&
> > -		!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
> > +	if (has_target() && ret_freq && policy->cur) {
> >  		/* verify no discrepancy between actual and
> >  					saved value exists */
> >  		if (unlikely(ret_freq != policy->cur)) {

@Rafael: Here are your comments from the IRC exchange we had
yesterday:

> <rafael>:
> 
> so the problem is that, because of the CPUFREQ_CONST_LOOPS check in
> __cpufreq_get(), it almost never does the cpufreq_out_of_sync() thing
> now. Because many drivers set CPUFREQ_CONST_LOOPS most of the time,
> some of them even unconditionally. This patch changes the code that
> runs very rarely into code that runs relatively often.

Right, we will do the frequency verification on has_target() platforms
with CPUFREQ_CONST_LOOPS set after this patch. But why is it the wrong
thing to do ?

What we do here is that we verify that the cached value of current
frequency is same as the real frequency the hardware is running at. It
makes sense to not do this check for setpolicy type drivers as the
cpufreq core isn't always aware of what the driver will end up doing
with the frequency and so no verification.

But for has_target() type drivers, cpufreq core caches the value with
it and it should check it to make sure everything is fine. I don't see
a correlation with CPUFREQ_CONST_LOOPS flag here, that's it. Either we
do this verification or we don't, but there is no reason (as per my
understanding) of skipping it using this flag.

So if you look at the commit I pointed in the history git [1], it does
two things:
- It adds the verification code (which is quite similar today as
  well).
- And it sets the CPUFREQ_CONST_LOOPS flag only for setpolicy drivers,
  rightly so.

The problem happened when we started to use CPUFREQ_CONST_LOOPS for
constant loops-per-jiffy thing as well and many has_target() drivers
started using the same flag and unknowingly skipped the verification
of frequency.

So, I think the current code is doing the wrong thing by skipping the
verification using CPUFREQ_CONST_LOOPS flag.

-- 
viresh

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=6a4a93f9c0d51b5f4ac1bd3efab53e43584330dd

Return-Path: <linux-pm+bounces-4309-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3148F860714
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 00:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8301C22513
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 23:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C6A13BAE7;
	Thu, 22 Feb 2024 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="itOF+Zcl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A34613792D
	for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 23:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708645193; cv=none; b=ZF8aEdxKHTsB97eyCXgfPKFiXccUe8gazWwJgtaWbYVmNV5A69gwUmXrOhpxnOwqbR6rO3UEQ911mHsURNj6P81jjC9jWknMyAO3zD/VgBLOg7NHvzblF9bZiQ0xZznP8KnbaT8vwqzA43cLo9YwN47mtl/jFzx+AqU/l3Wtixc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708645193; c=relaxed/simple;
	bh=k/T+MWitDhRoKFA0RmTLMBPwet2/JnsHLf8BjORtpZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAKLFAnDLsWghii0prDY1E7fSLKgRu7er8daRGAI3xBdobJQP6P2sZluBTpze2m5/+gHpGDEMWquJXnMah8eLBsVtoo0Lu2vhLjFgs/pcMufpJEt5hi+MUnYWnOLEqeL7qzZYo6iCQBZXoRHf4D8A0WNvO+nSA1JSHazoeWO0rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=itOF+Zcl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41291355cb4so1423765e9.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 15:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708645189; x=1709249989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8w8G1a8Y4HlJfHccqFgYT1HVBWLDDvx3WA7xBJKUAJ0=;
        b=itOF+Zclpp1oESZ8wbMh7wGVW1lH+ycY5b6yFkXHcUphCt/Uoi9Ieec6x6U5dw/i5S
         bnIQYJeVqZLVxAvLtcp/t3RUJImWRAFGpg76COh5gq9DxaTWfHDHJiE3zw4H4OrFhSgD
         R3YoGaj6G1XhRY+viTq4/+1CVblAdN0KztL9d6uDES/rRdqPePbKU6n8BXvz5DtEWDe+
         SCgsruaNwn9bH3lOtjPphGNqodAB31CDROPc1AWMxW68UPplJDHUQoe6fseZiCWbYxC8
         0FCYeKI/HN0SWDw2M34gXYTGY0+yOgEXZqmkNMCpxxOEaiUiKNnyXMj0BQE20zTvawdq
         dUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708645189; x=1709249989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8w8G1a8Y4HlJfHccqFgYT1HVBWLDDvx3WA7xBJKUAJ0=;
        b=mJ40YPwd544Mgs9x8si294JCxw82syMEyljUwwb/B2WXA9pYpQJ8MijIft/ztDVpC5
         itmnk3q6SADncTcE9p9ZDXq4cqQVrqJi/5tIveStIyDFguWQieWg3I0qLoQm/UiLEO9O
         1tbqmtvs0nSrINhKwhDV5Njle/J2dlzCRpxzt+okmNPKm+FS6d06m0k+SesLzTkXAPlm
         8gcXGCvoY1igRxg/SEe5SCcWZK+0xXG2S28hPPkDeWUIHuNOeGInyOIxxnYrCmIzl6qb
         J1vVIZy68yAo7+/7WOvkGcSxFZybdpBTeKkKsu3eccrHqOIl23Zwqt4Ddzeu8lotIpU+
         tcOw==
X-Forwarded-Encrypted: i=1; AJvYcCVVWemkzDdgBkp2omUhU0JxAtYp8Y9q69PPEPbhzhUG4yzKb2PxIwh2pENC+o1jg9JVuTPqdzFIxkmOYg4rbFNk2b5zLKMSI9c=
X-Gm-Message-State: AOJu0YyGZNdawM2aNiktyBIcpDzrvZVUH8K8D8IpIi6p/Z7P4a8Rwxbr
	oWNMDPhvaILf/pT1POdag92xUvVbAFVbAk7K8KvwmNhFAlqoC9pq4eMlDB2Uh5c=
X-Google-Smtp-Source: AGHT+IEy0EI8YStg0v9f2MbRg2VpNvuWIDZJWXNTQ7pCGm2FkfhhkqEdz31SKMWI+8MaE83zQGJcjg==
X-Received: by 2002:adf:fc8f:0:b0:33d:76a9:89ae with SMTP id g15-20020adffc8f000000b0033d76a989aemr320430wrr.12.1708645189394;
        Thu, 22 Feb 2024 15:39:49 -0800 (PST)
Received: from airbuntu (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id d5-20020a5d4f85000000b0033d9ee09b7asm500683wru.107.2024.02.22.15.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:39:48 -0800 (PST)
Date: Thu, 22 Feb 2024 23:39:47 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Christian.Loehle@arm.com
Subject: Re: [PATCH] cpufreq: Change default transition delay to 2ms
Message-ID: <20240222233947.sl435tvhhpe5iqzw@airbuntu>
References: <20240205022500.2232124-1-qyousef@layalina.io>
 <20240205074514.kiolurpounokalum@vireshk-i7>
 <CAJZ5v0j2rA-+Jpdv6OZ_ymiqh0+RGzmJBNncKGBwuxO3PxgSKA@mail.gmail.com>
 <ca000b2d-b552-43cb-8807-0a5f1450c6a2@arm.com>
 <20240220135037.qriyapwrznz2wdni@airbuntu>
 <d58de550-0ce1-4af9-9e2d-dedd5e73c797@arm.com>
 <20240222115557.blnm4uulkxnorrl4@airbuntu>
 <f4c3f028-b93e-4658-af28-ac2123203d68@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f4c3f028-b93e-4658-af28-ac2123203d68@arm.com>

On 02/22/24 16:15, Pierre Gondois wrote:

> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 66cef33c4ec7..68a5ba24a5e0 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -576,6 +576,15 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
> > 
> >          latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
> >          if (latency) {
> > +               unsigned int max_delay_us = 2 * MSEC_PER_SEC;;
> > +
> > +               /*
> > +                * If the platform already has high transition_latency, use it
> > +                * as-is.
> > +                */
> > +               if (latency > max_delay_us)
> [1]  return min(latency, 10ms);
> > +                       return latency;
> > +
> >                  /*
> >                   * For platforms that can change the frequency very fast (< 10
> >                   * us), the above formula gives a decent transition delay. But
> > @@ -586,7 +595,7 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
> >                   * a reasonable amount of time after which we should reevaluate
> >                   * the frequency.
> >                   */
> > -               return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2 * MSEC_PER_SEC));
> > +               return min(latency * LATENCY_MULTIPLIER, max_delay_us);
> >          }
> > 
> >          return LATENCY_MULTIPLIER;
> > 
> 
> A policy with these values:
> - transition_delay_us = 0
> - transition_latency = 30ms
> would get a transition_delay of 30ms I think.
> 
> Maybe it would be better to default to the old value in this case [1].

Hmm. I think it wouldn't make sense to have 2 levels of capping. It's either we
cap to 2ms, or honour the transition latency from the driver if it is higher
and let it lower it if it can truly handle smaller values?

Rafael, should I send a new version of the patch, a new patch on top or would
you like to take a fixup if you can amend the commit? If you and Viresh think
the two levels of capping make sense as suggested above let me know. I think
better to delegate to the drivers if they report transition_latency higher than
2ms.

-->8--

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 66cef33c4ec7..668263c53810 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -576,8 +576,17 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
 
        latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
        if (latency) {
+               unsigned int max_delay_us = 2 * MSEC_PER_SEC;;
+
+               /*
+                * If the platform already has high transition_latency, use it
+                * as-is.
+                */
+               if (latency > max_delay_us)
+                       return latency;
+
                /*
-                * For platforms that can change the frequency very fast (< 10
+                * For platforms that can change the frequency very fast (< 20
                 * us), the above formula gives a decent transition delay. But
                 * for platforms where transition_latency is in milliseconds, it
                 * ends up giving unrealistic values.
@@ -586,7 +595,7 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
                 * a reasonable amount of time after which we should reevaluate
                 * the frequency.
                 */
-               return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2 * MSEC_PER_SEC));
+               return min(latency * LATENCY_MULTIPLIER, max_delay_us);
        }
 
        return LATENCY_MULTIPLIER;

-->8--

> 
> ---
> 
> Also a note that on the Pixel6 I have, transition_latency=5ms,
> so the platform's policies would end up with transition_delay=5ms

Yes I know. But at this stage it's a driver issue. I think this value is not
correct and there's a typo.

> 
> 
> > > 
> > > 
> > > 2.
> > > There are references to the 10ms values at other places in the code:
> > > 
> > > include/linux/cpufreq.h
> > >   * ondemand governor will work on any processor with transition latency <= 10ms,
> > 
> > Not sure this one needs updating. Especially with the change above which means
> > 10ms could theoretically happen. But if there are suggestions happy to take
> > them.
> 
> a.
> LATENCY_MULTIPLIER introduction:
> 112124ab0a9f ("[CPUFREQ] ondemand/conservative: sanitize sampling_rate restrictions")
> 
> b.
> max_transition_latency removal:
> ed4676e25463 ("cpufreq: Replace "max_transition_latency" with "dynamic_switching"")
> 
> c.
> dynamic_switching removal:
> 9a2a9ebc0a75 ("cpufreq: Introduce governor flags")
> 
> The value could be removed independently from this patch indeed, as this is not
> related to cpufreq_policy_transition_delay_us() since b.

Thanks for sending the patch.

> 
> 
> > 
> > > 
> > > drivers/cpufreq/cpufreq.c
> > >   * For platforms that can change the frequency very fast (< 10
> > >   * us), the above formula gives a decent transition delay. But
> > > -> the 10us value matches 10ms = 10us * LATENCY_MULTIPLIER
> > 
> > I can't find this one.
> 
> It's in cpufreq_policy_transition_delay_us(),
>   "the 10us value matches 10ms = 10us * LATENCY_MULTIPLIER"
> is a sentence I wrote, the comment to modify would be:
> """
> * For platforms that can change the frequency very fast (< 10
> * us), the above formula gives a decent transition delay. But
> """

Ah you were referring to s/10/20/. Done.

> 
> > 
> > > 
> > > Documentation/admin-guide/pm/cpufreq.rst
> > >   Typically, it is set to values of the order of 10000 (10 ms).  Its
> > >   default value is equal to the value of ``cpuinfo_transition_latency``
> > 
> > I am not sure about this one. It refers to cpuinfo_transition_latency not the
> > delay and uses a formula to calculate it based on that.
> > 
> > Seems the paragraph needs updating in general to reflect other changes?
> 
> aa7519af450d ("cpufreq: Use transition_delay_us for legacy governors as well")
> 
> The cpufreq_policy_transition_delay_us() was introduced there and integrates the
> 10ms value related to this paragraph.
> 
> ---
> 
> I assume that if we keep the 10ms value in the code, it should be ok to let
> the comment as is. I'll send a patch to remove the first one as it can be
> done independently.

Thanks!

--
Qais Yousef


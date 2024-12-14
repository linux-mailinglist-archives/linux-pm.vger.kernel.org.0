Return-Path: <linux-pm+bounces-19232-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1BB9F1C1F
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2024 03:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B554F1618DF
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2024 02:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF20B101DE;
	Sat, 14 Dec 2024 02:35:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0693323AD;
	Sat, 14 Dec 2024 02:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734143748; cv=none; b=HoEAmi5MX+MoJN4/EGGrlhj24XKD597636skRmQ9WSWD7It3pG7YJHtYVrQYyhCKxM5BiEhDPaufHxaRh3QbjE8wFVtRFmWeB5QzmDwq+4SnUKtwLG7iUjeFeQx0caalcGXNUXV5x8sQjKYzmZaXoN+AXeyiDl3oyw7HWSW/Bf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734143748; c=relaxed/simple;
	bh=4wqap3t1XSWLu8ztdQ7Cu8789k+uDEU+NcHW1Y8XLuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOMXC4OaDuOlYjpMQ2VSPYMM8dG+jNLD1qPRY6IwvjyzMTFNr1g9CPUceowCuvy9qTuTkbnvpf0oBviZ/wwD0VWAw6/fGhcBwhP8vnSsHRp0vUE3U/jeHzsMEnmiulanLJbeSh8GWGVIyzIIazslRyBkz+DhkiIqS3J5rTDhMIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so1764844a12.0;
        Fri, 13 Dec 2024 18:35:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734143746; x=1734748546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPRhjEJVxQTQSLdLSuZF+NUxMFxgovEYaBdCXHPfWoc=;
        b=PxkK1S8S5VjgRp2h9sCKk/UuEogru7TxYFZHiy9ErEqr1ysU04vA1k0uZxSQ2b/Qc7
         5bdSkEKNHXjKgFB/8vhEgVKyIdX/+BGWzrwufbzdUv5MccG+tRrhwTk8L3WgzVY4y7hp
         MOWzkxspLQ8xXeTmCq+j0T1W9SbzvGkVsp2F1KY9eciD9S0H0I3Fc0QGsaCsdlfi6jDq
         xresfCN+jM4iThmzIg30IjrFbiYKzgIJ0/HaKN4s0ugDDXEA991nQoYnKUTN1OPEb3hL
         rROMlcTXBo8E6pMyiCG+co0NFGlZKAnWkdLXkkl3XfV9W47mmgC+MZLYS0ji81EmvVBQ
         ybhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ0oMNKnZACnKBLR2yFrkLWKyCtQfehu/jMbz86zIMU73FKpyfBvNBY28//+grZSWlasO47sWV7MQ=@vger.kernel.org, AJvYcCWG2VI5aSi/xyAG9sh0vADDuqk9bcWnGfKgRcfdhEbXIUi+VUXcpdn56zyRZYwoA9Sjgx3mOBfy+us2m7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9mHaaEx54kUoUt/xxitaxv0Ab9x7pVRGKOI8ONMgawIKY400y
	g8/bWCbLJulKH5YDjdeWBVtzZRjMaVo1+wMehhED3Xr4tA136Yvupij+g20b
X-Gm-Gg: ASbGncsy1rRYnHrpHXTWx3tPUNfjo7i9UyjRQPg6uHiX5qUGQ5puy8oUtikYmQQOBlg
	cWImTh1OG4dw4Tw6aB6zalRuZv4PZsl3DwBUEW4/4nnMKm15RyVuE56CIXddYxxL6ta5U2sbUzY
	BfAHUue4hcoTQx3hfaOxPif4oklFUaLqhqH7A0VAphjIACRfHCLj6K/N0AZduBto4QWLbHWnv4n
	dpQhpaAUl4+RaSHQFJnlMUaIk7MeME7mQNVhI8Agr0pf7tNsLAh8VxdqHBfPFN+aRECmtUmZFA=
X-Google-Smtp-Source: AGHT+IHxR7O4ws5JgiDlhLRgvzI0NMOJdvjjQoVfbkd0GPtBPu+2RIHPfLAM2ibiKTPZXKZpNkfSRQ==
X-Received: by 2002:a17:90b:3b48:b0:2ee:7415:4768 with SMTP id 98e67ed59e1d1-2f28fd6f5c1mr8909669a91.17.1734143746232;
        Fri, 13 Dec 2024 18:35:46 -0800 (PST)
Received: from sultan-box.localdomain ([142.147.89.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a1e9dfa1sm557652a91.20.2024.12.13.18.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 18:35:45 -0800 (PST)
Date: Fri, 13 Dec 2024 18:35:42 -0800
From: "Sultan Alsawaf (unemployed)" <sultan@kerneltoast.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: schedutil: Fix superfluous updates caused
 by need_freq_update
Message-ID: <Z1zu_nDQcik0cZLx@sultan-box.localdomain>
References: <20241212015734.41241-1-sultan@kerneltoast.com>
 <20241212015734.41241-2-sultan@kerneltoast.com>
 <79448239-86df-43ef-9a4f-717802d2c70a@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79448239-86df-43ef-9a4f-717802d2c70a@arm.com>

On Thu, Dec 12, 2024 at 01:24:41PM +0000, Christian Loehle wrote:
> On 12/12/24 01:57, Sultan Alsawaf wrote:
> > From: "Sultan Alsawaf (unemployed)" <sultan@kerneltoast.com>
> > 
> > A redundant frequency update is only truly needed when there is a policy
> > limits change with a driver that specifies CPUFREQ_NEED_UPDATE_LIMITS.
> > 
> > In spite of that, drivers specifying CPUFREQ_NEED_UPDATE_LIMITS receive a
> > frequency update _all the time_, not just for a policy limits change,
> > because need_freq_update is never cleared.
> > 
> > Furthermore, ignore_dl_rate_limit()'s usage of need_freq_update also leads
> > to a redundant frequency update, regardless of whether or not the driver
> > specifies CPUFREQ_NEED_UPDATE_LIMITS, when the next chosen frequency is the
> > same as the current one.
> > 
> > Fix the superfluous updates by only honoring CPUFREQ_NEED_UPDATE_LIMITS
> > when there's a policy limits change, and clearing need_freq_update when a
> > requisite redundant update occurs.
> > 
> > This is neatly achieved by moving up the CPUFREQ_NEED_UPDATE_LIMITS test
> > and instead setting need_freq_update to false in sugov_update_next_freq().
> >
> 
> Good catch!
> Fixes:
> 600f5badb78c ("cpufreq: schedutil: Don't skip freq update when limits change")
> 
> 
> > Signed-off-by: Sultan Alsawaf (unemployed) <sultan@kerneltoast.com>
> 
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Thanks for the review and digging up the bug provenance!

> > ---
> >  kernel/sched/cpufreq_schedutil.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 28c77904ea74..e51d5ce730be 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -83,7 +83,7 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> >  
> >  	if (unlikely(sg_policy->limits_changed)) {
> >  		sg_policy->limits_changed = false;
> > -		sg_policy->need_freq_update = true;
> > +		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);>  		return true;
> >  	}
> >  
> > @@ -96,7 +96,7 @@ static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
> >  				   unsigned int next_freq)
> >  {
> >  	if (sg_policy->need_freq_update)
> > -		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> > +		sg_policy->need_freq_update = false;
> >  	else if (sg_policy->next_freq == next_freq)
> >  		return false;
> 
> I guess you could rewrite this into just one if like
> 
> ---
> 
> 	if (sg_policy->next_freq == next_freq && !sg_policy->need_freq_update))
> 		return false;
> 
> 	sg_policy->need_freq_update = false
> 	sg_policy->next_freq = next_freq;
> 	sg_policy->last_freq_update_time = time;

Hmm, asm seems worse since it adds an extra store to one of the branch targets:

Before:
-------
        00100020 e3 03 00 aa     mov        x3,x0
        00100024 00 a8 43 39     ldrb       w0,[x0, #0xea]
        00100028 3f 23 03 d5     paciasp
        0010002c c0 00 00 36     tbz        w0,#0x0,LAB_00100044
        00100030 7f a8 03 39     strb       wzr,[x3, #0xea]
                             LAB_00100034
        00100034 20 00 80 52     mov        w0,#0x1
        00100038 61 14 00 f9     str        x1,[x3, #0x28]
        0010003c 62 38 00 b9     str        w2,[x3, #0x38]
        00100040 ff 0b 5f d6     retaa
                             LAB_00100044
        00100044 64 38 40 b9     ldr        w4,[x3, #0x38]
        00100048 9f 00 02 6b     cmp        w4,w2
        0010004c 41 ff ff 54     b.ne       LAB_00100034
        00100050 ff 0b 5f d6     retaa

After:
------
        00100020 e3 03 00 aa     mov        x3,x0
        00100024 00 38 40 b9     ldr        w0,[x0, #0x38]
        00100028 3f 23 03 d5     paciasp
        0010002c 1f 00 02 6b     cmp        w0,w2
        00100030 c0 00 00 54     b.eq       LAB_00100048
                             LAB_00100034
        00100034 20 00 80 52     mov        w0,#0x1
        00100038 61 14 00 f9     str        x1,[x3, #0x28]
        0010003c 62 38 00 b9     str        w2,[x3, #0x38]
        00100040 7f a8 03 39     strb       wzr,[x3, #0xea]
        00100044 ff 0b 5f d6     retaa
                             LAB_00100048
        00100048 60 a8 43 39     ldrb       w0,[x3, #0xea]
        0010004c 40 ff 07 37     tbnz       w0,#0x0,LAB_00100034
        00100050 ff 0b 5f d6     retaa

Sultan


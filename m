Return-Path: <linux-pm+bounces-34272-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A05D9B4FE9C
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 16:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972791B2471D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 14:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC972274FFD;
	Tue,  9 Sep 2025 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FO7/zetR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEC32356BA
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426583; cv=none; b=irbcQJpYa7lBhR/bVvdlmNMX11C6yXy8BH8KHk4t7vG7kklBomVkvjJopggAmCCrnAJBkzzi/lyyysfpeqt1Rr1Kmrl3t6sqRUHV+E6qsinWsW/ZThXaMLW2J9vR40KECq63x04u/J39wBoaVeL4DIp9K6CWDOKNj+8tC0BcB00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426583; c=relaxed/simple;
	bh=f3OQr5ANjsIOmReaa3CIYDHS7pK1RQLPMaap5l+Pb/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqrYswlX4LUJIjeHq+d+lpQpuThNTFF5Ae0fzRO4FpAXspxlWkQu9Yqoe1rjo6jEmM8yWEa/V3RFS5J6knHamwU+wnG0ZNB0JyfCUJ4e1Es0dE/QmA5hAh0S15DVW0HOjInOsd4OMdEfqnKRFPvgmlChSAbsm2tyDhFgXrOoolI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FO7/zetR; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b0472bd218bso868306266b.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2025 07:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757426580; x=1758031380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2BUW5/LW9jOJBAxRiEK/kGmWkiKeTyE9r4ygtNRhhTU=;
        b=FO7/zetROOYuHxdKIDiv5NUDRORpMDMt+lbp/VrFqUPmn/FCgFiIWIAXdyP2Q5+S48
         6RQFWqoRJTe7+8yS2lyI5PD4mbCpZdxFmnqtdAaseNzLo3z8nz9cuWyPC6/jXOU1vV2y
         QCOhmZY9VG+5ChILbLjU0Q3JxTtvurJ75tHkfZfV7ShRKxOyQD25B6WwCjOtoOM1NClz
         etv0LeApKweoiYZ1Am96LEG9ob/Ei3AXAq/rSYrTZANdBcDyqDg/tPXRypvCLA1PjZ1y
         7JmpCDYdCzt83NXN6OpsD+yUSwSpxsT4EZ3PDjriM0X5RHrW8ho9bKNFRB1//PBkCI4n
         UMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757426580; x=1758031380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BUW5/LW9jOJBAxRiEK/kGmWkiKeTyE9r4ygtNRhhTU=;
        b=gVDGkfdIW4jDBNVSlQ0LHeeH94+Gh/Ssk8Ctk0BHjirz1CqxFA3DmZMGXeS7AW8vME
         4reTsPK2put2wFoIYda5YAmiPoo+WagAQ8BRrID83g2IVtG2kDYGkjvKwWm4uPCPiark
         lNkaQfXOh2QNXH5s8hYsKqAdtzzWRSpL0cuXBoXvBn2QHajEKaocbSf7JYsnIHsGPFD+
         XkBYMugRZgqW4PsGYT5HdVMonwo99nokd7TuLNbWAH4t69FwfMZJymJbLvFcwJZjlxak
         YwUQSYe0yM08AOfXyl8px4irIlSPnIC9WHpSlJQhYHKhlxx11wpbRmDCyD4TlO+fqL/r
         ge2w==
X-Forwarded-Encrypted: i=1; AJvYcCUW9On8tnbz7iuyJfEo3iGdW/Jk1VGthE0X0j3Ufn0Jh1LAhktVvsx8ZwHRZCmaMIT2WSRADos/sg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqf7ZYWo/+zKV/yux4VR3R11Yu4EKnmzhpWYzpDAfit7E4/LxM
	cyKoyM9Ykd6TV/uJ6pi8V/9oyYZPjK+GdIv8uzm34ZO0eKFr2TsaXcqP/HhZOByNAx4=
X-Gm-Gg: ASbGnctTBsapvR+zNCRyCBe0Eh0P8aP9iAq5HywVoeTDTxI3KXgHSlGjQaSZksiBJK5
	de4yGuDRysCxREJnSajEPfmj2kMsayJQ/dL+ZqxPTp4ilm3XHP7trjA5atwXjilUbQpWiQYtSsj
	z+qwZqs6SYwRsycdqIl8+0Ow0fdX1Q9BRaa7dmVrC1Ds7i8VYpPluporRh/k13i+IBlmyatKuss
	eBu8Nor9Ii3A7BfJOCwlKQL+MtBo89AY1JMXJiq4ju0dLFRQHE6DQydvSsc16X4BaMuFRpJm0TI
	DyUhh/Ytjql67bDen1A/V869bGJytr3mTJw5DvDhpsIq/Y9ix2x5D3M7Fkq1kyhHwXPHP0UShmF
	bfFrFbefSoc35L7zuATNcdq5bpLSjxlYfBA==
X-Google-Smtp-Source: AGHT+IEcXOauWERSVTDc/oyeBPYo40tn1vR1+fr4Fma7wkicQf7mx/quHveASuxtVY4qRP9qxAuU+Q==
X-Received: by 2002:a17:906:6a04:b0:b04:5bc2:3246 with SMTP id a640c23a62f3a-b04b140cc26mr1306728766b.14.1757426579751;
        Tue, 09 Sep 2025 07:02:59 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aff0a591819sm2633577366b.41.2025.09.09.07.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:02:59 -0700 (PDT)
Date: Tue, 9 Sep 2025 16:02:57 +0200
From: Michal Hocko <mhocko@suse.com>
To: zhongjinji <zhongjinji@honor.com>
Cc: akpm@linux-foundation.org, feng.han@honor.com, lenb@kernel.org,
	liam.howlett@oracle.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pm@vger.kernel.org, liulu.liu@honor.com,
	lorenzo.stoakes@oracle.com, pavel@kernel.org, rafael@kernel.org,
	rientjes@google.com, shakeel.butt@linux.dev, surenb@google.com,
	tglx@linutronix.de
Subject: Re: [PATCH v8 1/3] mm/oom_kill: Introduce thaw_oom_process() for
 thawing OOM victims
Message-ID: <aMAzkQQ4XAFh9xlm@tiehlicka>
References: <aMAWvwQ3eJZH55mp@tiehlicka>
 <20250909135152.20477-1-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909135152.20477-1-zhongjinji@honor.com>

On Tue 09-09-25 21:51:52, zhongjinji wrote:
> > On Tue 09-09-25 19:41:31, zhongjinji wrote:
> > > > On Tue 09-09-25 17:06:57, zhongjinji wrote:
> > > > > OOM killer is a mechanism that selects and kills processes when the system
> > > > > runs out of memory to reclaim resources and keep the system stable.
> > > > > However, the oom victim cannot terminate on its own when it is frozen,
> > > > > because __thaw_task() only thaws one thread of the victim, while
> > > > > the other threads remain in the frozen state.
> > > > > 
> > > > > Since __thaw_task did not fully thaw the OOM victim for self-termination,
> > > > > introduce thaw_oom_process() to properly thaw OOM victims.
> > > > 
> > > > You will need s@thaw_oom_process@thaw_processes@
> > > 
> > > The reason for using thaw_oom_process is that the TIF_MEMDIE flag of the
> > > thawed thread will be set, which means this function can only be used to
> > > thaw processes terminated by the OOM killer.
> > 
> > Just do not set the flag inside the function. I would even say do not
> > set TIF_MEMDIE to the rest of the thread group at all. More on that
> > below
> > 
> > > thaw_processes has already been defined in kernel/power/process.c.
> > > Would it be better to use thaw_process instead?
> > 
> > Sorry I meant thaw_process as thaw_processes is handling all the
> > processes.
> > 
> > > I am concerned that others might misunderstand the thaw_process function.
> > > thaw_process sets all threads to the TIF_MEMDIE state, so it can only be
> > > used to thaw processes killed by the OOM killer.
> > 
> > And that is the reason why it shouldn't be doing that. It should thaw
> > the whole thread group. That's it.
> >  
> > > If the TIF_MEMDIE flag of a thread is not set, the thread cannot be thawed
> > > regardless of the cgroup state.
> > 
> > Why would that be the case. TIF_MEMDIE should only denote the victim
> > should be able to access memory reserves. Why the whole thread group
> > needs that? While more threads could be caught in the allocation path
> > this is a sort of boost at best. It cannot guarantee any forward
> > progress and we have kept marking only the first thread that way without
> > any issues.
> 
> When a process is frozen, all its threads enter __refrigerator() (in kernel/freezer.c). 
> When __thaw_task is called, the threads are woken up and check the freezing(current) 
> state (in __refrigerator). The freezing check is implemented via freezing_slow_path. 
> When TIF_MEMDIE is set for a thread, freezing_slow_path will return false, allowing 
> the thread to exit the infinite loop in __refrigerator(), and thus the thread will 
> be thawed.
> 
> The following code can explain how TIF_MEMDIE works in thread thawing.
> __refrigerator
>   for (;;) {
>     freezing = freezing(current)
>       freezing_slow_path
>         if (test_tsk_thread_flag(p, TIF_MEMDIE))
>           return false;
>     if (!freezing)
>       break;
>     schedule();
>   }

OK, I see. We could deal with that by checking tsk_is_oom_victim()
instead of TIF_MEMDIE

> Since thread_info is not shared within a thread group, TIF_MEMDIE for each thread  
> must be set so that all threads can be thawed.

-- 
Michal Hocko
SUSE Labs


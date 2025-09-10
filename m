Return-Path: <linux-pm+bounces-34379-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE17B51B42
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 17:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97727466DB2
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 15:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0482248B8;
	Wed, 10 Sep 2025 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LSl3GRTo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E8A15E5D4
	for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517321; cv=none; b=TikgyOouWtHJvGHlONeuYOOsbONbm9BCcgSU5MxN3LflXZ1So63Ykl8rLzzm/TQZMiLO2HYoxZbrFJLv+sBbhcPDMiRJ9XfGfW+JKmYSDygiMF3UBZkWUMGreuwoQFGNVNQVwAeIhs2iv2yKtddb7U1by8HSFh7RsVvFBni9Ls4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517321; c=relaxed/simple;
	bh=pTOXJL+Dx+SHQZMWlgXyxQlkmZPMmURfn7k+Jj1t5qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzWZKSQ18fxNz8VXjioh74sltTH7BidpqGThrsklZJT9A75Y8bki1fKtYMJ6+TsYAWrZk1XL7HoEb8yJvy8xKeoihJRx9KAbpU0NHgMnuUmhpkELq8KRv2/w3RbBOZ8v/S1zSD7mBjx7SczH5cKtVVgILhQvrOKWGRql/qN7Izw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LSl3GRTo; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b045d56e181so1036475766b.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757517318; x=1758122118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mO4BXqgIRoVXuE8zMomfonqu7ftxdJy1svObtMu/mjo=;
        b=LSl3GRTo6twqXurlTOzY9u7wA72iTAPxHw2aQMBs/kf9H0dRZa67kXrIoFOIHC9uDD
         aPmygUcDhwrELktXx+wJbTmVn4tAsJuA1WUU/h9zZ40lp97wUQapRC2EySozhTKbjRLQ
         +T4vhNo2DjfpPgmEhcHOcxZ+duZHNcHjczzOP2Eneaszj2zuWH+ljNMX95nkAos4ULzZ
         WoOEtoNftkOgWOt72+ZhCoBwldkmsVreoD6fkAKQN+Yk5O9VL0XX0uIQhPUjWloRvTRu
         s0Wa/ZnRpd5Icsf4q61y1zt/2yhRpwqlda/xbObmuC2HCWWN736x51d4q394NW6W97sd
         9jNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757517318; x=1758122118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mO4BXqgIRoVXuE8zMomfonqu7ftxdJy1svObtMu/mjo=;
        b=v2boP4xg7x872+CDYsWGurTsSyBrkp+uCS/OYZr4lred96ZcBnEkPGPMt7WGSaNlLY
         aRxedEkgJYwXsGTAwEMIeArUTOAtfuhQR50e3tdvbkcS8My6ftwVJyuJw1JZf8VpeblJ
         9m40lhCBheyZTPUq+d+R2BzqFQQtSAC4ZXRkx/49muCJWhQ7tddhZhKSZ244REMKSgAY
         ZmCWAgT2kSYVkI5kl4LBY/XH3jtmsELW0n4TDbBe9Rthk5HIVvxH6M6Es7aCH4tTtxd1
         pE6mAExPSUX42ODNhPDmRHyDJbS0DjqUEfLzRgBicZYPBiJrWufyqzX1WmbGX7hAu/gA
         6DCA==
X-Forwarded-Encrypted: i=1; AJvYcCUgYb8r+OK09FSCedjDVqu+MQnHraz2klHtfOESczJxRs88wmPC3gHJa570k8lNjpimac3KdpE/eA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXIljwly6+uAV4ICRwUf9FhJO4dIcX55Pglr+WtQlQP2cbnOnN
	5oVQ7FUKnnBFIWBZpKtJDbBV6ExnCkH8gdKLMiHH4s3TSyMNzPA4qYNiWghepMnnWp4=
X-Gm-Gg: ASbGnctG0GY9Y8dsS3kls2fb9h51oYCQ7sbfenmF04YdvC/qj3d/SpzxavSYctlYzz7
	do++xT0HRlX5bhn1eQlSdLO0EGWkoosp//VdTstdkFt1sgYbvbp9Lseie2StGRyOM/X5ZYY4kjQ
	leOWy3Qq+4So/+LjUFafFimrnW+8GXfK8lMBNH/SouqUrl1QY5AMu6D7Q2kCfX/Qk1V59xU1+hM
	KU4yoJaBEJ16RhNn4EOEqfBo6MZRKheFxGZsGewGLbbazdG/oi91Fp/m8Y8rWxPQxoOyyaI60K8
	ghadUUFdhc3Z4s+znll5HqI5NDjhiqNxHeoQeOsAF/ROJ6tK/JpJmkJKcvjUTKK8dovdF3/bPdN
	2XrmCmLffs/4qDTJaBa0lZQOC6dDqLDxQJA==
X-Google-Smtp-Source: AGHT+IFL0J4ew5U+5dXo6aHE9wyYqH4CItTcJJ1lajrP0Q5QwvYyOBbSzJdZxQClKY9ffOUW1Ole4w==
X-Received: by 2002:a17:907:d91:b0:b04:626e:f43d with SMTP id a640c23a62f3a-b04b167b9f2mr1217252166b.47.1757517317226;
        Wed, 10 Sep 2025 08:15:17 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b0783047123sm182588966b.14.2025.09.10.08.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:15:16 -0700 (PDT)
Date: Wed, 10 Sep 2025 17:15:14 +0200
From: Michal Hocko <mhocko@suse.com>
To: zhongjinji <zhongjinji@honor.com>
Cc: rientjes@google.com, shakeel.butt@linux.dev, akpm@linux-foundation.org,
	tglx@linutronix.de, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, surenb@google.com, lenb@kernel.org,
	rafael@kernel.org, pavel@kernel.org, linux-mm@kvack.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	liulu.liu@honor.com, feng.han@honor.com
Subject: Re: [PATCH v9 1/2] mm/oom_kill: Thaw the entire OOM victim process
Message-ID: <aMGWAg5jIitYCXdZ@tiehlicka>
References: <20250910143726.19905-1-zhongjinji@honor.com>
 <20250910143726.19905-2-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910143726.19905-2-zhongjinji@honor.com>

On Wed 10-09-25 22:37:25, zhongjinji wrote:
> OOM killer is a mechanism that selects and kills processes when the system
> runs out of memory to reclaim resources and keep the system stable. But the
> oom victim cannot terminate on its own when it is frozen, even if the OOM
> victim task is thawed through __thaw_task(). This is because __thaw_task() can
> only thaw a single OOM victim thread, and cannot thaw the entire OOM victim
> process.
> 
> Also, freezing_slow_path() decides whether a task is an OOM victim by checking
> the task's TIF_MEMDIE flag. When a task is thawed, the freezer bypasses PM
> freezing and cgroup freezing states to thaw it. But TIF_MEMDIE is not a thread
> group shared flag, and only one thread is marked with TIF_MEMDIE. If other
> threads are thawed, they may still remain frozen due to PM freezing and cgroup
> freezing states.
> 
> To solve this, thaw_process() is introduced to thaw all threads of the victim,
> ensuring every thread in the victim process can be thawed. The freezer uses
> tsk_is_oom_victim() to determine whether a task is an OOM victim, because
> tsk->signal->oom_mm is data shared by all threads. This allows all victim threads
> to rely on it to be thawed.

A history detour for future reference.
TIF_MEMDIE was a "this is the oom victim & it has access to memory
reserves" flag in the past. It has that thread vs. process problems and
tsk_is_oom_victim was introduced later to get rid of them and other
issues as well as the guarantee that we can identify the oom victim's mm reliably 
for other oom_reaper. I recommend reading git log of mm/oom_kill.c to
get hairy history of that area and how tricky it is due all the subtle
interaction with process exit paths etc.

> 
> This change will thaw the entire victim process when OOM occurs,
> ensuring that the oom victim can terminate on its own.
> 
> Signed-off-by: zhongjinji <zhongjinji@honor.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  include/linux/freezer.h |  2 ++
>  kernel/freezer.c        | 20 +++++++++++++++++++-
>  mm/oom_kill.c           | 10 +++++-----
>  3 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/freezer.h b/include/linux/freezer.h
> index b303472255be..32884c9721e5 100644
> --- a/include/linux/freezer.h
> +++ b/include/linux/freezer.h
> @@ -47,6 +47,7 @@ extern int freeze_processes(void);
>  extern int freeze_kernel_threads(void);
>  extern void thaw_processes(void);
>  extern void thaw_kernel_threads(void);
> +extern void thaw_process(struct task_struct *p);
>  
>  static inline bool try_to_freeze(void)
>  {
> @@ -80,6 +81,7 @@ static inline int freeze_processes(void) { return -ENOSYS; }
>  static inline int freeze_kernel_threads(void) { return -ENOSYS; }
>  static inline void thaw_processes(void) {}
>  static inline void thaw_kernel_threads(void) {}
> +static inline void thaw_process(struct task_struct *p) {}
>  
>  static inline bool try_to_freeze(void) { return false; }
>  
> diff --git a/kernel/freezer.c b/kernel/freezer.c
> index 6a96149aede9..ddc11a8bd2ea 100644
> --- a/kernel/freezer.c
> +++ b/kernel/freezer.c
> @@ -10,6 +10,7 @@
>  #include <linux/export.h>
>  #include <linux/syscalls.h>
>  #include <linux/freezer.h>
> +#include <linux/oom.h>
>  #include <linux/kthread.h>
>  
>  /* total number of freezing conditions in effect */
> @@ -40,7 +41,7 @@ bool freezing_slow_path(struct task_struct *p)
>  	if (p->flags & (PF_NOFREEZE | PF_SUSPEND_TASK))
>  		return false;
>  
> -	if (test_tsk_thread_flag(p, TIF_MEMDIE))
> +	if (tsk_is_oom_victim(p))
>  		return false;
>  
>  	if (pm_nosig_freezing || cgroup_freezing(p))
> @@ -206,6 +207,23 @@ void __thaw_task(struct task_struct *p)
>  		wake_up_state(p, TASK_FROZEN);
>  }
>  
> +/*
> + * thaw_process - Thaw a frozen process
> + * @p: the process to be thawed
> + *
> + * Iterate over all threads of @p and call __thaw_task() on each.
> + */
> +void thaw_process(struct task_struct *p)
> +{
> +	struct task_struct *t;
> +
> +	rcu_read_lock();
> +	for_each_thread(p, t) {
> +		__thaw_task(t);
> +	}
> +	rcu_read_unlock();
> +}
> +
>  /**
>   * set_freezable - make %current freezable
>   *
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 25923cfec9c6..88356b66cc35 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -772,12 +772,12 @@ static void mark_oom_victim(struct task_struct *tsk)
>  		mmgrab(tsk->signal->oom_mm);
>  
>  	/*
> -	 * Make sure that the task is woken up from uninterruptible sleep
> -	 * if it is frozen because OOM killer wouldn't be able to free
> -	 * any memory and livelock. freezing_slow_path will tell the freezer
> -	 * that TIF_MEMDIE tasks should be ignored.
> +	 * Make sure that the process is woken up from uninterruptible sleep
> +	 * if it is frozen because OOM killer wouldn't be able to free any
> +	 * memory and livelock. The freezer will thaw the tasks that are OOM
> +	 * victims regardless of the PM freezing and cgroup freezing states.
>  	 */
> -	__thaw_task(tsk);
> +	thaw_process(tsk);
>  	atomic_inc(&oom_victims);
>  	cred = get_task_cred(tsk);
>  	trace_mark_victim(tsk, cred->uid.val);
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs


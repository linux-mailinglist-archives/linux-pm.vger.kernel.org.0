Return-Path: <linux-pm+bounces-34250-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A813B4AD11
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 14:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C63618921DC
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 12:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D3F32BF31;
	Tue,  9 Sep 2025 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ICD7RKk3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA5432A3C2
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419205; cv=none; b=uq8NCd7FdLnKJwl8leHrSQ++i4l4M/uvStd9YeH6WB6uvgSbxO8XZWEqyb6xfWuNbdG/KgqkehX9oZkVT4TvMQqtv7Qo7a9NiFnomrovqUvGjbtztaJQ6W0I6KnoXqrQnxEEi0+z5KsY/Q4xnmMSoMCVYFIa0ge/befurCrW6yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419205; c=relaxed/simple;
	bh=wO931vf3tCB/2C2a6XF5aRNBCnRugdm8BOwCaW5DDrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+n7cSrK59P8TJKTi/73tr7Mez3Q8gT7BDBUkH3XYSgpKXnGMO56GXpCXU7boTe3oficxvMne9gAUwOkFmZhEpHmWCIOTsJv9Ffnzy6XP39X93C6LZqdy1S3Xa1E43mQfiYYSkF5P7ryikt0ngxZ4JnOZMf3eMvkpu+BNyBk9q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ICD7RKk3; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6188b793d21so8783952a12.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2025 05:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757419202; x=1758024002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zpoH6jIFgFKbyHNBMDkBh9Rdg/ma6DdBtffCZfzJ4S8=;
        b=ICD7RKk3BoRyJMa1tSLBKCXT/WeQh5aracZEi/E6ePriUzsZ4x/WeUKp5UBdSWNEX6
         6f/b8oDjIm0NCuWCLP0mRULbSj417Da6Ur3kJ8QyhUl2NSU/HJzdC4OaYHQhuIVFBBVJ
         MyVy8W+IZ53Ya2+sGcrnjw8c8tTz4+5FegotpZNQcA+4LQlZpKVHP7A9Uu6CZ8i1yNOf
         qDgGpp70MBDucjveLsqQJbQDCmSy/9LQhMG5Hnhp5l72EbDkVUyGjdqGmh9juOX/w/Ea
         uegRNQmqTPXhgmO+IpmddlHXlgNwa8ffKP/vdH3JFfTNdZvkx+BeVG/GtXqbfxZoRSOs
         FwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757419202; x=1758024002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpoH6jIFgFKbyHNBMDkBh9Rdg/ma6DdBtffCZfzJ4S8=;
        b=MuF679sZ1r29x8kiIz8RxNMtim2VpK754321lOeJCz1nHqqEAt92zNEuUiKSA6Ldqb
         re6uog1RqpPFK/WN4T/JIneUk9dAqeZGds6qyKHpaqioI82gv92TGMMO9P+VwiQSvOKu
         Mln3sjoxXLIrzWnt9XZonC01HO3daTf5V7ebqVhnqphowlj7QWJTuALe31RuxcmEDNAY
         R+iqEAyw76bWSEfBW11gad9ISiMHCdxAm9UrHF1gmqlCs1NWFkGGRQi7IH4Et9AY3ILE
         katdinHBQ1FXSh9n90m4cuminARx73G48lAxg5ZZRmepm/PddsTrhZQ0y7KqGNjmMCbr
         ZiaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX/g0GW2x7Ozu++Hop8ZIlzInmnw34yWNdp/b9KomS5m01NYXpMPGamnsWzyaBnChem58iGUlLUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYyLxGP0ZiSiDXsUbmPGtOOG7yvxQX2kFMKiEGB6yQyB133EJM
	UBjUAlW++nTppQTSnYlfy3bEVXVQzznw0KzodqTyE/Ek2QBaoIbHnb5jOnCNQf/JwFY=
X-Gm-Gg: ASbGncvcBXSN40/KoOcIyluDtW44yNC6K5o2cNTV3obkwgHESNBKnjjs4zo0ZZt+0Q4
	zkvPsy6f6Zfgns1Z3uDNes1H4029QWR/fOxn354Qmn+rdq4KtiLDImQ6oG3m2+hEVVD2+LZCYxt
	96vU0ByDwTD6eUFpTlUdBthvY4+PgdijzKBAEsCRx4cuXz1YlEZQ8j7CfhtBMrDjVIsnZM9nvHt
	0nswdNkXAzfd6UXc6OXyfaHi4v7QZKGu2bZkV9N2a9zL2ANMGT/qlLxKmbBOBfpXB96533BSQ8K
	+9fRSXSGZlrH78iV+SjpeCDBFFFbAcfwIdVp4GcyvQyr1Sifl82P80v7BWma+TfPlS6edkk8U99
	AcpRDfaLnoJQZZx7JSOIOSJLASpJm2nwYWds/OPmkWqLi1fHFdtrJyCU=
X-Google-Smtp-Source: AGHT+IGsIN8mwOQ4OSrkp1PyG3QvcNyGyHSS1KrMkb8cUBEj4L750Kxz7JC7cS2+GeODNKnh3rh9wg==
X-Received: by 2002:a17:906:16c9:b0:b07:6087:6803 with SMTP id a640c23a62f3a-b0760876abdmr372197466b.21.1757419201605;
        Tue, 09 Sep 2025 05:00:01 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b042a4b3110sm2112324566b.49.2025.09.09.05.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 05:00:00 -0700 (PDT)
Date: Tue, 9 Sep 2025 13:59:59 +0200
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
Message-ID: <aMAWvwQ3eJZH55mp@tiehlicka>
References: <aL_wQkwBZ7uLM2ND@tiehlicka>
 <20250909114131.13519-1-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909114131.13519-1-zhongjinji@honor.com>

On Tue 09-09-25 19:41:31, zhongjinji wrote:
> > On Tue 09-09-25 17:06:57, zhongjinji wrote:
> > > OOM killer is a mechanism that selects and kills processes when the system
> > > runs out of memory to reclaim resources and keep the system stable.
> > > However, the oom victim cannot terminate on its own when it is frozen,
> > > because __thaw_task() only thaws one thread of the victim, while
> > > the other threads remain in the frozen state.
> > > 
> > > Since __thaw_task did not fully thaw the OOM victim for self-termination,
> > > introduce thaw_oom_process() to properly thaw OOM victims.
> > 
> > You will need s@thaw_oom_process@thaw_processes@
> 
> The reason for using thaw_oom_process is that the TIF_MEMDIE flag of the
> thawed thread will be set, which means this function can only be used to
> thaw processes terminated by the OOM killer.

Just do not set the flag inside the function. I would even say do not
set TIF_MEMDIE to the rest of the thread group at all. More on that
below

> thaw_processes has already been defined in kernel/power/process.c.
> Would it be better to use thaw_process instead?

Sorry I meant thaw_process as thaw_processes is handling all the
processes.

> I am concerned that others might misunderstand the thaw_process function.
> thaw_process sets all threads to the TIF_MEMDIE state, so it can only be
> used to thaw processes killed by the OOM killer.

And that is the reason why it shouldn't be doing that. It should thaw
the whole thread group. That's it.
 
> If the TIF_MEMDIE flag of a thread is not set, the thread cannot be thawed
> regardless of the cgroup state.

Why would that be the case. TIF_MEMDIE should only denote the victim
should be able to access memory reserves. Why the whole thread group
needs that? While more threads could be caught in the allocation path
this is a sort of boost at best. It cannot guarantee any forward
progress and we have kept marking only the first thread that way without
any issues.

> Should we add a function to set the TIF_MEMDIE
> state for all threads, like the implementation below?
> 
> -/*
> - * thaw_oom_process - thaw the OOM victim process
> - * @p: process to be thawed
> - *
> - * Sets TIF_MEMDIE for all threads in the process group and thaws them.
> - * Threads with TIF_MEMDIE are ignored by the freezer.
> - */
> -void thaw_oom_process(struct task_struct *p)
> +void thaw_process(struct task_struct *p)
>  {
>         struct task_struct *t;
> 
>         rcu_read_lock();
>         for_each_thread(p, t) {
> -               set_tsk_thread_flag(t, TIF_MEMDIE);
>                 __thaw_task(t);
>         }
>         rcu_read_unlock();
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 52d285da5ba4..67b65b249757 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -753,6 +753,17 @@ static inline void queue_oom_reaper(struct task_struct *tsk)
>  }
>  #endif /* CONFIG_MMU */
> 
> +void mark_oom_victim_die(struct task_struct *p)
> +{
> +       struct task_struct *t;
> +
> +       rcu_read_lock();
> +       for_each_thread(p, t) {
> +               set_tsk_thread_flag(t, TIF_MEMDIE);
> +       }
> +       rcu_read_unlock();
> +}
> +
>  /**
>   * mark_oom_victim - mark the given task as OOM victim
>   * @tsk: task to mark
> @@ -782,7 +793,8 @@ static void mark_oom_victim(struct task_struct *tsk)
>          * if it is frozen because OOM killer wouldn't be able to free
>          * any memory and livelock.
>          */
> -       thaw_oom_process(tsk);
> +       mark_oom_victim_die(tsk);
> +       thaw_process(tsk);
> 
> > I would also add the caller in this patch.
> >
> > > Signed-off-by: zhongjinji <zhongjinji@honor.com>
> > 
> > Other than that looks good to me. With the above fixed feel free to add
> > Acked-by: Michal Hocko <mhocko@suse.com>

-- 
Michal Hocko
SUSE Labs


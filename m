Return-Path: <linux-pm+bounces-34228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFFDB4A788
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 11:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F94F544456
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 09:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B3E2DA768;
	Tue,  9 Sep 2025 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PIyMysj3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3030B2D836D
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409351; cv=none; b=lOzJ2ayPN1nrj5jHIEras2PK9wPbK4ohbLAqxgcgi3z4v8J44WlF5mfizjTMQ5tz21BguXa72fUoxYUoxHW4H3fTTdMC5i3pLZn99PlBG4vTQssNXHwBv53qtdXki208+hjqfsTgDchQy09AwLOOVsE7Oo3He0abjTln6v3I67Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409351; c=relaxed/simple;
	bh=lA3Sef89UxhD96LIqU14KJgSsxI2nu11zjoqrGnvJhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTL+6kgFcV9hSpf39mHgMm6KFB0vCYCxIA5kxgrWX7m0i5beErtzcX3dT+6LShiXqluHbgv7sBJRWcIz7j2XLRTrS5t7sFhA+C4qDKZKx6zbWbIuQ2D+kM76469FXotaOKFx+JlhTBLRshX6XSR3HtArWqKRwC+3xkTuY+8lTjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PIyMysj3; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b04271cfc3eso729381466b.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2025 02:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757409347; x=1758014147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4wyBfzXieOB4BKjRhG36VNeBbb5dfQQ18kcUJJo+HeI=;
        b=PIyMysj3v8aZhqBX1vhj3O4t7W/Vb/XanqhaMHs54kO6fn8DJNv3OU46ArFb5PDXpM
         veVGiheYjBgAkKMQ4klKDxYP83C/d+LglcfHOj3cHsRhg0YUWmDnwqkiQzOyMcRkMjd3
         C5lSs9+8L1k4HE3oTR02CbaGWniKc+mj1mLytKtodjnwfykDID7Radnt9TdJ9LUlTwvH
         VfvPu1fj1hi+SsjQ3DRQPcwVNmvi30VQGJ1Zu3A3ZLO7LFgn/hsQcZi27x5R9v+2rwcb
         4KcDK9J5hySef+T/OJEahX/4Zl0+dpZfnYnh7/A0zg60RYBjsVgEvccWUmxGXPgW1Kyf
         M/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409347; x=1758014147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wyBfzXieOB4BKjRhG36VNeBbb5dfQQ18kcUJJo+HeI=;
        b=wuMAfbY7Qev8sB5yV2Dxu93jRHySBC07dES6ZTYu1212hm0ogH372778EI1IniRmIu
         7tJWF8mGcIPRdhtRWb9ApXUU/BKMdJ62IJEbGxA4ZoUtN6aOHqv2yn7kny30qDqb6AgQ
         9lrO/mI6vST4Lmq/EmN5plrwoszWS3df5hY/8GdodUsmrHXXQyetdQlbe5ojEpp81dNV
         OteOoUAtY+L7/rDAvl1eQSa6kLCjHTgzdIzoMFdyo6ZR5iAASRzFRjja8qvUJuCgSWP4
         wB7kDPOm7gKr+Nc6bnRHdfF3S3Ax8Rjht7xpY0dlVLTV+NxykxdBfpEOk6wOn5XxTuRP
         ANbw==
X-Forwarded-Encrypted: i=1; AJvYcCUCF+Z2haM5ElyIBfZB6vDfnwfoQOzVttBI7Cd5v5Q4wrhXh+WeccEaay5b+IkZhaDwGbuqw2lHcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhtkMenyJSsHIOMKuxU8yQWy/bfe56nQCdssZxGf9D9kBPl/sa
	Yzr3z4DTsXlQ2xU8+I38jVMMlW6hUfObhrDo348TuOtzcUfqtQ1HpAPdkdk6AnECQCM=
X-Gm-Gg: ASbGncvFMNXvZYJsIM1eaYUZP2roabEd3WmXHeSGe5S41gSY/ARic82+NNMT65x3aMg
	a9UidyHziHBa0BdpmLdB57yUTl+3fa5Dl/WCIoVHJbY/8krGMql1P438WjcYzkh0Ps5yDzwOS6d
	fDmJAg+5SxJuitFwVayXohahV37D/93yzF1WZ2Vss0lkDLcL++5FF7s1+Z3b1J7mZPEqz9biADl
	ssJWx1Gucjkbv29iNba00MFpd8SQTW8GCeh5zn7EyybzOkEk3Mix2aN+j1gE5SuWIJg4CZX6vhl
	grpAi+TvzwYD1hwLxEp1/I0w28kN7sJNyXy2+YaLKQf9UEw51VvVmuWLB+xux3e57my2EiI2PCU
	FYwoUTV+88dT06nf2k457KbDm/k6fQQo2ZZGe8CZ+cRAp+ZZkJ9UWuCM=
X-Google-Smtp-Source: AGHT+IFUomSr1Edwt6q9MQDVZ8nWTr0HkefRKWchKOMD/D/mp42AWKlgEJvjm+P3vDEQZ3SMoB8W3A==
X-Received: by 2002:a17:906:9fcb:b0:af9:5ca0:e4fe with SMTP id a640c23a62f3a-b04b179c35emr1088210266b.56.1757409347400;
        Tue, 09 Sep 2025 02:15:47 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aff0681aefdsm2661611766b.8.2025.09.09.02.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:15:46 -0700 (PDT)
Date: Tue, 9 Sep 2025 11:15:46 +0200
From: Michal Hocko <mhocko@suse.com>
To: zhongjinji <zhongjinji@honor.com>
Cc: rientjes@google.com, shakeel.butt@linux.dev, akpm@linux-foundation.org,
	tglx@linutronix.de, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, surenb@google.com, lenb@kernel.org,
	rafael@kernel.org, pavel@kernel.org, linux-mm@kvack.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	liulu.liu@honor.com, feng.han@honor.com
Subject: Re: [PATCH v8 2/3] mm/oom_kill: Thaw the entire OOM victim process
Message-ID: <aL_wQkwBZ7uLM2ND@tiehlicka>
References: <20250909090659.26400-1-zhongjinji@honor.com>
 <20250909090659.26400-3-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909090659.26400-3-zhongjinji@honor.com>

On Tue 09-09-25 17:06:58, zhongjinji wrote:
> OOM killer is a mechanism that selects and kills processes when the system
> runs out of memory to reclaim resources and keep the system stable.
> However, the oom victim cannot terminate on its own when it is frozen,
> because __thaw_task() only thaws one thread of the victim, while
> the other threads remain in the frozen state.
> 
> This change will thaw the entire victim process when OOM occurs,
> ensuring that the oom victim can terminate on its own.

fold this into patch 1.

> 
> Signed-off-by: zhongjinji <zhongjinji@honor.com>
> ---
>  mm/oom_kill.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 25923cfec9c6..ffa50a1f0132 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -772,12 +772,11 @@ static void mark_oom_victim(struct task_struct *tsk)
>  		mmgrab(tsk->signal->oom_mm);
>  
>  	/*
> -	 * Make sure that the task is woken up from uninterruptible sleep
> +	 * Make sure that the process is woken up from uninterruptible sleep
>  	 * if it is frozen because OOM killer wouldn't be able to free
> -	 * any memory and livelock. freezing_slow_path will tell the freezer
> -	 * that TIF_MEMDIE tasks should be ignored.
> +	 * any memory and livelock.
>  	 */
> -	__thaw_task(tsk);
> +	thaw_oom_process(tsk);
>  	atomic_inc(&oom_victims);
>  	cred = get_task_cred(tsk);
>  	trace_mark_victim(tsk, cred->uid.val);
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs


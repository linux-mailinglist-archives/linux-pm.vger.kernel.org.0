Return-Path: <linux-pm+bounces-34284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CAFB5026A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 18:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63AFC172E07
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 16:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7CF3451B6;
	Tue,  9 Sep 2025 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYq+vg62"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0185725B30E
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435014; cv=none; b=n3WHNBsub2gvzNkncl2u0hru4Jq9dgZ8TPxVpKa48hAvK+XMHaYKurwoaZSw6LnZZiiE7witV/EqM+z4TPirUThBCJ5VbU4OtZWMJEYjP7pRjyGjyYBJIAY8J1dRRbMCXt/tr23qAmiAzjNlrYwUWAm984VXsDta+j99pxD4Rlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435014; c=relaxed/simple;
	bh=gCmriwNrpFdJfOUYm/taCmIwvQSRPPVRGzsDgoc/QHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUvZNdEKNVrhGHT+uSGvV6lMCTgYRV+WoYunpQLufYUGet+9r0T9Cu+W+lQsaLWKFVASLTp7TrdmUoAePmeUKj01yqpbVoEDNcFwpqhhb6+41fAm2C24NiziD//q4kvZud/qOHfH8E8luAnyugNzteM+8RF42Co9HYW4zViqKnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eYq+vg62; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61d14448c22so29862a12.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2025 09:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757435011; x=1758039811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiVBofelZHpMzXxZ3S925BN2xoWncKB8wIE7dJMH83E=;
        b=eYq+vg627nNR2uZ8U87sWRFB6mpyBSkLG0NMpXQtwTsVBC7JVaKvFCz4L7uWQ3qWd2
         c5uyJq34tppZAX/VekbGnernAk3bYWVcIBU4SpLCq9wXEk8ZsnCMzKethQelA4OopHo8
         iVhnk0TLe9/ors6TQABWyTb9JUVk9tAxeMec7YD/nWqe3qDHaFKQkO/YD+7mRAF3vGfy
         j0Sj95UJfiIWOpKYBZ9ibxV0dZkyE0rlLUpsK/97t4PEvQ1GJNrolju8/vUvFfkPHqrf
         J7GELenPIErHtAiDZ2PQd5q8fzFD9Y99GtESKh/HJ8DdW+PnGl+nkM6AiZpgG9EFOwIh
         Ropw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757435011; x=1758039811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiVBofelZHpMzXxZ3S925BN2xoWncKB8wIE7dJMH83E=;
        b=d50JHTwT0T3OwOipSix2rPWkW2sNC/vFV+YbQVQj6Xh87I59r0OLDOtV63A6k9LeIw
         OO5t37LmJW1TWcEBPEo9WEGUAXF2hpN9VsUIT/vC4xKGoCR7mFOj3zP+MHDN2Uajffa7
         MLHeXAuvbTfXvEmlhADj+6a8SQzGQW2S0utc+pjpEQROucaKya6W+XyJVQF+s93uRudd
         95v/bmHr4i+hNGy1jLbxaqiVJwdnKNcHR4S6R8Hw8e3jgw5hH01u6JrXteB7ud0ICq0n
         9/mlJ0N98W2aJG9Mnm08XcMvjOGJ3e/RDjYqCwoInzQkPYjqBMR60tdcYIF0VGJFDxc9
         vgxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU2JKl4PV2sfoYD8pSCj8Za2j3bJTOe/pZs4I0QNjnao3fC2zKxm6NSNePlJ0OerDIM8OuFWI7DA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx4xBkO6X9NpsloqLT/4L2SdTWCAJIXoSJRexlTqLhjJQpADSp
	sxeDXrSg3pbbaeGp+7POmQcCo1eKTrZecgVf7y7NZZUakkdAEStnilt/VKuxb4jfFCUYcCKrtqc
	EQNp1qD/+iLUMJ5j7cWSAK+ZE7iSTPbpOCKJ7Qt9Z
X-Gm-Gg: ASbGncuisyZH7sgjKKAFp43ZJpTYGxcDBuA3J0LlqbbEpN7fmmb2Hh7YqSiGgvyBK8Z
	1c+X+5YN7QZwgtwqz03tFgD6nc5bw4kJ/nEm+4YKhpJ8kWM7MhlRS096S7jBR3l4uBIYcm8hkLT
	tRSsowYuuvXiqebnirzFRDbcdGJT2p5QYcuR+ZHW8mm6Q5Zk0YI+XZIRMPS6tvCvZFP203RSfKP
	SmENA4iPZPucMC7EsPuvFtPmIlffysnDX8kiiFp7QRt
X-Google-Smtp-Source: AGHT+IEpjhWf1f/zS3jSy099Km83UZ6GPfZLXi6Q4O+DwExC5+sMeiNfCbXZVRgPSvKKAmT1gOicI5bAQG3N8Tbzyt8=
X-Received: by 2002:a50:875a:0:b0:621:dc0f:6b2c with SMTP id
 4fb4d7f45d1cf-623d2c48760mr247988a12.1.1757435011094; Tue, 09 Sep 2025
 09:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909090659.26400-1-zhongjinji@honor.com> <20250909090659.26400-3-zhongjinji@honor.com>
 <aL_wQkwBZ7uLM2ND@tiehlicka>
In-Reply-To: <aL_wQkwBZ7uLM2ND@tiehlicka>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Sep 2025 09:23:18 -0700
X-Gm-Features: AS18NWAMe0CzoiFSDbepBrWqyKfxIxGSu3RBWJfK7KdLpTSnI-kM7z2JwBdt3mM
Message-ID: <CAJuCfpFr_oCQPhoq4CfsnTm_Reu=oAGA6Bu1Uy-MUR7V60QnKw@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] mm/oom_kill: Thaw the entire OOM victim process
To: Michal Hocko <mhocko@suse.com>
Cc: zhongjinji <zhongjinji@honor.com>, rientjes@google.com, shakeel.butt@linux.dev, 
	akpm@linux-foundation.org, tglx@linutronix.de, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, lenb@kernel.org, rafael@kernel.org, 
	pavel@kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, liulu.liu@honor.com, feng.han@honor.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 2:15=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Tue 09-09-25 17:06:58, zhongjinji wrote:
> > OOM killer is a mechanism that selects and kills processes when the sys=
tem
> > runs out of memory to reclaim resources and keep the system stable.
> > However, the oom victim cannot terminate on its own when it is frozen,
> > because __thaw_task() only thaws one thread of the victim, while
> > the other threads remain in the frozen state.
> >
> > This change will thaw the entire victim process when OOM occurs,
> > ensuring that the oom victim can terminate on its own.
>
> fold this into patch 1.

+1
With that done,
Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> >
> > Signed-off-by: zhongjinji <zhongjinji@honor.com>
> > ---
> >  mm/oom_kill.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 25923cfec9c6..ffa50a1f0132 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -772,12 +772,11 @@ static void mark_oom_victim(struct task_struct *t=
sk)
> >               mmgrab(tsk->signal->oom_mm);
> >
> >       /*
> > -      * Make sure that the task is woken up from uninterruptible sleep
> > +      * Make sure that the process is woken up from uninterruptible sl=
eep
> >        * if it is frozen because OOM killer wouldn't be able to free
> > -      * any memory and livelock. freezing_slow_path will tell the free=
zer
> > -      * that TIF_MEMDIE tasks should be ignored.
> > +      * any memory and livelock.
> >        */
> > -     __thaw_task(tsk);
> > +     thaw_oom_process(tsk);
> >       atomic_inc(&oom_victims);
> >       cred =3D get_task_cred(tsk);
> >       trace_mark_victim(tsk, cred->uid.val);
> > --
> > 2.17.1
>
> --
> Michal Hocko
> SUSE Labs


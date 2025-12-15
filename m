Return-Path: <linux-pm+bounces-39603-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 405A4CBFF97
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 22:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20305301C8DF
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 21:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8413090E2;
	Mon, 15 Dec 2025 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQLrXJ5J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2209F5475B
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834820; cv=none; b=fIxPqfdMXrcwoBs65cbVGcKwmWmD9WWdNJhQIbGD9HyrpKnBzCnwKxUtNjzpZqxsdBZpITM4tiluEFW1b4eZOK3iDaz5o4gOEeWNdNWtPNaA3Q7eu0t2yg2FXW0YFUlU0pl3yu/7iuQoiRJiMDUGdsFQpZkD+TD3HmV6KGsxzlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834820; c=relaxed/simple;
	bh=Y9B0PrO7eep9Md2S3cwjSR2T7fsBiwkpWkQ81Zxh7oM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eeNXNV/dP1V19XuUOwApc8GaBMRi0UXZVh4Y0i+N72pPBjCk0mikWN9H5cDAwTR0b6MFpteXlNcTV4alR45tQZY5vJ7Yp7uzb1JXz6s4b43z6o4XS5XIc9g9Pkfg+lBYBwqQnxIphz+/wjR8bA6QdYFwt3NhcLDh+mUiEcnZ5AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQLrXJ5J; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-430fbb6012bso1251037f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 13:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765834817; x=1766439617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtrYjcDo8W8ENLiooSwtuxxlBPD0y00FacSVPre/Faw=;
        b=QQLrXJ5JAUOzJ8Yt1jyd5kWZKLwJD6LCSRU0Tj/6IcYefX0Ty+qXaOOCXoVzD161Hm
         oz1eXEiyEZs1Db+2tRL0QVbtnLpASsry3v+lyOkqjtXFqQabduvZnaDnAunDTa7qJ4uP
         isD3IBOOlgDrc4PazKAYDV0GyoixAfeSmaHIZHKU3IJMZfasrCR9xa4SepsW9x1uuZZD
         GEHl9BIInSVE/5ZEdpq/SmJoxLGSqd2AAQgzRqUxhsbx3x9kt9KPJR977m/JDxTY8LTx
         Btuo/BDu9wLR4eu9NOnrxRc6XFAqYzAHNUMPU/Ql/xAVuXNFaz+oquG5jC0STwf0D3Nu
         p1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765834817; x=1766439617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PtrYjcDo8W8ENLiooSwtuxxlBPD0y00FacSVPre/Faw=;
        b=BCE3E5iE1oGDfkuPYc/SnYNnsP5zltc2ZQEWML0UE2kDOXOjdSzQ0i4fYgnN6HJuCg
         ioTSGNVDkyMg0FurNl7r3apd9DQWUaAj0e1gLnd4hkXSQSi9p/fkIjx3V8OQvV9P8qTY
         jfsa9wen/Fp+gp8KgLTZfPfDI3gmZtPRusmICEmk4pruTPpTu0FPmTUG792NeUvpri5I
         FIgo1huYpZeE6dX1ZmCWRLKBqBxW5Xk2mSSUKezbELynWTvkoBONnwHrMkezLVTP+r8b
         lSpiuzenYkI6Y1A01Wh1QI1YOr91nyvfV7yOVS8peO+tCbKgyNhf3e1kUpZJgZMS5SiM
         M6dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmYS3PZxnF3tYLDdvVW2j5mOArjKto3B227eUuZCoMjLeCw7MSn0Kyfj1Z0yJ79/InHA6u9kIl7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvvbErY1gVBcStm2Sb9MP/hUbdYUjBbC4i3Ovx0zZQAnp32m2p
	n3xX33iSD5X7abQ0b1d4obm7Qr3I66pxnjxt0L76xEHI/fbQpkCJB52h7Cw+JxVrIjyj9/Z4aig
	2sQUWTjMe6sxewx58oafd6Nb7r9TGhjE=
X-Gm-Gg: AY/fxX5F2unrx5ssQ8v7RB5e01PfBr/uPLsErVLPgAeIYMDRf3CbmBNK2IMZ6VLsG4u
	JlRJWIQz5o9xeHMrGxydH3dQ1lwp+/mKo0q4niqoNXuIPy8DMb3dKqkuSpaWhaagjDqARckjt5Q
	H5/ai7ZYaicWP6yYVD7uhYTaP4MAPChLbh8OLC1G8JJYUYq+04KWIiO4ou/pWE9w8i/imK8LeF0
	dkKncc3LSmG1IWF19DB+A1gO1w72UcWJI9nG3r2us/C/7tBzjAdeKAJAI9x19FNvlglxr95AJn1
	E3ZwlRJOy47l1BrCO/B8wxh2hPj/
X-Google-Smtp-Source: AGHT+IFLwg9qrtGIR+KKSJwR/7/cX3U7rq6rlbIqE5QA9N+Q5KZyJ8O41sxw+c2I52/X9p3wPLvNSGsFlF/3a+MqKoo=
X-Received: by 2002:a5d:5f82:0:b0:430:fd0f:28fe with SMTP id
 ffacd0b85a97d-430fd0f2a7bmr4935997f8f.31.1765834817292; Mon, 15 Dec 2025
 13:40:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215044919.460086-1-ankur.a.arora@oracle.com> <20251215044919.460086-11-ankur.a.arora@oracle.com>
In-Reply-To: <20251215044919.460086-11-ankur.a.arora@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Dec 2025 13:40:06 -0800
X-Gm-Features: AQt7F2rQ1ApFWmx4BVk_0MGk_PcVWn8dueHeO96jKZChfmmCmjnf-YqQHmYoFps
Message-ID: <CAADnVQKYoE85HFAOE5OBFpKbXej=h12m4DVvHuPViJSjAncK4A@mail.gmail.com>
Subject: Re: [PATCH v8 10/12] bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Linux Power Management <linux-pm@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Mark Rutland <mark.rutland@arm.com>, harisokn@amazon.com, 
	Christoph Lameter <cl@gentwo.org>, Alexei Starovoitov <ast@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, zhenglifeng1@huawei.com, 
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 14, 2025 at 8:51=E2=80=AFPM Ankur Arora <ankur.a.arora@oracle.c=
om> wrote:
>
>  /**
>   * resilient_queued_spin_lock_slowpath - acquire the queued spinlock
>   * @lock: Pointer to queued spinlock structure
> @@ -415,7 +415,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rq=
spinlock_t *lock, u32 val)
>          */
>         if (val & _Q_LOCKED_MASK) {
>                 RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
> -               res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHEC=
K_TIMEOUT(ts, timeout_err, _Q_LOCKED_MASK) < 0);
> +               smp_cond_load_acquire_timeout(&lock->locked, !VAL,
> +                                             (timeout_err =3D clock_dead=
lock(lock, _Q_LOCKED_MASK, &ts)),
> +                                             ts.duration);

I'm pretty sure we already discussed this and pointed out that
this approach is not acceptable.
We cannot call ktime_get_mono_fast_ns() first.
That's why RES_CHECK_TIMEOUT() exists and it does
if (!(ts).spin++)
before doing the first check_timeout() that will do ktime_get_mono_fast_ns(=
).
Above is a performance critical lock acquisition path where
pending is spinning on the lock word waiting for the owner to
release the lock.
Adding unconditional ktime_get_mono_fast_ns() will destroy
performance for quick critical section.


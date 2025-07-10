Return-Path: <linux-pm+bounces-30637-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D793B00EC2
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 00:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA104E8690
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 22:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3388A29A30A;
	Thu, 10 Jul 2025 22:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ow/zjSNn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF5E29993F
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752186899; cv=none; b=mKSVcage36asbMrSFV/40yeqH8sNBWbf9PLE3K3TKhIOHuHY8VSvmj4LBSeShdzGd8rZo+0ow0sKALL0xpN5pJNH20mN+TYkGOZd9wxF/QX4cOlXd4Xpo7QmTvsmSaRipBpnnzbabk/DWJ6d+8J+e7iVOzTlUaJxhEsxArASduQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752186899; c=relaxed/simple;
	bh=yVh66acthu6J6IcXm4m/4Uj6wbfy1DTZooP7O1ZX4H8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1y5i/l6UCIsdxxgr8L6B8FQgg4ZEdbXV5jUWIu9N8Lm1/Emi9CkSPj8C+YP/+aEcE3L1haA7ZjKWWvq701x06422eYRZ00+jFPUAgOKl+318nNZaz++lnhii+BNvSHSrqYWvt0Mem7LlgpGVMtY+ov502P8hWl1bCPRK39uS2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ow/zjSNn; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-558fa0b2cc8so1296546e87.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 15:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752186895; x=1752791695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dPHJ//ZU8p5qKrzh9zty72ZQJ4R8fsELp28sl7pL/M=;
        b=Ow/zjSNnttk4xulKkUfjGD93GHch6RikRFveK8BfaAQ00grSoDkI8DhYd2m/bZtrFN
         GRGKqqGcVNeJIvopUZa5m/KOQn9U2LPL5x1+OklNO8Lo4pIPR9YltyguHnZ9PpUpcg+M
         1Mqy9jDabO6WmbIi+eGmU9P4UM4xuFJCE1urb+6XIjR7ypatVn75os50ylYt1VhLIlAZ
         9RBBBI0jqnXmxKSf6fRJ430lVegNu5OgeRjf6rNkSHW/ke4FziK1BHs7Rxcas3Pk/c2B
         3EnlCBsT0+Ou9kPmfKfs/CUVF2/ou0o0OmNu8Ikem5UkLlcvnkXcpAzZq4xpBFPzpKW0
         Ra4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752186895; x=1752791695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dPHJ//ZU8p5qKrzh9zty72ZQJ4R8fsELp28sl7pL/M=;
        b=X62AMAKzJYUIbTCAlmNfFjLokzWQqusvd5piur0P+dJ/+3ATlCQaMnUV8H7suK4YyP
         gKyT0kQUkOvV89Uhhm5G1UFgAilqKK0eWxgaE8t1E+tFLRxM/nM7050jQPp7oIpIdJzU
         jtT+yE/thHgc5HOFvKLjxcpO1RRWcTECdl9owdVR0E7eapFCr6qW/xfkSXF/nct195kS
         OlQW8teEOYsWa/FpS9ufFLJfuRe8LcrYj2sTF6PO83eTXwQ9ODce7LIcDJE/HmU/1LyP
         mu++ijOrJtWonQVVF/04u5AMuNcYbN1mkzk1yjBu6zyC3qV4ufbrBdpiNyYD1ICSCxM/
         tmrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCZcul8jBglCa7+v5b1iw9pskYYFVqeZZMOqYcfEoEksRZvUJ1XZ6853E2wd8hXXGhS20pDIee5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Av8hyZRnJ50rHn7z9/BsYy60XUd/qCj97D5ih83myLFj+ZaN
	5OJNf8+P/a3/CFTzQ/ujwVXXqEfpgrpzW3sm8Wd0lw9cNkgjQK60MjZC1o+qYuV1kSYUrUzyc2p
	oFn6/CuYFrtq7Lk1AH+F7zELOuLRdj0x/t8VKbYI=
X-Gm-Gg: ASbGncvCp1oxOKNxJ6Ntn00utOPsoDPhbGvZb40ft0pqjxXBmN3FHZ0F3tFCQ4NDeR0
	uyxbsURkcEEWN6AkFVM5TVMw2kEmBzPW+zcLl/oUkDQmyz+1PycIpYvtO0a++ovIvw/Hj8K6u9W
	bh3E2qflauF7uFLA4I8EhaXnWRkkI9Q9Q7iYKqJ/RlQhEkQeDwCBqo6bGZ4xOdFpO8P9CYwL5eH
	JIcCsanyKchWNIE+uwM2zFYKzHUZj4FsQw0sbAYR9vSmBI=
X-Google-Smtp-Source: AGHT+IG0Jt0F+H8ws01F7A/4pvkhxz8kyGzoUj7Y3DMX9DxPL5uC4Dxim0O59t0qkQgtO/+aMgx5AjX4UJwG32eQQ1w=
X-Received: by 2002:a05:6512:15aa:b0:553:28f1:66ec with SMTP id
 2adb3069b0e04-55a045f07bbmr166129e87.31.1752186895155; Thu, 10 Jul 2025
 15:34:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3cbd9533b091576a62f597691ced375850d7464a.camel@decadent.org.uk> <CANDhNCoYPX_5m-v_sR4TJ3Xj5TVtrMLP8Bswo_-_+BMXwWUkjg@mail.gmail.com>
In-Reply-To: <CANDhNCoYPX_5m-v_sR4TJ3Xj5TVtrMLP8Bswo_-_+BMXwWUkjg@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 10 Jul 2025 15:34:43 -0700
X-Gm-Features: Ac12FXzRtPRCG3vVKe_al9TAYFZy78y3CS7g8LC2LK-_0V2sZ7fkJfcot95IKmY
Message-ID: <CANDhNCqK26S7p0nypKOytgvzKUL8CMMr4-JbN-8PkNc=Em6VYA@mail.gmail.com>
Subject: Re: User-space watchdog timers vs suspend-to-idle
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	linux-pm@vger.kernel.org, 1107785@bugs.debian.org, 
	Tiffany Yang <ynaffit@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 2:59=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
> On Thu, Jul 10, 2025 at 12:52=E2=80=AFPM Ben Hutchings <ben@decadent.org.=
uk> wrote:
> > There seems to be a longstanding issue with the combination of user-
> > space watchdog timers (using CLOCK_MONOTONIC) and suspend-to-idle.  Thi=
s
> > was reported at <https://bugzilla.kernel.org/show_bug.cgi?id=3D200595> =
and
> > more recently at <https://bugs.debian.org/1107785>.
> >
> > During suspend-to-idle the system may be woken by interrupts and the
> > CLOCK_MONOTONIC clock may tick while that happens, but no user-space
> > tasks are allowed to run.  So when the system finally exits suspend, a
> > watchdog timer based on CLOCK_MONOTONIC may expire immediately without
> > the task being supervised ever having an opportunity to pet the
> > watchdog.
> >
> > This seems like a hard problem to solve!
>
> So I don't know much about suspend-to-idle, but I'm surprised it's not
> suspending timekeeping! That definitely seems problematic.

Hrm. The docs here seem to call out that timekeeping is supposed to be
suspended in s2idle:
  https://docs.kernel.org/admin-guide/pm/sleep-states.html#suspend-to-idle

Looking at enter_s2idle_proper():
https://elixir.bootlin.com/linux/v6.16-rc5/source/drivers/cpuidle/cpuidle.c=
#L154

We call tick_freeze():
https://elixir.bootlin.com/linux/v6.16-rc5/source/kernel/time/tick-common.c=
#L524

Which calls timekeeping_suspend() when the last cpu's tick has been frozen.

So it seems like the problem might be somehow all the cpus maybe
aren't entering s2idle, causing time to keep running?

thanks
-john


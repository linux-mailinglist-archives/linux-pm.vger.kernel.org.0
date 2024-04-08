Return-Path: <linux-pm+bounces-6051-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D0089BF4B
	for <lists+linux-pm@lfdr.de>; Mon,  8 Apr 2024 14:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7F51C23404
	for <lists+linux-pm@lfdr.de>; Mon,  8 Apr 2024 12:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD9C7BAEE;
	Mon,  8 Apr 2024 12:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hlbGNp/f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1DA7BAF4
	for <linux-pm@vger.kernel.org>; Mon,  8 Apr 2024 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580216; cv=none; b=rukGG+Sj55kp1VIVUnt0/bcPkueJ8XGoVuYofExVGo8i+qEBUqKmgjmqHAaO6eBbh6Ckx+oXyuFW94CYKqZOf5LhQJ9fFwWIKHFGKq+jePdvXX8q3waxmQ9Ki1ietVAdQs3KZkBr0Ifdo1whR3+W6mSan56g7GghGnP1zPwjdn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580216; c=relaxed/simple;
	bh=fKehCiClD9dg01VzoXzMKEtrJs4OUkNg+PrGr3/Dtj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzIbba+axRK5UxYx3tpqYJvAg9zb5lI4AT7ugndM325wY0Bj03UYpm+b0D9YST8mqnK+PlyFXEQW2bnhuvB6ETz4O+qzX3r/3TcdngbiOdPNfQRNdLFuSA5LfUPI4JSghNdZmugIUifeK4bc2HrcpWjgh+tF+KdgCkbHvUsGm4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hlbGNp/f; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc236729a2bso4184133276.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 05:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712580212; x=1713185012; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JxaT3PMRuL4e9KTFT/emlcM/OCUcuLvdOqHXG/okFts=;
        b=hlbGNp/fBHWVphGMddVgDdX+vu3xoJ9QQPpk6l8/NG4rT82WYaVeixwkytbFU8/JQC
         A8q8q1r2C8yMKaItjJaVpoUj4SUxaKQPJ9r9sqZSQU7+N5UIcunE0ytCeULyfHUqQgjr
         OcGZS7+ph3UilRsolSfKpyET8XsQmMk3B8oayeOEdZ8UmtVPJ3GXwVwhTc2UE0MDY7V9
         5bIbd4fsAA7lBdAAAcSpU8pwvZIxYzGWooW6ZP0MHEvXTI1IrcjE9eXemPn6HTGvyA97
         tXe0TqsL+UvcxSMSdv7Mv56VFx9d+A5Y+VAuL+ZLF+WX5hy5umtW41Predm+PK7S4KAT
         CUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712580212; x=1713185012;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxaT3PMRuL4e9KTFT/emlcM/OCUcuLvdOqHXG/okFts=;
        b=PDTDjwID14V1zP7cweDAElD7uBb8PB2PzH2SgxgaOKwQ8l4T1ymJ8Uazn6gUdZRV78
         FpvP8rFwkqoOxuKwPYpBFKJwxT2WyvmEo/WMbK5mjbEvymmo4V9kfLHkJdF2vu0LMP2N
         3ANtNbfMJIn5ZE0YJg2T6PHH7xPmicZ7NuIdVbck6UKpbpvZNI1GB3MUOsobZlrYLPeo
         E1jhKdCscFEUig3+1N2zoAqPABBj00K6DBgSq4s+KmsysJZSxzZRo6KpEuwTrK3JGD5Y
         R84LSjhmLeELa9fQk2z/h4d/X2mWAYBr+oBJJk6v0EMujHWuHYz7msyBMjgliXWhAY1b
         WUow==
X-Forwarded-Encrypted: i=1; AJvYcCW0udUujf8OCxswA5YpRFsEFg+W0BQjzr99DHgEwEqS1ZEHRLM+KZLSpBseEXwPuNeAFAPdOH69/P2furZyQRexEkU+3ltGvFc=
X-Gm-Message-State: AOJu0YzHTxFxEiF0sQsy51s5RYG1to132StJRxBNSfpKchRqEARWpH8F
	c1tgfDFL2j+NwDsh2BJYtWZZxnRkwKk9l4VPmNo1VnTZ2RA014Kwu4W2rSkyp4vX3qRgiVsyWuL
	ZPqPe4FbR62HExzK3M/q6ktC28Q+4F7Q9GTjjJQ==
X-Google-Smtp-Source: AGHT+IGQxbNzH63UQFQ7p/mhjOGB9jWdMTr1htv/fo/3N9wxCGG7juvIee6jEqslTXlE94kDc2JpOoAnb98ws1sIxxU=
X-Received: by 2002:a25:ef03:0:b0:dcd:5bdb:4aa4 with SMTP id
 g3-20020a25ef03000000b00dcd5bdb4aa4mr5956331ybd.51.1712580212336; Mon, 08 Apr
 2024 05:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405083410.4896-1-anna-maria@linutronix.de> <87r0fg5ocg.fsf@somnus>
In-Reply-To: <87r0fg5ocg.fsf@somnus>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 8 Apr 2024 14:42:56 +0200
Message-ID: <CAPDyKFo7KT4V8Nvn58N3mNfeW6ai=-5hampjN7N19kYaR7zdVA@mail.gmail.com>
Subject: Re: [PATCH v2] PM: s2idle: Make sure CPUs will wakeup directly on resume
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
	Mario Limonciello <mario.limonciello@amd.com>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Apr 2024 at 09:02, Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> s2idle works like a regular suspend with freezing processes and freezing
> devices. All CPUs except the control CPU go into idle. Once this is
> completed the control CPU kicks all other CPUs out of idle, so that they
> reenter the idle loop and then enter s2idle state. The control CPU then
> issues an swait() on the suspend state and therefore enters the idle loop
> as well.
>
> Due to being kicked out of idle, the other CPUs leave their NOHZ states,
> which means the tick is active and the corresponding hrtimer is programmed
> to the next jiffie.
>
> On entering s2idle the CPUs shut down their local clockevent device to
> prevent wakeups. The last CPU which enters s2idle shuts down its local
> clockevent and freezes timekeeping.
>
> On resume, one of the CPUs receives the wakeup interrupt, unfreezes
> timekeeping and its local clockevent and starts the resume process. At that
> point all other CPUs are still in s2idle with their clockevents switched
> off. They only resume when they are kicked by another CPU or after resuming
> devices and then receiving a device interrupt.
>
> That means there is no guarantee that all CPUs will wakeup directly on
> resume. As a consequence there is no guarantee that timers which are queued
> on those CPUs and should expire directly after resume, are handled. Also
> timer list timers which are remotely queued to one of those CPUs after
> resume will not result in a reprogramming IPI as the tick is
> active. Queueing a hrtimer will also not result in a reprogramming IPI
> because the first hrtimer event is already in the past.
>
> The recent introduction of the timer pull model (7ee988770326 ("timers:
> Implement the hierarchical pull model")) amplifies this problem, if the
> current migrator is one of the non woken up CPUs. When a non pinned timer
> list timer is queued and the queuing CPU goes idle, it relies on the still
> suspended migrator CPU to expire the timer which will happen by chance.
>
> The problem exists since commit 8d89835b0467 ("PM: suspend: Do not pause
> cpuidle in the suspend-to-idle path"). There the cpuidle_pause() call which
> in turn invoked a wakeup for all idle CPUs was moved to a later point in
> the resume process. This might not be reached or reached very late because
> it waits on a timer of a still suspended CPU.
>
> Address this by kicking all CPUs out of idle after the control CPU returns
> from swait() so that they resume their timers and restore consistent system
> state.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218641
> Fixes: 8d89835b0467 ("PM: suspend: Do not pause cpuidle in the suspend-to-idle path")
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Cc: stable@kernel.org

Thanks for the detailed commit message! Please add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> v2: Fix typos in commit message
> ---
>  kernel/power/suspend.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -106,6 +106,12 @@ static void s2idle_enter(void)
>         swait_event_exclusive(s2idle_wait_head,
>                     s2idle_state == S2IDLE_STATE_WAKE);
>
> +       /*
> +        * Kick all CPUs to ensure that they resume their timers and restore
> +        * consistent system state.
> +        */
> +       wake_up_all_idle_cpus();
> +
>         cpus_read_unlock();
>
>         raw_spin_lock_irq(&s2idle_lock);


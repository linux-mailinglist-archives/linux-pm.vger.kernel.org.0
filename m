Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 725F4614A3
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jul 2019 12:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfGGKO4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 06:14:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34386 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfGGKO4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 06:14:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id p10so6196197pgn.1;
        Sun, 07 Jul 2019 03:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=9b1EGXOx4NeF4JTA7eM5HskbqythmMpkxkl1a4JGzA0=;
        b=UUVurbNoPqHqrmeUuvp4JhwWnf7tIMiogR4wNFWQy2Yg9s0VDKYMOBYp0alcm7xqmy
         prWWl/SDvlnKeuMa3qIGX7xJhsnZD5ZGIl+UlAOi160yk/UEHKohpIEmKZ3npBPCrX+O
         ChPr9CSJ3Wbe89Qg2S2hpHTW7IF1PzJiilIeJaqgAQDCB2LJulNX7jAVvnMa6t/1LiAI
         iM1IFlpvK+lxOvAKnW1POkq5CLL5gNZGa3UPh59xMtXfATagAZIu0Nlw5nTGCUAoSV4B
         9hrJ2bI5CAbD7NOn8VQJEvw6TgykLcOf8/OryLjdATYGQCEEPLduB8OwesvLFxmnoFOV
         3Jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=9b1EGXOx4NeF4JTA7eM5HskbqythmMpkxkl1a4JGzA0=;
        b=L95hDnkTKWoiv0u9sl0/FlGqTdpZk8OrGl36bobVikrPvk2xkm4+wIVHW028bFcYSC
         BU9cgYnDIl9hRLj4vPj5aGO+k0Y5DyKnBss8R4ET/sTE6ywjy1pe7+ZuAIb619Lqow8l
         BbK0AnNX/E+OSpjUslm1nLXYEG74U6ZKzvshVwITWAhCNio4JdO5AlsYww5lrhvTRBWV
         ud/wdsXRt0htdkNHlkLnd+zbrAQA+p1pGrLq9gNUUmnnP43vAmk8M1aR1LHBkP5k7MY3
         4DSXXmyO+ThWFPx2VPPdXKdVeYTqhhqgG++NjpNboP/QuEid0LS73Qvp0WZYfeaDgnPN
         zGfg==
X-Gm-Message-State: APjAAAX4udIoO8vsz9bqIO70XY7pMnGyEF3+s7tJ/HoO5BFnHNNSaXYn
        Fw/Sb5zxxZj4p8fRPGGSouKid/jd
X-Google-Smtp-Source: APXvYqw7+g7XXTJSX6Asjijq/vU5Vo5FyhGnvQSw6y6Wxkp4QA/7+N00beHz2HuLJBcfPMN/BdiKhw==
X-Received: by 2002:a17:90a:290b:: with SMTP id g11mr16776527pjd.122.1562494495653;
        Sun, 07 Jul 2019 03:14:55 -0700 (PDT)
Received: from localhost ([203.111.179.197])
        by smtp.gmail.com with ESMTPSA id u137sm14324745pgc.91.2019.07.07.03.14.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Jul 2019 03:14:54 -0700 (PDT)
Date:   Sun, 07 Jul 2019 20:13:16 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 1/3] cpuidle-powernv : forced wakeup for stop states
To:     Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     daniel.lezcano@linaro.org, dja@axtens.net, ego@linux.vnet.ibm.com,
        mpe@ellerman.id.au, rjw@rjwysocki.net
References: <20190704091827.19555-1-huntbag@linux.vnet.ibm.com>
        <20190704091827.19555-2-huntbag@linux.vnet.ibm.com>
In-Reply-To: <20190704091827.19555-2-huntbag@linux.vnet.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1562493994.wseoth6w1s.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Abhishek Goel's on July 4, 2019 7:18 pm:
> Currently, the cpuidle governors determine what idle state a idling CPU
> should enter into based on heuristics that depend on the idle history on
> that CPU. Given that no predictive heuristic is perfect, there are cases
> where the governor predicts a shallow idle state, hoping that the CPU wil=
l
> be busy soon. However, if no new workload is scheduled on that CPU in the
> near future, the CPU may end up in the shallow state.
>=20
> This is problematic, when the predicted state in the aforementioned
> scenario is a shallow stop state on a tickless system. As we might get
> stuck into shallow states for hours, in absence of ticks or interrupts.
>=20
> To address this, We forcefully wakeup the cpu by setting the
> decrementer. The decrementer is set to a value that corresponds with the
> residency of the next available state. Thus firing up a timer that will
> forcefully wakeup the cpu. Few such iterations will essentially train the
> governor to select a deeper state for that cpu, as the timer here
> corresponds to the next available cpuidle state residency. Thus, cpu will
> eventually end up in the deepest possible state.
>=20
> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> ---
>=20
> Auto-promotion
>  v1 : started as auto promotion logic for cpuidle states in generic
> driver
>  v2 : Removed timeout_needed and rebased the code to upstream kernel
> Forced-wakeup
>  v1 : New patch with name of forced wakeup started
>  v2 : Extending the forced wakeup logic for all states. Setting the
> decrementer instead of queuing up a hrtimer to implement the logic.
>  v3 : Cleanly handle setting/resetting of decrementer so as to not break
> irq work=20
>=20
>  arch/powerpc/include/asm/time.h   |  2 ++
>  arch/powerpc/kernel/time.c        | 40 +++++++++++++++++++++++++++++++
>  drivers/cpuidle/cpuidle-powernv.c | 32 +++++++++++++++++++++++++
>  3 files changed, 74 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/t=
ime.h
> index 54f4ec1f9..a3bd4f3c0 100644
> --- a/arch/powerpc/include/asm/time.h
> +++ b/arch/powerpc/include/asm/time.h
> @@ -188,6 +188,8 @@ static inline unsigned long tb_ticks_since(unsigned l=
ong tstamp)
>  extern u64 mulhdu(u64, u64);
>  #endif
> =20
> +extern int set_dec_before_idle(u64 timeout);
> +extern void reset_dec_after_idle(void);
>  extern void div128_by_32(u64 dividend_high, u64 dividend_low,
>  			 unsigned divisor, struct div_result *dr);
> =20
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 694522308..814de3469 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -576,6 +576,46 @@ void arch_irq_work_raise(void)
> =20
>  #endif /* CONFIG_IRQ_WORK */
> =20
> +/*
> + * Returns 1 if we have reprogrammed the decrementer for idle.
> + * Returns 0 if the decrementer is unchanged.
> + */
> +int set_dec_before_idle(u64 timeout)
> +{
> +	u64 *next_tb =3D this_cpu_ptr(&decrementers_next_tb);
> +	u64 now =3D get_tb_or_rtc();
> +
> +	/*
> +	 * Ensure that the timeout is at least one microsecond
> +	 * before the current decrement value. Else, we will
> +	 * unnecesarily wakeup again within a microsecond.
> +	 */
> +	if (now + timeout + 512 > *next_tb)

I would pass this 512 in as a parameter and put the comment in the
idle code. Timer code does not know/care.

Maybe return bool and call it try_set_dec_before_idle.

> +		return 0;
> +
> +	set_dec(timeout);

This needs to have

  if (test_irq_work_pending())
      set_dec(1);

here AFAIKS

> +
> +	return 1;
> +}
> +
> +void reset_dec_after_idle(void)
> +{
> +	u64 now;
> +	u64 *next_tb;
> +
> +	if (test_irq_work_pending())
> +		return;
> +
> +	now =3D get_tb_or_rtc();
> +	next_tb =3D this_cpu_ptr(&decrementers_next_tb);
> +	if (now >=3D *next_tb)
> +		return;

Are you sure it's okay to escape early in this case?

Thanks,
Nick
=

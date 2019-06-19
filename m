Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8E6B4B0D8
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 06:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbfFSE2L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 00:28:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46484 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfFSE2L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 00:28:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id 81so8926955pfy.13;
        Tue, 18 Jun 2019 21:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=DGRb75yIjtPnzydCGSmKGs8fdmo+cuZrHDcr1XkPuQM=;
        b=q9XM9tOobAlpop+hLOk+0kNdRTkTayvyMR9QQzblOS+NwyEr82jcMdUh72VpnoJSw2
         X5E2bfbR2ppPXcbNEHgwwsH9BtwqTN5/4Hd/y+e+HMdaBIOLdkA4rApPVFogpsj7KxQq
         ghm+j1vEdjn/nskYmniuPfFv6DwBU0zMBZC9nPNKNY7vg3Gk5UciFW6aeAV4kk8ILFjV
         EjfKAnvrExeiy9OO/Nx3HZxDedk48F2mCdKXYG/lKYpbjNObnc2Hkc4C/ywWVBMEDY20
         8go3l8PZBT7AKo438sROdhGvYBKBXOq9pLp9H+JHpNICEv0J8LpMcTFdVRSp/SPW21+z
         cWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=DGRb75yIjtPnzydCGSmKGs8fdmo+cuZrHDcr1XkPuQM=;
        b=ga85AmDm3bJTygnCOUIYTlgv+Ojw6gikrngaDGslKMI7VkRp9XDAcBrNWxANrTZuE9
         upz6GM/SJwdfGf0+0x7JDWcl+CvOUVh8mpX5vd14yloiUWMLfnE10t7B2QLzylhyG1QC
         U793SJ6A59g/Zy3Z1/KYl5ixq18NW2igk6AT6RuZjbfpnjyvlrH5KZnVxP3A8titVg+C
         ye6NYiv4npDTDDnl+iqqMSYvhAyp0KxFjrWeI3sCdxkCUuaLGSTPcxg4TgWy/7NRjDZ+
         /ZU9M9yu9L9KJl+Fdy3mAPJH/HRq5je21V7y8580fjFyeuffkxky31R5wly1PJWGqF8P
         pgNQ==
X-Gm-Message-State: APjAAAXtDxgzF8FTn/wvOx3QlKWs/Q0ezUAivgTUhRMLKKSSAo0WvuOq
        XA70whn438B21IdqRPTrvpg=
X-Google-Smtp-Source: APXvYqyPQRgQfyEQQsCe5fedY34G1dLdn4PVJf15gt4z1w2xvO+JpWBC0RAdTsK+BDq6JqldiDwhrQ==
X-Received: by 2002:a63:18c:: with SMTP id 134mr1359993pgb.432.1560918490535;
        Tue, 18 Jun 2019 21:28:10 -0700 (PDT)
Received: from localhost (193-116-92-108.tpgi.com.au. [193.116.92.108])
        by smtp.gmail.com with ESMTPSA id r15sm21539691pfc.162.2019.06.18.21.28.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 21:28:09 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:23:03 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/1] cpuidle-powernv : forced wakeup for stop states
To:     Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     daniel.lezcano@linaro.org, dja@axtens.net, ego@linux.vnet.ibm.com,
        mpe@ellerman.id.au, rjw@rjwysocki.net
References: <20190617095648.18847-1-huntbag@linux.vnet.ibm.com>
        <20190617095648.18847-2-huntbag@linux.vnet.ibm.com>
In-Reply-To: <20190617095648.18847-2-huntbag@linux.vnet.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1560917320.mk5nn6r8jw.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Abhishek Goel's on June 17, 2019 7:56 pm:
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
>=20
>  drivers/cpuidle/cpuidle-powernv.c | 38 +++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>=20
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-=
powernv.c
> index 84b1ebe212b3..bc9ca18ae7e3 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -46,6 +46,26 @@ static struct stop_psscr_table stop_psscr_table[CPUIDL=
E_STATE_MAX] __read_mostly
>  static u64 default_snooze_timeout __read_mostly;
>  static bool snooze_timeout_en __read_mostly;
> =20
> +static u64 forced_wakeup_timeout(struct cpuidle_device *dev,
> +				 struct cpuidle_driver *drv,
> +				 int index)
> +{
> +	int i;
> +
> +	for (i =3D index + 1; i < drv->state_count; i++) {
> +		struct cpuidle_state *s =3D &drv->states[i];
> +		struct cpuidle_state_usage *su =3D &dev->states_usage[i];
> +
> +		if (s->disabled || su->disable)
> +			continue;
> +
> +		return (s->target_residency + 2 * s->exit_latency) *
> +			tb_ticks_per_usec;
> +	}
> +
> +	return 0;
> +}

It would be nice to not have this kind of loop iteration in the
idle fast path. Can we add a flag or something to the idle state?

> +
>  static u64 get_snooze_timeout(struct cpuidle_device *dev,
>  			      struct cpuidle_driver *drv,
>  			      int index)
> @@ -144,8 +164,26 @@ static int stop_loop(struct cpuidle_device *dev,
>  		     struct cpuidle_driver *drv,
>  		     int index)
>  {
> +	u64 dec_expiry_tb, dec, timeout_tb, forced_wakeup;
> +
> +	dec =3D mfspr(SPRN_DEC);
> +	timeout_tb =3D forced_wakeup_timeout(dev, drv, index);
> +	forced_wakeup =3D 0;
> +
> +	if (timeout_tb && timeout_tb < dec) {
> +		forced_wakeup =3D 1;
> +		dec_expiry_tb =3D mftb() + dec;
> +	}

The compiler probably can't optimise away the SPR manipulations so try
to avoid them if possible.

> +
> +	if (forced_wakeup)
> +		mtspr(SPRN_DEC, timeout_tb);

This should just be put in the above 'if'.

> +
>  	power9_idle_type(stop_psscr_table[index].val,
>  			 stop_psscr_table[index].mask);
> +
> +	if (forced_wakeup)
> +		mtspr(SPRN_DEC, dec_expiry_tb - mftb());

This will sometimes go negative and result in another timer interrupt.

It also breaks irq work (which can be set here by machine check I
believe.

May need to implement some timer code to do this for you.

static void reset_dec_after_idle(void)
{
	u64 now;
        u64 *next_tb;

	if (test_irq_work_pending())
		return;
	now =3D mftb;
	next_tb =3D this_cpu_ptr(&decrementers_next_tb);

	if (now >=3D *next_tb)
		return;
	set_dec(*next_tb - now);
	if (test_irq_work_pending())
		set_dec(1);
}

Something vaguely like that. See timer_interrupt().

Thanks,
Nick
=

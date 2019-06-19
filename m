Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C14AD4B603
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 12:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfFSKOv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 06:14:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45826 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfFSKOu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 06:14:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id s21so9375682pga.12;
        Wed, 19 Jun 2019 03:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=6i/GeqDjrWmWov4kQahlGNOB5ZKJs7UV4GwUkEvu3yE=;
        b=FUDCIHmFiUaivC6kaQ3sYLdpKaBpcxhLQ9X2o5L+O94uzKtvv9zvu60l2fomkBKnV/
         9QPowqfeNME5ed0XLxG3s3/PQjhBJflMH9euC8V69JQCPWUq5/Rq+LFzBKwjPlfyXifz
         XMM7uqD1JdmNFPCw6NWSRyGdZGdVFGUkj9JeIKG6xmWy1XDD7L0YQpj4L3R/snt1oquS
         zmhDk2R2Qh/xU0Nob8jwT+HG667MtRGcui31L613/u7+O2Xc6/IyKQ/u57oAkTKWxExh
         B6BwwQEeXQfdkV1CiJNXdRtEIKJuLSYKH6hFQN49zdHXaExlalQ/brt1zRyLDPOZ1DMh
         wtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=6i/GeqDjrWmWov4kQahlGNOB5ZKJs7UV4GwUkEvu3yE=;
        b=A+b27+7GdO11tyNUEC5icmdnOCeAp/QowcS1wYWmuAuxQx+SUqWd6WgO3B7ZoSd1Aq
         Hmcooq0HGvyrt9rwXxcO6McQoMJe3+XN9P0grn1qkXbr5JN0ScgKibC3nHnxhOrdkxKD
         82u5XyvTzkGVC4DI2l4Bsnk3Gskr0ThqzcJNWioPkXhevkfRnKiyy8ZptgTa4laZWsPB
         O6rk73FTbVFm8/Cq+ZsHhhZD6aAqM8G8dtLClO87KjPPvGGqUlu37UGhQ4pVyiGk00lc
         /hErhdKKdKSMIwoFvB+fzOHi5Usprdcu6Gh9zxSZdjWBMcb8H6c+Cd8UTzo6AvW9N9eg
         cy7g==
X-Gm-Message-State: APjAAAXMe/u6Ca2xVhQ/2iF5G9HHX9fZzIiSQIz0tS8UBesCOMT1B3p3
        WJh66kDYdvbclXP/ETCtzfQ=
X-Google-Smtp-Source: APXvYqwwcbJwmLM8R4kXz9EDK8fOmfB/NTHOIXIR8Nghol24uNK6j1dHGi22a8Jur1GfGfSK0OwCDg==
X-Received: by 2002:aa7:82cd:: with SMTP id f13mr129011930pfn.203.1560939289993;
        Wed, 19 Jun 2019 03:14:49 -0700 (PDT)
Received: from localhost (193-116-92-108.tpgi.com.au. [193.116.92.108])
        by smtp.gmail.com with ESMTPSA id r1sm14141972pfq.100.2019.06.19.03.14.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 03:14:49 -0700 (PDT)
Date:   Wed, 19 Jun 2019 20:09:32 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/1] cpuidle-powernv : forced wakeup for stop states
To:     Abhishek <huntbag@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     daniel.lezcano@linaro.org, dja@axtens.net, ego@linux.vnet.ibm.com,
        mpe@ellerman.id.au, rjw@rjwysocki.net
References: <20190617095648.18847-1-huntbag@linux.vnet.ibm.com>
        <20190617095648.18847-2-huntbag@linux.vnet.ibm.com>
        <1560917320.mk5nn6r8jw.astroid@bobo.none>
        <689a52a7-7bfc-7225-e563-ac07f7357e75@linux.vnet.ibm.com>
In-Reply-To: <689a52a7-7bfc-7225-e563-ac07f7357e75@linux.vnet.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1560938644.5ukemauqsy.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Abhishek's on June 19, 2019 7:08 pm:
> Hi Nick,
>=20
> Thanks for the review. Some replies below.
>=20
> On 06/19/2019 09:53 AM, Nicholas Piggin wrote:
>> Abhishek Goel's on June 17, 2019 7:56 pm:
>>> Currently, the cpuidle governors determine what idle state a idling CPU
>>> should enter into based on heuristics that depend on the idle history o=
n
>>> that CPU. Given that no predictive heuristic is perfect, there are case=
s
>>> where the governor predicts a shallow idle state, hoping that the CPU w=
ill
>>> be busy soon. However, if no new workload is scheduled on that CPU in t=
he
>>> near future, the CPU may end up in the shallow state.
>>>
>>> This is problematic, when the predicted state in the aforementioned
>>> scenario is a shallow stop state on a tickless system. As we might get
>>> stuck into shallow states for hours, in absence of ticks or interrupts.
>>>
>>> To address this, We forcefully wakeup the cpu by setting the
>>> decrementer. The decrementer is set to a value that corresponds with th=
e
>>> residency of the next available state. Thus firing up a timer that will
>>> forcefully wakeup the cpu. Few such iterations will essentially train t=
he
>>> governor to select a deeper state for that cpu, as the timer here
>>> corresponds to the next available cpuidle state residency. Thus, cpu wi=
ll
>>> eventually end up in the deepest possible state.
>>>
>>> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
>>> ---
>>>
>>> Auto-promotion
>>>   v1 : started as auto promotion logic for cpuidle states in generic
>>> driver
>>>   v2 : Removed timeout_needed and rebased the code to upstream kernel
>>> Forced-wakeup
>>>   v1 : New patch with name of forced wakeup started
>>>   v2 : Extending the forced wakeup logic for all states. Setting the
>>> decrementer instead of queuing up a hrtimer to implement the logic.
>>>
>>>   drivers/cpuidle/cpuidle-powernv.c | 38 ++++++++++++++++++++++++++++++=
+
>>>   1 file changed, 38 insertions(+)
>>>
>>> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidl=
e-powernv.c
>>> index 84b1ebe212b3..bc9ca18ae7e3 100644
>>> --- a/drivers/cpuidle/cpuidle-powernv.c
>>> +++ b/drivers/cpuidle/cpuidle-powernv.c
>>> @@ -46,6 +46,26 @@ static struct stop_psscr_table stop_psscr_table[CPUI=
DLE_STATE_MAX] __read_mostly
>>>   static u64 default_snooze_timeout __read_mostly;
>>>   static bool snooze_timeout_en __read_mostly;
>>>  =20
>>> +static u64 forced_wakeup_timeout(struct cpuidle_device *dev,
>>> +				 struct cpuidle_driver *drv,
>>> +				 int index)
>>> +{
>>> +	int i;
>>> +
>>> +	for (i =3D index + 1; i < drv->state_count; i++) {
>>> +		struct cpuidle_state *s =3D &drv->states[i];
>>> +		struct cpuidle_state_usage *su =3D &dev->states_usage[i];
>>> +
>>> +		if (s->disabled || su->disable)
>>> +			continue;
>>> +
>>> +		return (s->target_residency + 2 * s->exit_latency) *
>>> +			tb_ticks_per_usec;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>> It would be nice to not have this kind of loop iteration in the
>> idle fast path. Can we add a flag or something to the idle state?
> Currently, we do not have any callback notification or some feedback that
> notifies the driver everytime some state is enabled/disabled. So we have
> to parse everytime to get the next enabled state.

Ahh, that's why you're doing that.

> Are you suggesting to
> add something like next_enabled_state in cpuidle state structure itself
> which will be updated when a state is enabled or disabled?

Hmm, I guess it normally should not iterate over more than one state
unless some idle states are disabled.

What would have been nice is each state just have its own timeout
field with ticks already calculated, if that could be updated when
a state is enabled or disabled. How hard is that to add to the
cpuidle core?

>>> +
>>>   static u64 get_snooze_timeout(struct cpuidle_device *dev,
>>>   			      struct cpuidle_driver *drv,
>>>   			      int index)
>>> @@ -144,8 +164,26 @@ static int stop_loop(struct cpuidle_device *dev,
>>>   		     struct cpuidle_driver *drv,
>>>   		     int index)
>>>   {
>>> +	u64 dec_expiry_tb, dec, timeout_tb, forced_wakeup;
>>> +
>>> +	dec =3D mfspr(SPRN_DEC);
>>> +	timeout_tb =3D forced_wakeup_timeout(dev, drv, index);
>>> +	forced_wakeup =3D 0;
>>> +
>>> +	if (timeout_tb && timeout_tb < dec) {
>>> +		forced_wakeup =3D 1;
>>> +		dec_expiry_tb =3D mftb() + dec;
>>> +	}
>> The compiler probably can't optimise away the SPR manipulations so try
>> to avoid them if possible.
> Are you suggesting something like set_dec_before_idle?(in line with
> what you have suggested to do after idle, reset_dec_after_idle)

I should have been clear, I meant don't mfspr(SPRN_DEC) until you
have tested timeout_tb.

>>> +
>>> +	if (forced_wakeup)
>>> +		mtspr(SPRN_DEC, timeout_tb);
>> This should just be put in the above 'if'.
> Fair point.
>>
>>> +
>>>   	power9_idle_type(stop_psscr_table[index].val,
>>>   			 stop_psscr_table[index].mask);
>>> +
>>> +	if (forced_wakeup)
>>> +		mtspr(SPRN_DEC, dec_expiry_tb - mftb());
>> This will sometimes go negative and result in another timer interrupt.
>>
>> It also breaks irq work (which can be set here by machine check I
>> believe.
>>
>> May need to implement some timer code to do this for you.
>>
>> static void reset_dec_after_idle(void)
>> {
>> 	u64 now;
>>          u64 *next_tb;
>>
>> 	if (test_irq_work_pending())
>> 		return;
>> 	now =3D mftb;
>> 	next_tb =3D this_cpu_ptr(&decrementers_next_tb);
>>
>> 	if (now >=3D *next_tb)
>> 		return;
>> 	set_dec(*next_tb - now);
>> 	if (test_irq_work_pending())
>> 		set_dec(1);
>> }
>>
>> Something vaguely like that. See timer_interrupt().
> Ah, Okay. Will go through timer_interrupt().

Thanks,
Nick

=

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC9911220F
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 05:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfLDEZE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 23:25:04 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33508 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLDEZE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 23:25:04 -0500
Received: by mail-qt1-f193.google.com with SMTP id d5so6434973qto.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2019 20:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B9MmqnRWtIVp3fWfwFCcQm9pMRp0v8IC2cGtCdVC9mo=;
        b=fdC3HliYjNYkiWW8//bSAD7lm5j9z97Yiv0EvZ6ncNzaC6UMQx4ZFw5zc+ETAygLIL
         mQv3ZgTo0/EvsBukCSUbHP0oiR26oHJHuEqPS182nyW5zsePj12uSH11H/9fENjbOKU4
         6oYq4o+htkCpvM3yAWGJMMAeMRPiFTLKQlVI5QA3H/OJaF7QDVQD1oDWN667IYisSWpY
         NgRuEbSBy4kqhH3n2Nj4GhEJgmoxMTD65D6le4YYhR/S4mGTIqL5PRHtbEkllEjGH2ja
         7jmEFYiHeBw/5QofkfbI6w6I/NKBrQk71uGFSqncF/DxDTk9QArkUt7Los03XmLqUd5c
         Y/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B9MmqnRWtIVp3fWfwFCcQm9pMRp0v8IC2cGtCdVC9mo=;
        b=Rgp5YffhG/6QwVks96la1sia5QK9kUsiKQE9HgmDJLfaNvMMwpDEpS/FH9eHsjZvRb
         dC/4nBxIkk422HU9d728riGP5jympogwsXQOP8x/TVLI1mJTg6MOOVz6m++Zu3dSKjif
         NLWRyzHDo88lkChH5dh3kHKDLl12Kvujo0ieYQdsYpbKOlW9iG5AJxZS9SspgChcojpx
         GS9APg8dR6V23+Fx/W62h/QM9yXHjPYbRfPmy4BSUKatWLN4GDXbUsMWSnUO3qIwJuRv
         y6M3w9LlzBQMIEdsiOFVLK990egxEAqFjBJR5op/h6b00DUBrfryvpl3yuLRTz7oaPJP
         pWcA==
X-Gm-Message-State: APjAAAU5qmTtdZR0uHnzxk+4hgPGFgovVR9xW8ajXVkTlzh4cpiIxj6u
        A3zRHkoplPY5IMcpnxhhvpecvYN/Cz9UePqODdCM2A==
X-Google-Smtp-Source: APXvYqydGfQv0uEelxFJkSBYHU7qx8JzqjgefaZW1j0Obon9Qa2gCm+oYB1TDeYFAZ6xkXCjqD6Ce3GBLetwNkYvVVc=
X-Received: by 2002:ac8:3177:: with SMTP id h52mr1082749qtb.264.1575433502917;
 Tue, 03 Dec 2019 20:25:02 -0800 (PST)
MIME-Version: 1.0
References: <20191203093704.7037-1-daniel.lezcano@linaro.org> <20191203093704.7037-2-daniel.lezcano@linaro.org>
In-Reply-To: <20191203093704.7037-2-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 4 Dec 2019 09:54:51 +0530
Message-ID: <CAP245DV=kd=LdvgZ2x1Q8-ZahpS3423Z9vHXw91N20aQ6DKxAQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/4] thermal/drivers/cpu_cooling: Add idle cooling
 device documentation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 3, 2019 at 3:07 PM Daniel Lezcano <daniel.lezcano@linaro.org> w=
rote:
>
> Provide some documentation for the idle injection cooling effect in
> order to let people to understand the rational of the approach for the

s/rational/rationale

> idle injection CPU cooling device.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../driver-api/thermal/cpu-idle-cooling.rst   | 166 ++++++++++++++++++
>  1 file changed, 166 insertions(+)
>  create mode 100644 Documentation/driver-api/thermal/cpu-idle-cooling.rst
>
> diff --git a/Documentation/driver-api/thermal/cpu-idle-cooling.rst b/Docu=
mentation/driver-api/thermal/cpu-idle-cooling.rst
> new file mode 100644
> index 000000000000..457cd9979ddb
> --- /dev/null
> +++ b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
> @@ -0,0 +1,166 @@
> +
> +Situation:
> +----------
> +
> +Under certain circumstances a SoC can reach the maximum temperature
> +limit or is unable to stabilize the temperature around a temperature

s/the maximum/a critical/

s/or/and/

> +control. When the SoC has to stabilize the temperature, the kernel can
> +act on a cooling device to mitigate the dissipated power. When the
> +maximum temperature is reached and to prevent a reboot or a shutdown,
> +a decision must be taken to reduce the temperature under the critical
> +threshold, that impacts the performance.

Consider replacing above paragraph with:

When the critical temperature is reached, a decision must be taken to
reduce the temperature, that, in turn impacts performance.

> +
> +Another situation is when the silicon reaches a certain temperature
> +which continues to increase even if the dynamic leakage is reduced to
> +its minimum by clock gating the component. The runaway phenomena will

s/phenomena/phenomenon/

> +continue with the static leakage and only powering down the component,
> +thus dropping the dynamic and static leakage will allow the component
> +to cool down.
> +

Consider rephrasing as,

Another situation is when the silicon temperature continues to
increase even after the dynamic leakage is reduced to its minimum by
clock gating the component. This runaway phenomenon can continue due
to the static leakage. The only solution is to power down the
component, thus dropping the dynamic and static leakage that will
allow the component to cool down.


> +Last but not least, the system can ask for a specific power budget but
> +because of the OPP density, we can only choose an OPP with a power
> +budget lower than the requested one and underuse the CPU, thus losing
> +performances. In other words, one OPP under uses the CPU with a power

s/performances/performance.

s/underuse/under-utlilize/
s/under use/under-utlilizes/

> +lesser than the power budget and the next OPP exceed the power budget,

s/lesser than the/less than the requested/
s/exceed/exceeds/

> +an intermediate OPP could have been used if it were present.

Make this a new sentence.

> +
> +Solutions:
> +----------
> +
> +If we can remove the static and the dynamic leakage for a specific
> +duration in a controlled period, the SoC temperature will
> +decrease. Acting at the idle state duration or the idle cycle

s/at/for/ ?

> +injection period, we can mitigate the temperature by modulating the
> +power budget.
> +
> +The Operating Performance Point (OPP) density has a great influence on
> +the control precision of cpufreq, however different vendors have a
> +plethora of OPP density, and some have large power gap between OPPs,
> +that will result in loss of performance during thermal control and
> +loss of power in other scenes.

s/scenes/scenarios/

> +
> +At a specific OPP, we can assume injecting idle cycle on all CPUs,
> +belonging to the same cluster, with a duration greater than the

Change to "we can assume that injecting idle cycles on all CPUs belong
to the same cluster"

> +cluster idle state target residency, we drop the static and the

s/we drop/will lead to dropping/

> +dynamic leakage for this period (modulo the energy needed to enter
> +this state). So the sustainable power with idle cycles has a linear
> +relation with the OPP=E2=80=99s sustainable power and can be computed wi=
th a
> +coefficient similar to:
> +
> +           Power(IdleCycle) =3D Coef x Power(OPP)
> +
> +Idle Injection:
> +---------------
> +
> +The base concept of the idle injection is to force the CPU to go to an
> +idle state for a specified time each control cycle, it provides
> +another way to control CPU power and heat in addition to
> +cpufreq. Ideally, if all CPUs belonging to the same cluster, inject
> +their idle cycle synchronously, the cluster can reach its power down

cycles

> +state with a minimum power consumption and static leakage
> +drop. However, these idle cycles injection will add extra latencies as

s/static leakage drop/reduce static leakage to (almost) zero/

> +the CPUs will have to wakeup from a deep sleep state.
> +
> +     ^
> +     |
> +     |
> +     |-------       -------       -------
> +     |_______|_____|_______|_____|_______|___________
> +
> +      <----->
> +       idle  <---->
> +              running
> +
> +With the fixed idle injection duration, we can give a value which is
> +an acceptable performance drop off or latency when we reach a specific
> +temperature and we begin to mitigate by varying the Idle injection
> +period.
> +

I'm not sure what it the purpose of this statement. You've described
how the period value starts at a maximum and is adjusted dynamically
below.

> +The mitigation begins with a maximum period value which decrease when

Shouldn't the idle injection period increase to get more cooling effect?

> +more cooling effect is requested. When the period duration is equal to
> +the idle duration, then we are in a situation the platform can=E2=80=99t
> +dissipate the heat enough and the mitigation fails. In this case the
> +situation is considered critical and there is nothing to do. The idle
> +injection duration must be changed by configuration and until we reach
> +the cooling effect, otherwise an additionnal cooling device must be

typo: additional

> +used or ultimately decrease the SoC performance by dropping the
> +highest OPP point of the SoC.
> +
> +The idle injection duration value must comply with the constraints:
> +
> +- It is lesser or equal to the latency we tolerate when the mitigation

s/lesser/less than/

> +  begins. It is platform dependent and will depend on the user
> +  experience, reactivity vs performance trade off we want. This value
> +  should be specified.
> +
> +- It is greater than the idle state=E2=80=99s target residency we want t=
o go
> +  for thermal mitigation, otherwise we end up consuming more energy.
> +
> +Minimum period
> +--------------
> +
> +The idle injection duration being fixed, it is obvious the minimum

Change to:
When the idle injection duration is fixed,

> +period can=E2=80=99t be lesser than that, otherwise we will be schedulin=
g the
> +idle injection task right before the idle injection duration is
> +complete, so waking up the CPU to put it asleep again.
> +
> +Maximum period
> +--------------
> +
> +The maximum period is the initial period when the mitigation
> +begins. Theoretically when we reach the thermal trip point, we have to
> +sustain a specified power for specific temperature but at this time we
> +consume:
> +
> + Power =3D Capacitance x Voltage^2 x Frequency x Utilisation
> +
> +... which is more than the sustainable power (or there is something
> +wrong on the system setup). The =E2=80=98Capacitance=E2=80=99 and =E2=80=
=98Utilisation=E2=80=99 are a

s/on/in/

> +fixed value, =E2=80=98Voltage=E2=80=99 and the =E2=80=98Frequency=E2=80=
=99 are fixed artificially
> +because we don=E2=80=99t want to change the OPP. We can group the
> +=E2=80=98Capacitance=E2=80=99 and the =E2=80=98Utilisation=E2=80=99 into=
 a single term which is the
> +=E2=80=98Dynamic Power Coefficient (Cdyn)=E2=80=99 Simplifying the above=
, we have:
> +
> + Pdyn =3D Cdyn x Voltage^2 x Frequency
> +
> +The IPA will ask us somehow to reduce our power in order to target the

s/IPA/power allocator governor/

> +sustainable power defined in the device tree. So with the idle
> +injection mechanism, we want an average power (Ptarget) resulting on

s/on/in

> +an amount of time running at full power on a specific OPP and idle
> +another amount of time. That could be put in a equation:
> +
> + P(opp)target =3D ((trunning x (P(opp)running) + (tidle P(opp)idle)) /

missed a 'x' after tidle.

Suggest using capital T for time everwhere to make it easier to read.

> +                       (trunning + tidle)
> +  ...
> +
> + tidle =3D trunning x ((P(opp)running / P(opp)target) - 1)
> +
> +At this point if we know the running period for the CPU, that gives us
> +the idle injection, we need. Alternatively if we have the idle

Lose the comma.

> +injection duration, we can compute the running duration with:
> +
> + trunning =3D tidle / ((P(opp)running / P(opp)target) - 1)
> +
> +Practically, if the running power is lesses than the targeted power,

s/lesses/less/

> +we end up with a negative time value, so obviously the equation usage
> +is bound to a power reduction, hence a higher OPP is needed to have
> +the running power greater than the targeted power.
> +
> +However, in this demonstration we ignore three aspects:
> +
> + * The static leakage is not defined here, we can introduce it in the
> +   equation but assuming it will be zero most of the time as it is
> +   difficult to get the values from the SoC vendors
> +
> + * The idle state wake up latency (or entry + exit latency) is not
> +   taken into account, it must be added in the equation in order to
> +   rigorously compute the idle injection
> +
> + * The injected idle duration must be greater than the idle state
> +   target residency, otherwise we end up consuming more energy and
> +   potentially invert the mitigation effect
> +
> +So the final equation is:
> +
> + trunning =3D (tidle - twakeup ) x
> +               (((P(opp)dyn + P(opp)static ) - P(opp)target) / P(opp)tar=
get )
> --
> 2.17.1
>

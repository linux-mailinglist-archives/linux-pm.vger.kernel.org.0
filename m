Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9162311C6DE
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 09:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfLLIQq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Dec 2019 03:16:46 -0500
Received: from comms.puri.sm ([159.203.221.185]:48208 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfLLIQq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Dec 2019 03:16:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 3D198E01F3;
        Thu, 12 Dec 2019 00:16:44 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IVaT9x0ILVlj; Thu, 12 Dec 2019 00:16:43 -0800 (PST)
Subject: Re: [PATCH V5 1/3] thermal/drivers/cpu_cooling: Add idle cooling
 device documentation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        viresh.kumar@linaro.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org
References: <20191211224347.1001-1-daniel.lezcano@linaro.org>
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
Autocrypt: addr=martin.kepplinger@puri.sm; keydata=
 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
 ekMtxgNYb/8oDry09UFHbGHLsWn6oBo=
Message-ID: <6206b0c7-0f3a-80df-efa8-4f88939615d4@puri.sm>
Date:   Thu, 12 Dec 2019 09:16:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20191211224347.1001-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11.12.19 23:43, Daniel Lezcano wrote:
> Provide some documentation for the idle injection cooling effect in
> order to let people to understand the rational of the approach for the
> idle injection CPU cooling device.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Martin Kepplinger <martin.kepplinger@puri.sm>

thanks

> ---
>   V4:
>     - Fixed typos, replaced 'period' per 'duty cycles', clarified some
>       wording (Amit Kucheria)
> ---
>  .../driver-api/thermal/cpu-idle-cooling.rst   | 189 ++++++++++++++++++
>  1 file changed, 189 insertions(+)
>  create mode 100644 Documentation/driver-api/thermal/cpu-idle-cooling.rst
> 
> diff --git a/Documentation/driver-api/thermal/cpu-idle-cooling.rst b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
> new file mode 100644
> index 000000000000..13d7fe4e8de8
> --- /dev/null
> +++ b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
> @@ -0,0 +1,189 @@
> +
> +Situation:
> +----------
> +
> +Under certain circumstances a SoC can reach a critical temperature
> +limit and is unable to stabilize the temperature around a temperature
> +control. When the SoC has to stabilize the temperature, the kernel can
> +act on a cooling device to mitigate the dissipated power. When the
> +critical temperature is reached, a decision must be taken to reduce
> +the temperature, that, in turn impacts performance.
> +
> +Another situation is when the silicon temperature continues to
> +increase even after the dynamic leakage is reduced to its minimum by
> +clock gating the component. This runaway phenomenon can continue due
> +to the static leakage. The only solution is to power down the
> +component, thus dropping the dynamic and static leakage that will
> +allow the component to cool down.
> +
> +Last but not least, the system can ask for a specific power budget but
> +because of the OPP density, we can only choose an OPP with a power
> +budget lower than the requested one and under-utilize the CPU, thus
> +losing performance. In other words, one OPP under-utilizes the CPU
> +with a power less than the requested power budget and the next OPP
> +exceeds the power budget. An intermediate OPP could have been used if
> +it were present.
> +
> +Solutions:
> +----------
> +
> +If we can remove the static and the dynamic leakage for a specific
> +duration in a controlled period, the SoC temperature will
> +decrease. Acting on the idle state duration or the idle cycle
> +injection period, we can mitigate the temperature by modulating the
> +power budget.
> +
> +The Operating Performance Point (OPP) density has a great influence on
> +the control precision of cpufreq, however different vendors have a
> +plethora of OPP density, and some have large power gap between OPPs,
> +that will result in loss of performance during thermal control and
> +loss of power in other scenarios.
> +
> +At a specific OPP, we can assume that injecting idle cycle on all CPUs
> +belong to the same cluster, with a duration greater than the cluster
> +idle state target residency, we lead to dropping the static and the
> +dynamic leakage for this period (modulo the energy needed to enter
> +this state). So the sustainable power with idle cycles has a linear
> +relation with the OPP’s sustainable power and can be computed with a
> +coefficient similar to:
> +
> +	    Power(IdleCycle) = Coef x Power(OPP)
> +
> +Idle Injection:
> +---------------
> +
> +The base concept of the idle injection is to force the CPU to go to an
> +idle state for a specified time each control cycle, it provides
> +another way to control CPU power and heat in addition to
> +cpufreq. Ideally, if all CPUs belonging to the same cluster, inject
> +their idle cycles synchronously, the cluster can reach its power down
> +state with a minimum power consumption and reduce the static leakage
> +to almost zero.  However, these idle cycles injection will add extra
> +latencies as the CPUs will have to wakeup from a deep sleep state.
> +
> +We use a fixed duration of idle injection that gives an acceptable
> +performance penalty and a fixed latency. Mitigation can be increased
> +or decreased by modulating the duty cycle of the idle injection.
> +
> +     ^
> +     |
> +     |
> +     |-------                         -------
> +     |_______|_______________________|_______|___________
> +
> +     <------>
> +       idle  <---------------------->
> +                    running
> +
> +      <----------------------------->
> +              duty cycle 25%
> +
> +	      
> +The implementation of the cooling device bases the number of states on
> +the duty cycle percentage. When no mitigation is happening the cooling
> +device state is zero, meaning the duty cycle is 0%.
> +
> +When the mitigation begins, depending on the governor's policy, a
> +starting state is selected. With a fixed idle duration and the duty
> +cycle (aka the cooling device state), the running duration can be
> +computed.
> +
> +The governor will change the cooling device state thus the duty cycle
> +and this variation will modulate the cooling effect.
> +
> +     ^
> +     |
> +     |
> +     |-------                 -------
> +     |_______|_______________|_______|___________
> +
> +     <------>
> +       idle  <-------------->
> +                running
> +
> +      <----------------------------->
> +              duty cycle 33%
> +
> +
> +     ^
> +     |
> +     |
> +     |-------         -------
> +     |_______|_______|_______|___________
> +
> +     <------>
> +       idle  <------>
> +              running
> +
> +      <------------->
> +       duty cycle 50%
> +
> +The idle injection duration value must comply with the constraints:
> +
> +- It is less than or equal to the latency we tolerate when the
> +  mitigation begins. It is platform dependent and will depend on the
> +  user experience, reactivity vs performance trade off we want. This
> +  value should be specified.
> +
> +- It is greater than the idle state’s target residency we want to go
> +  for thermal mitigation, otherwise we end up consuming more energy.
> +
> +Power considerations
> +--------------------
> +  
> +When we reach the thermal trip point, we have to sustain a specified
> +power for a specific temperature but at this time we consume:
> +
> + Power = Capacitance x Voltage^2 x Frequency x Utilisation
> +
> +... which is more than the sustainable power (or there is something
> +wrong in the system setup). The ‘Capacitance’ and ‘Utilisation’ are a
> +fixed value, ‘Voltage’ and the ‘Frequency’ are fixed artificially
> +because we don’t want to change the OPP. We can group the
> +‘Capacitance’ and the ‘Utilisation’ into a single term which is the
> +‘Dynamic Power Coefficient (Cdyn)’ Simplifying the above, we have:
> +
> + Pdyn = Cdyn x Voltage^2 x Frequency
> +
> +The power allocator governor will ask us somehow to reduce our power
> +in order to target the sustainable power defined in the device
> +tree. So with the idle injection mechanism, we want an average power
> +(Ptarget) resulting in an amount of time running at full power on a
> +specific OPP and idle another amount of time. That could be put in a
> +equation:
> +
> + P(opp)target = ((Trunning x (P(opp)running) + (Tidle x P(opp)idle)) /
> +			(Trunning + Tidle)
> +  ...
> +
> + Tidle = Trunning x ((P(opp)running / P(opp)target) - 1)
> +
> +At this point if we know the running period for the CPU, that gives us
> +the idle injection we need. Alternatively if we have the idle
> +injection duration, we can compute the running duration with:
> +
> + Trunning = Tidle / ((P(opp)running / P(opp)target) - 1)
> +
> +Practically, if the running power is less than the targeted power, we
> +end up with a negative time value, so obviously the equation usage is
> +bound to a power reduction, hence a higher OPP is needed to have the
> +running power greater than the targeted power.
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
> + Trunning = (Tidle - Twakeup ) x
> +		(((P(opp)dyn + P(opp)static ) - P(opp)target) / P(opp)target )
> 

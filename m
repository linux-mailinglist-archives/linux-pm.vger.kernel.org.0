Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25652CDF21
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 20:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgLCToi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 14:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgLCToi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2020 14:44:38 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0DBC061A4E;
        Thu,  3 Dec 2020 11:43:57 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id x16so5232102ejj.7;
        Thu, 03 Dec 2020 11:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cUaWjy7o68A9wvGaH0xfAB/1Sk7r+m3ooH1CzhMv4p4=;
        b=qYOuA62C81XoRGPrSQov1pQCdXI4LlC3azJdhm+zewi3G5J3mb80+ZjZ1tDVCWbV35
         Nj+4kv6Ddfw04OV9fr2JGmEojPL063NHTURS2ifmFf3bWqGNCpSxsLSd3QhfZak7MZyp
         Z0x1kMAWgq9WyqKsb4HYg7a9zCNGih8eI6hHy6obn4xjID/SRPq5m7nH/LjdQ1etLdQm
         c/jFGIgDxt51T0nXhEx3CvvyhNINe/dv+HuboSMCLXc463rsUMl7FlGs3KpQeUhyFXub
         +ziu4zDfPAf7VEsJ0h5X0/2eonZQCgnhlOKaReCNJPM4KUPj0gGmOZjTtwPjn1vBy7ME
         m1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cUaWjy7o68A9wvGaH0xfAB/1Sk7r+m3ooH1CzhMv4p4=;
        b=CcF/V37UunnZ5d5CiASrOFrjrkgEQU50nx+u1nIxNG6FN4QDXSNLgqKfLk0AEeprJH
         ySCn8TKPKS7PVwwy0rEnEBtzHjf7wKS2D4TWErB69carkzQx+yN0CkiV4n5kaB47MmBY
         /ZODOUop1M14IKYgzrUj1Rybk49H9+V6JJniafsiZNiqQSfYpr15+0uQWYZqv0rKHScy
         sKguO9xYZszMbsnSLkBg9mS8uY8zEYQZNLLhE4y1fFY8pNV9zAB0LC0KO7zyks8eKayA
         BBsigcxLoHZkF/ivriKDX3t0knq+bmF4b5NyOjknQtux57OzkLGl3DVRZWm2ZaljwCO2
         xxog==
X-Gm-Message-State: AOAM531CuxWNESyc8Z9Cv4xkz807gAdpXwIk6QVSDC+cvBmk6Fk8Xz7h
        lwgfJRFwQ82OMRWjOby8zFA=
X-Google-Smtp-Source: ABdhPJw0HhHLuYJmr5VY7nmK+Do0M8I+RqHzSwtUs5Sh2O1OA8qEqj8dYDgikdGo1ps1sQ1phCHl3Q==
X-Received: by 2002:a17:906:8042:: with SMTP id x2mr4261540ejw.79.1607024635954;
        Thu, 03 Dec 2020 11:43:55 -0800 (PST)
Received: from [192.168.1.85] (5-12-86-45.residential.rdsnet.ro. [5.12.86.45])
        by smtp.gmail.com with ESMTPSA id n14sm1825980edw.38.2020.12.03.11.43.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Dec 2020 11:43:55 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: high number of dropped packets/rx_missed_errors from 4.17 kernel
From:   Andrei Popa <andreipopad@gmail.com>
In-Reply-To: <18276301.3Z8BrWjNFq@kreacher>
Date:   Thu, 3 Dec 2020 21:43:54 +0200
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        Linux PM <linux-pm@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2E1DF9B2-0CE3-4C4E-8803-0DC145BFE530@gmail.com>
References: <8EACE662-A291-4DB8-A5CB-BB0BD44B7AB0@gmail.com>
 <47586104-a816-1419-13c0-b1d297289fd5@intel.com>
 <18276301.3Z8BrWjNFq@kreacher>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On what kernel version should I try the patch ? I tried on 5.9 and it =
doesn't build.

> On 18 Nov 2020, at 20:47, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>=20
> On Tuesday, November 17, 2020 7:31:29 PM CET Rafael J. Wysocki wrote:
>> On 11/16/2020 8:11 AM, Andrei Popa wrote:
>>> Hello,
>>>=20
>>> After an update from vmlinuz-4.15.0-106-generic to =
vmlinuz-5.4.0-37-generic we experience, on a  number of servers, a very =
high number of rx_missed_errors and dropped packets only on the uplink =
10G interface. We have another 10G downlink interface with no problems.
>>>=20
>>> The affected servers have the following mainboards:
>>> S5520HC ver E26045-455
>>> S5520UR ver E22554-751
>>> S5520UR ver E22554-753
>>> S5000VSA
>>>=20
>>> On other 30 servers with similar mainboards and/or configs there are =
no dropped packets with vmlinuz-5.4.0-37-generic.
>>>=20
>>> We=E2=80=99ve installed vanilla 4.16 and there were no dropped =
packets.
>>> Vanilla 4.17 had a very high number of dropped packets like the =
following:
>>>=20
>>> root@shaper:~# cat test
>>> #!/bin/bash
>>> while true
>>> do
>>> ethtool -S ens6f1|grep "missed_errors"
>>> ifconfig ens6f1|grep RX|grep dropped
>>> sleep 1
>>> done
>>>=20
>>> root@shaper:~# ./test
>>>      rx_missed_errors: 2418845
>>>         RX errors 0  dropped 2418888  overruns 0  frame 0
>>>      rx_missed_errors: 2426175
>>>         RX errors 0  dropped 2426218  overruns 0  frame 0
>>>      rx_missed_errors: 2431910
>>>         RX errors 0  dropped 2431953  overruns 0  frame 0
>>>      rx_missed_errors: 2437266
>>>         RX errors 0  dropped 2437309  overruns 0  frame 0
>>>      rx_missed_errors: 2443305
>>>         RX errors 0  dropped 2443348  overruns 0  frame 0
>>>      rx_missed_errors: 2448357
>>>         RX errors 0  dropped 2448400  overruns 0  frame 0
>>>      rx_missed_errors: 2452539
>>>         RX errors 0  dropped 2452582  overruns 0  frame 0
>>>=20
>>> We did a git bisect and we=E2=80=99ve found that the following =
commit generates the high number of dropped packets:
>>>=20
>>> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com =
<mailto:rafael.j.wysocki@intel.com>>
>>> Date:   Thu Apr 5 19:12:43 2018 +0200
>>>     cpuidle: menu: Avoid selecting shallow states with stopped tick
>>>     If the scheduler tick has been stopped already and the governor
>>>     selects a shallow idle state, the CPU can spend a long time in =
that
>>>     state if the selection is based on an inaccurate prediction of =
idle
>>>     time.  That effect turns out to be relevant, so it needs to be
>>>     mitigated.
>>>     To that end, modify the menu governor to discard the result of =
the
>>>     idle time prediction if the tick is stopped and the predicted =
idle
>>>     time is less than the tick period length, unless the tick timer =
is
>>>     going to expire soon.
>>>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com =
<mailto:rafael.j.wysocki@intel.com>>
>>>     Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org =
<mailto:peterz@infradead.org>>
>>> diff --git a/drivers/cpuidle/governors/menu.c =
b/drivers/cpuidle/governors/menu.c
>>> index 267982e471e0..1bfe03ceb236 100644
>>> --- a/drivers/cpuidle/governors/menu.c
>>> +++ b/drivers/cpuidle/governors/menu.c
>>> @@ -352,13 +352,28 @@ static int menu_select(struct cpuidle_driver =
*drv, struct cpuidle_device *dev,
>>>          */
>>>         data->predicted_us =3D min(data->predicted_us, =
expected_interval);
>>> -       /*
>>> -        * Use the performance multiplier and the user-configurable
>>> -        * latency_req to determine the maximum exit latency.
>>> -        */
>>> -       interactivity_req =3D data->predicted_us / =
performance_multiplier(nr_iowaiters, cpu_load);
>>> -       if (latency_req > interactivity_req)
>>> -               latency_req =3D interactivity_req;
>>=20
>> The tick_nohz_tick_stopped() check may be done after the above and it=20=

>> may be reworked a bit.
>>=20
>> I'll send a test patch to you shortly.
>=20
> The patch is appended, but please note that it has been rebased by =
hand and
> not tested.
>=20
> Please let me know if it makes any difference.
>=20
> And in the future please avoid pasting the entire kernel config to =
your
> reports, that's problematic.
>=20
> ---
> drivers/cpuidle/governors/menu.c |   23 ++++++++++++-----------
> 1 file changed, 12 insertions(+), 11 deletions(-)
>=20
> Index: linux-pm/drivers/cpuidle/governors/menu.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -308,18 +308,18 @@ static int menu_select(struct cpuidle_dr
> 				get_typical_interval(data, =
predicted_us)) *
> 				NSEC_PER_USEC;
>=20
> -	if (tick_nohz_tick_stopped()) {
> -		/*
> -		 * If the tick is already stopped, the cost of possible =
short
> -		 * idle duration misprediction is much higher, because =
the CPU
> -		 * may be stuck in a shallow idle state for a long time =
as a
> -		 * result of it.  In that case say we might mispredict =
and use
> -		 * the known time till the closest timer event for the =
idle
> -		 * state selection.
> -		 */
> -		if (data->predicted_us < TICK_USEC)
> -			data->predicted_us =3D min_t(unsigned int, =
TICK_USEC,
> -						   =
ktime_to_us(delta_next));
> +	/*
> +	 * If the tick is already stopped, the cost of possible short =
idle
> +	 * duration misprediction is much higher, because the CPU may be =
stuck
> +	 * in a shallow idle state for a long time as a result of it.  =
In that
> +	 * case, say we might mispredict and use the known time till the =
closest
> +	 * timer event for the idle state selection, unless that event =
is going
> +	 * to occur within the tick time frame (in which case the CPU =
will be
> +	 * woken up from whatever idle state it gets into soon enough =
anyway).
> +	 */
> +	if (tick_nohz_tick_stopped() && data->predicted_us < TICK_USEC =
&&
> +	    delta_next >=3D TICK_NSEC) {
> +		data->predicted_us =3D ktime_to_us(delta_next);
> 	} else {
> 		/*
> 		 * Use the performance multiplier and the =
user-configurable


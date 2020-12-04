Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5812CE847
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 07:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgLDGqg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 01:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgLDGqg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 01:46:36 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD01EC061A4F;
        Thu,  3 Dec 2020 22:45:55 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id b73so4680744edf.13;
        Thu, 03 Dec 2020 22:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=R4w2cLWlzCbILEne69r04q7mJV2JkZ6WUF5KKB0AsJ0=;
        b=OgJCu5xzRjJNwdZl9zG9+eFwWjjeSUZsGrEUs6vpFo74rYLpo2zaZ1ySGXZ2O/od1t
         cu9z5n9pYtdfWuJzztb3emld56YVlhJyQnR+FgILb6ynLsJ6DA3iw3T++31C3zmpefUd
         EXC63FtMmLqdBGxzic0uVdtJ6/nz0HGVjaJaIJTkAG6po5tTIacXiV3zvDMwG0FAd5O+
         VyllGI69JpgUmoKK2LdQIFyLQGQhFlnX9qgF16+JRkoOWFEfVxJzMrbi1oFEG2h9OPH5
         pcflNdR1hK9yrvFM6mcf6bDafDyzRtssG3AIPv9pyG06Da64fatCu+H9ivnySQQRJqUK
         fQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=R4w2cLWlzCbILEne69r04q7mJV2JkZ6WUF5KKB0AsJ0=;
        b=COqNmHYvJJkcBSaOH8823jkrkoX9VbzYE3SfM5f63wJf1lMEiqc6UXBEUyOJXt4gvG
         wvLKY/GlW+vn0UyzPnMbWGEJ8yBEof41ai7afQaArTyC00sDq4W+4yjTPNQ5K2nQUdxD
         +iyuuRBiMYM/zSv5EJ8g4NGwOyYIsyFRMmG7Xa4fSvjWdz3VLQRki8Cu7LSAhGF6dxOq
         3WWFfA5NQNlwB9Gylsbmx19+fKvvgJAR6WQTkZ7AMUoX1yxJPsFy1VG6AIUiHdli2wsT
         3hf5Ns9PSiTdxv43rD3OxIF6TTNPjjTkjv4INO/+FcxY3VN8bPqpKyvqY8lMY6DJn+nJ
         2Q7A==
X-Gm-Message-State: AOAM532B2rq0UqyJYVW+NaKPLjs9SYn6mT7tH9lDZHf86fxCPHv9O9By
        ChLf7/5xGtrPpV128cBQS2h1RrXFOO2G0A==
X-Google-Smtp-Source: ABdhPJyuLFTeMmgVFjTO1LnBVTJuGLF2HYnv/jd7WgP+L16aGgMy+g9DlIP0DIBz884LCyIqPBEQ8w==
X-Received: by 2002:a05:6402:3049:: with SMTP id bu9mr6143338edb.127.1607064354557;
        Thu, 03 Dec 2020 22:45:54 -0800 (PST)
Received: from [192.168.1.85] (5-12-86-45.residential.rdsnet.ro. [5.12.86.45])
        by smtp.gmail.com with ESMTPSA id ov22sm2454356ejb.23.2020.12.03.22.45.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Dec 2020 22:45:54 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: high number of dropped packets/rx_missed_errors from 4.17 kernel
From:   Andrei Popa <andreipopad@gmail.com>
In-Reply-To: <2E1DF9B2-0CE3-4C4E-8803-0DC145BFE530@gmail.com>
Date:   Fri, 4 Dec 2020 08:45:52 +0200
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        Linux PM <linux-pm@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5F92AF26-B9EB-4456-B135-39BF92396F6E@gmail.com>
References: <8EACE662-A291-4DB8-A5CB-BB0BD44B7AB0@gmail.com>
 <47586104-a816-1419-13c0-b1d297289fd5@intel.com>
 <18276301.3Z8BrWjNFq@kreacher>
 <2E1DF9B2-0CE3-4C4E-8803-0DC145BFE530@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I=E2=80=99ve applied your patch on kernel 4.17.0 and dropped packets and =
rx_missed_errors are still present, through they are increasing at a =
lower rate.

root@shaper:~# ./test
     rx_missed_errors: 2135
        RX errors 0  dropped 2155  overruns 0  frame 0
sleeping 60 seconds
     rx_missed_errors: 2433
        RX errors 0  dropped 2459  overruns 0  frame 0
sleeping 60 seconds
     rx_missed_errors: 2433
        RX errors 0  dropped 2465  overruns 0  frame 0
sleeping 60 seconds
     rx_missed_errors: 2526
        RX errors 0  dropped 2564  overruns 0  frame 0
sleeping 60 seconds


> On 3 Dec 2020, at 21:43, Andrei Popa <andreipopad@gmail.com> wrote:
>=20
> Hi,
>=20
> On what kernel version should I try the patch ? I tried on 5.9 and it =
doesn't build.
>=20
>> On 18 Nov 2020, at 20:47, Rafael J. Wysocki <rjw@rjwysocki.net> =
wrote:
>>=20
>> On Tuesday, November 17, 2020 7:31:29 PM CET Rafael J. Wysocki wrote:
>>> On 11/16/2020 8:11 AM, Andrei Popa wrote:
>>>> Hello,
>>>>=20
>>>> After an update from vmlinuz-4.15.0-106-generic to =
vmlinuz-5.4.0-37-generic we experience, on a  number of servers, a very =
high number of rx_missed_errors and dropped packets only on the uplink =
10G interface. We have another 10G downlink interface with no problems.
>>>>=20
>>>> The affected servers have the following mainboards:
>>>> S5520HC ver E26045-455
>>>> S5520UR ver E22554-751
>>>> S5520UR ver E22554-753
>>>> S5000VSA
>>>>=20
>>>> On other 30 servers with similar mainboards and/or configs there =
are no dropped packets with vmlinuz-5.4.0-37-generic.
>>>>=20
>>>> We=E2=80=99ve installed vanilla 4.16 and there were no dropped =
packets.
>>>> Vanilla 4.17 had a very high number of dropped packets like the =
following:
>>>>=20
>>>> root@shaper:~# cat test
>>>> #!/bin/bash
>>>> while true
>>>> do
>>>> ethtool -S ens6f1|grep "missed_errors"
>>>> ifconfig ens6f1|grep RX|grep dropped
>>>> sleep 1
>>>> done
>>>>=20
>>>> root@shaper:~# ./test
>>>>     rx_missed_errors: 2418845
>>>>        RX errors 0  dropped 2418888  overruns 0  frame 0
>>>>     rx_missed_errors: 2426175
>>>>        RX errors 0  dropped 2426218  overruns 0  frame 0
>>>>     rx_missed_errors: 2431910
>>>>        RX errors 0  dropped 2431953  overruns 0  frame 0
>>>>     rx_missed_errors: 2437266
>>>>        RX errors 0  dropped 2437309  overruns 0  frame 0
>>>>     rx_missed_errors: 2443305
>>>>        RX errors 0  dropped 2443348  overruns 0  frame 0
>>>>     rx_missed_errors: 2448357
>>>>        RX errors 0  dropped 2448400  overruns 0  frame 0
>>>>     rx_missed_errors: 2452539
>>>>        RX errors 0  dropped 2452582  overruns 0  frame 0
>>>>=20
>>>> We did a git bisect and we=E2=80=99ve found that the following =
commit generates the high number of dropped packets:
>>>>=20
>>>> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com =
<mailto:rafael.j.wysocki@intel.com>>
>>>> Date:   Thu Apr 5 19:12:43 2018 +0200
>>>>    cpuidle: menu: Avoid selecting shallow states with stopped tick
>>>>    If the scheduler tick has been stopped already and the governor
>>>>    selects a shallow idle state, the CPU can spend a long time in =
that
>>>>    state if the selection is based on an inaccurate prediction of =
idle
>>>>    time.  That effect turns out to be relevant, so it needs to be
>>>>    mitigated.
>>>>    To that end, modify the menu governor to discard the result of =
the
>>>>    idle time prediction if the tick is stopped and the predicted =
idle
>>>>    time is less than the tick period length, unless the tick timer =
is
>>>>    going to expire soon.
>>>>    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com =
<mailto:rafael.j.wysocki@intel.com>>
>>>>    Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org =
<mailto:peterz@infradead.org>>
>>>> diff --git a/drivers/cpuidle/governors/menu.c =
b/drivers/cpuidle/governors/menu.c
>>>> index 267982e471e0..1bfe03ceb236 100644
>>>> --- a/drivers/cpuidle/governors/menu.c
>>>> +++ b/drivers/cpuidle/governors/menu.c
>>>> @@ -352,13 +352,28 @@ static int menu_select(struct cpuidle_driver =
*drv, struct cpuidle_device *dev,
>>>>         */
>>>>        data->predicted_us =3D min(data->predicted_us, =
expected_interval);
>>>> -       /*
>>>> -        * Use the performance multiplier and the user-configurable
>>>> -        * latency_req to determine the maximum exit latency.
>>>> -        */
>>>> -       interactivity_req =3D data->predicted_us / =
performance_multiplier(nr_iowaiters, cpu_load);
>>>> -       if (latency_req > interactivity_req)
>>>> -               latency_req =3D interactivity_req;
>>>=20
>>> The tick_nohz_tick_stopped() check may be done after the above and =
it=20
>>> may be reworked a bit.
>>>=20
>>> I'll send a test patch to you shortly.
>>=20
>> The patch is appended, but please note that it has been rebased by =
hand and
>> not tested.
>>=20
>> Please let me know if it makes any difference.
>>=20
>> And in the future please avoid pasting the entire kernel config to =
your
>> reports, that's problematic.
>>=20
>> ---
>> drivers/cpuidle/governors/menu.c |   23 ++++++++++++-----------
>> 1 file changed, 12 insertions(+), 11 deletions(-)
>>=20
>> Index: linux-pm/drivers/cpuidle/governors/menu.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
>> +++ linux-pm/drivers/cpuidle/governors/menu.c
>> @@ -308,18 +308,18 @@ static int menu_select(struct cpuidle_dr
>> 				get_typical_interval(data, =
predicted_us)) *
>> 				NSEC_PER_USEC;
>>=20
>> -	if (tick_nohz_tick_stopped()) {
>> -		/*
>> -		 * If the tick is already stopped, the cost of possible =
short
>> -		 * idle duration misprediction is much higher, because =
the CPU
>> -		 * may be stuck in a shallow idle state for a long time =
as a
>> -		 * result of it.  In that case say we might mispredict =
and use
>> -		 * the known time till the closest timer event for the =
idle
>> -		 * state selection.
>> -		 */
>> -		if (data->predicted_us < TICK_USEC)
>> -			data->predicted_us =3D min_t(unsigned int, =
TICK_USEC,
>> -						   =
ktime_to_us(delta_next));
>> +	/*
>> +	 * If the tick is already stopped, the cost of possible short =
idle
>> +	 * duration misprediction is much higher, because the CPU may be =
stuck
>> +	 * in a shallow idle state for a long time as a result of it.  =
In that
>> +	 * case, say we might mispredict and use the known time till the =
closest
>> +	 * timer event for the idle state selection, unless that event =
is going
>> +	 * to occur within the tick time frame (in which case the CPU =
will be
>> +	 * woken up from whatever idle state it gets into soon enough =
anyway).
>> +	 */
>> +	if (tick_nohz_tick_stopped() && data->predicted_us < TICK_USEC =
&&
>> +	    delta_next >=3D TICK_NSEC) {
>> +		data->predicted_us =3D ktime_to_us(delta_next);
>> 	} else {
>> 		/*
>> 		 * Use the performance multiplier and the =
user-configurable
>=20


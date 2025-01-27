Return-Path: <linux-pm+bounces-20983-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C135A1DB1A
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 18:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2875718836A9
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 17:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEE5157493;
	Mon, 27 Jan 2025 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGFci6Wg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520541F95A;
	Mon, 27 Jan 2025 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737998264; cv=none; b=H6g5LJ6qX63ksk6cKfKm5UVfrL8yxL/Euda26QL0nzi8KDdNy86N4nHsHunB3G0aW8gm4pm8oVzpou+cDnKxZoTNKtruRlfJ9GD62QaDRkZbEOFxzZF6S55KDsPXY8p7U6uv8AFm8JTx7ODO3OB407A8mBqS3+f176gNzL1KfgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737998264; c=relaxed/simple;
	bh=X4RrfmLSQKm796VLP8MLWGQzFQ3rW1jsDvPoTVrkh/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDc7jIT01gKC9sMAki0Bmn8iq1+5LeSabMEx9COscWco2KkUPceA8lFfJMEa8ZrPF0A6hhHcWjg7xOf3yUdlaQ8ibFBfgpC1nOGk8ZT6zC9e1mVvekuWnvDVsIgOEIJgU+KCbkQt6IcepG7sax6XTWkdT8BkIMdmpg9RkS+P3Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGFci6Wg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216281bc30fso4166555ad.0;
        Mon, 27 Jan 2025 09:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737998261; x=1738603061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJq4F5R52EihkJnORvxW1Duv4b4PNbOuy1hXm+tIhDA=;
        b=MGFci6WgrrtP4cu3DZU9V14pIp6KQFEPvxNo9ncWNXlJ30Vcj1fQ2e0ro/zdvKA37c
         GUw0ePzXQa8gT0pG/t3Pr2oUDkPfUNEIDM0XbE/04XtPieBnGLMiDKVUOul0QZxgZuKM
         D+Rda2w3JFMdWORsMFILdOPoSQed4QUUtLj4RuJMWvxYab6sBR32JgmdoQh72wgf1/cy
         YzCZCZXeG3NycCVoEVHV00+oAQSNNE+WcsMllA1/ph6LX+b8fJX0JFqKDHKI6zv0cDQ+
         Pl4NaSsRVLIbiRWoLFCj83L9YxU64SLGUNA636QX7vDFOkqnCC667zY0+ZEZpYYd+qFF
         HecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737998261; x=1738603061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJq4F5R52EihkJnORvxW1Duv4b4PNbOuy1hXm+tIhDA=;
        b=MWApGwoDykClv1f+ZsGUUBhQSIR7rP425RWwJvapi4UzuzSKis70aDy75MyUs4W661
         sVGXB6GL4/odpcj8DIqxHRONDicOqvKK30ihv3Khn3J7K67Gb3dqoeEOiSnKepYoUGxJ
         vG+nRgSpKeJ//M1q7f7J3Xfz1evm1KYPJhv5bZ5rGIgNhEl+1pH7flbHwYMHJ254r6BN
         4A4G2taUaoUOum7uguFCCgkHQHXV779zxmh+/Hy972cfrtHdJ//dTGovbsyxZVwuN1Vq
         sJZ/kF2s2+2Fq41Kr05ds6QGbGK3JnHukKc6IksuLUbOGNaZHSTIK6vcSJ3/MujYlPdW
         HaPw==
X-Forwarded-Encrypted: i=1; AJvYcCUGgKPhTlOTZmGaooSqRgdsSfwcu7xANzx35DpksOi9mKQcqAbJYn+Ye+SQ/DtZzSCXiB5CCZKx/NIzy4X9@vger.kernel.org, AJvYcCUmR0Zh+4yNetIamp3KXtvxSnfydvl4zj1mQcdj1m8CFRYasOBmbbjZ9JCjPkb7tzOxG5lHNsuVkGxbA5w=@vger.kernel.org, AJvYcCVrjmlHpFFD1LxQVxR+dGpKsF2bzfqcYtAG2e2tS/G7BRrlmZ39HQKXZ0qwGUT8DrWhBNgPVAuXhcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU/EcyHj4qy5uv1933OrT4mMtGIX6tPm+9+VzCuhxRmpmTddaT
	NFuvGgYb/Mt+7y8WkIFjiZXxqThRcScKvGQp3HLGO+spPC64zw2EVHimFh1+3ID9xM3P2WImXb4
	h0L1MKN6UsE30MhAJ86OjVWjgCmA=
X-Gm-Gg: ASbGncsD+VKSZQEfaDzXS8wpR/j+zio80cPhVbZ22vP0EVSmDpkuPOw8Y9WskQxmqWv
	KsP7EyHY2G69JhYvnGUpCsEVyvW3gNVE7KphXvKca2jvXMDsvpI+KyNfclzScugPond35yJrxo2
	BVe5CTcD6pmysoWOnBHM8=
X-Google-Smtp-Source: AGHT+IG48HR0KtIpd4V+2VRj7rni5YpEd9979Gv8ZvYiepf73ADFYTxGHnhAHYPiGLsj85FC0xIsC3/5SZ9H2fCLaJI=
X-Received: by 2002:a17:903:22d0:b0:215:63a0:b58c with SMTP id
 d9443c01a7336-21c356780cfmr582137805ad.46.1737998259884; Mon, 27 Jan 2025
 09:17:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO6a-9_aPLCx2CqecQBGbK78_=+-tT44RepPkrBjpkWSvjj4Tg@mail.gmail.com>
 <CAO6a-98cdSvyd7jgAyGNmsC2nxmRSyr3GppxvZU9yHU1xqwz3g@mail.gmail.com>
 <20241211055052.gbxnyqpui3t3zpw5@lcpd911> <20241211121825.GA2054801@bogus>
 <20241211143428.kaoovhiwar74dy6x@lcpd911> <Z1rbLdWW75KQw5cl@bogus>
In-Reply-To: <Z1rbLdWW75KQw5cl@bogus>
From: Vivek yadav <linux.ninja23@gmail.com>
Date: Mon, 27 Jan 2025 22:47:28 +0530
X-Gm-Features: AWEUYZmvkfg7G9UyzXYIBb0JSKee0hyMWDe0xrSrlhdRHKhJHC925vN_hf6pY84
Message-ID: <CAO6a-98XFxbCnOMp5ARwPssjYomyNKWjT=WTk=z2+ZKyOAQ0jQ@mail.gmail.com>
Subject: Re: Fwd: ARM64: CPUIdle driver is not select any Idle state other
 then WFI
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Dhruva Gole <d-gole@ti.com>, linux-newbie@vger.kernel.org, linux-pm@vger.kernel.org, 
	daniel.lezcano@linaro.org, lpieralisi@kernel.org, krzk@kernel.org, 
	christian.loehle@arm.com, quic_sibis@quicinc.com, cristian.marussi@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	vigneshr@ti.com, khilman@ti.com, sebin.francis@ti.com, khilman@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi @Dhruva Gole,

Q.1. Does your CA-53 properly go into CPUIdle state and come out of
sleep state ?
Q.2. Can you provide a snapshot of command
cat /sys/devices/system/cpu/cpu*/cpuidle/state*/usage  ?
Q.3. How frequently CPUs are going into custom state1 (other than
standard WFI state) ?

> Any further luck on this?

I am still facing some issues. This issue is not closed yet.

>
> idle-states {
>       entry-method =3D "psci";
>        cpu_ret_l: cpu-retention-l {
>          compatible =3D "arm,idle-state";
>          arm,psci-suspend-param =3D <0x00010001>;
>          local-timer-stop;
>          entry-latency-us =3D <55>;
>           exit-latency-us =3D <140>;
>           min-residency-us =3D <780>;
>     };
> };
>
> I am using ``Menu governor`` with the ``psci_idle driver`` in its origina=
l form.
> After booting Linux I find out that the CPUIdle core is never going
> inside the ``cpu-retention`` state.
> To check time spent by CPU in any state. I am using the below command.
>
> ``cat /sys/devices/system/cpu/cpu*/cpuidle/state*/time``

As of now I made some changes in the DT node. After making changes in
latency (which is mentioned below).

 idle-states {
       entry-method =3D "psci";
        cpu_ret_l: cpu-retention-l {
          compatible =3D "arm,idle-state";
          arm,psci-suspend-param =3D <0x00000000>;
          local-timer-stop;
          entry-latency-us =3D <300000>; # 300ms
           exit-latency-us =3D <300000>; # 300ms
           min-residency-us =3D <1000000>; # 1 sec
     };
 };

I can see that  CA-55 went into a sleep state (state1) using command
``cat /sys/devices/system/cpu/cpu*/cpuidle/state*/time``.
As you mention earlier in a multicore system (2 or more) at least one
core keeps working and does not go into sleep state. It should happen
as per theory and other developers' case.

In my case, after some time, both CPUs (CPU0 and CPU1) go into sleep
state (state1). Hence the system console hangs.

My expectations are,
If I type anything on keyboard. UART interrupt should take out CPUs
from sleep state and execute commands. OR some periodic timer should
take the CPU out of sleep. Which is not happening as of now.
As you said  we can safely remove`` local-timer-stop``. It means local
timers are working for the CPUs and triggering interrupts ?

Any discussion on this topic will definitely help me.

Regards,
Vivek Yadav

On Thu, Dec 12, 2024 at 6:16=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Wed, Dec 11, 2024 at 08:04:28PM +0530, Dhruva Gole wrote:
> > On Dec 11, 2024 at 12:18:25 +0000, Sudeep Holla wrote:
> > > On Wed, Dec 11, 2024 at 11:20:52AM +0530, Dhruva Gole wrote:
> > [...]
> > > > >
> > > > >
> > > > > Hi @all,
> > > > >
> > > > > I am working on one custom SoC. Where I add one CPUIdle state for
> > > > > ``arm,cortex-a55`` processor.
> > > >
> > > > Any further luck on this?
> > > >
> > > > I have also been working on something similar[1] but on an A53 core=
 on
> > > > TI-K3 AM62x processor.
> > >
> > > Does upstream DTS have support for this platform to understand it bet=
ter ?
> > > Even reference to any complete DT file for the platform will help.
> >
> > Yes, you can ref to the AM625 (CPU layout) DT here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/arch/arm64/boot/dts/ti/k3-am625.dtsi
> >
> > The board/starter kit DT is:
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> >
> > The patches for idle state are not upstream, and only exist in this
> > patch of mine here:
> > https://github.com/DhruvaG2000/v-linux/commit/0fd088d624276a2e72b8dc666=
0d261ab6d194f4b
> >
>
> "arm,psci-suspend-param" indicate that this idle state doesn't loose the
> cpu context which means timer doesn't stop. So adding "local-timer-stop"
> sound completely wrong to me.
>
> > [...]
> > > > See this chunk in the kernel cpuidle driver:
> > > >   if (broadcast && tick_broadcast_enter()) {
> > > >
> > > > When I dug deeper into tick_broadcast_enter it always returns somet=
hing
> > > > non zero and hence in my case it was entering the if block and trie=
d to
> > > > find a deepest state. Then the deepest state would always return WF=
I and
> > > > not the idle-state I had added.
> > > >
>
> It depends. If this is the last CPU and since you have marked the state w=
ith
> "local-timer-stop" and the system doesn't have any other timers to use as
> source of broadcast, it prevents one of the CPU entering that state. So y=
ou
> could be matching all the above conditions on your platform and hence you
> are observing the above.
>
> > > > What we found out was on our kernel we end up using
> > > >
> > > > kernel/time/tick-broadcast-hrtimer.c
> > > >
> > > > This always seems to be keeping atleast 1 CPU busy and prevents idl=
e.
> > > > If we remove the local-timer-stop it was helping us, but we still n=
eed
> > > > to dig into the full impact of what that entails and I am still
> > > > interested in finding out how so many other users of similar idle-s=
tate
> > > > implementation are able to do so without trouble.
> > > >
> > >
>
> As mentioned about adding "local-timer-stop" for a retention state seems
> pure wrong in my opinion as it contradicts to the fact that context is
> retained.
>
> > > Interesting. So if the platform is functional removing local-timer-st=
op,
> > > I am bit confused. Either there is something else that is getting it =
out
> >
> > Yes it was interesting to us too, as to how the RCU didn't kick in and
> > system continued to function as though nothing was wrong.
> >
>
> It worked as if it was a state with context lost. So there might be some
> impact on the latency though it as the kernel assumed context lost and
> re-entered/resumed through resume entry point rather than where it called
> cpu_suspend() similar to wfi(). I mean only on the CPUs it was able to
> enter this state as one of the CPU will never enter this if there are no
> system timers to act as broadcast timer.
>
> Does you system not have Arch timers memory mapped interface enabled and
> interrupt wired to GIC(other than PPIs) ? Look at Juno R2 as example.
>
> > > from the idle state so, it should be fine and it could be just some
> >
> > It's probably UART keypresses or some userspace processes that get
> > scheduled that bring the CPUs back out of TF-A's cpu_standby.
>
> I doubt the CPU resume from suspend is based on some userspace event.
>
> > Is it possible that EL1 interrupts can bring EL3 out of WFI? Is yes the=
n
> > it explains the behaviour. The arch timer could also be continuing to
> > tick and bringing the CPUs out of ATF WFI.
> >
>
> Yes but that doesn't explain the behaviour. It could be just the timer
> event from the broadcast timer.
>
> > > misconfiguration.
> > >
> > > > Arm64 recommends to use arch_timer instead of external timers. Once=
 we
> > > > enter el3, timer interrupts to el1 is blocked and hence it's equiva=
lent
> > > > to local-timer-stop, so it does make sense to keep this property, b=
ut
> > > > then how are others able to enter idle-states for all plugged CPUs =
at
> > > > the same time?
> > > >
> > >
> > > Some systems have system timer that can take over as broadcast timer =
when
> > > CPUs enter deeper idle states where the local timers are stopped.
> >
> > In CPUIdle we're not really clock gating anything so the timer does kee=
p
> > ticking. So in this particular case it might make sense to remove the
> > local-timer-stop property from the idle-state.
> >
>
> Correct in your case it is retention state and hence local CPU timers
> keep ticking and you can safely drop that property. However if you add
> deeper idle states like CPU OFF with the power rail cut off, then you nee=
d
> some system timer to act as backup/broadcast timer so that all the CPUs
> can enter the state concurrently and wake up successfully.
>
> > However we're looking into taking this further and putting interconnect
> > and few other PLLs in bypass which could cause arch timer for eg. to
> > tick slower.
>
> I assume it will be present as another timer with the rate set appropriat=
ely.
>
> > In this case would it still make sense to omit the property?
>
> No, you should mark it as stopped even if it is running at slower rate
> as I am not sure if the local CPU timer support can handle rate change.
>
> > We may even have some usecases planned where we may turn OFF
> > the CPU once it is in TF-A cpu_standby/ WFI. What would be the right
> > approach in such scenarios?
> >
>
> As mentioned above, this will be separate state and all CPUs can use this
> if there is another system broadcast timer.
>
> > Could you provide any examples where the local-timer-stop property is
> > being used and an alternative timer can be configured once we enter the
> > idle-state where CPU CTX maybe lost or clocks maybe bypass?
> > great if you could share some example implementation if you're aware.
>
> As I mentioned, Juno R2 is an example. It was broken on R0 with some SoC
> errata(can't recall all the details as I looked at it almost a decade ago=
)
>
> --
> Regards,
> Sudeep


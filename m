Return-Path: <linux-pm+bounces-37614-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 009A1C3FBFE
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 12:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5508E3486A6
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 11:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9392E1C7C;
	Fri,  7 Nov 2025 11:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkxsdfD+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AA32D8DA8
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515372; cv=none; b=rc/NBkzOpetH77Cx5VTBJaro9gjv1WjbiSkPnk7kIIoBBmC8czIaWzDerrNxwyN1JTS8kVtxfylwUOP3VKl/Ha9kDkGhrr6Uyns0ovryYI3J+ULgzUiOi2NMZsIQo0QmbD8b7GcMNcEHbo3KZgq48nUkzRV49nrz1T59QvCuoBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515372; c=relaxed/simple;
	bh=NVXmcX+N5Z8qyU9clkL0WOP631Jjrk+MV8BCCsUgWpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFpN7ZKFZn+xeVQT0rr959A/4DwlS09DjibSAd/ZW5DOUP+WqmvL0plycHqk+Cs/ngsSQBRTtsrP/LjAByFPCvmR1SxU+khFxscMZP4pwSK/NMVW5lfb5skwhZi8XCZdkkRti5drA58GCtaWteTVcXY/e74ZWDgR0dy/H+dBXJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkxsdfD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B7FC19421
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 11:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762515369;
	bh=NVXmcX+N5Z8qyU9clkL0WOP631Jjrk+MV8BCCsUgWpA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PkxsdfD+NGnDjyt9KmOcU0mPlsedc1Gpn6k7aw2l8LAfZJO2pUdcbQPIzPmiqmTXO
	 qIg6C1llEwmA0cP3Q28MI0nbPoVuohqY5G73le+WkdNihowbVRVTyPDdLRBzqh12xa
	 52dE/g4ksRNRuxGD9Q6RX37aqwVB0R3BmqfiSwXHqCQN4JPbRyY8OkiaRMsd4GlZ2c
	 hulwz8GedaVhjQ4Ts5QBdaIOQmFZlBUbeSDMS6jP9un4W0N3e/BrWQcwGy+VFHFrg5
	 wWZmWg6i01z6OoyntRVkeASXM/hzGmlj7/fladtJWTFq+p2QhbtVSFwstnVzJZrv/X
	 ybozdyPoF2wbQ==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c5333e7033so200504a34.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 03:36:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWoAutHpPT6E8xiVDE1UX5zJhr8Oqts3GboXAGdo8CxCs/JtsKG/dpwVa4I8sNYDh4JY2NNuWZLeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCGkj3Zy1tr5tGVCqh3uR3BG8N0IEjM4hDapDvnkUkym/LHovn
	L6e08Ve/mOtNsV6um49ZSLFLOHvDZlkjmZNAFwh/ixu79iqs8kjBRGH0KMbu7jWen5VaLwX/aJf
	uZbQhrUlZtvMNBNucYLQY3ueEBdtSrn0=
X-Google-Smtp-Source: AGHT+IGMraaEUZuaSZGyJap8VbBWHoBgwHAMFV2rLhgj0mY/gxejSx1HmMKOUNyMgGxe+eyY4Ol44ZwktA8egyX/kC8=
X-Received: by 2002:a05:6830:6750:b0:7c6:8ede:ca96 with SMTP id
 46e09a7af769-7c6effbfaedmr1645415a34.26.1762515368486; Fri, 07 Nov 2025
 03:36:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
 <a50064b2-e6aa-4237-a715-12f21a65e9a6@arm.com> <ed1e64dc-91c9-44d9-b3d3-9f142bcf7a8d@arm.com>
 <CAJZ5v0g9Jndez5y5i4pPW1C+qfj=4iiu51HV7Eb1dBGd1jg-CA@mail.gmail.com>
 <b910a35c-83aa-4050-9c6c-de40f13a2a55@arm.com> <CAJZ5v0h6qAgWkEad5OGM-V-HOE-1PwD_XqgsDWbnJNxLWOKDfA@mail.gmail.com>
 <CAEmPcws_pvYpzRMQfMyRPBw=7bUyYCcnP3BHN2H4wgUeLLszFg@mail.gmail.com>
In-Reply-To: <CAEmPcws_pvYpzRMQfMyRPBw=7bUyYCcnP3BHN2H4wgUeLLszFg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Nov 2025 12:35:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i_ZUD1=3JDABJZ3fcdD7r8uMU36=mam8r2=1P02YksYw@mail.gmail.com>
X-Gm-Features: AWmQ_bkMQcZXkdUeJBXJR75APx0O3Un17vVtfzLd_ekUoe-TGmrpixv7T-2fEQA
Message-ID: <CAJZ5v0i_ZUD1=3JDABJZ3fcdD7r8uMU36=mam8r2=1P02YksYw@mail.gmail.com>
Subject: Re: Regression in TEO cpuidle governor between 6.6 and 6.12
To: Reka Norman <rekanorman@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000073624f0642ff960f"

--00000000000073624f0642ff960f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 4:28=E2=80=AFAM Reka Norman <rekanorman@chromium.org=
> wrote:
>
> On Fri, Nov 7, 2025 at 7:33=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
> >
> > On Thu, Nov 6, 2025 at 12:13=E2=80=AFPM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> > >
> > > On 11/5/25 20:48, Rafael J. Wysocki wrote:
> > > > On Wed, Nov 5, 2025 at 12:24=E2=80=AFAM Christian Loehle
> > > > <christian.loehle@arm.com> wrote:
> > > >>
> > > >> On 11/4/25 09:03, Christian Loehle wrote:
> > > >>> On 11/4/25 03:36, Reka Norman wrote:
> > > >>>> Hi,
> > > >>>>
> > > >>>> I=E2=80=99m seeing a regression in the TEO governor between 6.6 =
and 6.12. At
> > > >>>> 6.12, when the system is idle it=E2=80=99s spending almost 100% =
of time in
> > > >>>> WFI, compared to about 6% at 6.6. At mainline it has improved co=
mpared
> > > >>>> to 6.12 but is still a lot worse than 6.6, spending about 50% in=
 WFI.
> > > >>>>
> > > >>>> The system is a ChromeOS device with Mediatek MT8196.
> > > >>>>
> > > >>>> Bisecting showed the specific commit which caused the regression=
 is:
> > > >>>> 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts=
")
> > > >>>>
> > > >>>> I=E2=80=99ve attached sysfs dumps showing the issue. All were ta=
ken a couple
> > > >>>> of minutes after boot, with the device having been idle since bo=
ot.
> > > >>>> The cases tested are:
> > > >>>> cpuidle_6_6.txt      =3D 6.6 kernel
> > > >>>> cpuidle_6_12.txt     =3D 6.6 kernel with teo commits up to 6.12
> > > >>>> cpuidle_mainline.txt =3D 6.6 kernel with teo commits up to mainl=
ine
> > > >>>>
> > > >>>> Summary of the percentage time spent in each state (averaged acr=
oss CPUs):
> > > >>>>
> > > >>>> |            |   6.6 |  6.12 | mainline |
> > > >>>> |------------|------:|------:|---------:|
> > > >>>> | WFI        |  6.02 | 99.94 |    56.84 |
> > > >>>> | cpuoff     | 11.02 |     0 |     0.65 |
> > > >>>> | clusteroff | 82.96 |  0.05 |    42.51 |
> > > >>>> | s2idle     |     0 |     0 |        0 |
> > > >>>>
> > > >>>> Any help would be much appreciated. Let me know if there's any o=
ther
> > > >>>> debugging information I should provide.
> > > >>>>
> > > >>>
> > > >>> That's not good.
> > > >>> If the system is mostly idle (only boot activity but dumps are ta=
ken after
> > > >>> ~3mins?), what is causing the wakeups? Even in 6.6 There are defi=
nitely more
> > > >>> than I would've expected?
> > > >>> I noticed that clusteroff and cpuoff have equal residency, which =
is
> > > >>> obviously a bit awkward for cpuidle, but shouldn't be relevant to=
 your issue.
> > > >>>
> > > >>> I'm a bit puzzled by your bisect results.
> > > >>> 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts"=
)
> > > >>> made the intercept logic *less* prone to count (false) intercepts=
, yet it
> > > >>> seems to count more of them? (resulting in more WFI).
> > > >>> I'll think about it some more, for now of course a trace would be=
 very
> > > >>> helpful. (cpuidle events, ipi_raise, irqs?)
> > > >>> Are there ever any latency constraints set?
> > > >>>
> > > >>> FWIW the mainline results look the most reasonable, from a 30000 =
feet view
> > > >>> anyway:
> > > >>> Cluster       State           above   below   usage   above%  bel=
ow%
> > > >>> LITTLE        cpuoff-l        ~75     ~65     ~140    23%     20%
> > > >>> LITTLE        clusteroff-l    ~800    0       ~100    89%     0%
> > > >>> MID   cpuoff-m        ~3=E2=80=934    ~15     ~20     15%     55%
> > > >>> MID   clusteroff-m    ~1300   0       ~4000   24%     0%
> > > >>> BIG   cpuoff-b        0       1       1       =E2=80=94       =E2=
=80=94
> > > >>> BIG   clusteroff-b    ~800    0       ~1900   30%     0%
> > > >>>
> > > >>> (WFI seems mostly the correct choice for little CPUs, that's fine=
, the energy
> > > >>> savings compared to cpuoff should be marginal anyway.)
> > > >>>
> > > >>> Do you mind trying:
> > > >>> 13ed5c4a6d9c cpuidle: teo: Skip getting the sleep length if wakeu=
ps are very frequent
> > > >>> on 6.12?
> > > >>>
> > > >>
> > > >> So just thinking out loud, the only case I can actually thing of t=
o explain your
> > > >> bisect to 4b20b07ce72f ("cpuidle: teo: Don't count non-existent in=
tercepts")
> > > >> is that the workload essentially changed dramatically because of o=
ur calls
> > > >> to tick_nohz_get_sleep_length() now.
> > > >> I'm not sure how likely I think that is, but I'm lacking imaginati=
on for another
> > > >> cause. That's why results with
> > > >> 13ed5c4a6d9c ("cpuidle: teo: Skip getting the sleep length if wake=
ups are very frequent")
> > > >> would be interesting.
> > > >
> > > > My current theory is that this issue is related to the
> > > > tick_nohz_get_sleep_length() overhead and the way "intercepts" are
> > > > distinguished from "hits" in teo.
> > > >
> > > > Namely, teo assumes that its own overhead is negligible and so it
> > > > counts a given event as an "intercept" if the measured time spent i=
n
> > > > the idle state (with the exit latency roughly taken into account)
> > > > falls into a different "state bin" than the sleep length (the expec=
ted
> > > > time till the next timer).  However, the sleep length is computed a=
s a
> > > > difference between the upcoming timer wakeup event time and
> > > > ts->idle_entrytime, so it actually includes the time taken by
> > > > tick_nohz_next_event().  If the latter is significant, it may
> > > > contribute to the difference seen by teo_update() and cause extra
> > > > "intercepts" to appear.
> > >
> > > Right, additionally with psci pc-mode and the exposed clusteroff stat=
es we end
> > > up vastly exaggerating the wakeup latency (i.e. underestimating the a=
ctual idle time)
> > > for three reasons:
> > > - wakeup latency =3D entry+exit latency (worst case: pay full latenci=
es on both
> > > even though for most cases we don't incur the entry latency)
> > > - Wakeup latency is a worst-case and often is more like 2x-3x of the =
average.
> > > - We use the (higher) clusteroff values even though the clusteroff st=
ate couldn't
> > > possibly have been entered as not the entire cluster is idle.
> > >
> > > Nonetheless these are all just a "intercept counting is significantly=
 more likely"
> > > while the results show not a single state >0 entered =3D> the interce=
pt logic
> > > probably triggers every cpuidle entry.
> >
> > It has to for this to happen, if timers are not frequent enough.
> >
> > > Feels like there should be an issue in the feedback loop.
> >
> > I'm wondering what the issue could be though.  The change in commit
> > 4b20b07ce72f only affects the cases when idle state 0 is about to be
> > selected and it only really changes the sleep length value from
> > KTIME_MAX to something more realistic (but it still may be KTIME_MAX).
> >
> > It may turn an "intercept" into a "hit", but only if the CPU is not
> > woken up by the tick because those cases had been already counted as
> > "hits" before commit 4b20b07ce72f.
> >
> > Now, if the majority of wakeups in the workload are tick wakeups, the
> > only real difference appears to be the presence of
> > tick_nohz_get_sleep_length() in that code path.
> >
> > Frankly, I would try to remove the update of cpu_data->sleep_length_ns
> > right before the "goto out_tick" statement (in 6.12 that should be
> > line 426) and see what happens.
>
> Just tried this quickly. Results attached. It goes back to behaving
> the same as 6.6 - about 2% WFI.

Thanks for checking this!  It means that the
tick_nohz_get_sleep_length() overhead doesn't matter here that much.

Instead of making the change above, can you please try the 6.12
equivalent of the attached patch?

Or alternatively, apply this one to the mainline and see if it changes
the idle states selection proportions?

--00000000000073624f0642ff960f
Content-Type: text/x-patch; charset="US-ASCII"; name="cpuidle-teo-reflect-refinement.patch"
Content-Disposition: attachment; 
	filename="cpuidle-teo-reflect-refinement.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mhos33nx0>
X-Attachment-Id: f_mhos33nx0

LS0tCiBkcml2ZXJzL2NwdWlkbGUvZ292ZXJub3JzL3Rlby5jIHwgICAgMyArLS0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKCi0tLSBhL2RyaXZlcnMvY3B1
aWRsZS9nb3Zlcm5vcnMvdGVvLmMKKysrIGIvZHJpdmVycy9jcHVpZGxlL2dvdmVybm9ycy90ZW8u
YwpAQCAtNTA3LDggKzUwNyw3IEBAIHN0YXRpYyB2b2lkIHRlb19yZWZsZWN0KHN0cnVjdCBjcHVp
ZGxlX2QKIAlzdHJ1Y3QgdGVvX2NwdSAqY3B1X2RhdGEgPSBwZXJfY3B1X3B0cigmdGVvX2NwdXMs
IGRldi0+Y3B1KTsKIAogCWRldi0+bGFzdF9zdGF0ZV9pZHggPSBzdGF0ZTsKLQlpZiAoZGV2LT5w
b2xsX3RpbWVfbGltaXQgfHwKLQkgICAgKHRpY2tfbm9oel9pZGxlX2dvdF90aWNrKCkgJiYgY3B1
X2RhdGEtPnNsZWVwX2xlbmd0aF9ucyA+IFRJQ0tfTlNFQykpIHsKKwlpZiAoZGV2LT5wb2xsX3Rp
bWVfbGltaXQgfHwgdGlja19ub2h6X2lkbGVfZ290X3RpY2soKSkgewogCQkvKgogCQkgKiBUaGUg
d2FrZXVwIHdhcyBub3QgImdlbnVpbmUiLCBidXQgdHJpZ2dlcmVkIGJ5IG9uZSBvZiB0aGUKIAkJ
ICogc2FmZXR5IG5ldHMuCg==
--00000000000073624f0642ff960f--


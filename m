Return-Path: <linux-pm+bounces-37826-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 092A7C527C5
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 14:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4C11882AC8
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 13:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C653E3358C3;
	Wed, 12 Nov 2025 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNSpRgLY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC7532ABC8
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954338; cv=none; b=gD8sUALTXM87KU27S+osrE0H6laVa871wbzT4OLFfBbAKE62EUxVaiuLT1Bs9IGggjiDCtWllLpkkF7kyjFyWaZBeYOC29TSAISh90Hbrfu5aokvuEfUUPzeEi63CaeeoNS5F7Sul0eHtGe6Cr58h1lPQRwvOnCiPgorNqzAuTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954338; c=relaxed/simple;
	bh=FSZdTyLXfhe8/nAXJkQ9acuOYvmM/X1Fd1xp54crBCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SwIYEZ9jBcgcKI2UvzLafLZlcylPLtWd1yhtfIMIAMZW1YeJTcY3TgNp2qPD+ZyHD9afO2LV/scU3a5mO1rMVj2LQ2ylg0UxI2iJ/FHYZHJ3VOuUt3seGEYLzbKCPMVyTYQO9vSqylAkxI2z44VLBXKidVe4B7YsLnoXFfbki5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNSpRgLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C89C19422
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 13:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762954338;
	bh=FSZdTyLXfhe8/nAXJkQ9acuOYvmM/X1Fd1xp54crBCo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hNSpRgLYJneoOq4ob7m3sJBdVAYywwWZhXrmkhKwFohE9y3CLk8kv4JhUMGfnC06/
	 ijT7yIRi0RdUp84JVo+H+WCz6Vc/CiIQKZv70tH/uTRK+lMOVRPxjOMGT1qcWxSM9O
	 OC8uQQT/nKdI6xlU5z2AThcgYXPR4MdNfiN0xjGNtka8bEw1+slxirl1yI1fyXJ52N
	 8wkqnmkQaNL2Ns6w8kAuMQ9/v4Z1zbYEmQC8RTeN+eNuFbNhjHAbp9rVDPFSVvguX5
	 f/AmO+n+NPGYnP7dHwjKAgv1X8jhvu/fjB/xzWz6mBKfkCyw4FGJDr0swT/ssFeMNa
	 PMMVhb6ET+J0g==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c6ddd07c5dso217306a34.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 05:32:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/bGZblJMdOj4XMgYY8mRZC2QPcn/LiU2mDBt5SghJDnxV+4Yk325rIYDY9Lv02NVut1JZX3D4Gg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlmy1+cakHnSdsrNvHQGbzH1Od0FCNEUH0eYUeftefqfGMyob4
	cimVoukh0OP4Wi77aAiCFWdinRncU+Hot+aDgQZLSoi3QVowa/vf2OzHntObyBSPv9Zwaajdg+Y
	6k0hvl9cHorJs1i1duSuHMFSwX/jzk4s=
X-Google-Smtp-Source: AGHT+IHHBBBY0n9kvd7Y5zUBWOzx9NNdc17tlZmvdAlxrxmH4whHs8M5BlH6VgG7xqx3QMI5q5dqBK84gL7PbO52G5M=
X-Received: by 2002:a05:6808:508a:b0:450:30e:5ee0 with SMTP id
 5614622812f47-4507444901bmr1340168b6e.10.1762954337438; Wed, 12 Nov 2025
 05:32:17 -0800 (PST)
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
 <CAJZ5v0i_ZUD1=3JDABJZ3fcdD7r8uMU36=mam8r2=1P02YksYw@mail.gmail.com>
 <f0a2492b-9cea-4450-88ca-be8f99f3e0fe@arm.com> <CAEmPcwvui5Cg5yoa9NEq5b3OZREb08tbmy4=f=adTLuLPBgGgw@mail.gmail.com>
 <0c018867-c092-4f8e-8f7a-32bb02de3ad5@arm.com> <CAEmPcwuVPMONrDHcnxbWpoG5K5DFwf-u2i7wuOK4Q9HvF2uOhw@mail.gmail.com>
 <2a429c41-8624-408c-9db0-4450ab76e52f@arm.com> <a33965da-81d8-47c5-9fa0-434812f2bd72@arm.com>
 <CAJZ5v0jjswmSsSRqfjrbDVD4rpYvp2qCdweYrK0JV0zUketczQ@mail.gmail.com> <939deff8-7856-4d9b-be91-eda06fac21d0@arm.com>
In-Reply-To: <939deff8-7856-4d9b-be91-eda06fac21d0@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Nov 2025 14:32:02 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ic0+sG7yp=wXAcsTBmHdXLe8gKLosFJj48AGuCQ=1beg@mail.gmail.com>
X-Gm-Features: AWmQ_blTXlmM3IG8tfJlKUxulccv-s-yePjgRRUqoMCP1NMty6W5Sj-5zM82jgk
Message-ID: <CAJZ5v0ic0+sG7yp=wXAcsTBmHdXLe8gKLosFJj48AGuCQ=1beg@mail.gmail.com>
Subject: Re: Regression in TEO cpuidle governor between 6.6 and 6.12
To: Christian Loehle <christian.loehle@arm.com>, Reka Norman <rekanorman@chromium.org>
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000009ef3a064365cbf2"

--00000000000009ef3a064365cbf2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 6:20=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/11/25 11:48, Rafael J. Wysocki wrote:
> > On Tue, Nov 11, 2025 at 11:48=E2=80=AFAM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 11/11/25 10:00, Christian Loehle wrote:

[...]

> >>> I see two issues:
> >>> 1) Because of DECAY_SHIFT 3 values < 8 cannot decay (I guess this wou=
ldn't really be an issue without 2))
> >
> > This shouldn't be a problem.
>
> Agreed, it should be a non-issue. Nonetheless if this wasn't the case $su=
bject would've likely
> never been an issue.

Well, I think that the leftovers can be cleared when they become less than =
8.

> >
> >>> 2) if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) isn't a=
n appropriate check, it will
> >>> exclude the state if it its idx_hit_sum make up the vast majority of =
cpu_data->total (i.e. it would
> >>> have been a really good candidate actually).
> >
> > Well, it would exclude the state if the sum of hits for the states
> > below it is large enough.  This is questionable (because why would
> > hits matter here), but I attempted to make the change below and
> > somebody reported a regression IIRC.
> >
> > This check is related to the problem at hand though (see below).
> >
> >>>
> >>> I lightly tested the below, it seems to be at least comparable to mai=
nline teo.
> >>> (the documentation/comments would need adapting too, of course)
> >>>
> >>> -----8<-----
> >>>
> >>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/govern=
ors/teo.c
> >>> index bfa55c1eab5b..f8f76e3b8364 100644
> >>> --- a/drivers/cpuidle/governors/teo.c
> >>> +++ b/drivers/cpuidle/governors/teo.c
> >>> @@ -355,7 +355,7 @@ static int teo_select(struct cpuidle_driver *drv,=
 struct cpuidle_device *dev,
> >>>          * all of the deeper states, a shallower idle state is likely=
 to be a
> >>>          * better choice.
> >>>          */
> >>> -       if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
> >>> +       if (2 * idx_intercept_sum > idx_hit_sum) {
> >>>                 int first_suitable_idx =3D idx;
> >>>
> >>>                 /*
> >>>
> >>>
> >>
> >> ... nevermind the patch, idx_hit_sum is of course the sum of 0...idx-1=
.
> >> Maybe something like this, again lightly tested:
> >>
> >> -----8<-----
> >>
> >> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governo=
rs/teo.c
> >> index 173ddcac540a..6bfb9cedb75e 100644
> >> --- a/drivers/cpuidle/governors/teo.c
> >> +++ b/drivers/cpuidle/governors/teo.c
> >> @@ -383,13 +395,15 @@ static int teo_select(struct cpuidle_driver *drv=
, struct cpuidle_device *dev,
> >>                  * has been stopped already into account.
> >>                  */
> >>                 intercept_sum =3D 0;
> >> +               hit_sum =3D 0;
> >>
> >>                 for (i =3D idx - 1; i >=3D 0; i--) {
> >>                         struct teo_bin *bin =3D &cpu_data->state_bins[=
i];
> >>
> >>                         intercept_sum +=3D bin->intercepts;
> >> +                       hit_sum +=3D bin->hits;
> >>
> >> -                       if (2 * intercept_sum > idx_intercept_sum) {
> >> +                       if (2 * intercept_sum > cpu_data->total || 2 *=
 hit_sum > cpu_data->total) {
> >>                                 /*
> >>                                  * Use the current state unless it is =
too
> >>                                  * shallow or disabled, in which case =
take the
> >
> > This will only matter after the deepest state has been rejected
> > already and on the system in question this means selecting state 0 no
> > matter what.
> >
>
> Ah, right!
>
>
> > The pre-6.12 behavior can be explained if tick wakeups are taken into a=
ccount.
> >
> > Namely, when state 0 is chosen (because of the check mentioned above),
> > the tick is not stopped and the sleep length is KTIME_MAX.  If the
> > subsequent wakeup is a tick one, it will be counted as a hit on the
> > deepest state (and it will contribute to the total sum in the check
> > mentioned above).  Then, at one point, cpu_data->total will be large
> > enough and the deepest state will become the candidate one.  If
> > tick_nohz_get_sleep_length() returns a large value at that point, the
> > tick will be stopped and the deepest state will be entered.  Nirvana
> > ensues.
>
> So fundamentally we will have to count tick-wakeups as a) nothing, which
> doesn't allow us to ever break out of the intercept logic that caused us
> to leave the tick on b) intercepts, which is bonkers and doesn't allow us
> to ever break out and c) hits =3D=3D sleep_length would've been accurate.
> Of course counting a tick wakeup as a hit for sleep_length negates the
> intercept logic.

Not quite.  The intercept logic is there for wakeups other than tick
wakeups and timer wakeups.

I actually think that tick wakeups can be counted as hits on the
deepest available state - maybe only when tick wakeups dominate the
wakeup pattern - but generally this is not unreasonable: When the
wakeup pattern is dominated by tick wakeups, this by itself is a good
enough reason to stop the tick.

The attached patch tests the theory above, let's see how far it gets
us.  Reka, can you please test this one on top of the mainline and see
if it gets you more deep idle state residency?

The difference between it and the previous one is that the sleep
length is set to KTIME_MAX on every tick wakeup.

> >
> > The change in commit 4b20b07ce72f causes the sleep length to fall
> > below the deepest idle state target residency at least sometimes in
> > the scenario above, and if the subsequent wakeup is a tick one, it
> > doesn't matter how it is counted - it will contribute to selecting
> > idle state 0.
> >
> > The mainline is affected to a lesser extent because it sometimes does
> > what pre-6.12 did.
> >
> > IMV addressing this would require changing the check you've identified
> > as the culprit, but I'm not sure how to change it TBH.
>
> I guess we don't really have a choice but to have every 10th or so idle
> during intercept try the sleep_length state with tick off (i.e. disregard
> intercept) and see if that's still the case? If the sleep length is now
> accurate and we haven't been woken up then keep disregarding until it doe=
s
> again?

Fortunately, we know when the CPU is woken up by the tick, so we can
use that information.

> It's the smartest thing I can come up with for now, but I'll give it some
> more thought!

Thanks!

--00000000000009ef3a064365cbf2
Content-Type: text/x-patch; charset="US-ASCII"; name="cpuidle-teo-tick-wakeups.patch"
Content-Disposition: attachment; filename="cpuidle-teo-tick-wakeups.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mhw1c4wp0>
X-Attachment-Id: f_mhw1c4wp0

LS0tCiBkcml2ZXJzL2NwdWlkbGUvZ292ZXJub3JzL3Rlby5jIHwgICAxMiArKysrKysrLS0tLS0K
IDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgotLS0gYS9k
cml2ZXJzL2NwdWlkbGUvZ292ZXJub3JzL3Rlby5jCisrKyBiL2RyaXZlcnMvY3B1aWRsZS9nb3Zl
cm5vcnMvdGVvLmMKQEAgLTUwNywxMyArNTA3LDE1IEBAIHN0YXRpYyB2b2lkIHRlb19yZWZsZWN0
KHN0cnVjdCBjcHVpZGxlX2QKIAlzdHJ1Y3QgdGVvX2NwdSAqY3B1X2RhdGEgPSBwZXJfY3B1X3B0
cigmdGVvX2NwdXMsIGRldi0+Y3B1KTsKIAogCWRldi0+bGFzdF9zdGF0ZV9pZHggPSBzdGF0ZTsK
LQlpZiAoZGV2LT5wb2xsX3RpbWVfbGltaXQgfHwKLQkgICAgKHRpY2tfbm9oel9pZGxlX2dvdF90
aWNrKCkgJiYgY3B1X2RhdGEtPnNsZWVwX2xlbmd0aF9ucyA+IFRJQ0tfTlNFQykpIHsKKwlpZiAo
ZGV2LT5wb2xsX3RpbWVfbGltaXQpIHsKKwkJZGV2LT5wb2xsX3RpbWVfbGltaXQgPSBmYWxzZTsK
KwkJY3B1X2RhdGEtPmFydGlmaWNpYWxfd2FrZXVwID0gdHJ1ZTsKKwl9IGVsc2UgaWYgKHRpY2tf
bm9oel9pZGxlX2dvdF90aWNrKCkpIHsKIAkJLyoKLQkJICogVGhlIHdha2V1cCB3YXMgbm90ICJn
ZW51aW5lIiwgYnV0IHRyaWdnZXJlZCBieSBvbmUgb2YgdGhlCi0JCSAqIHNhZmV0eSBuZXRzLgor
CQkgKiBDb3VudCBhbGwgdGljayB3YWtldXBzIGFzIGhpdHMgb24gdGhlIGRlZXBlc3QgYXZhaWxh
YmxlIGlkbGUKKwkJICogc3RhdGUuCiAJCSAqLwotCQlkZXYtPnBvbGxfdGltZV9saW1pdCA9IGZh
bHNlOworCQljcHVfZGF0YS0+c2xlZXBfbGVuZ3RoX25zID0gS1RJTUVfTUFYOwogCQljcHVfZGF0
YS0+YXJ0aWZpY2lhbF93YWtldXAgPSB0cnVlOwogCX0gZWxzZSB7CiAJCWNwdV9kYXRhLT5hcnRp
ZmljaWFsX3dha2V1cCA9IGZhbHNlOwo=
--00000000000009ef3a064365cbf2--


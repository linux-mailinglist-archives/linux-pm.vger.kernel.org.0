Return-Path: <linux-pm+bounces-31975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB08AB1BA76
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 20:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15DC5182B54
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 18:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E4D29A9D3;
	Tue,  5 Aug 2025 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXJ9jPep"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2D515ECCC;
	Tue,  5 Aug 2025 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419835; cv=none; b=eafA+ZpdbG38BccEwo2knkzyyt1yx7qON9yb1Cb56eqDK0BkryDzRzYKogHfYWYZsgPP+71TnoqFr8LfI4p+onOnBhfGzcC6VpKJhIZelvlHOuFYq20ULcSySgAqPmegUiIuJnyEDUGF1XyCJY8TLF3f6n4jvj9qH027zc8NdrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419835; c=relaxed/simple;
	bh=YuiY8/+omzxC9b9OB1MwQijHAnOhpTYyzNvzlGQ8c1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpG76n94x3W59P9WlA2ml4lBOkTVhXjTMHrQxTBiavYYbjVUraeH30AceUKeNU9YmkHMQAijsHmcwWgOBWQu/q9dWa2DmwlgL/ap2A/wAPnnZe+nvYzNPWlsGninAMIl0N7qHRsRiNGXSDP1IhZJGtogFKfqQnwxOvgJzi7H73s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXJ9jPep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A2AC4CEFB;
	Tue,  5 Aug 2025 18:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754419835;
	bh=YuiY8/+omzxC9b9OB1MwQijHAnOhpTYyzNvzlGQ8c1o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dXJ9jPepJjoJSa/iKFsC9DYeWWPrh6VUSr4xajokhGjZty1+OsZjLd+4gdks6jw8g
	 k2ASXcDnF+uPPI8E8y0TdbfEIcU67rbIRGi+2EJcUK6DcUcpADQKbO7lBIJdflt8K0
	 ltYyEsFHVIzFu858cvfVkF9pOc6+OvOTugo7+KeJD/TneqEsShic7CZmFiu9uIbLkt
	 Gf1NtMdHPJ56EFzuy86CMrwPrtOaGdCRnQ93ZOlEaMi+udevgnB1QCOfmaU9KQFPKU
	 joTy1ijsBWjhrCxlSPD1PLNW159jVgJWh18ZBIKBnuJr/R01Z5G3y001eUSI5Du7XB
	 78Q9ELP0dFovg==
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31ee880f7d2so6140265a91.0;
        Tue, 05 Aug 2025 11:50:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTeOGFsfUKqGKiVCEUVJ4HRPoneSU3kGeD2Ttb8xhLcXcAUyzMoScfJ+ULfFpqP3zQ5F/Jehs0b4asee8=@vger.kernel.org, AJvYcCXqFyabZeuwKsMbKQAjhZNi5SPmL8a0twA8rKjYQqVNVwvmfRb3qiGvwxf1J2KzCXqYIYsOMzVYT/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj1SVfLi13XL6yp641o0kubHrpRO9/FmTIgDAwF/SXBcX1x9MR
	NNwCGWHh7/U8W0XrSLp9YHXynjvO/qkehygVka/Fdot+gZHMqBSuIa93BpqsrWyHrHts1p0xgVF
	VawO/ZeRG5EfC4FkuvJvHfxYkKJPdkWw=
X-Google-Smtp-Source: AGHT+IEQuP6M+vaY7su5SFq5ZyNDX81BmCB0XHsef+jUvWmuqHeIBD2GHNotSpD8hChvA12TuPLTEs7pPnd7L5B2JxU=
X-Received: by 2002:a17:90a:ec87:b0:311:ad7f:329c with SMTP id
 98e67ed59e1d1-321162c790bmr22231788a91.18.1754419834446; Tue, 05 Aug 2025
 11:50:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1916668.tdWV9SEqCh@rjwysocki.net> <7770672.EvYhyI6sBW@rjwysocki.net>
 <86o6sv6n94.wl-maz@kernel.org> <CAJZ5v0g=eSeAp96mHCOm+C9jis3uNRXgPhNgtT0SgP9kZ1emvw@mail.gmail.com>
 <86ectpahdj.wl-maz@kernel.org>
In-Reply-To: <86ectpahdj.wl-maz@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Aug 2025 20:50:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jnSwkOHuq5QjvVN7RLk=BV1Oi6Jbv1SvP5TCbAERq0yw@mail.gmail.com>
X-Gm-Features: Ac12FXzdAo-v0CYThzIi79jDoMvCFlyxXtx6Fv47kPAi-M2vswtv7aRS7kgSrp8
Message-ID: <CAJZ5v0jnSwkOHuq5QjvVN7RLk=BV1Oi6Jbv1SvP5TCbAERq0yw@mail.gmail.com>
Subject: Re: [RFT][PATCH v1 5/5] cpuidle: menu: Avoid discarding useful information
To: Marc Zyngier <maz@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: multipart/mixed; boundary="0000000000000572dc063ba2b36d"

--0000000000000572dc063ba2b36d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 6:00=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 05 Aug 2025 14:23:56 +0100,
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >
> > On Mon, Aug 4, 2025 at 6:54=E2=80=AFPM Marc Zyngier <maz@kernel.org> wr=
ote:
> > >
> > > [+ Thomas, Mark]
> > >
> > > On Thu, 06 Feb 2025 14:29:05 +0000,
> > > "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> > > >
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > When giving up on making a high-confidence prediction,
> > > > get_typical_interval() always returns UINT_MAX which means that the
> > > > next idle interval prediction will be based entirely on the time ti=
ll
> > > > the next timer.  However, the information represented by the most
> > > > recent intervals may not be completely useless in those cases.
> > > >
> > > > Namely, the largest recent idle interval is an upper bound on the
> > > > recently observed idle duration, so it is reasonable to assume that
> > > > the next idle duration is unlikely to exceed it.  Moreover, this is
> > > > still true after eliminating the suspected outliers if the sample
> > > > set still under consideration is at least as large as 50% of the
> > > > maximum sample set size.
> > > >
> > > > Accordingly, make get_typical_interval() return the current maximum
> > > > recent interval value in that case instead of UINT_MAX.
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/cpuidle/governors/menu.c |   13 ++++++++++++-
> > > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > > >
> > > > --- a/drivers/cpuidle/governors/menu.c
> > > > +++ b/drivers/cpuidle/governors/menu.c
> > > > @@ -190,8 +190,19 @@
> > > >        * This can deal with workloads that have long pauses intersp=
ersed
> > > >        * with sporadic activity with a bunch of short pauses.
> > > >        */
> > > > -     if ((divisor * 4) <=3D INTERVALS * 3)
> > > > +     if (divisor * 4 <=3D INTERVALS * 3) {
> > > > +             /*
> > > > +              * If there are sufficiently many data points still u=
nder
> > > > +              * consideration after the outliers have been elimina=
ted,
> > > > +              * returning without a prediction would be a mistake =
because it
> > > > +              * is likely that the next interval will not exceed t=
he current
> > > > +              * maximum, so return the latter in that case.
> > > > +              */
> > > > +             if (divisor >=3D INTERVALS / 2)
> > > > +                     return max;
> > > > +
> > > >               return UINT_MAX;
> > > > +     }
> > > >
> > > >       /* Update the thresholds for the next round. */
> > > >       if (avg - min > max - avg)
> > >
> > > It appears that this patch, which made it in 6.15, results in *a lot*
> > > of extra interrupts on one of my arm64 test machines.
> > >
> > > * Without this patch:
> > >
> > > maz@big-leg-emma:~$ vmstat -y 1
> > > procs -----------memory---------- ---swap-- -----io---- -system-- ---=
---cpu-----
> > >  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us =
sy id wa st
> > >  1  0      0 65370828  29244 106088    0    0     0     0   66   26  =
0  0 100  0  0
> > >  1  0      0 65370828  29244 106088    0    0     0     0  103   66  =
0  0 100  0  0
> > >  1  0      0 65370828  29244 106088    0    0     0     0   34   12  =
0  0 100  0  0
> > >  1  0      0 65370828  29244 106088    0    0     0     0   25   12  =
0  0 100  0  0
> > >  1  0      0 65370828  29244 106088    0    0     0     0   28   14  =
0  0 100  0  0
> > >
> > > we're idling at only a few interrupts per second, which isn't bad for
> > > a 24 CPU toy.
> > >
> > > * With this patch:
> > >
> > > maz@big-leg-emma:~$ vmstat -y 1
> > > procs -----------memory---------- ---swap-- -----io---- -system-- ---=
---cpu-----
> > >  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us =
sy id wa st
> > >  1  0      0 65361024  28420 105388    0    0     0     0 3710   27  =
0  0 100  0  0
> > >  1  0      0 65361024  28420 105388    0    0     0     0 3399   20  =
0  0 100  0  0
> > >  1  0      0 65361024  28420 105388    0    0     0     0 4439   78  =
0  0 100  0  0
> > >  1  0      0 65361024  28420 105388    0    0     0     0 5634   14  =
0  0 100  0  0
> > >  1  0      0 65361024  28420 105388    0    0     0     0 5575   14  =
0  0 100  0  0
> > >
> > > we're idling at anywhere between 3k and 6k interrupts per second. Not
> > > exactly what you want. This appears to be caused by the broadcast
> > > timer IPI.
> > >
> > > Reverting this patch on top of 6.16 restores sanity on this machine.
> >
> > I don't know what is going on here, but it looks highly suspicious to m=
e.
>
> What does? My observation? The likelihood of this patch being the
> source (or the trigger) for an unwanted behaviour? Something else?

The behavior of the platform, which is basically confirmed by
Christian's observation here:

https://lore.kernel.org/linux-pm/7ffcb716-9a1b-48c2-aaa4-469d0df7c792@arm.c=
om/

And yes, cpuidle has a problem with this corner case.

> > The only effect of the change in question should be selecting a
> > shallower idle state occasionally and why would this alone cause the
> > number of wakeup interrupts to increase?
>
> You tell me. I'm the messenger here.

The tick stopping logic in menu appears to be confused.

> > Arguably, it might interfere with the tick stopping logic if
> > predicted_ns happened to be less than TICK_NSEC sufficiently often,
> > but that is not expected to happen on an idle system because in that
> > case the average interval between genuine wakeups is relatively large.
> > The tick itself is not counted as a wakeup event, so returning a
> > shallower state at one point shouldn't affect future predictions, but
> > the data above suggests that it actually does affect them.
> >
> > It looks like selecting a shallower idle state by the governor at one
> > point causes more wakeup interrupts to occur in the future which is
> > really note expected to happen.
> >
> > Christian, what do you think?
> >
> > > I suspect that we're entering some deep idle state in a much more
> > > aggressive way,
> >
> > The change actually goes the other way around.  It causes shallower
> > idle states to be more likely to be selected overall.
>
> Another proof that I don't understand a thing, and that I should go
> play music instead of worrying about kernel issues.
>
> >
> > > leading to a global timer firing as a wake-up mechanism,
> >
> > What timer and why would it fire?
>
> The arch_timer_mem timer, which is used as a backup timer when the
> CPUs lose their timer context while going into a deep enough idle
> state.

Interesting.  They should not go anywhere below WFI as per the message
from Christian linked above.

> >
> > > and the broadcast IPI being used to kick everybody else
> > > back. This is further confirmed by seeing the broadcast IPI almost
> > > disappearing completely if I load the system a bit.
> > >
> > > Daniel, you should be able to reproduce this on a Synquacer box (this
> > > what I used here).
> > >
> > > I'm happy to test things that could help restore some sanity.
> >
> > Before anything can be tested, I need to understand what exactly is goi=
ng on.
> >
> > What cpuidle driver is used on this platform?
>
> psci_idle.

Right.

> > Any chance to try the teo governor on it to see if this problem can
> > also be observed?
>
> Neither ladder nor teo have this issue. The number of broadcast timer
> IPIs is minimal, and so is the number of interrupts delivered from the
> backup timer. Only menu exhibits the IPI-hose behaviour on this box
> (and only this one).

Good to know, thanks!

<shameless plug>Switch over to teo?</shameless plug>

> > Please send the output of
> >
> > $ grep -r '.*' /sys/devices/system/cpu/cpu*/cpuidle
> >
> > collected after a period of idleness from the kernel in which the
> > change in question is present and from a kernel without it?
>
> * with the change present: https://pastebin.com/Cb45Rysy

This is what Christian said, idle states 1 and 2 get rejected every time.

> * with the change reverted: https://pastebin.com/qRy2xzeT

And same here, but in this case menu doesn't get confused because
predicted_ns is basically UINT_MAX all the time.

The attached patch (completely untested) causes menu to insert an
"invalid interval" value to the array of recent intervals after the
idle state selected previously got rejected.  It basically should
prevent get_typical_interval() from returning small values if deeper
idle states get rejected all the time.

--0000000000000572dc063ba2b36d
Content-Type: text/x-patch; charset="US-ASCII"; name="cpuidle-menu-corner-case.patch"
Content-Disposition: attachment; filename="cpuidle-menu-corner-case.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mdyw2lla0>
X-Attachment-Id: f_mdyw2lla0

LS0tCiBkcml2ZXJzL2NwdWlkbGUvZ292ZXJub3JzL21lbnUuYyB8ICAgMTUgKysrKysrKysrKyst
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCklu
ZGV4OiBsaW51eC1wbS9kcml2ZXJzL2NwdWlkbGUvZ292ZXJub3JzL21lbnUuYwo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
Ci0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvY3B1aWRsZS9nb3Zlcm5vcnMvbWVudS5jCisrKyBs
aW51eC1wbS9kcml2ZXJzL2NwdWlkbGUvZ292ZXJub3JzL21lbnUuYwpAQCAtOTcsNiArOTcsMTQg
QEAgc3RhdGljIGlubGluZSBpbnQgd2hpY2hfYnVja2V0KHU2NCBkdXJhdAogCiBzdGF0aWMgREVG
SU5FX1BFUl9DUFUoc3RydWN0IG1lbnVfZGV2aWNlLCBtZW51X2RldmljZXMpOwogCitzdGF0aWMg
dm9pZCBtZW51X3VwZGF0ZV9pbnRlcnZhbHMoc3RydWN0IG1lbnVfZGV2aWNlICpkYXRhLCB1bnNp
Z25lZCBpbnQgaW50ZXJ2YWxfdXMpCit7CisJLyogVXBkYXRlIHRoZSByZXBlYXRpbmctcGF0dGVy
biBkYXRhLiAqLworCWRhdGEtPmludGVydmFsc1tkYXRhLT5pbnRlcnZhbF9wdHIrK10gPSBpbnRl
cnZhbF91czsKKwlpZiAoZGF0YS0+aW50ZXJ2YWxfcHRyID49IElOVEVSVkFMUykKKwkJZGF0YS0+
aW50ZXJ2YWxfcHRyID0gMDsKK30KKwogc3RhdGljIHZvaWQgbWVudV91cGRhdGUoc3RydWN0IGNw
dWlkbGVfZHJpdmVyICpkcnYsIHN0cnVjdCBjcHVpZGxlX2RldmljZSAqZGV2KTsKIAogLyoKQEAg
LTIyMiw2ICsyMzAsOCBAQCBzdGF0aWMgaW50IG1lbnVfc2VsZWN0KHN0cnVjdCBjcHVpZGxlX2Ry
CiAJaWYgKGRhdGEtPm5lZWRzX3VwZGF0ZSkgewogCQltZW51X3VwZGF0ZShkcnYsIGRldik7CiAJ
CWRhdGEtPm5lZWRzX3VwZGF0ZSA9IDA7CisJfSBlbHNlIGlmICghZGV2LT5sYXN0X3Jlc2lkZW5j
eV9ucykgeworCQltZW51X3VwZGF0ZV9pbnRlcnZhbHMoZGF0YSwgVUlOVF9NQVgpOwogCX0KIAog
CS8qIEZpbmQgdGhlIHNob3J0ZXN0IGV4cGVjdGVkIGlkbGUgaW50ZXJ2YWwuICovCkBAIC00ODIs
MTAgKzQ5Miw3IEBAIHN0YXRpYyB2b2lkIG1lbnVfdXBkYXRlKHN0cnVjdCBjcHVpZGxlX2QKIAog
CWRhdGEtPmNvcnJlY3Rpb25fZmFjdG9yW2RhdGEtPmJ1Y2tldF0gPSBuZXdfZmFjdG9yOwogCi0J
LyogdXBkYXRlIHRoZSByZXBlYXRpbmctcGF0dGVybiBkYXRhICovCi0JZGF0YS0+aW50ZXJ2YWxz
W2RhdGEtPmludGVydmFsX3B0cisrXSA9IGt0aW1lX3RvX3VzKG1lYXN1cmVkX25zKTsKLQlpZiAo
ZGF0YS0+aW50ZXJ2YWxfcHRyID49IElOVEVSVkFMUykKLQkJZGF0YS0+aW50ZXJ2YWxfcHRyID0g
MDsKKwltZW51X3VwZGF0ZV9pbnRlcnZhbHMoZGF0YSwga3RpbWVfdG9fdXMobWVhc3VyZWRfbnMp
KTsKIH0KIAogLyoqCg==
--0000000000000572dc063ba2b36d--


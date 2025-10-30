Return-Path: <linux-pm+bounces-37122-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F28DC213CD
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 17:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 564584F083D
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 16:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97EA2C325C;
	Thu, 30 Oct 2025 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9ZpgQQj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F8D1E7C19
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842174; cv=none; b=MsoGthI6NYHch9pJ6Zbwj3132PashbCs3EQ7QKAqY7E4HGQTSjGJ1fJd8W4/24xFCv6nHqobsUkEKUarR7ReTuQmCKJ2V+EtUdQ+US0Z2Fx20AuIoCudaI+O5PqY5SB70+sVELsEP8SGYobxp2W4q5Pdww1gL9cpQD0Bh/DJ5JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842174; c=relaxed/simple;
	bh=vP+pymK20F1Ue0pbPPjwYm+BT7lM2cGdHDR+EnkeI0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LrWWYbLEPz9V+f6gK7DYvbVpiv7GVSigeb/VmlhGTdJwlfqVnr1/vWzNXHL52T70SZYDwfbAp63hbsbPt1upTjffxZRtdz4QtCDQZM0S9F6ozSdAm2/VSKGmYUO8TX5dKWl+W9qfyLEkOzPzrB8mG0YX4gz2Br2XLIrXfDOiu0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9ZpgQQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DEBC19425
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 16:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761842174;
	bh=vP+pymK20F1Ue0pbPPjwYm+BT7lM2cGdHDR+EnkeI0I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=C9ZpgQQjz6L9fAbot4Bp72ytRoW5qf9QXqZVuIy+QIJaLNtG0baeMhddbKQl9SxE2
	 cNeoPebjo6ys8NrxPxsvD1Sjia9n9NjQrUNF/OILEP1Myh1e+WhH+Z2u+rpl0tWI12
	 sEAN+jh8O5KiIzRYbmgdl5brbfbQ4jDfJd+iYlO/SEwGSo30peFga5/YCWlVDgTKNz
	 xKq9E39rdz+OTKiPwdnc9SUqTZuFM8rPeGKvohEaq4nPLxA4CU+0HdQe11o2dH48kA
	 F9GgsFIF6+EqOE+Iizszfl+o4TG0Ugdg2HNL/di9eYnDvaGbJ8itVnyIeQUqhCwgvA
	 ZzBECmezYgYnw==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-65681b64384so641305eaf.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 09:36:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhpJI2lT5Gk256nN3SFAA5YnjQ2aBCMIDFDS9njBfdXvzh7rOsxdyedX6OjR5PRtSt8D+1zHFumQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp04eW9RA5QxQwpbpt4cgE0DX7oW8KZbWb1zb9QTJlVkSOYHaL
	V0RmVqr2EL/B0mbBet6tqKOyPj7QkXuJhxAVfpHyd+1Cse9P010EpVK8nthnqNMa0CeUr7DAq3N
	5q+EYhD9pv5aW6gfuIXm3+z6nC6t1f9c=
X-Google-Smtp-Source: AGHT+IE6ZzggTcJK8TTkZwg9J05sdyp5k6C/3bRv3YPq4OFWafDOlpdYgwXmlie329n1ehZsFqf7mdgO80evj7Lnu58=
X-Received: by 2002:a05:6870:970a:b0:344:34e3:5143 with SMTP id
 586e51a60fabf-3dacbfabd05mr114995fac.28.1761842173362; Thu, 30 Oct 2025
 09:36:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <CAJZ5v0i_0K6+nCvBC55Bbu7XuKYjHrky3uG_aZ3aM0HMymcfeg@mail.gmail.com>
 <CAPDyKFpYfLJ1F1ynLAZLJBoWp+Uk-k2B0796_yWQTNg4xT9zew@mail.gmail.com>
 <CAJZ5v0igMhr=N90As66dioXXzL8YL11PN3k49n5-yoPuHNR-_w@mail.gmail.com>
 <CAJZ5v0jSvU7=bmscRyQrvoWA0q=AgbDE3Ad1jf+4PTdzZgSNjw@mail.gmail.com>
 <CAPDyKFr=uVS0CsuFnTjXH+o+P+xrG7GKj2O92mGgqiSo-tk9Bg@mail.gmail.com>
 <CAJZ5v0g2TebJDR5SWdFfyU7dksShZV0qXeO+yP6V_QTCsE--AQ@mail.gmail.com> <CAPDyKFpBHZ758khTGhidcyYCwy7dDtkabJ4trg4K16BhWEpUYA@mail.gmail.com>
In-Reply-To: <CAPDyKFpBHZ758khTGhidcyYCwy7dDtkabJ4trg4K16BhWEpUYA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Oct 2025 17:36:02 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jdT28Q0mnyU_2RKEYWhEHhQvWBAzsra1Jp9dBCLSCO1Q@mail.gmail.com>
X-Gm-Features: AWmQ_bkfZ9mwS_MKPHlZ7aBvNTfFbAuA_7RwNKginJV-rY0GyuG4SykcfE-k1qU
Message-ID: <CAJZ5v0jdT28Q0mnyU_2RKEYWhEHhQvWBAzsra1Jp9dBCLSCO1Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PM: QoS: Introduce a CPU system-wakeup QoS limit
 for s2idle
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Kevin Hilman <khilman@baylibre.com>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 4:13=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Thu, 30 Oct 2025 at 15:06, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Thu, Oct 30, 2025 at 1:44=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
> > >
> > > On Thu, 30 Oct 2025 at 13:29, Rafael J. Wysocki <rafael@kernel.org> w=
rote:
> > > >
> > > > On Thu, Oct 30, 2025 at 1:26=E2=80=AFPM Rafael J. Wysocki <rafael@k=
ernel.org> wrote:
> > > > >
> > > > > On Thu, Oct 30, 2025 at 1:23=E2=80=AFPM Ulf Hansson <ulf.hansson@=
linaro.org> wrote:
> > > > > >
> > > > > > On Wed, 29 Oct 2025 at 15:53, Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> > > > > > >
> > > > > > > On Thu, Oct 16, 2025 at 5:19=E2=80=AFPM Ulf Hansson <ulf.hans=
son@linaro.org> wrote:
> > > > > > > >
> > > > > > > > Changes in v2:
> > > > > > > >         - Limit the new QoS to CPUs  and make some correspo=
nding renaming of the
> > > > > > > >         functions along with name of the device node for us=
er space.
> > > > > > > >         - Make sure we deal with the failure/error path cor=
rectly when there are
> > > > > > > >         no state available for s2idle.
> > > > > > > >         - Add documentation.
> > > > > > > >
> > > > > > > > Some platforms supports multiple low-power states for CPUs =
that can be used
> > > > > > > > when entering system-wide suspend and s2idle in particular.=
 Currently we are
> > > > > > > > always selecting the deepest possible state for the CPUs, w=
hich can break the
> > > > > > > > system-wakeup latency constraint that may be required for s=
ome use-cases.
> > > > > > > >
> > > > > > > > Therefore, this series suggests to introduce a new interfac=
e for user-space,
> > > > > > > > allowing us to specify the CPU system-wakeup QoS limit. The=
 QoS limit is then
> > > > > > > > taken into account when selecting a suitable low-power stat=
e for s2idle.
> > > > > > >
> > > > > > > Last time we discussed this I said I would like the new limit=
 to be
> > > > > > > taken into account by regular "runtime" cpuidle because the "=
s2idle"
> > > > > > > limit should not be less that the "runtime" limit (or at leas=
t it
> > > > > > > would be illogical if that happened).
> > > > > >
> > > > > > Yes, we discussed this, but that was also before we concluded t=
o add a
> > > > > > new file for user-space to operate on after all.
> > > > > >
> > > > > > To me, it looks unnecessarily limiting to not allow them to be
> > > > > > orthogonal,
> > > > >
> > > > > So what's the use case in which it makes sense to have a lower la=
tency
> > > > > limit for s2idle than for runtime?
> > >
> > > Honestly, I don't know, but I just wanted to keep things more flexibl=
e.
> > >
> > > > >
> > > > > > but I am not insisting that it needs to be like this. I
> > > > > > was just thinking that we do not necessarily have to care about=
 the
> > > > > > same use-case in runtime as in the system-suspend state. Moreov=
er,
> > > > > > nothing would prevent user-space from applying the same constra=
int to
> > > > > > both of them, if that is needed.
> > > > > >
> > > > > > >
> > > > > > > It looks like that could be implemented by making
> > > > > > > cpuidle_governor_latency_req() take cpu_wakeup_latency_qos_li=
mit()
> > > > > > > into account, couldn't it?
> > > > > >
> > > > > > Right, but I am not sure we want that. See above.
> > > > >
> > > > > I do or I need to be convinced that this is a bad idea.
> > > >
> > > > And there is a specific reason why I want that.
> > > >
> > > > Namely, say somebody wants to set the same limit for both s2idle an=
d
> > > > "runtime" cpuidle.  If the s2idle limit did not affect "runtime", t=
hey
> > > > would need to open two device special files and write the same valu=
e
> > > > to both of them.  Otherwise, they just need to use the s2idle limit
> > > > and it will work for "runtime" automatically.
> > >
> > > Right. User-space would need to open two files instead of one, but is
> > > that really a problem?
> >
> > It is potentially confusing and error-prone.
> >
> > > What if user-space doesn't want to affect the runtime state-selection=
,
> > > but cares only about a use-case that requires a cpu-wakeup constraint
> > > when resuming from s2idle.
> >
> > Well, I'm not sure if this use case exists at all, which is key here.
> > If it doesn't exist, why make provisions for it?
>
> Well, because it's not possible to change afterwards as it becomes ABI.
>
> It would be silly having to add yet another file for userspace, down
> the road, if it turns out to be needed.

OTOH doing things without a good reason is also not particularly wise.


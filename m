Return-Path: <linux-pm+bounces-20506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C76FA12CF5
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 21:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDEE118893BD
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 20:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DF51D9A54;
	Wed, 15 Jan 2025 20:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSJOpaKU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE091D959B;
	Wed, 15 Jan 2025 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736974107; cv=none; b=Syoo00qJq/uiTvC5HS5ukLcB9Oy8M+YXc5L1MNuzC96Ay+oIDbkFvOkftTF5vyyCZ2SllALvRAT9jVD318P2BWk/CR2CWK2uQ3Zr86097lLgx8zJdsIu1HoKnFpMZx5DvDAgIlqAFrd5x3F4C4mnOkh7DVXf294nhvySwQGsrzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736974107; c=relaxed/simple;
	bh=ajkToPphb6vy2jV89RAM55ANAsAbTzJP3SFWe3HZBus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZGRmIN+De1c0Bbp36zI5EfrIfz0Gbcj4dmLEXbZ60n9PgSBX1U+kLuiyVMpE7HeQN9mV3BckBqA8iCn7/OVQ+pgrMItr18Ljp5QYsD4V1jXmirxN99EGp82ZVb++fOHn/eOlajMNXfcolX5VyLGpeCzvUZWIqU/amHVoQH5aYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSJOpaKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAF4C4CEE3;
	Wed, 15 Jan 2025 20:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736974106;
	bh=ajkToPphb6vy2jV89RAM55ANAsAbTzJP3SFWe3HZBus=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YSJOpaKUeZvpSZfkb6SWaURrV8ehi/h7UGG0dYchEbS8Fbu3ikLJwW/1IzlXcI7a0
	 8U5VKIegt1pKmsLH8C2MWtdYIhxYXnYMHc9Eye9uIxDsktrmKOEmJjmrVa1lI7903j
	 OxFkINW7mbQTt6j8Arvqqpq9xSI2vFrNaCdG68mtmXgEEARHcnqZMNzE9r19ZFjyRo
	 PfkCa5CUBw5Hl7Kc1jkIQY3xWp+47FSJYPbxQN74XxoB6g0qrGrY6NnztUkOgK+4gD
	 eN9EmsOnn7HsI1aupf4fIk6PXRSgcQTOmqYgVSJhY3D1e7NF8KG0WXbjZE+4S2QYHC
	 86+AO5BisE9Vg==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3eb9de518e2so109698b6e.2;
        Wed, 15 Jan 2025 12:48:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjWiWJyXDl/4E1uLyoSTQBjZK582uEgp/B/ZZnBC7G3ZnsoqMbppyC5OBxvOkzyQ4RrDeklk9ep6s=@vger.kernel.org, AJvYcCXWXpzybeTfpoNeK7uTGYnC3Crfd5Df0g4Xkx5qBNiQs0fnF4ljDIqWWkFG3tQuOau1UW2Kczc+FoY0ELg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk2iwn3qc/OBTRlAaGsHFRaOj3Y4uIySa29JUOn40cRSIJJLZ9
	sIhcy12javuGrXeNqa2rq0vV72eyDoQqcIWX4O5RaeJ7VqngsVvFez2gKhhGTZb0VZQDHM233sd
	1ke98DDx7JDIgHAmR8NTMFlUT68s=
X-Google-Smtp-Source: AGHT+IHIO7wiJ1E6+02cXSFHPlXJaIhPRCdReTVr9mQ7JlY2Lu64h7mzW3TPvvjT5nE31EffwwJD2yZiHbIXmHYEAOo=
X-Received: by 2002:a05:6808:398e:b0:3eb:638d:5e28 with SMTP id
 5614622812f47-3ef2eba7205mr21518098b6e.4.1736974105926; Wed, 15 Jan 2025
 12:48:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6116275.lOV4Wx5bFT@rjwysocki.net> <1907276.tdWV9SEqCh@rjwysocki.net>
 <8959e72a-600d-427a-9ab2-54f14b056766@arm.com> <CAJZ5v0iVOg5CnYo8OQ5E8VGLdn4cvVdFFQqpOgpWvij4a4cdxQ@mail.gmail.com>
 <a44d8a62-8753-4efb-8c3a-f9c3cdc1dabc@arm.com>
In-Reply-To: <a44d8a62-8753-4efb-8c3a-f9c3cdc1dabc@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 Jan 2025 21:48:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g2CxmFB3Js09jKk=ym26oEGVUsr5tM2p2vpPU_bczjmA@mail.gmail.com>
X-Gm-Features: AbW1kvZxvndgTWTkn-piLFP8vODDqpvcWTbyiW1DQvpOeDRzmeqrRhrnwh4rNfI
Message-ID: <CAJZ5v0g2CxmFB3Js09jKk=ym26oEGVUsr5tM2p2vpPU_bczjmA@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] cpuidle: teo: Reorder candidate state index checks
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 8:20=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 1/15/25 15:54, Rafael J. Wysocki wrote:
> > On Wed, Jan 15, 2025 at 3:46=E2=80=AFPM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 1/13/25 18:36, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Since constraint_idx may be 0, the candidate state index may change t=
o 0
> >>> after assigning constraint_idx to it, so first check if it is greater
> >>> than constraint_idx (and update it if so) and then check it against 0=
.
> >>
> >> So the reason I've left this where it was is because the prev_intercep=
t_idx
> >> was supposed to query the sleep length if we're in an majority-interce=
pt
> >> period and then it makes sense to query the sleep length (to detect su=
ch
> >> a period being over).
> >> A constraint_idx =3D=3D 0 scenario doesn't need the intercept-machiner=
y to
> >> work at all, why are we querying the sleep length then?
> >
> > In case the constraint is different next time and it's better to know
> > the sleep length to properly classify the wakeup.
>
> I would hope constraints change nowhere near as frequently as
> idle entry / exit happen, is your experience different?

They don't, but they may change at any time and it is kind of good to
have history in case this happens.

> >
> >>>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>>
> >>> This is a rebased variant of
> >>>
> >>> https://lore.kernel.org/linux-pm/8476650.T7Z3S40VBb@rjwysocki.net/
> >>>
> >>> ---
> >>>  drivers/cpuidle/governors/teo.c |   15 ++++++++-------
> >>>  1 file changed, 8 insertions(+), 7 deletions(-)
> >>>
> >>> --- a/drivers/cpuidle/governors/teo.c
> >>> +++ b/drivers/cpuidle/governors/teo.c
> >>> @@ -428,6 +428,14 @@
> >>>                               break;
> >>>               }
> >>>       }
> >>> +
> >>> +     /*
> >>> +      * If there is a latency constraint, it may be necessary to sel=
ect an
> >>> +      * idle state shallower than the current candidate one.
> >>> +      */
> >>> +     if (idx > constraint_idx)
> >>> +             idx =3D constraint_idx;
> >>> +
> >>>       if (!idx && prev_intercept_idx) {
> >>>               /*
> >>>                * We have to query the sleep length here otherwise we =
don't
> >>> @@ -439,13 +447,6 @@
> >>>       }
> >>>
> >>>       /*
> >>> -      * If there is a latency constraint, it may be necessary to sel=
ect an
> >>> -      * idle state shallower than the current candidate one.
> >>> -      */
> >>> -     if (idx > constraint_idx)
> >>> -             idx =3D constraint_idx;
> >>> -
> >>> -     /*
> >>
> >> We could leave this here and just do goto end;?
> >
> > Why would this be better?
>
> Saves querying the sleep length in case of constraint_idx =3D=3D 0, i.e.
> qos request to be very latency-sensitive and us actually adding latency
> here.

Fair enough, but before patch [7/9] leaving it where it is doesn't
really cause it to skip the sleep length check unless state 0 is
"polling".

After patch [7/9] it is possible to add a constraint_idx check against
0 to the "goto out_tick" condition before the
tick_nohz_get_sleep_length() call, that is

if ((!idx || drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_NS)=
 &&
    (2 * cpu_data->short_idle >=3D cpu_data->total || !constraint_idx))
        goto out_tick;

but that would be a separate patch if you will.


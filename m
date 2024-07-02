Return-Path: <linux-pm+bounces-10366-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 284B39244DB
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 19:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63FC284215
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 17:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533721BE22A;
	Tue,  2 Jul 2024 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNEBAC/W"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A67178381;
	Tue,  2 Jul 2024 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940540; cv=none; b=fqJDYPHFCZ0qMSGpZ+TicMwk7pBs5t1LJWPVMnZudc88vVmGZHI0UU6BJDSMP1CpsMfmeLhTGuvoKDyOXurYTicQ2H50KVPVEKvkOnga57BrUjjVrjFWuPK+6GYuLEcQ9zErsoid8ltOwG09kycjyyabjBxpAkdswrGf8B9zHqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940540; c=relaxed/simple;
	bh=Voao/9ZbAQgCxYYXt+AnJWKa7CyUGptJVX/ODDe6bKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VelE5uPwS4G+rq+/fn7Eux8QfmHn8OLmm1tro5F27ARxHEZhSgRiDfC9d+6hxSBqLMzQfsb60HNhawCp3kBPpLWi0waHnj6sUaTHwD5jPI1BRrosB28pxn1IBOFksRucra5kDS7i8M7gt8PI+8hiSh56+HgHnmU6ueasmgESrGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNEBAC/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B68C4AF0A;
	Tue,  2 Jul 2024 17:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719940539;
	bh=Voao/9ZbAQgCxYYXt+AnJWKa7CyUGptJVX/ODDe6bKo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DNEBAC/WytPnR9V+BRdY+5hONNBz7BWJhkn8ERlNYMP58bJq27YNnlfmMTUUeFeDh
	 rB1ugxZay58NfWftptCG/88JWwndPj55OyWUB65/YupL/sF7o7SmbdZMB3nWUsdjtv
	 x1ldPQ551VAu8uL98XSWKxz2Hxzt0pCnpu7Bbj2OqZZK47/eyd2E+9x3bjxXrp34I9
	 nkcdwjNqSZEqnDPYdqAelreLJRSUg/zlhwRtIEscdOo/+gfmSNfaDt61Far8cQXh5b
	 thFPpKlGof1Kh3eMAsO9X34EyARk/BMwLtkNky/hmd6UW5VL3WWkMykEgxhnr1BNb+
	 /EmmtERXHDouQ==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-25cd2b51fd3so617874fac.3;
        Tue, 02 Jul 2024 10:15:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXvn8+p1ex0q6rkfLqwY0cCf9a1LK54PqDv5/f2eiQLV/mSG+KFh6+GhC4oC3AsbH3JQM0/usecD5VWHt9g/bRVv4CZrMrp6q4j/GMQZFWs/TbGo1dtiyRWqEZ1kN/5bAuEAbG87BLKsZpDnfRveeOGRCOjYMUzkmd94fNtDanWeGfi
X-Gm-Message-State: AOJu0YzM14hdvGPfa9Erag4W+q9+h4Ieb80kCa7/h7zb2TYalMt66BLk
	gMdLtl8T5/oVi67AWNqtfe6pC9s2c8gTkZ0/H8raEVt82SO/Eu1eHuC7ZbIPkvPOKizIqakIYsh
	f5ngPk3L8sTHmWiQiehg7OHFG724=
X-Google-Smtp-Source: AGHT+IE1DRCB6qtLcW4MoX0ogT+ywTiqe+dg1pKMXFbqphnd5h9FK8o+rlXfPkXivwsNxTp84BAwQBXh1QBXZpyn1Wc=
X-Received: by 2002:a05:6870:a511:b0:259:f03c:4e90 with SMTP id
 586e51a60fabf-25db36a52edmr9891331fac.4.1719940539219; Tue, 02 Jul 2024
 10:15:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627085451.3813989-1-daniel.lezcano@linaro.org>
 <20240701162600.GA4119789-robh@kernel.org> <98fe3146-07ae-4095-b372-6aed6e080d94@linaro.org>
 <CAJZ5v0ix+RDtrR+r3jd=A_W7D5U7JodMiirJ519-wwLrHeBbSw@mail.gmail.com>
 <1eb7eb88-4230-4803-83fe-415ce0745951@linaro.org> <CAJZ5v0jV+0bWqpCR1Q2rYLJvx0J6hgExzRks6YDPL9gX_HK0rA@mail.gmail.com>
 <2a8f5b5f-b67a-4bd0-afe9-f09473aea2d5@linaro.org>
In-Reply-To: <2a8f5b5f-b67a-4bd0-afe9-f09473aea2d5@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Jul 2024 19:15:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g4A1FYZ+7Cb5ocw78y=1Kdg=HSuza2FpYSAiT2c_ZzaQ@mail.gmail.com>
Message-ID: <CAJZ5v0g4A1FYZ+7Cb5ocw78y=1Kdg=HSuza2FpYSAiT2c_ZzaQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: Introduce user trip points
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 6:31=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> On 02/07/2024 13:03, Rafael J. Wysocki wrote:
>
> [ ... ]
>
> >>> Trips cannot be created on the fly ATM.
> >>>
> >>> What can be done is to create trips that are invalid to start with an=
d
> >>> then set their temperature via sysfs.  This has been done already for
> >>> quite a while AFAICS.
> >>
> >> Yes, I remember that.
> >>
> >> I would like to avoid introducing more weirdness in the thermal
> >> framework which deserve a clear ABI.
> >>
> >> What is missing to create new trip points on the fly ?
> >
> > A different data structure to store them (essentially, a list instead
> > of an array).
> >
> > I doubt it's worth the hassle.
> >
> > What's wrong with the current approach mentioned above?  It will need
> > to be supported going forward anyway.
>
> So when the "user trip point" option will be set, a thermal zone will
> have ~ten(?) user trip points initialized to an invalid temperature ?

If a thermal zone is registered with 10 invalid trip points, htat can
happen already today.

Let's talk about the usage model, though.

IIUC, this would be something like "triggers" I mentioned before: If a
certain temperature level is reached, a notification is sent to user
space, and there are multiple (possibly many) levels like this.  They
can be added and deleted at any time.

There can be an interface for this, as simple as a pair of sysfs
attributes under a thermal zone: add_trigger and remove_trigger.  If
root (or equivalent) writes a (valid) temperature value to
add_trigger, a new trigger is added (up to a limit and provided that
enough memory can be allocated).  Conversely, if a temperature value
is written to remove_trigger and there is a trigger with that
temperature, it will be deleted.

Internally, the triggers can be stored in a sorted list (with some
optimizations, so it need not be walked every time the zone
temperature changes) or a tree, independent of the trips table (if
any).  Every time the zone temperature changes, the triggers list is
consulted (in addition to the trips table) and if any of them have
been crossed, notifications are sent to user space.

If polling is used, this would just work, but without polling the
driver needs to support setting a pair (at least) of temperature
levels causing an interrupt to occur.  If a specific callback, say
.set_triggers(), is provided by the driver, it can be used for setting
those temperature levels to the triggers right above and right below
the current zone temperature, in analogy with .set_trips().

Does this reflect what you are after?


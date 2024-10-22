Return-Path: <linux-pm+bounces-16206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880919A9F64
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 11:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D051C22752
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 09:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F70199236;
	Tue, 22 Oct 2024 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t05E/pal"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85CE155330;
	Tue, 22 Oct 2024 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729591061; cv=none; b=hNppv7vl2Bift/AEAOZMVbNv+T84SNnGZ6/eZ3qA9oYv9qiNw0prPaxmX3eYpCAI2tm8vZJNlsfpqImwX1gPRNu6c6Lyk8xWodzZpxIkt35olSBZkqExQIQFBMVOYXUTO40vciZ7L+5WzYv8aOQSJIQJtoe4acwnZTLWmucjMKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729591061; c=relaxed/simple;
	bh=9iHOySmjVoCgtF7pUd0KF7YfYo8M3XdvolwYYOb/Kjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auu5m3udEFqqKwH4x6pl05r3Ep0myAEsUO4QWuGO46zVpMstVzoYCWBwwYr9YpCcfjLafOp2ZtPyCzqU6XuaOG9vNNo6sqNr5gPaNqj0UPiQpvQqkGYAOGmNYmx3qwpFhjrO3lLyVLdfOvoM4zr5PylU1ZzWG8OlDbqwuOA6eBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t05E/pal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3878CC4AF09;
	Tue, 22 Oct 2024 09:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729591061;
	bh=9iHOySmjVoCgtF7pUd0KF7YfYo8M3XdvolwYYOb/Kjc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=t05E/palXMQuTPb152S3tBI93dvDjv3dZGoS1dmEMGCeQPJmvaPVAL5s5JOFshpV7
	 98iVo+S9YfLbKCcRMdrBRYpb189Wk4DIsFTMgKicv7+RInkH7vA4sz2XHkZeDYa55S
	 g8MNZXUhdsHyZbD1GsFvcBefQNN4b/GPFdrVw5NWvWfV31gyq4pi7OLE3wAaOcaxS4
	 1YfngsbHAscQMbBBtND4uUwF+IvUxaQdmSlC/O7Y8hyH6nPrMB0mcGt2zBgK4q0+9d
	 pb8NhV6bOAzA0JASal7eG5UUZqHW/HJs1uAwKU0ipzEEyZPPN+1QCxC2S5RPv2+lhZ
	 +tURN80nca/lw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-288916b7fceso2719513fac.3;
        Tue, 22 Oct 2024 02:57:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUviftUzBBBfL99q8jBBHihv4ptix3wr0dggy5z508WN+FkxRTeIUCWla5pFTbF1oY4TrwELJxHNmY=@vger.kernel.org, AJvYcCVNq7HN/Sipwu452h1fisudqqrCY8Nj7AXl9SFaZonXTv6CtfbAaAHgy/JRID3DwvVrePJSQpGDxeiF6zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbDacVVdxGDfW3qCh/xyZSq8ep5ft9aJoJmG1w9IM9f6fRgxnI
	Vz+4ugD7dzQn2EUEW+zNqLEPzhSbjJ+vQ8CYksHuSWuosIrYlZKgDMVAXWexTQbqn2sd4zJW+DI
	Shz5hERcyEjO0msNZeQUwA7uGzbk=
X-Google-Smtp-Source: AGHT+IHvV+j27y9+L0jRmmAJNlhqwK7uOGyntN7p15mscBlWcvIXN/HYcbxk+J67uOy6xJLa1Yb7gdkcNnMP9OSNQXU=
X-Received: by 2002:a05:6870:469f:b0:287:e3e1:15f2 with SMTP id
 586e51a60fabf-28caff9a008mr1971594fac.25.1729591060584; Tue, 22 Oct 2024
 02:57:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4985597.31r3eYUQgx@rjwysocki.net> <CAJZ5v0iV4-3-sqmK12ZoRQXzUSgO0NDySe5LZ3z7FMQOFJCymQ@mail.gmail.com>
 <CAJZ5v0hHFp+FROxs_NbyjA8_ODKmiirFrdJNhGiHYvDMjZ2h3A@mail.gmail.com> <81c752c1-6f51-4aae-ac25-98214c9b9da0@arm.com>
In-Reply-To: <81c752c1-6f51-4aae-ac25-98214c9b9da0@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 22 Oct 2024 11:57:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iy3Z_WV1k7KBwuy1RrdgXpqK2fu2J2wG6PWpLxz293zA@mail.gmail.com>
Message-ID: <CAJZ5v0iy3Z_WV1k7KBwuy1RrdgXpqK2fu2J2wG6PWpLxz293zA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] thermal: core: Reimplement locking through guards
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Tue, Oct 22, 2024 at 12:02=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
> Hi Rafael,
>
> On 10/21/24 12:08, Rafael J. Wysocki wrote:
> > On Fri, Oct 11, 2024 at 8:51=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> >>
> >> On Fri, Oct 11, 2024 at 12:22=E2=80=AFAM Rafael J. Wysocki <rjw@rjwyso=
cki.net> wrote:
> >>>
> >>> Hi Everyone,
> >>>
> >>> This is a continuation of
> >>>
> >>> https://lore.kernel.org/linux-pm/2215082.irdbgypaU6@rjwysocki.net/
> >>>
> >>> and (quite obviously) it is based on that series.
> >>>
> >>> The majority of the patches in it are new iterations of patches inclu=
ded in
> >>>
> >>> https://lore.kernel.org/linux-pm/6100907.lOV4Wx5bFT@rjwysocki.net/
> >>>
> >>> and there is one new patch ([02/11]).
> >>>
> >>> All of these patches are related to locking, but some of them are pre=
paratory.
> >>>
> >>> The series as a whole introduces guards for thermal zones and cooling=
 devices
> >>> and uses them to re-implement locking in the thermal core.  It also u=
ses mutex
> >>> guards for thermal_list_lock and thermal_governor_lock locking.
> >>>
> >>> As usual, the details are described by the individual patch changelog=
s.
> >>
> >> This material is now present in the thermal-core-experimental branch
> >> in linux-pm.git.
> >
> > I gather that it is not controversial as it was covered in the PM+TC
> > session at the LPC and it has been around for quite a while, so I've
> > just queued it up for 6.13.
>
> If it's not too late, I will do the review tomorrow.

No, it isn't, please do!


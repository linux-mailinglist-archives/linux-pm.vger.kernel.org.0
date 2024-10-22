Return-Path: <linux-pm+bounces-16230-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2389AB217
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 17:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69BF2284D2C
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 15:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94E51A3049;
	Tue, 22 Oct 2024 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIO1QMed"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1229139CE2;
	Tue, 22 Oct 2024 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610990; cv=none; b=uKHtdY3DS1w7e82vF+daKpvK8dNQdz4PiXTwN8UJvXb//9MlN3xOUmY9NbmkX4zQX+rD13a3NxE9GCcK7k5r8d0Gv0ZhHF8N97dSna+AlaFx0DG8uYAG68eG9avAXfY16KodG7AxpKwgbxSg0mD9hAdGUfT/4vJLjTsT/nBB+Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610990; c=relaxed/simple;
	bh=x9OOsIzW0hpu7fOsDieYHPUfkaGjIdsaKK3N1PuxVj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFhCwstoNS39sk5OPbiU9jTFA3B+n5XsOrrFUDC5XIoN+xWwwjAKwbfqRIhIGlbK5HxjNMI3kNXrAD5SpXKDmUzYiKpUYe7eX8cneOgPddotQR3ZQBTi/04qclmtIBAjmqDtVedOyIJQ2YjItWX1TbRp8cOtQqYC+N1ChyiZxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIO1QMed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFA1C4CEC7;
	Tue, 22 Oct 2024 15:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729610990;
	bh=x9OOsIzW0hpu7fOsDieYHPUfkaGjIdsaKK3N1PuxVj0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SIO1QMedx6L437x71LCUIy4sgpPRjCuyRrEdUVrIaISVtR7L5cMSH+80I6FioGB3z
	 wfgZNwNfRTkQxqIzOSPG8CYpcOXhz70qJTGEaKkQ38bVfBT0snX1ACO+84NHU2MLG7
	 XV2yHb7yRI5YpG6UKIBy2oavbKw5cIvi4+DmXqsunYzU6xP6Mzt+1jQD2NHuSif7Hu
	 4DfE98GMfgpy2dsjtg57nDKBvbuubuuWQC6/JsvJzk9Rjjk4s5oCy5mNcxi1Yap1I9
	 97rulWcxq64DzXGvVs3N7BElVu36UEF4MYq79wClaZVDrNLsqpdSGkAqa5I443FH29
	 tG9oBUG01U/TA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-28896d9d9deso2409251fac.2;
        Tue, 22 Oct 2024 08:29:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVpO2G7Kwtd87GMBeMwzd2xa2QxzGnDGxe7DNqtNcl50XgzxzSeEFQjb92nQTJws27ZhDX48l7G0g7zbn8=@vger.kernel.org, AJvYcCWaN16zOp/La0H+FaAUU8f2orR72zj6dZd165Yzk7/jD+UTi15Ikmme/146f/Br0BsgID+O9aC8wnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YypZmj1+vLmV1LEiGHp1RexvbBBWe40S9XBYSbhJ23BiygraIWi
	V6CAP/GR1ivRcWoUkKme1Sco0T5q1xK2jSsuUxGH/sWLsQ170ybiT1saKsllhcVJpsaoMP0k4t2
	DXJIKqYFyc6IiBgoe/aJpQgJZnl4=
X-Google-Smtp-Source: AGHT+IEBceEB3WAbPmy2tG9IzzXIv5KkBLk3/LrGpnZ9GPjc5Nqh7wPXOD7bmaDOTmeYYzuaiIkN8mv7RIofiLYXvv8=
X-Received: by 2002:a05:6870:f612:b0:278:222c:98c4 with SMTP id
 586e51a60fabf-28caae7641fmr4210011fac.21.1729610989589; Tue, 22 Oct 2024
 08:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4985597.31r3eYUQgx@rjwysocki.net> <CAJZ5v0iV4-3-sqmK12ZoRQXzUSgO0NDySe5LZ3z7FMQOFJCymQ@mail.gmail.com>
 <CAJZ5v0hHFp+FROxs_NbyjA8_ODKmiirFrdJNhGiHYvDMjZ2h3A@mail.gmail.com>
 <81c752c1-6f51-4aae-ac25-98214c9b9da0@arm.com> <CAJZ5v0iy3Z_WV1k7KBwuy1RrdgXpqK2fu2J2wG6PWpLxz293zA@mail.gmail.com>
 <8f7fdfe6-f29c-46e0-ae85-c2f794ee268d@arm.com>
In-Reply-To: <8f7fdfe6-f29c-46e0-ae85-c2f794ee268d@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 22 Oct 2024 17:29:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jzpWuH=3aj26VHJ_9VkuPAobVM6r-8XFTsAmfysfrKag@mail.gmail.com>
Message-ID: <CAJZ5v0jzpWuH=3aj26VHJ_9VkuPAobVM6r-8XFTsAmfysfrKag@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] thermal: core: Reimplement locking through guards
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 12:19=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
>
>
> On 10/22/24 10:57, Rafael J. Wysocki wrote:
> > Hi Lukasz,
> >
> > On Tue, Oct 22, 2024 at 12:02=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.c=
om> wrote:
> >>
> >> Hi Rafael,
> >>
> >> On 10/21/24 12:08, Rafael J. Wysocki wrote:
> >>> On Fri, Oct 11, 2024 at 8:51=E2=80=AFPM Rafael J. Wysocki <rafael@ker=
nel.org> wrote:
> >>>>
> >>>> On Fri, Oct 11, 2024 at 12:22=E2=80=AFAM Rafael J. Wysocki <rjw@rjwy=
socki.net> wrote:
> >>>>>
> >>>>> Hi Everyone,
> >>>>>
> >>>>> This is a continuation of
> >>>>>
> >>>>> https://lore.kernel.org/linux-pm/2215082.irdbgypaU6@rjwysocki.net/
> >>>>>
> >>>>> and (quite obviously) it is based on that series.
> >>>>>
> >>>>> The majority of the patches in it are new iterations of patches inc=
luded in
> >>>>>
> >>>>> https://lore.kernel.org/linux-pm/6100907.lOV4Wx5bFT@rjwysocki.net/
> >>>>>
> >>>>> and there is one new patch ([02/11]).
> >>>>>
> >>>>> All of these patches are related to locking, but some of them are p=
reparatory.
> >>>>>
> >>>>> The series as a whole introduces guards for thermal zones and cooli=
ng devices
> >>>>> and uses them to re-implement locking in the thermal core.  It also=
 uses mutex
> >>>>> guards for thermal_list_lock and thermal_governor_lock locking.
> >>>>>
> >>>>> As usual, the details are described by the individual patch changel=
ogs.
> >>>>
> >>>> This material is now present in the thermal-core-experimental branch
> >>>> in linux-pm.git.
> >>>
> >>> I gather that it is not controversial as it was covered in the PM+TC
> >>> session at the LPC and it has been around for quite a while, so I've
> >>> just queued it up for 6.13.
> >>
> >> If it's not too late, I will do the review tomorrow.
> >
> > No, it isn't, please do!
>
> OK, I will do that today.

Thank you!


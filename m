Return-Path: <linux-pm+bounces-34065-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EEBB471C8
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 17:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D553A9BF7
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632ED27B4E1;
	Sat,  6 Sep 2025 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmT18Oa1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3822367D5;
	Sat,  6 Sep 2025 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757171708; cv=none; b=pgzsWQQnPSdbP//xa38pGxxC/LluKrxvC0Qf/vpyGroBBmLaSKjG5D3wBK7Ww871oiuVz2Js+Pi6nzPAuvzaGokASUWKw8EoibUP29x7fxcsT3VUgLYflWQYXF+gfC0aGqzuZ7lwLHhiscxhcJnifHrMSz+z2/BOY99xGKS/ANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757171708; c=relaxed/simple;
	bh=V5VmoIRnbNArlBQcQV7ik20GPooqfqzAyxhtR9pDKqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKv7+2t/RRNcTvhQoR464Opmd1/7Orlh2UQN+FOoCHcnn3QGjzRdqGTQu0P63dmddIBN+fZhbsaUQB0Kb5eogvWkkXKqIZKjO0WpHTuGE1Clo+6J2SyJtCQ0F3rJD0/l8MwpHmpwvL7JtjenoRRIwGENMJM5cD2M4Tyi6uIo4b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmT18Oa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8358C4CEF7;
	Sat,  6 Sep 2025 15:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757171707;
	bh=V5VmoIRnbNArlBQcQV7ik20GPooqfqzAyxhtR9pDKqo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SmT18Oa1d2twPn5m2avid3JvaHisblr9DQq8UMpUE7eIs5GkMpgHoEZT+4oLLYVjn
	 QlKkV9rC+0HYInYjRhOd7MsFVBHBNbFHd19S3nZWOn2yybCeQoCBReufz+6xFxYJzJ
	 897GDoUqakWe0gSXjdO/xV+UVdheYvnH01DW74yAe1hw6dGNrEF4JChEDGQbyk6ka9
	 VatHzO6G5OXPKTg5dtw4e3WTI8Uq37Qfqt+SLqu9NfOQ8AzY9Sb7O62+p4ZXl+5gF5
	 eVzu79k6SaKmQiLM8MkWtseWBkLCvTekIDxzcdeKU5+6ldjdbo4FHoYQbn45tG/ylg
	 qWvquajl+Imnw==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-746dae5ff93so1917744a34.0;
        Sat, 06 Sep 2025 08:15:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVpcw/jsIREpvasFCWC0ouC+C+RUkIHodVaV5EChn+TlVC8j61KeOs9Juhm1XcH7UJKwJ8n5K7dbSM=@vger.kernel.org, AJvYcCWaG3pMLgHxeiSzV1cqWMw0mRl1/qJ7LSinYgf5xmJuWA6KkJ0Y5ravSO6tCVrnhNrme7yP8cFBB+f4iHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi++906ifU518DExGvBh7ft8QFpfDEIT5IKRkK87KNTYCp4jHK
	jd/ykXzOlhIZ/OAN2pmEumpFUgeTZgcoQsCjGUi5G66QzSxSnR2CXxvprQFVN+NjWsNpQcapo1C
	Zx8kKFZmFR1PWFiYMaix0gq9qLp156ac=
X-Google-Smtp-Source: AGHT+IGdyYZhwu8BpYyLbNc4bt5eZeyZy46pY08sYjpDYaOcudSjwedT7KRLhXVNTCPfylS0X1oxQfyXuYFi2XZS3hk=
X-Received: by 2002:a05:6830:2906:b0:73f:f3a2:212b with SMTP id
 46e09a7af769-74c6ffce840mr904633a34.5.1757171707091; Sat, 06 Sep 2025
 08:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12749467.O9o76ZdvQC@rafael.j.wysocki> <2025082851-progress-unsliced-ade4@gregkh>
 <CAJZ5v0hn9NXvHPy6zV4R4y0AHtN2BfN41wjd5s7dos0wx6ih0Q@mail.gmail.com>
 <CAJZ5v0gj33W-2FOswYoBLQQyTj0wr_EuMUdLiL_tdt4t=ss-jg@mail.gmail.com>
 <CAJZ5v0ifvwbPs1VKBMpWdanBKUdHSZuNandbF9=uhec56DynNw@mail.gmail.com>
 <2025090658-cucumber-velvet-ae53@gregkh> <2025090638-arson-scrawny-ceb5@gregkh>
In-Reply-To: <2025090638-arson-scrawny-ceb5@gregkh>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 6 Sep 2025 17:14:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jvo4U0zGPZj0bu62qSCJh248JsmiO0E3ie3VPzFJ9FTg@mail.gmail.com>
X-Gm-Features: Ac12FXxrDU4kO3Id7Z6wGxJfeP_mVHH3Vx9ccNz4Byyul4wr7qgfvfg5attRSfE
Message-ID: <CAJZ5v0jvo4U0zGPZj0bu62qSCJh248JsmiO0E3ie3VPzFJ9FTg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] driver core/PM: Two updates related to power.no_pm
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 1:54=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Sep 06, 2025 at 01:53:11PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Sep 03, 2025 at 01:33:18PM +0200, Rafael J. Wysocki wrote:
> > > On Fri, Aug 29, 2025 at 9:09=E2=80=AFPM Rafael J. Wysocki <rafael@ker=
nel.org> wrote:
> > > >
> > > > On Thu, Aug 28, 2025 at 1:20=E2=80=AFPM Rafael J. Wysocki <rafael@k=
ernel.org> wrote:
> > > > >
> > > > > On Thu, Aug 28, 2025 at 1:07=E2=80=AFPM Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Thu, Aug 28, 2025 at 12:55:50PM +0200, Rafael J. Wysocki wro=
te:
> > > > > > > Hi All,
> > > > > > >
> > > > > > > Applying this series will cause power.no_pm to be set for fau=
x devices (so they
> > > > > > > don't get processed unnecessarily during system-wide suspend/=
resume transitions)
> > > > > > > and power.no_callbacks to be set along with power.no_pm (for =
consistency).
> > > > > >
> > > > > > Oh, nice!  I forgot about that entirely.  Should these be backp=
orted to
> > > > > > older kernels as well?
> > > >
> > > > So do you want me to resend these patches with suitable Cc: stable =
tags?
> > > >
> > > > Alternatively, I can just apply them with the tags and route them
> > > > through my tree, whatever you prefer.
> > >
> > > In the absence of more feedback, this is what I'm going to do.
> >
> > Thanks, sorry for the delay, been swamped with conferences and travel :=
(

No worries.

> Wait, I can take them right now, no need to resend them.

Cool, thanks!


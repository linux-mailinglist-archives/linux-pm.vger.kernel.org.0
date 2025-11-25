Return-Path: <linux-pm+bounces-38600-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62427C856C3
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 15:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0D1C23504E6
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 14:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6772441B8;
	Tue, 25 Nov 2025 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbaVpIIH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271E421C167
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081022; cv=none; b=KOuAXRAK6bWgDfnWvPYfII/sufncA62kewUC1moYgaWNbuzTz3afCiQisYgtr3uKdQiQNBR+QsI132Qpzdbcq2IyeB9nMASGXR3rr+SyRprKyU1yZnhkCqLYRthuYXBa6RKmJtst6MUZD82tlbop1BT3iFtvGasjHzjh71NixwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081022; c=relaxed/simple;
	bh=VLuSqotQrlOf3SHj4TqQvSWcGoIJ8RiTpJ03c5baWPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvjX9oY5MWndLnDeIlxmuwf2F+JZZEXRi1kdjLDBrZBwZOorVnQhXBPRvFdfFCtf8MuQS0fPRieYLLvYjju8Fnj6v3VFcyD02nCBNVwd5ZwgHcp9HZvuO1Q4HsiEy1egokdJYGKo3WK8MzcQ+xuUQkGdZ3pY0bM93t1ZIwK4Jck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbaVpIIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66AAC4AF09
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 14:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764081020;
	bh=VLuSqotQrlOf3SHj4TqQvSWcGoIJ8RiTpJ03c5baWPM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZbaVpIIHNkAjJmwXOJIOfOguxXmrrlfEN9clt15RCzJwF7mnenUXVVOcVdJTMWd8b
	 +j2EaEtSPgLHTUVhyadcrk58RIb0M3sDfVNfas9KObaVat2fR9BIUYg+bqdiybp+AQ
	 ++JBRHpIOs5kv4/XBRaeBF79vwi/IzcK4K2Xo8YE9CpaZNcM4tx/KC6Ly3scbAYPqX
	 eDJ26efMrcapHC7qBWCfX3nY4yZ71RTg9mGgp+3w/3O9xgYNCm7fzbUPhtFMChYOLT
	 uofibSv5kjIngjPareTJPmAolpybos5bljDCzmah6sGJVq602wWejjb0k9BdGjTLPP
	 QjgglOqEq71DQ==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6571763793bso2269912eaf.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 06:30:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW6GDXrpQo6FRDesgENrLG2D065q9ZmQyI4EEqrmKmfPBIr4MscXoghbx2b2IoMDsizlm1wQOGQKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYsSVxTbCAeG/Zuuc170dhu93Vdfr37Sp3xwjfsLYRV7kTspjZ
	AbZcMVljCbwvfSBUcxyeTsbOYAEwOvnmrAH0fRItsWIJnsVo3waCN9BzEqlcvE1034JtYKzaCKZ
	7N3c+O+Up1GuLPI5zEJaTKGeiv86e88c=
X-Google-Smtp-Source: AGHT+IGrLrSdQCBbRW8Y6tLPmP5EB+qvhMUQhPXqW+3lItWW2B4QzEXcWzTQrIT8mG040RLk6R6SjjUe5+h7xZ6RbiQ=
X-Received: by 2002:a05:6820:1507:b0:657:5629:2cef with SMTP id
 006d021491bc7-657bddc0372mr1026268eaf.4.1764081019947; Tue, 25 Nov 2025
 06:30:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125105453.471445-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0gfcwg1+o5-H5tQVd=xM=D1Gufyzdk-WeD4Vmyz_pstCw@mail.gmail.com> <LV3PR11MB87686D49A69727A16D913D60F5D1A@LV3PR11MB8768.namprd11.prod.outlook.com>
In-Reply-To: <LV3PR11MB87686D49A69727A16D913D60F5D1A@LV3PR11MB8768.namprd11.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 25 Nov 2025 15:30:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jKJYaK5cg2UeaoriVRmFdb4i=S_v=GdH9z07y+5xJWFw@mail.gmail.com>
X-Gm-Features: AWmQ_bn1s4V6ULqVRQJEkDaqElqwrtgJWarnyz51uY97y7AmIGXFgBbMifXC0MA
Message-ID: <CAJZ5v0jKJYaK5cg2UeaoriVRmFdb4i=S_v=GdH9z07y+5xJWFw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Fix tunables_hook cleanup on init failure
To: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, 
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, 
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "bsegall@google.com" <bsegall@google.com>, 
	"mgorman@suse.de" <mgorman@suse.de>, "vschneid@redhat.com" <vschneid@redhat.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 2:05=E2=80=AFPM Kumar, Kaushlendra
<kaushlendra.kumar@intel.com> wrote:
>
> Hi Rafael,
>
> On 11/25/25 XX:XX, Rafael J. Wysocki wrote:
> > On Tue, Nov 25, 2025 at 11:57 AM Kaushlendra Kumar
> > <kaushlendra.kumar@intel.com> wrote:
> >>
> >> If sugov_init() fails after registering the tunables_hook to the
> >> global list, the hook is not removed before freeing the tunables
> >> structure via kobject_put(). This leaves a dangling list entry
> >> pointing to freed memory.
> >
> > Except that sugov_init() cannot fail after calling gov_attr_set_get(),
> > so how can it get to the error path with tunables_hook in the list in
> > the first place?
>
> >
> >> Remove the hook from the list in the error path to prevent this.
> >
> > There is no bug to fix here AFAICS.
>
> In function sugov_tunables_alloc() tunables_hook is getting added.
> tunables =3D sugov_tunables_alloc(sg_policy);

Yes, which adds tunables_hook in sg_policy to attr_set in tunables.
Both tunables and sg_policy are freed in the error path in question.

Where's the bug being fixed then?


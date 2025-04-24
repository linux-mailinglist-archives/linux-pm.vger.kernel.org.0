Return-Path: <linux-pm+bounces-26119-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04222A9ABAE
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 13:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B600C3B587E
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 11:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACAB225776;
	Thu, 24 Apr 2025 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWFzyxe5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118D72701B1;
	Thu, 24 Apr 2025 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745493983; cv=none; b=riJCu5ywZwmnGyDgjrD3GWxRBXK/O9fyCsUAnOdMEjGcHRQChGud7iNZ5qBsNod1vUmxnZ8Bm8DUx1jHht8Fe+II3399xG4NdQUr5r1v5wIrjME7Y982nHpQW8zQne2qNoMII6gXbSSkcv7TpCWDRj9ohh0wlj8f23gILXeleJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745493983; c=relaxed/simple;
	bh=t1mLYWzl++Dp6co3SY5ATnlJ+E6q5o9OOxJL/Gz01cQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8lqPuJhaOXQf7wTcEhp452n3TegsI8b19HtOule1FjBr20zWqNxbqZc4qiM2jHJP9ChWSOi6WhuJBVl7fpPxkP1KRk+W9n3rLH3EhBfdd/JJKDsJ4jI7426k009a/vEOw2vD2KGVch/eLd3Jg9Efx2sGvPwo8T4yosCnxTnCcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWFzyxe5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CB8C4CEEE;
	Thu, 24 Apr 2025 11:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745493982;
	bh=t1mLYWzl++Dp6co3SY5ATnlJ+E6q5o9OOxJL/Gz01cQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EWFzyxe5j2BoL8qlFkhmdWweuR+SvDtT67Qjx0054eAHyf0CankiHXa2+sQ6AD8V8
	 7fcRlSsU9C1YK27A3E0mp+xxze6IOzS1vdWq+rDaq5lVDGCz5uLWBbcHiAEJ5zMmI3
	 sZQYe6ItNBy5yvjhIZW4ZTQqheVgjDUWHRvseUKg904qJEdnNUuzOVjwuyA8rWK4Gd
	 NZHUnMdsvZck9jhQeJgbUFBKuqT1xxy3v82RxY32iWm64zg3Xi51SdxWbojISAxi9j
	 KFlbskOPhyXwelQwIF6aepco8XvclbM+1xhWGQL82slnX2bIIU6BDGYEjpSKRCT16v
	 NIDchPd7EIhgA==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-72bceb93f2fso1168736a34.0;
        Thu, 24 Apr 2025 04:26:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVI1NN/rWMS6NUvFMNyjiFkPaTk+O4vSq+z2dOXGS8GswGNtlWA2eOce9sFi1TtTlPSV4cIzaAmGwEFzxI=@vger.kernel.org, AJvYcCVVbKpIVkQDa4ToAlNT8Pk24CRgO7g5dJmOI8hOWLI0FYRKpAjzTuPt/x/+ysmKyKK73kNzASmG2Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4m90s05Gjb4LV0W9EXDLSXyH8TymM864OTD+PBzgiKG5Cp11q
	5GSZ4z3IVloNS0svJPRQut0YGX5ySZFcXhkx32mpn9s14/ehwPYOWfiaS91pEP7E63TLe/+9bnu
	ituOVnywQph4PZgFYsSBNcgq9c8s=
X-Google-Smtp-Source: AGHT+IHc+M0OTAx+GOWmGYuhmkDFbvYnaIudvg2OOLa+0NPepqRu/Y2tib0yj2sxRGw5P3Gjm2cE79Hq0RNtTwLhY9M=
X-Received: by 2002:a05:6870:cd96:b0:2d9:7a9e:99ef with SMTP id
 586e51a60fabf-2d97a9ea48cmr618355fac.1.1745493981792; Thu, 24 Apr 2025
 04:26:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745315548.git.viresh.kumar@linaro.org> <7ce4ffb166beef83cf1bd703a41bf91622011585.1745315548.git.viresh.kumar@linaro.org>
 <CAJZ5v0iCrQeKs=4S-x83Fgf-W4u=2JYLA5VmgKPaLCvYAkNpig@mail.gmail.com> <20250424071503.2uhc4k3jxy7x5mo2@vireshk-i7>
In-Reply-To: <20250424071503.2uhc4k3jxy7x5mo2@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 Apr 2025 13:26:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hLBE0vLvpw6k8E7KxiUGqXbH7wEZwFhEziJNYqfxJbyA@mail.gmail.com>
X-Gm-Features: ATxdqUEwm1MBdN3yTHiwvvP-_C0jH4FqSTGGRVGw3dTSLhnVeRhno7cCEnalCQM
Message-ID: <CAJZ5v0hLBE0vLvpw6k8E7KxiUGqXbH7wEZwFhEziJNYqfxJbyA@mail.gmail.com>
Subject: Re: [PATCH 1/6] cpufreq: acpi: Don't enable boost on policy exit
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lifeng Zheng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Nicholas Chin <nic.c3.14@gmail.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 9:15=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 23-04-25, 16:14, Rafael J. Wysocki wrote:
> > Even after commit 2b16c631832d, the code removed by this patch does a
> > useful thing.  Namely, it clears the boost-disable bit in the MSR so
> > that the offline CPU doesn't prevent online CPUs from getting the
> > boost (in case the boost settings change after it has been taken
> > offline).
>
> I didn't understand this part earlier (and even now). How does a CPU
> with boost-disabled, prevents others from boosting ? I have tried
> looking at git logs, and still don't understand it :(

At the HW level, this is certainly possible.

Say two (or more) cores are driven by the same VR.  Boost typically
(always?) requires a separate OPP with a higher voltage and this
applies to all cores sharing the VR, so if one of them says it doesn't
want that (which is what the bit in the boost-disable MSR effectively
means), they all won't get it.

They arguably should belong to the same cpufreq policy, but this
information is often missing from the ACPI tables, sometimes on
purpose (for instance, the firmware may want to be in charge of the
frequency coordination between the cores).

> Also, IIUC this and the boost-enabling at init() only happens for one
> CPU in a policy, as init() and exit() are only called for the first
> and last CPU of a policy. So if a policy has multiple CPUs, we aren't
> touching boost states of other CPUs at init/exit.

But there may be a policy per CPU.

> And yes, this patch isn't mandatory at all for the
>
> > Moreover, without the $subject patch, the change made by the next one
> > will cause the boost setting in the MSR to get back in sync with
> > policy->boost_enabled during online AFAICS, so why exactly is the
> > $subject patch needed?
>
> Right, this is merely a cleanup patch and isn't really required for
> the next patch to make it work.

So I'd rather not make this change.

Evidently, someone made the effort to put in a comment explaining the
purpose of the code in question, so it looks like they had a reason
for adding it.


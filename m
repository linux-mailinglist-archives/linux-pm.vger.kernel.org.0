Return-Path: <linux-pm+bounces-27077-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA01AB5534
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 14:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92A516F074
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 12:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15CA28CF5F;
	Tue, 13 May 2025 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeeH4mUO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A27725745A;
	Tue, 13 May 2025 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747140728; cv=none; b=poGqos3zph9dRUqN9scrZi53EjNumOyCtXt0H4KyWyvmZZ06vpwc1otJWXN/ogbxqq1SsHHeV1RdMtjHgxxsNoB4gk4CeRnTmUmDeyLckc88pJ2j9DAV9E9LLlM/zN4yWzMpQ2MMsR+1swrS8Up25uyZTyhKf/Oh8M5vgFaTjgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747140728; c=relaxed/simple;
	bh=MaUY3vRS+RfPHnzj7olOTdKpd1Z31CQY6kp8pcFliJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRM0hBlTrggexOvuy1qTlLQiaXA88dE4xQ/QPWXQ8fCTyhC2q9JtF57lmIzVPO0fZIkMtK0i4FLxoVXVEYzGNo38tf9P0BkptKQ1aOv/5aDhWfB2cz7W29uWtSs/OO166DejFYerqlTI4j8vapnc8N2nfR45Kdha2UW5C8W7ICc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeeH4mUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39CEC4CEF1;
	Tue, 13 May 2025 12:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747140728;
	bh=MaUY3vRS+RfPHnzj7olOTdKpd1Z31CQY6kp8pcFliJs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VeeH4mUORI2lEwLhJY62l2S1TB9YD1d1wMpyPslRH3+wkK7dy47Ef0Lenmic2d6Zn
	 iBGfG9GkjjhAfdC2C5Zz9Rhfu0RoPg7aEjE82wWKLBqnBBSceHhGaW4c/7ZZgKoa73
	 RdKJHruGj8HEUP1eMTnUABeaDlfxlOQT7OcX/iefM/67u5eLrjQrnLHtKV34X9hPkB
	 jJSS3CYZt7WVYQgvvdqx5eBCX5XNoEyrBw47xskqnjSHtMGX2sKpnz5f3DELtuoDpf
	 V5Tdsx9oyB49Fd0K5M/RQPxmn9Rgh3IkpntNaVb4zvLP/Wy8dy+Qs6UZzbTEKN991z
	 SH5uUdXjLXbIw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2c2ada8264aso4693060fac.2;
        Tue, 13 May 2025 05:52:07 -0700 (PDT)
X-Gm-Message-State: AOJu0YzI7txZoYuv2Kd39oUGr+NMOFL1O3htNchaX+0XBVsXgYCRK+Ty
	MAbD+lnIISiV2pfCl2UqUfAC8KnRjFKxczQdOx90o8uQxwIA4klLvmEzewms5uO/yjoM82NhRua
	oANxk0+4QbWEuOVBC1rAowl7twW4=
X-Google-Smtp-Source: AGHT+IGYYdGUhzSYNwacciHBfNMGXNDI9cq5mpKXjS2lGp7KMnM6sm7RsEVMgf32N2G6iyLgap6f3+/uk7RKaIt9ufg=
X-Received: by 2002:a05:6870:219b:b0:2ba:11d5:ad64 with SMTP id
 586e51a60fabf-2dba43603e9mr9587134fac.23.1747140727197; Tue, 13 May 2025
 05:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2999205.e9J7NaK4W3@rjwysocki.net>
In-Reply-To: <2999205.e9J7NaK4W3@rjwysocki.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 May 2025 14:51:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jLpKEgAodWx8G0k127vMUe-J1rGkCEreRP7a1dQXT2vA@mail.gmail.com>
X-Gm-Features: AX0GCFuWF3KsflArHF8v3e4Wq0Z-32SforuMJQxYpdwHQbT4FcgxJqP_KciZ5bQ
Message-ID: <CAJZ5v0jLpKEgAodWx8G0k127vMUe-J1rGkCEreRP7a1dQXT2vA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] cpufreq: intel_pstate: Enable EAS on hybrid
 platforms without SMT
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 10:49=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> Hi Everyone,
>
> This is a new (and most likely final) version of
>
> https://lore.kernel.org/linux-pm/3344336.aeNJFYEL58@rjwysocki.net/
>
> The most significant difference between it and the above is that scheduti=
l is
> now required for EAS to be enabled, like on the other platforms using EAS=
,
> which means that intel_pstate needs to operate in the passive mode in ord=
er
> to use it (the most straightforward way to switch it over to the passive =
mode
> is to write "passive" to /sys/devices/system/cpu/intel_pstate/status).
>
> Accordingly, the changes that were needed for EAS to work without schedut=
il are
> not needed any more, so there is one patch less in the series because of =
that
> and patch [5/7] is simpler than its previous version because some changes=
 made
> by it are not necessary any more.
>
> Another patch that has been dropped is
>
> https://lore.kernel.org/linux-pm/1964444.taCxCBeP46@rjwysocki.net/
>
> because it didn't take CPU online into account properly and it is not ess=
ential
> for the current hardware anyway.
>
> There is a new patch, [7/7], which adds CAS/EAS/hybrid support descriptio=
n to
> the intel_pstate admin-guide documentation.
>
> The following paragraph from the original cover letter still applies:
>
> "The underlying observation is that on the platforms targeted by these ch=
anges,
> Lunar Lake at the time of this writing, the "small" CPUs (E-cores), when =
run at
> the same performance level, are always more energy-efficient than the "bi=
g" or
> "performance" CPUs (P-cores).  This means that, regardless of the scale-
> invariant utilization of a task, as long as there is enough spare capacit=
y on
> E-cores, the relative cost of running it there is always lower."
>
> The first 2 patches depend on the current cpufreq material queued up for =
6.16
> in linux-pm.git/linux-next (and in linux-next proper) and are not really
> depended on by the rest of the series, but I've decided to include them i=
nto
> this series because they have been slightly updated since the previous ve=
rsion,
> mostly to take review feedback into account (I'm going to queue them up f=
or
> 6.16 shortly because they don't appear to be objectionable).
>
> The next 2 patches (Energy Model code changes) were reviewed previously, =
but
> they are only needed because of patch [5/7].
>
> Patch [5/7] has not changed much except that some changes made by the pre=
vious
> version have been dropped from it.  Also its changelog has been updated. =
 It
> causes perf domains to be registered per CPU and in addition to the prima=
ry cost
> component, which is related to the CPU type, there is a small component
> proportional to performance whose role is to help balance the load betwee=
n CPUs
> of the same type.
>
> The expected effect is still that the CPUs of the "low-cost" type will be
> preferred so long as there is enough spare capacity on any of them.
>
> Patch [6/7] has been updated to walk all of the cache leaves and look for
> the ones with level equal to 3 because the check used in the previous ver=
sion
> does not always work.
>
> The documentation patch, [7/7], is new.
>
> Please refer to the individual patch changelogs for details.

This series along with the fix at

https://lore.kernel.org/linux-pm/2806514.mvXUDI8C0e@rjwysocki.net/

is now present in the experimental/intel_pstate/eas-final brangh in
linux-pm.git:

https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log=
/?h=3Dexperimental/intel_pstate/eas-final

and it has been added to the bleeding-edge branch for 0-day build testing.

Thanks!


Return-Path: <linux-pm+bounces-16585-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0979B34B3
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 16:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41A128221B
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 15:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0027B1DE2C4;
	Mon, 28 Oct 2024 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpIsP2CD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D011A1DE3A3
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128900; cv=none; b=qGemozGLHPcIzsRPZBWTFFkcsvSmYpNi4MJXCaoLqhPEVZ8uufUrbGwKTyTqP28js67AqOl7JdPhiol3Zxye00CbvZMfT7WofaG017atxu7IvuPRzottugeCy9WtYC6lYkG4MjV5ZGxQPFYqDxNs0zBEhjaXHQ1hs+g8kA1v/pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128900; c=relaxed/simple;
	bh=XWXrbzOffIb0np3p4vbK768nTgGNJA+qEzz59w/09fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPNwmRH31PDjg7OABxSiQlVBjD2bTos8nEj6544YN/fX6q61TzUSn8vwzq0sS9fyYDGJ7N6GAhNGRFaZ68C1TIgwpOllXSwhM0HYf/fSA1Jr8n/l2be78BXs9BXQal8Oe+inQH0raX2V1U9EyC7WmGoCL9iX836MRKAR+hZvJRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpIsP2CD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CEAC4CEC3
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 15:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730128900;
	bh=XWXrbzOffIb0np3p4vbK768nTgGNJA+qEzz59w/09fg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lpIsP2CDCJRdjVdYJCmSbf8AcjrVkumpE2BkbzbTCV5E4JBIBl5cUdMO2ofE4Afb3
	 2xqA7ifZTv8dCHyigujjLfq0qBTDGVHtl3B+husfPTSJ5MD8zDCnI/y0vFJBO09rYb
	 xbdWnOwapquwNB3LoO1ENnleYFkEaoM2qO4Ks27XXy/arlnW8LlW4jPQRYM8KTIzzB
	 3UTUsXBymvtqeM5iXSZ9nI0FhnKZlSS0PxJDXzVuY91zqu5ODtBMQI558S2Q55Yqv/
	 pCVZaI07X6PdUY+x7M0k/MHVBs42SI+5xfbIc9IBWJ3fvDoVnBRVQVs9pRKp1y+uoy
	 +Ud4bzfaOt0pw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-27beb2496f4so1466052fac.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 08:21:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAobViVJoiX9j+kXn/gmUNrWpjLiGIsebiYMYDVzmVV6th2IEDRRu4dok7VrhQdNb3eRv7Qh4huw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/WmNHK/JD+54g+9RxqY5Sup4wn7WYDsVmVDlPUEkgssAwaLl4
	ZzlrMmUQCYxeTr7BCfBqe6bsdu/NQU99oLPA8s/Vhbp76P66h8F0R5tMyrXrgo3gUoEwPj8WnLv
	lt0HTSUzM+Ly+N8Q75uBkLCKJpuo=
X-Google-Smtp-Source: AGHT+IFy7m8oqoI2p+UW27Qt/at/lhgT7ouRn4H3+At1KT1DVIQdB7W5ZAxE4D1XtE5QJqz2PL8g8ACwlSbEuuYkcL0=
X-Received: by 2002:a05:6871:b29:b0:259:88b4:976 with SMTP id
 586e51a60fabf-29051dc9e94mr7160675fac.43.1730128899716; Mon, 28 Oct 2024
 08:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <19b70e8a-7a11-46f6-ab9e-6dfaf315ef95@amd.com> <CAJZ5v0iPGtnimd7_LwwGyoxxSrGQ8pug-JDhc5obWZNByTJN+A@mail.gmail.com>
 <CAJZ5v0hjPVL=vJ=YGNoAKwEej=v27oPg_wvZUQ5KXU+=zD6Q9g@mail.gmail.com> <796cf4f2-6397-4012-8130-0c7c7f136486@amd.com>
In-Reply-To: <796cf4f2-6397-4012-8130-0c7c7f136486@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 28 Oct 2024 16:21:28 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jtFYDQ8YRnQwo+sp19J3754ZDY79mcSiC7k--TSg7vuw@mail.gmail.com>
Message-ID: <CAJZ5v0jtFYDQ8YRnQwo+sp19J3754ZDY79mcSiC7k--TSg7vuw@mail.gmail.com>
Subject: Re: amd-pstate 6.13 content (10/22/24)
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 2:56=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 10/28/2024 06:22, Rafael J. Wysocki wrote:
> > On Wed, Oct 23, 2024 at 3:16=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> >>
> >> Hi,
> >>
> >> On Tue, Oct 22, 2024 at 10:54=E2=80=AFPM Mario Limonciello
> >> <mario.limonciello@amd.com> wrote:
> >>>
> >>> Hello,
> >>>
> >>> The following changes since commit 7f31183fa1d5c043864b4bd5632930f40d=
3c7002:
> >>>
> >>>     Merge branch 'acpi-battery' into linux-next (2024-10-22 22:00:30 =
+0200)
> >>>
> >>> are available in the Git repository at:
> >>>
> >>>
> >>> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.=
git
> >>> tags/amd-pstate-v6.13-2024-10-22
> >>>
> >>> for you to fetch changes up to 7027b415ff1a4184b99055f11455d5c7041aa3=
ee:
> >>>
> >>>     cpufreq/amd-pstate-ut: Add fix for min freq unit test (2024-10-22
> >>> 15:21:42 -0500)
> >>>
> >>> ----------------------------------------------------------------
> >>> Update the amd-pstate driver to set the initial scaling frequency pol=
icy
> >>> lower bound to be lowest non-linear frequency. This will have a sligh=
t
> >>> power consumption impact but should lead to increased efficiency.
> >>>
> >>> Also amd-pstate is enabled by default on servers starting with newer
> >>> AMD Epyc processors.
> >>>
> >>> Add various code cleanups to rename functions and remove redundant ca=
lls.
> >>>
> >>> ----------------------------------------------------------------
> >>> Dhananjay Ugwekar (7):
> >>>         cpufreq/amd-pstate: Rename MSR and shared memory specific fun=
ctions
> >>>         cpufreq/amd-pstate: Remove the redundant verify() function
> >>>         cpufreq/amd-pstate: Set the initial min_freq to lowest_nonlin=
ear_freq
> >>>         cpufreq/amd-pstate: Call amd_pstate_register() in amd_pstate_=
init()
> >>>         cpufreq/amd-pstate: Call amd_pstate_set_driver() in
> >>> amd_pstate_register_driver()
> >>>         cpufreq/amd-pstate: Remove the switch case in amd_pstate_init=
()
> >>>         cpufreq/amd-pstate: Remove the redundant amd_pstate_set_drive=
r() call
> >>>
> >>> Gautham R. Shenoy (1):
> >>>         amd-pstate: Set min_perf to nominal_perf for active mode
> >>> performance gov
> >>>
> >>> Mario Limonciello (5):
> >>>         cpufreq/amd-pstate: Fix non kerneldoc comment
> >>>         cpufreq/amd-pstate: Don't update CPPC request in
> >>> amd_pstate_cpu_boost_update()
> >>>         cpufreq/amd-pstate: Use amd_pstate_update_min_max_limit() for=
 EPP
> >>> limits
> >>>         cpufreq/amd-pstate: Drop needless EPP initialization
> >>>         cpufreq/amd-pstate-ut: Add fix for min freq unit test
> >>>
> >>> Swapnil Sapkal (1):
> >>>         amd-pstate: Switch to amd-pstate by default on some Server pl=
atforms
> >>
> >> Pulled, thanks!
> >
> > And unpulled, because this branch contains my temporary linux-next merg=
es.
> >
> > Please.  If you want my branch to base your material on, let me know
> > and I'll create one for you.  Otherwise, please base your material
> > that you are going to push to me on an -rc from Linus.
> >
> > Thanks!
>
> I had asked if I could base on your linux-next before sending it.

I obviously missed or misunderstood it, sorry.

The rule of thumb is that all merges in my fixes, linux-next, testing
and bleeding-edge branches are temporary and they cannot show up in
the mainline.

So I wouldn't have been able to ask Linus to pull any branch
containing any of these merges.

> Yes; in this case can you please make a base branch instead and I'll
> send out a new one then based on that.

Please use the 'cpufreq' branch:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git cpufreq

that I've just pushed.

Thanks!


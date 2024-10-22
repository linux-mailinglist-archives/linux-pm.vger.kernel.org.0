Return-Path: <linux-pm+bounces-16257-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A249AB761
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 22:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3AB28561F
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 20:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D32F1C9ED2;
	Tue, 22 Oct 2024 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCqtnkZI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A301BDA89
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729627456; cv=none; b=Vlgh6gi3L0y7/mP/BTDiNeQ71zE8vUZg8b9cw4ecT3FNR1Zm56GiZrTn8PGk7wCHKZPVwy473xiI8p6foparFos9RvWOTlE5s1Ijab8PknoCCmiwfS7hZSGtrBBbdvxW2C3o6IshRJ8Gy+YkjcsDGLqthfEQ6nx+uQzSqTjlr48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729627456; c=relaxed/simple;
	bh=AapnWajIgFlKSf+f+I8tmcW/TeEdV4Q7O5GUa+4kbvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCKFX2hSsEhUHmd7pamNtB0yBCCH9DZpqGvVVwbyuzwWlqkx6kFqMMlANXnShsOH6TgV/sEe+MNGSGQs6LOQBXudvR/WzH8aK+VpdhvQs5xkAFIFbypR0Mp62nyWxtgQ4NcJTem44gqcHF/BUFWnGBM7V2Ctngg/ngdaPKKF3LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCqtnkZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E324CC4CECD
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 20:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729627455;
	bh=AapnWajIgFlKSf+f+I8tmcW/TeEdV4Q7O5GUa+4kbvQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lCqtnkZIqO3TYVn2B5G2M8gN56xm/tBOQvYVLXB8fc4c/Ai0esFScffKdLQU/dfLT
	 qVSYyGXXUq/AGePfTbCk2FKYB7Mdi3EU/5xjanq3/EdYLsu+LvJYyWR8NPJ2jNGQ0m
	 MxIAQ9Br8rAAMn60dyZBqAqeHjfH7Tt/V3dCcWQdgupGUwY7U1ighZgi8iPXAEVWbx
	 nzHO7DKxwDn5nfjnpagz/93ojiLRaBeipci+AzSq9/JyKcTbNVTw5CuflJxTCQN0wC
	 o6xjFheKoLpftEduZi64MS9Q4KM8cnYs5k72vDAn4HrqwRye79ekVnUtWLu5QZV+pG
	 kR08l0yB+cLgQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2887abeefbdso3097382fac.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 13:04:15 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx9y/78RKowHWAI+0TGXhnfiwhVnNH7XZ7zpU19inyu8dOTVQVb
	iOLblxMhrMXyRbctA2q1BNxPVka1il85eA3Bgv0SMZ/AmeEtVFTKS6sYP+XuNNNRxjugcOujnOr
	IPNaJ+VDVE2R0xrkHgNVa9gJwr/4=
X-Google-Smtp-Source: AGHT+IG/NK4HIx4jxz1DEFH6hQK2k9tkvJ9ypj1iefTDvyvq2Gq5fk/cBNVlnNbAmw2uoVplXKXYUZ7cJUK0t3geKEE=
X-Received: by 2002:a05:6870:8288:b0:27b:583b:bfa8 with SMTP id
 586e51a60fabf-28ccb410e8bmr448439fac.17.1729627455084; Tue, 22 Oct 2024
 13:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bfd6e381-b3e1-457e-b992-d6d9be5e446d@amd.com> <CAJZ5v0gwO6hLGu1iNu+GKz6_LAMaZdY_8htDhVoFVixUhSO1zg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gwO6hLGu1iNu+GKz6_LAMaZdY_8htDhVoFVixUhSO1zg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 22 Oct 2024 22:04:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j7HpUN-heihZL3HZDMLV0y7XCw2nvkHgFCGZPhhFroAQ@mail.gmail.com>
Message-ID: <CAJZ5v0j7HpUN-heihZL3HZDMLV0y7XCw2nvkHgFCGZPhhFroAQ@mail.gmail.com>
Subject: Re: Preparing next amd-pstate PR
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 5:32=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> Hi Mario,
>
> On Tue, Oct 22, 2024 at 4:14=E2=80=AFPM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > Rafael,
> >
> > As Boris mentioned we need to drop these two commits and go through som=
e
> > more review.  There's an active series under review for it.
> >
> >        CPPC: Use heterogeneous core topology for identifying boost nume=
rator
> >        x86/cpufeatures: Add feature bits for AMD heterogeneous processo=
r
> >
> > In order to prepare the next amd-pstate 6.13 pull request, I wanted to
> > discuss with you the best way to do it.  Those commits came into
> > linux-pm/linux-next with this tag:
> >
> >      * tag 'amd-pstate-v6.13-2024-10-10' of
> > ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux:
> >        cpufreq/amd-pstate: Fix non kerneldoc comment
> >        cpufreq/amd-pstate: Rename MSR and shared memory specific functi=
ons
> >        CPPC: Use heterogeneous core topology for identifying boost nume=
rator
> >        x86/cpufeatures: Add feature bits for AMD heterogeneous processo=
r
> >        cpufreq/amd-pstate: Fix amd_pstate mode switch on shared memory
> > systems
> >
> > Unless there are other conflicts I'm not aware of I was going to sugges=
t
> > that you just drop this entire PR, and then I'll take the other commits
> > that were in that tag besides those two in an updated tag.  I would the=
n
> > do the next one based on content in linux-pm/linux-next instead of 6.12=
-rcX
> >
> > Does that work for you?  If not, can you advise how we should do this?
>
> Yes, it does, no problem.
>
> I'll get to this later today.

Done now.

For the future, I would suggest sending pull requests with stuff that
has been reviewed properly.

Thanks!


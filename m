Return-Path: <linux-pm+bounces-16565-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 724B99B2ED0
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 12:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03362286C10
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 11:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6E11862B8;
	Mon, 28 Oct 2024 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sq03bjdS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B8654765
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730114584; cv=none; b=MhJjzo2rS+/OVnPIRrkR/0EIboK0WZo8GwTKwZ42UnLe6LqGzlvf1Njs/cDsumtuxbW5DxW1wde+CanisbeIPo4V9LAH9iHmzFRkKJJz434tCJR7IMs3pBtocRzKXQGzPV8eM+gJY4agUHe6P4vszpaGkhYaRy/8i1ymBxhCOyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730114584; c=relaxed/simple;
	bh=ZG8BgGjf6+Aqoe4a8IuhfghvYgZCOSBqFyMby2/2J/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDg7YrvXkviPgLEGQuUmfsl3WJ1sMGVNpDF6NnYjX2BfIlvhRfPcbhmrHIUg4PCUGCnoMxnD1RtPWvNXtmxpo3UYkvbaJd4R3tpNIfx5YJP49DSLCMx+b7fXHcJQbhk6MAFlPXXZxsGNxDaQgrTFUYoOcArSlaq40ZuX1valta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sq03bjdS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE23C4CEE7
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 11:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730114584;
	bh=ZG8BgGjf6+Aqoe4a8IuhfghvYgZCOSBqFyMby2/2J/g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sq03bjdSI9Jg6d1oepjxw0Ql39ov8Dp32fgQhra7nYIGNRIQtZQM49MlgS8i9hT32
	 UQP6mSmTLExBnvQNNKan7m/+r2UU+kDtj+GvWSdpFFCVLAlzHizNAwCJQcM3svCdlt
	 qi6dbfE4XiZ8o/F7jruzOz9kEAO1AWJ2uWzB0CQ78EUZ+DbWRnTh30EkTp37uXwiW7
	 vio/Tgn6obya7rnw5UObEEL7xIGF7VwAYWcpKD/26JrAahQayAIZ/Ttw1pMgVbi1/f
	 MF2c7oNbjoeEMuT3bzc4jmGhTpBbfVk1z1Tfem8Zjr7iXjG5Jf2q69Yl9fWRXxpqE4
	 G9sesYuppCfOw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2884a6b897cso2099645fac.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 04:23:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVY/mgelt+8XlyCGHYzFZHUao+YZXag3jVqbfiEr8pTAyam/KjCripwHm2AAz1gq7B8gl5iM5RptQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhPSZBT2M0PiAZ2A1w3+zQHl9PAkq16qPeO4O+L9uMLZovBygM
	aH4MG5SDaKiUyeMJ3mzwKhf4a0qtsl55GkYDi9uZFB1S33+/so9ks+kiH4arfoebj47mQU1akLi
	za2pnWvGTkzGKvW2pSYzIjg3MKGA=
X-Google-Smtp-Source: AGHT+IFaqgYwp5QThR4iYjjD/jUT5v60zkJ2f+kZKrnt3kAWkoEGf37TljTZCXvhUsLiGlccFbZWdlh4b3L5sXohzMo=
X-Received: by 2002:a05:6870:418d:b0:270:50f7:50c1 with SMTP id
 586e51a60fabf-29051af0f4amr6115413fac.1.1730114583472; Mon, 28 Oct 2024
 04:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <19b70e8a-7a11-46f6-ab9e-6dfaf315ef95@amd.com> <CAJZ5v0iPGtnimd7_LwwGyoxxSrGQ8pug-JDhc5obWZNByTJN+A@mail.gmail.com>
In-Reply-To: <CAJZ5v0iPGtnimd7_LwwGyoxxSrGQ8pug-JDhc5obWZNByTJN+A@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 28 Oct 2024 12:22:47 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hjPVL=vJ=YGNoAKwEej=v27oPg_wvZUQ5KXU+=zD6Q9g@mail.gmail.com>
Message-ID: <CAJZ5v0hjPVL=vJ=YGNoAKwEej=v27oPg_wvZUQ5KXU+=zD6Q9g@mail.gmail.com>
Subject: Re: amd-pstate 6.13 content (10/22/24)
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 3:16=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> Hi,
>
> On Tue, Oct 22, 2024 at 10:54=E2=80=AFPM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > Hello,
> >
> > The following changes since commit 7f31183fa1d5c043864b4bd5632930f40d3c=
7002:
> >
> >    Merge branch 'acpi-battery' into linux-next (2024-10-22 22:00:30 +02=
00)
> >
> > are available in the Git repository at:
> >
> >
> > ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.gi=
t
> > tags/amd-pstate-v6.13-2024-10-22
> >
> > for you to fetch changes up to 7027b415ff1a4184b99055f11455d5c7041aa3ee=
:
> >
> >    cpufreq/amd-pstate-ut: Add fix for min freq unit test (2024-10-22
> > 15:21:42 -0500)
> >
> > ----------------------------------------------------------------
> > Update the amd-pstate driver to set the initial scaling frequency polic=
y
> > lower bound to be lowest non-linear frequency. This will have a slight
> > power consumption impact but should lead to increased efficiency.
> >
> > Also amd-pstate is enabled by default on servers starting with newer
> > AMD Epyc processors.
> >
> > Add various code cleanups to rename functions and remove redundant call=
s.
> >
> > ----------------------------------------------------------------
> > Dhananjay Ugwekar (7):
> >        cpufreq/amd-pstate: Rename MSR and shared memory specific functi=
ons
> >        cpufreq/amd-pstate: Remove the redundant verify() function
> >        cpufreq/amd-pstate: Set the initial min_freq to lowest_nonlinear=
_freq
> >        cpufreq/amd-pstate: Call amd_pstate_register() in amd_pstate_ini=
t()
> >        cpufreq/amd-pstate: Call amd_pstate_set_driver() in
> > amd_pstate_register_driver()
> >        cpufreq/amd-pstate: Remove the switch case in amd_pstate_init()
> >        cpufreq/amd-pstate: Remove the redundant amd_pstate_set_driver()=
 call
> >
> > Gautham R. Shenoy (1):
> >        amd-pstate: Set min_perf to nominal_perf for active mode
> > performance gov
> >
> > Mario Limonciello (5):
> >        cpufreq/amd-pstate: Fix non kerneldoc comment
> >        cpufreq/amd-pstate: Don't update CPPC request in
> > amd_pstate_cpu_boost_update()
> >        cpufreq/amd-pstate: Use amd_pstate_update_min_max_limit() for EP=
P
> > limits
> >        cpufreq/amd-pstate: Drop needless EPP initialization
> >        cpufreq/amd-pstate-ut: Add fix for min freq unit test
> >
> > Swapnil Sapkal (1):
> >        amd-pstate: Switch to amd-pstate by default on some Server platf=
orms
>
> Pulled, thanks!

And unpulled, because this branch contains my temporary linux-next merges.

Please.  If you want my branch to base your material on, let me know
and I'll create one for you.  Otherwise, please base your material
that you are going to push to me on an -rc from Linus.

Thanks!


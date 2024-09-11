Return-Path: <linux-pm+bounces-14033-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55641975665
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 17:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 045FF284F71
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 15:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F1B19C552;
	Wed, 11 Sep 2024 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gg0R3EWy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8832AE90
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067216; cv=none; b=DrfQEv5/kukaCwrpO789C5E3TJiX7D77gwwjsSTRNca55AmPdcZEH3Y8mOMG0KiNWZlTvHYoMUpgwRrwT9kbCaQojUwVDEviHE8oKE3QxBN3BobBxrKsJUV6drJu3Dv/aFRYRDhN/mMS972SU6J4vVsov4SvJmWSFidQJJFXbYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067216; c=relaxed/simple;
	bh=MHOahEhV5IkdarQ1obFsdA1HdirAcyWhfisRLJN/e2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogkW4fT+HwhGxB3cAbRoZGw7tt4yS2oNKMGJjsAB+HY7/gjxwcv5X9jQMMpjeOqSMqLqfv8UAXRlIhZ4+mvOUClr4DeX2I8tZ1mVg8zcNPzQFypsEi5LAMoSmA5yT1PKFdA5H4+G6G5mDKGq+BmNZI6txwvnhLdisY4LmpfrquE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gg0R3EWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637CDC4CEC7
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 15:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726067216;
	bh=MHOahEhV5IkdarQ1obFsdA1HdirAcyWhfisRLJN/e2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gg0R3EWy3a4uoLDAFcvhhYuuxpaubQY7760nDr/JAr8SblTAkJPvViGELDTIveNOr
	 jgyS8r6h1Ygel+ufbaimEnFaAbvutKVY8ooZLtatY4TDRFU+dQt0NOFbokLyPv2GZw
	 lHceIJ7ONS3SqvHBgwPYjqp8C47WGzCaJosbGpbNLjfMOhAIGYX8vu4gl2qY92GPdl
	 mGAgA6fNQojoErcMq93uw/zF0jGYZecbBVVo/edj8715UacdOVOL+hHWyPm5mHrDqk
	 DYmZQd7MljT47HJIqlEgA7NZgCrRhBkUlPp8AB7tCzdXr/DsD3N1SRPa34nRcYtrA/
	 HEPIYJrFNvO+g==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5da6865312eso4076400eaf.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 08:06:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5put4SeWatI/BSJkypU0isl2pY1x6jOQ+L50vEEMOdTnAQgCjq6NknZLOUktrFnb+pnL3oMh2gA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwC7IlrB4E36Vp5HCVj/8vYCW9FCC1oTuANREsAw/c6iTzJ75TN
	TKwrt/7cwEBgv5jUnv3ZH/F5hTqAZo3z1YkMf7WXJagZ1p6RuAOLlioOAoeVonSBHmQYrn7ZNT8
	T03gzNrVFkIYhbFMf0dnsNQFjjfU=
X-Google-Smtp-Source: AGHT+IG1b7zxdjzHRlXwtCkB3UL3qllRuWNfG0Ko769YFP5gAvPq8hvK29b4DZJsd24P2AXHV3zNcB3dtxFXrpqkyRk=
X-Received: by 2002:a05:6870:8181:b0:27b:686a:43b8 with SMTP id
 586e51a60fabf-27b82ff50b9mr12031132fac.47.1726067215666; Wed, 11 Sep 2024
 08:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <da6db097-d4a7-425f-8e61-084a2fe15770@amd.com> <CAJZ5v0gzUbiaT5_74NSPv9bbBO4GfCoEfx-M0JHHMqYkn5N+8w@mail.gmail.com>
 <CAJZ5v0jG57Oq_rdoGzXABdxHGvQ9yqeG1f-850LmtmFy+3MFKg@mail.gmail.com> <749561d6-51b1-4136-8baf-c7a10fdffd5d@amd.com>
In-Reply-To: <749561d6-51b1-4136-8baf-c7a10fdffd5d@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Sep 2024 17:06:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gq2jOAYZtqG1nya=To2H1pdTm6DV0_-yj+QA7L-jUKSw@mail.gmail.com>
Message-ID: <CAJZ5v0gq2jOAYZtqG1nya=To2H1pdTm6DV0_-yj+QA7L-jUKSw@mail.gmail.com>
Subject: Re: Second round of amd-pstate 6.12 content
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 4:48=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 9/11/2024 09:43, Rafael J. Wysocki wrote:
> > On Mon, Sep 9, 2024 at 6:38=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >>
> >> Hi Mario,
> >>
> >> On Mon, Sep 9, 2024 at 5:52=E2=80=AFPM Mario Limonciello
> >> <mario.limonciello@amd.com> wrote:
> >>>
> >>> Hi,
> >>>
> >>> The following changes since commit 8cc214312cf8a0c3702edd1aa52e507262=
adccb9:
> >>>
> >>>     Merge branch 'pm-opp' into linux-next (2024-09-06 20:53:58 +0200)
> >>>
> >>> are available in the Git repository at:
> >>>
> >>>
> >>> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.=
git
> >>> tags/amd-pstate-v6.12-2024-09-09
> >>>
> >>> for you to fetch changes up to e121c01c0422fc56033d0dfa1bf3f0366115d2=
d5:
> >>>
> >>>     cpufreq/amd-pstate-ut: Add test case for mode switches (2024-09-0=
9
> >>> 10:26:26 -0500)
> >>>
> >>> ----------------------------------------------------------------
> >>> second round of amd-pstate changes for 6.12:
> >>>
> >>> * Move the calculation of the AMD boost numerator outside of
> >>>     amd-pstate, correcting acpi-cpufreq on systems with preferred cor=
es
> >>> * Harden preferred core detection to avoid potential false positives
> >>> * Add extra unit test coverage for mode state machine
> >>>
> >>> ----------------------------------------------------------------
> >>> Mario Limonciello (13):
> >>>         x86/amd: Move amd_get_highest_perf() from amd.c to cppc.c
> >>>         ACPI: CPPC: Adjust return code for inline functions in
> >>> !CONFIG_ACPI_CPPC_LIB
> >>>         x86/amd: Rename amd_get_highest_perf() to
> >>> amd_get_boost_ratio_numerator()
> >>>         ACPI: CPPC: Drop check for non zero perf ratio
> >>>         ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio()=
 to warn
> >>>         x86/amd: Move amd_get_highest_perf() out of amd-pstate
> >>>         x86/amd: Detect preferred cores in amd_get_boost_ratio_numera=
tor()
> >>>         cpufreq: amd-pstate: Merge amd_pstate_highest_perf_set() into
> >>> amd_get_boost_ratio_numerator()
> >>>         cpufreq: amd-pstate: Optimize amd_pstate_update_limits()
> >>>         cpufreq: amd-pstate: Add documentation for `amd_pstate_hw_pre=
fcore`
> >>>         amd-pstate: Add missing documentation for
> >>> `amd_pstate_prefcore_ranking`
> >>>         cpufreq/amd-pstate: Export symbols for changing modes
> >>>         cpufreq/amd-pstate-ut: Add test case for mode switches
> >>>
> >>>    Documentation/admin-guide/pm/amd-pstate.rst |  15 ++++++++++++++-
> >>>    arch/x86/include/asm/processor.h            |   3 ---
> >>>    arch/x86/kernel/acpi/cppc.c                 | 172
> >>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++-----------
> >>>    arch/x86/kernel/cpu/amd.c                   |  16 ----------------
> >>>    drivers/cpufreq/acpi-cpufreq.c              |  12 +++++++++---
> >>>    drivers/cpufreq/amd-pstate-ut.c             |  41
> >>> ++++++++++++++++++++++++++++++++++++++++-
> >>>    drivers/cpufreq/amd-pstate.c                | 151
> >>> +++++++++++++++++++++++++++++++++++++++------------------------------=
---------------------------------------------------------------------------=
-------
> >>>    drivers/cpufreq/amd-pstate.h                |  14 ++++++++++++++
> >>>    include/acpi/cppc_acpi.h                    |  41
> >>> ++++++++++++++++++++++++++++-------------
> >>>    9 files changed, 305 insertions(+), 160 deletions(-)
> >>
> >> Pulled and added to the linux-next branch in linux-pm.git, thanks!
> >
> > And unpulled because it was based on the linux-next branch of the day.
> >
> > Basically, please don't do this.
> >
> > Please base your pull requests on top of mainline commits and if there
> > are dependencies out-of-the-mainline dependencies you need to pull in,
> > please ask for immutable branches to pull from.
> >
> > Thanks!
>
> Ah.  That's what I did originally, but there was a conflict specifically
> because this got applied through another tree and I ran into problems
> when I tried to do a test merge before sending out the PR.
>
> commit 5493f9714e4c ("cpufreq: amd-pstate: add check for
> cpufreq_cpu_get's return value")
>
> So I figured it was better to rebase.  In this case can you please make
> me an immutable branch and I'll redo the PR from that?

If I'm not mistaken, you can pull this:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git
tags/cpufreq-arm-updates-6.12

as per

https://lore.kernel.org/linux-pm/20240906054735.cbsjpwvpelgukppq@vireshk-i7=
/

and apply your changes on top of that merge.

Alternatively, I can just cherry pick them from the branch I have
pulled and apply them myself, whichever you prefer.


Return-Path: <linux-pm+bounces-23492-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3BAA5035B
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 16:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782C63AA7DE
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 15:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64892505AC;
	Wed,  5 Mar 2025 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFVQvvJg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A5D20B21D
	for <linux-pm@vger.kernel.org>; Wed,  5 Mar 2025 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188170; cv=none; b=gJb2izyPzQDkMEChpCZk99szKME5avWok741RkCoTvL9tyCC/MXAglPig1Mz/t5XUwaaGNCKidA+68XfLCZ2l5SRnNPZsdmsCZaol6/R/YKMfGycI3Afpo3n4DMsGmJyzFzT6wMaOAROLVmEH2c1VWUnaYiN+5jec/YMgZ7QHsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188170; c=relaxed/simple;
	bh=YjN9p1v5ocwBx0GAux5+cTSmEc8rBnZJ//Vw5/239b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l1DrNRq9z9NzOsxyH0PKOlBcFy3F9IQ3e+lRQoJ9MMd7XL3N2bq40WfX8NiT8QqAKr0qZg7TlfVw4mxSgNudaLAYlQ1D65me34quHh+f9KH+itZ+URNhV7GFUVb6QBsZxfvG0SxrMODqAp8SzIh/eErmcysI4NNT+90CR204t6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFVQvvJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D8FC4CED1
	for <linux-pm@vger.kernel.org>; Wed,  5 Mar 2025 15:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741188170;
	bh=YjN9p1v5ocwBx0GAux5+cTSmEc8rBnZJ//Vw5/239b0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MFVQvvJg9ZHVsN3GqQUucPf4FhzEaQZgaCwAFiKXsUzlQp9RK9vcGSyeWVYB+QtKu
	 Qga3uoM32RK5hYq35RoX4F2Etzfjx8203eixhTEfg2u3Y3nEb/oMhguTcvVdyOQ3oV
	 cXthLi1WCN23DvowibEiVPmNTBmCOcuI9ljgAyt6TJuvw8UxEfaSUGInANwy+ejMgT
	 +h4KjTVDtz3xpSHpKgWk2C8dVO5YAzVAjbOOxScuu6T7SmWLgau0ImtM9ylSRlMdrv
	 iZEAfinEd1/DPRclmdkMxmkt4oy89CEWBPbQYkZsGiXPGKUXhHe7hfGxjDB1PTtxVt
	 +2Qm7OFxzu+2Q==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-72a164cb607so688004a34.0
        for <linux-pm@vger.kernel.org>; Wed, 05 Mar 2025 07:22:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUI0qQBykMyVDM0lOy83/VAi1HfyLAclSQaQaHFpHApKaJpuwPxHe0ntRYATW5uGRabnWwBrPBuDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGLsy14EyWfMQnVIrHoK5aJpg6KUhTacZxZiTwa6rTX6C8l6Sb
	F5ENNKadlH/JZbzJbw6XfiyFaLWnmYkBSjZxCRsXVevdoKtyt2bVbvZ1th4Ibwp55QElLLBmSzU
	yZCDXPEff8ZKwjhqGlyObDXP/yzo=
X-Google-Smtp-Source: AGHT+IEPmWVOsF2lPmtXvZREBZ1y/9XJapkCwBS0hX7yacLivJcYZ7SOMv6ADcfqCFpvbSmQDuG+ETPTL6zeXnaOZn0=
X-Received: by 2002:a05:6830:6b82:b0:72a:10c2:3b55 with SMTP id
 46e09a7af769-72a14e74e3dmr4161182a34.0.1741188169366; Wed, 05 Mar 2025
 07:22:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9b23785c-9aa9-44d2-9bca-0f4fbc9bbc70@amd.com>
In-Reply-To: <9b23785c-9aa9-44d2-9bca-0f4fbc9bbc70@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 5 Mar 2025 16:22:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gJM7zA3Nt==qGVALNP4ZaM6jWqoby2BQS-t_gTsni9Bw@mail.gmail.com>
X-Gm-Features: AQ5f1Jr2ygfpvcTyPhd-NvcTJ3ngiCmiBRwQIT-L2lbPHQNi0SYk8fmhPDzh1MY
Message-ID: <CAJZ5v0gJM7zA3Nt==qGVALNP4ZaM6jWqoby2BQS-t_gTsni9Bw@mail.gmail.com>
Subject: Re: [GIT PULL] amd-pstate content for 6.15 (3/3/25)
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 11:10=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The following changes since commit d082ecbc71e9e0bf49883ee4afd435a77a5101=
b6:
>
>    Linux 6.14-rc4 (2025-02-23 12:32:57 -0800)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> amd-pstate-v6.15-2025-03-03
>
>
>
>                                                                  for you
> to fetch changes up to 9e64cfbb06a534089ae4fc9174c01cd91323d505:
>
>    cpufreq/amd-pstate: Drop actions in amd_pstate_epp_cpu_offline()
> (2025-03-01 06:45:50 -0600)
>
> ----------------------------------------------------------------
> amd-pstate content for 6.15 (3/3/25)
>
> A lot of code optimization to avoid cases where call paths will end up
> calling
> the same writes multiple times and needlessly caching variables.  To
> accomplish
> this some of the writes are now made into an atomically written "perf"
> variable.
> Locking has been overhauled to ensure it only applies to the necessary
> functions.
> Tracing has been adjusted to ensure trace events only are used right befo=
re
> writing out to the hardware.
>
>
>
>
> ----------------------------------------------------------------
> Dhananjay Ugwekar (10):
>        cpufreq/amd-pstate: Modify the min_perf calculation in
> adjust_perf callback
>        cpufreq/amd-pstate: Remove the redundant des_perf clamping in
> adjust_perf
>        cpufreq/amd-pstate: Pass min/max_limit_perf as min/max_perf to
> amd_pstate_update
>        cpufreq/amd-pstate: Convert all perf values to u8
>        cpufreq/amd-pstate: Modularize perf<->freq conversion
>        cpufreq/amd-pstate: Remove the unnecessary cpufreq_update_policy c=
all
>        cpufreq/amd-pstate: Add missing NULL ptr check in amd_pstate_updat=
e
>        cpufreq/amd-pstate: Use scope based cleanup for cpufreq_policy ref=
s
>        cpufreq/amd-pstate: Remove the unncecessary driver_lock in
> amd_pstate_update_limits
>        cpufreq/amd-pstate: Fix the clamping of perf values
>
> Mario Limonciello (19):
>        cpufreq/amd-pstate: Invalidate cppc_req_cached during suspend
>        cpufreq/amd-pstate: Show a warning when a CPU fails to setup
>        cpufreq/amd-pstate: Drop min and max cached frequencies
>        cpufreq/amd-pstate: Move perf values into a union
>        cpufreq/amd-pstate: Overhaul locking
>        cpufreq/amd-pstate: Drop `cppc_cap1_cached`
>        cpufreq/amd-pstate-ut: Use _free macro to free put policy
>        cpufreq/amd-pstate-ut: Allow lowest nonlinear and lowest to be
> the same
>        cpufreq/amd-pstate-ut: Drop SUCCESS and FAIL enums
>        cpufreq/amd-pstate-ut: Run on all of the correct CPUs
>        cpufreq/amd-pstate-ut: Adjust variable scope
>        cpufreq/amd-pstate: Replace all AMD_CPPC_* macros with masks
>        cpufreq/amd-pstate: Cache CPPC request in shared mem case too
>        cpufreq/amd-pstate: Move all EPP tracing into *_update_perf and
> *_set_epp functions
>        cpufreq/amd-pstate: Update cppc_req_cached for shared mem EPP writ=
es
>        cpufreq/amd-pstate: Drop debug statements for policy setting
>        cpufreq/amd-pstate: Rework CPPC enabling
>        cpufreq/amd-pstate: Stop caching EPP
>        cpufreq/amd-pstate: Drop actions in amd_pstate_epp_cpu_offline()
>
>   arch/x86/include/asm/msr-index.h   |  20 ++++----
>   arch/x86/kernel/acpi/cppc.c        |   4 +-
>   drivers/cpufreq/amd-pstate-trace.h |  57 +++++++++++----------
>   drivers/cpufreq/amd-pstate-ut.c    | 211
> ++++++++++++++++++++++++++++++++-----------------------------------------=
--
>   drivers/cpufreq/amd-pstate.c       | 666
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++---------------------------------------------=
---------------------------------------------------------------------------=
--------------
>   drivers/cpufreq/amd-pstate.h       |  65 +++++++++++++-----------
>   include/linux/cpufreq.h            |   3 ++
>   7 files changed, 461 insertions(+), 565 deletions(-)

Pulled and added to linux-pm.git/linux-next, thanks!


Return-Path: <linux-pm+bounces-14052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6CB975B7F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 22:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F9B283330
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 20:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE9F1BAEF6;
	Wed, 11 Sep 2024 20:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMGmPWfg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783E67E583
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 20:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085644; cv=none; b=vBW7Yo+2vqEDKtWSPZi4xHU1vHVmUUSrBUyJ9Dqtd52yjKA+irVIWHUETwpMWLmAKjuEp0sSaZORP4sKJJW8JZ+901C1vqSDZKYArGt+ghCVPbpRdq+6qjksEprJj2EGMyUGi2pRSDB0HX8fC7aj1LMJ0wbyx3LkrlN46M9puzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085644; c=relaxed/simple;
	bh=Vi+zG9ijbJAjSNtB/PKK/KMeKngrA2t57Sr6cbQ5Heg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QxeI88jJPtgrDm+xilhe0wyxYxrD3Mc180IPg9JXPMyC5Kbj+Xa+RgAod4geXYfmMwiIKU/ebLYqY8cRK3vk24ValJ2bVJ5en0cY9wR4+BMiyU5tkFgFy4rB4Qi/BTcmtxN/O0Dwh2fAjZFbDyJcSHscQhHvnQpe0xyTwYFnrxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMGmPWfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF46C4CEC0
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 20:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726085644;
	bh=Vi+zG9ijbJAjSNtB/PKK/KMeKngrA2t57Sr6cbQ5Heg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DMGmPWfg58fozw6GJmofR6vrG1b/MEn9NdLXyDzftuwC9TehQJp3PDy3gxQxxZxka
	 YCywmAuu09u6zIm0ClblMFpJgUWsvwFTvOZaIKxOuVJXdFaaJWTsB98yvXAxvfO3L1
	 glaQnmaIvwhGAX2DZ0/sBUHdG8Y6OqbbqP90qHTkVhGssq67KjEGZeLyKlWlV7x1yS
	 BEk66rhTPKHzCsY+b2ltMpXAxVzJd/E+mBBHMKwNlWxmVWzvwRSxMgkPm8ndUFDQDZ
	 E7sQxoKrqBm/AMA3qcamxk1dmb8b9mrxtt9NQl8CVOol2ETzDkmoM0vaLsKqu11REM
	 sWHCibF7ixZ8A==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-277f19ee2a2so104522fac.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 13:14:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWgFh7KFi/HR7EMdw9la3GDSVg7XoCKAIH8nepnP4IJiu40leglQOWOuaIU+LMFShBP/m19mu4KOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlHfar7K/HwwOuhPgM2UhrXjKv9swNftnYeFh66/0E7WF1lcDD
	SI+gyZcPH6HRol64Gz+vMJkT5F4D1+QFIljxYmp25mNhz6Nn5mFGG3ip+QlJLB2h1CiGc3tUXd9
	79YpsnwMrweN6H1jCpW8zenK6EWU=
X-Google-Smtp-Source: AGHT+IGAspnQK+XKmBu/nHSGyygB2CApiIYIagjAhYtGpEDZiNNeU4hPid4x0lkQj1JqLRAj6I0d3m/TAdsc0Xvzibc=
X-Received: by 2002:a05:6870:870b:b0:277:f301:40d5 with SMTP id
 586e51a60fabf-27c3f6099c0mr444904fac.31.1726085643243; Wed, 11 Sep 2024
 13:14:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0f490e10-bab5-44d2-aa9f-efd80d306083@amd.com>
In-Reply-To: <0f490e10-bab5-44d2-aa9f-efd80d306083@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Sep 2024 22:13:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gRTQTLL3r5LV+ehm6+8VfgSQ2QMOASD_JP9B34GJk9Lg@mail.gmail.com>
Message-ID: <CAJZ5v0gRTQTLL3r5LV+ehm6+8VfgSQ2QMOASD_JP9B34GJk9Lg@mail.gmail.com>
Subject: Re: second round of amd-pstate changess for 6.12 (second try)
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mario,

On Wed, Sep 11, 2024 at 6:01=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The following changes since commit 6b612d1bac67b0f483fde7779a45f6310274d4=
eb:
>
>    cpufreq: ti-cpufreq: Use socinfo to get revision in AM62 family
> (2024-09-04 20:43:59 +0530)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.12-2024-09-11
>
>
>
>                                      for you to fetch changes up to
> 93497752dfed196b41d2804503e80b9a04318adb:
>
>    cpufreq/amd-pstate-ut: Fix an "Uninitialized variables" issue
> (2024-09-11 10:53:03 -0500)
>
> ----------------------------------------------------------------
> second round of amd-pstate changes for 6.12 (second try):
>
> * Move the calculation of the AMD boost numerator outside of
>    amd-pstate, correcting acpi-cpufreq on systems with preferred cores
> * Harden preferred core detection to avoid potential false positives
> * Add extra unit test coverage for mode state machine
>
>
>
>
> ----------------------------------------------------------------
> Mario Limonciello (13):
>        x86/amd: Move amd_get_highest_perf() from amd.c to cppc.c
>        ACPI: CPPC: Adjust return code for inline functions in
> !CONFIG_ACPI_CPPC_LIB
>        x86/amd: Rename amd_get_highest_perf() to
> amd_get_boost_ratio_numerator()
>        ACPI: CPPC: Drop check for non zero perf ratio
>        ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to w=
arn
>        x86/amd: Move amd_get_highest_perf() out of amd-pstate
>        x86/amd: Detect preferred cores in amd_get_boost_ratio_numerator()
>        cpufreq: amd-pstate: Merge amd_pstate_highest_perf_set() into
> amd_get_boost_ratio_numerator()
>        cpufreq: amd-pstate: Optimize amd_pstate_update_limits()
>        cpufreq: amd-pstate: Add documentation for `amd_pstate_hw_prefcore=
`
>        amd-pstate: Add missing documentation for
> `amd_pstate_prefcore_ranking`
>        cpufreq/amd-pstate: Export symbols for changing modes
>        cpufreq/amd-pstate-ut: Add test case for mode switches
>
> Qianqiang Liu (1):
>        cpufreq/amd-pstate-ut: Fix an "Uninitialized variables" issue
>
>   Documentation/admin-guide/pm/amd-pstate.rst |  15 ++++++++++++++-
>   arch/x86/include/asm/processor.h            |   3 ---
>   arch/x86/kernel/acpi/cppc.c                 | 172
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++-----------
>   arch/x86/kernel/cpu/amd.c                   |  16 ----------------
>   drivers/cpufreq/acpi-cpufreq.c              |  12 +++++++++---
>   drivers/cpufreq/amd-pstate-ut.c             |  41
> ++++++++++++++++++++++++++++++++++++++++-
>   drivers/cpufreq/amd-pstate.c                | 151
> +++++++++++++++++++++++++++++++++++++++----------------------------------=
---------------------------------------------------------------------------=
---
>   drivers/cpufreq/amd-pstate.h                |  14 ++++++++++++++
>   include/acpi/cppc_acpi.h                    |  41
> ++++++++++++++++++++++++++++-------------
>   9 files changed, 305 insertions(+), 160 deletions(-)

Pulled and added to the linux-next branch in linux-pm.git, thanks!


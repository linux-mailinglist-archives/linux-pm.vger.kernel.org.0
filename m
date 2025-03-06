Return-Path: <linux-pm+bounces-23579-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C09A55779
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 21:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B2B1898433
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 20:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1693E1D8E01;
	Thu,  6 Mar 2025 20:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9GG2oZj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66AE249E5
	for <linux-pm@vger.kernel.org>; Thu,  6 Mar 2025 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741293154; cv=none; b=d8ZdXwLhtL0zdoQDVmTP5f/vdzA+lZGyx+szEA+W2SnxZTrfaghiK+8MHUb+FRt67L54uA6cCmy3S7elm9/6gHxlrBst3//83sLSZ96iKBTOrFoDbPZVtxfysiDPOKl5Ixn96QrxgZ/euKydINAWwQYE33NXayIqSbSQ8PzFbIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741293154; c=relaxed/simple;
	bh=PFdDZGCrSjSwKObNvyxPA2g7xcnd+JijTKqT/fIRv6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZL1UTSC53Ysm1lhD14UwpatVSWPBQDUMPV8X0btnmxSZq6jIG2kd2upxnQGQFhOgYwdFNZmWlw8YgvcMN3pyb3nOh9omAvPdvv6EGU+N8DnxOI9sWzjpZ2Mvkc+4VPWw4wxgpuz8aBWmxbxW15Qg4oYV3X8YbbcA+m2U4RvE9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9GG2oZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFE8C4CEE9
	for <linux-pm@vger.kernel.org>; Thu,  6 Mar 2025 20:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741293153;
	bh=PFdDZGCrSjSwKObNvyxPA2g7xcnd+JijTKqT/fIRv6A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K9GG2oZjGgSYJ8+X8L9VLyfkklScyuNqCBCVGICjiEhGHe3qzOqUg3z5Yk3YqWQ43
	 9LZ2GMP4SZtxiTuKJZ6QansGNDT0ATM07ZJD76fGroHAVFKydlDq5kQLkzoOr9N45X
	 MrIU3BVkuADza9L7KUUN+jetVYf+gzh6OgRvaSziWcirfhphVarXMWAoBAAovCGfYC
	 o0k6ge9mWaNHku8H9eWq255FBn4qPGQBRs/mOW4kUmGMgVr4PuWpp4yvl7dyIckyDC
	 Nns7YtK+vaRbsNnZKF2LwwtT4KtEvp8+CJ34jwTH2Im6lzQNS95etll26sR7WPzEZK
	 3Bzn5t0qU0Azw==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5fe8759153dso411300eaf.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Mar 2025 12:32:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWXuatHzauJ8qJ/ZrpAEQ4dWhhnFk7lmMNtT9qZVQlTFP1IdUQk3hhoCQKry1Ma9kOuuDqrDETOdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFPK0gc7VFQaVslBKbrB7FzmGHNQD4DE69jmCe2kRJ3xAH9+EI
	58lhb0NZhYSeEwryhNa41sr3u6Ca4cn7NQIjhwW6lHzWfI9xp6MhhJeKDAs8qRKD8hpfEyVMb64
	5OeKHwNWqlArGlS2aXY1A5JTZ+H8=
X-Google-Smtp-Source: AGHT+IHwx1Fu/6ZpdAmfRd/IODyaBV72kwFvEmEDb99Fm8ev469mUvvLGFdZeRqiXwFi4kS2Rb4PlddHSacWrE227Uc=
X-Received: by 2002:a05:6820:180f:b0:5fe:9db0:6d5b with SMTP id
 006d021491bc7-6004ab5464emr517842eaf.7.1741293152563; Thu, 06 Mar 2025
 12:32:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <206f245c-d6f6-4dcd-a2f8-643c8100622d@amd.com>
In-Reply-To: <206f245c-d6f6-4dcd-a2f8-643c8100622d@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 6 Mar 2025 21:32:21 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hLTpGb012t48OAic0hu4Y8FXBF5ogh+n7U1aPbKRUb+A@mail.gmail.com>
X-Gm-Features: AQ5f1JpxNA5NSD2ZT7uEQ2dw5DkCGwHQ62cQSAMlgojuH6Ki7evzVMQhhHemqME
Message-ID: <CAJZ5v0hLTpGb012t48OAic0hu4Y8FXBF5ogh+n7U1aPbKRUb+A@mail.gmail.com>
Subject: Re: [GIT PULL] amd-pstate content for 6.15 3/6/25 (redo of 3/3/25 tag)
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	"Ugwekar, Dhananjay" <dhananjay.ugwekar@amd.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 9:17=E2=80=AFPM Mario Limonciello
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
> tags/amd-pstate-v6.15-2025-03-06
>
> for you to fetch changes up to efb758c8c803217e58248f03db372c5e23827dae:
>
>    cpufreq/amd-pstate: Drop actions in amd_pstate_epp_cpu_offline()
> (2025-03-06 13:01:26 -0600)
>
> ----------------------------------------------------------------
> amd-pstate content for 6.15 (3/6/25)
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
> NOTE: This is a redo of amd-pstate-v6.15-2025-03-03 with a fixed Fixes ta=
g.
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

Pulled, thanks!


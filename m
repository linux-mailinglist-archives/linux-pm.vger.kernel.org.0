Return-Path: <linux-pm+bounces-16664-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDD29B4C9F
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 15:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDCFE1C2224A
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 14:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C073191F91;
	Tue, 29 Oct 2024 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hc9RHHQA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271A2191F6D
	for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213460; cv=none; b=gDpuXKndiR3pD7hNvBEvoZDaqTs7N1U6Tcfbw4f0f8xAh8dGAUORNDzD8MCAgEZDd07luxHmY9H+ZkOBr0kyj7D8DFiAcJvZUBihxRLBDDk1IqjbiWmk4qt1aE01emQK2ZSrYq8oMTWN9z6azvekdj/o7VDR3kRe0nHtWbS7/rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213460; c=relaxed/simple;
	bh=V+9pAZ1TgZqiU1UnOdv1TPVZzftVCZkFTasinCKkMY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bs8kXLZqqhs5vcwG2i0MBH7oN3zqyF5dsEE1T+304j3nQw3E8qozVJbr0rqwcfVnjvvZuhU6NcT5Cxm78ll/UBYUoXS7D9X7tQu+Ji1EvsIWXPeh6jnXws+JXTlHgjsJj8JEsvRc7N1HIAriEZ48hwbKDhs4y/To2qCLpF6nTlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hc9RHHQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07620C4CEE8
	for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 14:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730213460;
	bh=V+9pAZ1TgZqiU1UnOdv1TPVZzftVCZkFTasinCKkMY8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Hc9RHHQAAC1xyLlR/OLmDaLQHgmIrIajv3urH2+D6bVyJmANp2GGuKGYAtEczLIq1
	 mvdUdFE+lkMOjErsbovas3ExMb2W2Y62j6KPdcrQA7B3w7FJzNgEXC34ayP4DwR/SS
	 SLFu9jq+hjrQa81pZBe8Pb4jQ++q7lqCQVPxIeySXYxxNneSGSUXAocfzJQKNQCHHX
	 rl5DXWWwlPM39wEGQOKr2ynjxgNQ4V439HoIWj9PxG8kR+HOISPbABG6dujLq0tJLi
	 K2L3IO/t1aOXcUV35QYWElCmoanSFOGFoyt84gjkK4bQi3uqDT15881KCDob0hruUU
	 eHGxzh9F5iMTg==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-28cdd9d8d01so2845406fac.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 07:50:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUt3FKavQMg951ZJGqALVBwmDn4sp9xSb1TXsMvAZqSXS0dmpHmb++hQpaOCLSlhSN/ngWcJzd7Gg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7v/FpbNIMIdHixQKmSPqIAOSZFCbR5zv9YnOB8jO5VP7iWeYu
	PG9N6DUmcb9Bl+LDmjAUkHDDbRjEJ42KYFFxHwM7JVyl87H4VpIOYmkf1fskVHPhCVHWqBgT9TN
	/tc1ekcXaUyas4aQPPLcv6V8NqrE=
X-Google-Smtp-Source: AGHT+IFzk+5iknjkPQXGC2Ldd7aUxT/U8a9N4oVLFa9RKRs98Rfy3Xnvu2htDge081jFGWjD//mSk4EyNKdcGJaW0YA=
X-Received: by 2002:a05:6870:2184:b0:288:4823:fe1b with SMTP id
 586e51a60fabf-29051b73163mr10494636fac.17.1730213459229; Tue, 29 Oct 2024
 07:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7b1d8208-1e00-4ca3-a4f9-7d13c9867447@amd.com>
In-Reply-To: <7b1d8208-1e00-4ca3-a4f9-7d13c9867447@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 29 Oct 2024 15:50:47 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jkt3SPJAfO5cexMTOvp77auusSC9bohnhiDwiq=e5M7A@mail.gmail.com>
Message-ID: <CAJZ5v0jkt3SPJAfO5cexMTOvp77auusSC9bohnhiDwiq=e5M7A@mail.gmail.com>
Subject: Re: New amd-pstate content for 6.13 (10/29/24)
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 3:03=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Hi,
>
> Here is the updated PR based off the linux-pm/cpufreq branch.
>
> The following changes since commit a9dedaa07b5e6034dbdd482c23aa3936958292=
ac:
>
>    cpufreq: Switch back to struct platform_driver::remove() (2024-10-28
> 12:24:39 +0100)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.13-2024-10-29
>
>
>
>                                                                  for you
> to fetch changes up to ff2653ded4d99b709f62f35656d976c47a7aa476:
>
>    cpufreq/amd-pstate: Move registration after static function call
> update (2024-10-29 08:50:39 -0500)
>
> ----------------------------------------------------------------
> Update the amd-pstate driver to set the initial scaling frequency policy
> lower bound to be lowest non-linear frequency. This will have a slight
> power consumption impact but should lead to increased efficiency.
>
> Also amd-pstate is enabled by default on servers starting with newer
> AMD Epyc processors.
>
> Align more codepaths between shared memory and MSR designs.
>
> Add various code cleanups to rename functions and remove redundant calls.
>
>
>
>
> ----------------------------------------------------------------
> Dhananjay Ugwekar (11):
>        cpufreq/amd-pstate: Rename MSR and shared memory specific function=
s
>        cpufreq/amd-pstate: Remove the redundant verify() function
>        cpufreq/amd-pstate: Set the initial min_freq to lowest_nonlinear_f=
req
>        cpufreq/amd-pstate: Call amd_pstate_register() in amd_pstate_init(=
)
>        cpufreq/amd-pstate: Call amd_pstate_set_driver() in
> amd_pstate_register_driver()
>        cpufreq/amd-pstate: Remove the switch case in amd_pstate_init()
>        cpufreq/amd-pstate: Remove the redundant amd_pstate_set_driver() c=
all
>        cpufreq/amd-pstate: Rename functions that enable CPPC
>        cpufreq/amd-pstate: Do not attempt to clear MSR_AMD_CPPC_ENABLE
>        cpufreq/amd-pstate: Call cppc_set_epp_perf in the reenable functio=
n
>        cpufreq/amd-pstate: Align offline flow of shared memory and MSR
> based systems
>
> Gautham R. Shenoy (1):
>        amd-pstate: Set min_perf to nominal_perf for active mode
> performance gov
>
> Mario Limonciello (7):
>        cpufreq/amd-pstate: Fix non kerneldoc comment
>        cpufreq/amd-pstate: Don't update CPPC request in
> amd_pstate_cpu_boost_update()
>        cpufreq/amd-pstate: Use amd_pstate_update_min_max_limit() for EPP
> limits
>        cpufreq/amd-pstate: Drop needless EPP initialization
>        cpufreq/amd-pstate-ut: Add fix for min freq unit test
>        cpufreq/amd-pstate: Push adjust_perf vfunc init into cpu_init
>        cpufreq/amd-pstate: Move registration after static function call
> update
>
> Swapnil Sapkal (1):
>        amd-pstate: Switch to amd-pstate by default on some Server platfor=
ms
>
>   drivers/cpufreq/amd-pstate-ut.c |   6 +++---
>   drivers/cpufreq/amd-pstate.c    | 229
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++------------------------------------------------------=
---------------------------------------------------------------------------=
------
>   2 files changed, 97 insertions(+), 138 deletions(-)

Pulled and added to the linux-next branch in linux-pm.git.

I will merge it into the 'cpufreq' branch when it spends some time in
linux-next.

Thanks!


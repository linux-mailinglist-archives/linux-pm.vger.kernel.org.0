Return-Path: <linux-pm+bounces-13901-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A47B4971F65
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 18:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D763288BD5
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 16:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44909168488;
	Mon,  9 Sep 2024 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lz/8oCw/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFB21487E2
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899904; cv=none; b=WymRHBYY6ZdGSLm2nuVseC1McFMHDtL92KpGpmFn7CDBjIbnnB11PgA6YeiMhA7OkwqQ8j2DFcrWyBUhu1aLX/cmHXfXZwcyJRQuEBLg3WF3xZRa4bP5TPUSG/yGelIhLAKuopu5W3sGV4nFIP2ZzCSBaqy365mfF5X0UorMctA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899904; c=relaxed/simple;
	bh=26pYfRVa9CCrl5GO8JaubgMwNbJAivZ31qyuhjb6VaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5eiMxLigVlPREQK9qHF/vAwssjUtlCM2XcdEEegPul87oMkLUwcE+VrdehiFEEVX340VMGkYspRSFEw0sEj7aeO+DelS670x2x4X5upZA4SjNgvaU6qP5MFYkMtgqEwpI7wrbN1MZjN3EPomFjdkPR91dUqk+llNNytuDsSIL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lz/8oCw/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D83C4CEC5
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 16:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725899903;
	bh=26pYfRVa9CCrl5GO8JaubgMwNbJAivZ31qyuhjb6VaI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lz/8oCw/5ZjoxORcKqLTPfyvq3fkXdHLWmT1gBxu0kqSyxBQm6iwqRHcjnzh+U3l1
	 QmbYjwjyaXzhiSrjkXPHIq1RCPLucFLsIvizaRFhtNMVJeK1jcfLINx3Y3UP2hlyXq
	 6rRCx/fyHkit04Pu7cfmH9taCQwMhimbjsJERUoLwfv3nEtFOOS++gtsFczHs2NenA
	 p2DjDkDipmV9KkBgSno3KaKyDvH3Of4Dha6x9xps5RaQpbZTV2KET/rpMDeJrqZrEe
	 2qnYDsh8Tvp0SPJ8hHnLgTsD1/XrffyO/1EJkypQH75VTidgfJvRcRnx943wLuhdUX
	 sgA+AF+p/jvug==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5de8b17db8dso2859872eaf.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Sep 2024 09:38:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0qp8idtNjSNCdUWPNE2UuwVg8prhJZ2jJiBU2bkV5k7MnomVmq0Ju1HdP4d5MuhNa9jCsR3BEww==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywph76bOSmYuIv4uz7gDSD83K5Fil5e/+R7InQr9tS4pz7gnhyP
	JthXTCaplgDCL0SticXGCsWnuBk8ZyHES7pnoK5TzPbEzYDhpvUyKw4q239bqRySOBiIXO/ICZ3
	McgMaRBgQa/ywdBKK2xwD8woAbA8=
X-Google-Smtp-Source: AGHT+IFhCDwyE4qCRaiZ/qa3huhYxWq9BWwBau0I2hI3N+BB+JhqlCeGBhGaSrL1QXkPJIisfRNFQ1LA3ur061h7tS4=
X-Received: by 2002:a4a:ee82:0:b0:5e1:d961:e7b with SMTP id
 006d021491bc7-5e1d96110f3mr2241937eaf.1.1725899902997; Mon, 09 Sep 2024
 09:38:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <da6db097-d4a7-425f-8e61-084a2fe15770@amd.com>
In-Reply-To: <da6db097-d4a7-425f-8e61-084a2fe15770@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 9 Sep 2024 18:38:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gzUbiaT5_74NSPv9bbBO4GfCoEfx-M0JHHMqYkn5N+8w@mail.gmail.com>
Message-ID: <CAJZ5v0gzUbiaT5_74NSPv9bbBO4GfCoEfx-M0JHHMqYkn5N+8w@mail.gmail.com>
Subject: Re: Second round of amd-pstate 6.12 content
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mario,

On Mon, Sep 9, 2024 at 5:52=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Hi,
>
> The following changes since commit 8cc214312cf8a0c3702edd1aa52e507262adcc=
b9:
>
>    Merge branch 'pm-opp' into linux-next (2024-09-06 20:53:58 +0200)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.12-2024-09-09
>
> for you to fetch changes up to e121c01c0422fc56033d0dfa1bf3f0366115d2d5:
>
>    cpufreq/amd-pstate-ut: Add test case for mode switches (2024-09-09
> 10:26:26 -0500)
>
> ----------------------------------------------------------------
> second round of amd-pstate changes for 6.12:
>
> * Move the calculation of the AMD boost numerator outside of
>    amd-pstate, correcting acpi-cpufreq on systems with preferred cores
> * Harden preferred core detection to avoid potential false positives
> * Add extra unit test coverage for mode state machine
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


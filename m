Return-Path: <linux-pm+bounces-19537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 481559F84C0
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 20:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494CF188A33D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 19:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B8E1A9B55;
	Thu, 19 Dec 2024 19:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZJWs5sy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D18155342
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 19:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734637889; cv=none; b=OrXaemQbtGJSMXmLtoWWPWbdyArjPPgqu94TpF1af31xZEquJQqAnkWmBMVTwcJGvS46nPe+HEvplNA8VqWw0Ie0kouSaU2S5rvMyGkkc8DTK91mTFlhZEDVfgvPHFCUaBd0w2G25/IaS8SEeb9PGTdWR5/G9yrrhsHrRmlQs9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734637889; c=relaxed/simple;
	bh=y7oUz4SuExNm31vj3cCfoo9vRQaFpH/6KjDAOIQ94/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSlBAj8bTceEFyZxlUS6zn8sev9jbhbv4c0R0MCGQ4k2UBTuWEAAJUr3QNi69YHmF/HIvOD2i8IMI1VpPoJ6YVFzvrDXZk9a9MK1bhGcnXvixMV+LFr9KEPKgXrwc/poHoqICAs8er+1ZeBLYfWXYoKEBssDdX7YpbcBKy+mvg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZJWs5sy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4ADC4CECE
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 19:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734637889;
	bh=y7oUz4SuExNm31vj3cCfoo9vRQaFpH/6KjDAOIQ94/Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LZJWs5syOho+IV0FU20jbzD/XCq6fYybLIF4eTjNXbokkbRh4Xhz1ueixcCrdSnZ4
	 iZO8m79nYZ/hk6IEL/lQkOayWdAP6sHLMeg5lhfB02As79XbLkkssBQD+iRJy/FsZG
	 5elDfvUIsG+IZCOqa+ANQhjl1ZOJ2HYoiUX/gtZEg3hmiT79QeO3PhrstgEZTJhvCZ
	 oKOuVLDA9wLh8yt9IYsOSzX5wAroko9jF99fBJ083SmO1WT8DMqnPs4h342L5Ky3Qd
	 d1w+w5RZAnEJW4OuR692Mp7S2i/xovMhPRG3CrrH36qIOHfGiqe6xdlA5eTjt/x6i+
	 kg8jIlBqXhkqA==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71e2bc5b90fso539023a34.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 11:51:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW6ahP//W7d3pHk5PT2UzQVdkn3BudyebxGCtp3bvGyABr/KlI3mEb4s+Jc4I0dy+JI/U8qhh2cQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCW1mrFHdstk2p/TUHHPZYFR9TUFP+XBU3y8yEFWUW9d/os0Ex
	0tlNdftGU3S+iC5Cn59Z9VtyTcrtO8Nhz/qSyW97L30MTyMYvobhNG5EaBU0T2lBuE5TX0cYaCU
	AmHUntNb3c1zgnAKG+ZEOYrItX8k=
X-Google-Smtp-Source: AGHT+IHpoTLJhYkOGEbi9uTZv+d3e8a4yuH01dxKw6bsV019Mfsc4FgHzBbE0bKTNhb7L/x5P+w2OSri8ciTVQzOVz0=
X-Received: by 2002:a05:6830:7102:b0:71d:fdf7:f8d6 with SMTP id
 46e09a7af769-720ff955110mr139592a34.28.1734637888318; Thu, 19 Dec 2024
 11:51:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ba6ab96f-89bb-4bb3-a295-a1f41042eb15@amd.com>
In-Reply-To: <ba6ab96f-89bb-4bb3-a295-a1f41042eb15@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 19 Dec 2024 20:51:17 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ihGFW3cKHo1MEhyaHGKimLMeh4Ri8O=0E3YwQGRErD3w@mail.gmail.com>
Message-ID: <CAJZ5v0ihGFW3cKHo1MEhyaHGKimLMeh4Ri8O=0E3YwQGRErD3w@mail.gmail.com>
Subject: Re: [GIT PULL] amd-pstate content for 6.14 (12/18/24)
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 18, 2024 at 8:43=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Hello,
>
> The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dc=
a4:
>
>    Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.14-2024-12-18
>
> for you to fetch changes up to 95fad7fb58cfaa2a295aa54a1f001a16b9324963:
>
>    cpufreq/amd-pstate: Drop boost_state variable (2024-12-11 10:44:53 -06=
00)
>
> ----------------------------------------------------------------
> amd-pstate changes for 6.14
>
> Mostly cleanups and optimizations to increase code reuse by
> shuffling around and using helpers.
>
> Notable other changes:
>   * Add ftrace event for active mode to use
>   * Set default EPP policy on Ryzen
>
> ----------------------------------------------------------------
> Dhananjay Ugwekar (5):
>        cpufreq/amd-pstate: Convert the amd_pstate_get/set_epp() to
> static calls
>        cpufreq/amd-pstate: Move the invocation of amd_pstate_update_perf(=
)
>        cpufreq/amd-pstate: Refactor amd_pstate_epp_reenable() and
> amd_pstate_epp_offline()
>        cpufreq/amd-pstate: Remove the cppc_state check in offline/online
> functions
>        cpufreq/amd-pstate: Merge amd_pstate_epp_cpu_offline() and
> amd_pstate_epp_offline()
>
> K Prateek Nayak (1):
>        cpufreq/amd-pstate: Detect preferred core support before driver
> registration
>
> Mario Limonciello (15):
>        cpufreq/amd-pstate: Store the boost numerator as highest perf agai=
n
>        cpufreq/amd-pstate: Use boost numerator for upper bound of
> frequencies
>        cpufreq/amd-pstate: Add trace event for EPP perf updates
>        cpufreq/amd-pstate: convert mutex use to guard()
>        cpufreq/amd-pstate: Drop cached epp_policy variable
>        cpufreq/amd-pstate: Use FIELD_PREP and FIELD_GET macros
>        cpufreq/amd-pstate: Only update the cached value in msr_set_epp()
> on success
>        cpufreq/amd-pstate: store all values in cpudata struct in khz
>        cpufreq/amd-pstate: Change amd_pstate_update_perf() to return an i=
nt
>        cpufreq/amd-pstate: Move limit updating code
>        cpufreq/amd-pstate: Cache EPP value and use that everywhere
>        cpufreq/amd-pstate: Always write EPP value when updating perf
>        cpufreq/amd-pstate: Drop ret variable from
> amd_pstate_set_energy_pref_index()
>        cpufreq/amd-pstate: Set different default EPP policy for Epyc and
> Ryzen
>        cpufreq/amd-pstate: Drop boost_state variable
>
>   Documentation/admin-guide/pm/amd-pstate.rst |   4 +-
>   drivers/cpufreq/amd-pstate-trace.h          |  52 ++++++++++++--
>   drivers/cpufreq/amd-pstate-ut.c             |  12 ++--
>   drivers/cpufreq/amd-pstate.c                | 520
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------=
----------------------------------------------------------------
>   drivers/cpufreq/amd-pstate.h                |   3 -
>   5 files changed, 301 insertions(+), 290 deletions(-)

Pulled, thanks!


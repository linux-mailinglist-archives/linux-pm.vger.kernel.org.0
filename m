Return-Path: <linux-pm+bounces-16302-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 306609ACAEC
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 15:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A32281D8D
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 13:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C6D1A2658;
	Wed, 23 Oct 2024 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGA4Ew78"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D60159583
	for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2024 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689408; cv=none; b=ggSiZ2TFBoIIGpaF3wkaqESVRyVJwX7fb+RgbMEOUICctyRG75kzAZxPzvoIdXzoR6qIplxONIsUZ74YGfrdYQkyxKfo98nhU2CTrqDEtZUtPV/UzsVRbcSIsDbfVHDwcsJ0Zpt/BWZkYbAwB3sUzwF8a9H0WN9vceCOZDn9v2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689408; c=relaxed/simple;
	bh=IfqLlPJAQ100I0nafozTcY0d/YJhpyqkjbYuiHkNiFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ws/sdcxohh5UxSvufjDHdDvHM3vxAoGk47SNA9+ro/JEbCmDQO8+XfiOZw2ksyQHLCOS5kVOZ0Y1tbL2Hw1VDAWfuJNJosSKFxJ2BNO4pkuFyyaBKJhBXt4gT1ob0Ego6BWm9cpwGNzU/lrgaTMDOPgyMHTGm62CndRD7+ED8jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGA4Ew78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B90AC4CEC6
	for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2024 13:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729689408;
	bh=IfqLlPJAQ100I0nafozTcY0d/YJhpyqkjbYuiHkNiFY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XGA4Ew78TZgNjg/WXvDoX+exUWSpF+cbG6oJPUFzmoG03lw2hZgkY2RxK7BsrAoov
	 socmbA9htVaRaK1Vmza8uE5OsxMnCLo0hSq0dEB1g7iWNfJu1ksyIPqI0RTpF2LKyP
	 3amUsIJNomj/ilVp8V1Zbk92eWCKRgw9Xc1TCcSfPBWS9D+qd5wk7y0//dTWTzFZdp
	 n/EOhV5cxTPySTqUR9mznblXzNMR40/CXNQECtm8uV3KTv5xPyIaMvV3QqSh+w7nrz
	 PhJfCXtPQP6IV4teDs7bW003RNjKMCO3PWDpgkzhzghKkXnsD87xGMBW4xYbm5B6uz
	 UmUPhNvnoWk6g==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-288fa5ce8f0so2943337fac.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2024 06:16:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8KZIYTAm+XLOS+3LUPsK7ZKg+1p8tQa9wSuuYbLS9Ckpd86fGqRMmh7mecX0Aqx1oWzhpucADUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0z1TRs9h7erkxyWsPqVl0AudwK+IOfu74JPYkwE+/qD5wCpYu
	uacVLD7Ck05+G5MXIpWOrjUUeTxeGOyu0D8xH5v2EXMlqO/zAr4oy86pmtKyFuRTHzMuD7wBQd3
	42wfxcjeOoCxZGdLBbT/KakWXSoY=
X-Google-Smtp-Source: AGHT+IFGq/U+3gyujHCS9mqNGx8j6LLgaMDaUUqbr6oXAebM6UgRWSKARD71W+W2/hwWE9x3VLesvxUZyWhVFtUtryY=
X-Received: by 2002:a05:6870:828f:b0:287:0:9ecc with SMTP id
 586e51a60fabf-28ccb9888aamr2730466fac.33.1729689407408; Wed, 23 Oct 2024
 06:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <19b70e8a-7a11-46f6-ab9e-6dfaf315ef95@amd.com>
In-Reply-To: <19b70e8a-7a11-46f6-ab9e-6dfaf315ef95@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 23 Oct 2024 15:16:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iPGtnimd7_LwwGyoxxSrGQ8pug-JDhc5obWZNByTJN+A@mail.gmail.com>
Message-ID: <CAJZ5v0iPGtnimd7_LwwGyoxxSrGQ8pug-JDhc5obWZNByTJN+A@mail.gmail.com>
Subject: Re: amd-pstate 6.13 content (10/22/24)
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 22, 2024 at 10:54=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Hello,
>
> The following changes since commit 7f31183fa1d5c043864b4bd5632930f40d3c70=
02:
>
>    Merge branch 'acpi-battery' into linux-next (2024-10-22 22:00:30 +0200=
)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.13-2024-10-22
>
> for you to fetch changes up to 7027b415ff1a4184b99055f11455d5c7041aa3ee:
>
>    cpufreq/amd-pstate-ut: Add fix for min freq unit test (2024-10-22
> 15:21:42 -0500)
>
> ----------------------------------------------------------------
> Update the amd-pstate driver to set the initial scaling frequency policy
> lower bound to be lowest non-linear frequency. This will have a slight
> power consumption impact but should lead to increased efficiency.
>
> Also amd-pstate is enabled by default on servers starting with newer
> AMD Epyc processors.
>
> Add various code cleanups to rename functions and remove redundant calls.
>
> ----------------------------------------------------------------
> Dhananjay Ugwekar (7):
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
>
> Gautham R. Shenoy (1):
>        amd-pstate: Set min_perf to nominal_perf for active mode
> performance gov
>
> Mario Limonciello (5):
>        cpufreq/amd-pstate: Fix non kerneldoc comment
>        cpufreq/amd-pstate: Don't update CPPC request in
> amd_pstate_cpu_boost_update()
>        cpufreq/amd-pstate: Use amd_pstate_update_min_max_limit() for EPP
> limits
>        cpufreq/amd-pstate: Drop needless EPP initialization
>        cpufreq/amd-pstate-ut: Add fix for min freq unit test
>
> Swapnil Sapkal (1):
>        amd-pstate: Switch to amd-pstate by default on some Server platfor=
ms

Pulled, thanks!


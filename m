Return-Path: <linux-pm+bounces-35629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FC9BB060B
	for <lists+linux-pm@lfdr.de>; Wed, 01 Oct 2025 14:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 675D54C0085
	for <lists+linux-pm@lfdr.de>; Wed,  1 Oct 2025 12:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C1F26F295;
	Wed,  1 Oct 2025 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqlM3P7r"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02793A8F7
	for <linux-pm@vger.kernel.org>; Wed,  1 Oct 2025 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759322894; cv=none; b=bF4fRX0NaPrja67a91P0WqskuZiK/duBjEqLTlZIjUHiGNZRD9gStlZEa6J9n6VNqTEsei7t55e4wTDAKuyh12EZeiXuhKtUuBV1u7Sfg89I1gHa+BQTH7GS2E++TxtigocCetp/S+KbhTvsaSEKHsGHU/8J2Ck30VSHfvL0ifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759322894; c=relaxed/simple;
	bh=0uii14LP1LA92VKfWGfQYjpZpUG578uPPyL31hK9Quw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rzx29XtO68EirNWc/zk1KMyK0wKGLRaXUa1nFDm2xZlkSacUiocbu9qIJw9Zj/ojlAeJTlNN1FLe93Eaam+2V4R0mFbM/h2N6i0wXHwUOLuXKE+YwnRbmPmn0JN/ObB00Sf6nfKDaHklGr2AG2obBIb4Aks5K4JnDm+BoGQPAUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqlM3P7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC10CC4CEF4
	for <linux-pm@vger.kernel.org>; Wed,  1 Oct 2025 12:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759322893;
	bh=0uii14LP1LA92VKfWGfQYjpZpUG578uPPyL31hK9Quw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uqlM3P7rUh0+4CNVBhtt4a4azofdgY5yYfMHcQ3ayXn/wFasa8dblPvyzQWfjAMMk
	 hjhSVGlPtqFN2e9rcPE0J8SS+cmuHhfyv/H4bmJfDzdkQ7gOCvuRNF5beOyhOl+Qxt
	 GCV3wJY9woTHaiOouEzKW78DMovoJhfuw2tiwLQmRj5OHTVuAAU+fsjwLxxdw/SGLX
	 Rk0mAUx3XJo9pDmofNMBFYX6cwGPEHNrUAF5bzkexeomJtWPA7yNrfln3iogoKtmLc
	 dTDYbEOHPjvayrxc1RseK2wW6lOsVsHENUYlS8+dQSHGiN8vSgaHmXtybzFj4z5IMx
	 DHItzKJg1SNIQ==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6401f1733d7so2976557eaf.0
        for <linux-pm@vger.kernel.org>; Wed, 01 Oct 2025 05:48:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAOePIwgpFcyX8LSQAV9rLfko9FAaCuxQl+HC6J7hRXuGgYnyyVx2A/KHfzrG0yRTK+l3elFu6wQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0OIZIF3NMcwA443KrC0KkdBP+zJaPiOT6qseKnP5zwffsoPDp
	GT1vmuJcAugqIuv5oFlyMOZ9VUDhI69UnBUKl6wIeT+loZkTue8VaoRxB3yiwjRv1aZ4/obJtdk
	wVnA52Ly5Vxt0kQY26xO4zu8kzqaJFn8=
X-Google-Smtp-Source: AGHT+IE0PDlgyrc/KZ+o6fYHXvzHEqU8maawZFuSQLk9j9AAHLsthxk6iO7ndPCFT24oNvs+b2+evShlrNyu4nRPNjI=
X-Received: by 2002:a05:6808:1815:b0:43f:5e26:6638 with SMTP id
 5614622812f47-43fa402ce1cmr1766875b6e.4.1759322893148; Wed, 01 Oct 2025
 05:48:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001083423.5jndpemysufxjx7f@vireshk-i7>
In-Reply-To: <20251001083423.5jndpemysufxjx7f@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 1 Oct 2025 14:48:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h5AJGwG1RAQWMg32H6510JO82VAWh8bw+z0HYNr2LbTg@mail.gmail.com>
X-Gm-Features: AS18NWDsVfUidyLSFF8ymoMqk1gEG6WB5vBAJQGylXK7cgt8A_kCGuZKXk-2mjk
Message-ID: <CAJZ5v0h5AJGwG1RAQWMg32H6510JO82VAWh8bw+z0HYNr2LbTg@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm fixes for 6.18-rc
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Wed, Oct 1, 2025 at 10:34=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Hi Rafael,
>
> The following changes since commit 3e681899cc6e6c77eca55dd8c7cc57b27868e8=
a2:
>
>   cpufreq: mediatek: avoid redundant conditions (2025-09-04 10:20:44 +053=
0)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufr=
eq-arm-updates-6.18-rc
>
> for you to fetch changes up to ba6018929165fc914c665f071f8e8cdbac844a49:
>
>   cpufreq: tegra186: Initialize all cores to max frequencies (2025-09-29 =
14:55:50 +0530)
>
> ----------------------------------------------------------------
> CPUFreq fixes for 6.18
>
> - Update frequency for all tegra CPUs (Aaron Kling).
>
> - Fix device leak in mediatek driver (Johan Hovold).
>
> - Rust cpufreq helper cleanup (Thorsten Blum).
>
> ----------------------------------------------------------------
> Aaron Kling (2):
>       cpufreq: tegra186: Set target frequency for all cpus in policy
>       cpufreq: tegra186: Initialize all cores to max frequencies
>
> Johan Hovold (1):
>       cpufreq: mediatek: fix device leak on probe failure
>
> Thorsten Blum (1):
>       rust: cpufreq: streamline find_supply_names
>
>  drivers/cpufreq/mediatek-cpufreq.c | 14 +++++++++++---
>  drivers/cpufreq/rcpufreq_dt.rs     | 10 +++-------
>  drivers/cpufreq/tegra186-cpufreq.c | 35 +++++++++++++++++++++++++++-----=
---
>  3 files changed, 41 insertions(+), 18 deletions(-)
>
> --

Pulled and added to linux-pm.git/linux-next, thanks!


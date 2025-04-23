Return-Path: <linux-pm+bounces-26032-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50940A98A6B
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 15:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49D81B66D5B
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 13:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A7C143C69;
	Wed, 23 Apr 2025 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLGQKjay"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB6733F9
	for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745413508; cv=none; b=DP0R0/fsaf/sRH2Mur4DyJ6T1bwV/ve3hGIvh3gMS8C220OW7zGKno3HENNJ+uoHRvwZvGS0CRk+ZFC8TpozKOX6AXXGA0ZQ6N4SS8ErGIThxG1+snb3zKyxXeyvWbKeRrVXmBvN2XT2+z+QJhcJtgwJGaAvAiJYhMpJQXHQZS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745413508; c=relaxed/simple;
	bh=5YJ1EzEX4tdXlahfUcZnusIfoLhFoCXWqBQIDb8gXLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXObCntY430lEbkguo0sV66kbaPAD46cQQJWqL+7r3yxpp3yxgIc2nSNvEk+ie4eC4MG4oO2lP/scyVqPsW+PHZwrLt+T7EhC7/oTgJZvUKu+4wfE/ASwuFfN/sV2Db5MiJYeui424ErL6KeVUbsoVzVBOQIg0qJZ4PnochFW9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLGQKjay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B143C4CEEB
	for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 13:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745413508;
	bh=5YJ1EzEX4tdXlahfUcZnusIfoLhFoCXWqBQIDb8gXLY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mLGQKjay2qJSZ6fQtDbAnSnQPRj/Z6dpcBfml7J0pWhiMCGBja/EHALSkIG+8Wi0h
	 uMUg/A2fJVs0IKpJHXbMNdi9+XrVBJw5a1FWwF3H+/gvJNG3Ar+bg1dt9T+K9UZjw+
	 LqdzqN61tMshN6QMpnJEW830Sdw1rHoL94Dj4qUU3ZhTFWshUMoBRFoGqfqGF+IP5c
	 jqEHS6+RNv6m0CKxxBteN80/yjr2FcjuaCy9uvLxXdJxsNNX2HrscbgiCoqT0Hg8c/
	 tuTv3Mi4tBWn8w7irx4TiyNX3T3ElLUsSdYWLSVb1zepLemILQ5pAB5Y65TrbISwno
	 1Ogh/iSoZXADQ==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72bd5f25ea6so1575463a34.1
        for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 06:05:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDF5r6BnaJpVNfhhoRHWoCg0HG4bbezbQcvnxMiz1D5bsFeT/tkqkMs8OWla87Z5C0hXsZmvpPUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOCRbauE4ZioEB1nAc8aepfG2v4gGZBkVdf7IQ3/EeaYHPlKdj
	WYGUavURfcaKC7qOwWJ6QSqg7X5erIhj6JLMPhfsy75arzDPSIXG9t/zmHXPasfgflnOPxiRMNi
	hWAEhRxOwuSevfxV7tqtBrzmrB4Q=
X-Google-Smtp-Source: AGHT+IGBE3hDiXUq4vJ31XF825f6u5B7bMdNQIaEPegarjVvXd+ugvbm9LC7BBULTmZda8l1CKsvwdKRFr9Uvv4mN+s=
X-Received: by 2002:a05:6871:a411:b0:2cc:3530:d313 with SMTP id
 586e51a60fabf-2d526e52d97mr10759005fac.25.1745413507472; Wed, 23 Apr 2025
 06:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421073437.u5wfnuvjd2pfqtfr@vireshk-i7>
In-Reply-To: <20250421073437.u5wfnuvjd2pfqtfr@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 23 Apr 2025 15:04:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ga957CH38k4vdjWMjeskODbrww21kxGpg18PUA4Gk6LA@mail.gmail.com>
X-Gm-Features: ATxdqUEtxg4PaRSvMOPVjcdQel4Pg7J1_q0GhA2zHmjMd64X-LdmDZWY8vPlmnc
Message-ID: <CAJZ5v0ga957CH38k4vdjWMjeskODbrww21kxGpg18PUA4Gk6LA@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm fixes for 6.15-rc
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 9:34=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089a=
c8:
>
>   Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufr=
eq-arm-fixes-6.15-rc
>
> for you to fetch changes up to a374f28700abd20e8a7d026f89aa26f759445918:
>
>   cpufreq: fix compile-test defaults (2025-04-17 13:36:29 +0530)
>
> ----------------------------------------------------------------
> ARM cpufreq fixes for 6.15-rc
>
> - Fix possible out-of-bound / null-ptr-deref in drivers (Andre Przywara
>   and Henry Martin).
>
> - Fix Kconfig issues with compile-test (Johan Hovold and Krzysztof
>   Kozlowski).
>
> - Fix invalid return value in .get() (Marc Zyngier).
>
> - Add SM8650 to cpufreq-dt-platdev blocklist (Pengyu Luo).
>
> ----------------------------------------------------------------
> Andre Przywara (1):
>       cpufreq: sun50i: prevent out-of-bounds access
>
> Henry Martin (3):
>       cpufreq: apple-soc: Fix null-ptr-deref in apple_soc_cpufreq_get_rat=
e()
>       cpufreq: scmi: Fix null-ptr-deref in scmi_cpufreq_get_rate()
>       cpufreq: scpi: Fix null-ptr-deref in scpi_cpufreq_get_rate()
>
> Johan Hovold (1):
>       cpufreq: fix compile-test defaults
>
> Krzysztof Kozlowski (1):
>       cpufreq: Do not enable by default during compile testing
>
> Marc Zyngier (1):
>       cpufreq: cppc: Fix invalid return value in .get() callback
>
> Pengyu Luo (1):
>       cpufreq: Add SM8650 to cpufreq-dt-platdev blocklist
>
>  drivers/cpufreq/Kconfig.arm            | 20 ++++++++++----------
>  drivers/cpufreq/apple-soc-cpufreq.c    | 10 ++++++++--
>  drivers/cpufreq/cppc_cpufreq.c         |  2 +-
>  drivers/cpufreq/cpufreq-dt-platdev.c   |  1 +
>  drivers/cpufreq/scmi-cpufreq.c         | 10 ++++++++--
>  drivers/cpufreq/scpi-cpufreq.c         | 13 ++++++++++---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 18 ++++++++++++------
>  7 files changed, 50 insertions(+), 24 deletions(-)
>
> --

Pulled and added to linux-pm.git/fixes, thanks!


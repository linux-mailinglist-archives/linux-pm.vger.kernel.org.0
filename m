Return-Path: <linux-pm+bounces-20687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F764A16BE8
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 13:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7467161EDC
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 12:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19A61DF984;
	Mon, 20 Jan 2025 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/FKSIot"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB441DEFFE
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737374459; cv=none; b=paiC8KbLoHg70ssD6RE+DTyR/wMCQmMEyT3Op8A6n3lc0IQ2ca3XLwJuGW/HjDEXVcScN/a2FkYh/KpbV77bEZZgULov3bi/nuPZr1RCBxo51EVmZEHb86BA9Bq6Es0OJbVxJefPhsEgyn2JBiHQ2I1iMQmv/4t+JNFwK9b+UMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737374459; c=relaxed/simple;
	bh=ovOy8UMsWkkF4XtLWiy23eBVYj/gEG4GIbOOgRK013Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f32MU404YV3V1f+3bRkFwpVQNsZXDM8C1dzR9/vQ2b8jlkNdZFzk5dc84MExI0kqtiE3H8nIQG4jl5WutGcCBASHqmhXRJR348z50u9qSZB0rhSzWGQtHxUKn/mRlAWgdx4aEKTBKPVx0pg0SzjcW5WoP9i1hOYa3fmem2uWu+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/FKSIot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DF8C4CEE0
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 12:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737374459;
	bh=ovOy8UMsWkkF4XtLWiy23eBVYj/gEG4GIbOOgRK013Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K/FKSIotXYOO0tEjwB52erj45rJ8broaMf/+eHgKAtm5UGM12zjBRUZigE7MyM7jJ
	 AVbT42bQwF5mNtQNDQRMD9m02btl1QlDbdozsxfwgnq4Az0dtsIYhCVSmOXvoILIDX
	 2ZjkNDAeHVCrrN+bhILczFqSdiCoDxAvHLhS+OrMrQZqtBUsWc9i/V5ukmAUqr7diP
	 TKblcPcKE7lM+HhZ7Cg1icFpdgsflYASBYu9kUdPYQeu8YgSduf69JnU+rG1lsgYhj
	 2VXVOnlR0xqmQuBE6fTld2fVW4DGMj1WkP2FtVXj2nQCGTBbF9InqDfrjCbwLFMJ1+
	 AvrvrDLL5KhgA==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3eb98ad8caaso2980192b6e.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 04:00:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIMW1hjdhTTf706oA3AOiADAA+j7Ht9JjsdFopsZjeyua33LqMn9EcfnH3xk0WTSeaKAGu6kgLQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyB0zScTywPxovYWEA0IEAjRM6Bg2UUGBs8TCfwPm2PLi/TsTnr
	7cO0xUApECsxEg7S0MpkLMSqZr7pgt3TUdchDVoUiOyHIo/O0BBGwA+9oU58MpKLhPc5qb3s+df
	UO184y+KGTJq0oVMGmLwzCW7Rcfc=
X-Google-Smtp-Source: AGHT+IGFMAo5DrGfN0epNTfpW0pTqyLBzGwLn9nMv86tczdm2svCzTQQpY+tHIajvlBnh6/CE+9diTdzzSBRFmDZra4=
X-Received: by 2002:a05:6808:38c6:b0:3eb:7303:1dfc with SMTP id
 5614622812f47-3f19fd4cccbmr8884164b6e.30.1737374458494; Mon, 20 Jan 2025
 04:00:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120033527.w7s6bzbuw3sa63u3@vireshk-i7>
In-Reply-To: <20250120033527.w7s6bzbuw3sa63u3@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Jan 2025 13:00:43 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0haYARpnDw85uB9z1AvCKtHkuyZU9oD2woAPUoFu=Rvpg@mail.gmail.com>
X-Gm-Features: AbW1kvYMSO--9gr_oCt9yhI91Jaw7J68DpSmb85t9a4eCCsXXnZW6P0VgGRlhW4
Message-ID: <CAJZ5v0haYARpnDw85uB9z1AvCKtHkuyZU9oD2woAPUoFu=Rvpg@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 6.14
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Mon, Jan 20, 2025 at 4:35=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Hi Rafael,
>
> The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b=
37:
>
>   Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufr=
eq-arm-updates-6.14
>
> for you to fetch changes up to 84cf9e541cccb8cb698518a9897942e8c78f1d83:
>
>   cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver (2025-01-17 09:05:07 +=
0530)
>
> ----------------------------------------------------------------
> ARM cpufreq updates for 6.14
>
> - Extended support for more SoCs in apple cpufreq driver (Hector Martin
>   and Nick Chan).
>
> - Add new cpufreq driver for Airoha SoCs (Christian Marangi).
>
> - Fix using cpufreq-dt as module (Andreas Kemnade).
>
> - Minor fixes for Sparc, scmi, and Qcom drivers (Ethan Carter Edwards,
>   Sibi Sankar and Manivannan Sadhasivam).
>
> ----------------------------------------------------------------
> Andreas Kemnade (1):
>       cpufreq: fix using cpufreq-dt as module
>
> Christian Marangi (2):
>       dt-bindings: cpufreq: Document support for Airoha EN7581 CPUFreq
>       cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
>
> Ethan Carter Edwards (1):
>       cpufreq: sparc: change kzalloc to kcalloc
>
> Hector Martin (1):
>       cpufreq: apple-soc: Drop setting the PS2 field on M2+
>
> Manivannan Sadhasivam (2):
>       cpufreq: qcom: Fix qcom_cpufreq_hw_recalc_rate() to query LUT if LM=
h IRQ is not available
>       cpufreq: qcom: Implement clk_ops::determine_rate() for qcom_cpufreq=
* clocks
>
> Nick Chan (6):
>       dt-bindings: cpufreq: apple,cluster-cpufreq: Add A7-A11, T2 compati=
bles
>       cpufreq: apple-soc: Allow per-SoC configuration of APPLE_DVFS_CMD_P=
S1
>       cpufreq: apple-soc: Use 32-bit read for status register
>       cpufreq: apple-soc: Increase cluster switch timeout to 400us
>       cpufreq: apple-soc: Set fallback transition latency to APPLE_DVFS_T=
RANSITION_TIMEOUT
>       cpufreq: apple-soc: Add Apple A7-A8X SoC cpufreq support
>
> Sibi Sankar (1):
>       cpufreq: scmi: Register for limit change notifications
>
>  Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml |  =
55 +++++++++++++++++++++++++++++++++++++++++++++++++
>  Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml |  =
10 ++++++++-
>  drivers/cpufreq/Kconfig                                              |  =
 2 +-
>  drivers/cpufreq/Kconfig.arm                                          |  =
 8 ++++++++
>  drivers/cpufreq/Makefile                                             |  =
 1 +
>  drivers/cpufreq/airoha-cpufreq.c                                     | 1=
52 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cpufreq/apple-soc-cpufreq.c                                  |  =
56 ++++++++++++++++++++++++++++++++++++++++----------
>  drivers/cpufreq/cpufreq-dt-platdev.c                                 |  =
 4 ++--
>  drivers/cpufreq/qcom-cpufreq-hw.c                                    |  =
34 +++++++++++++++++++++---------
>  drivers/cpufreq/scmi-cpufreq.c                                       |  =
45 ++++++++++++++++++++++++++++++++++++++++
>  drivers/cpufreq/sparc-us2e-cpufreq.c                                 |  =
 2 +-
>  drivers/cpufreq/sparc-us3-cpufreq.c                                  |  =
 2 +-
>  12 files changed, 344 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/airoha,en75=
81-cpufreq.yaml
>  create mode 100644 drivers/cpufreq/airoha-cpufreq.c
>
> --

Pulled and added to linux-pm.git/linux-next, thanks!


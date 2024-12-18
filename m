Return-Path: <linux-pm+bounces-19431-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D534A9F68F6
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 15:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7E91894684
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 14:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46842199EA1;
	Wed, 18 Dec 2024 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RL9oXWp9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213AF156238
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734533200; cv=none; b=LtAKSzbDW6BMOyvv21fbx5DXg12B2DS77pJeHVw1W0YoxRCz6b1yNeSef2aV/oAdXaftEwhTirXtYCTWLm19NKHaRHb06mzekLpfAuP04RMbGQzZcLF//ugU3wFeNxJN71qv1UfDNugX6L4U31Lgn7qag1xRwMFMkBCSa+sENoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734533200; c=relaxed/simple;
	bh=9TdYA+hgHTEMQMU0wxaKjX3yEuRr6+3EVyLcSqPcMgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSYb8cEDwjsZPBf6bge3+poHqDZC/RrzKlmn4pdy/+dLeyUMZMbgkjkJwAOTsqXSuER9hdcHnG1AfZTysI90XkNghAzdgXmACHUDPZddVzoyzxWJHS/uCbY4nZ5atz4IWv0SZ1aagb0b+bkTSfPAoyoUA70bOVb0KKdE2b9s5ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RL9oXWp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10FAC4CECD
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 14:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734533199;
	bh=9TdYA+hgHTEMQMU0wxaKjX3yEuRr6+3EVyLcSqPcMgI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RL9oXWp9BCWcY9t31V5OY8SKn5x+wzu+m1hILlv6RwDo/h+sB2f1j64jaBzNRP/gs
	 SUvfV8c6Grw6cgKstOXlLSNQ1EG72IzBMX+Bvalv1I9hY1rE/CG/bA+ybMwOYUeauS
	 i7NPkRPSiv4BcmMn0wauB3sEANt9fJvc0kW5Zea+36r1woYb2Pc7bEeJvfE4RhYIiq
	 iWQUeK3b9NgdIsvA1geinOh/uOzwJsrXVcTn+2NjpBRKKi7VAFPGX7PuxjOV7TX4gK
	 KDZixhV0gICniudKtwCw5ZaK2vefn3W3/APZqDbHEkfpNQqyg+je4HrSOKUb/XZPg3
	 MByeZt6YyQoug==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3ebb2d8dac4so2611330b6e.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 06:46:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWgiMJqaqTUVO9cxTudaxU1XNnkAsPMh8tlA5J6hsNDyMQlm0VhzfR1/rJDkIU7Nmc8EJM91y/EYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzehKBNuKoahxBgup+RqsBs6kotnpGSmqviNFPIuFl39Gf+BuM5
	RCPIFMN9CFdYmjwLpcDrq5/llNsoWGHyTmXQEtGPSPJ7yUy0BT1o/DOSvZoYP1xLsPbwGsJi2v6
	u3ahfiAHn2FzMqnf8meAsCPSt55k=
X-Google-Smtp-Source: AGHT+IH6z4i2ZF2jNVtZKxptuhBLiDRtPDhnOcbx0awt+Y5OSWk8gLf7ZXMDxlc3pXZeEHPtZO/BUHpxn/Fc8WUPT2M=
X-Received: by 2002:a05:6808:2183:b0:3e7:9f1f:b84a with SMTP id
 5614622812f47-3eccc0d8ec5mr1776663b6e.21.1734533199009; Wed, 18 Dec 2024
 06:46:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <63f03935-a73c-45f2-b152-29d08cb300b5@amd.com>
In-Reply-To: <63f03935-a73c-45f2-b152-29d08cb300b5@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Dec 2024 15:46:27 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0je6n4V9zyS47a-RfuFVXhEjit6XhpSTTfq8=KthLkkgA@mail.gmail.com>
Message-ID: <CAJZ5v0je6n4V9zyS47a-RfuFVXhEjit6XhpSTTfq8=KthLkkgA@mail.gmail.com>
Subject: Re: amd-pstate fixes for 6.13 (12/11/24)
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 11, 2024 at 6:25=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Hi,
>
> The following changes since commit
> fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:
>
>
>
>
>
>
>
>    Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)
>
>
>
>
>
>
>
> are available in the Git repository at:
>
>
>
>
>
>
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.13-2024-12-11
>
>
>
>
>
>
> for you to fetch changes up to 2993b29b2a98f2bc9d55dfd37ef39f56a2908748:
>
>
>
>
>
>
>
>    cpufreq/amd-pstate: Use boost numerator for upper bound of
> frequencies (2024-12-10 10:17:43 -0600)
>
>
>
>
>
>
>
> ----------------------------------------------------------------
>
>
>
> Fix a problem where systems without preferred cores were
>
>
>
> misdetecting preferred cores.
>
>
>
>
>
>
>
> Fix issues with with boost numerator handling leading to
>
>
>
> inconsistently programmed CPPC max performance values.
>
>
>
>
>
>
>
> ----------------------------------------------------------------
>
>
>
> K Prateek Nayak (1):
>
>
>
>        cpufreq/amd-pstate: Detect preferred core support before driver
> registration
>
>
>
>
>
>
> Mario Limonciello (2):
>
>
>
>        cpufreq/amd-pstate: Store the boost numerator as highest perf
> again
>
>
>        cpufreq/amd-pstate: Use boost numerator for upper bound of
> frequencies
>
>
>
>
>
>
>   Documentation/admin-guide/pm/amd-pstate.rst |  4 +---
>
>
>
>   drivers/cpufreq/amd-pstate.c                | 50
> ++++++++++++++++++++++++++------------------------
>
>
>
>   2 files changed, 27 insertions(+), 27 deletions(-)

Pulled and added to linux-pm.git/fixes, sorry for the delay.

I'd suggest using the "[GIT PULL]" prefix on pull requests to reduce
the likelihood of them getting missed.

Thanks!


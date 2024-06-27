Return-Path: <linux-pm+bounces-10140-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BF591AFAB
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 21:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81805B24ADD
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 19:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1A8200DE;
	Thu, 27 Jun 2024 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fE6OiMfr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880631CFB9
	for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2024 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719516632; cv=none; b=tEJmuYL7VZb2NKqGjKo5dgGtoXUiFgavOwAMzksuuiMLCs0t/MH7i78TApf0Mf6UAOSruqxady78AclBitF3+OBNxBmhhizG/XBDJPP7aNKtjese00+b3mfcnjaEfqhp9M2GoIA6vRG4qRLpEUiJc51wf3zkDXmqyzvgV+lDyKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719516632; c=relaxed/simple;
	bh=s+wMAH3BSxFxvYUPIFCBd2sKp7raIRDY8ajnbhVZMOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FrNVYqgj2dxYKBZqlrc3CmSexTzkhOsIasa6UjAuG2+faNAszgwlPjsQuGjBfBfSPVMYZDxSCm3xwYEoxwjvEK3qfBDp2Js724I2pTavUdVrTE7cTTFYsdtuuOjzhqOUOgG91VWfXIPUPKqOyMr+4vzGOpEX7/MWlZybo/BiVuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fE6OiMfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1061EC2BD10
	for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2024 19:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719516632;
	bh=s+wMAH3BSxFxvYUPIFCBd2sKp7raIRDY8ajnbhVZMOY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fE6OiMfr7wpc9nv9/hCh6Jrjqo9UqwV4Ohjb9QeJADQhcfCRdsyPexZcnUbn5B4eY
	 VJL/J5Q/F6Fl5y2NrsVS2NLMQZLbujNBtnj9WlXK0VHf+bIWsSXoBcSNRY52Iz5kbs
	 f+M1CppM1d8TkQZ+DN9sakxvqOIqU+l7rwe4PyShIoosKVMYa5DywM0L04h+wdNjF7
	 RtrdD/J7F89wdMyrZXYdeBy5MOTGnVHGkBQ2UnMEHVgbNxFVfON02uSYtNYdIF/ImU
	 WcCuBCyw9SjpimHPGVS9EEbr97cRVsocSjSqrDHyn4PcQjceVsHzAClU0ym9Fy+GAX
	 vjZqzMry2PdDA==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5c2256e52f3so118479eaf.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2024 12:30:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXLGVoVhPigY55xCytt+zRzhyZpDWBqSCOCpOLs74kCzuuChCj47DFrgXKyHfPk3L5P/ro++ISkSoArFsbBCseeO5VF/REOVrU=
X-Gm-Message-State: AOJu0YyKIEm+tGPDVaoMsCG7hKLzsyeiaGmI9gNyg+49+ZG1qLgpJ9YT
	j5ousjrwCN+ygPPTofujNGsTCAwM54Mw4/ucLlsAaIhpElGV/WCmh8j4grUagwpJw/iFoFZFm2f
	4Bf8QY5nXY5dTgCwwikDdDsMTXk0=
X-Google-Smtp-Source: AGHT+IFN4G2m39zSfuklRJbqCJ1cwM5LnZWS931kyvwmL8Qa7AhMJsiHo/yGUj25E5ci/YD2POUfdPbiBZnufxZ4COQ=
X-Received: by 2002:a4a:c186:0:b0:5c2:25cb:e6c6 with SMTP id
 006d021491bc7-5c225cbe811mr4957924eaf.0.1719516631344; Thu, 27 Jun 2024
 12:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <56258f5f-c529-4f91-b0a6-09f233174e1f@amd.com>
In-Reply-To: <56258f5f-c529-4f91-b0a6-09f233174e1f@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Jun 2024 21:30:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0izHJZJhBAqB14An51zdi-5L4rDV4=Gkw7uf6nH4C2=eA@mail.gmail.com>
Message-ID: <CAJZ5v0izHJZJhBAqB14An51zdi-5L4rDV4=Gkw7uf6nH4C2=eA@mail.gmail.com>
Subject: Re: 3rd amd-pstate pull request for 6.11
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 10:53=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The following changes since commit 2240d3e60bb3e7a00422596412d012aeb54c15=
73:
>
>    cpufreq: simplify boolean parsing with kstrtobool in store function
> (2024-06-24 16:16:16 -0500)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.11-2024-06-26
>
> for you to fetch changes up to 6d588891a90c5a946aaac11a93d06edd89ed9054:
>
>    Documentation: cpufreq: amd-pstate: update doc for Per CPU boost
> control method (2024-06-26 15:48:21 -0500)
>
> ----------------------------------------------------------------
> Add support for amd-pstate core performance boost support which
> allows controlling which CPU cores can operate above nominal
> frequencies for short periods of time.
>
> ----------------------------------------------------------------
> Perry Yuan (4):
>        cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
>        cpufreq: amd-pstate: initialize core precision boost state
>        cpufreq: amd-pstate: Cap the CPPC.max_perf to nominal_perf if CPB
> is off
>        Documentation: cpufreq: amd-pstate: update doc for Per CPU boost
> control method
>
>   Documentation/admin-guide/pm/amd-pstate.rst |  16 ++++++++++++
>   arch/x86/include/asm/msr-index.h            |   2 ++
>   drivers/cpufreq/acpi-cpufreq.c              |   2 --
>   drivers/cpufreq/amd-pstate.c                | 122
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-=
---------------
>   drivers/cpufreq/amd-pstate.h                |   1 +
>   5 files changed, 119 insertions(+), 24 deletions(-)

Pulled and added to the linux-next branch in linux-pm.git, thanks!


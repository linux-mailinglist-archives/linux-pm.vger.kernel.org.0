Return-Path: <linux-pm+bounces-31189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74147B0C194
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 12:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2640B1781D6
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 10:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306FB290BD5;
	Mon, 21 Jul 2025 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nx4hG4Ak"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB32290BA2
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753094567; cv=none; b=OMQVfaQY2iVxCzZjq1KyJQuEdjG+eTv673r+aMxILBg/odXVk/4rPTF73qzqknhX5gmVPSa73OjiP6kX0/iPwAF7ItghIJvp4T9C576SKA+Snm/BZ2LnPdieXgPlW2KyulJunobKeXuzRV6xZVhuOdeIvVCyL0HAzBU0YcHjlDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753094567; c=relaxed/simple;
	bh=cBuSKvFtSWNzuV0Y9OjjXQ1AX1Agr8CHdNXlVTOY4FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZcPcIDJgVXuY3mcEs31RQ1O8yVnxoy/ftOS1cNwBGHn8SE1jKHbSzaE+JuIee7e/FFDXh7S9S5uFzTLVrnc4/9vgQzxH3Zsafx2l8I5poUKQ7QLVBVS9hsaxwm8RwJSX9qdA5X/h34vrLrg+vk716ZbZJ32ZepolRyel4VQ4j6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nx4hG4Ak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94204C4CEED
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 10:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753094566;
	bh=cBuSKvFtSWNzuV0Y9OjjXQ1AX1Agr8CHdNXlVTOY4FM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Nx4hG4AkmnpPLEAegRiNSNn4+wuPS2Idrk4Y48MGTvG9Ida5zi4fT1l/EFxh2ItqA
	 y8ekNCJcznohdr0AuyLOvWANRda7iuLhKg8+tci+vdLZKyRPqybtikiNWbSEzQPd2+
	 XBGQKYKEKJuEBXBUwDiTlKNtgVo5uVDuyZ4oDJ/A9mYMKboIrRuk+Am3vWABdiEZhK
	 m0hkOepbI7WHuCrFVmcRkr/YRNebh9jJN8UBvZIuTykyc4ypkp+4Rzuex/l8TTqcbJ
	 6KJPWLQEG352VSnaLnQ1jDWUGwuURQQpbXwQjIRBE6q3puCwt/JcgqcL1iGKeczLaY
	 /WLWe4NgU1Gqg==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-615a007e2easo2087174eaf.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 03:42:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXYC6OdA5ZmbyNzI1vKMzZzr+aRjRl/kpuLwN53dNdME+6sNv5H9Fe9f4w7OrBjWnz+hZ6RTnUAUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsTvgwsJSB4Yp/PCYt2hPwdnZUQx+lDt32z1WugcYn3+6j3DNH
	bQQ25MWLrCsqBH+ZWWyApK1532iZ5pwUY1Vu+i8s/pkdM+DxSzYwe1qsi/EOMONvMzKtYibRfW6
	Lai2VYkwMhxj43UObuguRV1ida0nC3DI=
X-Google-Smtp-Source: AGHT+IHSbroiAK1TmZL0BwmUiVaSjEl3+538zhtzXH211VIJOuF7qaZB8aUAcBHqa3iKZv/mDus+cSrP/Cgs79SaQ8U=
X-Received: by 2002:a05:6820:4c0e:b0:615:e20a:64cd with SMTP id
 006d021491bc7-615e20a681bmr2162864eaf.7.1753094565843; Mon, 21 Jul 2025
 03:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721075138.nibnp2nje6vlcdq5@vireshk-i7>
In-Reply-To: <20250721075138.nibnp2nje6vlcdq5@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Jul 2025 12:42:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gyjKz83yuRasApmpkEMg78+XvDy-ib=an07C2P6QwjaQ@mail.gmail.com>
X-Gm-Features: Ac12FXzbjnLcKz9uXMFbmiRiArAxKY1_a6q6n05BPawCQVkUZ3NYa1ezk544zsI
Message-ID: <CAJZ5v0gyjKz83yuRasApmpkEMg78+XvDy-ib=an07C2P6QwjaQ@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 6.17
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 9:51=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e326=
7e:
>
>   Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-u=
pdates-6.17
>
> for you to fetch changes up to 22679d807dea5c065d8019acfce48f20e87ba5ca:
>
>   rust: opp: use c_* types via kernel prelude (2025-06-23 09:52:45 +0530)
>
> ----------------------------------------------------------------
> OPP Updates for 6.17
>
> - Minor cleanup in Rust bindings (Abhinav Ananthu).
>
> ----------------------------------------------------------------
> Abhinav Ananthu (1):
>       rust: opp: use c_* types via kernel prelude
>
>  rust/kernel/opp.rs | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> --

Pulled, thanks!


Return-Path: <linux-pm+bounces-9758-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C44912629
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 14:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BBE11F26102
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 12:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AF8153819;
	Fri, 21 Jun 2024 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVc2KrM8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1D9152E0A;
	Fri, 21 Jun 2024 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718974748; cv=none; b=qo/lm4HFjXIKBaECz6IFVmVXdrvFezWJrV2xRh8bU6Zxk/CFnQsAqrb9EFO0PopU1V8JWdX3ejsTKBccNazMxHIiB+HY7JZGkc+oyOLITvzqBCIbBDiyXjFb3Aqht8/4MXtJsMLpGL1M352tgPQZtt++LU30lRr7J7BcHJWSu24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718974748; c=relaxed/simple;
	bh=djYOMocjjWNBveqmvAKKXAXxAFrO1ciKaKoGXj5nprQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNxAMQNYaCpbDJdYgP2XeNdDCNRx8Vo4lR1IOz2rxnYmdQXEAGMDjDoVLdtiF2qDbmj2U6MIllj9jcFvEtsKV7Hyj521xT+fBF7AMcqGZuwB6c+DxZyea32dgZ8xysAUvWcDU7g3IkGBni9nVhk0I2di04S6JGIaG9NOl5HpCHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVc2KrM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B24CC3277B;
	Fri, 21 Jun 2024 12:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718974748;
	bh=djYOMocjjWNBveqmvAKKXAXxAFrO1ciKaKoGXj5nprQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NVc2KrM8ob6oczSMQDtFNtqeab/9ni/gHHCyBWZFDSWe6A+XsPgi4J66arGPY5Fm+
	 zx/AB4IpzxmTUOc67jSMOIalL0i0eoZi4r791AFj6ufCVkgtRMfUK4OnKCkRNx/hKx
	 Tnx/c8DLxhzMDowaa8337hZl8mBEoVBqW8T4RZv9aFmmM5N4Qxjx9shqIDOWX2oxk0
	 CUKBzbE5Im4ISu7UP8qNuEbuZf7UJpCbE72TR284bDgQafsg8qUO/tRbq45ikVC4Xp
	 UwX/zLA4arpgsP09jhn051EkM4g8zjk5BtHUZe50kggCbNSc0e8XXLk4icHKaWIW2P
	 khU5NuRIy3VSw==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25cb022c0e6so184810fac.0;
        Fri, 21 Jun 2024 05:59:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWt4A1EmAEeZ+lIBPfLXDMONM8MrHASzrVnB2UBKdNJfWccwjQ8e5BmiWevfssWrtxfdRAA4BudpolKVmKnztiBkQ0ONMwInNvSA1BbcBL2K26mznCXjXMCApFRP/KlurLDMwWcBVo=
X-Gm-Message-State: AOJu0YzZAHrVvFfccEdv+bLFPluwVQFK0vyCMMI751tn3WiDL1q9NfJp
	a+n5s0y+bOgzBLHlK6Bs4xji6Urik97Fi+Z+KBiZEZJgzwq1LzRRxbACO74tXCMVgWVOmp7e6i6
	xgtJZ/AmBUVMPU/rEc17LTxdboY0=
X-Google-Smtp-Source: AGHT+IFGwJsHzxOweSVoXguQ2BIT8PLQGsRfSemN0wxVR84863+zhFST8MDeWO8jOwvn8+o5Jt8pNihX2VxKeeR3ylE=
X-Received: by 2002:a05:6808:189e:b0:3d2:3bc2:71b2 with SMTP id
 5614622812f47-3d51b7c6ee6mr8900820b6e.0.1718974747301; Fri, 21 Jun 2024
 05:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240616124025.16477-1-atulpant.linux@gmail.com>
In-Reply-To: <20240616124025.16477-1-atulpant.linux@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 Jun 2024 14:58:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jYUt-qieii+BG0turTn0h+FvA-6U4zeiEkAqV0uGKn7Q@mail.gmail.com>
Message-ID: <CAJZ5v0jYUt-qieii+BG0turTn0h+FvA-6U4zeiEkAqV0uGKn7Q@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: governors: Fixes a typo in a comment
To: Atul Kumar Pant <atulpant.linux@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 2:40=E2=80=AFPM Atul Kumar Pant
<atulpant.linux@gmail.com> wrote:
>
> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> ---
>  drivers/cpuidle/governors/teo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/=
teo.c
> index 7244f71c5..95831d2a5 100644
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -592,7 +592,7 @@ static int teo_select(struct cpuidle_driver *drv, str=
uct cpuidle_device *dev,
>         cpu_data->sleep_length_ns =3D duration_ns;
>
>         /*
> -        * If the closest expected timer is before the terget residency o=
f the
> +        * If the closest expected timer is before the target residency o=
f the
>          * candidate state, a shallower one needs to be found.
>          */
>         if (drv->states[idx].target_residency_ns > duration_ns) {
> --

Applied as 6.11 material (with a changelog), thanks!


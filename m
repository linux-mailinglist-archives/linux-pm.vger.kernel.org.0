Return-Path: <linux-pm+bounces-10294-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3263891E625
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 19:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6242E1C21BDA
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 17:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B6B16D31E;
	Mon,  1 Jul 2024 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukJ1XLye"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B31014AD25;
	Mon,  1 Jul 2024 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719853352; cv=none; b=qPd9V2JqaSIwOL/H6xhHz5FOPm1gBNfxu/2vokwKa71q2MesV9bLQjmI9+JomEp+AiQ3alWnEDw72/I9vIrKtNQ8jhsZxmB2rLWqdynIJMZf50QZz0uRSnLcC7TNkn5SyK2asVZq2F4lACyT40UMiyzhUH8mUvmmCEmjDCyCFZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719853352; c=relaxed/simple;
	bh=rrZg9Pb0++jARgOgd/Z0l3VmYE7RR9w+0Gh7JqwfciA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPgHppmyyLYIxInRnZuXDBcoqaiUf9pKhoZN1ROWIuqbL9gaEPdmNyb0rj/arVsrEsjMi3ZWsYzfMSDp3Jed8oKyAAZXH4C/7QTP1A+st/gigegpeShff4KpbOYlMQEyrEerbCIKfR2HFq2yMkccQXLte9UEEGDGKp+oDQpu074=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukJ1XLye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250B5C4AF12;
	Mon,  1 Jul 2024 17:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719853352;
	bh=rrZg9Pb0++jARgOgd/Z0l3VmYE7RR9w+0Gh7JqwfciA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ukJ1XLyeOU7dxCB49i0ennHAaVa1jJTryhFOGA+E8Nere57bzHshRUNzzdezWqB1w
	 oW9gtcr8NPmhf+eYmD0PztlGnOihLVLIUbkTZs2Syu6FHAnDWqp6na+67mSsRtY4Jl
	 dkeOummBLEWEi3FKYBFmei747ke6iObMkO3PyR+zSstsmpRFjGeOBLScJc/0LdE5ki
	 hWuznYaexvRgB04gAFoo0NS9M0DZdxjm6VRwHjpqpVPnSxjjF1znzSFtRVPQYT87Hg
	 1V+iYtEJqGUNypGYdO75dJc2nR+Gnc2S6uwHjQTJN0Cssuk+s0a7/UbjhTjJK7Uzvo
	 6U3N39uZo2pCQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-25989f87e20so504939fac.1;
        Mon, 01 Jul 2024 10:02:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVc3RyDe9B2GkUXOZKAZElHzsAFnNYk2U0sbkikOCGRM83fIwQXDGcGEz9NeHKBqwx3yZHDsqCx7I0+fvwg43p1YrdjdoY2+oT8RZcCQFwJemBUV/s0PpOKvM1bo5Sn09K72R00cD8=
X-Gm-Message-State: AOJu0Yxm5PD8BqWut5NsjdAqcRPKzD3mCZvR1H7VL/9x7IuJKZ5Fwq3P
	OkhcZ7js4TCHVWPapknJTXge0gnR/qokmVWM269faPxznDQES+La3OHMCZFyylkXcBmewNdff42
	PMFsH9g9GSJeZsY0tCjgo0DJhpm0=
X-Google-Smtp-Source: AGHT+IEJpZmbqEHO1Bh+OEp3LPFinKMG1IadW16uX8PwTkV1l2Yyvu7JRQgOww++E+3PBknGG60nkJTheF+JVlO6A5A=
X-Received: by 2002:a05:6870:4195:b0:25d:d69:eaf with SMTP id
 586e51a60fabf-25db36406d0mr6091618fac.4.1719853351316; Mon, 01 Jul 2024
 10:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628091456.57301-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20240628091456.57301-1-yang.lee@linux.alibaba.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jul 2024 19:02:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h1OZ1=x3Evfkdb90oHML_KOALS9FmPW+jk-o7udOY-yQ@mail.gmail.com>
Message-ID: <CAJZ5v0h1OZ1=x3Evfkdb90oHML_KOALS9FmPW+jk-o7udOY-yQ@mail.gmail.com>
Subject: Re: [PATCH -next] mm/treewide: Add missing kernel-doc function comments.
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: mingo@redhat.com, rafael@kernel.org, tglx@linutronix.de, pavel@ucw.cz, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 11:15=E2=80=AFAM Yang Li <yang.lee@linux.alibaba.co=
m> wrote:
>
> Add kernel-doc style comments for the pfn_is_nosave and
> arch_hibernation_header_save functions.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D9453
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  arch/x86/power/hibernate.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
> index 5b81d19cd114..90f682ff63b1 100644
> --- a/arch/x86/power/hibernate.c
> +++ b/arch/x86/power/hibernate.c
> @@ -41,7 +41,8 @@ unsigned long temp_pgt __visible;
>  unsigned long relocated_restore_code __visible;
>
>  /**
> - *     pfn_is_nosave - check if given pfn is in the 'nosave' section
> + * pfn_is_nosave - check if given pfn is in the 'nosave' section
> + * @pfn: The Page Frame Number to check

This is fine.

>   */
>  int pfn_is_nosave(unsigned long pfn)
>  {
> @@ -84,9 +85,11 @@ static inline u32 compute_e820_crc32(struct e820_table=
 *table)
>  #endif
>
>  /**
> - *     arch_hibernation_header_save - populate the architecture specific=
 part
> - *             of a hibernation image header
> - *     @addr: address to save the data at
> + * arch_hibernation_header_save - populate the architecture specific par=
t
> + * of a hibernation image header

But this is not.

If you take the time to clean this up, please rephrase this so it fits
into one line.

> + * @addr: address to save the data at
> + * @max_size: the maximum size of the data to save
> + *
>   */
>  int arch_hibernation_header_save(void *addr, unsigned int max_size)
>  {
> --
> 2.20.1.7.g153144c
>
>


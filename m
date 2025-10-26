Return-Path: <linux-pm+bounces-36844-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61504C0A86C
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 14:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04CC14E10CA
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 13:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5C021CC56;
	Sun, 26 Oct 2025 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9vccQCZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8999A1E487
	for <linux-pm@vger.kernel.org>; Sun, 26 Oct 2025 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761483943; cv=none; b=KA9giDJLZmEzICbQ1q0tWT07jO3k0tSRL5PdqXyk9lESMvFRhjWWWn5273PzLdA870DAObjeccSXp4vFz9xAnfRYcfbOHwjYoqw4Rk/uyafjubnm30RrkKXCp4zbZVgR+LqLNmWYoHeeMhsGQy4CXvwgDpi3/E8eupcmVpZXOBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761483943; c=relaxed/simple;
	bh=0HLmai/3AND1bebak7evHRyrS3T5IrE5p46YRKrpJXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmqUA16xXhApTsfSk7GuXOVrG7mGSq4rg4SjUiMR6MI2WItdaCPeHXn7s5puJ8m1M31mcKqCuQnL7TRV/2pgNJ0pCm5TxQ0KSF4wjm85hzN9XWEPl4OUpEj/METnegZGuf0drlwh2JEenDdTKqZwu1Z0ra7sEZBqUS4wXeJ3ZvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9vccQCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014DDC4CEF1
	for <linux-pm@vger.kernel.org>; Sun, 26 Oct 2025 13:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761483943;
	bh=0HLmai/3AND1bebak7evHRyrS3T5IrE5p46YRKrpJXo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c9vccQCZiwAa8l7okYXBlu72WbMQBc6Fp1XM/U/Zv6VYVYpgMgjJfpkYlQTEN0j/g
	 fT9er0WvkFLqaAb4+LravzNaD2M/G3yXtVXqVF88MOcaLes7XzAG2wAOEjyqvAfugz
	 4KbOBGcOYKzvYBYJQShDts4roupQ3gfCVVbhk/v/KN+vZDOZiEiQ74dLFiDvWAgwCC
	 YXc5rcVfkhGXwBcsVzI0jm0DxSpypZ6iLTvnFgM2pJQPc8MM9P84zkW2F5sZQxkPdC
	 t2DWL7X1o3JaHSO31nUz9xKYcfA7EPzdeGR5PiLbtApb9X/IKfbVY3URvWb9MReio7
	 uHaCZP20/SXlA==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-651c743b2d9so1935392eaf.3
        for <linux-pm@vger.kernel.org>; Sun, 26 Oct 2025 06:05:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVdm2pr5UX1rwx0Gvntq+OsXulFmExcAyiQ8n6SpnBK9dKFtPXdej/NpKLGkh7LIabAdRST/v2Bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyTLYyItfk45lV8DB9KtviTEy+aG9bn7RU34ALrGb2iVMFQ2CC
	DmLU9y1EwI/pcMfxvnm2C4cqNzwbi6RmbyK33+FfJiA3n+YxF/w2wcvVAyi8lrtYnKwlB1aETb+
	K4rBmT8pTC5Tlh3pOxe184x0xvq3tMTs=
X-Google-Smtp-Source: AGHT+IHC5JJMdx2g+m4NDtTzZlycNzrptZxdNGhkllPEAJ93ySk2afTcZPUTZWEiu6XEDVsPMhRqJe6s52KeGRy7rDw=
X-Received: by 2002:a05:6820:4b8f:b0:651:c8cc:8650 with SMTP id
 006d021491bc7-654d7f5c6fbmr4804130eaf.2.1761483942328; Sun, 26 Oct 2025
 06:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026033115.436448-1-superm1@kernel.org>
In-Reply-To: <20251026033115.436448-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 26 Oct 2025 14:05:25 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j-cNA4AiMSM8GCQPwVWYk5eb4cLV+snGbuGtuLWjB-vw@mail.gmail.com>
X-Gm-Features: AWmQ_bkMPcxNCgmr_plJytZfac542PYqdddy6zy7Eh_5PaEsjY4SeDPURHDEL-8
Message-ID: <CAJZ5v0j-cNA4AiMSM8GCQPwVWYk5eb4cLV+snGbuGtuLWjB-vw@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Restore GFP mask in power_down() for HIBERNATION_PLATFORM
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, rafael@kernel.org, lenb@kernel.org, 
	pavel@kernel.org, Askar Safin <safinaskar@gmail.com>, rafael.j.wysocki@intel.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 4:31=E2=80=AFAM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> commit 449c9c02537a1 ("PM: hibernate: Restrict GFP mask in
> hibernation_snapshot()") added a restrict GFP mask call that leads to
> mismatch when using the platform for hibernation.  As part of calling
> hibernation_platform_enter() the mask will be restricted when calling
> dpm_suspend_start().
>
> This is a similar problem as occurred with hybrid sleep that was fixed
> by commit 469d80a3712c6 ("PM: hibernate: Fix hybrid-sleep").
>
> Restore GFP maks as part of power_down() in HIBERNATION_PLATFORM case
> to fix the mismatch.
>
> Reported-by: Askar Safin <safinaskar@gmail.com>
> Closes: https://lore.kernel.org/linux-pm/20251025050812.421905-1-safinask=
ar@gmail.com/
> Fixes: 449c9c02537a1 ("PM: hibernate: Restrict GFP mask in hibernation_sn=
apshot()")
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  kernel/power/hibernate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 14e85ff235512..e15907f28c4cd 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -721,6 +721,7 @@ static void power_down(void)
>                 kernel_restart(NULL);
>                 break;
>         case HIBERNATION_PLATFORM:
> +               pm_restore_gfp_mask();
>                 error =3D hibernation_platform_enter();
>                 if (error =3D=3D -EAGAIN || error =3D=3D -EBUSY) {
>                         events_check_enabled =3D false;
> --

Applied as 6.18-rc material, thanks!


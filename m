Return-Path: <linux-pm+bounces-31029-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F240B093F6
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 20:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD7B5A3BE1
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 18:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A072D1B394F;
	Thu, 17 Jul 2025 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyEUPyjG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7602FCA4B;
	Thu, 17 Jul 2025 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777158; cv=none; b=L/dp1B0aJNBmC/uANL4ff88Af2rsP+cWqzJmeKJUH8cdGUJ/KqogZvFClesPbJEjfz2VpuH06IMx3PAaYJIJZmw9g7fiQ1Y4U2SeyP5EGWkpckOC1jchDntzh04i2Pjme/ANqOScj0yPRH8rReHC0qYt1L4vAd5eRYURu+zn/Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777158; c=relaxed/simple;
	bh=6DwbyGB3LVxrMlrjrJxXjPghbn2x3+WSQ8z97rK1OMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVwxvO42Diy9CkGkR+xmJeOsyl3q8CLU2Ea7RDdPiOGXCPnFDaZOgpWLfqZ6+mRBRgqjBS/iH5bML0JxUC7lEvaQx7tAkqWRuXLsuwqUlqOc/xkyibLMfz/9QX5rbHwnpaDH84tYaaE12ibL5k941ATEyg6muaJ+Ei3tMwtTci4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyEUPyjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC0DC4CEE3;
	Thu, 17 Jul 2025 18:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752777158;
	bh=6DwbyGB3LVxrMlrjrJxXjPghbn2x3+WSQ8z97rK1OMU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CyEUPyjGk0Fe3uSoKoSe+6kgt3x6r1AWZElkNLklmKK3hIfX3ApQpkDQWZqy6YIFK
	 vrfEPBHvHVV5UOr3oiO09OJhT32PWlaEpWY5N7P1fM1spajykcs9et99YCQ/dSK3SN
	 uGorMKBlc+JnsbDBHXcm/OR7EZmnpylKkNRirZ33f+B9cRYA7fFcCdc1LEfYvrG8FW
	 2iIMDD/hcbus1p0MR7hp1oEL73g03PjqOQrQFQaqcYwvnKu422YJnwilUiPgZZVhRa
	 3y3ppJD6WGZcHU54C8ae97iuU0WvOqcjHDFQ4Is+nOqFprKvUGw+lrw47ajY3k9xEm
	 UuWGI0A+h7YGw==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-615950642d9so628169eaf.1;
        Thu, 17 Jul 2025 11:32:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtZ8d/eXqb7RwcTh3DtKdP3yGKbW1pelL9WhBetdIPAq7cqATV3Nn4AL1HKYb03yvh1n2Z1u0jtoQicV8=@vger.kernel.org, AJvYcCVOYfh8zzdQ2cfmrp51Xhk8hEFj8z2fQAuzMLFyK9FfL3PZoIsa6PwC9SJDuw+FM4ywV0/aFymkOqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2vKicFh4GKyGB3I5ko7fgMxIiq5csAzqnrzXahGQL2rqgxU8u
	PyHat6A+cBfivifonPZRlE9UyTju6IHl1HT2kfCkEo+Y8u99OmCx9CuUnFBjqPEW7JYTg8mgSPM
	KN2DEFnVr8o8IkBHiXzOWPg7rJKz+aO8=
X-Google-Smtp-Source: AGHT+IHE947K1+CKtFh2eCiuCgmKR3YCzUkmd1ovTysn+nHuSZy48tTIBHtDdiBC7wWl2Bb6TyFZFhB9Oec3LmVbR40=
X-Received: by 2002:a4a:edcc:0:b0:615:9673:ab6c with SMTP id
 006d021491bc7-615a1ee0386mr6072101eaf.1.1752777157387; Thu, 17 Jul 2025
 11:32:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716124216.64329-1-darshanrathod475@gmail.com>
In-Reply-To: <20250716124216.64329-1-darshanrathod475@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Jul 2025 20:32:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i3XNyyK+4ZnGOj54LiCvnd_Zz+xVr+cKpWoJRLETBO6w@mail.gmail.com>
X-Gm-Features: Ac12FXwhzBeGTImQ9hlr9sDOzZiSRRitcTJ7dkTUhXrv-X7z2Yp6WxfmyY0MSGU
Message-ID: <CAJZ5v0i3XNyyK+4ZnGOj54LiCvnd_Zz+xVr+cKpWoJRLETBO6w@mail.gmail.com>
Subject: Re: [PATCH] power: snapshot: Fix coding style issues
To: Darshan Rathod <darshanrathod475@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 2:42=E2=80=AFPM Darshan Rathod
<darshanrathod475@gmail.com> wrote:
>
> Clean up various coding style violations in snapshot.c identified by
> checkpatch.pl.
>
> - Add a space after control flow keywords (for, if).
> - Correct indentation from spaces to tabs for a variable declaration.
>
> These changes have no functional impact and improve compliance with the
> Linux Kernel Coding Style.
>
> Signed-off-by: Darshan Rathod <darshanrathod475@gmail.com>
> ---
>  kernel/power/snapshot.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 2af36cfe35cd..501df0676a61 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1536,7 +1536,7 @@ static unsigned long copy_data_pages(struct memory_=
bitmap *copy_bm,
>         memory_bm_position_reset(orig_bm);
>         memory_bm_position_reset(copy_bm);
>         copy_pfn =3D memory_bm_next_pfn(copy_bm);
> -       for(;;) {
> +       for (;;) {
>                 pfn =3D memory_bm_next_pfn(orig_bm);
>                 if (unlikely(pfn =3D=3D BM_END_OF_MAP))
>                         break;
> @@ -2161,13 +2161,13 @@ static const char *check_image_kernel(struct swsu=
sp_info *info)
>  {
>         if (info->version_code !=3D LINUX_VERSION_CODE)
>                 return "kernel version";
> -       if (strcmp(info->uts.sysname,init_utsname()->sysname))
> +       if (strcmp(info->uts.sysname, init_utsname()->sysname))
>                 return "system type";
> -       if (strcmp(info->uts.release,init_utsname()->release))
> +       if (strcmp(info->uts.release, init_utsname()->release))
>                 return "kernel release";
> -       if (strcmp(info->uts.version,init_utsname()->version))
> +       if (strcmp(info->uts.version, init_utsname()->version))
>                 return "version";
> -       if (strcmp(info->uts.machine,init_utsname()->machine))
> +       if (strcmp(info->uts.machine, init_utsname()->machine))
>                 return "machine";
>         return NULL;
>  }
> @@ -2361,7 +2361,7 @@ static int unpack_orig_pfns(unsigned long *buf, str=
uct memory_bitmap *bm,
>                 struct memory_bitmap *zero_bm)
>  {
>         unsigned long decoded_pfn;
> -        bool zero;
> +       bool zero;
>         int j;
>
>         for (j =3D 0; j < PAGE_SIZE / sizeof(long); j++) {
> --

Applied (with rewritten subject and changelog) as 6.17 material, thanks!


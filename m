Return-Path: <linux-pm+bounces-37056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDEAC1BFF0
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 17:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B751882791
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 16:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA5B281525;
	Wed, 29 Oct 2025 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxILBQOw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680891F7575
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754216; cv=none; b=unF/tpESwHq9t/Fwg2JuGxgflh+UA6jFB/yqEd+xtZa3wrvK3bjkIfbH3PoseEat57i8rUQkjapYWpAxn1GQ61XkseQ1ufapO83Vj3WD4h+SCNcbYqn+8UPwMIYjkbolsc4wtdb97sWwaFL244LHFksqoY/YYNJUVGyAplFfv3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754216; c=relaxed/simple;
	bh=bhppgf5z3TwuEAo+4Rr4KhZs8ynqvre+y0Ii9tlE860=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZwTvouLY7ozNJ7qglps+DfWCQd0Xed12FaA8EJpGJaKbXe1PN0gxnPbA6ZO8rkPaHDxLWtx7LunplWp2tDb8NfTa/nx0i/ECdSqe5v/gHqmCmT7nneuMlFaytCHWlfv0IHqPNsWzVntPeMQc1nolV3sfnuw9C+UNWkREO9U96M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxILBQOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82C2C4CEF7
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 16:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761754215;
	bh=bhppgf5z3TwuEAo+4Rr4KhZs8ynqvre+y0Ii9tlE860=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nxILBQOwX3C1BaOsG9+DXkR2NEWD3lfOjqBNLQzddorhQXAJM2Xz+Ko3gDU7Ae2WM
	 y22M5oeSWTu/snuXy8989O9jqWw9aIrY4xOomv8rwtssyvThIsyY/FjWcH99/MRgtf
	 CS76C8VziuWHT3/7ZQFrkGxxHn5bXcZYmIJ7xQFYmxXPUqh8qGbjUxgyBJs/rt2pGu
	 1sj5TvreEBeT96iACWrzbCXxVZrogRHPoTar9mS9u47qyaFgS92plSRc1YiOhTG3TB
	 FLFbuVvalDTRbdr4DmSF+TMSTO4eKwZwClxL1F5HQqN6w2UnCqi4EnXW64y7Wh1USM
	 vpFczKZdN6HUA==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-65677b3aa4bso9091eaf.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 09:10:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVyXF9Go73TK2gEZNbB6m9GObp7d5xuKqcLC4jJNHIRGWrW1KAd/nVwdDZdQGvUz48EDgIr0xdlsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcjW5d7asBG+G4SNd8U34xE/d6LAvl0i2U17d7k4xs+y9KYCzZ
	leq9MEViBURZgiXNRRY1e9z4l0ONqm+6Wj87FL6035bz/tSF+3tm+z5z9O+d9zzn94znbe/NDuC
	eMpKLH1W3acrRUS63m4EAHt8cBfvtex0=
X-Google-Smtp-Source: AGHT+IF7NkBqMpSOL34v/1QYZNB5PUHiunb7vHO9g1EXUy5G8xPXdGyVeFaaFxdElb7Izfb4h8IHQ0X+jpTyyEGl9hI=
X-Received: by 2002:a05:6820:2229:b0:654:f452:45f2 with SMTP id
 006d021491bc7-65677eed247mr1738225eaf.6.1761754215202; Wed, 29 Oct 2025
 09:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029154329.3939680-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20251029154329.3939680-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Oct 2025 17:10:03 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0itwsggK1JwL8h86Pow7vLkgfg6w1TKXaR3wk6rbrfXdw@mail.gmail.com>
X-Gm-Features: AWmQ_bnTaHMVHZP-_w2l2c1JP5MwZsA6HbvID6IbG6U9r68ZPVjqIjKCgBH40Gc
Message-ID: <CAJZ5v0itwsggK1JwL8h86Pow7vLkgfg6w1TKXaR3wk6rbrfXdw@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: mrrm: Fix memory leaks and improve error handling
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: rafael@kernel.org, tony.luck@intel.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 4:45=E2=80=AFPM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> Add proper error handling and resource cleanup to prevent memory leaks
> in add_boot_memory_ranges(). The function now checks for NULL return
> from kobject_create_and_add(), uses local buffer for range names to
> avoid dynamic allocation, and implements a cleanup path that removes
> previously created sysfs groups and kobjects on failure.
>
> This prevents resource leaks when kobject creation or sysfs group
> creation fails during boot memory range initialization.
>
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
> Changes in v3:
> - Fix memory leak in success path by adding kfree(kobjs) before
>   return.
> Changes in v2:
> - Use local buffer for range names instead of kasprintf/kfree as
>   suggested in review.
>
>  drivers/acpi/acpi_mrrm.c | 43 ++++++++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
> index 47ea3ccc2142..a554f6443b4b 100644
> --- a/drivers/acpi/acpi_mrrm.c
> +++ b/drivers/acpi/acpi_mrrm.c
> @@ -149,26 +149,49 @@ ATTRIBUTE_GROUPS(memory_range);
>
>  static __init int add_boot_memory_ranges(void)
>  {
> -       struct kobject *pkobj, *kobj;
> +       struct kobject *pkobj, *kobj, **kobjs;
>         int ret =3D -EINVAL;
> -       char *name;
> +       char name[16];
> +       int i;
>
>         pkobj =3D kobject_create_and_add("memory_ranges", acpi_kobj);
> +       if (!pkobj)
> +               return -ENOMEM;
>
> -       for (int i =3D 0; i < mrrm_mem_entry_num; i++) {
> -               name =3D kasprintf(GFP_KERNEL, "range%d", i);
> -               if (!name) {
> -                       ret =3D -ENOMEM;
> -                       break;
> -               }
> +       kobjs =3D kcalloc(mrrm_mem_entry_num, sizeof(*kobjs), GFP_KERNEL)=
;
> +       if (!kobjs) {
> +               kobject_put(pkobj);
> +               return -ENOMEM;
> +       }
>
> +       for (i =3D 0; i < mrrm_mem_entry_num; i++) {
> +               snprintf(name, sizeof(name), "range%d", i);

So someone will subsequently send a patch to replace this with scnprintf().

>                 kobj =3D kobject_create_and_add(name, pkobj);
> +               if (!kobj) {
> +                       ret =3D -ENOMEM;
> +                       goto cleanup;
> +               }
>
>                 ret =3D sysfs_create_groups(kobj, memory_range_groups);
> -               if (ret)
> -                       return ret;
> +               if (ret) {
> +                       kobject_put(kobj);
> +                       goto cleanup;
> +               }
> +               kobjs[i] =3D kobj;
>         }
>
> +       kfree(kobjs);
> +       return 0;
> +
> +cleanup:
> +       for (int j =3D 0; j < i; j++) {
> +               if (kobjs[j]) {
> +                       sysfs_remove_groups(kobjs[j], memory_range_groups=
);
> +                       kobject_put(kobjs[j]);
> +               }
> +       }
> +       kfree(kobjs);
> +       kobject_put(pkobj);
>         return ret;
>  }
>
> --


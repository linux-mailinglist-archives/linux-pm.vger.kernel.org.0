Return-Path: <linux-pm+bounces-15145-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B651990377
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 15:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1F91C2112C
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 13:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5E1210196;
	Fri,  4 Oct 2024 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbMf8Q5X"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E2079F3;
	Fri,  4 Oct 2024 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047151; cv=none; b=YbBp7XPPcf9in8B7fCneV3sETvF0GB8LKvtZ8MJCWL2eOjB03GBvInsh/Xbs5mS/e1E3dTgzlm88Tyye2Vr3CEmSEKC+u6KZ+mydlhl+1wE2z1qOIzHjeW7POfGgDHSTYUaJYA66+njyKPnB6A+kLkqNtHrLmiX2AkgQLUHATik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047151; c=relaxed/simple;
	bh=EZEtQHswMoewld0YGGWf+H67wxGaKSpue9nbA4Dce4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oud6SuUrNPKWU+V4ACuS3YKlVjiqOixnNzK7Pf2VR9FeB5HwQjzMjmA6WnbVLdQZVgEyL5iItvjrUySpkfZ2qXedHvk04UISjtMWXK3INKXkgJcKxWCMzzoqQz5qVk6yQnzd81dvvdh74+mRQ/bgaPwL43TwEYBXDt3mZhZzMRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbMf8Q5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FDDC4CEC6;
	Fri,  4 Oct 2024 13:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728047151;
	bh=EZEtQHswMoewld0YGGWf+H67wxGaKSpue9nbA4Dce4M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WbMf8Q5XTTJFPy0+xZyHsE4fii0rWKqZbJoBePK/FiRVc/Hbe/kuCVUwEdTWh8pYf
	 ibTgSgCP1DgWQX6vJjj6KptIktOdQ1K+4M8wyuC/vore+X8UJDSUEZiAnvBut6CrgI
	 V1oxMcYQ7pPejgcSGWd3e3NfJFWHA00zHp5CAbpcQMaPsfCXCiXzUYajwte0pw6jsH
	 mG+tkjLJ29/z3ko+UM9o9RVAHdka62DONO0PCa4nurMsBbLzcPJJInMLDIi9g1xuAZ
	 +HQvLBa4wC1fw8CMBQSmTm+ElUvy2Gs3gxgNLmNiZBVYkZOIoMsgiXNH3ITZPzJ5Zi
	 BoAVp8Y6THsNA==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5e77c6ed928so942604eaf.0;
        Fri, 04 Oct 2024 06:05:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV87JoI327vfOnoQLFR04vkn7oZm4NK6uxivTlfZD3FVnlE9gHNYTtTBjhmTGFSKt4558C1FM2XCZ519IqnEYjAw236hg==@vger.kernel.org, AJvYcCVeQnA3TCO/dFlXAYxRQTd4P8Ng5EPzQ0vWH7k+vSWE7eOw2I7mw+S1YidtmUTR4N3zCmfBR53fZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzD5jNIHQubvm1kYTbmvpnnp+TnMX6AhkHqyjBUsL3Y2u6nyZL5
	mJvYjy11YCV3mGawxiLYwu2Oy/T4A+6Q6ApRK5D9yOnqh7wOMWovPMZxukHUZokSl4WC7OZpE6F
	LjKFQe0vWsLHp5VdARs7BnUJb7UQ=
X-Google-Smtp-Source: AGHT+IF0FbTYTZOjT0OJHv+5ndCTq15dw56nW3BVMcSCsCYwBx3XIIshrxsMR+fZuSLG01Dr6Rjt0A4XJGTxTBJUUSc=
X-Received: by 2002:a05:6820:270d:b0:5e1:e65d:5148 with SMTP id
 006d021491bc7-5e7cc0a432fmr1124750eaf.6.1728047150778; Fri, 04 Oct 2024
 06:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003202614.17181-1-hdegoede@redhat.com> <20241003202614.17181-2-hdegoede@redhat.com>
In-Reply-To: <20241003202614.17181-2-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 4 Oct 2024 15:05:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gfMc==C9xcU0-OOSjo8=L46CKAbjf4YV3EZ-6+00EVkQ@mail.gmail.com>
Message-ID: <CAJZ5v0gfMc==C9xcU0-OOSjo8=L46CKAbjf4YV3EZ-6+00EVkQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86:intel/pmc: Disable ACPI PM Timer disabling
 on Sky and Kabe Lake
To: Hans de Goede <hdegoede@redhat.com>
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, David E Box <david.e.box@intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>, 
	Todd Brandt <todd.e.brandt@intel.com>, Marek Maslanka <mmaslanka@google.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, regressions@lists.linux.dev, 
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 10:26=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> There have been multiple reports that the ACPI PM Timer disabling is
> causing Sky and Kabe Lake systems to hang on all suspend (s2idle, s3,
> hibernate) methods.

It's Kaby Lake as pointed out  by Paul.

Other than this

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> Remove the acpi_pm_tmr_ctl_offset and acpi_pm_tmr_disable_bit settings fr=
om
> spt_reg_map to disable the ACPI PM Timer disabling on Sky and Kabe Lake t=
o
> fix the hang on suspend.
>
> Fixes: e86c8186d03a ("platform/x86:intel/pmc: Enable the ACPI PM Timer to=
 be turned off when suspended")
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Closes: https://lore.kernel.org/linux-pm/18784f62-91ff-4d88-9621-6c88eb0a=
f2b5@molgen.mpg.de/
> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219346
> Cc: Marek Maslanka <mmaslanka@google.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/intel/pmc/spt.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x86/=
intel/pmc/spt.c
> index 2cd2b3c68e46..ab993a69e33e 100644
> --- a/drivers/platform/x86/intel/pmc/spt.c
> +++ b/drivers/platform/x86/intel/pmc/spt.c
> @@ -130,8 +130,6 @@ const struct pmc_reg_map spt_reg_map =3D {
>         .ppfear_buckets =3D SPT_PPFEAR_NUM_ENTRIES,
>         .pm_cfg_offset =3D SPT_PMC_PM_CFG_OFFSET,
>         .pm_read_disable_bit =3D SPT_PMC_READ_DISABLE_BIT,
> -       .acpi_pm_tmr_ctl_offset =3D SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> -       .acpi_pm_tmr_disable_bit =3D SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
>         .ltr_ignore_max =3D SPT_NUM_IP_IGN_ALLOWED,
>         .pm_vric1_offset =3D SPT_PMC_VRIC1_OFFSET,
>  };
> --
> 2.46.2
>
>


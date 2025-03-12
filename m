Return-Path: <linux-pm+bounces-23933-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D64A5E4ED
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 21:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D7516FBA9
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 20:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A41D1E5B71;
	Wed, 12 Mar 2025 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTM0JBry"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BF51DE3AF;
	Wed, 12 Mar 2025 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809848; cv=none; b=GyYwhLTsJNwHfS+RwAbtmvrjdtka7bVSH3dS7ZyqESEcnTsU7X67Jy1HB5i6oYGNuzzz390wSXI2vV/uaew+1iG6Q92lWM3nHufaHG7LYJsMBnhXMY+qf/++dAsD6IDBJKFDwxKSI0ysRA0UjHw9LaGJid1x5tzWHY5qajwDVyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809848; c=relaxed/simple;
	bh=wNuqf53XUH4jcdwH6C0CQTwH9roS7HOh4G+zIDNCoWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPdtIPNLg36rOhnwVFFgfjOY4uX6X96cllZyu7MkL51LZ5Mq7GrI1E5Vf+q+6/7pze86RM8M+DHl+L0hd6x5+NlDMp8e+vV1GE1CdtLeuwLJMinB9ONG2njxLFrhqXESehynNs3OyDi91bBPpqFoEmarQwMeek/kE2pgkTihzfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTM0JBry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CAAC4AF0B;
	Wed, 12 Mar 2025 20:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741809847;
	bh=wNuqf53XUH4jcdwH6C0CQTwH9roS7HOh4G+zIDNCoWY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mTM0JBryU0uetVVV+cwk7RbNqcopRYfM+l0hJNW5gN/n2FUMH3WrbJUg46BwC4oFQ
	 QaWGnYf9ruMYt2Txd/ekDGfWCTE+9rJmEim1uMdtmUyAYH30ZoGpvDgnA57AiqLsId
	 Dqh7H9uj7NjvccuxYS8AiydrQVBZ2bUJUr9qhyHs8rn5AHAdnpoblLYTeMrO7cXqz6
	 XsWapUqJ3R0Lljjfni/yc9JXWpMPlbD3050DTnYpAmc3I3Hrql+MdMDUHjgBtP2d+z
	 Pki02SO8oVbFTHidWYjVLh2A1U++ZNVzsodtpn8PLAln4TOxJGhqdO0HoY2QkwV2xk
	 WkCk1R/vnTnWA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2bc66e26179so139737fac.2;
        Wed, 12 Mar 2025 13:04:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVr4M7Zk0Y92U7vIxgKXsBg2UGIbQm7br4GyZD1aSxsZrC/X0w5PBL3goJiQKw0WyMADZNmD/MUHkwqOGI=@vger.kernel.org, AJvYcCVyFfDVIslNuigb+1aYPjhad+uiUPdCSPxZ28Gu36GjbGc3Ja0Dqx5tG+9owe79WjBW/1gwTAZ+GDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuiMM0WP/el1wXBlQ6rFcbcb8kxRXPyEThOr6LrylLv7UMU0Ik
	BQOTWUdvfGXF1JMel1GA1tZeAkV6pGXBDJHvAzgPn9oTBqw7zz7phAcr3bs7+CpnMb5YP9BKSUm
	ran2DxsKMCEp1jZUBwxXFC+cj10I=
X-Google-Smtp-Source: AGHT+IHnIBq7OWoc386zouTDRs+6+dYYWygUAwuAs+Djbha1sU5onLDD3P3mJ3eI3pD/3QYB5AA8rLJ87LgDqh2xxlM=
X-Received: by 2002:a05:6870:819d:b0:29e:40f8:ad9b with SMTP id
 586e51a60fabf-2c261032b54mr13605881fac.14.1741809846947; Wed, 12 Mar 2025
 13:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307021750.457600-1-linux@treblig.org>
In-Reply-To: <20250307021750.457600-1-linux@treblig.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Mar 2025 21:03:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hq-0yfinMG5=EHxqk4B=FfRvkaUuE9gjFgL9gfb35C7A@mail.gmail.com>
X-Gm-Features: AQ5f1JrBuvQ0VlvbrZwfjzKvwWZOQUy1b2v1kE99vMI3SgvUovZSS0sOza7GoPg
Message-ID: <CAJZ5v0hq-0yfinMG5=EHxqk4B=FfRvkaUuE9gjFgL9gfb35C7A@mail.gmail.com>
Subject: Re: [PATCH] drivers: base: power: Remove unused pm_generic_ wrappers
To: linux@treblig.org
Cc: rafael@kernel.org, len.brown@intel.com, pavel@kernel.org, 
	gregkh@linuxfoundation.org, dakr@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 3:18=E2=80=AFAM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> pm_generic_thaw_early() has been unused since 2016's
> commit 294f47ffd55c ("PM / Domains: Remove redundant system PM callbacks"=
)
>
> pm_generic_freeze_late() has been unused since 2019's
> commit 3cd7957e85e6 ("ACPI: PM: Simplify and fix PM domain hibernation
> callbacks")
>
> Remove them.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/base/power/generic_ops.c | 24 ------------------------
>  include/linux/pm.h               |  4 ----
>  2 files changed, 28 deletions(-)
>
> diff --git a/drivers/base/power/generic_ops.c b/drivers/base/power/generi=
c_ops.c
> index 4fa525668cb7..6502720bb564 100644
> --- a/drivers/base/power/generic_ops.c
> +++ b/drivers/base/power/generic_ops.c
> @@ -114,18 +114,6 @@ int pm_generic_freeze_noirq(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(pm_generic_freeze_noirq);
>
> -/**
> - * pm_generic_freeze_late - Generic freeze_late callback for subsystems.
> - * @dev: Device to freeze.
> - */
> -int pm_generic_freeze_late(struct device *dev)
> -{
> -       const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> -
> -       return pm && pm->freeze_late ? pm->freeze_late(dev) : 0;
> -}
> -EXPORT_SYMBOL_GPL(pm_generic_freeze_late);
> -
>  /**
>   * pm_generic_freeze - Generic freeze callback for subsystems.
>   * @dev: Device to freeze.
> @@ -186,18 +174,6 @@ int pm_generic_thaw_noirq(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(pm_generic_thaw_noirq);
>
> -/**
> - * pm_generic_thaw_early - Generic thaw_early callback for subsystems.
> - * @dev: Device to thaw.
> - */
> -int pm_generic_thaw_early(struct device *dev)
> -{
> -       const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> -
> -       return pm && pm->thaw_early ? pm->thaw_early(dev) : 0;
> -}
> -EXPORT_SYMBOL_GPL(pm_generic_thaw_early);
> -
>  /**
>   * pm_generic_thaw - Generic thaw callback for subsystems.
>   * @dev: Device to thaw.
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 78855d794342..7bf22ed4a1d5 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -838,10 +838,8 @@ extern int pm_generic_resume_early(struct device *de=
v);
>  extern int pm_generic_resume_noirq(struct device *dev);
>  extern int pm_generic_resume(struct device *dev);
>  extern int pm_generic_freeze_noirq(struct device *dev);
> -extern int pm_generic_freeze_late(struct device *dev);
>  extern int pm_generic_freeze(struct device *dev);
>  extern int pm_generic_thaw_noirq(struct device *dev);
> -extern int pm_generic_thaw_early(struct device *dev);
>  extern int pm_generic_thaw(struct device *dev);
>  extern int pm_generic_restore_noirq(struct device *dev);
>  extern int pm_generic_restore_early(struct device *dev);
> @@ -883,10 +881,8 @@ static inline void dpm_for_each_dev(void *data, void=
 (*fn)(struct device *, void
>  #define pm_generic_resume_noirq                NULL
>  #define pm_generic_resume              NULL
>  #define pm_generic_freeze_noirq                NULL
> -#define pm_generic_freeze_late         NULL
>  #define pm_generic_freeze              NULL
>  #define pm_generic_thaw_noirq          NULL
> -#define pm_generic_thaw_early          NULL
>  #define pm_generic_thaw                        NULL
>  #define pm_generic_restore_noirq       NULL
>  #define pm_generic_restore_early       NULL
> --

Applied as 6.15 material, thanks!


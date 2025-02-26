Return-Path: <linux-pm+bounces-23004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0FCA46358
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 15:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D2E43A6D44
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 14:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F32F2222B8;
	Wed, 26 Feb 2025 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFrM1f+k"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9C222173E;
	Wed, 26 Feb 2025 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581103; cv=none; b=UyBg8FyU7p4TvWowdQVbTKICtuH0xmKsbDst8xsW3nzAoaQxl3T1y5CPax8gI5OvxAPlT+XmwI1gFPpeNBooVGOxdKBjsofrhujMYTY3lPL18SUQLzoRRp487cLehZPS+pKNo1gUwwsfjPmEhIX9w/zK4GZm4cyq7zbJqVcP7mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581103; c=relaxed/simple;
	bh=RTe1hi9sZtyjsIJ/eh+swsfyLFcndx/luRTFTjbvSOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7rade6vYSHwhkpC9VDY9yYfZhq1K3rWPnrivfHSSbHxNG8Tn5K+wlkYgiJXSOXYS2G4A0HjY+h8TtPt1V/NgAoQ2D3IAZeK1Sqo0ij9FmkJlg1j1/kqwJKrQw/hNIgQX2F0HXNDgRHF1tgy4Y1FPxyk2Y55XXvMaYxr+d5lyZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFrM1f+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A74C4CEEA;
	Wed, 26 Feb 2025 14:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740581102;
	bh=RTe1hi9sZtyjsIJ/eh+swsfyLFcndx/luRTFTjbvSOE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mFrM1f+k4Ryw9/hca6RmY8s1EczbyQAEbv08b0iv0aQ1LjH91v/7pYBy8Bt4ckOYE
	 4+6VlXgrn+VpOd1yDuUOOcB3XNLlgz1j5EnxUSC1vMSwTyqbpNcQ06DM5WhcMsc7LO
	 u4GZFsVbdJTo8DSkH0i5HmlWg6E2WIQSSWvf6aMh1Fs37axyUsbl3d32jUWGc/BSsx
	 CYmTQdy+SFBEhazDvVLRaPMrp/jAyducZZ6n+6kklm4vf83qw1BdGNjPUEVJXGF8UB
	 PhbjSAL5UIf9wcvO2DjQ33Mchu+uBvcj2sj2W0RSjJ0wFd8cVuAOs1SGEThbyhiE13
	 XUsdih/fEjhlQ==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5fe944a4243so537972eaf.0;
        Wed, 26 Feb 2025 06:45:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXT0LR3/t3n3t48G4Y+NMWm1SZhTVCEcnWZUzEG2SMcQGALF0jRgNBmfspH8uj9Dgq7Cou0Y3aJOFE=@vger.kernel.org, AJvYcCXY2htfPldA7pk+xgg6g2m14sVGUEQElIKnb8oKlMzlB6M1ym6IcEA7EndX0oSBKJH1PVcMl695JnFXd3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw05kps7jIGTXQrBBCtlmuIqsnDWAcl4KhqdNpKaSvTaxtCHtZ5
	+/qMxjZpLeRjp6V2zG1h0xmLeUj8jkgCMJQbWmCRkBTpMBboya+gYlsc4ObHRmcSDDESyERY1mU
	GmUwv+nJwPjQgmw1tMv/ipJ7bVeE=
X-Google-Smtp-Source: AGHT+IFDwFhho2gHF381k0q51unIEu5nVg0XaN8q8w7FXXIdvxfU5Fs0Ire5SNN90GjJPlA17LgF12CU1gM23vx/Uvw=
X-Received: by 2002:a05:6808:3a0e:b0:3f3:ffc5:7ba7 with SMTP id
 5614622812f47-3f540fbf8d8mr4309832b6e.24.1740581102067; Wed, 26 Feb 2025
 06:45:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224010610.187503-1-linux@treblig.org>
In-Reply-To: <20250224010610.187503-1-linux@treblig.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Feb 2025 15:44:51 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j_dX2a1_cz1SDdSqWHFsGX2mcFx1rE52hVHRnPUFgbmw@mail.gmail.com>
X-Gm-Features: AQ5f1JoyX5cU0PwLw63HPMohRvlIDUpPpZx6RHNliw-kLiQ9B0-X0rpSleyA9H8
Message-ID: <CAJZ5v0j_dX2a1_cz1SDdSqWHFsGX2mcFx1rE52hVHRnPUFgbmw@mail.gmail.com>
Subject: Re: [PATCH] PM: clk: remove unused of_pm_clk_add_clk
To: linux@treblig.org
Cc: rafael@kernel.org, len.brown@intel.com, pavel@kernel.org, 
	linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, dakr@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 2:06=E2=80=AFAM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> The last use of of_pm_clk_add_clk() was removed by 2019's
> commit fe00f8900ca7 ("irqchip/gic-pm: Update driver to use clk_bulk APIs"=
)
>
> Remove it.
>
> Note that the plural version of_pm_clk_add_clks() is still being
> used and is left.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/base/power/clock_ops.c | 33 ---------------------------------
>  include/linux/pm_clock.h       |  1 -
>  2 files changed, 34 deletions(-)
>
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_op=
s.c
> index e18ba676cdf6..97a53215a274 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -259,39 +259,6 @@ int pm_clk_add_clk(struct device *dev, struct clk *c=
lk)
>  }
>  EXPORT_SYMBOL_GPL(pm_clk_add_clk);
>
> -
> -/**
> - * of_pm_clk_add_clk - Start using a device clock for power management.
> - * @dev: Device whose clock is going to be used for power management.
> - * @name: Name of clock that is going to be used for power management.
> - *
> - * Add the clock described in the 'clocks' device-tree node that matches
> - * with the 'name' provided, to the list of clocks used for the power
> - * management of @dev. On success, returns 0. Returns a negative error
> - * code if the clock is not found or cannot be added.
> - */
> -int of_pm_clk_add_clk(struct device *dev, const char *name)
> -{
> -       struct clk *clk;
> -       int ret;
> -
> -       if (!dev || !dev->of_node || !name)
> -               return -EINVAL;
> -
> -       clk =3D of_clk_get_by_name(dev->of_node, name);
> -       if (IS_ERR(clk))
> -               return PTR_ERR(clk);
> -
> -       ret =3D pm_clk_add_clk(dev, clk);
> -       if (ret) {
> -               clk_put(clk);
> -               return ret;
> -       }
> -
> -       return 0;
> -}
> -EXPORT_SYMBOL_GPL(of_pm_clk_add_clk);
> -
>  /**
>   * of_pm_clk_add_clks - Start using device clock(s) for power management=
.
>   * @dev: Device whose clock(s) is going to be used for power management.
> diff --git a/include/linux/pm_clock.h b/include/linux/pm_clock.h
> index 68669ce18720..45c3f3ccbaf8 100644
> --- a/include/linux/pm_clock.h
> +++ b/include/linux/pm_clock.h
> @@ -41,7 +41,6 @@ extern int pm_clk_create(struct device *dev);
>  extern void pm_clk_destroy(struct device *dev);
>  extern int pm_clk_add(struct device *dev, const char *con_id);
>  extern int pm_clk_add_clk(struct device *dev, struct clk *clk);
> -extern int of_pm_clk_add_clk(struct device *dev, const char *name);
>  extern int of_pm_clk_add_clks(struct device *dev);
>  extern void pm_clk_remove(struct device *dev, const char *con_id);
>  extern void pm_clk_remove_clk(struct device *dev, struct clk *clk);
> --

Applied as 6.15 material, thanks!


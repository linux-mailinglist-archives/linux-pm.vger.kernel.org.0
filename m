Return-Path: <linux-pm+bounces-30429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D64CAFE10C
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 09:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97439188A777
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 07:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8690426E703;
	Wed,  9 Jul 2025 07:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+hJGiJM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5E126E6F6;
	Wed,  9 Jul 2025 07:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752045241; cv=none; b=YIqXCtxr2tSfTgllM0sIUWX+CftnJjYwAdezAylFuas1+cM1RhQSWs0Jj2Np3HK9C9qS7quj/8EIzsGrIim0PVNQHODlKNRPnW7DxKcQbIIntbrRGmB7322VbUHhe/BxxYtQOca9mydvsARGyDKn8YQ8KHGEyH/cAlSIGFh5De0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752045241; c=relaxed/simple;
	bh=J76AGjtuh6R11kYnmJzRbYHT82Z1gW9iVpQmqPtKFU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBEhtU9MpYlKBGBCRHDlAPJjMXOIGqNsFZ8KlBZbeFz1aCq0tk94hGW54xxmT54MCZWWdO9ey8UD1dtkALchiBoxmBxKRD+eMZDnFXWqLTAia0wzgD+K3MK9EJIifiWg7EbSuqbfE5+r2Cn2U5kRCqf8x7hM7Tkhncz+nMJ07J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+hJGiJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF79DC4CEF8;
	Wed,  9 Jul 2025 07:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752045240;
	bh=J76AGjtuh6R11kYnmJzRbYHT82Z1gW9iVpQmqPtKFU4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T+hJGiJMwbIatP4gi1aY/LeMighFT2sidAiqtotJemce7yn35/uoswKA2LXDckfEh
	 ZTa++ASbo/hfi8vyB1uWSd0B9mATBVHsaFj6wDdDOFv6PQK5++aLwIz3eWwBxDUB+c
	 ONCTnpPukSdHCa66ZnrARIouPHXxyG/KrGr1VkUf3Bnd/c9lNcWtV0JeUNvrrVLLDl
	 sbD3qkF405bW1nS3OHF8uEnq2QlIEJXgCUg0W7Tf6PAIu/KdrN7fj1IPdyle1UVHXM
	 ARYs6geXwIiTQbxdsAEZKnUBWQ7scfButM+T6FTFuzBwiAr3cT9zhtJfEmTnNuL/Je
	 EmJdlSSuGRWUA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-613a6e39f52so1449666eaf.3;
        Wed, 09 Jul 2025 00:14:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFCprHoEq27aLF8+Oa/mXRYGbWZ2C6QQT9cVwUajay5N4Xp9N7FsGcZy8BjbnQ3kl5ruo3AnMwfq8rmpY=@vger.kernel.org, AJvYcCX5f6kApRDhX3hNxhFcJR8PYPGpEHIMoDKgVn7RtKSOfNuAbHokR5sSWbLHDzpwQ4E954q26YYhpVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwViLl3tSGHHtvs15Cay/zpOsc6b31I0rfdyscn6aij7Qbh6HxZ
	cido4QnFc0QtUJIhct66dpfsZTV3dPc959IAoSC4f6mbOmjxr4KtvvVB9+gOjuL07aAfF+cgAJN
	drJVIKqBftbzTivQR7PDCX1dk8cAz19I=
X-Google-Smtp-Source: AGHT+IEskKLtdnCJNubzh7Cv2QywfY12LAjcDNXgB1nerfn1NA3+BNnJyGqJuYGQA0goXWDl19YnXJjYrQ6XWocHf6c=
X-Received: by 2002:a05:6820:3085:b0:611:75a8:f6ca with SMTP id
 006d021491bc7-613ccf31355mr832520eaf.6.1752045240045; Wed, 09 Jul 2025
 00:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709064404.839975-1-guoqing.zhang@amd.com> <20250709064404.839975-6-guoqing.zhang@amd.com>
In-Reply-To: <20250709064404.839975-6-guoqing.zhang@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Jul 2025 09:13:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ibK49=fbXH2oy6jVSEo6iFD9EvYR8ivHCUpP3iaU=8=A@mail.gmail.com>
X-Gm-Features: Ac12FXyIZd8T-A7UNwtDMfu3w-N8qETo7FMixPqescOOM5nC0bPObGEfy2_bAJI
Message-ID: <CAJZ5v0ibK49=fbXH2oy6jVSEo6iFD9EvYR8ivHCUpP3iaU=8=A@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] drm/amdgpu: do not resume device in thaw for
 normal hibernation
To: Samuel Zhang <guoqing.zhang@amd.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, rafael@kernel.org, 
	len.brown@intel.com, pavel@kernel.org, gregkh@linuxfoundation.org, 
	dakr@kernel.org, airlied@gmail.com, simona@ffwll.ch, ray.huang@amd.com, 
	matthew.auld@intel.com, matthew.brost@intel.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	mario.limonciello@amd.com, lijo.lazar@amd.com, victor.zhao@amd.com, 
	haijun.chang@amd.com, Qing.Ma@amd.com, Owen.Zhang2@amd.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 8:44=E2=80=AFAM Samuel Zhang <guoqing.zhang@amd.com>=
 wrote:
>
> For normal hibernation, GPU do not need to be resumed in thaw since it is
> not involved in writing the hibernation image. Skip resume in this case
> can reduce the hibernation time.
>
> On VM with 8 * 192GB VRAM dGPUs, 98% VRAM usage and 1.7TB system memory,
> this can save 50 minutes.
>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 4f8632737574..c37285a8b2c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2541,6 +2541,10 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
>         if (amdgpu_ras_intr_triggered())
>                 return;
>
> +       /* device maybe not resumed here, return immediately in this case=
 */
> +       if (adev->in_s4 && adev->in_suspend)
> +               return;
> +

You need to do analogous things in amdgpu_pmops_prepare() and
amdgpu_pmops_poweroff() AFAICS in case hibernation is carried out in
the "platform" mode.

>         /* if we are running in a VM, make sure the device
>          * torn down properly on reboot/shutdown.
>          * unfortunately we can't detect certain
> @@ -2654,8 +2658,17 @@ static int amdgpu_pmops_freeze(struct device *dev)
>  static int amdgpu_pmops_thaw(struct device *dev)
>  {
>         struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> +       int event =3D pm_transition_event();
>
> -       return amdgpu_device_resume(drm_dev, true);
> +       switch (event) {
> +       case PM_EVENT_THAW: /* normal case */
> +               return 0;
> +       case PM_EVENT_RECOVER: /* error case */
> +               return amdgpu_device_resume(drm_dev, true);
> +       default:
> +               dev_err(dev, "unknown pm_transition_event %d\n", event);
> +               return -EOPNOTSUPP;
> +       }
>  }
>
>  static int amdgpu_pmops_poweroff(struct device *dev)
> --


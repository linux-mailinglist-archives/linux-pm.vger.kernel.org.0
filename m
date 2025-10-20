Return-Path: <linux-pm+bounces-36489-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC53EBF2AD9
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 19:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61BFB407864
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 17:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94E632ED3E;
	Mon, 20 Oct 2025 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rvl/jEr3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4341245014
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980889; cv=none; b=YA7wHzijHjT/IKecAs3iC/skZb3jyaV3dQN2nd0NF2G3xMGlCGONaMYltYXz1UVcXwJA9IFTMEOWu0hj6ff66SIDHb6dOTg3UlLYyNSuAv77LIt4BTJ8tUzW3aausO9vsR9FjncG6Hxc/BYxYSUSEicfgy8pjdKcsf3mwXMXJeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980889; c=relaxed/simple;
	bh=uI5rsFpiE13xOKlRUr0iIvhiw/jg45u3VMFRQxTK9Hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeRNXDJY4GYaT6//f4AXOwfSrkGgcCxH2dAuD8hP6hA70VGzDMuu2xrlMTMt15JqWUlApF36red7i7VMzT9AVPu/tqltSRqKtgQ1CsQh4biNLD7km94FZnFKSCzW5Al/lopjtcc0Y5i4eF6k+e4LFyyFbJDbQ1qIU1sNAN4oSMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rvl/jEr3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E8AC19424
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 17:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760980889;
	bh=uI5rsFpiE13xOKlRUr0iIvhiw/jg45u3VMFRQxTK9Hk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Rvl/jEr3JCHqO7eVAcQ2vXHc4Cei02Xx6mPp//9vMReOYECUZuKOyRBR+1PEWGaA4
	 OC0QZ6+t4kJMRFIJJbJwgZCdpcAw2s+dHkmCCjHU8VD3ZOQfjrhuCJMGfag72QqfST
	 I6Bjc3dq6SeRjZPSjcR4FRNU4IzbZOd1U5dX3vXYoLcineMF8fz0zHbLkjqc5U7cVu
	 Cd9hm3ahpdusMDDvIl2HRGLy8LUR6Waqfjv8u+TxMUWHeo0AdDkaU0DglgUQjOry2z
	 idCNbCNd0uJEi7ZLN1dkaMUI5FaCTKSVGDAWAOwqRqPi0ybiqtwFwuXMvdj2g3UhKw
	 zwRUsrO/I+V6w==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3c97c98c791so2660572fac.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 10:21:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXg3/Eiu6bTglU12rqTYTZ8ly1N8nvrk60ZrSNIMe/QgGtHMnHbjFp7AxswhPSvou3TZWvhg/yNTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMHtjhx1tx7R7rucsn6B31tQgGEopZi9DyQ6LXyjM+J+4+k6DU
	6epmJL5A7s6jmtQ6dLYCyaQh6PxzPqklhiVgtZYPqYy1/Pfc7DeCHi2VxTCHC1Gc0HBuvDCNljp
	7Fisv4rO1Mlu2tabV16ksIt0+NTILg78=
X-Google-Smtp-Source: AGHT+IFU0bU8fKZ0Wua75/5pRYAXjg6ICdC5ZIAIZU0v6VlGJqQRFSAEBuztx/l/Pivh+cm/UonHIHXKPVckX8HLNyQ=
X-Received: by 2002:a05:6871:2e90:b0:387:9b79:a61b with SMTP id
 586e51a60fabf-3c98cff3fd9mr5575729fac.22.1760980888969; Mon, 20 Oct 2025
 10:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020165317.3992933-1-superm1@kernel.org> <20251020165317.3992933-4-superm1@kernel.org>
In-Reply-To: <20251020165317.3992933-4-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Oct 2025 19:21:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gsdmfXUJuLW8Ogt2jKDunx4g51LqCfSVMWQ6WHXBw_zg@mail.gmail.com>
X-Gm-Features: AS18NWChU2EP-kmiSeBpXBkZQsZMUWO1qaU0RIWwAVoz1ykVcHqEMNRFvTKh8NY
Message-ID: <CAJZ5v0gsdmfXUJuLW8Ogt2jKDunx4g51LqCfSVMWQ6WHXBw_zg@mail.gmail.com>
Subject: Re: [RFC 3/3] drm/amd: Return -EBUSY for amdgpu_pmops_thaw() on success
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, airlied@gmail.com, alexander.deucher@amd.com, 
	christian.koenig@amd.com, dakr@kernel.org, gregkh@linuxfoundation.org, 
	lenb@kernel.org, pavel@kernel.org, rafael@kernel.org, simona@ffwll.ch, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 6:53=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> The PM core should be notified that thaw was skipped for the device
> so that if it's tried to be resumed (such as an aborted hibernate)
> that it gets another chance to resume.
>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 61268aa82df4d..d40af069f24dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2681,7 +2681,7 @@ static int amdgpu_pmops_thaw(struct device *dev)
>
>         /* do not resume device if it's normal hibernation */
>         if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_susp=
end())
> -               return 0;
> +               return -EBUSY;

So that's why you need the special handling of -EBUSY in the previous patch=
.

I think that you need to save some state in this driver and then use
it in subsequent callbacks instead of hacking the core to do what you
want.

>         return amdgpu_device_resume(drm_dev, true);
>  }
> --


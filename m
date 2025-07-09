Return-Path: <linux-pm+bounces-30444-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DA4AFE57E
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 12:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0EC01882094
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 10:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72038289369;
	Wed,  9 Jul 2025 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jv75CHNk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482672868B0;
	Wed,  9 Jul 2025 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752056058; cv=none; b=kmBFx0U45Oiu+2okdTFWauoZY8jL0yLUQCap6mioWY8W7TM3tzpGJ1cW+l/SptO7TXI4RiZoj1wBflkAKKZ/0/6bss3rvgq4YCUJ4Cz8/9RNlLentXDTiNlf8+nQlZDmV/GsIALZesc9Tyex7qxOb7IxNs+4YnEPR5tZQtlHo/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752056058; c=relaxed/simple;
	bh=2C4pjyJfdueSpOB2Mvvwc5pv38gCi/WniANABx1A6dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AzM3fP15MJ2x29FrCAn/VAP6guQoWhInAXQ9iwORfB/iTPK9Z3K75VJad4ty4DIs5yYBdwg6zAcxxS+pQK6y2HDzFtLQw2qeiS1e+pLGYmdSUkg6Z3+eXsdYB6m42yRQuv2Pb4870+HmmMie/1e06fmKq/ZEEczfW380FiCs/Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jv75CHNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA80C4CEF5;
	Wed,  9 Jul 2025 10:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752056057;
	bh=2C4pjyJfdueSpOB2Mvvwc5pv38gCi/WniANABx1A6dc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jv75CHNk32psM/ac6tyRoLCzzu5BFZCiIlBJT7APWb00m7ZkYBkb2M5bLM2fj7J8N
	 viXdxE396Ys3g6AORulQWY6QVx9pydFaQqqxkYAkm4DKoWFXITb6LrUD+269wUONvR
	 GQ/W4hdarSY/t3plzB3KwpMpD4OruzrJXSM/T7dGLfdI8+gbR6oVGlw+qciEE+8HRE
	 2kEqClhlzFbFZkVywH+AHLslJXEz0StbJWQ7lZpSVlwW57/rw9MR/aZ1WxGk+6GiSA
	 gIJRrT3Q5t4goEeqPv4W2V/QPN0iMot8LYN5YWEXNwlNEnttjsN41QPbzrBTyzzlTK
	 dLc/Rhw+ADbJw==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6138aedd718so415618eaf.0;
        Wed, 09 Jul 2025 03:14:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQT5bvtZmxEA++vKOqmiVt779SowoERgaHjrqlvCup1GhSZGTc2PIWgjgOaApAi3exe/SADMAUXDpoyqU=@vger.kernel.org, AJvYcCVO2T11YpmDBW5sE1D7w6zt+ni4gXs1cPCwnQHN4In5HMwzwycjQbcBZlas1/op+eh92sj4HShjefs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1MMleUl27b1fY6Vn0QbxFmrbY0jcBBX5DDIgdj3tXD51oW+I1
	aDS3e42UuTU5Y5bk+4CHXol3sXScDbWFctZA9GwzShcZoZmr7UxSv4yTeZs0An9KK72mVtOt5PB
	e+D63TWLnlqH7+0LUH+xVjHAg13f48JM=
X-Google-Smtp-Source: AGHT+IGV03Pl9AQwiLzwXsYo2beEMoMSWrGSGoCKgRfbkG+PrR7p5pv9tGMAyclr03pPq+vN5TQloAV+Py294L3Ea9c=
X-Received: by 2002:a05:6820:4c85:b0:613:bd07:54cc with SMTP id
 006d021491bc7-613cd02aac7mr1117259eaf.0.1752056057126; Wed, 09 Jul 2025
 03:14:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709100512.3762063-1-guoqing.zhang@amd.com> <20250709100512.3762063-5-guoqing.zhang@amd.com>
In-Reply-To: <20250709100512.3762063-5-guoqing.zhang@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Jul 2025 12:14:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hAHfL-Vamh-OAGJ73oVnoRDXh3QqLd8+NjNFsU5yWwcg@mail.gmail.com>
X-Gm-Features: Ac12FXyFX77CgkWVTAu-0wLPoDSeMMEFLfqSFYTRgAjt5vPCEE2oN68SUekAwCY
Message-ID: <CAJZ5v0hAHfL-Vamh-OAGJ73oVnoRDXh3QqLd8+NjNFsU5yWwcg@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] PM: hibernate: add new api pm_hibernate_is_recovering()
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

On Wed, Jul 9, 2025 at 12:05=E2=80=AFPM Samuel Zhang <guoqing.zhang@amd.com=
> wrote:
>
> dev_pm_ops.thaw() is called in following cases:
> * normal case: after hibernation image has been created.
> * error case 1: creation of a hibernation image has failed.
> * error case 2: restoration from a hibernation image has failed.
>
> For normal case, it is called mainly for resume storage devices for
> saving the hibernation image. Other devices that are not involved
> in the image saving do not need to resume the device. But since there's
> no api to know which case thaw() is called, device drivers can't
> conditionally resume device in thaw().
>
> The new pm_hibernate_is_recovering() is such a api to query if thaw() is
> called in normal case.
>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>  drivers/base/power/main.c | 14 ++++++++++++++
>  include/linux/pm.h        |  2 ++
>  2 files changed, 16 insertions(+)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 40e1d8d8a589..ff78cf96f795 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -63,6 +63,20 @@ static LIST_HEAD(dpm_noirq_list);
>  static DEFINE_MUTEX(dpm_list_mtx);
>  static pm_message_t pm_transition;
>
> +/**
> + * pm_hibernate_is_recovering - if recovering from hibernate due to erro=
r.
> + *
> + * Used to query if dev_pm_ops.thaw() is called for normal hibernation c=
ase or
> + * recovering from some error.
> + *
> + * Return: true for error case, false for normal case.
> + */
> +bool pm_hibernate_is_recovering(void)
> +{
> +       return pm_transition.event =3D=3D PM_EVENT_RECOVER;
> +}
> +EXPORT_SYMBOL_GPL(pm_hibernate_is_recovering);
> +
>  static int async_error;
>
>  static const char *pm_verb(int event)
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 78855d794342..f54a803f2afb 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -657,6 +657,8 @@ struct pm_subsys_data {
>  #define DPM_FLAG_SMART_SUSPEND         BIT(2)
>  #define DPM_FLAG_MAY_SKIP_RESUME       BIT(3)
>
> +bool pm_hibernate_is_recovering(void);
> +

Please add this to suspend.h instead (preferably after the
is_hibernate_resume_dev definition).

>  struct dev_pm_info {
>         pm_message_t            power_state;
>         bool                    can_wakeup:1;
> --


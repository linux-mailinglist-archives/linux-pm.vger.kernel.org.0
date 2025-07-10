Return-Path: <linux-pm+bounces-30540-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1724AFFC0C
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 10:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5C81C449A4
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 08:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A1C28C5A3;
	Thu, 10 Jul 2025 08:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwZ1eXoI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F2F28BAA4;
	Thu, 10 Jul 2025 08:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135688; cv=none; b=RjGybQCmxpuBKy/CgT3ENV4m83SlNyOeKGXlgoE0J5CG3C/7/r9B8fZ8Sj/efahc1kT3mBmhNd06e6cgQyJ6/sXb3Jx1cmx2aUf31SlB64xlYAjceMcjODUtwK4sCuCPZBrueqMP2O2ll4RxACjf8sNiMwTa1RzpmD/vSiRwUzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135688; c=relaxed/simple;
	bh=vZGC4utAN8Jf9kgiQ1OU9eVoRR/s/LZegXdZdbaWUUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gpemt1gPrqjrx+OS6YOkgeaagR8MPHdX7oVhSNvkcVnpiEEutiuAG38OY3udxa4hMx6pwxHYCtbKvSu9rFO8ZLjKoBf4nEYblgV6XdObJ4mZ+DTmpkqaHPKgL20yphTqZ6hJW2w1y5Bke+u/Y4S2v67NnGqpoV4Ur8+BMOQvvGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwZ1eXoI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C12C4CEFA;
	Thu, 10 Jul 2025 08:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752135688;
	bh=vZGC4utAN8Jf9kgiQ1OU9eVoRR/s/LZegXdZdbaWUUs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nwZ1eXoI7fqtm/S4j0EXI6RuCDnSvh6y8W27PzYPT7pPx9Qdi3E36ZGsKPNpdntyg
	 djzLoS4vZN8K/v6B8ZUWumFZE4nS+j9+q0EVcbVSFmL37Mm+PaSJbIjC4kxsPFCCLY
	 fiC15jL7Tf18sJfuTr9+J2fsHHs8OqAumYuKkcQ/TeJOCvCcfbjuoXkSBUJw9bzwjg
	 PyW4kl9PC0dPH1vKNW4jkWkmfr91LekmtCulC6ufEcykXlX0tWzTfYaKOa/ppQiURL
	 hhD66bQ2tXAORgA3G10GiNu8AE2hRGODEaDRrxD94SQhhC8EKtnTRtG5vApcZ3ObCh
	 Z3LjDs2O1A3Jw==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-611e20dd2ffso259428eaf.2;
        Thu, 10 Jul 2025 01:21:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhi10tDZUW8UD6Ee+ZUB8YwcXks6vr51gY5bGjC+tuSmcHYyK/9hSPuIw4EYyeXDLfz8LUswIhAZc=@vger.kernel.org, AJvYcCVvgWC4wcdoX+dZjlqcU7OHum3pScd68vOi3ZagJpKpwdBduD9BFvoK7KbzFbpWywno61f0zkivtlg3RVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVqJvSiBs6m0BgEK682RTbLXzc3+tktoCUcnd37UGswmHa2cLJ
	LgiNPwbNRrR0HbpZo3dMlCG4UXQ+Mg4Hx5uDJ1Al8/cOcu6g+AP+n23pzEYTpYOEkzTXukB1r4v
	h4bw48yMwaoWxTLQvA5fNX2u62gEf77k=
X-Google-Smtp-Source: AGHT+IF/jRMTIGOY1PdngLNu1usC8M99C638yCwVzM6VG3sXyFaNfyL7DMzkpuc1Vd31N6pmaGxsai2kNCIVGCP0+oc=
X-Received: by 2002:a05:6870:40d5:b0:2e8:7953:ece7 with SMTP id
 586e51a60fabf-2ff10991555mr1234020fac.24.1752135687725; Thu, 10 Jul 2025
 01:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710062313.3226149-1-guoqing.zhang@amd.com> <20250710062313.3226149-5-guoqing.zhang@amd.com>
In-Reply-To: <20250710062313.3226149-5-guoqing.zhang@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Jul 2025 10:21:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ha_XUJ4OK0G5RT1a1KFDTAz82jVDdCFRtKTCv8aoDdxA@mail.gmail.com>
X-Gm-Features: Ac12FXyuUHPZGj-fRagl7o7kPz3guIlAxJWSaIJW8PovsrLvRAObEgMY_8LU2pg
Message-ID: <CAJZ5v0ha_XUJ4OK0G5RT1a1KFDTAz82jVDdCFRtKTCv8aoDdxA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] PM: hibernate: add new api pm_hibernate_is_recovering()
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

On Thu, Jul 10, 2025 at 8:23=E2=80=AFAM Samuel Zhang <guoqing.zhang@amd.com=
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

LGTM now, so

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/power/main.c | 14 ++++++++++++++
>  include/linux/suspend.h   |  2 ++
>  2 files changed, 16 insertions(+)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 24ebe7a635a7..c4817b379230 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -66,6 +66,20 @@ static pm_message_t pm_transition;
>  static DEFINE_MUTEX(async_wip_mtx);
>  static int async_error;
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
>  static const char *pm_verb(int event)
>  {
>         switch (event) {
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 6a3f92098872..d11a124b7a91 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -426,6 +426,8 @@ int is_hibernate_resume_dev(dev_t dev);
>  static inline int is_hibernate_resume_dev(dev_t dev) { return 0; }
>  #endif
>
> +bool pm_hibernate_is_recovering(void);
> +
>  /* Hibernation and suspend events */
>  #define PM_HIBERNATION_PREPARE 0x0001 /* Going to hibernate */
>  #define PM_POST_HIBERNATION    0x0002 /* Hibernation finished */
> --
> 2.43.5
>


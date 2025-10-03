Return-Path: <linux-pm+bounces-35696-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9215BB7DFF
	for <lists+linux-pm@lfdr.de>; Fri, 03 Oct 2025 20:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25DE34EE1F9
	for <lists+linux-pm@lfdr.de>; Fri,  3 Oct 2025 18:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C4D2DCBE2;
	Fri,  3 Oct 2025 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPeMRcCx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663392DC339
	for <linux-pm@vger.kernel.org>; Fri,  3 Oct 2025 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759515540; cv=none; b=D1a3F7YmJXgLTQPS4KLS6CNBEQIV+NSGePgdMfYGfeodt6sGaG6RaPZBJrHiDiz5SEl1gXjmIzBz88EtWM/f1Je1npS+tzvW1O2kgyzz9gcBqF+L6CvcbOu0x/IC3LqiOmWuwUCAwj/micSfpFPj8DiHFtQtLYTfRO5wqJk17w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759515540; c=relaxed/simple;
	bh=++WRUe2aDvANfhEeao915TQLwk/Lfp0RbLMHA3rIrF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rxv96F4Yyv2jH/1gV+6vghD+4+YEzT0ualbVUzTUmmV99GPzk95x2U6l3b4rMtxcAo4x9kwJ+y7/ZqFSU+vHRDcBrt1wspOcAHRxSAWXiEaJr/lKT/Epnh6rDeDqblZrSJpMdpXXRbfBiMcFmRrfqytOS6in1DR1dOlmfkwKNEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPeMRcCx; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d603b60cbso27488077b3.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Oct 2025 11:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759515537; x=1760120337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUQoE2+YrP4Piuppn11V4n/Ge5n4X6vhqEU1SyrhiLY=;
        b=QPeMRcCxAsaE4KxHd6n5jJZ4nt+2xjdX8Iv8uKJ2BNIU3kmD8FrxjdUMqHFI3tsLNv
         Llk7CasHt0s84rTncHVZVALtGJlK9gv6a9sb1xjSMPXPd/LWCbAGMNymQHTg8q8WOB4n
         4kJOfoIoL/WcFH+fxnsje1j2Y6VSn5KpTw4zHc7Yn686PPvJdr0SVbWqfRaY9ajU9jwR
         CTDTsVo3IsCEwBCG2sfCn2G+pkdRMrmbPvi6msRVQO7nNVHQMpz8iIOaTu8nG28K/vLj
         r9W2Pu9NdhAz0iw/q57IAPTWakSu4DtBP4lBmxHYe2ex1kShOCA5brWqufxhHlLkpFZx
         oR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759515537; x=1760120337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUQoE2+YrP4Piuppn11V4n/Ge5n4X6vhqEU1SyrhiLY=;
        b=og/SZyD5KHLfHr3s0QQEJpgRudRjJvaal0v6+4AP55GszsOpOtZPNqoE0ZXlR+cUac
         9mkWoXEbnUYwmzwbB+URKVMTkK2L8llpNi16GhdKJi9I/Vxh9M2Z//JsVwRzx75yYAKV
         9gaDGjFo3rY5HMAP9G01vXG7wPabp+iKz7XXEu+9XDrmVENIEruKwQkj3cxBzHJyXjmR
         5y2I/pLUQnxm2ynUjhI14WsNRcM1d9SfffRil/x0HS+40oy80wTNSXFK1VqSqXep6AZe
         LcXjYLUOVsB6Q2E+AEeXR1HLER0anopx/zzsZ07EtYKZF//ox++u3bb5X9D5qVs3wFF2
         2X4g==
X-Forwarded-Encrypted: i=1; AJvYcCXZy3FtLkhkrsvZfqf1n/9ODRoAl7U7ercmxMwF7t1cSzK6sg4S+Rbo1geo2VYTtWywiTwbX/czRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpWgbZPwkeRIj8kGO4sQ7xEOuFTGd1AxAfI4yh5dkYx+2DGNqw
	KguRS456eA45LumG3cq8RZFwLF50ggw29IB5ujxHFtGB/dRM6zZirIIZ13jNFlZCWrRubzFIIVx
	ZdEYxj0ua8uVG+OQTYB79+jSIJUexkPI=
X-Gm-Gg: ASbGncsHAn3txXpEkUrN9uWenPypaWWs0Xk7ULmgdlMV0Sk4egl3LPNq0CbP/TNXtkf
	xevGZufFFswlMCsuvI50rdLiasTp9/e5GVdlykCAsIc0qBUSGhwenTIPDrNUJRjWROzRPdIHoBu
	++Hx6kWcXvmcrCpEThuKVI1iIaDDXIGp0mfCzEwJQDKBxOB1W1WNrdeExcRbNDZhpFQBUiVVF+P
	l1IaE8gunnpoAni5G8ltfYkxG/rq1DeyLo+jG5t+cghfup+ubaXXiF2Ew2QVbfBH4BaKheoSKtQ
	+E9oWDv+rTpo2qgQ0cag3A==
X-Google-Smtp-Source: AGHT+IGtLMvtFx4RxHoNIBh2x4X8Ab6Ix6GqGCbCEA5mUc1tZP075IB+GlQMmeZfD4IGoIK1kUGSajZNab9Clue8LXg=
X-Received: by 2002:a53:c043:0:20b0:636:1ee5:7745 with SMTP id
 956f58d0204a3-63b99f36944mr3824334d50.0.1759515537310; Fri, 03 Oct 2025
 11:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929-mt8196-gpufreq-v5-0-3056e5ecf765@collabora.com> <20250929-mt8196-gpufreq-v5-5-3056e5ecf765@collabora.com>
In-Reply-To: <20250929-mt8196-gpufreq-v5-5-3056e5ecf765@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Fri, 3 Oct 2025 11:18:45 -0700
X-Gm-Features: AS18NWDjAm-QC4ccunNsvz_U1UXKS_05wvPJ1N_78dxhAoW5d44NTw2whZ6ltCU
Message-ID: <CAPaKu7S6_0G4rbRP_nCF0Aw9uy1K8ABqi2z8isvpHcVWkWjJaQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] drm/panthor: call into devfreq for current frequency
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Chen-Yu Tsai <wenst@chromium.org>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 12:48=E2=80=AFAM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> As it stands, panthor keeps a cached current frequency value for when it
> wants to retrieve it. This doesn't work well for when things might
> switch frequency without panthor's knowledge.
>
> Instead, implement the get_cur_freq operation, and expose it through a
> helper function to the rest of panthor.
>
> Reviewed-by: Steven Price <steven.price@arm.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_devfreq.c | 33 +++++++++++++++++++++++++=
++----
>  drivers/gpu/drm/panthor/panthor_devfreq.h |  2 ++
>  drivers/gpu/drm/panthor/panthor_device.h  |  3 ---
>  drivers/gpu/drm/panthor/panthor_drv.c     |  4 +++-
>  4 files changed, 34 insertions(+), 8 deletions(-)
>
[...]
> +
> +unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev)
> +{
> +       struct panthor_devfreq *pdevfreq =3D ptdev->devfreq;
> +       unsigned long freq =3D 0;
> +       int ret;
> +
> +       if (!pdevfreq || !pdevfreq->devfreq)
> +               return 0;
> +
> +       if (pdevfreq->devfreq->profile->get_cur_freq) {
This and the other two NULL checks above seem unnecessary. But let's
follow other functions and check for pdevfreq->devfreq only.

With that, Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> +               ret =3D pdevfreq->devfreq->profile->get_cur_freq(ptdev->b=
ase.dev,
> +                                                              &freq);
> +               if (ret)
> +                       return 0;
> +       }
> +
> +       return freq;
> +}
> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.h b/drivers/gpu/drm/=
panthor/panthor_devfreq.h
> index b7631de695f7d79456478c87e8af5dc47673cd1d..f8e29e02f66cb3281ed4bb4c7=
5cda9bd4df82b92 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.h
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.h
> @@ -18,4 +18,6 @@ void panthor_devfreq_suspend(struct panthor_device *ptd=
ev);
>  void panthor_devfreq_record_busy(struct panthor_device *ptdev);
>  void panthor_devfreq_record_idle(struct panthor_device *ptdev);
>
> +unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev);
> +
>  #endif /* __PANTHOR_DEVFREQ_H__ */
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/p=
anthor/panthor_device.h
> index 9f0649ecfc4fc697a21a8b2fc4dd89c8ecf298df..f32c1868bf6d782d99df9dbd0=
babcea049c917e0 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -214,9 +214,6 @@ struct panthor_device {
>         /** @profile_mask: User-set profiling flags for job accounting. *=
/
>         u32 profile_mask;
>
> -       /** @current_frequency: Device clock frequency at present. Set by=
 DVFS*/
> -       unsigned long current_frequency;
> -
>         /** @fast_rate: Maximum device clock frequency. Set by DVFS */
>         unsigned long fast_rate;
>
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/pant=
hor/panthor_drv.c
> index ea4a37b566a8b215f2b7a09c333a696f1dcdb58f..4d59d94c353c3ca76f4b98a41=
1c8f8284efafd08 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -25,6 +25,7 @@
>  #include <drm/gpu_scheduler.h>
>  #include <drm/panthor_drm.h>
>
> +#include "panthor_devfreq.h"
>  #include "panthor_device.h"
>  #include "panthor_fw.h"
>  #include "panthor_gem.h"
> @@ -1519,7 +1520,8 @@ static void panthor_gpu_show_fdinfo(struct panthor_=
device *ptdev,
>                 drm_printf(p, "drm-cycles-panthor:\t%llu\n", pfile->stats=
.cycles);
>
>         drm_printf(p, "drm-maxfreq-panthor:\t%lu Hz\n", ptdev->fast_rate)=
;
> -       drm_printf(p, "drm-curfreq-panthor:\t%lu Hz\n", ptdev->current_fr=
equency);
> +       drm_printf(p, "drm-curfreq-panthor:\t%lu Hz\n",
> +                  panthor_devfreq_get_freq(ptdev));
>  }
>
>  static void panthor_show_internal_memory_stats(struct drm_printer *p, st=
ruct drm_file *file)
>
> --
> 2.51.0
>


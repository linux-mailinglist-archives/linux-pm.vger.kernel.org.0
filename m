Return-Path: <linux-pm+bounces-28799-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA2AADAC28
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 11:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9958F1892057
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 09:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8E8273D91;
	Mon, 16 Jun 2025 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GWCt+dz+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEEF273D78
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750066867; cv=none; b=P2/qSqDyJamlb3zuL/c/6qHCHHrmZWDnt1q5LOh9ZjtiMvA/JimQ0s5JGrpV9IZ67DRWkKQXim2k6dSQ1Gww/ruTe39H6zuIQRB5of3Y234AXgerpfqceGLUSLeNwC41dmLZX7rhAwV26U6hoe1wFEphJ7JuPtlwmP9MW5OCAH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750066867; c=relaxed/simple;
	bh=7XgftMYlowI9omQsqIdx6iLF24jqn6RByllX2ehfs7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DD5Wgq3LMOtL4X8Y/ZlJIztwqqbzH+/EKZYN/jNwUvCTV6losaV1Vs86L+pyhVcVb7RBz5TAFacBmivC/6Sf3S34qhElML5Ae8143GetnBPsel/1E4B/a/cv5qQK8U2/5RZ9ujNmmGURkhKKMkLg15i5CILTF9ZTdz8q0kKaBuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GWCt+dz+; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54b10594812so4258614e87.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 02:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750066864; x=1750671664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZadNMdHIaOPYoMnd8DCHGg9pjL54W3auftd8ZPyuMno=;
        b=GWCt+dz+xgX1+HTKkjCZXjMRV7n/QHqw+aBcgYC0SnsqkYJ+sgXMWHq+ZWPK7LTaBt
         6nDaEIBRp2k6IiutyYuXPyVWtkdUzKQPC6JVb/yqLe9ohmZTwjpKmEyq/ObkmEFY+DSw
         P5AOU/CSqlA9EgMx4/2Fny+uOGdJDHYL9lfina9VfUCXtt6I6gzwQT4aqL2J6it+sQhu
         JBNCNsUKihsXQ+BTfpoiIPx92h7mKGqRxX8gfTPf0EPH28J66pVnfWvj6pVI4B4ooTLR
         xRrzNBIf3i5H/JOOezwkR9FSkCispNTrhpbBVC6jnh5LxSNTPbWZg1tJXIOs69qSOnXM
         PI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750066864; x=1750671664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZadNMdHIaOPYoMnd8DCHGg9pjL54W3auftd8ZPyuMno=;
        b=JnR0UL1BMWBjLmKggt/+qGA91yiF7hR1Qh90QOz+HOeMnGBXSwrj9+EFXhKNm3C2+U
         V2BGqc3ZIAo61XDpaBBAsg2IpW/rpgEysYVLQWqHjpkKGT2eSkERlloPtUvrhJUyHv8S
         ZYFTopbhkRgYB2X/ATtLplCqDVQjHc91Hm0WdUMvUQgFMJj9I/n0aJX4WpoQxR69mIn+
         g6t0LFe5uQxyBDukRWrG2rfGG0xdAjwzq35zWEK6iHbcPw6K73WO448ya8DEEv7i+xWX
         EC4jO7CbEcQlqtoi4y8zX0k96eaqh1C2YQ5X5NylDNubJPmszrnRITRnxblAuY/SdFn4
         sZcA==
X-Forwarded-Encrypted: i=1; AJvYcCWy54/S7fCKPAWIO7ZQu/Qdok0A9n7AUYhG3Xhz8mzNyO92xAgEJ1jIkj9zRD8QuLo6Y8wwkY5Vtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpY1L7tYWc+H0aGeLabwCcxGexkt1ecRos1GXeqD4zzBCQoBwy
	lHHSUFaYu9EVE1RtP5d5LSSDoFgbK+LtH1dYHb3vSlI2SFm3R/9ZfZooIBiusWFm1+FU4PoZBYU
	qJIp9skekiBvPRD5SYvCUjrm3HeKBoRqnPpif6MD5tg==
X-Gm-Gg: ASbGnctR2yCYH6npQ1wo5VqnjM5W/iemf1kTJdyEwUQ0OT4S0qGmjnpC0tK/pVpDro0
	VKfrFhQ8aIxAsfbl5HbOGltPjQL9s+hkDBXmwaeIzAj7wP1Fd9xMI11VuizR+82sq+VbBnGE2Ij
	TJwVj+R+9fxjw3URC3DKUzdO69x0RMMQQa68EU/HblnasMS0wwK9LgFVJkXg/rETZifG/iLToUA
	m0=
X-Google-Smtp-Source: AGHT+IGQWWfUkusHDrOLuRcyzoECeHHGTF7H0pzgq8rg6Tj7LyO4hdSVch5xZMTnr/dQPwUpgGJMqB60ks8Us882nLo=
X-Received: by 2002:a05:6512:12d1:b0:553:663d:7354 with SMTP id
 2adb3069b0e04-553b6f31175mr1628391e87.48.1750066863507; Mon, 16 Jun 2025
 02:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250614180911eucas1p16c9fb4a8160253c253f623bec2529f70@eucas1p1.samsung.com>
 <20250614-apr_14_for_sending-v4-0-8e3945c819cd@samsung.com> <20250614-apr_14_for_sending-v4-4-8e3945c819cd@samsung.com>
In-Reply-To: <20250614-apr_14_for_sending-v4-4-8e3945c819cd@samsung.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 16 Jun 2025 11:40:50 +0200
X-Gm-Features: AX0GCFt1wszk0eSWs2NPgAoE3A4kwN-NyBJ_b5il4mUmGBJkPe4uMiqiWgyvPn0
Message-ID: <CAMRc=MfdBd6HBwM4F1TcjDvwbOJ03kxgRk4hJQ8HFK7Wz2XBAg@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] drm/imagination: Use pwrseq for TH1520 GPU power management
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 8:09=E2=80=AFPM Michal Wilczynski
<m.wilczynski@samsung.com> wrote:
>
> Update the Imagination PVR DRM driver to leverage the pwrseq framework
> for managing the power sequence of the GPU on the T-HEAD TH1520 SoC.
>
> To cleanly handle the TH1520's specific power requirements in the
> generic driver, this patch implements the "driver match data" pattern. A
> has_pwrseq flag in a new pvr_soc_data struct is now associated with
> thead,th1520-gpu compatible string in the of_device_id table.
>
> At probe time, the driver checks this flag. If true, it calls
> devm_pwrseq_get("gpu-power"), requiring a valid sequencer and deferring
> probe on failure. In this mode, all power and reset control is delegated
> to the pwrseq provider. If the flag is false, the driver skips this
> logic and falls back to its standard manual power management. Clock
> handles are still acquired directly by this driver in both cases for
> other purposes like devfreq.
>
> The runtime PM callbacks, pvr_power_device_resume() and
> pvr_power_device_suspend(), are modified to call pwrseq_power_on() and
> pwrseq_power_off() respectively when the sequencer is present.  A helper
> function, pvr_power_off_sequence_manual(), is introduced to encapsulate
> the manual power-down logic.
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---

[snip]

>
> +static int pvr_power_off_sequence_manual(struct pvr_device *pvr_dev)
> +{
> +       int err;
> +
> +       err =3D reset_control_assert(pvr_dev->reset);
> +
> +       clk_disable_unprepare(pvr_dev->mem_clk);
> +       clk_disable_unprepare(pvr_dev->sys_clk);
> +       clk_disable_unprepare(pvr_dev->core_clk);
> +
> +       return err;
> +}
> +
>  int
>  pvr_power_device_suspend(struct device *dev)
>  {
> @@ -252,11 +266,10 @@ pvr_power_device_suspend(struct device *dev)
>                         goto err_drm_dev_exit;
>         }
>
> -       clk_disable_unprepare(pvr_dev->mem_clk);
> -       clk_disable_unprepare(pvr_dev->sys_clk);
> -       clk_disable_unprepare(pvr_dev->core_clk);
> -
> -       err =3D reset_control_assert(pvr_dev->reset);
> +       if (pvr_dev->pwrseq)
> +               err =3D pwrseq_power_off(pvr_dev->pwrseq);
> +       else
> +               err =3D pvr_power_off_sequence_manual(pvr_dev);
>
>  err_drm_dev_exit:
>         drm_dev_exit(idx);
> @@ -276,44 +289,55 @@ pvr_power_device_resume(struct device *dev)
>         if (!drm_dev_enter(drm_dev, &idx))
>                 return -EIO;
>
> -       err =3D clk_prepare_enable(pvr_dev->core_clk);
> -       if (err)
> -               goto err_drm_dev_exit;
> +       if (pvr_dev->pwrseq) {
> +               err =3D pwrseq_power_on(pvr_dev->pwrseq);
> +               if (err)
> +                       goto err_drm_dev_exit;
> +       } else {
> +               err =3D clk_prepare_enable(pvr_dev->core_clk);
> +               if (err)
> +                       goto err_drm_dev_exit;
>
> -       err =3D clk_prepare_enable(pvr_dev->sys_clk);
> -       if (err)
> -               goto err_core_clk_disable;
> +               err =3D clk_prepare_enable(pvr_dev->sys_clk);
> +               if (err)
> +                       goto err_core_clk_disable;
>
> -       err =3D clk_prepare_enable(pvr_dev->mem_clk);
> -       if (err)
> -               goto err_sys_clk_disable;
> +               err =3D clk_prepare_enable(pvr_dev->mem_clk);
> +               if (err)
> +                       goto err_sys_clk_disable;
>

In order to decrease the number of if-elses, would it make sense to
put the "manual" and "pwrseq" operations into their own separate
functions and then store addresses of these functions in the device
match data struct as function pointers (instead of the has_pwrseq
flag)? This way we'd just call them directly.

Bart


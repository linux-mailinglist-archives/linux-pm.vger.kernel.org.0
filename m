Return-Path: <linux-pm+bounces-39833-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3274ECD8CE5
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 11:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A18393001BD2
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 10:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBC235E55E;
	Tue, 23 Dec 2025 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="hFB+ptqm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED26C35E531
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766485422; cv=none; b=j/5cIuH8jgFXyFKG6ez7zMLInywYAcGEeGieQ2JtfXGd/dnw3HsCfD7P2r8HPQL9DovuU8HnXZ9QBfL1H9qgzlC/yutzaRd+Uok4dM0lSRZlRP9a2j8icvTAsWyx8w37gFE2Oi1v28sErVAPtQNXAqpqRG0oppEF9iG8iAH7qVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766485422; c=relaxed/simple;
	bh=9xpk2FA/LZvu6BpdclMfWtz4l3CkeFvlN+H71Eo47ME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XODhm4OCWUYmmdMcHkOGTU0EyOlTmAkDRNF3vrSqdaNyEUH515IidU1N+bEOoQpFyEgPRdMH6KZs72NBb0hme/w7QUhRUebC88NUyfXq5Erp4k6PYVjm+Ll0nSckp7T3C6iObU4/SobvfM5tokQyLJgF8z+2ZF/JRYXvieinEv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=hFB+ptqm; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78c6a53187dso38235887b3.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 02:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1766485418; x=1767090218; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UlhETS7/kFMdpmyZp8uXws6d7GG/7QM6EmMT9RiTjas=;
        b=hFB+ptqm5I7S551w7E/URmO/p6w0wg9VmivhX6TMB7MR7/Rcbhqmq9Z2DawB65Loy9
         OSE0+iMzC4Cd2gCWAvY4hAz6C6fWTXbHy/77NHo64jJUcWE5HGdO7v+dFspo5D8Kkr/e
         DaD8zBvWyvKZ67JMWbWGOg+6EmxOr9bhZShTKiow9uo15lvPYHGBusp4Yj36u3ooQl9/
         C0MhIgX/Ajd9JCkcH4wyuK/sb2i1WpPaSASyLN3ZgOM955dJJ6UwjTEylTqBR4T8i/un
         qJ61wyztEDHeXaDWFleqeFZ+EzE/0+ZdqaLfibyiV+sMsfQJDkKBPCsI1lcUvJq9U4tx
         PmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766485418; x=1767090218;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlhETS7/kFMdpmyZp8uXws6d7GG/7QM6EmMT9RiTjas=;
        b=XvosH1u3zQP48M3xbfTxz8VU3zypFuOcX4HPjnLomLRjF2ejHHPgrJeDox1UhEdzZs
         mJC/kplx00+r08L/Tn5mcgwSHqT6Q5c+8w7Qsjh7XmmhlbwAlXQGDS5THVxHLsRGFLiq
         Sb6K1B0YoHa8oXeEt/zRh83+S7f/XHGLVJMY1ViG7fA1Ou2ugqtmcCsElxRtxms7nf9a
         VKYEneLCg0ts6MA0/vuTZlU/z7smcfco+vpP/yXT0TE2mLsWnLwwKtVJImPO0PVvMm9m
         47rnKSkiyDWRFWRFcNUZ0RKI4rfu8dm6Mfmyv2n3msa+UxXPAMulSSY9su8P51zoRYtd
         Ok9A==
X-Gm-Message-State: AOJu0YyW4mZv5p9A+/8anIZeBd/QmeB0aqlVsoXdaIGZ5ZDUCZ6qvTL0
	ztfG0otO4Vuyrz9MgN4PSgNpDVt4cRdlGRz9Swg+fEHgE1aYIpHjIvt6h2vh9i2zkcxwPp0Vx31
	+TLuhhRzXPXpyK8ycvkgd1WJEFfDQW2R/cQAGtjAt2Q==
X-Gm-Gg: AY/fxX5nz3L8g8CZhrkhV4tBWlzHNWuBc704qln81u4hiyHtuYbEkjVAwGQ2J2zVK4y
	oNQtwks4Th1BHGW6X797nJRr45UDmIxFlZ9AUkb1WaivOadPn4kP/DHYmSRNPfAqw2KOnAdzcgT
	TIynP8ugAdEIO6pda/HoyG343/jpByoklXvKlWcz+4wswnWUp/YtjjxHne3IcPfFcqOH1/Pgkl2
	RYYeIPAMhnFtu9Yx8U8aNZ3sbKy1CJiOPoAcxLfPH+60j1kBLTm7G59UdZxvHMvoXYOF5hqhDcw
	kO9T1kwCZ3KW1cBQG+ovqqNB5J0=
X-Google-Smtp-Source: AGHT+IFnf13U6Ikz16XDuf5ZDc4vmAituFzAXSaLSV0CwD1Jp327Q008LcjqhybrfbyhfayJFBxuTuwR8kI2KEjgIY8=
X-Received: by 2002:a05:690e:1883:b0:63f:ab07:def with SMTP id
 956f58d0204a3-6466a901125mr9125733d50.59.1766485418165; Tue, 23 Dec 2025
 02:23:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki> <3045480.e9J7NaK4W3@rafael.j.wysocki>
In-Reply-To: <3045480.e9J7NaK4W3@rafael.j.wysocki>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 23 Dec 2025 10:23:21 +0000
X-Gm-Features: AQt7F2q5j8iCScxuKrDJdn6a0Mw5tIUxNBazZbfeydozNI3XFwXBXhSVIstZQCM
Message-ID: <CAPY8ntBrcpqHjVAqkc2r4Map+dUBfNsHZPN22AYdUWi+QmVYrg@mail.gmail.com>
Subject: Re: [PATCH v1 03/23] drm: Discard pm_runtime_put() return value
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Brian Norris <briannorris@chromium.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Liu Ying <victor.liu@nxp.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Dec 2025 at 20:38, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Multiple DRM drivers use the pm_runtime_put() return value for printing
> debug or even error messages and all of those messages are at least
> somewhat misleading.
>
> Returning an error code from pm_runtime_put() merely means that it has
> not queued up a work item to check whether or not the device can be
> suspended and there are many perfectly valid situations in which that
> can happen, like after writing "on" to the devices' runtime PM "control"
> attribute in sysfs for one example.  It also happens when the kernel
> has been configured with CONFIG_PM unset.
>
> For this reason, modify all of those drivers to simply discard the
> pm_runtime_put() return value which is what they should be doing.
>
> This will facilitate a planned change of the pm_runtime_put() return
> type to void in the future.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> This patch is part of a series, but it doesn't depend on anything else
> in that series.  The last patch in the series depends on it.
>
> It can be applied by itself and if you decide to do so, please let me
> know.
>
> Otherwise, an ACK or equivalent will be appreciated, but also the lack
> of specific criticism will be eventually regarded as consent.
>
> ---
>  drivers/gpu/drm/arm/malidp_crtc.c                   |    6 +-----
>  drivers/gpu/drm/bridge/imx/imx8qm-ldb.c             |    4 +---
>  drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c            |    4 +---
>  drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c |    5 +----
>  drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c        |    5 +----
>  drivers/gpu/drm/imx/dc/dc-crtc.c                    |   12 +++---------
>  drivers/gpu/drm/vc4/vc4_hdmi.c                      |    5 +----
>  drivers/gpu/drm/vc4/vc4_vec.c                       |   12 ++----------

For vc4_hdmi and vc4_vec:

Acked-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

>  8 files changed, 11 insertions(+), 42 deletions(-)
>
> --- a/drivers/gpu/drm/arm/malidp_crtc.c
> +++ b/drivers/gpu/drm/arm/malidp_crtc.c
> @@ -77,7 +77,6 @@ static void malidp_crtc_atomic_disable(s
>                                                                          crtc);
>         struct malidp_drm *malidp = crtc_to_malidp_device(crtc);
>         struct malidp_hw_device *hwdev = malidp->dev;
> -       int err;
>
>         /* always disable planes on the CRTC that is being turned off */
>         drm_atomic_helper_disable_planes_on_crtc(old_state, false);
> @@ -87,10 +86,7 @@ static void malidp_crtc_atomic_disable(s
>
>         clk_disable_unprepare(hwdev->pxlclk);
>
> -       err = pm_runtime_put(crtc->dev->dev);
> -       if (err < 0) {
> -               DRM_DEBUG_DRIVER("Failed to disable runtime power management: %d\n", err);
> -       }
> +       pm_runtime_put(crtc->dev->dev);
>  }
>
>  static const struct gamma_curve_segment {
> --- a/drivers/gpu/drm/bridge/imx/imx8qm-ldb.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8qm-ldb.c
> @@ -280,9 +280,7 @@ static void imx8qm_ldb_bridge_atomic_dis
>         clk_disable_unprepare(imx8qm_ldb->clk_bypass);
>         clk_disable_unprepare(imx8qm_ldb->clk_pixel);
>
> -       ret = pm_runtime_put(dev);
> -       if (ret < 0)
> -               DRM_DEV_ERROR(dev, "failed to put runtime PM: %d\n", ret);
> +       pm_runtime_put(dev);
>  }
>
>  static const u32 imx8qm_ldb_bus_output_fmts[] = {
> --- a/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
> @@ -282,9 +282,7 @@ static void imx8qxp_ldb_bridge_atomic_di
>         if (is_split && companion)
>                 companion->funcs->atomic_disable(companion, state);
>
> -       ret = pm_runtime_put(dev);
> -       if (ret < 0)
> -               DRM_DEV_ERROR(dev, "failed to put runtime PM: %d\n", ret);
> +       pm_runtime_put(dev);
>  }
>
>  static const u32 imx8qxp_ldb_bus_output_fmts[] = {
> --- a/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c
> @@ -181,11 +181,8 @@ static void imx8qxp_pc_bridge_atomic_dis
>  {
>         struct imx8qxp_pc_channel *ch = bridge->driver_private;
>         struct imx8qxp_pc *pc = ch->pc;
> -       int ret;
>
> -       ret = pm_runtime_put(pc->dev);
> -       if (ret < 0)
> -               DRM_DEV_ERROR(pc->dev, "failed to put runtime PM: %d\n", ret);
> +       pm_runtime_put(pc->dev);
>  }
>
>  static const u32 imx8qxp_pc_bus_output_fmts[] = {
> --- a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
> @@ -127,11 +127,8 @@ static void imx8qxp_pxl2dpi_bridge_atomi
>                                                   struct drm_atomic_state *state)
>  {
>         struct imx8qxp_pxl2dpi *p2d = bridge->driver_private;
> -       int ret;
>
> -       ret = pm_runtime_put(p2d->dev);
> -       if (ret < 0)
> -               DRM_DEV_ERROR(p2d->dev, "failed to put runtime PM: %d\n", ret);
> +       pm_runtime_put(p2d->dev);
>
>         if (p2d->companion)
>                 p2d->companion->funcs->atomic_disable(p2d->companion, state);
> --- a/drivers/gpu/drm/imx/dc/dc-crtc.c
> +++ b/drivers/gpu/drm/imx/dc/dc-crtc.c
> @@ -300,7 +300,7 @@ dc_crtc_atomic_disable(struct drm_crtc *
>                                 drm_atomic_get_new_crtc_state(state, crtc);
>         struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
>         struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
> -       int idx, ret;
> +       int idx;
>
>         if (!drm_dev_enter(crtc->dev, &idx))
>                 goto out;
> @@ -313,16 +313,10 @@ dc_crtc_atomic_disable(struct drm_crtc *
>         dc_fg_disable_clock(dc_crtc->fg);
>
>         /* request pixel engine power-off as plane is off too */
> -       ret = pm_runtime_put(dc_drm->pe->dev);
> -       if (ret)
> -               dc_crtc_err(crtc, "failed to put DC pixel engine RPM: %d\n",
> -                           ret);
> +       pm_runtime_put(dc_drm->pe->dev);
>
>         /* request display engine power-off when CRTC is disabled */
> -       ret = pm_runtime_put(dc_crtc->de->dev);
> -       if (ret < 0)
> -               dc_crtc_err(crtc, "failed to put DC display engine RPM: %d\n",
> -                           ret);
> +       pm_runtime_put(dc_crtc->de->dev);
>
>         drm_dev_exit(idx);
>
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -848,7 +848,6 @@ static void vc4_hdmi_encoder_post_crtc_p
>         struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
>         struct drm_device *drm = vc4_hdmi->connector.dev;
>         unsigned long flags;
> -       int ret;
>         int idx;
>
>         mutex_lock(&vc4_hdmi->mutex);
> @@ -867,9 +866,7 @@ static void vc4_hdmi_encoder_post_crtc_p
>         clk_disable_unprepare(vc4_hdmi->pixel_bvb_clock);
>         clk_disable_unprepare(vc4_hdmi->pixel_clock);
>
> -       ret = pm_runtime_put(&vc4_hdmi->pdev->dev);
> -       if (ret < 0)
> -               drm_err(drm, "Failed to release power domain: %d\n", ret);
> +       pm_runtime_put(&vc4_hdmi->pdev->dev);
>
>         drm_dev_exit(idx);
>
> --- a/drivers/gpu/drm/vc4/vc4_vec.c
> +++ b/drivers/gpu/drm/vc4/vc4_vec.c
> @@ -542,7 +542,7 @@ static void vc4_vec_encoder_disable(stru
>  {
>         struct drm_device *drm = encoder->dev;
>         struct vc4_vec *vec = encoder_to_vc4_vec(encoder);
> -       int idx, ret;
> +       int idx;
>
>         if (!drm_dev_enter(drm, &idx))
>                 return;
> @@ -556,17 +556,9 @@ static void vc4_vec_encoder_disable(stru
>
>         clk_disable_unprepare(vec->clock);
>
> -       ret = pm_runtime_put(&vec->pdev->dev);
> -       if (ret < 0) {
> -               drm_err(drm, "Failed to release power domain: %d\n", ret);
> -               goto err_dev_exit;
> -       }
> +       pm_runtime_put(&vec->pdev->dev);
>
>         drm_dev_exit(idx);
> -       return;
> -
> -err_dev_exit:
> -       drm_dev_exit(idx);
>  }
>
>  static void vc4_vec_encoder_enable(struct drm_encoder *encoder,
>
>
>


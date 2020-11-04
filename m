Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1922A646A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 13:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbgKDMcV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 07:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729227AbgKDMcU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 07:32:20 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF97C0613D3;
        Wed,  4 Nov 2020 04:32:19 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id t13so22705315ljk.12;
        Wed, 04 Nov 2020 04:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=WeIfqXGwoq63ONx1sO5j9B808BBmaXQhJPEuc3bw8vw=;
        b=aHPstKjpE+vLjyZQjBakxtssBn9fBy07xCyp3SNI527c0yRVzqiL8sQl22ul1S0/Ev
         RanpD61BJaFeXCvYdRnosPy+Q7MU1/3AyWT8Uj0GUmGEERCXA7/Gsc7RtWOtWgjMqf1c
         vj0ZnZnOX/en0x7i8IpU+4cojci6fMqGwxvn/dzGJO8r8t9V+RF/I5aOABUjetI2ws3A
         ewKtThIFhWzTwCQ2K44M4HjPYgKxO1HZmgFVzuJUmXrYSLXnVWmTtuXixFDMosgEijvz
         B3XUGhwOXiZuQblOkL0hROBQjHUyzB7nt0PFv3IkGdLIO4ErphMQTdC1t41aGOf9HtyG
         pkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=WeIfqXGwoq63ONx1sO5j9B808BBmaXQhJPEuc3bw8vw=;
        b=K905nBEgvXDlKx6M1fP1AOEJm/2oAlr3mp6+ilMz4qujoLoh6WjoqvOQihp0wgohQz
         gxX04yIL8csT2Jgq0M3p+Wky3jYLqADYNK6YSt79NkIn2VQ/QIqPsNMNAWWkArKUwyNO
         6G4Zkd+70jKvo1EY3MmAaBFCBiaCR5E/ZgqApbGG17K0EqAg8CpbkSf2JEnNttKafxPj
         wh/sb8Gqhck+lq3kwRxy5pMcwexhtvgyFHZs5TgRcOvOL05z77ctiFZdQPdYz6IgwuEq
         i5Wp3GOg/fCmWtUkxaflLpTM6XyX1V7xs0d6lAt7N2WI8CGiULLWNgsOAAkkwmeQwcsq
         775g==
X-Gm-Message-State: AOAM530qxwHX8nsxHGCXaLnTbFViwWq8KPu3QoLmPJ740nDlKW7gZ+gq
        E1CCyKFpt/fCw3akx/Cju0WFCUyEt3xOxCauiSc09ZjbGLsQuQ==
X-Google-Smtp-Source: ABdhPJwRH8EBDgHLh4cqieAv3up0pK65ln8svgnmQ871aXdne26gPrlkQ2eTGqZVMmJ0BAUuXccD9IgeowbrVkPSF14=
X-Received: by 2002:a2e:681a:: with SMTP id c26mr11035328lja.56.1604493138330;
 Wed, 04 Nov 2020 04:32:18 -0800 (PST)
MIME-Version: 1.0
References: <CGME20201104103730eucas1p2964e5910a1319fc1c931db8f02a447de@eucas1p2.samsung.com>
 <20201104103657.18007-1-s.nawrocki@samsung.com> <20201104103657.18007-8-s.nawrocki@samsung.com>
In-Reply-To: <20201104103657.18007-8-s.nawrocki@samsung.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Wed, 4 Nov 2020 21:31:41 +0900
Message-ID: <CAGTfZH07vV49o_c-QTkF_1LqQpymFAd6zwBnawukwiE0ZBM9vw@mail.gmail.com>
Subject: Re: [PATCH v8 7/7] drm: exynos: mixer: Add interconnect support
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sylwester,

On Wed, Nov 4, 2020 at 7:37 PM Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
>
> This patch adds interconnect support to exynos-mixer. The mixer works
> the same as before when CONFIG_INTERCONNECT is 'n'.
>
> For proper operation of the video mixer block we need to ensure the
> interconnect busses like DMC or LEFTBUS provide enough bandwidth so
> as to avoid DMA buffer underruns in the mixer block. I.e we need to
> prevent those busses from operating in low perfomance OPPs when
> the mixer is running.
> In this patch the bus bandwidth request is done through the interconnect
> API, the bandwidth value is calculated from selected DRM mode, i.e.
> video plane width, height, refresh rate and pixel format.
>
> The bandwidth setting is synchronized with VSYNC when we are switching
> to lower bandwidth. This is required to ensure enough bandwidth for
> the device since new settings are normally being applied in the hardware
> synchronously with VSYNC.
>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Co-developed-by: Artur =C5=9Awigo=C5=84 <a.swigon@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes for v8:
>  - updated comment in mixer_probe()
>
> Changes for v7:
>  - fixed incorrect setting of the ICC bandwidth when the mixer is
>    disabled, now the bandwidth is set explicitly to 0 in such case.
>
> Changes for v6:
>  - the icc_set_bw() call is now only done when calculated value for
>    a crtc changes, this avoids unnecessary calls per each video frame
>  - added synchronization of the interconnect bandwidth setting with
>    the mixer VSYNC in order to avoid buffer underflow when we lower
>    the interconnect bandwidth when the hardware still operates with
>    previous mode settings that require higher bandwidth. This fixed
>    IOMMU faults observed e.g. during switching from two planes to
>    a single plane operation.
>
> Changes for v5:
>  - renamed soc_path variable to icc_path
> ---
>  drivers/gpu/drm/exynos/exynos_mixer.c | 146 ++++++++++++++++++++++++++++=
++++--
>  1 file changed, 138 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exyn=
os/exynos_mixer.c
> index af192e5..8c1509e 100644
> --- a/drivers/gpu/drm/exynos/exynos_mixer.c
> +++ b/drivers/gpu/drm/exynos/exynos_mixer.c
> @@ -13,6 +13,7 @@
>  #include <linux/component.h>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> +#include <linux/interconnect.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
> @@ -73,6 +74,7 @@ enum mixer_flag_bits {
>         MXR_BIT_INTERLACE,
>         MXR_BIT_VP_ENABLED,
>         MXR_BIT_HAS_SCLK,
> +       MXR_BIT_REQUEST_BW,
>  };
>
>  static const uint32_t mixer_formats[] =3D {
> @@ -99,6 +101,13 @@ struct mixer_context {
>         struct exynos_drm_plane planes[MIXER_WIN_NR];
>         unsigned long           flags;
>
> +       struct icc_path         *icc_path;
> +       /* memory bandwidth on the interconnect bus in B/s */
> +       unsigned long           icc_bandwidth;
> +       /* mutex protecting @icc_bandwidth */
> +       struct mutex            icc_lock;
> +       struct work_struct      work;
> +
>         int                     irq;
>         void __iomem            *mixer_regs;
>         void __iomem            *vp_regs;
> @@ -754,6 +763,9 @@ static irqreturn_t mixer_irq_handler(int irq, void *a=
rg)
>                 val |=3D MXR_INT_CLEAR_VSYNC;
>                 val &=3D ~MXR_INT_STATUS_VSYNC;
>
> +               if (test_and_clear_bit(MXR_BIT_REQUEST_BW, &ctx->flags))
> +                       schedule_work(&ctx->work);
> +
>                 /* interlace scan need to check shadow register */
>                 if (test_bit(MXR_BIT_INTERLACE, &ctx->flags)
>                     && !mixer_is_synced(ctx))
> @@ -934,6 +946,76 @@ static void mixer_disable_vblank(struct exynos_drm_c=
rtc *crtc)
>         mixer_reg_writemask(mixer_ctx, MXR_INT_EN, 0, MXR_INT_EN_VSYNC);
>  }
>
> +/**
> + * mixer_get_memory_bandwidth - calculate memory bandwidth for current c=
rtc mode
> + * @crtc: a crtc with DRM mode to calculate the bandwidth for
> + *
> + * Return: memory bandwidth in B/s
> + *
> + * This function returns memory bandwidth calculated as a sum of amount =
of data
> + * per second for each plane. The calculation is based on maximum possib=
le pixel
> + * resolution for a plane so as to avoid different bandwidth request per=
 each
> + * video frame. The formula used for calculation for each plane is:
> + *
> + * bw =3D width * height * frame_rate / interlace / (hor_subs * vert_sub=
s)
> + *
> + * where:
> + *  - width, height - (DRM mode) video frame width and height in pixels,
> + *  - frame_rate - DRM mode frame refresh rate,
> + *  - interlace: 1 - in case of progressive and 2 in case of interlaced =
video,
> + *  - hor_subs, vert_subs - accordingly horizontal and vertical pixel
> + *    subsampling for a plane.
> + */
> +static unsigned int mixer_get_memory_bandwidth(struct exynos_drm_crtc *c=
rtc)
> +{
> +       struct drm_display_mode *mode =3D &crtc->base.state->adjusted_mod=
e;
> +       struct mixer_context *ctx =3D crtc->ctx;
> +       unsigned long bw, bandwidth =3D 0;
> +       int i, j, sub;
> +
> +       for (i =3D 0; i < MIXER_WIN_NR; i++) {
> +               struct drm_plane *plane =3D &ctx->planes[i].base;
> +               const struct drm_format_info *format;
> +
> +               if (plane->state && plane->state->crtc && plane->state->f=
b) {
> +                       format =3D plane->state->fb->format;
> +                       bw =3D mode->hdisplay * mode->vdisplay *
> +                                                       drm_mode_vrefresh=
(mode);
> +                       if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> +                               bw /=3D 2;
> +                       for (j =3D 0; j < format->num_planes; j++) {
> +                               sub =3D j ? (format->vsub * format->hsub)=
 : 1;
> +                               bandwidth +=3D format->cpp[j] * bw / sub;
> +                       }
> +               }
> +       }
> +
> +       return bandwidth;
> +}
> +
> +static void mixer_set_icc_bandwidth(struct mixer_context *ctx,
> +                                   unsigned long bandwidth)
> +{
> +       u32 avg_bw, peak_bw;
> +
> +       /* add 20% safety margin */
> +       bandwidth =3D bandwidth / 4 * 5;
> +
> +       avg_bw =3D peak_bw =3D Bps_to_icc(bandwidth);
> +       icc_set_bw(ctx->icc_path, avg_bw, peak_bw);
> +
> +       dev_dbg(ctx->dev, "safe bandwidth %lu Bps\n", bandwidth);
> +}
> +
> +static void mixer_icc_request_fn(struct work_struct *work)
> +{
> +       struct mixer_context *ctx =3D container_of(work, struct mixer_con=
text,
> +                                                work);
> +       mutex_lock(&ctx->icc_lock);
> +       mixer_set_icc_bandwidth(ctx, ctx->icc_bandwidth);
> +       mutex_unlock(&ctx->icc_lock);
> +}
> +
>  static void mixer_atomic_begin(struct exynos_drm_crtc *crtc)
>  {
>         struct mixer_context *ctx =3D crtc->ctx;
> @@ -980,12 +1062,35 @@ static void mixer_disable_plane(struct exynos_drm_=
crtc *crtc,
>
>  static void mixer_atomic_flush(struct exynos_drm_crtc *crtc)
>  {
> -       struct mixer_context *mixer_ctx =3D crtc->ctx;
> +       struct mixer_context *ctx =3D crtc->ctx;
> +       int bw, prev_bw;
>
> -       if (!test_bit(MXR_BIT_POWERED, &mixer_ctx->flags))
> +       if (!test_bit(MXR_BIT_POWERED, &ctx->flags))
>                 return;
>
> -       mixer_enable_sync(mixer_ctx);
> +       /*
> +        * Request necessary bandwidth on the interconnects. If new
> +        * bandwidth is greater than current value set the new value
> +        * immediately. Otherwise request lower bandwidth only after
> +        * VSYNC, after the HW has actually switched to new video
> +        * frame settings.
> +        */
> +       if (ctx->icc_path) {
> +               bw =3D mixer_get_memory_bandwidth(crtc);
> +
> +               mutex_lock(&ctx->icc_lock);
> +               prev_bw =3D ctx->icc_bandwidth;
> +               ctx->icc_bandwidth =3D bw;
> +
> +               if (bw > prev_bw)
> +                       mixer_set_icc_bandwidth(ctx, bw);
> +               else if (bw < prev_bw)
> +                       set_bit(MXR_BIT_REQUEST_BW, &ctx->flags);
> +
> +               mutex_unlock(&ctx->icc_lock);
> +       }
> +
> +       mixer_enable_sync(ctx);
>         exynos_crtc_handle_event(crtc);
>  }
>
> @@ -1036,6 +1141,8 @@ static void mixer_atomic_disable(struct exynos_drm_=
crtc *crtc)
>
>         pm_runtime_put(ctx->dev);
>
> +       mixer_set_icc_bandwidth(ctx, 0);
> +
>         clear_bit(MXR_BIT_POWERED, &ctx->flags);
>  }
>
> @@ -1223,19 +1330,33 @@ static int mixer_probe(struct platform_device *pd=
ev)
>         struct device *dev =3D &pdev->dev;
>         const struct mixer_drv_data *drv;
>         struct mixer_context *ctx;
> +       struct icc_path *path;
>         int ret;
>
> +       /*
> +        * Returns NULL if CONFIG_INTERCONNECT is disabled or if "interco=
nnects"
> +        * property does not exist. May return ERR_PTR(-EPROBE_DEFER).
> +        */
> +       path =3D of_icc_get(dev, NULL);
> +       if (IS_ERR(path))
> +               return PTR_ERR(path);
> +
>         ctx =3D devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
>         if (!ctx) {
>                 DRM_DEV_ERROR(dev, "failed to alloc mixer context.\n");
> -               return -ENOMEM;
> +               ret =3D -ENOMEM;
> +               goto err;
>         }
>
>         drv =3D of_device_get_match_data(dev);
>
> +       INIT_WORK(&ctx->work, mixer_icc_request_fn);
> +       mutex_init(&ctx->icc_lock);
> +
>         ctx->pdev =3D pdev;
>         ctx->dev =3D dev;
>         ctx->mxr_ver =3D drv->version;
> +       ctx->icc_path =3D path;
>
>         if (drv->is_vp_enabled)
>                 __set_bit(MXR_BIT_VP_ENABLED, &ctx->flags);
> @@ -1247,17 +1368,26 @@ static int mixer_probe(struct platform_device *pd=
ev)
>         pm_runtime_enable(dev);
>
>         ret =3D component_add(&pdev->dev, &mixer_component_ops);
> -       if (ret)
> +       if (ret) {
>                 pm_runtime_disable(dev);
> -
> +               goto err;
> +       }
> +       return 0;
> +err:
> +       icc_put(path);
>         return ret;
>  }
>
>  static int mixer_remove(struct platform_device *pdev)
>  {
> -       pm_runtime_disable(&pdev->dev);
> +       struct device *dev =3D &pdev->dev;
> +       struct mixer_context *ctx =3D dev_get_drvdata(dev);
> +
> +       pm_runtime_disable(dev);
> +
> +       component_del(dev, &mixer_component_ops);
>
> -       component_del(&pdev->dev, &mixer_component_ops);
> +       icc_put(ctx->icc_path);
>
>         return 0;
>  }
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

--=20
Best Regards,
Chanwoo Choi

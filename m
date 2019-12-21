Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADA6128B6E
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2019 21:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfLUUPq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Dec 2019 15:15:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbfLUUPq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 21 Dec 2019 15:15:46 -0500
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 738AE206D8;
        Sat, 21 Dec 2019 20:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576959344;
        bh=5ebffvH8RjGUA/CqJXLR3seJ47MPgsm90kIrp/SYkC8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rRET7jGuQ9x3Bi6G6g9O1ZUsM1zX4zsiWIx1Nt2RxjGBVszQtqOvdsBF44Zl2BSMt
         1/06vhY22BJ5Irc1JeHg41UBKX9WzhDW+rNMBK5x0tDO6y0e+Cza/GHqV8Sw63s/01
         lpUg9+MvHXTQwpVg2VaK0P17ndrD+m0kBl/sU1CI=
Received: by mail-lj1-f182.google.com with SMTP id a13so13616145ljm.10;
        Sat, 21 Dec 2019 12:15:44 -0800 (PST)
X-Gm-Message-State: APjAAAVY7MI3xsJU4gSDsvwvV8KoMBDiSSmJB1iMp9cB2mQtfgNLgyu5
        IMnYJdjLvC6kiyRb8IfarSkHv2IKpwOOdf3KesQ=
X-Google-Smtp-Source: APXvYqw/wOkj3/7bhV08O1Y2ozplefUJRTEti5Jg7xBvbgQ90EBzcMhD9yqJ5nlEbYLGWhZbqzIfqislmtInQwBiECg=
X-Received: by 2002:a2e:9b05:: with SMTP id u5mr13652547lji.59.1576959342597;
 Sat, 21 Dec 2019 12:15:42 -0800 (PST)
MIME-Version: 1.0
References: <CGME20191220120146eucas1p22a7b0457be4f378b113f67dc25f2eba7@eucas1p2.samsung.com>
 <20191220115653.6487-1-a.swigon@samsung.com> <20191220115653.6487-8-a.swigon@samsung.com>
In-Reply-To: <20191220115653.6487-8-a.swigon@samsung.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Sun, 22 Dec 2019 05:15:06 +0900
X-Gmail-Original-Message-ID: <CAGTfZH0LKmBzAokgN+2K4-PS87gc2GnchYaHJi33nMQBCTNS-g@mail.gmail.com>
Message-ID: <CAGTfZH0LKmBzAokgN+2K4-PS87gc2GnchYaHJi33nMQBCTNS-g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 7/7] drm: exynos: mixer: Add interconnect support
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, inki.dae@samsung.com,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Fri, Dec 20, 2019 at 9:03 PM Artur =C5=9Awigo=C5=84 <a.swigon@samsung.co=
m> wrote:
>
> From: Marek Szyprowski <m.szyprowski@samsung.com>
>
> This patch adds interconnect support to exynos-mixer. The mixer works
> the same as before when CONFIG_INTERCONNECT is 'n'.

The patch description doesn't include why interconnect is required
and what to do.

>
> Co-developed-by: Artur =C5=9Awigo=C5=84 <a.swigon@samsung.com>
> Signed-off-by: Artur =C5=9Awigo=C5=84 <a.swigon@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_mixer.c | 71 +++++++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exyn=
os/exynos_mixer.c
> index 6cfdb95fef2f..a7e7240a055f 100644
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
> @@ -97,6 +98,7 @@ struct mixer_context {
>         struct exynos_drm_crtc  *crtc;
>         struct exynos_drm_plane planes[MIXER_WIN_NR];
>         unsigned long           flags;
> +       struct icc_path         *soc_path;
>
>         int                     irq;
>         void __iomem            *mixer_regs;
> @@ -931,6 +933,40 @@ static void mixer_disable_vblank(struct exynos_drm_c=
rtc *crtc)
>         mixer_reg_writemask(mixer_ctx, MXR_INT_EN, 0, MXR_INT_EN_VSYNC);
>  }
>
> +static void mixer_set_memory_bandwidth(struct exynos_drm_crtc *crtc)
> +{
> +       struct drm_display_mode *mode =3D &crtc->base.state->adjusted_mod=
e;
> +       struct mixer_context *ctx =3D crtc->ctx;
> +       unsigned long bw, bandwidth =3D 0;
> +       int i, j, sub;
> +
> +       if (!ctx->soc_path)
> +               return;
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
> +       /* add 20% safety margin */
> +       bandwidth =3D bandwidth / 4 * 5;
> +
> +       dev_dbg(ctx->dev, "exynos-mixer: safe bandwidth %ld Bps\n", bandw=
idth);
> +       icc_set_bw(ctx->soc_path, Bps_to_icc(bandwidth), 0);
> +}

I recommend that add the role of this function in order to guarantee
the minimum bandwidth to prevent performance drop or h/w issue.

> +
>  static void mixer_atomic_begin(struct exynos_drm_crtc *crtc)
>  {
>         struct mixer_context *ctx =3D crtc->ctx;
> @@ -982,6 +1018,7 @@ static void mixer_atomic_flush(struct exynos_drm_crt=
c *crtc)
>         if (!test_bit(MXR_BIT_POWERED, &mixer_ctx->flags))
>                 return;
>
> +       mixer_set_memory_bandwidth(crtc);
>         mixer_enable_sync(mixer_ctx);
>         exynos_crtc_handle_event(crtc);
>  }
> @@ -1029,6 +1066,7 @@ static void mixer_disable(struct exynos_drm_crtc *c=
rtc)
>         for (i =3D 0; i < MIXER_WIN_NR; i++)
>                 mixer_disable_plane(crtc, &ctx->planes[i]);
>
> +       mixer_set_memory_bandwidth(crtc);
>         exynos_drm_pipe_clk_enable(crtc, false);
>
>         pm_runtime_put(ctx->dev);
> @@ -1220,12 +1258,22 @@ static int mixer_probe(struct platform_device *pd=
ev)
>         struct device *dev =3D &pdev->dev;
>         const struct mixer_drv_data *drv;
>         struct mixer_context *ctx;
> +       struct icc_path *path;
>         int ret;
>
> +       /*
> +        * Returns NULL if CONFIG_INTERCONNECT is disabled.
> +        * May return ERR_PTR(-EPROBE_DEFER).
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
> @@ -1233,6 +1281,7 @@ static int mixer_probe(struct platform_device *pdev=
)
>         ctx->pdev =3D pdev;
>         ctx->dev =3D dev;
>         ctx->mxr_ver =3D drv->version;
> +       ctx->soc_path =3D path;
>
>         if (drv->is_vp_enabled)
>                 __set_bit(MXR_BIT_VP_ENABLED, &ctx->flags);
> @@ -1242,17 +1291,29 @@ static int mixer_probe(struct platform_device *pd=
ev)
>         platform_set_drvdata(pdev, ctx);
>
>         ret =3D component_add(&pdev->dev, &mixer_component_ops);
> -       if (!ret)
> -               pm_runtime_enable(dev);
> +       if (ret < 0)
> +               goto err;
> +
> +       pm_runtime_enable(dev);
> +
> +       return 0;
> +
> +err:
> +       icc_put(path);
>
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
> +       icc_put(ctx->soc_path);
>
>         return 0;
>  }
> --
> 2.17.1
>

Basically, I agree this patch about using ICC feature
to guarantee the minimum bandwidth. But, I don't have
the knowledge of exynos-mixer.c. So, just I reviewed
the part of ICC usage. After digging the exynos-mixer.c,
I'll reply the reviewed tag. Thanks.

--=20
Best Regards,
Chanwoo Choi

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC33E180FCE
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 06:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgCKFXR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 01:23:17 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42110 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgCKFXR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2020 01:23:17 -0400
Received: by mail-ed1-f65.google.com with SMTP id n18so1318230edw.9
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2020 22:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JM9zu4grKzwKY2OIbM2yqTOoFgqOAS5Vs32abRmGmUM=;
        b=KQwCs+/l9EaTxy3RwXy50wGVDvK1dSgCff/KUauW5pN1fszV3LSPQc2T2D0ZiwIx9t
         It135UhmhIw3RafGKWFO5x46JRKtPf/yCz3+ghgGnnBX0vLOrx8pa7ofGX5mLaBZ/FU9
         KNfPSwQwjCMRyuMwYpUTRRnmURbl3WDAw8ZuJO+7SSiVfLYLDkV0hxkTkbGrufYD2xq9
         LUVrfmy/I7z1CrtTBF9CzaixYTGyHPvApKxsAxYr4bms5hIc+bhw6HeVx6RgQ3+5H/UD
         tQJtbuSVnpB0YgV/ePW0f6Po03AqU3xPr34KwUBX0xzTVlNvjK4PZx7zbGbUeT+ggO+k
         Mbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JM9zu4grKzwKY2OIbM2yqTOoFgqOAS5Vs32abRmGmUM=;
        b=dMprqYAQX7tWM4sxw9WLuMBzABoCdiwHjxlVx1r4Dfp9VSJwUQIsOSqg0tGLIUHIRE
         8/KxqpUYGCde/nqtBiCAgRkwEoMGQObomTmfWHexygwOyjTZ1g7GkWanQsWszjTYOfD+
         cxCu4+EEJK2nsFUavINE99OaImNJAtkG/jxIvfx6wc/sWu96n51fgKaYACys3H2Xs5Na
         32V2OcJ79ns1L88eGmt37VjwvaUgdTV/NpXaoB9eBqUKGj+qQTYFEr+gcYNBIYNQ9JtN
         jg57H1U+7mDbYg6dnImxfNviYXOfxv3o6mW+4SXxMSn1VynF0IdMyBcZKvNW/WROzJF8
         LSNQ==
X-Gm-Message-State: ANhLgQ3h9+57U7bT/THASXxPPlJPbJ9Ye2qfmypkwR4CSgDTpFlbdhts
        AzRR4OpxRSWyKIe56eHEY+Ny1teWrseDnNFPz3QRBw==
X-Google-Smtp-Source: ADFU+vuTDvC9t080L+LZ2YE+PW/zd8Eu9TQJoE8XAM9NvA1Xqm/2oKnjT2jJhZKEQMuGlrbALvs8u36+drjZYwbvN/E=
X-Received: by 2002:a17:906:385:: with SMTP id b5mr913477eja.268.1583904194983;
 Tue, 10 Mar 2020 22:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583896344.git.joe@perches.com> <2e6818291503f032e7662f1fa45fb64c7751a7ae.1583896348.git.joe@perches.com>
In-Reply-To: <2e6818291503f032e7662f1fa45fb64c7751a7ae.1583896348.git.joe@perches.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 11 Mar 2020 10:53:03 +0530
Message-ID: <CAHLCerPFWFoUpt6Soc1awDiCy6aBn=qTbQ8G5vjhmX-g2=8znA@mail.gmail.com>
Subject: Re: [PATCH -next 011/491] ARM/QUALCOMM SUPPORT: Use fallthrough;
To:     Joe Perches <joe@perches.com>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-media@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 11, 2020 at 10:37 AM Joe Perches <joe@perches.com> wrote:
>
> Convert the various uses of fallthrough comments to fallthrough;
>
> Done via script
> Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/


Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/media/platform/qcom/venus/vdec.c |  2 +-
>  drivers/phy/qualcomm/phy-qcom-usb-hs.c   |  2 +-
>  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c |  4 ++--
>  drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c |  2 +-
>  drivers/rpmsg/qcom_glink_native.c        |  4 ++--
>  drivers/soc/qcom/socinfo.c               | 16 ++++++++--------
>  drivers/thermal/qcom/tsens-v0_1.c        |  8 ++++----
>  drivers/thermal/qcom/tsens-v1.c          |  4 ++--
>  8 files changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index f34920..9e0451 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -983,7 +983,7 @@ static int vdec_stop_capture(struct venus_inst *inst)
>         switch (inst->codec_state) {
>         case VENUS_DEC_STATE_DECODING:
>                 ret = hfi_session_flush(inst, HFI_FLUSH_ALL);
> -               /* fallthrough */
> +               fallthrough;
>         case VENUS_DEC_STATE_DRAIN:
>                 vdec_cancel_dst_buffers(inst);
>                 inst->codec_state = VENUS_DEC_STATE_STOPPED;
> diff --git a/drivers/phy/qualcomm/phy-qcom-usb-hs.c b/drivers/phy/qualcomm/phy-qcom-usb-hs.c
> index 610542..327df1a 100644
> --- a/drivers/phy/qualcomm/phy-qcom-usb-hs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-usb-hs.c
> @@ -53,7 +53,7 @@ static int qcom_usb_hs_phy_set_mode(struct phy *phy,
>                 case PHY_MODE_USB_OTG:
>                 case PHY_MODE_USB_HOST:
>                         val |= ULPI_INT_IDGRD;
> -                       /* fall through */
> +                       fallthrough;
>                 case PHY_MODE_USB_DEVICE:
>                         val |= ULPI_INT_SESS_VALID;
>                 default:
> diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> index fe0be8..3b0ab0e 100644
> --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> @@ -793,13 +793,13 @@ static int pmic_gpio_populate(struct pmic_gpio_state *state,
>         switch (subtype) {
>         case PMIC_GPIO_SUBTYPE_GPIO_4CH:
>                 pad->have_buffer = true;
> -               /* Fall through */
> +               fallthrough;
>         case PMIC_GPIO_SUBTYPE_GPIOC_4CH:
>                 pad->num_sources = 4;
>                 break;
>         case PMIC_GPIO_SUBTYPE_GPIO_8CH:
>                 pad->have_buffer = true;
> -               /* Fall through */
> +               fallthrough;
>         case PMIC_GPIO_SUBTYPE_GPIOC_8CH:
>                 pad->num_sources = 8;
>                 break;
> diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
> index 338a15..b5949f7 100644
> --- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
> +++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
> @@ -346,7 +346,7 @@ static int pm8xxx_pin_config_set(struct pinctrl_dev *pctldev,
>                                 return -EINVAL;
>                         }
>                         pin->pull_up_strength = arg;
> -                       /* FALLTHROUGH */
> +                       fallthrough;
>                 case PIN_CONFIG_BIAS_PULL_UP:
>                         pin->bias = pin->pull_up_strength;
>                         banks |= BIT(2);
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 1995f5b..f40312 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -553,7 +553,7 @@ static void qcom_glink_receive_version(struct qcom_glink *glink,
>                 break;
>         case GLINK_VERSION_1:
>                 glink->features &= features;
> -               /* FALLTHROUGH */
> +               fallthrough;
>         default:
>                 qcom_glink_send_version_ack(glink);
>                 break;
> @@ -584,7 +584,7 @@ static void qcom_glink_receive_version_ack(struct qcom_glink *glink,
>                         break;
>
>                 glink->features &= features;
> -               /* FALLTHROUGH */
> +               fallthrough;
>         default:
>                 qcom_glink_send_version(glink);
>                 break;
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index 7864b7..8ae5646 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -325,7 +325,7 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
>                 debugfs_create_x32("raw_device_number", 0400,
>                                    qcom_socinfo->dbg_root,
>                                    &qcom_socinfo->info.raw_device_num);
> -               /* Fall through */
> +               fallthrough;
>         case SOCINFO_VERSION(0, 11):
>         case SOCINFO_VERSION(0, 10):
>         case SOCINFO_VERSION(0, 9):
> @@ -333,12 +333,12 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
>
>                 debugfs_create_u32("foundry_id", 0400, qcom_socinfo->dbg_root,
>                                    &qcom_socinfo->info.foundry_id);
> -               /* Fall through */
> +               fallthrough;
>         case SOCINFO_VERSION(0, 8):
>         case SOCINFO_VERSION(0, 7):
>                 DEBUGFS_ADD(info, pmic_model);
>                 DEBUGFS_ADD(info, pmic_die_rev);
> -               /* Fall through */
> +               fallthrough;
>         case SOCINFO_VERSION(0, 6):
>                 qcom_socinfo->info.hw_plat_subtype =
>                         __le32_to_cpu(info->hw_plat_subtype);
> @@ -346,7 +346,7 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
>                 debugfs_create_u32("hardware_platform_subtype", 0400,
>                                    qcom_socinfo->dbg_root,
>                                    &qcom_socinfo->info.hw_plat_subtype);
> -               /* Fall through */
> +               fallthrough;
>         case SOCINFO_VERSION(0, 5):
>                 qcom_socinfo->info.accessory_chip =
>                         __le32_to_cpu(info->accessory_chip);
> @@ -354,27 +354,27 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
>                 debugfs_create_u32("accessory_chip", 0400,
>                                    qcom_socinfo->dbg_root,
>                                    &qcom_socinfo->info.accessory_chip);
> -               /* Fall through */
> +               fallthrough;
>         case SOCINFO_VERSION(0, 4):
>                 qcom_socinfo->info.plat_ver = __le32_to_cpu(info->plat_ver);
>
>                 debugfs_create_u32("platform_version", 0400,
>                                    qcom_socinfo->dbg_root,
>                                    &qcom_socinfo->info.plat_ver);
> -               /* Fall through */
> +               fallthrough;
>         case SOCINFO_VERSION(0, 3):
>                 qcom_socinfo->info.hw_plat = __le32_to_cpu(info->hw_plat);
>
>                 debugfs_create_u32("hardware_platform", 0400,
>                                    qcom_socinfo->dbg_root,
>                                    &qcom_socinfo->info.hw_plat);
> -               /* Fall through */
> +               fallthrough;
>         case SOCINFO_VERSION(0, 2):
>                 qcom_socinfo->info.raw_ver  = __le32_to_cpu(info->raw_ver);
>
>                 debugfs_create_u32("raw_version", 0400, qcom_socinfo->dbg_root,
>                                    &qcom_socinfo->info.raw_ver);
> -               /* Fall through */
> +               fallthrough;
>         case SOCINFO_VERSION(0, 1):
>                 DEBUGFS_ADD(info, build_id);
>                 break;
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index 4b8dd6..893ce1 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -163,7 +163,7 @@ static int calibrate_8916(struct tsens_priv *priv)
>                 p2[4] = (qfprom_cdata[1] & MSM8916_S4_P2_MASK) >> MSM8916_S4_P2_SHIFT;
>                 for (i = 0; i < priv->num_sensors; i++)
>                         p2[i] = ((base1 + p2[i]) << 3);
> -               /* Fall through */
> +               fallthrough;
>         case ONE_PT_CALIB2:
>                 base0 = (qfprom_cdata[0] & MSM8916_BASE0_MASK);
>                 p1[0] = (qfprom_cdata[0] & MSM8916_S0_P1_MASK) >> MSM8916_S0_P1_SHIFT;
> @@ -228,7 +228,7 @@ static int calibrate_8974(struct tsens_priv *priv)
>                         p2[8] = (calib[5] & S8_P2_BKP_MASK) >> S8_P2_BKP_SHIFT;
>                         p2[9] = (calib[5] & S9_P2_BKP_MASK) >> S9_P2_BKP_SHIFT;
>                         p2[10] = (calib[5] & S10_P2_BKP_MASK) >> S10_P2_BKP_SHIFT;
> -                       /* Fall through */
> +                       fallthrough;
>                 case ONE_PT_CALIB:
>                 case ONE_PT_CALIB2:
>                         base1 = bkp[0] & BASE1_MASK;
> @@ -263,7 +263,7 @@ static int calibrate_8974(struct tsens_priv *priv)
>                         p2[8] = (calib[4] & S8_P2_MASK) >> S8_P2_SHIFT;
>                         p2[9] = (calib[4] & S9_P2_MASK) >> S9_P2_SHIFT;
>                         p2[10] = (calib[4] & S10_P2_MASK) >> S10_P2_SHIFT;
> -                       /* Fall through */
> +                       fallthrough;
>                 case ONE_PT_CALIB:
>                 case ONE_PT_CALIB2:
>                         base1 = calib[0] & BASE1_MASK;
> @@ -293,7 +293,7 @@ static int calibrate_8974(struct tsens_priv *priv)
>                         p2[i] <<= 2;
>                         p2[i] |= BIT_APPEND;
>                 }
> -               /* Fall through */
> +               fallthrough;
>         case ONE_PT_CALIB2:
>                 for (i = 0; i < priv->num_sensors; i++) {
>                         p1[i] += base1;
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index bd2ddb..d096d3 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -202,7 +202,7 @@ static int calibrate_v1(struct tsens_priv *priv)
>                 p2[9] = (qfprom_cdata[3] & S9_P2_MASK) >> S9_P2_SHIFT;
>                 for (i = 0; i < priv->num_sensors; i++)
>                         p2[i] = ((base1 + p2[i]) << 2);
> -               /* Fall through */
> +               fallthrough;
>         case ONE_PT_CALIB2:
>                 base0 = (qfprom_cdata[4] & BASE0_MASK) >> BASE0_SHIFT;
>                 p1[0] = (qfprom_cdata[0] & S0_P1_MASK) >> S0_P1_SHIFT;
> @@ -263,7 +263,7 @@ static int calibrate_8976(struct tsens_priv *priv)
>
>                 for (i = 0; i < priv->num_sensors; i++)
>                         p2[i] = ((base1 + p2[i]) << 2);
> -               /* Fall through */
> +               fallthrough;
>         case ONE_PT_CALIB2:
>                 base0 = qfprom_cdata[0] & MSM8976_BASE0_MASK;
>                 p1[0] = (qfprom_cdata[0] & MSM8976_S0_P1_MASK) >> MSM8976_S0_P1_SHIFT;
> --
> 2.24.0
>

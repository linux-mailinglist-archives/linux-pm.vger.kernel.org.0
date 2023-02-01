Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5846869E8
	for <lists+linux-pm@lfdr.de>; Wed,  1 Feb 2023 16:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBAPSq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Feb 2023 10:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjBAPSc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2023 10:18:32 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76890CDE3
        for <linux-pm@vger.kernel.org>; Wed,  1 Feb 2023 07:18:03 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o20so29768419lfk.5
        for <linux-pm@vger.kernel.org>; Wed, 01 Feb 2023 07:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGV2vUABECnu0sHGj4budXohf8un4zHsRX1ZxSKWcpA=;
        b=oLHkkoaK4jXojZwy11d1zGScoYpM+cA3cXWYIUzi4fL2LWBV1rmfLZrA9otnxd3AUe
         pM3oo2/xU/nWvxZ2uHdTkTEaEoGG1claELoEtPXgu36QV49NOzU+/5SnZmBT8rQ7gICc
         TsjXH9f0S14O7tsoyXWysEYUEMpv6bdjxEkkNvp9obK2NAYGBnIgg1m/HDhnBfUHjfeO
         Iq1W+9SrY65kks9zVIZOOXRofBlH2bljecIA9MqM+jcDT+v6y8dlVZ+3IMzbx5rsQ+my
         IbH1JIZZFGKtVSfiBFJnJhAAYZwefGI7avesRk8HmlxHQgxvfd1hAqRVE7vR6WUU1pOL
         pABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGV2vUABECnu0sHGj4budXohf8un4zHsRX1ZxSKWcpA=;
        b=7MWEf/BseCI4wnhmlSZn8mQSUUBSAXibLxO/lZpfuVVrvfSjfBNEiCebNSUH5xJg4t
         wHEMn3o0YJRqhNmIRlCoVsmynkmDuMMedgYHCjNyLlLGHAEVHYns0FZjY04upi6F6XoG
         UI2ELOmT3OA1PIj3/ja+qoZJshUL4NTnkQP2zu9NWOaZyk8LofJcbI97yZB2NSfW0M/e
         jxY7eTgHlzMGj52HkIXgBRFkF7W2o97sq7Z+dfrvW5O/NjXeK1M8mtusCLvHJgnj+cjA
         nILZP2OR+dNsTFDhgLMuVLFGJAckrwK1wcZRz+k8LNxS1IKyLIX07VcOLpL+JvltG+iH
         ocPw==
X-Gm-Message-State: AO0yUKWqcQtEMet7vI3Vm5wux/00XyiBIlx5ySHzh2GYYCUUGxf56Zho
        ejauo2fK7aW7MP/wHi2wC9Wma3L81MllrjhtGmk4JQ==
X-Google-Smtp-Source: AK7set/aAMiOd9Vro/C7UYDMJ8oY7X2HeimUs98lHLwCiS2Xop22IfD/UPlxp+K+9600RVCXlg7wk3nbKlDPyqLsjXM=
X-Received: by 2002:ac2:43d0:0:b0:4d2:e530:d53c with SMTP id
 u16-20020ac243d0000000b004d2e530d53cmr436433lfl.8.1675264680185; Wed, 01 Feb
 2023 07:18:00 -0800 (PST)
MIME-Version: 1.0
References: <20230201080227.473547-1-jun.nie@linaro.org> <20230201080227.473547-2-jun.nie@linaro.org>
 <cee1778f-70a0-4bb5-a18f-4dd89cf62a2e@gmail.com>
In-Reply-To: <cee1778f-70a0-4bb5-a18f-4dd89cf62a2e@gmail.com>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Wed, 1 Feb 2023 23:17:56 +0800
Message-ID: <CABymUCMAL-iEOni_xVhDfOi60axr2ujz5kaH1V30ymE3cAjT9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM / devfreq: qcom: Introduce CCI devfreq driver
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, bryan.odonoghue@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Chanwoo Choi <cwchoi00@gmail.com> =E4=BA=8E2023=E5=B9=B42=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=B8=89 19:02=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On 23. 2. 1. 17:02, Jun Nie wrote:
> > Cache Coherent Interconnect (CCI) is used by some Qualcomm SoCs. This
> > driver is introduced so that its freqency can be adjusted. And regulato=
r
> > associated with opp table can be also adjusted accordingly which is
> > shared with cpu cluster.
> >
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > ---
> >  drivers/devfreq/Kconfig    |   9 +++
> >  drivers/devfreq/Makefile   |   1 +
> >  drivers/devfreq/qcom-cci.c | 162 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 172 insertions(+)
> >  create mode 100644 drivers/devfreq/qcom-cci.c
> >
> > diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> > index 9754d8b31621..6f3f1872f3fb 100644
> > --- a/drivers/devfreq/Kconfig
> > +++ b/drivers/devfreq/Kconfig
> > @@ -130,6 +130,15 @@ config ARM_MEDIATEK_CCI_DEVFREQ
> >         buck voltages and update a proper CCI frequency. Use the notifi=
cation
> >         to get the regulator status.
> >
> > +config ARM_QCOM_CCI_DEVFREQ
> > +     tristate "QUALCOMM CCI DEVFREQ Driver"
> > +     depends on ARCH_QCOM || COMPILE_TEST
> > +     select DEVFREQ_GOV_PASSIVE
> > +     help
> > +       This adds a devfreq driver for Qualcomm Cache Coherent Intercon=
nect which
> > +       shares the same regulator with the cpu cluster. This driver can=
 track a
> > +       proper regulator state while CCI frequency is updated.
>
> Maybe, this driver use the passive governor because as this description,
> the regulator is shared with cpu cluster. But, as I commented below,
> you use the 'userspace' governor in probe. is it right?
>
> > +
> >  config ARM_RK3399_DMC_DEVFREQ
> >       tristate "ARM RK3399 DMC DEVFREQ Driver"
> >       depends on (ARCH_ROCKCHIP && HAVE_ARM_SMCCC) || \
> > diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> > index bf40d04928d0..f2526d8c168d 100644
> > --- a/drivers/devfreq/Makefile
> > +++ b/drivers/devfreq/Makefile
> > @@ -12,6 +12,7 @@ obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)        +=3D exyn=
os-bus.o
> >  obj-$(CONFIG_ARM_IMX_BUS_DEVFREQ)    +=3D imx-bus.o
> >  obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ) +=3D imx8m-ddrc.o
> >  obj-$(CONFIG_ARM_MEDIATEK_CCI_DEVFREQ)       +=3D mtk-cci-devfreq.o
> > +obj-$(CONFIG_ARM_QCOM_CCI_DEVFREQ)   +=3D qcom-cci.o
> >  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ) +=3D rk3399_dmc.o
> >  obj-$(CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ)     +=3D sun8i-a33-mbus.o
> >  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)              +=3D tegra30-devfreq.o
> > diff --git a/drivers/devfreq/qcom-cci.c b/drivers/devfreq/qcom-cci.c
> > new file mode 100644
> > index 000000000000..21b5f133cddc
> > --- /dev/null
> > +++ b/drivers/devfreq/qcom-cci.c
> > @@ -0,0 +1,162 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2023 Linaro Ltd.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/devfreq.h>
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/of_device.h>
> > +#include <linux/pm_opp.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +#define SPEED_PVS(s, p) ((s << 16) | p)
>
> What it meaning of PVS? Could you add the comment for 'PVS' and 's', 'p'?
>
This is what I have from Qualcomm code. Maybe others have more info about i=
t.
Process Voltage Scaling(PVS) Tables defines the voltage and frequency
value based on the msm-id in SMEM and speedbin blown in the efuse
combination.

> > +
> > +struct qcom_cci {
> > +     struct devfreq_dev_profile profile;
> > +     struct devfreq *devfreq;
> > +     struct clk *clk;
> > +};
> > +
> > +static int qcom_cci_target(struct device *dev,
> > +             unsigned long *freq, u32 flags)
>
> Actually, this line is not long. You can type it on one line as following=
:
>
> static int qcom_cci_target(struct device *dev, unsigned long *freq, u32 f=
lags)
>
> > +{
> > +     struct dev_pm_opp *new_opp;
> > +     int ret;
>
> As I mentioned belwo, this local variable is not needed
> if just return PTR_ERR(new_opp).
>
> > +
> > +     new_opp =3D devfreq_recommended_opp(dev, freq, flags);
> > +     if (IS_ERR(new_opp)) {
> > +             ret =3D PTR_ERR(new_opp);
> > +             dev_err(dev, "failed to get recommended opp: %d\n", ret);
> > +             return ret;
>
> Better to add 'return PTR_ERR(new_opp)' without 'ret' local variable.
>
> > +     }
> > +     dev_pm_opp_put(new_opp);
> > +
> > +     return dev_pm_opp_set_rate(dev, *freq);
> > +}
> > +
> > +static int qcom_cci_get_cur_freq(struct device *dev, unsigned long *fr=
eq)
> > +{
> > +     struct qcom_cci *priv =3D dev_get_drvdata(dev);
> > +
> > +     *freq =3D clk_get_rate(priv->clk);
> > +
> > +     return 0;
> > +}
> > +
> > +static int qcom_get_dev_version(struct nvmem_cell *speedbin_nvmem)
> > +{
> > +     int speed =3D 0, pvs =3D 0;
> > +     u8 *speedbin;
> > +     size_t len;
> > +
> > +     speedbin =3D nvmem_cell_read(speedbin_nvmem, &len);
> > +     if (IS_ERR(speedbin))
> > +             return PTR_ERR(speedbin);
> > +
> > +     speed =3D (speedbin[0xc] >> 2) & 0x7;
> > +     pvs =3D (speedbin[0x3] >> 5 & 0x1) | ((speedbin[0x6] >> 2 & 0x3) =
<< 1);
>
> Actually, 0xc, 0x3, 0x7, 0x1 and so on. It is impossible to understand
> the meaning of this hex value. Plesae add the constant defintion
> for the readability.
>
Thanks for pointing it. The bit wise manipulation will be converted
into nvmem offset and
bit position in next version. So driver will read out value directly
without bit shift/mask.
Other comments will be adopted in next version. Thanks!

- Jun

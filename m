Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1976B2D0737
	for <lists+linux-pm@lfdr.de>; Sun,  6 Dec 2020 22:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgLFU7y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Dec 2020 15:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgLFU7y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Dec 2020 15:59:54 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B367CC0613D0;
        Sun,  6 Dec 2020 12:59:13 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id q137so11388789iod.9;
        Sun, 06 Dec 2020 12:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d6BRn7qihcauXjMDGzCvXnL71Mb/VmGjXDz8MROhlHk=;
        b=m+rm8fkK8CPvVFookoUg7lSnLJD5HvqLaOzuUKEyIW9guDx7K3wLm45UHfWwrmsdOX
         zm/d61/jfJL7QDyQxMPfp13kVRhlEcNDmce7pV6Tu2iIZcUcLpeVR6oJCcnBOPGzwW7I
         Z5q1F1Efpfn3wdQ902cCE+nmPK5KCj53LyNsHieHbJbHX1pAP38j9CGiVcm63KR7kmdt
         VyePJmXIqPU4CftiNwTO3mLZIGF3aw6YgXg/+6Y+mj2Rs2OnMBgo9gdouVCT8O25v13X
         OQ8oXrQuJ//j0744PqnV6zIXkI6ttDHZ2Gax/TlnGwXV1qMiCXFj1CBzjvhyuCpsZgtk
         uQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d6BRn7qihcauXjMDGzCvXnL71Mb/VmGjXDz8MROhlHk=;
        b=hiZ/FmQXp4UdBxogYoQB8nDl545c35w1/jms9T3VHefqLVYNutchjobgqjRsyHd5eL
         M3B+vgeaUSH9tbqtdXnsvUG4PXej0jShZx1HzU/9m3sOEJ22zYwslg5gn19zE+/7tIqm
         vEGtXFj9SuNvXv7QsdnwMQHlGUKKompu7v7qvKVMRyE569EyFmTjvJxI5uz5rJnVKdNC
         L3+CdM5s+k7my1T0RH6Euch3viw82Vdl50mAb2I2/Je0PHRKL6tTjDx11EaMW7Sirqfl
         /sH/By5oDMcCdX4bQfRPN8imH4KmD9+yD3V366Cj6dirPeYUBORpyBT39OhRVI7gUYpI
         UNZw==
X-Gm-Message-State: AOAM532fPxkKS1w29MhWZLCRqgzvTdVTqOYHDgL3qcjvb0KnuM6JQMAn
        xfgAH9PcvyFU+66OhC8cl37hbcwq8ANKiApiBjE=
X-Google-Smtp-Source: ABdhPJzE54kWFUqCTS6AEHWQBP4v9lcCjLyuSTiIvnhN7o6HJIPZn0iDKhK7hYQJu2j9WmeX/FVlAMVOazhd2DeZRtk=
X-Received: by 2002:a5d:9b97:: with SMTP id r23mr14654441iom.123.1607288352988;
 Sun, 06 Dec 2020 12:59:12 -0800 (PST)
MIME-Version: 1.0
References: <20201204070901.24592-1-huangshuosheng@allwinnertech.com> <388512ba-9e2b-acad-8487-5c26a6eb101b@gmail.com>
In-Reply-To: <388512ba-9e2b-acad-8487-5c26a6eb101b@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 6 Dec 2020 21:59:01 +0100
Message-ID: <CAJiuCcf3r_ThavkXtHaRujZOthvRK2_+Esa_5BG-fk5xBN6fxQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: sun50i: add a100 cpufreq support
To:     Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Shuosheng,

On Sun, 6 Dec 2020 at 21:49, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>=
 wrote:
>
> Hi Shuosheng,
>
> On 04/12/2020 08:09, Shuosheng Huang wrote:
> > Let's add cpufreq nvmem based for allwinner a100 soc. It's similar to h=
6,
> > let us use efuse_xlate to extract the differentiated part.
>
> So you introduce 2 modifications here.
> In this case it's better to have 2 patches.
> One to introduce the efuse_xlate
> And one to introduce the A100 support.
>
> Regards,
> Clement
>
> >
> > Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> > ---
> >   drivers/cpufreq/cpufreq-dt-platdev.c   |  1 +
> >   drivers/cpufreq/sun50i-cpufreq-nvmem.c | 81 ++++++++++++++++++++-----=
-
> >   2 files changed, 64 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpu=
freq-dt-platdev.c
> > index 3776d960f405..2ebf5d9cb616 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -102,6 +102,7 @@ static const struct of_device_id whitelist[] __init=
const =3D {
> >    */
> >   static const struct of_device_id blacklist[] __initconst =3D {
> >       { .compatible =3D "allwinner,sun50i-h6", },
> > +     { .compatible =3D "allwinner,sun50i-a100", },
> >
> >       { .compatible =3D "calxeda,highbank", },
> >       { .compatible =3D "calxeda,ecx-2000", },
> > diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/s=
un50i-cpufreq-nvmem.c
> > index 9907a165135b..044e44a763f5 100644
> > --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > @@ -21,21 +21,63 @@
> >
> >   #define NVMEM_MASK  0x7
> >   #define NVMEM_SHIFT 5
> > +#define SUN50I_A100_NVMEM_MASK               0xf
> > +#define SUN50I_A100_NVMEM_SHIFT              12
> > +
> > +#define SUN50I_H6_NVMEM_MASK         0x7
> > +#define SUN50I_H6_NVMEM_SHIFT                5
> > +
> > +struct sunxi_cpufreq_soc_data {
> > +     u32 (*efuse_xlate)(void *efuse);

Maybe it's better to pass the speedbin_nvmem.
And call nvmem_cell_read_u16 or nvmem_cell_read_u32 regarding the SoC.

But I'm not a Maintainer.

Clement


> > +};
> >
> >   static struct platform_device *cpufreq_dt_pdev, *sun50i_cpufreq_pdev;
> >
> > +static u32 sun50i_a100_efuse_xlate(void *efuse)
> > +{
> > +     u32 efuse_value =3D (*(u16 *)efuse >> SUN50I_A100_NVMEM_SHIFT) &
> > +                       SUN50I_A100_NVMEM_MASK;
> > +
> > +     switch (efuse_value) {
> > +     case 0b100:
> > +             return 2;
> > +     case 0b010:
> > +             return 1;
> > +     default:
> > +             return 0;
> > +     }
> > +}
> > +
> > +static u32 sun50i_h6_efuse_xlate(void *efuse)
> > +{
> > +     u32 efuse_value =3D (*(u32 *)efuse >> SUN50I_H6_NVMEM_SHIFT) &
> > +                       SUN50I_H6_NVMEM_MASK;
> > +
> > +     /*
> > +      * We treat unexpected efuse values as if the SoC was from
> > +      * the slowest bin. Expected efuse values are 1-3, slowest
> > +      * to fastest.
> > +      */
> > +     if (efuse_value >=3D 1 && efuse_value <=3D 3)
> > +             return efuse_value - 1;
> > +     else
> > +             return 0;
> > +}
> > +
> >   /**
> >    * sun50i_cpufreq_get_efuse() - Determine speed grade from efuse valu=
e
> > + * @soc_data: pointer to sunxi_cpufreq_soc_data context
> >    * @versions: Set to the value parsed from efuse
> >    *
> >    * Returns 0 if success.
> >    */
> > -static int sun50i_cpufreq_get_efuse(u32 *versions)
> > +static int sun50i_cpufreq_get_efuse(const struct sunxi_cpufreq_soc_dat=
a *soc_data,
> > +                                 u32 *versions)
> >   {
> >       struct nvmem_cell *speedbin_nvmem;
> >       struct device_node *np;
> >       struct device *cpu_dev;
> > -     u32 *speedbin, efuse_value;
> > +     u32 *speedbin;
> >       size_t len;
> >       int ret;
> >
> > @@ -68,17 +110,7 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
> >       if (IS_ERR(speedbin))
> >               return PTR_ERR(speedbin);
> >
> > -     efuse_value =3D (*speedbin >> NVMEM_SHIFT) & NVMEM_MASK;
> > -
> > -     /*
> > -      * We treat unexpected efuse values as if the SoC was from
> > -      * the slowest bin. Expected efuse values are 1-3, slowest
> > -      * to fastest.
> > -      */
> > -     if (efuse_value >=3D 1 && efuse_value <=3D 3)
> > -             *versions =3D efuse_value - 1;
> > -     else
> > -             *versions =3D 0;
> > +     *versions =3D soc_data->efuse_xlate(speedbin);
> >
> >       kfree(speedbin);
> >       return 0;
> > @@ -86,18 +118,23 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
> >
> >   static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
> >   {
> > +     const struct of_device_id *match;
> >       struct opp_table **opp_tables;
> >       char name[MAX_NAME_LEN];
> >       unsigned int cpu;
> >       u32 speed =3D 0;
> >       int ret;
> >
> > +     match =3D dev_get_platdata(&pdev->dev);
> > +     if (!match)
> > +             return -EINVAL;
> > +
> >       opp_tables =3D kcalloc(num_possible_cpus(), sizeof(*opp_tables),
> >                            GFP_KERNEL);
> >       if (!opp_tables)
> >               return -ENOMEM;
> >
> > -     ret =3D sun50i_cpufreq_get_efuse(&speed);
> > +     ret =3D sun50i_cpufreq_get_efuse(match->data, &speed);
> >       if (ret)
> >               return ret;
> >
> > @@ -163,8 +200,17 @@ static struct platform_driver sun50i_cpufreq_drive=
r =3D {
> >       },
> >   };
> >
> > +static const struct sunxi_cpufreq_soc_data sun50i_a100_data =3D {
> > +     .efuse_xlate =3D sun50i_a100_efuse_xlate,
> > +};
> > +
> > +static const struct sunxi_cpufreq_soc_data sun50i_h6_data =3D {
> > +     .efuse_xlate =3D sun50i_h6_efuse_xlate,
> > +};
> > +
> >   static const struct of_device_id sun50i_cpufreq_match_list[] =3D {
> > -     { .compatible =3D "allwinner,sun50i-h6" },
> > +     { .compatible =3D "allwinner,sun50i-h6", .data =3D &sun50i_h6_dat=
a },
> > +     { .compatible =3D "allwinner,sun50i-a100", .data =3D &sun50i_a100=
_data >    {}
> >   };
> >
> > @@ -198,9 +244,8 @@ static int __init sun50i_cpufreq_init(void)
> >       if (unlikely(ret < 0))
> >               return ret;
> >
> > -     sun50i_cpufreq_pdev =3D
> > -             platform_device_register_simple("sun50i-cpufreq-nvmem",
> > -                                             -1, NULL, 0);
> > +     sun50i_cpufreq_pdev =3D platform_device_register_data(NULL,
> > +             "sun50i-cpufreq-nvmem", -1, match, sizeof(*match));
> >       ret =3D PTR_ERR_OR_ZERO(sun50i_cpufreq_pdev);
> >       if (ret =3D=3D 0)
> >               return 0;
> >

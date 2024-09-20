Return-Path: <linux-pm+bounces-14523-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3731A97DAB0
	for <lists+linux-pm@lfdr.de>; Sat, 21 Sep 2024 01:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78F3EB21CFD
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 23:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A81C186E4B;
	Fri, 20 Sep 2024 23:03:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893EA127E18;
	Fri, 20 Sep 2024 23:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726873430; cv=none; b=tgVW/dnaaGUWEbFKG8tsJyvbq1qyRhknsBONYBVYmbygCj9qy+SE2Bg0M2XtnWQWpXquXzCbtfcLYtdkA8ExfsScCTKkZ8Rz5/sAD10/6xM4oclcv+3LWIO2tHeXpG510zhn1wNCGcWI1ESy/I3P/VmzFMFoabrmdTt8ROSuDnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726873430; c=relaxed/simple;
	bh=OxcfEv9LV44Uf+115ne3sYDX9E+TssMqUoIG6dO5SeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQJhtAtW6Gwwc7UInLQIMeMrmsuNg2QDVP8jiTGUdIXtF+C+BJB+xL8YsgV2X6f5+mGUJ1kTsnc6uPWNYjOxZa5cUg2/fLFqMFtD1vCgWAOMnMv1QKZLOvLnRq2wueNs3KSYy9xNpsU6h/g3bGFK5B+DcyVwA4NV7BC1NEjCB70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f758f84dfbso20975071fa.0;
        Fri, 20 Sep 2024 16:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726873424; x=1727478224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6iPFS2iKcHR05KyOahfVFcvAwOHUoUZTGTIHlLSaJSg=;
        b=D5pFIiqzWMWDPK73STsF+N4vWGXQYURllbG8wVAi9sYHm4w9GmM/P4HLc4DrZ8T2Af
         JROXgNHH7hc3/bXt2mRnQj422/KpxP0p/Z5X3/QNWNBr6MP0yv54NNk8qe4l3am1j/xN
         T6tCjx1yRoH7G+KxmdyWSj2E6lNfjwLJ1voxDTTveoJmcj+ipehZfBbTYGazwN7oDmaz
         /4altF2hvVlt2OzZyac6MmflQ2uHYVl/hT2Zp2bhNv1LEZCoftDzfLucNEYS4rOTAFJ5
         8xO9VoDGtM4uKSm22bShd1aEtRAA8DR60c7lZfkVfvwyx5XR9M8dgfMdqxu8HFlijFYn
         QYhA==
X-Forwarded-Encrypted: i=1; AJvYcCUbOMx21p9uVrUzLd1e6Ap35vyeiiyISxS1Ne9N6TkUHDZyPjY7CT9E0VNwFP3O9y1jxENhraimX9LJBx8u@vger.kernel.org, AJvYcCW1NkmhA5M+iQB3NLVs2vcIozPp+Jtb4+30694BFZ6BsRsp4fAV9/YG4raJ/speqt1gpLTK+frWyqaJ@vger.kernel.org, AJvYcCWM9vHejTtE2SUzNYk4ZUAiB3haUoOeYLp3iIHPHkYnOu7R0OyQZzX/EkCHvYu3imviYm8wgme8L5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwutjQIsNq5lp/kkIp7BaMl61X8QIW4FYrhljB3HibgHKqd/Pr6
	s/z1VAzqshP8dqN935OZBOXto494PPI3rjYX8Qc5sMmy6iJAGTgfrSwU6/He0RU=
X-Google-Smtp-Source: AGHT+IGiqQ2LVji2758VQE2Oo00H3hLBLxvTiXrA0yv+E+Rrm2SkxNfHT7jJA3kBwVnONI6q08V2EA==
X-Received: by 2002:a2e:74f:0:b0:2f7:939f:a47f with SMTP id 38308e7fff4ca-2f7cb3192acmr24344491fa.11.1726873423925;
        Fri, 20 Sep 2024 16:03:43 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d2e1cb4sm20317781fa.22.2024.09.20.16.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 16:03:42 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f762de00fbso28028791fa.2;
        Fri, 20 Sep 2024 16:03:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcdEaojfH2Zj51J939tSiGXQ7rJObD1iC1DXf0/+rX2yLGI19MUSvQ3U9O+Tlv/5HCN8LeyoY4Dzc=@vger.kernel.org, AJvYcCUhFeE5kUaGvWdXHGUTl8pdjf9uod1fRMHDpNv+UZWJ9OTGfS/SnrWStwjufcv/sLi5lp8oMAS7SBioh00y@vger.kernel.org, AJvYcCWnkKMF7MGGpLWfseELFcDMRWMkjzmF2xUdfd5c+dV6J9W7IT2yt4ayEEnDVupWTvkHEXdhEpHslmZH@vger.kernel.org
X-Received: by 2002:a05:651c:1992:b0:2f5:a29:5a42 with SMTP id
 38308e7fff4ca-2f7cb3190f8mr31560601fa.14.1726873422580; Fri, 20 Sep 2024
 16:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919091834.83572-1-sebastian.reichel@collabora.com> <20240919091834.83572-6-sebastian.reichel@collabora.com>
In-Reply-To: <20240919091834.83572-6-sebastian.reichel@collabora.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 21 Sep 2024 01:03:26 +0200
X-Gmail-Original-Message-ID: <CAGb2v66SNkrkXa4Q2gy7fNFZq74WTkxTMYymOKAiYY4HdsRPfg@mail.gmail.com>
Message-ID: <CAGb2v66SNkrkXa4Q2gy7fNFZq74WTkxTMYymOKAiYY4HdsRPfg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] pmdomain: rockchip: add regulator support
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Elaine Zhang <zhangqing@rock-chips.com>, 
	=?UTF-8?Q?Adri=C3=A1n_Mart=C3=ADnez_Larumbe?= <adrian.larumbe@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, devicetree@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 11:27=E2=80=AFAM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Some power domains require extra voltages to be applied. For example
> trying to enable the GPU domain on RK3588 fails when the SoC does not
> have VDD GPU enabled.
>
> The solution to temporarily change the device's device tree node has
> been taken over from the Mediatek power domain driver.
>
> The regulator is not acquired at probe time, since that creates circular
> dependencies. The power domain driver must be probed early, since SoC
> peripherals need it. Regulators on the other hand depend on SoC
> peripherals like SPI, I2C or GPIO.
>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Adrian Larumbe <adrian.larumbe@collabora.com> # On Rock 5B
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 56 +++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index 663d390faaeb..4bc17b588419 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_clk.h>
>  #include <linux/clk.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/mfd/syscon.h>
>  #include <soc/rockchip/pm_domains.h>
>  #include <dt-bindings/power/px30-power.h>
> @@ -89,6 +90,8 @@ struct rockchip_pm_domain {
>         u32 *qos_save_regs[MAX_QOS_REGS_NUM];
>         int num_clks;
>         struct clk_bulk_data *clks;
> +       struct device_node *node;
> +       struct regulator *supply;
>  };
>
>  struct rockchip_pmu {
> @@ -571,18 +574,66 @@ static int rockchip_pd_power(struct rockchip_pm_dom=
ain *pd, bool power_on)
>         return 0;
>  }
>
> +static int rockchip_pd_regulator_disable(struct rockchip_pm_domain *pd)
> +{
> +       return pd->supply ? regulator_disable(pd->supply) : 0;
> +}
> +
> +static int rockchip_pd_regulator_enable(struct rockchip_pm_domain *pd)
> +{
> +       struct rockchip_pmu *pmu =3D pd->pmu;
> +       struct device_node *main_node;
> +
> +       if (!pd->supply) {
> +               /*
> +                * Find regulator in current power domain node.
> +                * devm_regulator_get() finds regulator in a node and its=
 child
> +                * node, so set of_node to current power domain node then=
 change
> +                * back to original node after regulator is found for cur=
rent
> +                * power domain node.
> +                */
> +               main_node =3D pmu->dev->of_node;
> +               pmu->dev->of_node =3D pd->node;
> +               pd->supply =3D devm_regulator_get(pmu->dev, "domain");

How do you differentiate between a power domain not needing a supply,
vs a power domain that is missing its supply in DT?

You're using the normal "devm_regulator_get()" here (no "_optional),
which gives the dummy supply if no supply is specified in the DT, and
I think that wouldn't work properly.

I'm trying to work out if having "devm_of_regulator_get()" is needed or
not.

Also, this could return -EPROBE_DEFER. I guess it works with the initial
pm_domain_attach() from the driver core?


Thanks
ChenYu


> +               pmu->dev->of_node =3D main_node;
> +               if (IS_ERR(pd->supply)) {
> +                       pd->supply =3D NULL;
> +                       return 0;
> +               }
> +       }
> +
> +       return regulator_enable(pd->supply);
> +}
> +
>  static int rockchip_pd_power_on(struct generic_pm_domain *domain)
>  {
>         struct rockchip_pm_domain *pd =3D to_rockchip_pd(domain);
> +       int ret;
> +
> +       ret =3D rockchip_pd_regulator_enable(pd);
> +       if (ret) {
> +               dev_err(pd->pmu->dev, "Failed to enable supply: %d\n", re=
t);
> +               return ret;
> +       }
>
> -       return rockchip_pd_power(pd, true);
> +       ret =3D rockchip_pd_power(pd, true);
> +       if (ret)
> +               rockchip_pd_regulator_disable(pd);
> +
> +       return ret;
>  }
>
>  static int rockchip_pd_power_off(struct generic_pm_domain *domain)
>  {
>         struct rockchip_pm_domain *pd =3D to_rockchip_pd(domain);
> +       int ret;
>
> -       return rockchip_pd_power(pd, false);
> +       ret =3D rockchip_pd_power(pd, false);
> +       if (ret)
> +               return ret;
> +
> +       rockchip_pd_regulator_disable(pd);
> +       return ret;
>  }
>
>  static int rockchip_pd_attach_dev(struct generic_pm_domain *genpd,
> @@ -663,6 +714,7 @@ static int rockchip_pm_add_one_domain(struct rockchip=
_pmu *pmu,
>
>         pd->info =3D pd_info;
>         pd->pmu =3D pmu;
> +       pd->node =3D node;
>
>         pd->num_clks =3D of_clk_get_parent_count(node);
>         if (pd->num_clks > 0) {
> --
> 2.45.2
>


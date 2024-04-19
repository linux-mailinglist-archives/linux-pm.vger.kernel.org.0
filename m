Return-Path: <linux-pm+bounces-6694-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AC78AA6F7
	for <lists+linux-pm@lfdr.de>; Fri, 19 Apr 2024 04:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF3B1F21F37
	for <lists+linux-pm@lfdr.de>; Fri, 19 Apr 2024 02:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7860928F3;
	Fri, 19 Apr 2024 02:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoHQ7xY0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4774E10E5;
	Fri, 19 Apr 2024 02:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713493854; cv=none; b=kIalSmFQW9u5tIAvirL9O0hKq5V2vxz92r+wjReriPPxCVUiO0xtuybgCwWIexWWkoDIViyNoJYFG/5LfqplR6ENEvBpdzdipff9s5cUqQxwtT+FtCzKISXhm+62b2D79oZ5E634KR52fu9a8OFmBynT1oGFlfH3qDIlhteZtBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713493854; c=relaxed/simple;
	bh=d6wW8IGmEQgntlHj6l65gyKM6gL5uLkJ3e+TQqruBx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGdS+DsDqwwd7o8+tqcQOfI+1GwAtsnLu9u+ZY6RtiKXl52QS97F+u+hWH2ldT+LKR+4c0k7r+YPwbCYeDGSJcI+2Daq/EE4qtFUTpHU+MNrvnjg9xw0ci2kEgq6s7WFypvd7O3TQ+3w+yBImuRKEnM2KJgvm3pW5BQlKnSa8AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoHQ7xY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8D2C113CE;
	Fri, 19 Apr 2024 02:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713493854;
	bh=d6wW8IGmEQgntlHj6l65gyKM6gL5uLkJ3e+TQqruBx4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PoHQ7xY0mSbkSYItL9h4YRm1dE/L0Y1f+X0Yb2kX926DK9Rb4q1JjpNVC20jGv36E
	 JHkyIejuJ3OYOX1qF06KP6PbcpFDPq41/dGr88DPVhmBdoBmu/OCHq0KrfyYoJcX2F
	 LFTiD2aVawFpBbVERT7EqXltEGrpgE+q3AnUezCS3PS06eR7bI8D27/WHG8u1CFS3R
	 f0H/gIqbwDjnKyDF0GzMfW8L7sVVElONXZR7X72DZ50fMoKfu96o3s8CL2XXUA2AUC
	 NaaHt3JP5Jp8vPLtjRFYgyeGf1QbCYHluSSlsVKAdBHKlm9QZrcG2SovuWqMtm+Xo2
	 o9Wh+34i1HL7Q==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4702457ccbso160139266b.3;
        Thu, 18 Apr 2024 19:30:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzV2g/noprxpCcM4vguZxYrCYsSnlhUZ8lORdym/uY1aSU45fG0afmutQusUnoOIaw/XTV17ve1N04DKH4ap7x59Y1fdpwowve+LtPS3Aa6wMPQkwxZ21Br1ylgzND74QK/wLe
X-Gm-Message-State: AOJu0YzpKS7vV1uHQVeieB9I6VmYevPgvxaiE5Kf2bY/Z9uY9osOycl9
	NplFaah2M2lB1vOaT6knAS/1k82BRBSKY9J5MoacksUrj3241hijVRLY4BBeadT9ZNZtEV82vuQ
	7mmCrpau9MNlSJovtu37nA7xruoc=
X-Google-Smtp-Source: AGHT+IGoeeamFkgPkxoIOkpZASJrJ6yNcuLdI6EcVcM4Cc/L85cXky+G13ZdEJA4cbPxywpA+E8uBy8UeBhcvF5ULYc=
X-Received: by 2002:a17:906:684d:b0:a55:551c:5d28 with SMTP id
 a13-20020a170906684d00b00a55551c5d28mr444180ejs.6.1713493852416; Thu, 18 Apr
 2024 19:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713147645.git.zhoubinbin@loongson.cn> <f77f740164ec573dffcf24558a0ac371e098e0f3.1713147645.git.zhoubinbin@loongson.cn>
In-Reply-To: <f77f740164ec573dffcf24558a0ac371e098e0f3.1713147645.git.zhoubinbin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 19 Apr 2024 10:30:46 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6K-+dnwfcjrRM+A9UzOY37U66gTb9C9VQM3i-nXhFJPQ@mail.gmail.com>
Message-ID: <CAAhV-H6K-+dnwfcjrRM+A9UzOY37U66gTb9C9VQM3i-nXhFJPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] thermal: loongson2: Trivial code style adjustment
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	loongson-kernel@lists.loongnix.cn, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, Yinbo Zhu <zhuyinbo@loongson.cn>, 
	WANG Xuerui <git@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Binbin,

On Mon, Apr 15, 2024 at 10:31=E2=80=AFAM Binbin Zhou <zhoubinbin@loongson.c=
n> wrote:
>
> Here are some minor code style adjustment. Such as fix whitespace code
> style; align function call arguments to opening parenthesis, and add
> devm_thermal_add_hwmon_sysfs() return value checking.
>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  drivers/thermal/loongson2_thermal.c | 69 +++++++++++++++--------------
>  1 file changed, 35 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongs=
on2_thermal.c
> index 0f475fe46bc9..d77d829c8b55 100644
> --- a/drivers/thermal/loongson2_thermal.c
> +++ b/drivers/thermal/loongson2_thermal.c
> @@ -16,45 +16,49 @@
>  #include <linux/units.h>
>  #include "thermal_hwmon.h"
>
> -#define LOONGSON2_MAX_SENSOR_SEL_NUM                   3
> +#define LOONGSON2_MAX_SENSOR_SEL_NUM   3
>
> -#define LOONGSON2_THSENS_CTRL_HI_REG                   0x0
> -#define LOONGSON2_THSENS_CTRL_LOW_REG                  0x8
> -#define LOONGSON2_THSENS_STATUS_REG                    0x10
> -#define LOONGSON2_THSENS_OUT_REG                       0x14
> +#define LOONGSON2_THSENS_CTRL_HI_REG   0x0
> +#define LOONGSON2_THSENS_CTRL_LOW_REG  0x8
> +#define LOONGSON2_THSENS_STATUS_REG    0x10
> +#define LOONGSON2_THSENS_OUT_REG       0x14
>
> -#define LOONGSON2_THSENS_INT_LO                                BIT(0)
> -#define LOONGSON2_THSENS_INT_HIGH                      BIT(1)
> -#define LOONGSON2_THSENS_OUT_MASK                      0xFF
> +#define LOONGSON2_THSENS_INT_LO                BIT(0)
> +#define LOONGSON2_THSENS_INT_HIGH      BIT(1)
> +#define LOONGSON2_THSENS_INT_EN                (LOONGSON2_THSENS_INT_LO =
| \
> +                                        LOONGSON2_THSENS_INT_HIGH)
> +#define LOONGSON2_THSENS_OUT_MASK      0xFF
>
>  struct loongson2_thermal_chip_data {
> -       unsigned int    thermal_sensor_sel;
> +       unsigned int thermal_sensor_sel;
>  };
>
>  struct loongson2_thermal_data {
> -       void __iomem    *regs;
> +       void __iomem *regs;
>         const struct loongson2_thermal_chip_data *chip_data;
>  };
>
> -static int loongson2_thermal_set(struct loongson2_thermal_data *data,
> -                                       int low, int high, bool enable)
> +static void loongson2_set_ctrl_regs(struct loongson2_thermal_data *data,
> +                                   int ctrl_data, bool low, bool enable)
>  {
> -       u64 reg_ctrl =3D 0;
> -       int reg_off =3D data->chip_data->thermal_sensor_sel * 2;
> +       int reg_ctrl =3D 0;
> +       int reg_off  =3D data->chip_data->thermal_sensor_sel * 2;
> +       int ctrl_reg =3D low ? LOONGSON2_THSENS_CTRL_LOW_REG :
> +                      LOONGSON2_THSENS_CTRL_HI_REG;
Line break is unnecessary, because long lines is acceptable now.

> +
> +       reg_ctrl =3D ctrl_data + HECTO;
> +       reg_ctrl |=3D enable ? 0x100 : 0;
> +       writew(reg_ctrl, data->regs + ctrl_reg + reg_off);
> +}
>
> +static int loongson2_thermal_set(struct loongson2_thermal_data *data,
> +                                int low, int high, bool enable)
> +{
>         low =3D clamp(-40, low, high);
>         high =3D clamp(125, low, high);
>
> -       low +=3D HECTO;
> -       high +=3D HECTO;
> -
> -       reg_ctrl =3D low;
> -       reg_ctrl |=3D enable ? 0x100 : 0;
> -       writew(reg_ctrl, data->regs + LOONGSON2_THSENS_CTRL_LOW_REG + reg=
_off);
> -
> -       reg_ctrl =3D high;
> -       reg_ctrl |=3D enable ? 0x100 : 0;
> -       writew(reg_ctrl, data->regs + LOONGSON2_THSENS_CTRL_HI_REG + reg_=
off);
> +       loongson2_set_ctrl_regs(data, low, true, enable);
> +       loongson2_set_ctrl_regs(data, high, false, enable);
>
>         return 0;
>  }
> @@ -75,15 +79,15 @@ static irqreturn_t loongson2_thermal_irq_thread(int i=
rq, void *dev)
>         struct thermal_zone_device *tzd =3D dev;
>         struct loongson2_thermal_data *data =3D thermal_zone_device_priv(=
tzd);
>
> -       writeb(LOONGSON2_THSENS_INT_LO | LOONGSON2_THSENS_INT_HIGH, data-=
>regs +
> -               LOONGSON2_THSENS_STATUS_REG);
> +       writeb(LOONGSON2_THSENS_INT_EN, data->regs + LOONGSON2_THSENS_STA=
TUS_REG);
>
>         thermal_zone_device_update(tzd, THERMAL_EVENT_UNSPECIFIED);
>
>         return IRQ_HANDLED;
>  }
>
> -static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, i=
nt low, int high)
> +static int loongson2_thermal_set_trips(struct thermal_zone_device *tz,
> +                                      int low, int high)
The same as above.

Huacai

>  {
>         struct loongson2_thermal_data *data =3D thermal_zone_device_priv(=
tz);
>
> @@ -116,14 +120,13 @@ static int loongson2_thermal_probe(struct platform_=
device *pdev)
>         if (irq < 0)
>                 return irq;
>
> -       writeb(LOONGSON2_THSENS_INT_LO | LOONGSON2_THSENS_INT_HIGH, data-=
>regs +
> -               LOONGSON2_THSENS_STATUS_REG);
> +       writeb(LOONGSON2_THSENS_INT_EN, data->regs + LOONGSON2_THSENS_STA=
TUS_REG);
>
>         loongson2_thermal_set(data, 0, 0, false);
>
>         for (i =3D 0; i <=3D LOONGSON2_MAX_SENSOR_SEL_NUM; i++) {
>                 tzd =3D devm_thermal_of_zone_register(dev, i, data,
> -                       &loongson2_of_thermal_ops);
> +                                                   &loongson2_of_thermal=
_ops);
>
>                 if (!IS_ERR(tzd))
>                         break;
> @@ -135,13 +138,11 @@ static int loongson2_thermal_probe(struct platform_=
device *pdev)
>         }
>
>         ret =3D devm_request_threaded_irq(dev, irq, NULL, loongson2_therm=
al_irq_thread,
> -                       IRQF_ONESHOT, "loongson2_thermal", tzd);
> +                                       IRQF_ONESHOT, "loongson2_thermal"=
, tzd);
>         if (ret < 0)
>                 return dev_err_probe(dev, ret, "failed to request alarm i=
rq\n");
>
> -       devm_thermal_add_hwmon_sysfs(dev, tzd);
> -
> -       return 0;
> +       return devm_thermal_add_hwmon_sysfs(dev, tzd);
>  }
>
>  static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k10=
00_data =3D {
> --
> 2.43.0
>


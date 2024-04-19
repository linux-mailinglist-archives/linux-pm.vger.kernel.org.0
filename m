Return-Path: <linux-pm+bounces-6696-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EE78AA7A5
	for <lists+linux-pm@lfdr.de>; Fri, 19 Apr 2024 06:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873FF1F21E8F
	for <lists+linux-pm@lfdr.de>; Fri, 19 Apr 2024 04:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8647C4C6B;
	Fri, 19 Apr 2024 04:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLakrdFC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19D829A2;
	Fri, 19 Apr 2024 04:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713501203; cv=none; b=uFSUVnsE1UTZfSMx93c4C8td4R5OgpQiEUrP5vWmWSawSzDZZTyAJbsdIqomauYYu8HU6gd0YwFPfSpCQYNi8DqniAe/SZmYVoyn93cbhGXJ5qmIj82mvKdG+P1z2C1XF8RykTqAp6SfqMUNw8VxpJsIsY+lJOa2U8rQAfxfcOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713501203; c=relaxed/simple;
	bh=JdNGLubn8zkHzoFnepQQh33d1j/JpQz1BMOEiWEROxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EbRU2p5obim8jBjRLoJQXQUxTfE0iWKESTDWGJlQEqUm9G3z13sGBGvKW0XYFL5bnQ4wXRhVmjIxPtYmyfAxAuAi2wxhXzGETrTGVnXB7m1829ssxtjIeRxX7GlGNqorFSJlAOtO0BkaQ3evfC8cIo9SNDbeKrUBalI6mcqA9Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLakrdFC; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6164d7a02d2so18934177b3.3;
        Thu, 18 Apr 2024 21:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713501201; x=1714106001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpkFbS/LUWYT+dYWFuL1kI/HN8/GTBk6GBVmp4Rcgxg=;
        b=jLakrdFCVp8wDpvMd4pp9ITY20ze9wnJ0nVdm0lLeSVFnQTnJl0ijARCs5UKh4fjSA
         JmmeZ0Ebd9B/J028ZtKIRgc9etS3uea4O8T18k6R2SNXQO8ZKL5UZSoTMR9bIjdx/5nv
         VpKkfSvnW3gd8irqsouTZUBBDLBlFYaWQ+m57kHjDBjc6AguPnAQaEtgZt3rPNLh90Ki
         s5nqF1tght8+DAjdRAw4s+i5cU/IZkyU45rx4VEsw5W1pglc1sFOJVdmu5lW62ojlvKE
         vGMAS2ZQLGw3C+rcTmnwJ6Jll1235Aqrw4e1aCCmCrABvmPJpoSSHG2sIQ6d+dXh+9Vu
         EXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713501201; x=1714106001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TpkFbS/LUWYT+dYWFuL1kI/HN8/GTBk6GBVmp4Rcgxg=;
        b=w0kScGf1wK+rrsfZuN5ioxAov+/CPBSqX0HJW4XSpZ41Pp5CBu02h6wd4qRzE+azOn
         Vk/iuYhDoGtWyFLPotGtwSmZfAvQR1Or1tU47zRJFTp70Y15LaG4jKdfpwwAxrpOFMr/
         WEhSiQ9dRxYqHkBWTOyN+yLEJgiJnG5XY5DgVKlgPNoqMfZn5GEY/x4HKOTYtRs3fTD2
         1s3afix+C0KwdRkJfPWYzYVxjwZ4cLqYhqHuN2myFBgGZfn6G8Mkk5aRPRH8RC1QHoNo
         X78VxGJSI2vKayxTTHBWzBwp4Ek9DZLqziLwmzYgpGIl8c/WUhVp3qBPgcvPB0qQ5dZo
         LFEA==
X-Forwarded-Encrypted: i=1; AJvYcCXEZ4cO8oQH801POW9hX76eBub3BZbEL4UL/yXYwXGEFz7sFpV6o4j+Ojp1Tp/pg3l3MoO7PI5Z6e1njP9SKqdeb/JxXt/FHQw3/XwmIqO+rCVXRKEBsPLjSIH8IaEGPqKzMoEh
X-Gm-Message-State: AOJu0YwztO1RONWfPDd/+sfxx/B4B9gSbcsDVfPp1967focJBnh2dZpM
	MXULozL/malgcq2v5jM13Am7/+7ZfPqx2POtJgk5d/rIzZfZTzJI8AgwNR7HgNBUBWs/9H0wE7y
	ZsfLEZQP7Whlakl00Opgds9d0wcC1XxE9rQASKg==
X-Google-Smtp-Source: AGHT+IE5CqiC7N0YJ16yoWVDy5wS7H6qJgW3Hc1t17tmyXH5OuiLdGmUl6Snv32Pa1LDU6RjziNlWRcj4FVaCbuNnRA=
X-Received: by 2002:a05:690c:3345:b0:61a:d4ea:b856 with SMTP id
 fk5-20020a05690c334500b0061ad4eab856mr765751ywb.40.1713501200724; Thu, 18 Apr
 2024 21:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713147645.git.zhoubinbin@loongson.cn> <f77f740164ec573dffcf24558a0ac371e098e0f3.1713147645.git.zhoubinbin@loongson.cn>
 <CAAhV-H6K-+dnwfcjrRM+A9UzOY37U66gTb9C9VQM3i-nXhFJPQ@mail.gmail.com>
In-Reply-To: <CAAhV-H6K-+dnwfcjrRM+A9UzOY37U66gTb9C9VQM3i-nXhFJPQ@mail.gmail.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Fri, 19 Apr 2024 10:33:08 +0600
Message-ID: <CAMpQs4LxBjaavSCyO6LkXV_auShw9tyNAAau5_w47OTDN_aKPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] thermal: loongson2: Trivial code style adjustment
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	loongson-kernel@lists.loongnix.cn, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, Yinbo Zhu <zhuyinbo@loongson.cn>, 
	WANG Xuerui <git@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 8:30=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> Hi, Binbin,
>
> On Mon, Apr 15, 2024 at 10:31=E2=80=AFAM Binbin Zhou <zhoubinbin@loongson=
.cn> wrote:
> >
> > Here are some minor code style adjustment. Such as fix whitespace code
> > style; align function call arguments to opening parenthesis, and add
> > devm_thermal_add_hwmon_sysfs() return value checking.
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  drivers/thermal/loongson2_thermal.c | 69 +++++++++++++++--------------
> >  1 file changed, 35 insertions(+), 34 deletions(-)
> >
> > diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loon=
gson2_thermal.c
> > index 0f475fe46bc9..d77d829c8b55 100644
> > --- a/drivers/thermal/loongson2_thermal.c
> > +++ b/drivers/thermal/loongson2_thermal.c
> > @@ -16,45 +16,49 @@
> >  #include <linux/units.h>
> >  #include "thermal_hwmon.h"
> >
> > -#define LOONGSON2_MAX_SENSOR_SEL_NUM                   3
> > +#define LOONGSON2_MAX_SENSOR_SEL_NUM   3
> >
> > -#define LOONGSON2_THSENS_CTRL_HI_REG                   0x0
> > -#define LOONGSON2_THSENS_CTRL_LOW_REG                  0x8
> > -#define LOONGSON2_THSENS_STATUS_REG                    0x10
> > -#define LOONGSON2_THSENS_OUT_REG                       0x14
> > +#define LOONGSON2_THSENS_CTRL_HI_REG   0x0
> > +#define LOONGSON2_THSENS_CTRL_LOW_REG  0x8
> > +#define LOONGSON2_THSENS_STATUS_REG    0x10
> > +#define LOONGSON2_THSENS_OUT_REG       0x14
> >
> > -#define LOONGSON2_THSENS_INT_LO                                BIT(0)
> > -#define LOONGSON2_THSENS_INT_HIGH                      BIT(1)
> > -#define LOONGSON2_THSENS_OUT_MASK                      0xFF
> > +#define LOONGSON2_THSENS_INT_LO                BIT(0)
> > +#define LOONGSON2_THSENS_INT_HIGH      BIT(1)
> > +#define LOONGSON2_THSENS_INT_EN                (LOONGSON2_THSENS_INT_L=
O | \
> > +                                        LOONGSON2_THSENS_INT_HIGH)
> > +#define LOONGSON2_THSENS_OUT_MASK      0xFF
> >
> >  struct loongson2_thermal_chip_data {
> > -       unsigned int    thermal_sensor_sel;
> > +       unsigned int thermal_sensor_sel;
> >  };
> >
> >  struct loongson2_thermal_data {
> > -       void __iomem    *regs;
> > +       void __iomem *regs;
> >         const struct loongson2_thermal_chip_data *chip_data;
> >  };
> >
> > -static int loongson2_thermal_set(struct loongson2_thermal_data *data,
> > -                                       int low, int high, bool enable)
> > +static void loongson2_set_ctrl_regs(struct loongson2_thermal_data *dat=
a,
> > +                                   int ctrl_data, bool low, bool enabl=
e)
> >  {
> > -       u64 reg_ctrl =3D 0;
> > -       int reg_off =3D data->chip_data->thermal_sensor_sel * 2;
> > +       int reg_ctrl =3D 0;
> > +       int reg_off  =3D data->chip_data->thermal_sensor_sel * 2;
> > +       int ctrl_reg =3D low ? LOONGSON2_THSENS_CTRL_LOW_REG :
> > +                      LOONGSON2_THSENS_CTRL_HI_REG;
> Line break is unnecessary, because long lines is acceptable now.
>
OK, I would check the entire code again and fix it in the next version.


Thanks.
Binbin

> > +
> > +       reg_ctrl =3D ctrl_data + HECTO;
> > +       reg_ctrl |=3D enable ? 0x100 : 0;
> > +       writew(reg_ctrl, data->regs + ctrl_reg + reg_off);
> > +}
> >
> > +static int loongson2_thermal_set(struct loongson2_thermal_data *data,
> > +                                int low, int high, bool enable)
> > +{
> >         low =3D clamp(-40, low, high);
> >         high =3D clamp(125, low, high);
> >
> > -       low +=3D HECTO;
> > -       high +=3D HECTO;
> > -
> > -       reg_ctrl =3D low;
> > -       reg_ctrl |=3D enable ? 0x100 : 0;
> > -       writew(reg_ctrl, data->regs + LOONGSON2_THSENS_CTRL_LOW_REG + r=
eg_off);
> > -
> > -       reg_ctrl =3D high;
> > -       reg_ctrl |=3D enable ? 0x100 : 0;
> > -       writew(reg_ctrl, data->regs + LOONGSON2_THSENS_CTRL_HI_REG + re=
g_off);
> > +       loongson2_set_ctrl_regs(data, low, true, enable);
> > +       loongson2_set_ctrl_regs(data, high, false, enable);
> >
> >         return 0;
> >  }
> > @@ -75,15 +79,15 @@ static irqreturn_t loongson2_thermal_irq_thread(int=
 irq, void *dev)
> >         struct thermal_zone_device *tzd =3D dev;
> >         struct loongson2_thermal_data *data =3D thermal_zone_device_pri=
v(tzd);
> >
> > -       writeb(LOONGSON2_THSENS_INT_LO | LOONGSON2_THSENS_INT_HIGH, dat=
a->regs +
> > -               LOONGSON2_THSENS_STATUS_REG);
> > +       writeb(LOONGSON2_THSENS_INT_EN, data->regs + LOONGSON2_THSENS_S=
TATUS_REG);
> >
> >         thermal_zone_device_update(tzd, THERMAL_EVENT_UNSPECIFIED);
> >
> >         return IRQ_HANDLED;
> >  }
> >
> > -static int loongson2_thermal_set_trips(struct thermal_zone_device *tz,=
 int low, int high)
> > +static int loongson2_thermal_set_trips(struct thermal_zone_device *tz,
> > +                                      int low, int high)
> The same as above.
>
> Huacai
>
> >  {
> >         struct loongson2_thermal_data *data =3D thermal_zone_device_pri=
v(tz);
> >
> > @@ -116,14 +120,13 @@ static int loongson2_thermal_probe(struct platfor=
m_device *pdev)
> >         if (irq < 0)
> >                 return irq;
> >
> > -       writeb(LOONGSON2_THSENS_INT_LO | LOONGSON2_THSENS_INT_HIGH, dat=
a->regs +
> > -               LOONGSON2_THSENS_STATUS_REG);
> > +       writeb(LOONGSON2_THSENS_INT_EN, data->regs + LOONGSON2_THSENS_S=
TATUS_REG);
> >
> >         loongson2_thermal_set(data, 0, 0, false);
> >
> >         for (i =3D 0; i <=3D LOONGSON2_MAX_SENSOR_SEL_NUM; i++) {
> >                 tzd =3D devm_thermal_of_zone_register(dev, i, data,
> > -                       &loongson2_of_thermal_ops);
> > +                                                   &loongson2_of_therm=
al_ops);
> >
> >                 if (!IS_ERR(tzd))
> >                         break;
> > @@ -135,13 +138,11 @@ static int loongson2_thermal_probe(struct platfor=
m_device *pdev)
> >         }
> >
> >         ret =3D devm_request_threaded_irq(dev, irq, NULL, loongson2_the=
rmal_irq_thread,
> > -                       IRQF_ONESHOT, "loongson2_thermal", tzd);
> > +                                       IRQF_ONESHOT, "loongson2_therma=
l", tzd);
> >         if (ret < 0)
> >                 return dev_err_probe(dev, ret, "failed to request alarm=
 irq\n");
> >
> > -       devm_thermal_add_hwmon_sysfs(dev, tzd);
> > -
> > -       return 0;
> > +       return devm_thermal_add_hwmon_sysfs(dev, tzd);
> >  }
> >
> >  static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k=
1000_data =3D {
> > --
> > 2.43.0
> >


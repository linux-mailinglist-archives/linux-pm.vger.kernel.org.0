Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E958128F28
	for <lists+linux-pm@lfdr.de>; Sun, 22 Dec 2019 18:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbfLVRrp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Dec 2019 12:47:45 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38323 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfLVRrp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Dec 2019 12:47:45 -0500
Received: by mail-io1-f65.google.com with SMTP id v3so14176134ioj.5;
        Sun, 22 Dec 2019 09:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cXV560NztAEyf3QDB9vqOOSo8xQQ1EuVI594ay/V1a0=;
        b=mhl+f14sIzO6v8IsTbkTnbhaRdufq3zfWQfi6Df8LI0VJjjz3dRfeoo5uE5XAFwTRa
         ooZKiYQiTn1JgPl3MJpOSzCZIELxSzUc2H9ugBb3A/+SBhXxvQCs6U60PF1w5hj5j9dy
         aF2knVluG3eKMrX91w+2SZtEvKtzvZ6PhoVmJb1XV3yZX/sCe29/76D2aOhmrz2Q+9Es
         bdV55vsGNk2eEfNKbtute1UFurvy4Xd7z9hH5Y1zkOytY8Z7QQLjkltpdRbk24sTW6fe
         VDdXi9VRoh/q/1XrVaTjIpfdr1OC4YgNGRHVMN2fIcNwqg+t0uOytBm2zUssB1CBe1ck
         2zIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cXV560NztAEyf3QDB9vqOOSo8xQQ1EuVI594ay/V1a0=;
        b=qpOJy/wxeTM2aorQ1XAQaUb0ObCdwk/PGo4kmizkz/qxXU8usXFdsgXbCSnCVsFwym
         PqamxWBayaywSAL7e2Yc168PKz0hYnfHBos2Gus5RUonRkCcaAmhIDHtSMArJcFfwSQS
         MUFx54GWXf4iqzyqMY6Y63uMvA2CnVo1viNPNsDSGo6f9bV/n93l6JDyQfm5RddIIsEd
         zZ2DWXkg+49Q0dxsj7Kh4Wn/J+nb8q4R1lCoG2WHa7lV9cIUK/Mw1JDDYKt22bhTAUNP
         XPSNvPAy4zlP1Ym4b/1cm7n1JtpJgZfhdcMz7rIWZP65YekY/GAavkeX9v2V8IRw6nR5
         XJYw==
X-Gm-Message-State: APjAAAXE64QaklSzlF658WWxvS9l9AvJsT9p1nN8oy5hMO1xBq/SYqoT
        /csx0GMC8ipOAj0jt+c8G3jIzBTJx+TgWUigGVs=
X-Google-Smtp-Source: APXvYqyqUD6V4nvBIWhPs+C6CdFKb8TEp89BFkN5R9+8ioRXvOtarOaPqoj/gFFYH7cG7aXPZrRFpdpOhInv7dyjAu4=
X-Received: by 2002:a6b:b941:: with SMTP id j62mr18408028iof.168.1577036864950;
 Sun, 22 Dec 2019 09:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20191221181855.31380-1-tiny.windzz@gmail.com> <20191221181855.31380-2-tiny.windzz@gmail.com>
 <CAGTfZH2vqk1R9Hkv4DjO8ktmpHEW+mV-+xreUHPyp6ZT2D7AxA@mail.gmail.com>
In-Reply-To: <CAGTfZH2vqk1R9Hkv4DjO8ktmpHEW+mV-+xreUHPyp6ZT2D7AxA@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Mon, 23 Dec 2019 01:47:33 +0800
Message-ID: <CAEExFWsGJ7Mv=z0tf2pvA2UooEd1bU0+Bo4ZaCMzA5randTr=w@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM / devfreq: exynos-bus: add missing
 exynos_bus_disable_edev in exynos_bus_profile_init
To:     Chanwoo Choi <chanwoo@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 23, 2019 at 1:02 AM Chanwoo Choi <chanwoo@kernel.org> wrote:
>
> Hi,
>
> Please use capital letter for the first char of patch title
> and better to edit the patch title as following:
> Actually, it is difficult to understand the role by only reading
> the function name. It depends on only this driver.
> So, better to edit it as following because devfreq-event
> is standard name in linux kernel. I think it is easy to understand
> what the patch does.
>
> - PM / devfreq: exynos-bus: Disable the devfreq-event device when failed
>
>
> 2019=EB=85=84 12=EC=9B=94 22=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 3:21=
, Yangtao Li <tiny.windzz@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > The exynos_bus_profile_init process may fail, but the devfreq event dev=
ice
> > remains enabled. Call devfreq_event_disable_edev on the error return pa=
th.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/devfreq/exynos-bus.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.=
c
> > index 7f5917d59072..5e54eaf3cfc6 100644
> > --- a/drivers/devfreq/exynos-bus.c
> > +++ b/drivers/devfreq/exynos-bus.c
> > @@ -335,10 +335,14 @@ static int exynos_bus_profile_init(struct exynos_=
bus *bus,
> >         ret =3D exynos_bus_set_event(bus);
> >         if (ret < 0) {
> >                 dev_err(dev, "failed to set event to devfreq-event devi=
ces\n");
> > -               return ret;
> > +               goto err_disable_edev;
> >         }
> >
> >         return 0;
> > +
> > +err_disable_edev:
>
> err_edev is enough instead of 'err_disable_edev'
>
> > +       exynos_bus_disable_edev(bus);
>
> exynos_bus_disable_edev() has return value for detecting the error.
> Need to add following warning message.
>
> if (ret < 0)
>      dev_warn(dev, "failed to disable the devfreq-event devices\n");

I'm not sure if it should be like this,
it may rewrite the above error code.

Yangtao

>
>
> > +       return ret;
> >  }
> >
> >  static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
> > --
> > 2.17.1
> >
>
>
> --
> Best Regards,
> Chanwoo Choi

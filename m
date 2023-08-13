Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D3E77AAAE
	for <lists+linux-pm@lfdr.de>; Sun, 13 Aug 2023 20:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjHMS6n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Aug 2023 14:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjHMS6n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Aug 2023 14:58:43 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09411702
        for <linux-pm@vger.kernel.org>; Sun, 13 Aug 2023 11:58:43 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b962c226ceso56341181fa.3
        for <linux-pm@vger.kernel.org>; Sun, 13 Aug 2023 11:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1691953122; x=1692557922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbRMQLgn6q8vxhzEowCXC6DM0VIy22uIjp0J0FlZhHw=;
        b=mEZqOEzFE/NHDpIJnP+f47/xucTwmNrnya1FWJHPVprnNFpuerfe0PTM7FEVUY1eMw
         wfkq7myj4csEPiDqvJaRm1KHqZmGGATAB+0+jNoGlNI4qCPmJuRpO3tWgV3vNcUgm+Bf
         CuuJ5jGA+lAAw3IKAFw4npqGdwJbujzYEu4d6y6zYhYV+Iwdpr0HArrzYUpaJ8EkJDo0
         9JGxpKtO/W/ysympLiTnDg+sy87A7Kfoxgy6XhODa6oTCk+XqhxFkpoQr6p/sEHmB3lK
         wrJs5jPCUzjHntDOzh3meRkoCNPBtaOUwlrxdjstHx94D5a+W8LBnxSc5wyvgkUspT0G
         /6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691953122; x=1692557922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbRMQLgn6q8vxhzEowCXC6DM0VIy22uIjp0J0FlZhHw=;
        b=f17zvtbon1LzJyscG8r8vHWy8j2UQPWfH88s8QRmOPJwO+6LCs8UF4lj0BJEMgFvVI
         H9MxsD+DA8K7FwmY0uWup7QjztLOnwuqp3s6Qblpe4ZkCng4uU3jhdHe8eUePwgO0kBn
         XnkOcq5/GwF9W/eKgOXc5a64FAuPFGFWNEoVwn8i+v8dRBXlA/yKJ8UXMWpIKfhdVRP5
         k3TGuXNvCcIbj+oFbZEkvu6wid02zlsYGI055DInhkFC9noETsiKHLRkU5aEytnqRrB2
         4jOTObPVOd4338fhIM+ZZLuch4/X22GmdgNI75ELctoKi65F7nlbKzLJ/H0p+8tx2M0S
         7AKw==
X-Gm-Message-State: AOJu0Yywp+0zhYjgMQsu4xjLgiaG28MacpE0m2r5AWJ/X8pMQ71Bc6bp
        UPXqhDWF7RbKqb2IXiu13tjTYIiOPXFVnS92YSQf0Q==
X-Google-Smtp-Source: AGHT+IEvpOk8ea7m2X3vZBrE0Ny9SDQyHNrazCNWd1S+UiFY+XEC89xad6T9d4vx8VCEZ/bYmPfek7fR6mdGzHzZntc=
X-Received: by 2002:a05:6512:a8d:b0:4fb:748f:604e with SMTP id
 m13-20020a0565120a8d00b004fb748f604emr6617146lfu.36.1691953122076; Sun, 13
 Aug 2023 11:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230811194032.4240-1-aboutphysycs@gmail.com> <4850013.31r3eYUQgx@jernej-laptop>
In-Reply-To: <4850013.31r3eYUQgx@jernej-laptop>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Sun, 13 Aug 2023 21:58:31 +0300
Message-ID: <CAH3L5QoVd45nR9HmAkSKJh7EnVXr1Jx6wqQ9j=x0AtNdqGjDaA@mail.gmail.com>
Subject: Re: [PATCH] thermal: sun8i_thermal: remove unneeded call to platform_set_drvdata()
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Andrei Coardos <aboutphysycs@gmail.com>, samuel@sholland.org,
        wens@csie.org, rui.zhang@intel.com, amitk@kernel.org,
        daniel.lezcano@linaro.org, rafael@kernel.org,
        tiny.windzz@gmail.com, anarsoul@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Aug 13, 2023 at 6:32=E2=80=AFPM Jernej =C5=A0krabec <jernej.skrabec=
@gmail.com> wrote:
>
> Dne petek, 11. avgust 2023 ob 21:40:32 CEST je Andrei Coardos napisal(a):
> > This function call was found to be unnecessary as there is no equivalen=
t
> > platform_get_drvdata() call to access the private data of the driver. A=
lso,
> > the private data is defined in this driver, so there is no risk of it b=
eing
> > accessed outside of this driver file.
> >
> > Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
>

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>

> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>
> Best regards,
> Jernej
>
> > ---
> >  drivers/thermal/sun8i_thermal.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/thermal/sun8i_thermal.c
> > b/drivers/thermal/sun8i_thermal.c index 195f3c5d0b38..61a2f287ac90 1006=
44
> > --- a/drivers/thermal/sun8i_thermal.c
> > +++ b/drivers/thermal/sun8i_thermal.c
> > @@ -489,8 +489,6 @@ static int sun8i_ths_probe(struct platform_device *=
pdev)
> > if (!tmdev->chip)
> >               return -EINVAL;
> >
> > -     platform_set_drvdata(pdev, tmdev);
> > -
> >       ret =3D sun8i_ths_resource_init(tmdev);
> >       if (ret)
> >               return ret;
>
>
>
>

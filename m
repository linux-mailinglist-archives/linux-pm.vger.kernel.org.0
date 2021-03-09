Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F170332A00
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 16:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhCIPQM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 10:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhCIPQD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 10:16:03 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360A3C06174A;
        Tue,  9 Mar 2021 07:16:03 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 75so9870098otn.4;
        Tue, 09 Mar 2021 07:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fo/UFIhHrZhOHbTilRDQ1Lx+49l/55BUkB2i0g94Gr4=;
        b=sdJfNL6Av8JgpvilDr3Dux06XuoejsBJh2ct8UcJqEepgn2M0/cYHrJchGJlKdFI/q
         yzSSf63kAtuCCi4YNASLVGMHeZ80DQ9rz/vDup3tHPrnD8VfYbIznWUc22wUqoRxGJHE
         Vn1nAaxPw4+leqi4JmM+xvaqvoHojwvAvlRxNLVSZ58MOFwMM+ZTXCXHShIBtiFAy3jD
         9lmiYCraV7Lo0G0McFH14cOqVXi5wPsq4LIcKiA23uX4mWW9kcqpSoJPSvgfAmeE3ftz
         opMh4SfGqfY+3Mk95Jqu07zF1ciBk5f03bOZF+rXCO8Kf+Y7tXk2nT2gVb/nHkyMsyZK
         VBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fo/UFIhHrZhOHbTilRDQ1Lx+49l/55BUkB2i0g94Gr4=;
        b=IzUx5HcYs3d8XnRXWADF8YClUUslvbskQ7YrC0GwJP1k6CG5vSGakIDc6rL5yXKzpq
         tFWNlPhdITZsFHF7syhg2UA40HCu31CUMC2pkDv3BZJLDXQaQKXz7HBDN2Hs+E/ODFc/
         /1lhgwRNQCaYaqn8dUp0Z7Ko5aNSQm/tVCmw3eiXpuseeSb0yfa+HQX5x3jieMAGLrdV
         DFVW2lZzR1lFz1gGBkivk/C+i1fgJKIi+6WbA3v1VX4nCqHa3Oili37U6/7shjbtFx8X
         JZ1Twjtkzo3vCWhCTm7SMuSm/1oSoHALCKBlCpCy8gTv6tevQBFBOPv0xUus+Tc8FA2l
         7PtQ==
X-Gm-Message-State: AOAM531d4avbNfttW08Pt0S76XSHkSivXfork9ejD/HB1/6gLuKpsKT4
        ygt5RfcLxCKttVOWjRSyZjQtXzd4ockuKFSleoo=
X-Google-Smtp-Source: ABdhPJxwTd00zYZgRH4HUdFcvaticC1wg+wqSFaoNmbgH6w5clc4oQHB6FmReAYCr9d95dHJ0oJlWtyjQIDfkP2S8qU=
X-Received: by 2002:a05:6830:408a:: with SMTP id x10mr3368002ott.248.1615302962661;
 Tue, 09 Mar 2021 07:16:02 -0800 (PST)
MIME-Version: 1.0
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-4-git-send-email-aisheng.dong@nxp.com> <717a9e7c-1b3f-2ea6-7471-fa554e47b71a@gmail.com>
In-Reply-To: <717a9e7c-1b3f-2ea6-7471-fa554e47b71a@gmail.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 9 Mar 2021 23:16:02 +0800
Message-ID: <CAA+hA=SmCH8FnLKrQFUE_4GR0ELmv1fywAWH__xH4OBk-NX13Q@mail.gmail.com>
Subject: Re: [PATCH 03/11] PM / devfreq: fix the wrong set_freq path for
 userspace governor
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        open list <linux-kernel@vger.kernel.org>,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Abel Vesa <abel.vesa@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 9, 2021 at 11:13 PM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> On 21. 3. 9. =EC=98=A4=ED=9B=84 9:58, Dong Aisheng wrote:
> > Fix the wrong set_freq path for userspace governor.
> >
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >   drivers/devfreq/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> > index 00704efe6398..20373a893b44 100644
> > --- a/drivers/devfreq/Kconfig
> > +++ b/drivers/devfreq/Kconfig
> > @@ -62,7 +62,7 @@ config DEVFREQ_GOV_USERSPACE
> >       help
> >         Sets the frequency at the user specified one.
> >         This governor returns the user configured frequency if there
> > -       has been an input to /sys/devices/.../power/devfreq_set_freq.
> > +       has been an input to /sys/devices/.../userspace/set_freq.
> >         Otherwise, the governor does not change the frequency
> >         given at the initialization.
> >
> >
>
> Looks good. But this patch just fix the information in Kconfig
> instead of fixing the wrong operation. To clarify the commit message,
> I'll change the patch title and commit message as following:

Looks like more accurate. Thanks.

Regards
Aisheng

>
>      PM / devfreq: Fix the wrong set_freq path for userspace governor in
> Kconfig
>
>      Fix the wrong set_freq path for userspace governor in Kconfig.
>
>      Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>
>
> Applied it. But, if you have any other objection, please let me know.
>
>
> --
> Best Regards,
> Samsung Electronics
> Chanwoo Choi

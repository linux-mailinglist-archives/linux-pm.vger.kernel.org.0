Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA38131EF64
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 20:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhBRTL4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 14:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbhBRRxy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 12:53:54 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EFDC06178A
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 09:52:32 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id c131so2967911ybf.7
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 09:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jCKXK+PFmSBOXc+6DZTlhejNeOtjzaMiiwtzHU5FCMg=;
        b=QhAFlNdbxz2ZH0EOmSuN4hH7h/bllTYnG73dsiApQ0JSkGBPa5ZkL8knPHaJoPXWnO
         /X+bHO3aksdKgwrCZvt3LrfXJIVwss4IlKznxks2L+c5MrW3EvkcyXM6O3huCsUA9u7+
         FPdxlFRTxlXvNNaBi1aj2eWLlWMVPvZ5vH1xjZE+/WUcAcFnQ6lGMj2XYKC//8IX9tOU
         3OFIHXhpMIDrqMDF9YsoBefUqlMC/aLOTHujPfL0Ns/kvlzJb+Q5sD+kWhdlGPNa2Edi
         9tw7Wtm54ULMECUzGqEyywFPQ/Ih5i6qI3jsWTJUwcT3FNVabOXl6+NWq6TpBSFGxXb6
         N8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jCKXK+PFmSBOXc+6DZTlhejNeOtjzaMiiwtzHU5FCMg=;
        b=T3d4HPnJQMa3eLPYRXZQrBAvOro0hfS0O7v8gdhj05aGnJN+VzGbidNWsmM3x8owb+
         +KqyZnpJuCNssLaaxjc+0cAsP/TWFTqGdyy2gr22uhU1mxoRxjj+1nN5Tq0PMUkxkr/G
         OQS41mi3NEmjzbNCVSCclImo4OIeO0jaWDHBItp7CAks2VwHWUkkFk2sNti6qJ7cQg/b
         yVbLTOA5vHgqpDxqnMh1d0xK8d1PvDd6o7NJ4kpfq7t/mPKPm947SED/9WLHatUCEBik
         Db+AKpdu/tI/rmuZDxN5aWNMkY9x8PCxZryv9JKZjFeM9MhGKdGIfJ6hVm1dTGUHGtaQ
         inkA==
X-Gm-Message-State: AOAM531bGw04le+5P8Pz8NhYBOcNTLC9TG3GjyKURqbPkYdTXMPSHFZM
        1yF98fTv9XSgCBNmX0nJku+WXXJMQLmuv/Qb5+8=
X-Google-Smtp-Source: ABdhPJyo/wApPoFIrmfdHLhAAxPzOMiWX1fM9bJuMOpRVHIyX175lMRr4b78LjKQHPMUIp0M082fu53Rk0s7dkzed0A=
X-Received: by 2002:a25:9885:: with SMTP id l5mr7627875ybo.501.1613670751941;
 Thu, 18 Feb 2021 09:52:31 -0800 (PST)
MIME-Version: 1.0
References: <YC6mW6hebIg7z9eA@makrotopia.org>
In-Reply-To: <YC6mW6hebIg7z9eA@makrotopia.org>
From:   =?UTF-8?Q?Daniel_Gonz=C3=A1lez_Cabanelas?= <dgcbueu@gmail.com>
Date:   Thu, 18 Feb 2021 18:52:20 +0100
Message-ID: <CABwr4_sfV_sRexcpBsGZw2UJf4cGRCFrNsNnmffvYHGknP2XMg@mail.gmail.com>
Subject: Re: small oddity in commit "power: reset: add driver for LinkStation
 power off"
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

El jue, 18 feb 2021 a las 18:39, Daniel Golle
(<daniel@makrotopia.org>) escribi=C3=B3:
>
> Hi Daniel,
>
> I stumbled upon a slight oddity in acommit you have contributed.
> Please see my comment below.
>
> > commit a7f79f99541eff4e6bcae0014eb08d3019337565
> > Author: Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.com>
> > Date:   Wed Jul 15 15:35:14 2020 +0200
> >
> >     power: reset: add driver for LinkStation power off
> >
> >     Some Buffalo LinkStations perform the power off operation, at resta=
rt
> >     time, depending on the state of an output pin (LED2/INTn) at the et=
hernet
> >     PHY. This pin is also used to wake the machine when a WoL packet is
> >     received by the PHY.
> >
> >     The driver is required by the Buffalo LinkStation LS421DE (ARM MVEB=
U),
> >     and other models. Without it, the board remains forever halted if a
> >     power off command is executed, unless the PSU is disconnected and
> >     connected again.
> >
> >     Add the driver to provide the power off function and also make the =
WoL
> >     feature to be available.
> >
> >     Signed-off-by: Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.com>
> >     Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ...
> > diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefil=
e
> > index 5710ca4695170..c51eceba9ea39 100644
> > --- a/drivers/power/reset/Makefile
> > +++ b/drivers/power/reset/Makefile
> > @@ -10,6 +10,7 @@ obj-$(CONFIG_POWER_RESET_GEMINI_POWEROFF) +=3D gemini=
-poweroff.o
> >  obj-$(CONFIG_POWER_RESET_GPIO) +=3D gpio-poweroff.o
> >  obj-$(CONFIG_POWER_RESET_GPIO_RESTART) +=3D gpio-restart.o
> >  obj-$(CONFIG_POWER_RESET_HISI) +=3D hisi-reboot.o
> > +obj-${CONFIG_POWER_RESET_LINKSTATION} +=3D linkstation-poweroff.o
>
> Why are you using curly brackets (ie. shell variable) here instead of
> normal parentheses (ie. Make variable)? It might work, but if there is
> no special reason for this, we should just be consistent with the rest
> of the file.

Hi Daniel. Indeed there is no reason to use curly brackets.

I have no idea why I commited this small mistake, probably I need to
graduate my glasses. Feel free to send a patch to fix it.

Thank you
Daniel
>
>
> Cheers
>
>
> Daniel

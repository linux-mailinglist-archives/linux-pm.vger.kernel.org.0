Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F272433D7C
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 19:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhJSRbS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 13:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhJSRbS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 13:31:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6C8C06161C;
        Tue, 19 Oct 2021 10:29:05 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so429203pjb.3;
        Tue, 19 Oct 2021 10:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W2X1FQaCbytH6Y85/dT0+c3wJsK9OsRJpL7ENlvvTJs=;
        b=AeB+pOTf5kJs/Z0r3aBXdKqT6wEplbvKH+tXHvBYW/4r9+YpsZZFJokIKTVWvnPL9A
         f2f7uAgd4x2L2hHZa7cFwOn3ulSBTfKCXgvAOJ2oqJDAcrbrQuZNXE1Eu6cxcRtqLmmc
         8FkBfQH/+5/LCgdQiUTQt/GUPLLjvLQR2Pkq0dVE+FSahdSiC+env5vJNWN7vTVsvE9f
         2O+G8h9nOlgcoORnzmjzSLusNjEhOwmBdat0jbNKkjdGJMrJA89C1vmyYkwi2tcV1RGY
         DdtFLoQX/Mm3lTU2eW2nx8dYVhgLZsSUuy3Yg+ny37MFuFv+WPszlvM8AK2L6XQgdlNo
         zE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W2X1FQaCbytH6Y85/dT0+c3wJsK9OsRJpL7ENlvvTJs=;
        b=x/3Q083fYndIUBW/fu4pJRplJKOsQiMgH56jcVjdaJQkyctcXhSoEr43qkkSmTNHjd
         j1W8QTxAMzGtJWmeXDE9g7O5WHOLS95Au1gdXmtPpbdRU41o2IihmrrvzVUg6O2I/0H/
         W0261vanEtj41QO6u3KAL1jGcotOoXuYPuvIsRIbDdbIxGQBxheraVIp49C88lPHeDso
         pVywAUULLtyojy9uoViF7KqQYJJvP788VdFdS6ug23Xz+oIhZn/R+WypkzMHXRIqeRfF
         6ydrPAGSHfjglN+uh9v4ex70KsWXVyyzjISjI6GLjqdxPic9Lovxx58rxgMo3ntvO+Ds
         O+Og==
X-Gm-Message-State: AOAM531xE5c/1bsNsEtNiidXCAhEKIJ40oxMtvonnttNOPpDcAJeT0uY
        2WKLxRf4sEcveUmfsnEVKF0pBik96E0CzcmaFxc=
X-Google-Smtp-Source: ABdhPJxlZkFuoAjdUJS8GFXiwpiKnmbV7aKH1yCtEw9KDPHGOTMeTZIWT/+sCYUojN4mkkY26vQHTsYRx94VC8yzyQc=
X-Received: by 2002:a17:902:a9c3:b0:13f:c765:148d with SMTP id
 b3-20020a170902a9c300b0013fc765148dmr9256619plr.28.1634664544821; Tue, 19 Oct
 2021 10:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210924115032.29684-1-o.rempel@pengutronix.de>
 <19b2ab33-aa56-75fb-f6ef-3c928be9c50c@linaro.org> <20211019115151.GC16320@pengutronix.de>
 <df3f527d-22f3-b58d-a546-bdd8d312505c@linaro.org> <20211019125929.GD16320@pengutronix.de>
In-Reply-To: <20211019125929.GD16320@pengutronix.de>
From:   Petr Benes <petrben@gmail.com>
Date:   Tue, 19 Oct 2021 19:28:53 +0200
Message-ID: <CAPwXO5Z8k9TZ4y6ZTFrv-2TK7Lv8Y28LDSTXpT8s4oPPDxupYw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] thermal: imx: implement runtime PM support
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Zhang Rui <rui.zhang@intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We dropped Michal from the loop. Adding him back.

On Tue, 19 Oct 2021 at 14:59, Oleksij Rempel <o.rempel@pengutronix.de> wrot=
e:
>
> On Tue, Oct 19, 2021 at 01:55:32PM +0200, Daniel Lezcano wrote:
> > On 19/10/2021 13:51, Oleksij Rempel wrote:
> > > Hi Daniel,
> > >
> > > On Tue, Oct 19, 2021 at 01:04:46PM +0200, Daniel Lezcano wrote:
> > >> On 24/09/2021 13:50, Oleksij Rempel wrote:
> > >>> Starting with commit d92ed2c9d3ff ("thermal: imx: Use driver's loca=
l
> > >>> data to decide whether to run a measurement") this driver stared us=
ing
> > >>> irq_enabled flag to make decision to power on/off the thermal core.=
 This
> > >>> triggered a regression, where after reaching critical temperature, =
alarm
> > >>> IRQ handler set irq_enabled to false,  disabled thermal core and wa=
s not
> > >>> able read temperature and disable cooling sequence.
> > >>>
> > >>> In case the cooling device is "CPU/GPU freq", the system will run w=
ith
> > >>> reduce performance until next reboot.
> > >>>
> > >>> To solve this issue, we need to move all parts implementing hand ma=
de
> > >>> runtime power management and let it handle actual runtime PM framew=
ork.
> > >>>
> > >>> Fixes: d92ed2c9d3ff ("thermal: imx: Use driver's local data to deci=
de whether to run a measurement")
> > >>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > >>
> > >> Thanks for this fix.
> > >>
> > >> Petr or Oleksij,
> > >>
> > >> could you confirm it is tested and working without CONFIG_PM ?
> > >
> > > Petr was right, no it is not working without PM.
> > Ok, thanks.
> >
> > I suppose the fix is related to the initialization of the sensor which
> > should be enabled with/out pm_runtime, right ?
>
> No, i did sanity check on pm_runtime_put() within the probe. Without PM
> it will properly return ENOSYS, so I aborted the probe. Looks like I
> should ignore return value on this function like every driver is doing
> it.
>
> >
> >
> > --
> > <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for =
ARM SoCs
> >
> > Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> > <http://twitter.com/#!/linaroorg> Twitter |
> > <http://www.linaro.org/linaro-blog/> Blog
> >
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09A3D77745
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2019 08:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfG0GdY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 27 Jul 2019 02:33:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37205 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfG0GdX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 27 Jul 2019 02:33:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so49271994wme.2;
        Fri, 26 Jul 2019 23:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ldJpVA6CE8TYIFWLOiSPguYs7EOGYw+Dfb3wpQniKEw=;
        b=sPAPHVvj/MDKirz5G4DrNwsHaEC0OfA1zsJsGk2qMS1qyY87+dcEx7MzdyqHWvfh+e
         zPkHdYDZdYpEHzIPzgrYVsxPJMz/2orE7rs6BQcAf1EnyZouv2q9YKBs6ULpldMnIoRw
         DKPC8U0a+vCYNaheHFFXB/AVlxozJpJI16dQxFkPak/RBGY2p15dte3hJ3E9Id2vRUZQ
         sfC3oIjEse/IRiiXQNnfhQNLPlukknwB4Qcy0Sjz5+52G6mINUwuiwSdY1+CeXvVQWSc
         Ap8uXbYfRIx5yi8Gy6GbGBjXPVMRQr4arZd6854a5NbouDV3IWi6pRu6GhSevHiJgD82
         OsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ldJpVA6CE8TYIFWLOiSPguYs7EOGYw+Dfb3wpQniKEw=;
        b=B0MKRtk+nwB17UO9MKmDgD97ppmu9r8TisruBjuBxwuESs6O9hNtJa1d0crXgY5VRn
         2QEKg2VLTILaIYIJf0FAuYf/k2KdeydI7kzw5D2aAWn+c3VxoeTO1Q6HAkhxY0EjjPNI
         rXD/ibZ4NKvnxMnqASiC5iLSHRI/Jy8YHatniLVZricleFRrG0wKPJapDGtzFwcOYV7s
         tMPfjLO9uyDKBQHeeNAWQcwyJdlcXzFK06nCVwnuJXaUcuL5hJNY48wcQvAmKZm2CijU
         nTrlXSirx0NRtgV08WjJmc3pasyQUBjwz5zuS6WwCs6ROoSXCVmda46Hovm4ABmBS1T9
         Lh2w==
X-Gm-Message-State: APjAAAWfXALFhv7bRctswB4NcjFZFJMJNYxmYfqJOdfcm4xr7RIkYeto
        XCkUzzPSMpprdHpZhQyzsZuecFYAggURqihbUdQ=
X-Google-Smtp-Source: APXvYqy92oOEaSw9pO9I2bT0W1j8OkANGqP73txRdDJZYc35yUpNin5FBhApbrCoeq1jkR6QhmZfNC1vyrlkYdmvbdQ=
X-Received: by 2002:a1c:96c7:: with SMTP id y190mr81779074wmd.87.1564209201152;
 Fri, 26 Jul 2019 23:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190705045612.27665-1-Anson.Huang@nxp.com> <20190705045612.27665-5-Anson.Huang@nxp.com>
 <CAEnQRZAZNMBx3ApVmRP8hYPw0XY_QgR-saE6WLcT8oZmHPCxSA@mail.gmail.com> <DB3PR0402MB3916233A56CF5DF778115716F5C30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916233A56CF5DF778115716F5C30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Sat, 27 Jul 2019 09:33:10 +0300
Message-ID: <CAEnQRZCrZybzcy__u4p_Eq4zSVc2ESyfKLk5sPf1JYba1JSOiA@mail.gmail.com>
Subject: Re: [PATCH 5/6] clk: imx8mq: Remove CLK_IS_CRITICAL flag for IMX8MQ_CLK_TMU_ROOT
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Carlo Caione <ccaione@baylibre.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jul 27, 2019 at 9:19 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Daniel
>
> > Subject: Re: [PATCH 5/6] clk: imx8mq: Remove CLK_IS_CRITICAL flag for
> > IMX8MQ_CLK_TMU_ROOT
> >
> > Hi all,
> >
> > latest linux-next hangs at boot.
> >
> > commit fde50b96be821ac9673a7e00847cc4605bd88f34 (HEAD -> master, tag:
> > next-20190726, origin/master, origin/HEAD)
> > Author: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date:   Fri Jul 26 15:18:02 2019 +1000
> >
> >     Add linux-next specific files for 20190726
> >
> >     Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> >
> >
> > I know this is crazy but reverting commit:
> >
> > commit 431bdd1df48ee2896ea9980d9153e3aeaf0c81ef (refs/bisect/bad)
> > Author: Anson Huang <Anson.Huang@nxp.com>
> > Date:   Fri Jul 5 12:56:11 2019 +0800
> >
> >     clk: imx8mq: Remove CLK_IS_CRITICAL flag for IMX8MQ_CLK_TMU_ROOT
> >
> >     IMX8MQ_CLK_TMU_ROOT is ONLY used for thermal module, the driver
> >     should manage this clock, so no need to have CLK_IS_CRITICAL flag
> >     set.
> >
> >
> >
> > makes the boot work again.
> >
> > Any idea?
>
> I just found if disabling SDMA1, then kernel can boot up, it does NOT make sense
> TMU clock is related to SDMA1, I will check with design and get back to you soon.
>

Hi Anson,

Applying Abel's patch:

commit 8816c47db6a82f55bb4d64f62fd9dd3af680f0e4 (HEAD -> master)
Author: Abel Vesa <abel.vesa@nxp.com>
Date:   Tue Jun 25 12:01:56 2019 +0300

    clk: imx8mq: Mark AHB clock as critical

    Keep the AHB clock always on since there is no driver to control it and
    all the other clocks that use it as parent rely on it being always enabled.



The kernel boots up again.

It make some sense. I don't understand though why having
IMX8MQ_CLK_TMU_ROOT as critical also "unhangs" the kernel.

thanks,
Daniel.

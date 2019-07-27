Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E632677B0E
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2019 20:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388097AbfG0S0n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 27 Jul 2019 14:26:43 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:38766 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388091AbfG0S0m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 27 Jul 2019 14:26:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 442EEFB03;
        Sat, 27 Jul 2019 20:26:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vRGa6_JKtNHm; Sat, 27 Jul 2019 20:26:37 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id DDD4B46B22; Sat, 27 Jul 2019 20:26:36 +0200 (CEST)
Date:   Sat, 27 Jul 2019 20:26:36 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <ccaione@baylibre.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        daniel.lezcano@linaro.org, dl-linux-imx <Linux-imx@nxp.com>,
        rui.zhang@intel.com, Michael Turquette <mturquette@baylibre.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        edubezval@gmail.com, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 5/6] clk: imx8mq: Remove CLK_IS_CRITICAL flag for
 IMX8MQ_CLK_TMU_ROOT
Message-ID: <20190727182636.GA7170@bogon.m.sigxcpu.org>
References: <20190705045612.27665-1-Anson.Huang@nxp.com>
 <20190705045612.27665-5-Anson.Huang@nxp.com>
 <CAEnQRZAZNMBx3ApVmRP8hYPw0XY_QgR-saE6WLcT8oZmHPCxSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnQRZAZNMBx3ApVmRP8hYPw0XY_QgR-saE6WLcT8oZmHPCxSA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,
On Sat, Jul 27, 2019 at 01:26:50AM +0300, Daniel Baluta wrote:
> Hi all,
> 
> latest linux-next hangs at boot.
> 
> commit fde50b96be821ac9673a7e00847cc4605bd88f34 (HEAD -> master, tag:
> next-20190726, origin/master, origin/HEAD)
> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> Date:   Fri Jul 26 15:18:02 2019 +1000
> 
>     Add linux-next specific files for 20190726
> 
>     Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> 
> I know this is crazy but reverting commit:
> 
> commit 431bdd1df48ee2896ea9980d9153e3aeaf0c81ef (refs/bisect/bad)
> Author: Anson Huang <Anson.Huang@nxp.com>
> Date:   Fri Jul 5 12:56:11 2019 +0800
> 
>     clk: imx8mq: Remove CLK_IS_CRITICAL flag for IMX8MQ_CLK_TMU_ROOT
> 
>     IMX8MQ_CLK_TMU_ROOT is ONLY used for thermal module, the driver
>     should manage this clock, so no need to have CLK_IS_CRITICAL flag
>     set.
> 
> 
> 
> makes the boot work again.

I noticed a boot hang yesterday on next-20190726 when loading the
qoriq_thermal which I worked around by blacklisting it. The
fsl,imx8mq-tmu node specifies a clock (IMX8MQ_CLK_TMU_ROOT) but does not
seem to enable, shouldn't it do so?

Cheers,
 -- Guido

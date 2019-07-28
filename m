Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED1D177E84
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2019 09:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfG1H7D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Jul 2019 03:59:03 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:51808 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfG1H7D (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 28 Jul 2019 03:59:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 41444FB03;
        Sun, 28 Jul 2019 09:59:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Wyg7IDtmtuoB; Sun, 28 Jul 2019 09:58:59 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id BF96646B51; Sun, 28 Jul 2019 09:58:58 +0200 (CEST)
Date:   Sun, 28 Jul 2019 09:58:58 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <ccaione@baylibre.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        dl-linux-imx <Linux-imx@nxp.com>,
        "rui.zhang" <rui.zhang@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 5/6] clk: imx8mq: Remove CLK_IS_CRITICAL flag for
 IMX8MQ_CLK_TMU_ROOT
Message-ID: <20190728075858.GA15144@bogon.m.sigxcpu.org>
References: <20190705045612.27665-1-Anson.Huang@nxp.com>
 <20190705045612.27665-5-Anson.Huang@nxp.com>
 <CAEnQRZAZNMBx3ApVmRP8hYPw0XY_QgR-saE6WLcT8oZmHPCxSA@mail.gmail.com>
 <20190727182636.GA7170@bogon.m.sigxcpu.org>
 <CAOMZO5C_g5bO-yqhoLbb6geUcmzi4necjdQ_P2tROq2vzEPOqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5C_g5bO-yqhoLbb6geUcmzi4necjdQ_P2tROq2vzEPOqQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Fabio,
On Sat, Jul 27, 2019 at 05:17:50PM -0300, Fabio Estevam wrote:
> Hi Guido,
> 
> On Sat, Jul 27, 2019 at 3:26 PM Guido Günther <agx@sigxcpu.org> wrote:
> 
> > I noticed a boot hang yesterday on next-20190726 when loading the
> > qoriq_thermal which I worked around by blacklisting it. The
> > fsl,imx8mq-tmu node specifies a clock (IMX8MQ_CLK_TMU_ROOT) but does not
> > seem to enable, shouldn't it do so?
> 
> Yes, I think you are right.
> 
> I don't have access to a imx8mq board at the moment, but something
> like below would probably help:
> http://code.bulix.org/pd88jp-812381
> 
> If it helps, I can send it as a formal patch.

Yes, this fixes it for me, thanks!
 -- Guido

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E835F290FC
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2019 08:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388260AbfEXGco (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 May 2019 02:32:44 -0400
Received: from gloria.sntech.de ([185.11.138.130]:34236 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388185AbfEXGco (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 May 2019 02:32:44 -0400
Received: from [46.183.103.17] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hU3ka-0002QF-W5; Fri, 24 May 2019 08:32:21 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] Revert "thermal: rockchip: fix up the tsadc pinctrl setting error"
Date:   Fri, 24 May 2019 08:32:19 +0200
Message-ID: <2521723.3ZzQbFiSsD@phil>
In-Reply-To: <20190524022042.GA1936@localhost.localdomain>
References: <20190522141236.26987-1-heiko@sntech.de> <CAD=FV=UxwqkHpsxXhEHrQDY6MtymeT3Gn_G4Q5xSh6pZVWTRHA@mail.gmail.com> <20190524022042.GA1936@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Freitag, 24. Mai 2019, 04:20:43 CEST schrieb Eduardo Valentin:
> On Wed, May 22, 2019 at 08:34:34AM -0700, Doug Anderson wrote:
> > Hi,
> > 
> > On Wed, May 22, 2019 at 7:12 AM Heiko Stuebner <heiko@sntech.de> wrote:
> > >
> > > This reverts commit 28694e009e512451ead5519dd801f9869acb1f60.
> > >
> > > The commit causes multiple issues in that:
> > > - the added call to ->control does potentially run unclocked
> > >   causing a hang of the machine
> > > - the added pinctrl-states are undocumented in the binding
> > > - the added pinctrl-states are not backwards compatible, breaking
> > >   old devicetrees.
> > >
> > > Fixes: 28694e009e51 ("thermal: rockchip: fix up the tsadc pinctrl setting error")
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > >  drivers/thermal/rockchip_thermal.c | 36 +++---------------------------
> > >  1 file changed, 3 insertions(+), 33 deletions(-)
> > 
> > In case it helps with the urgency, there are lots of people who have
> > all independently needed to identify which commit stopped their boards
> > from booting mainline or broke temperature reading.  I'm aware of at
> > least these reports:
> > 
> > Reported-by: kernelci.org bot <bot@kernelci.org>
> > Reported-by: Enric Balletbo Serra <eballetbo@gmail.com>
> > Reported-by: Vicente Bergas <vicencb@gmail.com>
> > Reported-by: Jack Mitchell <ml@embed.me.uk>
> > Reported-by: Douglas Anderson <dianders@chromium.org>
> > 
> > I can confirm that my board boots again after this revert, thus:
> > 
> > Tested-by: Douglas Anderson <dianders@chromium.org>
> 
> I see. I can collect this revert if that is what unblocks you guys.
>
> Elaine, do you mind checking why these pinctrl changes are causing
> boot issues?

The pinctrl issue is secondary, it makes the thermal driver fail to
probe, due to not handling existing devicetrees properly.
Hence the driver needs to stay backwards compatible with existing
devicetrees.

The hang is caused by the call to the per-soc ->control callback before
the clocks get enabled, relying on it being on at boot and that isn't the
case everywhere.

Heiko



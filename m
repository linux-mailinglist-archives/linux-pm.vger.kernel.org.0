Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC7C2840ED
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 22:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgJEUdv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 16:33:51 -0400
Received: from static-213-198-238-194.adsl.eunet.rs ([213.198.238.194]:51502
        "EHLO fx.arvanta.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbgJEUdv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 16:33:51 -0400
Received: from arya.arvanta.net (arya.arvanta.net [10.5.1.6])
        by fx.arvanta.net (Postfix) with ESMTP id 0379C1C136;
        Mon,  5 Oct 2020 22:33:49 +0200 (CEST)
Date:   Mon, 5 Oct 2020 22:33:49 +0200
From:   Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To:     Vicente Bergas <vicencb@gmail.com>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        kernel@collabora.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH] power: supply: sbs-battery: chromebook workaround for PEC
Message-ID: <20201005203349.GA23644@arya.arvanta.net>
References: <20201004224601.420786-1-sebastian.reichel@collabora.com>
 <9b4f62f2-0bf6-41bb-a946-bd94c75168b8@gmail.com>
 <20201005184759.GA15677@arya.arvanta.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201005184759.GA15677@arya.arvanta.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2020-10-05 at 20:48, Milan P. Stanić wrote:
> Hi all,
> 
> On Mon, 2020-10-05 at 19:53, Vicente Bergas wrote:
> > On Monday, October 5, 2020 12:46:01 AM CEST, Sebastian Reichel wrote:
> > > Looks like the I2C tunnel implementation from Chromebook's
> > > embedded controller does not handle PEC correctly. Fix this
> > > by disabling PEC for batteries behind those I2C tunnels as
> > > a workaround.
> > > 
> > > Reported-by: "Milan P. Stanić" <mps@arvanta.net>
> > > Reported-by: Vicente Bergas <vicencb@gmail.com>
> > > CC: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > Fixes: 7222bd603dd2 ("power: supply: sbs-battery: add PEC support")
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > ---
> > > Hi,
> > > 
> > > This is compile-tested only, since I do not have a chromebook at
> > > hand. Please test if this fixes your issue.
> > 
> > Hi Sebastian,
> > tested on rk3399-gru-kevin with 5.9.0-rc8 and now the CPU usage is 0 when
> > idling.
> > dmesg reports:
> > [    1.370249] sbs-battery 9-000b: Disabling PEC because of broken Cros-EC
> > implementation
> 
> Also I tested on same board and same kernel version and can confirm
> this.

And I forgot to mention that I opened bug report. sorry.
https://bugzilla.kernel.org/show_bug.cgi?id=209409
  
> > So,
> > Tested-by: Vicente Bergas <vicencb@gmail.com>
> > 
> > Thanks,
> >  Vicente.
> > 
> > > -- Sebastian
> > > ---
> > >  drivers/power/supply/sbs-battery.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/power/supply/sbs-battery.c
> > > b/drivers/power/supply/sbs-battery.c
> > > index 13192cbcce71..b6a538ebb378 100644
> > > --- a/drivers/power/supply/sbs-battery.c
> > > +++ b/drivers/power/supply/sbs-battery.c
> > > @@ -279,6 +279,12 @@ static int sbs_update_presence(struct sbs_info
> > > *chip, bool is_present)
> > >  	else
> > >  		client->flags &= ~I2C_CLIENT_PEC;
> > >   +	if (of_device_is_compatible(client->dev.parent->of_node,
> > > "google,cros-ec-i2c-tunnel")
> > > +	    && client->flags & I2C_CLIENT_PEC) {
> > > +		dev_info(&client->dev, "Disabling PEC because of broken Cros-EC
> > > implementation\n");
> > > +		client->flags &= ~I2C_CLIENT_PEC;
> > > +	}
> > > +
> > >  	dev_dbg(&client->dev, "PEC: %s\n", (client->flags & I2C_CLIENT_PEC) ?
> > >  		"enabled" : "disabled");
> > 

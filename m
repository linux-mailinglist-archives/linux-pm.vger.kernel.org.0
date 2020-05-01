Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B4E1C1782
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 16:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgEAOPe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 10:15:34 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:4154 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728887AbgEAOPe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 May 2020 10:15:34 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49DDmh0frmz7N;
        Fri,  1 May 2020 16:15:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588342532; bh=RSVIoD6VEbRqaKAB24EY4AB1NEEW81ul1IDXuwJqhz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N1oXLXFRCb8Kh9GRwXssEDApma+kNVrzNYhpt715GFVvRov8u1v+mC82iEZa9aPy/
         7qahTJHw0mYmIPz0+LgXgtOys0jFma7ieOZy+cCefsSUy40SyuFBindslcQraTJrV+
         xjTq78d6nFdEvsOufDb6jGnXB71vEruE89ieqOR+u+ftxagWSq8jNV57HYH+nGsNj3
         3s3vSms39RS7pI1xa5H99WnFcynNrvRR0eeE5kvsXo782PbXg5sAKV/IryJH1Snlka
         fxyjHflW4vSA/NM6s+1sg3NrtkVpfwi9KdN2rXoaPuOcVj+wK3Bn27iEOoMws1ZkBo
         Xt79A7e4nHHuw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 1 May 2020 16:15:30 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: charger-manager: fix adding of optional properties
Message-ID: <20200501141530.GA18633@qmqm.qmqm.pl>
References: <20200501133008.GA8927@qmqm.qmqm.pl>
 <995cf2c7d41d4895c319b60ea4ea83e858c34cef.1588340276.git.mirq-linux@rere.qmqm.pl>
 <20200501135109.45gwxpczcqdt3fbb@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200501135109.45gwxpczcqdt3fbb@earth.universe>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 01, 2020 at 03:51:09PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, May 01, 2020 at 03:39:53PM +0200, Micha³ Miros³aw wrote:
> > Use num_properties to index added property.
> > This will prevent overwriting POWER_SUPPLY_PROP_CHARGE_NOW with
> > POWER_SUPPLY_PROP_CURRENT_NOW and leaving the latter entry
> > uninitialized.
> > 
> > For clarity, num_properties is initialized with length of the copied
> > array instead of relying on previously memcpy'd value.
> > 
> > Fixes: 0a46510addc7 ("power: supply: charger-manager: Prepare for const properties")
> > Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> > ---
> 
> I folded your fix directly into the charger-manager patch, which did
> not yet reach linux-next. If you send the num_properties part as a
> separate one, I will merge it.

Since your patch already changes the line, maybe you could squash first
hunk below into it?

> >  drivers/power/supply/charger-manager.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
> > index a71e2ee81423..2ef53dc1f2fb 100644
> > --- a/drivers/power/supply/charger-manager.c
> > +++ b/drivers/power/supply/charger-manager.c
> > @@ -1729,7 +1729,7 @@ static int charger_manager_probe(struct platform_device *pdev)
> >  	memcpy(properties, default_charger_props,
> >  		sizeof(enum power_supply_property) *
> >  		ARRAY_SIZE(default_charger_props));
> > -	num_properties = psy_default.num_properties;
> > +	num_properties = ARRAY_SIZE(default_charger_props);
> >  
> >  	/* Find which optional psy-properties are available */
> >  	fuel_gauge = power_supply_get_by_name(desc->psy_fuel_gauge);
[...]

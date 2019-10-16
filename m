Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 307A0DA196
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 00:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391855AbfJPWgN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 18:36:13 -0400
Received: from muru.com ([72.249.23.125]:37664 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfJPWgN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Oct 2019 18:36:13 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D0BC08107;
        Wed, 16 Oct 2019 22:36:46 +0000 (UTC)
Date:   Wed, 16 Oct 2019 15:36:09 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 1/2] power: supply: cpcap-battery: Fix handling of
 lowered charger voltage
Message-ID: <20191016223609.GH5610@atomide.com>
References: <20191009210141.10037-1-tony@atomide.com>
 <20191009210141.10037-2-tony@atomide.com>
 <20191013113017.GC5653@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013113017.GC5653@amd>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [191013 11:30]:
> > +static int cpcap_battery_set_property(struct power_supply *psy,
> > +				      enum power_supply_property psp,
> > +				      const union power_supply_propval *val)
> > +{
> > +	struct cpcap_battery_ddata *ddata = power_supply_get_drvdata(psy);
> > +
> > +	switch (psp) {
> > +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> > +		if (val->intval < ddata->config.info.voltage_min_design)
> > +			return -EINVAL;
> 
> Is minimum design applicable here? I believe that's the lowest voltage
> battery is discharged to...
> 
> I guess we can use it if there's no more suitable limit?

Yeah so it seems, and can be changed if we find something bettter.

> > +		ddata->config.bat.constant_charge_voltage_max_uv = val->intval;
> > +
> > +		return cpcap_battery_update_charger(ddata, val->intval);
> > +	break;
> 
> Delete the break.

Sure thanks.

Tony

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8D22DE081
	for <lists+linux-pm@lfdr.de>; Fri, 18 Dec 2020 10:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgLRJnM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Dec 2020 04:43:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732761AbgLRJnM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Dec 2020 04:43:12 -0500
Date:   Fri, 18 Dec 2020 10:42:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608284550;
        bh=8UBtkOy+EdvKbwp1+yD9OVf/OKarJDscavBZccF/vbE=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=JuubyK77I2chT0Q+9DDp3GiVMW0MY8NRLaF41Dfuv36GIDFCFpHB5P7WtpB+Ux3Kd
         +DqTbIpjNHxGw/KCuz/nZahz6QUGpusLpZtUjWnBKk9BuA/tsantQ/eBNub4Lq4Vge
         HnkuOxhyVZi5jqoqf+sHHMKZvFW3IiY7XfA0449M2ue0LbjUtyypCK5b6SGZLn9jvv
         kME/YHp1eIV5NrB8l0t3ALVvM33E5w7plofpjYmfvKDj9uR0S3qx+I4Cmld0kYtH+K
         kLhdajMvYa2EF9ftHjnpSviz6hAyX243Sj6H1VOZWS+q57a+c8vUN3g86mBbNTKYyf
         zE9R/ik3GzuDA==
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Hermes Zhang <Hermes.Zhang@axis.com>
Cc:     Dan Murphy <dmurphy@ti.com>, Sebastian Reichel <sre@kernel.org>,
        kernel <kernel@axis.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: supply: bq27xxx: Supporrt CHARGE_NOW for
 bq27z561/bq28z610/bq34z100
Message-ID: <20201218094227.cacwoxzfu7e26mek@pali>
References: <20201217114737.7263-1-chenhui.zhang@axis.com>
 <20201217115648.iiferqyvg7tlnmln@pali>
 <c77d50a397054b20a4945140820a54e0@XBOX03.axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c77d50a397054b20a4945140820a54e0@XBOX03.axis.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday 17 December 2020 12:03:24 Hermes Zhang wrote:
> Hi Pali,
> 
> From the TI spec (e.g. https://www.ti.com/lit/ug/tidu077/tidu077.pdf?ts=1608206347022&ref_url=https%253A%252F%252Fwww.google.com%252F) , the NAC and RC (RemainingCapacity) are different:
> 
> 4.5 NominalAvailableCapacity( ): 0x08/0x09
> This read-only command pair returns the uncompensated (less than C/20 load) battery capacity
> remaining. Units are mAh.
> 
> 4.7 RemainingCapacity( ): 0x0c/0x0d
> This read-only command pair returns the compensated battery capacity remaining. Units are mAh.

Ok, thank you for explanation!

> But for some chip e.g. bq27z561 it doesn't have the NAC Reg, so I prefer to use RC instead.

I see that in your patch every configuration has either NAC or RC, but
none both (and some has none of them). Does it mean that every chip has
NAC or RC, but not both?

> Best Regards,
> Hermes
> 
> -----Original Message-----
> From: Pali Rohár <pali@kernel.org> 
> Sent: 2020年12月17日 19:57
> To: Hermes Zhang <Hermes.Zhang@axis.com>
> Cc: Dan Murphy <dmurphy@ti.com>; Sebastian Reichel <sre@kernel.org>; kernel <kernel@axis.com>; Hermes Zhang <Hermes.Zhang@axis.com>; linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] power: supply: bq27xxx: Supporrt CHARGE_NOW for bq27z561/bq28z610/bq34z100
> 
> On Thursday 17 December 2020 19:47:37 Hermes Zhang wrote:
> > From: Hermes Zhang <chenhuiz@axis.com>
> > 
> > The CHARGE_NOW is map to REG_NAC for all the gauge chips beofre. But 
> > for some chips (e.g. bq27z561) which doesn't have the REG_NAC, we use 
> > REG_RC (remaining capacity) for CHARGE_NOW.
> 
> Hello! What is the difference between NAC and RC? Is not it same thing?
> I'm asking because for me from this patch for power supply API purpose it is the same thing... And therefore if it does not make sense to define for bq27z561 chip BQ27XXX_REG_NAC reg value to value which you used in BQ27XXX_REG_RC (to simplify whole implementation).
> 
> > Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
> > ---
> >  drivers/power/supply/bq27xxx_battery.c | 35 
> > +++++++++++++++++++++++++-
> >  1 file changed, 34 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/power/supply/bq27xxx_battery.c 
> > b/drivers/power/supply/bq27xxx_battery.c
> > index 315e0909e6a4..c1a49a598e9b 100644
> > --- a/drivers/power/supply/bq27xxx_battery.c
> > +++ b/drivers/power/supply/bq27xxx_battery.c
> > @@ -110,6 +110,7 @@ enum bq27xxx_reg_index {
> >  	BQ27XXX_REG_TTES,	/* Time-to-Empty Standby */
> >  	BQ27XXX_REG_TTECP,	/* Time-to-Empty at Constant Power */
> >  	BQ27XXX_REG_NAC,	/* Nominal Available Capacity */
> > +	BQ27XXX_REG_RC,		/* Remaining Capacity */
> >  	BQ27XXX_REG_FCC,	/* Full Charge Capacity */
> >  	BQ27XXX_REG_CYCT,	/* Cycle Count */
> >  	BQ27XXX_REG_AE,		/* Available Energy */
> > @@ -145,6 +146,7 @@ static u8
> >  		[BQ27XXX_REG_TTES] = 0x1c,
> >  		[BQ27XXX_REG_TTECP] = 0x26,
> >  		[BQ27XXX_REG_NAC] = 0x0c,
> > +		[BQ27XXX_REG_RC] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_FCC] = 0x12,
> >  		[BQ27XXX_REG_CYCT] = 0x2a,
> >  		[BQ27XXX_REG_AE] = 0x22,
> > @@ -169,6 +171,7 @@ static u8
> >  		[BQ27XXX_REG_TTES] = 0x1c,
> >  		[BQ27XXX_REG_TTECP] = 0x26,
> >  		[BQ27XXX_REG_NAC] = 0x0c,
> > +		[BQ27XXX_REG_RC] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_FCC] = 0x12,
> >  		[BQ27XXX_REG_CYCT] = 0x2a,
> >  		[BQ27XXX_REG_AE] = INVALID_REG_ADDR, @@ -193,6 +196,7 @@ static u8
> >  		[BQ27XXX_REG_TTES] = 0x1a,
> >  		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_NAC] = 0x0c,
> > +		[BQ27XXX_REG_RC] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_FCC] = 0x12,
> >  		[BQ27XXX_REG_CYCT] = 0x2a,
> >  		[BQ27XXX_REG_AE] = INVALID_REG_ADDR, @@ -215,6 +219,7 @@ static u8
> >  		[BQ27XXX_REG_TTES] = 0x1c,
> >  		[BQ27XXX_REG_TTECP] = 0x26,
> >  		[BQ27XXX_REG_NAC] = 0x0c,
> > +		[BQ27XXX_REG_RC] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_FCC] = 0x12,
> >  		[BQ27XXX_REG_CYCT] = 0x2a,
> >  		[BQ27XXX_REG_AE] = 0x22,
> > @@ -237,6 +242,7 @@ static u8
> >  		[BQ27XXX_REG_TTES] = 0x1a,
> >  		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_NAC] = 0x0c,
> > +		[BQ27XXX_REG_RC] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_FCC] = 0x12,
> >  		[BQ27XXX_REG_CYCT] = 0x1e,
> >  		[BQ27XXX_REG_AE] = INVALID_REG_ADDR, @@ -257,6 +263,7 @@ static u8
> >  		[BQ27XXX_REG_TTES] = 0x1c,
> >  		[BQ27XXX_REG_TTECP] = 0x26,
> >  		[BQ27XXX_REG_NAC] = 0x0c,
> > +		[BQ27XXX_REG_RC] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_FCC] = 0x12,
> >  		[BQ27XXX_REG_CYCT] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_AE] = 0x22,
> > @@ -277,6 +284,7 @@ static u8
> >  		[BQ27XXX_REG_TTES] = 0x1c,
> >  		[BQ27XXX_REG_TTECP] = 0x26,
> >  		[BQ27XXX_REG_NAC] = 0x0c,
> > +		[BQ27XXX_REG_RC] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_FCC] = 0x12,
> >  		[BQ27XXX_REG_CYCT] = 0x2a,
> >  		[BQ27XXX_REG_AE] = 0x22,
> > @@ -297,6 +305,7 @@ static u8
> >  		[BQ27XXX_REG_TTES] = 0x1c,
> >  		[BQ27XXX_REG_TTECP] = 0x26,
> >  		[BQ27XXX_REG_NAC] = 0x0c,
> > +		[BQ27XXX_REG_RC] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_FCC] = 0x12,
> >  		[BQ27XXX_REG_CYCT] = 0x2a,
> >  		[BQ27XXX_REG_AE] = 0x22,
> > @@ -317,6 +326,7 @@ static u8
> >  		[BQ27XXX_REG_TTES] = 0x1c,
> >  		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_NAC] = 0x0c,
> > +		[BQ27XXX_REG_RC] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_FCC] = 0x12,
> >  		[BQ27XXX_REG_CYCT] = 0x1e,
> >  		[BQ27XXX_REG_AE] = INVALID_REG_ADDR, @@ -337,6 +347,7 @@ static u8
> >  		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_NAC] = INVALID_REG_ADDR,
> > +		[BQ27XXX_REG_RC] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_FCC] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_CYCT] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_AE] = INVALID_REG_ADDR, @@ -361,6 +372,7 @@ static u8
> >  		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_NAC] = 0x0c,
> > +		[BQ27XXX_REG_RC] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_FCC] = 0x12,
> >  		[BQ27XXX_REG_CYCT] = 0x2a,
> >  		[BQ27XXX_REG_AE] = INVALID_REG_ADDR, @@ -382,6 +394,7 @@ static u8
> >  		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_NAC] = 0x0c,
> > +		[BQ27XXX_REG_RC] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_FCC] = 0x12,
> >  		[BQ27XXX_REG_CYCT] = 0x2a,
> >  		[BQ27XXX_REG_AE] = INVALID_REG_ADDR, @@ -405,6 +418,7 @@ static u8
> >  		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_NAC] = 0x0c,
> > +		[BQ27XXX_REG_RC] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_FCC] = 0x12,
> >  		[BQ27XXX_REG_CYCT] = 0x2a,
> >  		[BQ27XXX_REG_AE] = INVALID_REG_ADDR, @@ -425,6 +439,7 @@ static u8
> >  		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_NAC] = 0x08,
> > +		[BQ27XXX_REG_RC] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_FCC] = 0x0e,
> >  		[BQ27XXX_REG_CYCT] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_AE] = INVALID_REG_ADDR, @@ -450,6 +465,7 @@ static u8
> >  		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_NAC] = INVALID_REG_ADDR,
> > +		[BQ27XXX_REG_RC] = 0x10,
> >  		[BQ27XXX_REG_FCC] = 0x12,
> >  		[BQ27XXX_REG_CYCT] = 0x2a,
> >  		[BQ27XXX_REG_AE] = 0x22,
> > @@ -470,6 +486,7 @@ static u8
> >  		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_NAC] = INVALID_REG_ADDR,
> > +		[BQ27XXX_REG_RC] = 0x10,
> >  		[BQ27XXX_REG_FCC] = 0x12,
> >  		[BQ27XXX_REG_CYCT] = 0x2a,
> >  		[BQ27XXX_REG_AE] = 0x22,
> > @@ -490,6 +507,7 @@ static u8
> >  		[BQ27XXX_REG_TTES] = 0x1e,
> >  		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
> >  		[BQ27XXX_REG_NAC] = INVALID_REG_ADDR,
> > +		[BQ27XXX_REG_RC] = 0x04,
> >  		[BQ27XXX_REG_FCC] = 0x06,
> >  		[BQ27XXX_REG_CYCT] = 0x2c,
> >  		[BQ27XXX_REG_AE] = 0x24,
> > @@ -745,6 +763,7 @@ static enum power_supply_property bq27z561_props[] = {
> >  	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
> >  	POWER_SUPPLY_PROP_TECHNOLOGY,
> >  	POWER_SUPPLY_PROP_CHARGE_FULL,
> > +	POWER_SUPPLY_PROP_CHARGE_NOW,
> >  	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> >  	POWER_SUPPLY_PROP_CYCLE_COUNT,
> >  	POWER_SUPPLY_PROP_POWER_AVG,
> > @@ -764,6 +783,7 @@ static enum power_supply_property bq28z610_props[] = {
> >  	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
> >  	POWER_SUPPLY_PROP_TECHNOLOGY,
> >  	POWER_SUPPLY_PROP_CHARGE_FULL,
> > +	POWER_SUPPLY_PROP_CHARGE_NOW,
> >  	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> >  	POWER_SUPPLY_PROP_CYCLE_COUNT,
> >  	POWER_SUPPLY_PROP_POWER_AVG,
> > @@ -784,6 +804,7 @@ static enum power_supply_property bq34z100_props[] = {
> >  	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
> >  	POWER_SUPPLY_PROP_TECHNOLOGY,
> >  	POWER_SUPPLY_PROP_CHARGE_FULL,
> > +	POWER_SUPPLY_PROP_CHARGE_NOW,
> >  	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> >  	POWER_SUPPLY_PROP_CYCLE_COUNT,
> >  	POWER_SUPPLY_PROP_ENERGY_NOW,
> > @@ -1518,6 +1539,15 @@ static inline int bq27xxx_battery_read_nac(struct bq27xxx_device_info *di)
> >  	return bq27xxx_battery_read_charge(di, BQ27XXX_REG_NAC);  }
> >  
> > +/*
> > + * Return the battery Remaining Capacity in µAh
> > + * Or < 0 if something fails.
> > + */
> > +static inline int bq27xxx_battery_read_rc(struct bq27xxx_device_info 
> > +*di) {
> > +	return bq27xxx_battery_read_charge(di, BQ27XXX_REG_RC); }
> > +
> >  /*
> >   * Return the battery Full Charge Capacity in µAh
> >   * Or < 0 if something fails.
> > @@ -1965,7 +1995,10 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
> >  			val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
> >  		break;
> >  	case POWER_SUPPLY_PROP_CHARGE_NOW:
> > -		ret = bq27xxx_simple_value(bq27xxx_battery_read_nac(di), val);
> > +		if (di->regs[BQ27XXX_REG_NAC] != INVALID_REG_ADDR)
> > +			ret = bq27xxx_simple_value(bq27xxx_battery_read_nac(di), val);
> > +		else
> > +			ret = bq27xxx_simple_value(bq27xxx_battery_read_rc(di), val);
> >  		break;
> >  	case POWER_SUPPLY_PROP_CHARGE_FULL:
> >  		ret = bq27xxx_simple_value(di->cache.charge_full, val);
> > --
> > 2.20.1
> > 

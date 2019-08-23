Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC75C9AAF9
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 11:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfHWJEG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 05:04:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41936 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfHWJEF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2019 05:04:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id j16so7912703wrr.8;
        Fri, 23 Aug 2019 02:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ajwUkKcw+iTIl6aLsM85NOMdJeASecdPjAOj2v577vU=;
        b=k9y4iYiYaj049QTESrEgDtUaU0+n4TFaihtpHIN9xDqAIP0thj98iv0w/m6cwndn1q
         BIDXJm+pJbflImJ9LwGRNxmH0V/xW3CnLV99KmoGMCG3691EoD82Dehoc9Yvma2QSHby
         H8S/XPVhYirLw7LAjvVWQ176CnEv/aaMB/IN+UFCuC/iNwwhPvjy5kSRDB5zC/hn3QUf
         5YJjIMeTDMV1K8dgohZn5Ib1zW2T5JTiX4lxidLYHHHqLnsEjMJYlRDf3nahyZuTju+U
         AAAG3obTy+vo9fi0Iv1px2CO3HKYLhfrfrNWr0SUmtaz3H1uJE0fHBR5MVWCzOWkNNb4
         Tbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ajwUkKcw+iTIl6aLsM85NOMdJeASecdPjAOj2v577vU=;
        b=e+/ha3V8HrVIxBfIA42O/SGuwjK0yj8u6+7H/wAkwxKD0jbksCHjbr9Z0noxa6Rc2x
         48dUYk8wiX7Y5FSBmv5PuIy4sVmGdFNWSxmwQ2YdPBwJJG+vf6YBSS70clci4tUxqWoV
         u0dmbLlivGXU0G55A0+Ayr0mTLVZyXyUBT83i+9Bfr8/5C7PLuWYnDWwmYCX5FGQj3DG
         K++7g/aa04zOp2f68RvQHslM+SvrVsO/qHgym86/mhCagZ4dZKnnA8ZZKEMn4QcQx3VO
         rsKH0FHD8pdyXn0Hp6V9+5GMruOqa4F6tb/UMa+POOE8f6CIobN6U9Imx7uZCsQ5X2e0
         QjEw==
X-Gm-Message-State: APjAAAVhmiYFyjhNSpf74TQhVZzEkOwaKuw0RSOBiMpdlfYFRYS5McHq
        NWvt8Dx8nIvuf7ThshU8tdXm9IlE
X-Google-Smtp-Source: APXvYqyqCfTFx4kZwn44WaV1+u3204PiYLlofSPkA2nm3USXUk7H/wIep7R3+UZYvzc18Iuwd/QktA==
X-Received: by 2002:adf:f3c1:: with SMTP id g1mr3810252wrp.203.1566551043866;
        Fri, 23 Aug 2019 02:04:03 -0700 (PDT)
Received: from 5WDYG62 (static-css-cqn-143221.business.bouyguestelecom.com. [176.149.143.221])
        by smtp.gmail.com with ESMTPSA id n9sm2408689wrx.76.2019.08.23.02.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Aug 2019 02:04:03 -0700 (PDT)
Date:   Fri, 23 Aug 2019 11:03:54 +0200
From:   Romain Izard <romain.izard.pro@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: register HWMON devices with valid names
Message-ID: <20190823090216.GA11377@5WDYG62>
References: <20190822150919.18290-1-romain.izard.pro@gmail.com>
 <20190822161207.GB6992@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822161207.GB6992@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 22, 2019 at 09:12:07AM -0700, Guenter Roeck wrote:
> On Thu, Aug 22, 2019 at 05:09:19PM +0200, Romain Izard wrote:
> > With the introduction of the HWMON compatibility layer to the power
> > supply framework in Linux 5.3, all power supply devices' names can be
> > used directly to create HWMON devices with the same names.
> > 
> > But HWMON has rules on allowable names that are different from the power
> > supply framework. The dash character is forbidden, as it is used by the
> > libsensors library in userspace as a separator, whereas this character
> > is used in the device names in more than half of the existing power
> > supply drivers. This last case is consistent with the typical naming
> > usage with MFD and Device Tree.
> > 
> > This leads to warnings in the kernel log, with the format:
> > 
> > power_supply gpio-charger: hwmon: \
> > 	'gpio-charger' is not a valid name attribute, please fix
> > 
> > Add a protection to power_supply_add_hwmon_sysfs() that replaces any
> > dash in the device name with an underscore when registering with the
> > HWMON framework. Other forbidden characters (star, slash, space, tab,
> > newline) are not replaced, as they are not in common use.
> > 
> > Fixes: e67d4dfc9ff1 ("power: supply: Add HWMON compatibility layer")
> > Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> > ---
> >  drivers/power/supply/power_supply_hwmon.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
> > index 51fe60440d12..ebe964bd512c 100644
> > --- a/drivers/power/supply/power_supply_hwmon.c
> > +++ b/drivers/power/supply/power_supply_hwmon.c
> > @@ -284,6 +284,7 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
> >  	struct device *dev = &psy->dev;
> >  	struct device *hwmon;
> >  	int ret, i;
> > +	const char *name;
> >  
> >  	if (!devres_open_group(dev, power_supply_add_hwmon_sysfs,
> >  			       GFP_KERNEL))
> > @@ -334,7 +335,19 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
> >  		}
> >  	}
> >  
> > -	hwmon = devm_hwmon_device_register_with_info(dev, psy->desc->name,
> > +	name = psy->desc->name;
> > +	if (strchr(name, '-')) {
> > +		char *new_name;
> > +
> > +		new_name = devm_kstrdup(dev, name, GFP_KERNEL);
> > +		if (!new_name) {
> > +			ret = -ENOMEM;
> > +			goto error;
> > +		}
> > +		strreplace(new_name, '-', '_');
> > +		name = (const char *) new_name;
> 
> Is that typecast necessary ?

Indeed, it is not. I'll remove it if a V2 is necessary.
> 
> Other than that,
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> > +	}
> > +	hwmon = devm_hwmon_device_register_with_info(dev, name,
> >  						psyhw,
> >  						&power_supply_hwmon_chip_info,
> >  						NULL);

Thanks for your review.

Best regards,
-- 
Romain Izard

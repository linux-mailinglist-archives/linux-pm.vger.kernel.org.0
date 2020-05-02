Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6706F1C289E
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 00:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgEBWpa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 May 2020 18:45:30 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:62888 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728565AbgEBWpa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 2 May 2020 18:45:30 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49F42b5VNMz39;
        Sun,  3 May 2020 00:45:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588459527; bh=CHJShVi3XY0BbhLa65FPayKa3UNmPaRfnp/54qLpPKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VHhx0GNXIyuT2BCU7dFUuVUEEB3FIrCDKDVfIE12gZxd+eu2SPLn8YOhyU2S5IPpy
         FgLuLCetken040elkf6SAPn7JBarf6ZxBlUjeg35LSmRJZnULDb/XDbnLUe2sjz9NR
         sarrrJLq6a6oEiT3LK+QrACrMG2lW97lZ2PUAeKWrsm+IEA9RDd80wfIHyEz40Nh/6
         pyIgleQHvsyB1w8O9i/6R6j5j31e8+P1mOTV24ne40f6h++IYxEahM7ZosJmCbTlY2
         vFTmVx3y3VQl3mb6tMohW9RNuAOH/Add54UwS7wvLRCk2kRCWEIsp3q3cgoJKwh+Y6
         jpFl2c6bWdOGg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 3 May 2020 00:45:26 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/4] power: supply: core: add input voltage/current
 measurements
Message-ID: <20200502224526.GA25127@qmqm.qmqm.pl>
References: <cover.1588345420.git.mirq-linux@rere.qmqm.pl>
 <249d7ad42b02bfeb8c31c49a64ee92b3e745086d.1588345420.git.mirq-linux@rere.qmqm.pl>
 <20200502222349.tfa72nr5zunybpla@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200502222349.tfa72nr5zunybpla@earth.universe>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, May 03, 2020 at 12:23:49AM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, May 01, 2020 at 05:11:18PM +0200, Micha³ Miros³aw wrote:
> > Introduce input voltage and current limits and measurements.
> > This makes room for e.g. VBUS measurements in USB chargers.
> We already have properties for charger input voltage/current.
> Unfortunately the naming is not as straight forward, as it
> could be. Basically the properties have been added over time
> and are ABI now. Things are documented in
> 
> Documentation/ABI/testing/sysfs-class-power
> 
> I provided the relevant properties below.

Hmm. Looks like there is no battery current/voltage properties then?
This is different from IBUS (input current), as IBUS = charging
current + system load. Documentation/power/power_supply_class.rst is
missing descriptions for the properties you mention.

[...]
> > --- a/include/linux/power_supply.h
> > +++ b/include/linux/power_supply.h
> > @@ -127,7 +127,9 @@ enum power_supply_property {
> >  	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
> >  	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD, /* in percents! */
> >  	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD, /* in percents! */
> > +	POWER_SUPPLY_PROP_INPUT_CURRENT_NOW,
> 
> What:           /sys/class/power_supply/<supply_name>/current_avg    
> Date:           May 2007
> Contact:        linux-pm@vger.kernel.org                          
> Description:                  
>                 Reports an average IBUS current reading over a fixed period.   
>                 Normally devices will provide a fixed interval in which they   
>                 average readings to smooth out the reported value.             
>                                                                                 
>                 Access: Read    
>                 Valid values: Represented in microamps
> 

There are two entries for /sys/class/power_supply/<supply_name>/current_avg
in the file, the other one mentions IBAT instead. "voltage_now" has the
same problem. There seems to be a split-personality disorder present in
the kernel ABI. ;-)

Best Regards,
Micha³ Miros³aw

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1256D1C28CB
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 01:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgEBXMB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 May 2020 19:12:01 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:22506 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbgEBXMB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 2 May 2020 19:12:01 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49F4dC40wyz39;
        Sun,  3 May 2020 01:11:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588461119; bh=PtEoSLlKWMegYf9HRBfoVi/1ytKJy7M8Vrb70UMSaJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KWl5EY3topXH9uyM4aU82OxE23+g+gQlWgXnscOuek0XwzOQrAegeTPNk9aDTS/vU
         5F5n2A16tuCsRceRY83UJV++Pj3Pg6ah6fMmNif2jekz+kJpcG7/8L0ijk4YEC0F9A
         cIbwIb0GN5dQUJIXmLdXsjs7BvS0VoksThwuiMuMZcVDCpbHCjy4Nl/QknpXtV/llb
         laVfLka3Dkf3J7JUdFNAywkALtzI2t3gg01AbN7YuOgNxFJrOdLq30sDioGN+ccg8A
         1l0rQYbZY+PHFvkKmWR9RksSL0PB/QyutfZzZTchITusdc/1wn+Kmjir3xi4KDUJRS
         xRaNY7QytNOrQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 3 May 2020 01:11:58 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/4] power: supply: core: add input voltage/current
 measurements
Message-ID: <20200502231158.GB25127@qmqm.qmqm.pl>
References: <cover.1588345420.git.mirq-linux@rere.qmqm.pl>
 <249d7ad42b02bfeb8c31c49a64ee92b3e745086d.1588345420.git.mirq-linux@rere.qmqm.pl>
 <20200502222349.tfa72nr5zunybpla@earth.universe>
 <20200502224526.GA25127@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200502224526.GA25127@qmqm.qmqm.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, May 03, 2020 at 12:45:26AM +0200, Micha³ Miros³aw wrote:
> On Sun, May 03, 2020 at 12:23:49AM +0200, Sebastian Reichel wrote:
> > On Fri, May 01, 2020 at 05:11:18PM +0200, Micha³ Miros³aw wrote:
[...]
> > > --- a/include/linux/power_supply.h
> > > +++ b/include/linux/power_supply.h
> > > @@ -127,7 +127,9 @@ enum power_supply_property {
> > >  	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
> > >  	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD, /* in percents! */
> > >  	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD, /* in percents! */
> > > +	POWER_SUPPLY_PROP_INPUT_CURRENT_NOW,
> > 
> > What:           /sys/class/power_supply/<supply_name>/current_avg    
> > Date:           May 2007
> > Contact:        linux-pm@vger.kernel.org                          
> > Description:                  
> >                 Reports an average IBUS current reading over a fixed period.   
> >                 Normally devices will provide a fixed interval in which they   
> >                 average readings to smooth out the reported value.             
> >                                                                                 
> >                 Access: Read    
> >                 Valid values: Represented in microamps
> > 
> 
> There are two entries for /sys/class/power_supply/<supply_name>/current_avg
> in the file, the other one mentions IBAT instead. "voltage_now" has the
> same problem.
[...]

So the general idea of the sysfs API seems to require separate devices for the
input (charger) and battery elements. Since what I'm looking at is an
integrated battery controller (bq25896) which has three connections: an USB
power (VBUS), a battery and the system load, but it creates only a single
power-class device. This is complicated by the fact that this is an OTG device
and so it can sink or source VBUS power.

Best Regards,
Micha³ Miros³aw

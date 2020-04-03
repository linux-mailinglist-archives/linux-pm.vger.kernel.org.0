Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF2919DC33
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 18:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390946AbgDCQ4p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 12:56:45 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:36600 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgDCQ4p (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 12:56:45 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48v5gZ3jQRz89;
        Fri,  3 Apr 2020 18:56:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585933002; bh=AKiZe9v9Y0LBmwVIkVjc7YkrXM9XLJKMJUSVn3jCmO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RN9Kg8Bh/VOAImlkFnNMcOXp3WXSAtBBZrJ0Pfd64BT8ZIVORDToaZltZ0nD4H3ee
         UFzA8m03JQT4oEDSQgerdStSiL66V1HAZsbsHhqAuFg7Mdh4adBD63fSjUyt1RX4U1
         6Za+tRZtwsjFQcbMyN54s8ejuWV2JGtcg2juZD3457Q7qLVBdJLy1IukiEkla71den
         v1layTbWEsbBnzgFfssxdmrNY+gxNqXcnaYdYL1h/j49OF+TloBMA1zwPOvVetp+2f
         Sveg5bm44U8mf9rEnL4SG7zNYk79iGei9dsny3ixmofwvHoMnV+SKeRacyvkRKjiWt
         pmee4yYZOUHUA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 3 Apr 2020 18:56:39 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 4/8] power: supply: core: tabularize HWMON temperature
 labels
Message-ID: <20200403165639.GA1966@qmqm.qmqm.pl>
References: <cover.1585929579.git.mirq-linux@rere.qmqm.pl>
 <ae82abf9da86542f5657a8c37106bcdae5011927.1585929579.git.mirq-linux@rere.qmqm.pl>
 <dad5d544-7f6d-5c0d-6c6e-9d23cb0a6055@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dad5d544-7f6d-5c0d-6c6e-9d23cb0a6055@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 03, 2020 at 09:47:40AM -0700, Guenter Roeck wrote:
> On 4/3/20 9:23 AM, Micha³ Miros³aw wrote:
> > Rework power_supply_hwmon_read_string() to check it's parameters.
> > This allows to extend it later with labels for other types of
> > measurements.
> > 
> > Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> > ---
> > v2: split from fix temperature labels
> > ---
> >  drivers/power/supply/power_supply_hwmon.c | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
> > index 67b6ee60085e..48c73994732c 100644
> > --- a/drivers/power/supply/power_supply_hwmon.c
> > +++ b/drivers/power/supply/power_supply_hwmon.c
> > @@ -43,6 +43,11 @@ static int power_supply_hwmon_curr_to_property(u32 attr)
> >  	}
> >  }
> >  
> > +static const char *const ps_temp_label[] = {
> > +	"temp",
> > +	"ambient temp",
> > +};
> > +
> >  static int power_supply_hwmon_temp_to_property(u32 attr, int channel)
> >  {
> >  	if (channel) {
> > @@ -144,8 +149,20 @@ static int power_supply_hwmon_read_string(struct device *dev,
> >  					  u32 attr, int channel,
> >  					  const char **str)
> >  {
> > -	*str = channel ? "temp ambient" : "temp";
> > -	return 0;
> > +	if (channel < 0)
> > +		return -EINVAL;
> > +
> 
> This is unnecessary.
> 
> > +	switch (type) {
> > +	case hwmon_temp:
> > +		if (channel >= ARRAY_SIZE(ps_temp_label))
> > +			return -EINVAL;
> 
> As is this. We don't usually check boundaries like this for
> in-kernel APIs, and I personally would not want to have it
> introduced in the kernel more than necessary. This just increases
> kernel image size with zero benefit.

I'll amend other patches in the same spirit, then. I like the code size
argument.

Best Regards,
Micha³ Miros³aw

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688C01E3A43
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 09:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgE0HWa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 03:22:30 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:33516 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbgE0HWa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 03:22:30 -0400
Received: by mail-ej1-f66.google.com with SMTP id n24so26754958ejd.0;
        Wed, 27 May 2020 00:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lasWSBfb6mgFf78Gxnts+qef209ryDGu3CxnF/TiDDE=;
        b=rCsGapR6bcYHFwQtaEr1dged33NpAT69M5id38LlroKBtzAyYtnPFj7Vr3LK+WnK50
         6FpJ4xPm19d9pDGEd40TXGdZ72ZZ5kpG8m96kTGaNQcpxHYm+LdI7YtAfRnMcsNSFuo8
         JWp3Q9LH35hz1f8BJloxU5qEYGPC0wYXzY69UOn6cSMwHXvkDZeDwOHxD57NDWfwK37c
         vZHY9C8jqkGn8Gg7qs7mKrOvz9HdYVDU3p6GWml2haUFIop/zazPMgiSruG58wpzdzJO
         Gkl+7ndbf9s+79B+tadDdSBd2r8sXsOdgDuwf1TquBaVftagODS5bJtFJHI7wFg5CnPa
         0ZnQ==
X-Gm-Message-State: AOAM5306iaSO4N+HxgklY254rcw2hM2PnJOHj373bZKa52CyJV5dbjAB
        Q0XmFPiBmXid+wQWoj2ivZU=
X-Google-Smtp-Source: ABdhPJxlowvLH0ykXGFUiaA/mqY8Mnm9bubmK11e8sGoqjyknuCVoRNq9vyqJ5zaT9HMOXdW8wLdsg==
X-Received: by 2002:a17:906:7855:: with SMTP id p21mr4707468ejm.257.1590564147700;
        Wed, 27 May 2020 00:22:27 -0700 (PDT)
Received: from pi3 ([194.230.155.118])
        by smtp.googlemail.com with ESMTPSA id l29sm1541401edj.74.2020.05.27.00.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 00:22:26 -0700 (PDT)
Date:   Wed, 27 May 2020 09:22:24 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@proceq.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] power: supply: bq27xxx_battery: Notify about all
 battery changes
Message-ID: <20200527072218.GA4575@pi3>
References: <20200525141200.17199-1-krzk@kernel.org>
 <fc59bcd5-1868-8c7a-9fc9-67ad70b477f4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc59bcd5-1868-8c7a-9fc9-67ad70b477f4@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 26, 2020 at 09:24:39PM -0400, Andrew F. Davis wrote:
> On 5/25/20 10:11 AM, Krzysztof Kozlowski wrote:
> > All battery related data could be important for user-space.  For example
> > time-to-full could be shown to user on the screen or health could be
> > monitored for any issues.  Instead of comparing few selected old/new
> > values, just check if anything changed in the cache.
> > 
> 
> 
> At least some value will change every time we poll the battery, are we
> okay with having power_supply_changed() called every time?

Hi,

Let me give few arguments:
1. "Every time" means still once per poll interval or in case of many
   get_property() calls, once per 5 seconds. In first case, if users
   sets polling every 1 second, I expect he knows what he wants. I2C
   will be busy anyway so uevents should not matter that much.
   In second case, called through get_property(), once per 5 seconds is
   not that frequent.

2. Different drivers do it differently. Many chargers notify about
   everything. Most fuel gauges only on status or capacity change (although
   I am not sure if they measure more) but few FG send uevents about
   everything (max17042_battery, sbs-battery, s3c_adc_battery).

3. If drivers does not send notifications on changed properties of
   battery, then basically the user-space has to poll every time for all
   data which is not being a trigger.  The overhead for system would be
   the same, I guess.

Best regards,
Krzysztof


> Andrew
> 
> 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  drivers/power/supply/bq27xxx_battery.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> > index 942c92127b6d..33c26d42cd02 100644
> > --- a/drivers/power/supply/bq27xxx_battery.c
> > +++ b/drivers/power/supply/bq27xxx_battery.c
> > @@ -1612,12 +1612,10 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
> >  			di->charge_design_full = bq27xxx_battery_read_dcap(di);
> >  	}
> >  
> > -	if ((di->cache.capacity != cache.capacity) ||
> > -	    (di->cache.flags != cache.flags))
> > +	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0) {
> >  		power_supply_changed(di->bat);
> > -
> > -	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)
> >  		di->cache = cache;
> > +	}
> >  
> >  	di->last_update = jiffies;
> >  }
> > 

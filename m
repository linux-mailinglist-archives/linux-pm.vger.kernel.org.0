Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A853A36370
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 20:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfFESjs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 14:39:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41661 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfFESjr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 14:39:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id 83so6053344pgg.8;
        Wed, 05 Jun 2019 11:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EsgY0LCfL8NEtsgC2ZWT1PgdhSR04Uyi+X7VGGPnVB8=;
        b=Io6YhUXF9Bn8KXo1od26iVf5UFoh68R+yM5ryVoQxoGO4ZAbI10gZw0p+wJ9fk1s7S
         dd1VxeT01mcvKz20KGAVj4QIxx5fFkQcXdvKBVU3LpvOyd7cYCNJPsRMGUnLY+AivLtR
         ol+VYLB4S4vgkMjaSamHHAvsHDSUl9nXy3oA0XETHbBq+DQqT2Ti6lCttZDSqDZENxfj
         zpctZ8L0lVnmVKM0n0z3k6smtdCvVQkRPmlgND7+YK4CDqNNo+sMWtWMfJSfvFeKlrVR
         YQ9AOecfhWzWpvoYr3l3VgOWyULSULTF9PNqPxJfZ8Jv0pikA8ZR8agwImf89sWvG+fc
         kVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EsgY0LCfL8NEtsgC2ZWT1PgdhSR04Uyi+X7VGGPnVB8=;
        b=XKGnKZZ27CA9sjSXkg0PsRtN7hLz26oDWgNukkReIjE6xVNOeLCqASJDNxMBbpLxhr
         dsadgZDScImJg0uAYfZnxWyhUXU2k1y4QILd9sYGw2CAGL9TF/GUzLjc0M7qAYeZBTrz
         98HB5SqAeAu87jZCFdon8H+7fNS8yqimkyq/NAzhpWy4tndx4kVi0H6/O6oTgjNo3Qr7
         XuVvyD0M6utgcAfySJBd2NWjwumw2scEmYhMcmJPOqQamt4ed81dajtmnRoTPsUB0mYo
         iofGyQfAIW4eE1PE/eiTm0Yo4zp6jLIs6hdrZg65ApI02vcy0qgA9f5BMSvZDjrRoChd
         n8NA==
X-Gm-Message-State: APjAAAWyhFgtnm2row3JI7VoVR7HEW8wnK39l+GaG/ygyOIDknempOlO
        u3ywX537bRPRsUL5hjc7Fz8=
X-Google-Smtp-Source: APXvYqynQ3f1POhj1reI+hZYror7QuG+fNiSU1o0vhZvAzQN2diIjINnXPXardwL8Y8kyZFf5sniyQ==
X-Received: by 2002:a63:1919:: with SMTP id z25mr157988pgl.440.1559759987279;
        Wed, 05 Jun 2019 11:39:47 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e66sm24784870pfe.50.2019.06.05.11.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 11:39:46 -0700 (PDT)
Date:   Wed, 5 Jun 2019 11:39:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     "Andrew F. Davis" <afd@ti.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] power: supply: ucs1002: Add HWMON interface
Message-ID: <20190605183945.GA2442@roeck-us.net>
References: <20190605072323.21990-1-andrew.smirnov@gmail.com>
 <20190605072323.21990-3-andrew.smirnov@gmail.com>
 <d9d8b0c4-e9f4-5a92-3832-3449153f807d@ti.com>
 <CAHQ1cqFRVmZvcFyV93udAHEwZG8NhtM350BSm7JcchNFiqZDjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQ1cqFRVmZvcFyV93udAHEwZG8NhtM350BSm7JcchNFiqZDjA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 05, 2019 at 10:47:25AM -0700, Andrey Smirnov wrote:
> On Wed, Jun 5, 2019 at 9:26 AM Andrew F. Davis <afd@ti.com> wrote:
> >
> > On 6/5/19 3:23 AM, Andrey Smirnov wrote:
> > > Expose current sensors found on UCS1002 via HWMON.
> > >
> > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > Cc: Chris Healy <cphealy@gmail.com>
> > > Cc: Cory Tusar <cory.tusar@zii.aero>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > Cc: Sebastian Reichel <sre@kernel.org>
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: linux-pm@vger.kernel.org
> > > ---
> > >   drivers/power/supply/ucs1002_power.c | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
> > > index 677f20a4d76f..a4b6b37549cf 100644
> > > --- a/drivers/power/supply/ucs1002_power.c
> > > +++ b/drivers/power/supply/ucs1002_power.c
> > > @@ -571,6 +571,12 @@ static int ucs1002_probe(struct i2c_client *client,
> > >               return ret;
> > >       }
> > >
> > > +     ret = devm_power_supply_add_hwmon_sysfs(info->charger);
> >
> > Could this be added to the core power supply framework on registering so
> > all devices get this, vs each driver having to add this line?
> >
> 
> I'd say it is up to Sebastian to decide if this should be opt-out
> rather than opt-in. I have no objections to either approach.
> 

Same here, and agreed.

Guenter

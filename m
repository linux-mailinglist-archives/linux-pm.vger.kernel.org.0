Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B23F341A2F
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2019 04:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405070AbfFLCCU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 22:02:20 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38034 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404880AbfFLCCU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jun 2019 22:02:20 -0400
Received: by mail-io1-f67.google.com with SMTP id k13so11632601iop.5;
        Tue, 11 Jun 2019 19:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KQq32cKsqkY3NhJq+BP0fPox4yAfuAv9Yt0Vd+TjtfI=;
        b=tub0/eAyDdq+sRrwDwUrU99nQ79e61+rN5hQoUhUhValhU2tmBJCOnvKq3fAolklIc
         emcxzOyraQ+OxeLfwG0bClVZRw87xiBpNoIWAhUglhWghg/R8abLDJ3UnQ3ZdzFTQ/NB
         JwERulhBzXtiBAcs42auD6oLqdlrc4xanWiuudqm22XEglv/OUwPOt5eTe0f/O14gQgE
         8lg3NzHzFOwSdZtyjWHHzwDydciIiq9213CO448ZyjnXZzdveD3EgvLZLD4Eq1CXwRlz
         ljr8oxeGFt0muOa3z5/kAwPs5WYypsMYqcua3zhQZ4d9NErltJ+wGAnTVxDvg4tfzW3L
         bUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KQq32cKsqkY3NhJq+BP0fPox4yAfuAv9Yt0Vd+TjtfI=;
        b=OKmLkagcas3ch1swWc1ruuXLMeL/D/jkXcIPbHNhPSs/AB31oR9uY9GmI4eb4iq2vX
         KJCGDiQ38DrhuAFpZ3HGL2GAMjt1mxaqrBem16aen06JwiXLv9f/3TLV84imw0MaHaAW
         N0frrExPBvJvV6ZAJe8kqHI3bZTof7GyXT6pTCtO274ExffjR9PVjdd9egdDMauXbbV2
         foPFi9vKIRQxBDiCRg4Na1xmhIA2kzihBh3DxvW6577YcSPAtSgNha6wL0EqDD+I0FnX
         ZWKVB/5gX7rU58UkgFntQ/dvKoEFcZ8YsekIn7Ff6YImbLW9/17NmlkbjFDAJtFjKqm3
         jptw==
X-Gm-Message-State: APjAAAWGzxINDYCptf17jy4kSsnmjIy5ORk5iZgv3L4HFoHajzNZbV8p
        G/0mk+4piySZDB4foV4z0ndpu0w1aoB1tIlBbQI=
X-Google-Smtp-Source: APXvYqzw2+qxOTW6nrAL3jdeotVKD4/lA7a5sLEteyM3MYFpjQuA5p/uQ/x2jo7fwG8N2NNvXKzsTAt6ZQckOPHzC7s=
X-Received: by 2002:a6b:f607:: with SMTP id n7mr16284029ioh.263.1560304939465;
 Tue, 11 Jun 2019 19:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190605072323.21990-1-andrew.smirnov@gmail.com>
 <20190605072323.21990-3-andrew.smirnov@gmail.com> <d9d8b0c4-e9f4-5a92-3832-3449153f807d@ti.com>
 <CAHQ1cqFRVmZvcFyV93udAHEwZG8NhtM350BSm7JcchNFiqZDjA@mail.gmail.com>
 <20190605183945.GA2442@roeck-us.net> <20190611194651.rmyo4jhdy7xgrgpu@earth.universe>
In-Reply-To: <20190611194651.rmyo4jhdy7xgrgpu@earth.universe>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 11 Jun 2019 19:02:08 -0700
Message-ID: <CAHQ1cqG3c3CvQymEH6uQNrmbSJAmapDBubc6jPke9y1BXWY76A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] power: supply: ucs1002: Add HWMON interface
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, "Andrew F. Davis" <afd@ti.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 11, 2019 at 12:46 PM Sebastian Reichel <sre@kernel.org> wrote:
>
> Hi,
>
> On Wed, Jun 05, 2019 at 11:39:45AM -0700, Guenter Roeck wrote:
> > On Wed, Jun 05, 2019 at 10:47:25AM -0700, Andrey Smirnov wrote:
> > > On Wed, Jun 5, 2019 at 9:26 AM Andrew F. Davis <afd@ti.com> wrote:
> > > >
> > > > On 6/5/19 3:23 AM, Andrey Smirnov wrote:
> > > > > Expose current sensors found on UCS1002 via HWMON.
> > > > >
> > > > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > > > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > > > Cc: Chris Healy <cphealy@gmail.com>
> > > > > Cc: Cory Tusar <cory.tusar@zii.aero>
> > > > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > > > Cc: Sebastian Reichel <sre@kernel.org>
> > > > > Cc: linux-kernel@vger.kernel.org
> > > > > Cc: linux-pm@vger.kernel.org
> > > > > ---
> > > > >   drivers/power/supply/ucs1002_power.c | 6 ++++++
> > > > >   1 file changed, 6 insertions(+)
> > > > >
> > > > > diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
> > > > > index 677f20a4d76f..a4b6b37549cf 100644
> > > > > --- a/drivers/power/supply/ucs1002_power.c
> > > > > +++ b/drivers/power/supply/ucs1002_power.c
> > > > > @@ -571,6 +571,12 @@ static int ucs1002_probe(struct i2c_client *client,
> > > > >               return ret;
> > > > >       }
> > > > >
> > > > > +     ret = devm_power_supply_add_hwmon_sysfs(info->charger);
> > > >
> > > > Could this be added to the core power supply framework on registering so
> > > > all devices get this, vs each driver having to add this line?
> > > >
> > >
> > > I'd say it is up to Sebastian to decide if this should be opt-out
> > > rather than opt-in. I have no objections to either approach.
> > >
> >
> > Same here, and agreed.
>
> I think this should be registered in power_supply_register() and
> free'd in power_supply_unregister(). It's not device specific at
> all and the functionality can be configured via Kconfig.
>

Sure, will do in v4.

Thanks,
Andrey Smirnov

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCB72357F4
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 09:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfFEHie (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 03:38:34 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33444 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfFEHie (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 03:38:34 -0400
Received: by mail-io1-f68.google.com with SMTP id u13so19508483iop.0;
        Wed, 05 Jun 2019 00:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/VQJXEXeZftJ/nSSLIUzgwAXzoErEFStYQp2K666tO4=;
        b=bVpUSzYf3kH3yxOP02XPck6E5JkgMxGaFKJbZRAJN8JQlp/GGgP23t6MnbG6WmlXlY
         UG6W8Wvy7oXz/9Y88EODigdDizNrmupbrZcmEc7mxXI8bU+X7B1GYOTe8N9R/scIoeFt
         xc/t+9wnWvkyQDabkoEyMBc+X1En2SLzFYxDohhqPrwrBNhNjeZOdz8wfoyPB1LtiIX5
         QvyJxGcY18tdJnmnaAtVhOWtOBctihxhxCARe/8J4dvS376owQb7Iegxi7DV+UPv/NM8
         A+/Gs3uw5QpyAkB+2hpnDdLUSnHU20rLM8NrfOW6rmGAXZugjyNaW2J499gsU9a+59b+
         0J/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/VQJXEXeZftJ/nSSLIUzgwAXzoErEFStYQp2K666tO4=;
        b=O2XvtDmVpYMO700gQ37muKmDbT7W8X2KNl7aX3qJRiV3kvatvJLsGrGh2Ldz9MtBUs
         sYF93G/SSopQKqoMkWLfgb4g6orOF/yuAmx/KzSfZMFtHsECGn3nq85j8OPuX8OXJ3p5
         jFMTiGw/L25ZuACcGMm1pnZdg+DCmZM+CvFwmHeJ8PhCplcyYVWKykDRM4zQyw53/8lM
         nn6pZUoONMNsImUsmXHSJJvyxTu1Ssy7zcypIWSYavFaaR4Qfg9Xa5J4DAmyM3FOSu41
         72XSP4G75o7rQ4BmPf5BZcl07sJSDLJLvwKDJnHw747jrrC38hC6+uSLORIdjaIq7vgJ
         dLjw==
X-Gm-Message-State: APjAAAUM1me1WIRYXNtByzjnj9l1/co54ZlejkrmKciGiR9a51vKPuVn
        cd3OZ1yk0JK7GCmBlmdSObdK1RHejitN1H1ANbU=
X-Google-Smtp-Source: APXvYqzfL0eD5Psq9k2rl87GuB7sKSYcuVKsdB22LjGSiBUii0V7gwCQo3Q4Utaci/w+oM7INEBVVUlMVztCiuxaZiU=
X-Received: by 2002:a6b:b556:: with SMTP id e83mr16894432iof.94.1559720313500;
 Wed, 05 Jun 2019 00:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190416172203.4679-1-daniel.lezcano@linaro.org>
 <20190423154430.GA16014@localhost.localdomain> <bc10d520-4d15-74d6-0dc2-fd63df8d9a21@linaro.org>
 <ff407865-8606-60c2-62d8-60ae96d1984d@linaro.org> <CAHQ1cqG-cb=1hyO8oeV4k-6Pq4q+aqhH8RPx04i2oPTNhAhiVg@mail.gmail.com>
 <20190529030542.GA2654@localhost.localdomain>
In-Reply-To: <20190529030542.GA2654@localhost.localdomain>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Wed, 5 Jun 2019 00:38:21 -0700
Message-ID: <CAHQ1cqGZceVR7HRUKjFT8wieRnd0_bZLNNzKNMcq62P3fWcvAw@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/of: Add a get_temp_id callback function
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 28, 2019 at 8:05 PM Eduardo Valentin <edubezval@gmail.com> wrote:
>
> On Thu, May 23, 2019 at 07:48:56PM -0700, Andrey Smirnov wrote:
> > On Mon, Apr 29, 2019 at 9:51 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> > >
> > > On 24/04/2019 01:08, Daniel Lezcano wrote:
> > > > On 23/04/2019 17:44, Eduardo Valentin wrote:
> > > >> Hello,
> > > >>
> > > >> On Tue, Apr 16, 2019 at 07:22:03PM +0200, Daniel Lezcano wrote:
> > > >>> Currently when we register a sensor, we specify the sensor id and a data
> > > >>> pointer to be passed when the get_temp function is called. However the
> > > >>> sensor_id is not passed to the get_temp callback forcing the driver to
> > > >>> do extra allocation and adding back pointer to find out from the sensor
> > > >>> information the driver data and then back to the sensor id.
> > > >>>
> > > >>> Add a new callback get_temp_id() which will be called if set. It will
> > > >>> call the get_temp_id() with the sensor id.
> > > >>>
> > > >>> That will be more consistent with the registering function.
> > > >>
> > > >> I still do not understand why we need to have a get_id callback.
> > > >> The use cases I have seen so far, which I have been intentionally rejecting, are
> > > >> mainly solvable by creating other compatible entries. And really, if you
> > > >> have, say a bandgap, chip that supports multiple sensors, but on
> > > >> SoC version A it has 5 sensors, and on SoC version B it has only 4,
> > > >> or on SoC version C, it has 5 but they are either logially located
> > > >> in different places (gpu vs iva regions), these are all cases in which
> > > >> you want a different compatible!
> > > >>
> > > >> Do you mind sharing why you need a get sensor id callback?
> > > >
> > > > It is not a get sensor id callback, it is a get_temp callback which pass
> > > > the sensor id.
> > > >
> > > > See in the different drivers, it is a common pattern there is a
> > > > structure for the driver, then a structure for the sensor. When the
> > > > get_temp is called, the callback needs info from the sensor structure
> > > > and from the driver structure, so a back pointer to the driver structure
> > > > is added in the sensor structure.
> > >
>
> Do you mind sending a patch showing how one could convert an existing
> driver to use this new API?
>

There's already a patch doing that for qoriq driver:
https://lore.kernel.org/lkml/20190404080647.8173-2-daniel.lezcano@linaro.org/

Here's what can be done with Armada sensor driver:
https://gist.github.com/ndreys/d733228756a17e1dcb31ec8f9a0e9115
(please note that I don't have Armada HW, so I haven't tested those
changes, just made them as an example)

> > > Hi Eduardo,
> > >
> > > does the explanation clarifies the purpose of this change?
> > >
> >
> > Eduardo, did you ever have a chance to revisit this thread? I would
> > really like to make some progress on this one to unblock my i.MX8MQ
> > hwmon series.
>
> The problem I have with this patch is that it is an API which resides
> only in of-thermal. Growing APIs on DT only diverges of-thermal from
> thermal core and platform drivers.
>

I don't have a horse in this race and would be fine if this API isn't
accepted, so this is up for you to decide. My main goal is to get my
i.MX8MQ hwmon patches moving and accepted.

> Besides, this patch needs to document the API in Documention/

I'd like to get more of a commitment on this before I'd start
investing time into improving this patch any further. If this patch is
a go, then I'd be happy to add that documentation.

Thanks,
Andrey Smirnov

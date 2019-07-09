Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A47D6320C
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2019 09:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfGIH1x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jul 2019 03:27:53 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:32891 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfGIH1x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jul 2019 03:27:53 -0400
Received: by mail-io1-f66.google.com with SMTP id z3so26078819iog.0;
        Tue, 09 Jul 2019 00:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7/bxfJbKg+kMsUtUJhrLaoqxMmi1kx1J4E3T3lScoo0=;
        b=GOakA4Zoww6s4joBky8YC/xK0UEazAQk7KPL3KUJHoncRjeImmYNYvubz8ATIdzq5I
         NeTohecnwX5lJ1K5hOuADTnz184NCDeD6VIMzwoBGv6g/mXwIucINPxF75m3wpqRExJk
         burx/YVxHJZOK3KJDTZ7sNumyf9oZpv5Qrlkv3vDIoq41sP9LKvKtMEpmtCsCK/MdhUk
         EzFnDhRXfy4OAQsQYxzvigY7RjNGgZDl9+KFlt9CiWLd/+BucKQdD8pbq44DfuZor2KC
         QM4NcKPFMLXONQkiweyokGUuR+vtbJty1OFY8CgxFXPYes/jlUvfm3y35dXGyqhTX08n
         3PPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/bxfJbKg+kMsUtUJhrLaoqxMmi1kx1J4E3T3lScoo0=;
        b=qOOdXLuXsbWyRwv7FUpRgujp1sxgAUsyPVx+s+UrAVl67ILAvhl86cX3DwBpRn9NAT
         kRqE/6GnI47CdqAHnHm/JQ9itw1Qu5/FofssZRGjW54oN93gqQNVGr+GbqZN4rekGnZd
         /Uz4yIitvV0nbhCO3rqYOdTM5R36RUJT3bt0hz87u4abkFiE3D70f1jep7yWXf0OFTYm
         0bexQDT2pNWwm3dzMj62OqeehTJ1kcEv/5hJA1xsTmwFLM01DV9cD2v3ctE/Rm5H8gmI
         ftAHBu0KShpBPkvcT3dZHK2rOetvAOd0C7hYFlddJ85mqlEDwqo7WncB/DH8OPvb+Isd
         cHTA==
X-Gm-Message-State: APjAAAU529URz6wlJQhsaD1OAvb1oau6qAy2IeyFWR6Y+pgx8AZRTVni
        C+YT1mFz9TA3q1Yt6kj8OTZpEf2z/OjtgHvsaLI=
X-Google-Smtp-Source: APXvYqymf605RlFVgls389To06orbitjyxSr6FY3GWzmKwkMbskOqhw9Qo1dfillgnlJvmOkHD/nwtDbTGtHqyxnK6s=
X-Received: by 2002:a6b:b556:: with SMTP id e83mr22963512iof.94.1562657271913;
 Tue, 09 Jul 2019 00:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190612084404.21685-1-andrew.smirnov@gmail.com>
 <20190612084404.21685-2-andrew.smirnov@gmail.com> <20190627182725.v3mgmy35fxoogofe@earth.universe>
In-Reply-To: <20190627182725.v3mgmy35fxoogofe@earth.universe>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 9 Jul 2019 00:27:40 -0700
Message-ID: <CAHQ1cqEWpczFb4B2UOfx0qSJd2Nh9HkTfAvkiLVeRT1hpxBPmw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] power: supply: Add HWMON compatibility layer
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
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

On Thu, Jun 27, 2019 at 11:27 AM Sebastian Reichel <sre@kernel.org> wrote:
>
> Hi,
>
> On Wed, Jun 12, 2019 at 01:44:04AM -0700, Andrey Smirnov wrote:
> > Add code implementing HWMON adapter/compatibility layer to allow
> > expositing various sensors present on power supply devices via HWMON
> > subsystem. This is done in order to allow userspace to use single
> > ABI/library(libsensors) to access/manipulate all of the sensors of the
> > system.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > Tested-by: Chris Healy <cphealy@gmail.com>
> > ---
>
> Thanks, queued.
>

Hmm, I just realized that power supply exposing POWER_SUPPLY_PROP_TEMP
will have a thermal zone created for it by default, which will expose
said reading via thermal/HWMON integration layer. Do we want to do
anything about this duplication of functionality? Maybe hide it here
if desc->no_thermal is true? Or just drop reporting temperature from
this patch?

Thanks,
Andrey Smirnov

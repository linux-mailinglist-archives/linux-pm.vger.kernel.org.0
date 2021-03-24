Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358503472E7
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 08:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhCXHn7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 03:43:59 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:36442 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhCXHnk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 03:43:40 -0400
Received: by mail-lj1-f182.google.com with SMTP id z25so28952913lja.3;
        Wed, 24 Mar 2021 00:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=VxtNnj3/UL7oLhV4/T5M1JANhE4KKsYGM2Lhl6l/dI4=;
        b=nxUydPLzWaY7RqIMqAeJNIX1mY9bqj2eBfv9dY8ZlVSTTcOh/He3rtNwFsPFziU10W
         u7cbpfQ3G0eiusW8fEXTui2isgqJzxLsIL6qK+Hx5vVOhtL495LGs29FpAI0HovI2rxE
         Tv0G+w+us9WHewQ4neIruq+9HxsOxhzRpcpbF6XoS/MtHlJxe1cS83HgISW2NwNdrGY5
         tkHdJuU9NyqOrlAdduWZuyb8bgM9ipWFApQpNomJ0dJqQDV1B0POOo2FAE67dk3mCFfS
         uzbwxVe4RED6zEVpls4AGMQxcdwvVKsRsyf/B9D5zb2RxC3hPh5QniL3qOmpWKdE3K94
         24RA==
X-Gm-Message-State: AOAM531tk4Ekxy9SVYArH10KpTjXX1Pp8ekaFdFtUMEYywoL2kYjGhw7
        obxAha1CQr4A2uevRuVWAp0=
X-Google-Smtp-Source: ABdhPJyun+swdu2/euwllY2kOmlsVWC3aDUQOA4jS8ERZ9zDXsgfOKlfh5B7zC0rSxbi1oam+GCisQ==
X-Received: by 2002:a2e:bc1e:: with SMTP id b30mr1357288ljf.18.1616571819157;
        Wed, 24 Mar 2021 00:43:39 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id t11sm196032ljk.65.2021.03.24.00.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 00:43:38 -0700 (PDT)
Message-ID: <d26f1e700b98ed9069e6508aefa8137675343b99.camel@fi.rohmeurope.com>
Subject: Re: [PATCH v3 6/8] power: supply: Clean-up few drivers by using
 managed work init
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     wens@csie.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sre@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
In-Reply-To: <CAGb2v67Jd6qFS-zmD+Hm4BJHA+-kx0nAxvDovUwW=WwZTEGYeg@mail.gmail.com>
References: <cover.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
         <e5b1b0380cdd1aa066c9ac6d7a8b1a86ba1ddbbe.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
         <CAGb2v67Jd6qFS-zmD+Hm4BJHA+-kx0nAxvDovUwW=WwZTEGYeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Wed, 24 Mar 2021 09:43:33 +0200
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Chen-Yu, Hans, Greg,

On Tue, 2021-03-23 at 22:36 +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Tue, Mar 23, 2021 at 9:58 PM Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com> wrote:
> > Few drivers implement remove call-back only for ensuring a delayed
> > work gets cancelled prior driver removal. Clean-up these by
> > switching
> > to use devm_delayed_work_autocancel() instead.
> > 
> > This change is compile-tested only. All testing is appreciated.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> > Changelog from RFCv2:
> >  - RFC dropped. No functional changes.
> > 
> >  drivers/power/supply/axp20x_usb_power.c      | 15 +++++----------
> >  drivers/power/supply/bq24735-charger.c       | 18 ++++++--------
> > ----
> >  drivers/power/supply/ltc2941-battery-gauge.c | 20 +++++++---------
> > ----
> >  drivers/power/supply/sbs-battery.c           | 16 +++++-----------
> >  4 files changed, 23 insertions(+), 46 deletions(-)
> > 
> > diff --git a/drivers/power/supply/axp20x_usb_power.c
> > b/drivers/power/supply/axp20x_usb_power.c
> > index 8933ae26c3d6..4259709e3491 100644
> > --- a/drivers/power/supply/axp20x_usb_power.c
> > +++ b/drivers/power/supply/axp20x_usb_power.c
> > @@ -8,6 +8,7 @@
> > 
> >  #include <linux/bitops.h>
> >  #include <linux/device.h>
> > +#include <linux/devm-helpers.h>
> >  #include <linux/init.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/kernel.h>
> > @@ -646,21 +647,16 @@ static int axp20x_usb_power_probe(struct
> > platform_device *pdev)
> >                 }
> >         }
> > 
> > +       ret = devm_delayed_work_autocancel(&pdev->dev, &power-
> > >vbus_detect,
> > +                                          axp20x_usb_power_poll_vb
> > us);
> > +       if (ret)
> > +               return ret;
> 
> This doesn't look right. The IRQ is requested before this, and the
> delayed_work
> struct is initialized even earlier, so you'd be re-initializing the
> struct,
> with the work item potentially running or queued up already.

Sigh. The company mail had redirected this to spam... :/
I will check this and send appropriate follow-up fix(es) to Greg. Big
thanks for the heads-up!

--Matti



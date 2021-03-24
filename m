Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F643347306
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 08:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbhCXHws (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 03:52:48 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:46925 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbhCXHwh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 03:52:37 -0400
Received: by mail-lf1-f43.google.com with SMTP id w37so30525542lfu.13;
        Wed, 24 Mar 2021 00:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=W5FgzHcFQYsfbsYv8RtYcChjckSHsGvp9iSM4MMtVzw=;
        b=GybPQk6nVWoZ/9aPKyq5lwdTlyvgfPn4NUIBFwlvXdifZM6xJ270SBpNWVkcM8yMko
         VnF2A94hdGgVYFUF+/toAwDJP1sPS0cqccaxnViapu+J+J5EgUsZaOMU1r5kGMZtxUEf
         1y7qzIM7EwI8mcZxqeIKC7Kd5dr56aXLBD2APHhCiBLxZRpVVje4wxSgStKtBNbm6Nr9
         f7wdDf+xBh1gCjuCJc/AVJInFJ5JXcWoDRQ6RdNNitnWSMOyS3mpQlmQ5bundzbfAa1W
         W9ptabFv2RE4qBexbq3krYOwJvjlFxEEcJBRiA1a8RYdC1uoaQ6o9RuQYVKrUi8ZuOKo
         XolA==
X-Gm-Message-State: AOAM532Ar5P+P6pJwiV5uSHSOOVQUjHiZkOavCF5WH5jvQdAwdSArTy5
        ePWCqDrWv1ovqoSLIvSMVCE=
X-Google-Smtp-Source: ABdhPJw6SooYDd8b1Vdawq1iwYwladaPohKMb615LICYXbLkVeQN1KKnLpcnCWBueLHs7giUPkE5gw==
X-Received: by 2002:a05:6512:4c6:: with SMTP id w6mr1228595lfq.258.1616572345706;
        Wed, 24 Mar 2021 00:52:25 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id l12sm207318ljg.39.2021.03.24.00.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 00:52:24 -0700 (PDT)
Message-ID: <4e85a49272e734fc0dc1b7a9da66d6977516a47a.camel@fi.rohmeurope.com>
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
Date:   Wed, 24 Mar 2021 09:52:14 +0200
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


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

I checked this and you are 100% correct.

b5e8642ed95ff6ecc20cc6038fe831affa9d098c
"power: supply: axp20x_usb_power: Init work before enabling IRQs" had
fixed the order between RFCv1 and the patch v3. This is what one gets
when not being careful with rebase. Thanks again for the heads-up! I'll
send follow-up fix still today.

Br,
	Matti Vaittinen


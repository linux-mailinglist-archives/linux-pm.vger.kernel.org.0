Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26871B559B
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 09:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgDWH0d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 03:26:33 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46165 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgDWH0c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Apr 2020 03:26:32 -0400
Received: by mail-oi1-f195.google.com with SMTP id q204so4398492oia.13;
        Thu, 23 Apr 2020 00:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3rdiRVi7JnvVom2uX8veudncwLjhAaPdpJsWOmscBdk=;
        b=GLKSGOEEkvRZtSw+hEJPLk1PQ98/WTgyfavsQqQsDZmcbt/6m+7ekPG/IIZu9ev/jB
         hCBp7nowQloL0HPV8HjT4guO+MSgZDzRo5aqTK/J9BXHMRO1ld4a0uuINaeGA/9Dypvn
         YJmMfLwXihqaQQGCspv25Zvd+JP2BOa4ppjreh+LTKHTjBBFy4LX1uZ2uuUshdnF3KaR
         YICXCGTaFGQ5YAHd/o5ZnRj9N6VGlRGANN6BmyxZ9zm5zqzMrFY2pU3/2AqK/NvAP0G3
         X4oAU8+ZaX44X/f4Ed7KHyFqUnlgTJBP7C6N9EyWKM4A7SQpOhnMI1wJ0fSaufSPPxza
         Rn3g==
X-Gm-Message-State: AGi0PuYhD7FplTUlZpRr1TIGsDdTp80PySDCm/XtDKCamKd/C3lXcXV5
        kqUDHSfnOI1RzcDOdgFJAB1pEfWI8/2355vYYrU=
X-Google-Smtp-Source: APiQypLWrjUEmsbk+dJ2lLiYqiwII7JfBgL/d+dnRg0+05MO8+fwjlhEBeXLztxjhtMmfjDBLWRqRw1leIanpQdJZRQ=
X-Received: by 2002:aca:f541:: with SMTP id t62mr1962017oih.148.1587626791926;
 Thu, 23 Apr 2020 00:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200225050828.56458-1-john.stultz@linaro.org>
 <20200421235836.GA8319@lxhi-065.adit-jv.com> <CALAqxLXX455P0V0o11scc3-1MHvecnvcUoT=XBcwB+ma7Kyjqg@mail.gmail.com>
 <20200422075413.GB4898@sirena.org.uk> <CALAqxLW13oA376bqj7uTR4E4zmnX5ASK=rpqw3HMr4yOWQGaOw@mail.gmail.com>
In-Reply-To: <CALAqxLW13oA376bqj7uTR4E4zmnX5ASK=rpqw3HMr4yOWQGaOw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Apr 2020 09:26:20 +0200
Message-ID: <CAMuHMdVoubQWoDcmLTMw9ADxboTxHDtb+90fpKM=GX14_a6TxQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] driver core: Improve and cleanup driver_deferred_probe_check_state()
To:     John Stultz <john.stultz@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi John,

On Wed, Apr 22, 2020 at 10:46 PM John Stultz <john.stultz@linaro.org> wrote:
> On Wed, Apr 22, 2020 at 12:54 AM Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Apr 21, 2020 at 06:16:31PM -0700, John Stultz wrote:
> > > The second reverts the default timeout back to 0:
> > >   https://lore.kernel.org/lkml/20200413204253.84991-1-john.stultz@linaro.org/
> >
> > If you're reverting the timeout we should revert the regulator change
> > too I think.
>
> Maybe? The main issue for me was my change was clearly breaking users
> with dts with missing dependencies where their setup was working
> before. I sort of feel like having a dtb with missing dependencies is
> less valid than wanting to load module dependencies from userland, but
> they were working first, so we have to keep them happy :) And at least
> now the latter can add the timeout boot argument to make it work.

IOMMU support is optional.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

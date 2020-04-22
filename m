Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C227E1B37C1
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 08:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgDVGqW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 02:46:22 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:55525 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgDVGqW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2020 02:46:22 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 9FB843C057F;
        Wed, 22 Apr 2020 08:46:19 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Wppy4fHkz_wK; Wed, 22 Apr 2020 08:46:14 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id A903B3C004C;
        Wed, 22 Apr 2020 08:46:14 +0200 (CEST)
Received: from lxhi-065.adit-jv.com (10.72.94.23) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 22 Apr
 2020 08:46:14 +0200
Date:   Wed, 22 Apr 2020 08:46:09 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v5 0/6] driver core: Improve and cleanup
 driver_deferred_probe_check_state()
Message-ID: <20200422064609.GA17637@lxhi-065.adit-jv.com>
References: <20200225050828.56458-1-john.stultz@linaro.org>
 <20200421235836.GA8319@lxhi-065.adit-jv.com>
 <CALAqxLXX455P0V0o11scc3-1MHvecnvcUoT=XBcwB+ma7Kyjqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALAqxLXX455P0V0o11scc3-1MHvecnvcUoT=XBcwB+ma7Kyjqg@mail.gmail.com>
X-Originating-IP: [10.72.94.23]
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi John,

On Tue, Apr 21, 2020 at 06:16:31PM -0700, John Stultz wrote:
> On Tue, Apr 21, 2020 at 4:59 PM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> >
> > Building a recent [0] kernel using vanilla arm64 defconfig
> > and booting it on H3ULCB, I get buried into backtraces [1].
> >
> > After reverting this series, up to and including its first commit,
> > booting goes back to normal [2].
> >
> > Any chance to get a fix or at least some hints where to dig into?
> 
> Yea. There's two patch sets I have for this. The first quiets down the
> warnings(we don't need stack dumps for these):
>   https://lore.kernel.org/lkml/20200330202715.86609-1-john.stultz@linaro.org/
> 
> The second reverts the default timeout back to 0:
>   https://lore.kernel.org/lkml/20200413204253.84991-1-john.stultz@linaro.org/
> 
> 
> Let me know if those work for you, or if you're still having trouble
> afterwards.  I need to resubmit the set as I'm guessing they've been
> overlooked.

The patches fix the issue on my end. Thanks!
One note is that they carry a slight mutual conflict, but that's up to
the maintainer to complain about.

Many thanks again!
Hope the patches will be picked up soon!

-- 
Best regards,
Eugeniu Rosca

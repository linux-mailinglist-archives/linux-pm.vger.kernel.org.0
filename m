Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F84E1B33AE
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 01:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgDUX7a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Apr 2020 19:59:30 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:54075 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgDUX7a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Apr 2020 19:59:30 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 71D5B3C0579;
        Wed, 22 Apr 2020 01:59:26 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ii3F635pHRba; Wed, 22 Apr 2020 01:59:20 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 912D03C004C;
        Wed, 22 Apr 2020 01:59:20 +0200 (CEST)
Received: from lxhi-065.adit-jv.com (10.72.94.4) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 22 Apr
 2020 01:59:20 +0200
Date:   Wed, 22 Apr 2020 01:59:14 +0200
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
        <linux-pm@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v5 0/6] driver core: Improve and cleanup
 driver_deferred_probe_check_state()
Message-ID: <20200421235836.GA8319@lxhi-065.adit-jv.com>
References: <20200225050828.56458-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200225050828.56458-1-john.stultz@linaro.org>
X-Originating-IP: [10.72.94.4]
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi John,
Cc: linux-renesas-soc

On Tue, Feb 25, 2020 at 05:08:22AM +0000, John Stultz wrote:
> This series goal is to improve and cleanup the
> driver_deferred_probe_check_state() code in the driver core.
> 
> This series is useful for being able to support modules
> dependencies which may be loaded by userland, far after
> late_initcall is done. For instance, this series allows us to
> successfully use various clk drivers as modules on the db845c
> board. And without it, those drivers have to be statically built
> in to work.
> 
> Since I first sent out this patch, Saravana suggested an
> alternative approach which also works for our needs, and is a
> bit simpler:
>  https://lore.kernel.org/lkml/20200220055250.196456-1-saravanak@google.com/T/#u
> 
> However, while that patch provides the functionality we need,
> I still suspect the driver_deferred_probe_check_state() code
> could benefit from the cleanup in this patch, as the existing
> logic is somewhat muddy.
> 
> New in v5:
> * Reworked the driver_deferred_probe_check_state() logic as
>   suggested by Saravana to tie the initcall_done checking with
>   modules being enabled.
> * Cleanup some comment wording as suggested by Rafael
> * Try to slightly simplify the regulator logic as suggested by
>   Bjorn
> 
> Thanks so much to Bjorn, Saravana and Rafael for their reviews
> and suggestions! Additional review and feedback is always greatly
> appreciated!

Building a recent [0] kernel using vanilla arm64 defconfig
and booting it on H3ULCB, I get buried into backtraces [1].

After reverting this series, up to and including its first commit,
booting goes back to normal [2].

Any chance to get a fix or at least some hints where to dig into?

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=18bf34080c4c3b
    ("Merge branch 'akpm' (patches from Andrew)")
[1] https://gist.github.com/erosca/ac779c348dd272c448e162c406c48f4a
[2] https://gist.github.com/erosca/5eea2bc5e82be651d405ba038d0ad036

-- 
Best regards,
Eugeniu Rosca

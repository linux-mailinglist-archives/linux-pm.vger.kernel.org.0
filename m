Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB07481FD5
	for <lists+linux-pm@lfdr.de>; Thu, 30 Dec 2021 20:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbhL3TWa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 30 Dec 2021 14:22:30 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:40925 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240217AbhL3TWa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Dec 2021 14:22:30 -0500
Received: by mail-qt1-f173.google.com with SMTP id l17so22501710qtk.7
        for <linux-pm@vger.kernel.org>; Thu, 30 Dec 2021 11:22:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JAyyRCwSZpuclAWd1dyn0iDLkdFP2BoQtJcRNxPV3x4=;
        b=iO5H/1i//2ogC0mVi3Cyev/NxHaoDtLeEjXsayq2ElvbzKdS4AWUMr6iVD4WNJbZoU
         lUHQ6ndoLicrdSv+hbekB6ck3lEd/DOmZ44WzPq3QsHvWJsWyEg/1808UCEmREFSD/4I
         rLwNBCJFjXmg7euXT4HW62hVhgdF02rsY4bQKANqyz5/wJM0D/c4QMI8F6MdvpPPzdjh
         1Px8Jl+yKoBzdEfVM6fmXPJlQzeZH19AqiPE7l39EOCAhBQdEOJEQ1TK+OFrout72F9F
         HmL7RSeYsDd3ezYIaRcT+QcGY5asGbO29NW4RSLM+CxejII9j7WaVFd1r8OtQl4MJ1AE
         TxJw==
X-Gm-Message-State: AOAM531OTxZyoA0GP9Znw0W32uMnG8C9M2JLsz2vWjXZwvl6Xhye3GA1
        +DwcC/zrovJG3rMvOhRly+0ffIO2swf5Z41OTS9m8Mns
X-Google-Smtp-Source: ABdhPJzVW/Fm5aQjF+ENCwXLgoavcitq48jrPtLWLtJnHwKlZvNfHKtlJZ0e60VB6krkVeaRRsLD+GCvsnZAbGOdj0k=
X-Received: by 2002:ac8:7c4e:: with SMTP id o14mr27783631qtv.80.1640892149506;
 Thu, 30 Dec 2021 11:22:29 -0800 (PST)
MIME-Version: 1.0
References: <20211220215828.189814-1-u.kleine-koenig@pengutronix.de>
 <CAJZ5v0hWYJikZnt9NZHv+3GeMCLU-BtQciKcuazEDST_541nEw@mail.gmail.com> <20211230190413.3zxp36oj72sbunwa@pengutronix.de>
In-Reply-To: <20211230190413.3zxp36oj72sbunwa@pengutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Dec 2021 20:22:18 +0100
Message-ID: <CAJZ5v0itRA+7Cv6q-gHZ5T+ZHyiv5p63by6FfKJXRedKy7ZF1g@mail.gmail.com>
Subject: Re: [PATCH] thermal: Kconfig: simplify dependency of THERMAL_HWMON
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>, alvin@alvinhc.com,
        Sascha Hauer <kernel@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 30, 2021 at 8:04 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Thu, Dec 30, 2021 at 04:37:20PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Dec 20, 2021 at 10:58 PM Uwe Kleine-König
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > THERMAL is bool (since commit 554b3529fe01 ("thermal/drivers/core:
> > > Remove the module Kconfig's option") in v5.2-rc1) and so cannot be
> > > configured as a module. As THERMAL_HWMON also depends on THERMAL (via a
> > > big if block in drivers/thermal/Kconfig) the condition
> > >
> > >         depends on HWMON=y || HWMON=THERMAL
> > >
> > > is equivalent to the simpler
> > >
> > >         depends on HWMON=y
> > >
> > > . Use the latter.
> > >
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> >
> > The change looks reasonable to me, but 0-day is evidently unhappy with
> > it.  Can you have a look at its replies to this message, please?
>
> 0-day isn't happy because I only wrote HWMON=y in the commit log, but
> not in the Kconfig. The bot should be improved to better understand
> the intention of a patch :-)
>
> > > ---
> > > Hello,
> > >
> > > I want to use this patch as an opportunity to question if THERMAL being
> > > a bool and not a tristate is still considered the right thing to do.
> >
> > IIRC there are correctness concerns regarding modular THERMAL.
>
> In the commit log of 554b3529fe018 this sounds more like modular being a
> burden to maintain because most systems use =y anyhow.
>
> > > This dependency attracted attention in the context of the armel Debian
> > > kernel which has HWMON=m for binary size reason. When THERMAL was
> > > changed to bool this resulted in THERMAL_HWMON not being available any
> > > more.
>
> So on these systems THERMAL_HWMON is forced to be off, which I guess is
> still less correct than THERMAL=m?!

If the problem ISTR is real, it is, because unloading thermal could
cause a use-after-free to occur in some cases.

That said, it might be better to address this particular problem
instead of making the whole thing non-modular.

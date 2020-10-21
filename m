Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72234295214
	for <lists+linux-pm@lfdr.de>; Wed, 21 Oct 2020 20:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503977AbgJUSTw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Oct 2020 14:19:52 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44880 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503839AbgJUSTw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2020 14:19:52 -0400
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id 9b286d2661666ff1; Wed, 21 Oct 2020 20:19:50 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <nks@flawful.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kevin Hilman <khilman@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/4] power: avs: Move drivers to the soc directories and drop avs
Date:   Wed, 21 Oct 2020 20:19:49 +0200
Message-ID: <4480050.lNUbsT5gvy@kreacher>
In-Reply-To: <CAPDyKFq4sym1V7EjEE4RArrtpBtXi2w1iCVLhNYgPEo4guCqiA@mail.gmail.com>
References: <20201006160516.319830-1-ulf.hansson@linaro.org> <CAJZ5v0i6CeUy4aQnyMmNyAHfdunWbbB2TsQwtX4QwNwYk+71jg@mail.gmail.com> <CAPDyKFq4sym1V7EjEE4RArrtpBtXi2w1iCVLhNYgPEo4guCqiA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, October 21, 2020 12:41:50 PM CEST Ulf Hansson wrote:
> On Fri, 16 Oct 2020 at 18:30, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Oct 7, 2020 at 5:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > + Arnd
> > >
> > > On Wed, 7 Oct 2020 at 17:09, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Tue, Oct 6, 2020 at 6:05 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > >
> > > > > The avs drivers in drivers/power/avs/* are all SoC specific drivers that
> > > > > doesn't share any code. Instead they are located in a directory, mostly to keep
> > > > > similar functionality together. From a maintenance point of view, it makes
> > > > > better sense to collect SoC specific drivers like these, into the SoC specific
> > > > > directories.
> > > > >
> > > > > Therefore, this series moves the drivers, one by one - and in the end, it
> > > > > deletes the empty avs directory.
> > > > >
> > > > > It seems best to me, if this can be funneled via Rafael's linux-pm tree. Then
> > > > > when going forward, each driver should be managed through the SoC maintainer's
> > > > > trees.
> > > >
> > > > That's fine by me.
> > > >
> > > > I'd like to get an ACK from the arm-soc side on this, though.
> > >
> > > I have looped in Arnd, to get his opinion on this.
> > >
> > > Although, I think the people on cc already send pull requests to the
> > > arm-soc maintainers (or perhaps it was these people you were referring
> > > to), so just awaiting their acks should be fine, I guess.
> >
> > OK
> >
> > For now, I've taken patches [2-3/4] that have been ACKed.
> >
> > When the [1/4] is ACKed, I'll take it too and apply the last one.
> 
> Patch 1/4 has been acked now as well, so I think the remaining part of
> this series is ready to go.

Agreed, I'm going to apply the remaining two patches from it tomorrow.

> However, I noticed that Stephen Rothwell reported some merge conflicts
> for arm-soc in linux-next. Quite trivial to resolve, though. Perhaps
> an option to consider is to send this as material for v5.10-rc1 (or
> maybe rc2) to avoid further conflicts during this release cycle? Just
> an idea..

Yes, I'm going to do that.

Thanks!




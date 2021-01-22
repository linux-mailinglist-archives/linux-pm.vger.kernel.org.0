Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66E8300971
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 18:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbhAVQAe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 11:00:34 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53774 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbhAVQAM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 11:00:12 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4847010D75C;
        Fri, 22 Jan 2021 10:59:27 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=2KFN33CCd/S9jQWHs/5VOncQkO4=; b=V2/5L0
        /9InRyW4Y5M/aiwaclrKjfjrT1eXbz8JGP/84yvrMYu/tkuu86XUVUpy298gPBbh
        M1hDcaWBbhYbkHwv0ZJqdpC0ExDLUymo35DAW7WXKG6Ek0qZjP3rxt7VDo/BUViF
        BgvqrJNbLtIV6rE7SmMzQKRANOqu1ATergVLE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3F87A10D75B;
        Fri, 22 Jan 2021 10:59:27 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=+GIvus0Wafw36PPn3D2pMPxldiPN6SMayidfB2ofWSo=; b=rHiaalri3X689/N+zq29ESzP/bGFQJV4fRYLb46mLFDxLe0CPONHgx1cD5zaGDuzTrFE4vtEvf/ssdQ1Lu7PqwMWiPky7cghUZt81cN5mTS3ghBAxTo6pQC6xXVbufpmHVlv3r/agUeitl+bUtf3y+1/sOC1V81bxAMOhnoVO+I=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0733510D75A;
        Fri, 22 Jan 2021 10:59:24 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 524D42DA0140;
        Fri, 22 Jan 2021 10:59:22 -0500 (EST)
Date:   Fri, 22 Jan 2021 10:59:22 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] PM / clk: make PM clock layer compatible with clocks
 that must sleep
In-Reply-To: <CAJZ5v0gsYb1uxDUTHUe539w8uXhk=m337Xn6wtPhF1oPKzaYrQ@mail.gmail.com>
Message-ID: <30np982n-r2q8-8532-q6os-9p9729ppos45@syhkavp.arg>
References: <17nqrn25-rp5s-4652-o5o1-72p2oprqpq90@onlyvoer.pbz> <CA+G9fYsyXsNSXGy6BWZ6mgpAP=+7r6Xy9jQ2xxb9mXyHdRoBCg@mail.gmail.com> <CAMuHMdULW4bnb0Jc0+ZaF9P2VNgnYsvEks7y8WYCk045BHqh7A@mail.gmail.com> <CA+G9fYvh0iSyEDQs7+0CX82FLPDCg5UmAt+1JuPsndmfmYF3kw@mail.gmail.com>
 <CAJZ5v0hFjpGp2GbV1Evi+BbUF7Am4ETY4Cm8VzTrvTJ=7=oyPQ@mail.gmail.com> <84r6s34s-opq7-9358-o45n-27s17084012@onlyvoer.pbz> <CAJZ5v0jUxonxp0q80Kdcbax+WMmh-NZ_h=KQG-HcfFdE1hr4VA@mail.gmail.com> <CAJZ5v0hj4VC_kjB5e_b_ho=ET_quG5zUh0Dbbdwofp-6azopsw@mail.gmail.com>
 <CA+G9fYsRVxWPW1nvSXMTLWfEadrdBDSH5hRPtoUYpfpqq8zRSw@mail.gmail.com> <CAJZ5v0gsYb1uxDUTHUe539w8uXhk=m337Xn6wtPhF1oPKzaYrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: CBFD9690-5CCA-11EB-946B-E43E2BB96649-78420484!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 22 Jan 2021, Rafael J. Wysocki wrote:

> On Fri, Jan 22, 2021 at 4:48 PM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > On Fri, 22 Jan 2021 at 20:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Jan 21, 2021 at 8:01 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Thu, Jan 21, 2021 at 6:23 PM Nicolas Pitre <npitre@baylibre.com> wrote:
> > > > >
> > > > > The clock API splits its interface into sleepable ant atomic contexts:
> > > > >
> > > > > - clk_prepare/clk_unprepare for stuff that might sleep
> > > > >
> > > > > - clk_enable_clk_disable for anything that may be done in atomic context
> > > > >
> > > > > The code handling runtime PM for clocks only calls clk_disable() on
> > > > > suspend requests, and clk_enable on resume requests. This means that
> > > > > runtime PM with clock providers that only have the prepare/unprepare
> > > > > methods implemented is basically useless.
> > > > >
> > > > > Many clock implementations can't accommodate atomic contexts. This is
> > > > > often the case when communication with the clock happens through another
> > > > > subsystem like I2C or SCMI.
> > > > >
> > > > > Let's make the clock PM code useful with such clocks by safely invoking
> > > > > clk_prepare/clk_unprepare upon resume/suspend requests. Of course, when
> > > > > such clocks are registered with the PM layer then pm_runtime_irq_safe()
> > > > > can't be used, and neither pm_runtime_suspend() nor pm_runtime_resume()
> > > > > may be invoked in atomic context.
> > > > >
> > > > > For clocks that do implement the enable and disable methods then
> > > > > everything just works as before.
> > > > >
> > > > > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > > > >
> > > > > ---
> > > > >
> > > > > On Thu, 21 Jan 2021, Rafael J. Wysocki wrote:
> > > > >
> > > > > > So I'm going to drop this patch from linux-next until the issue is
> > > > > > resolved, thanks!
> > > > >
> > > > > Here's the fixed version.
> > > >
> > > > Applied instead of the v1, thanks!
> > > >
> > > > > Changes from v1:
> > > > >
> > > > > - Moved clk_is_enabled_when_prepared() declaration under
> > > > >   CONFIG_HAVE_CLK_PREPARE and provided a dummy definition when that
> > > > >   config option is unset.
> > > > >
> > > > > diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> > > > > index ced6863a16..a62fb0f9b1 100644
> > > > > --- a/drivers/base/power/clock_ops.c
> > > > > +++ b/drivers/base/power/clock_ops.c
> > > > > @@ -23,6 +23,7 @@
> > > > >  enum pce_status {
> > > > >         PCE_STATUS_NONE = 0,
> > > > >         PCE_STATUS_ACQUIRED,
> > > > > +       PCE_STATUS_PREPARED,
> > > > >         PCE_STATUS_ENABLED,
> > > > >         PCE_STATUS_ERROR,
> > > > >  };
> > > > > @@ -32,8 +33,102 @@ struct pm_clock_entry {
> > > > >         char *con_id;
> > > > >         struct clk *clk;
> > > > >         enum pce_status status;
> > > > > +       bool enabled_when_prepared;
> > > > >  };
> > > > >
> > > > > +/**
> > > > > + * pm_clk_list_lock - ensure exclusive access for modifying the PM clock
> > > > > + *                   entry list.
> > > > > + * @psd: pm_subsys_data instance corresponding to the PM clock entry list
> > > > > + *      and clk_op_might_sleep count to be modified.
> > > > > + *
> > > > > + * Get exclusive access before modifying the PM clock entry list and the
> > > > > + * clock_op_might_sleep count to guard against concurrent modifications.
> > > > > + * This also protects against a concurrent clock_op_might_sleep and PM clock
> > > > > + * entry list usage in pm_clk_suspend()/pm_clk_resume() that may or may not
> > > > > + * happen in atomic context, hence both the mutex and the spinlock must be
> > > > > + * taken here.
> > > > > + */
> > > > > +static void pm_clk_list_lock(struct pm_subsys_data *psd)
> > > > > +{
> > > > > +       mutex_lock(&psd->clock_mutex);
> > > > > +       spin_lock_irq(&psd->lock);
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * pm_clk_list_unlock - counterpart to pm_clk_list_lock().
> > > > > + * @psd: the same pm_subsys_data instance previously passed to
> > > > > + *      pm_clk_list_lock().
> > > > > + */
> > > > > +static void pm_clk_list_unlock(struct pm_subsys_data *psd)
> > >
> > > Locking annotations for sparse were missing here and above, so I've
> > > added them by hand.
> > >
> > > Please double check the result in my linux-next branch (just pushed).
> >
> > May i request to add Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> 
> If this had been a patch fixing a problem reported by you, there would
> have been a reason to add a Reported-by,
> 
> In this case, it is just a new version of a patch taking your testing
> feedback into account.
> 
> I can add a Tested-by for you to it if desired, though.

It is probably fair to mention that Naresh reported the issue too.
My bad, I should have added the tag myself in v2.


Nicolas

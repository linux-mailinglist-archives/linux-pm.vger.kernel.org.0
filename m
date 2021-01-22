Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17733007DD
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 16:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbhAVPx6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 10:53:58 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56517 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbhAVPxK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 10:53:10 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A38F010D513;
        Fri, 22 Jan 2021 10:52:23 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=MfFlB8YVNmsXMB87ZaCNvKMewDs=; b=mK6dLI
        X6Q0l3QtcOkMNRVQ9uG+ofrigzP3If1SBjzKFz00SZ1AHGIYLz/FHv1ZFeJRJd1e
        m5GClbAw0sUkFqgyxnpxdikv8igacgUP8DNCQ/sAi1EBSKpc207P55Kq+dKLdXWx
        APS2gDbkz92WEopkH7G3mI6hvfKW198B1Eokg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9ABE810D511;
        Fri, 22 Jan 2021 10:52:23 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=9+ePAXFz3kh960y4E+FfoxuOJpYSg1dyLt9kq3gKshY=; b=KTGN9aV7tM9NaBqBbuP1oITDG3WCnFcg5KVe+Lqs/kaxR/WklGrwm2gjM5BQfaVhLF+V0p9tzeieOnriZXX1mrS4gpnyUbkMHpciqE8Zj7kE6w9m6km5psD0XTQLvXvGJ/81BkBw4j9og3Sskn6iNioXLsLZyTbyQabGtNlieGM=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9753410D50F;
        Fri, 22 Jan 2021 10:52:20 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id D1E3E2DA0140;
        Fri, 22 Jan 2021 10:52:18 -0500 (EST)
Date:   Fri, 22 Jan 2021 10:52:18 -0500 (EST)
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
In-Reply-To: <CAJZ5v0hj4VC_kjB5e_b_ho=ET_quG5zUh0Dbbdwofp-6azopsw@mail.gmail.com>
Message-ID: <66o22n46-n7p6-3p8r-3ssp-rs8oo28n87nq@syhkavp.arg>
References: <17nqrn25-rp5s-4652-o5o1-72p2oprqpq90@onlyvoer.pbz> <CA+G9fYsyXsNSXGy6BWZ6mgpAP=+7r6Xy9jQ2xxb9mXyHdRoBCg@mail.gmail.com> <CAMuHMdULW4bnb0Jc0+ZaF9P2VNgnYsvEks7y8WYCk045BHqh7A@mail.gmail.com> <CA+G9fYvh0iSyEDQs7+0CX82FLPDCg5UmAt+1JuPsndmfmYF3kw@mail.gmail.com>
 <CAJZ5v0hFjpGp2GbV1Evi+BbUF7Am4ETY4Cm8VzTrvTJ=7=oyPQ@mail.gmail.com> <84r6s34s-opq7-9358-o45n-27s17084012@onlyvoer.pbz> <CAJZ5v0jUxonxp0q80Kdcbax+WMmh-NZ_h=KQG-HcfFdE1hr4VA@mail.gmail.com>
 <CAJZ5v0hj4VC_kjB5e_b_ho=ET_quG5zUh0Dbbdwofp-6azopsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: CF9E62EE-5CC9-11EB-AF42-E43E2BB96649-78420484!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 22 Jan 2021, Rafael J. Wysocki wrote:

> > > +/**
> > > + * pm_clk_list_unlock - counterpart to pm_clk_list_lock().
> > > + * @psd: the same pm_subsys_data instance previously passed to
> > > + *      pm_clk_list_lock().
> > > + */
> > > +static void pm_clk_list_unlock(struct pm_subsys_data *psd)
> 
> Locking annotations for sparse were missing here and above, so I've
> added them by hand.

Thanks.

> Please double check the result in my linux-next branch (just pushed).

There are still the following warnings:

drivers/base/power/clock_ops.c:52:13: warning: context imbalance in 'pm_clk_list_lock' - wrong count at exit
drivers/base/power/clock_ops.c:64:13: warning: context imbalance in 'pm_clk_list_unlock' - wrong count at exit

I guess this can be silenced (still need to investigate how those 
annotations work).

But I'm more worried about these:

drivers/base/power/clock_ops.c:86:12: warning: context imbalance in 'pm_clk_op_lock' - different lock contexts for basic block
drivers/base/power/clock_ops.c:131:39: warning: context imbalance in 'pm_clk_op_unlock' - unexpected unlock

Those are special locking helpers indeed and I don't know if that can be 
dealt with.


Nicolas

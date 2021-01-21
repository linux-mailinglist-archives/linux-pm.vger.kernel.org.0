Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A8F2FF00E
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 17:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732981AbhAUQTw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 11:19:52 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64563 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732100AbhAUQTi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 11:19:38 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E28A1106769;
        Thu, 21 Jan 2021 11:18:52 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=xwglBKNBDOQa41zIQ1eVypVyscM=; b=dYOM9G
        FYHGC97iyU6/IxQRN5Of9psoeePTQJOmHWgvn1zdAo8NtJrkw1PaCbHG10n+f5i2
        lHwUwFW8wtHRc8AlalvHmVMnFfMryEeV8QgDuv4FMzKvLjtYzaduxcktcCVKcKYa
        bbQHN5MI8upRWw1VVF9CIkKkoVWZoaeATF3dA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D99A9106765;
        Thu, 21 Jan 2021 11:18:51 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=5fBPzAB/LUGoYmsC4s4Q3GVI9ZCjSpshAfLaiXN9zLg=; b=Iha+EsdhQeI8Ki7aaPar41/MZhotmmhAYcR34Vm/RS2dry4qKAqsQtlQhZKV0Ek7B2gTcuZkSsF+zj14sE/pefEZ0KxehuMt3FLCJ+xZMfjB1nQW910K9iXBqhM00ZTuEIx5hB+vdwsqvTzbBU3BHWl7QTUQbDEr+8tRol/Tvmk=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BC6CB10675B;
        Thu, 21 Jan 2021 11:18:48 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 14E2D2DA015D;
        Thu, 21 Jan 2021 11:18:47 -0500 (EST)
Date:   Thu, 21 Jan 2021 11:18:46 -0500 (EST)
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
Subject: Re: [PATCH] PM / clk: make PM clock layer compatible with clocks
 that must sleep
In-Reply-To: <CAJZ5v0hFjpGp2GbV1Evi+BbUF7Am4ETY4Cm8VzTrvTJ=7=oyPQ@mail.gmail.com>
Message-ID: <43p026p5-468-n892-4nss-6ro5s047qp9@syhkavp.arg>
References: <17nqrn25-rp5s-4652-o5o1-72p2oprqpq90@onlyvoer.pbz> <CA+G9fYsyXsNSXGy6BWZ6mgpAP=+7r6Xy9jQ2xxb9mXyHdRoBCg@mail.gmail.com> <CAMuHMdULW4bnb0Jc0+ZaF9P2VNgnYsvEks7y8WYCk045BHqh7A@mail.gmail.com> <CA+G9fYvh0iSyEDQs7+0CX82FLPDCg5UmAt+1JuPsndmfmYF3kw@mail.gmail.com>
 <CAJZ5v0hFjpGp2GbV1Evi+BbUF7Am4ETY4Cm8VzTrvTJ=7=oyPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 57D11538-5C04-11EB-9E8A-D609E328BF65-78420484!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 21 Jan 2021, Rafael J. Wysocki wrote:

> On Thu, Jan 21, 2021 at 1:11 PM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > ref:
> > https://builds.tuxbuild.com/1nN0vkpNP4qhvIuIJN12j7tTpQs/
> 
> So I'm going to drop this patch from linux-next until the issue is
> resolved, thanks!

No problem - I'm on it.

Thanks Naresh for reporting the issue.


Nicolas

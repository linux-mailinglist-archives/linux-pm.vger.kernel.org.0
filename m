Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEF2790C8B
	for <lists+linux-pm@lfdr.de>; Sat, 17 Aug 2019 05:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfHQDsN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 23:48:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfHQDsN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Aug 2019 23:48:13 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5435B21721;
        Sat, 17 Aug 2019 03:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566013692;
        bh=HxsSwNwiVHXbty9BjtNr6DuJclpMy2U5qUXHSszZxrM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=e8Au8v1YjIZnWREKfQOag1wlJ5dlrZgSMRbp90GK5UTPY+nUl2WJc1otkEjseKTHD
         3520uhhDA1MOfMC6z+SshHGl8yLV5hAyKMxhpPm5HKjtVazIzaF8qeRTw9/o/K0lqr
         o/oE9EuoQwMQ1Ku1q59wIcPUKdI9WFywtxJJo4W0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMuHMdVvwsXU2YwFRA2Y2K9KKzF4L-hqDudarmc-OeHXRMCifQ@mail.gmail.com>
References: <20190816125225.16061-1-geert+renesas@glider.be> <20190816125225.16061-2-geert+renesas@glider.be> <20190816180123.6299720665@mail.kernel.org> <CAMuHMdVvwsXU2YwFRA2Y2K9KKzF4L-hqDudarmc-OeHXRMCifQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] clk: renesas: mstp: Set GENPD_FLAG_ALWAYS_ON for clock domain
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 20:48:11 -0700
Message-Id: <20190817034812.5435B21721@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Geert Uytterhoeven (2019-08-16 12:59:32)
> Hi Stephen,
>=20
> On Fri, Aug 16, 2019 at 8:01 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > Quoting Geert Uytterhoeven (2019-08-16 05:52:23)
> > > The CPG/MSTP Clock Domain driver does not implement the
> > > generic_pm_domain.power_{on,off}() callbacks, as the domain itself
> > > cannot be powered down.  Hence the domain should be marked as always-=
on
> > > by setting the GENPD_FLAG_ALWAYS_ON flag.
> > >
> > > This gets rid of the following boot warning on RZ/A1:
> > >
> > >     sh_mtu2 fcff0000.timer: PM domain cpg_clocks will not be powered =
off
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> >
> > Are you going to add a Fixes tag?
>=20
> I didn't add a Fixes tag, as there's no clear point in history where the
> problem appeared: the Clock Domain code in this driver predates the
> introduction of the GENPD_FLAG_ALWAYS_ON flag by ca. 18 months.
>=20
> Candidates are:
> d716f4798ff8c65a ("PM / Domains: Support IRQ safe PM domains")
> ffaa42e8a40b7f10 ("PM / Domains: Enable users of genpd to specify
> always on PM domains")
> 075c37d59ecd4a8b ("PM / Domains: Don't warn about IRQ safe device for
> an always on PM domain")
>=20
> Do you think it's worth adding one or more of the above?
> Thanks!
>=20

Well is it actually a problem to not specify the flag? I guess it's just
a potential problem if the genpd is ever powered off, but given that the
governor decides to leave it always enabled it doesn't actually matter?
So it's not really fixing anything besides silencing a harmless warning?


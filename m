Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715011E524F
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 02:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgE1AiR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 20:38:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgE1AiR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 May 2020 20:38:17 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62F82206DF;
        Thu, 28 May 2020 00:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590626296;
        bh=cmSou5VE1UNh7bIXRNVGEpuB0HEm75DbJwXB1O6nCt8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=I4zKjqrD5Xi60T8w5xlbBJOO1r9GlOycS6B77QnDNwNpYrmFm/Mm49/7WcydqN9MD
         7zmIaEBqkLR64PKfIOcN/Fr4AFWAP5R6aB+10rKCIUr707orYGhMrsD9zmryXAniVQ
         DcWGtigeJR5AmjNXretYcdxXURCwZqBJEC3mI4fM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3fcac59c-7a37-d4af-9d12-710d7af05845@gmail.com>
References: <20200330231617.17079-1-digetx@gmail.com> <20200330231617.17079-3-digetx@gmail.com> <159055894944.88029.2029223648098859689@swboyd.mtv.corp.google.com> <3fcac59c-7a37-d4af-9d12-710d7af05845@gmail.com>
Subject: Re: [PATCH v1 2/5] clk: Introduce clk_round_rate_unboundly()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>
Date:   Wed, 27 May 2020 17:38:15 -0700
Message-ID: <159062629560.69627.6748976171636917991@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Dmitry Osipenko (2020-05-27 10:57:01)
> 27.05.2020 08:55, Stephen Boyd \u043f\u0438\u0448\u0435\u0442:
> > Quoting Dmitry Osipenko (2020-03-30 16:16:14)
> >> In same cases it may be desired to round clock's rate without taking i=
nto
> >> account current min/max requests made by the clock's users. One exampl=
e is
> >> building up OPP table based on a possible clock rates.
> >=20
> > Shouldn't the OPP table come from firmware/DT? I don't quite understand
> > why we're generating OPP tables on top of the rate rounding API.
> > clk_round_rate() is supposed to tell us what rate we'll get if we call
> > clk_set_rate() with the same arguments. An unboundly version of that
> > doesn't make sense.=20
>=20
> The OPP should come from the DT, but unfortunately DT and Tegra's
> devfreq driver wasn't designed like that from the start, so it will take
> some extra effort to re-do it properly now. I wanted to postpone that
> effort a tad and get at least the basics upstreamed for the starter.
>=20
> > I wonder if perhaps the clk provider should be populating OPP tables in
> > this case? Or basically anything besides adding another clk consumer API
> > to solve this problem. Who is the caller? Something later in this
> > series?
>=20
> I'll try to add a proper OPP table with freqs and voltages, will see how
> it goes. We will need to do it sooner or later anyways. So perhaps it's
> fine to drop the current approach with the clk_round_rate_unboundly()
> and re-focus on a proper OPP implementation.
>=20
> Thank you for getting back and replying to this topic :)

Alright, it sounds better to me if we can avoid a one off addition to
the clk API in favor of implementing a proper OPP table from the start.

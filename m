Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F5E26530F
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 23:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgIJV2Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 17:28:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgIJV2E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Sep 2020 17:28:04 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 391E121D92;
        Thu, 10 Sep 2020 21:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599773283;
        bh=rxvS6AwOCqkTF8dpA59A+IKXNYafSMKsYQi6sF6t5cY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=D8bMlInaMbzmreh8AWVaj6VOCmrieNuNvtw24IhlqGgE3O5WPH1Aay4HThqIRkplf
         CwO54HfYwM892eVqkcQlyBaWP0JggqtjersZ8bFOzIjOYct8/7WQw/FMmdLzp33a4d
         wOGyFEl57OAHhuuI1kjZr+/5nQdqrBK9XJpiXNRM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200910162610.GA7008@gerhold.net>
References: <20200910162610.GA7008@gerhold.net>
Subject: Re: Qcom clock performance votes on mainline
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org
To:     Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 10 Sep 2020 14:28:01 -0700
Message-ID: <159977328190.2295844.1029544710226353839@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Stephan Gerhold (2020-09-10 09:26:10)
> Hi Stephen, Hi Rajendra,
>=20
> while working on some MSM8916 things I've been staring at the downstream
> clock-gcc-8916.c [1] driver a bit. One thing that confuses me are the
> voltage/performance state votes that are made for certain clocks within
> the driver. Specifically lines like
>=20
>     VDD_DIG_FMAX_MAP2(LOW, 32000000, NOMINAL, 64000000),
>=20
> on certain clocks like UART, I2C or SPI. There does not seem to be
> anything equivalent in the mainline clock driver at the moment.
>=20
> As far as I understand from related discussions on mailing lists [2],
> these performance votes are not supposed to be added to the clock
> driver(s), but rather as required-opps within OPP tables of all the
> consumers. Is that correct?

Yes.

>=20
> As a second question, I'm wondering about one particular case:
> I've been trying to get CPR / all the CPU frequencies working on MSM8916.
> For that, I already added performance state votes for VDDMX and CPR as
> required-opps to the CPU OPP table.
>=20
> After a recent discussion [3] with Viresh about where to enable power
> domains managed by the OPP core, I've been looking at all the
> performance state votes made in the downstream kernel again.
>=20
> Actually, the A53 PLL used for the higher CPU frequencies also has such
> voltage/performance state votes. The downstream driver declares the
> clock like [4]:
>=20
>                 .vdd_class =3D &vdd_sr2_pll,
>                 .fmax =3D (unsigned long [VDD_SR2_PLL_NUM]) {
>                         [VDD_SR2_PLL_SVS] =3D 1000000000,
>                         [VDD_SR2_PLL_NOM] =3D 1900000000,
>                 },
>                 .num_fmax =3D VDD_SR2_PLL_NUM,
>=20
> which ends up as votes for the VDDCX power domain.
>=20
> Now I'm wondering: Where should I make these votes on mainline?
> Should I add it as yet another required-opps to the CPU OPP table?

Sounds like the right approach.

>=20
> It would be a bit of a special case because these votes are only done
> for the A53 PLL (which is only used for the higher CPU frequencies, not
> the lower ones)...

Can that be put into the OPP table somehow for only the high
frequencies? The OPP tables for CPUs sometimes cover the CPU PLL voltage
requirements too so it doesn't seem like a totally bad idea.

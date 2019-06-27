Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3771A58CE0
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 23:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfF0VOy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 17:14:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfF0VOy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Jun 2019 17:14:54 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37FF4208CB;
        Thu, 27 Jun 2019 21:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561670093;
        bh=aF18PB9ndCbQ/0tO043NbIEQd0ErKNrDAli6X2roWq0=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=CNMciDmGkyUYWNkDg4WtU6vSG5PpIaJeyI1Upn0mozqwrcBTJRUhBZhl8YEV0+/Zv
         WN4ik+trQwPg6qycA+od0fYc9/pkYm3PLK6t//UKhFyPMmNX0+GkThhgWqnArchKwB
         PXUS29YhxcVR4eRS9/ga35BFDW8O+jwqMn5mUEJo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <475e0250b1e77a660c095749e78427fde318d5f6.1559200405.git.leonard.crestez@nxp.com>
References: <475e0250b1e77a660c095749e78427fde318d5f6.1559200405.git.leonard.crestez@nxp.com>
To:     Alexandre Bailon <abailon@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC] clk: imx8mm: Add dram freq switch support
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Cedric Neveux <cedric.neveux@nxp.com>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        Nitin Garg <nitin.garg@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
User-Agent: alot/0.8.1
Date:   Thu, 27 Jun 2019 14:14:52 -0700
Message-Id: <20190627211453.37FF4208CB@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Leonard Crestez (2019-05-30 00:13:51)
> Add a wrapper clock encapsulating dram frequency switch support for
> imx8m chips. This allows higher-level DVFS code to manipulate dram
> frequency using standard clock framework APIs.
>=20
> Linux-side implementation is similar in principle to imx_clk_cpu or a
> composite clock. Only some preparation is done inside the kernel, the
> actual freq switch is performed from TF-A code which runs from an SRAM
> area. Cores other than the one performing the switch are also made to
> spin inside TF-A by sending each an IRQ.
>=20
> This is an early proof-of-concept which only support low/high mode on
> imx8mm but NXP has secure-world dram freq switching implementations for
> multiple other chips and this approach can be extended.
>=20
> This was tested using a large pile of NXP out-of-tree patches. Code for
> the "busfreq core" from last release can be seen here:
> https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/soc/imx=
/busfreq-imx8mq.c?h=3Dimx_4.14.98_2.0.0_ga
>=20
> It can be likely made to work with interconnect RFC:
> https://patchwork.kernel.org/cover/10851705/
>=20
> This RFC effectively refactors a common part between them.
>=20
> Among the possible cleanups:
>  * Handle errors in low/high busfreq code and back off
>  * Move irq to secure world
>  * Try to use fewer clk parameters
>  * More chips and frequencies
>=20
> Many platforms handle this kind of stuff externally but cpufreq is quite
> insistent that actual rates are set by clk code and that new platforms
> use cpufreq-dt.
>=20
> Let me know if there are objections to handling dram freq via clk.

Can it be an interconnect driver instead? I don't see how this is a clk
driver. It looks more like a driver that itself manages a collection of
clks, and you've put the coordination of those clks behind the clk_ops
interface. We don't want to have clk_ops calling clk consumer APIs in
general, so the whole approach doesn't seem correct. Hopefully this can
work out as some other sort of driver that is used directly from devfreq
or interconnect core instead and then have a different consumer driver
of devfreq or interconnect core that knows how to drive the clk tree.


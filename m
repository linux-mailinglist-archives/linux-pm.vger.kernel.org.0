Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B07F810A4AE
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 20:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfKZToZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 14:44:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfKZToZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Nov 2019 14:44:25 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E94B20874;
        Tue, 26 Nov 2019 19:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574797464;
        bh=um1j8Y/GaUsZ1q4T+Tiu5+4Kgs2yzoDg2ThT8cprhsY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s2DzKRlGMlFyXboS3+ux6a+0J9Jj4ZZ2Ta/XPxcn/LL1zm9tGpoJ2knRLRxeO9UKm
         7aSAdRg7u09+FNjsPT5WPuvb++5joBKHq8TQWRJVlfwsW0unmURJhcf+tUm4vCnOhA
         45eqetRrjwiY4T6IizY/TnfK/dpZyfJ+ZiETfYLc=
Received: by mail-qk1-f176.google.com with SMTP id c124so12823712qkg.0;
        Tue, 26 Nov 2019 11:44:24 -0800 (PST)
X-Gm-Message-State: APjAAAXGW1IjEtN2Z7mcpfuM0sbVat53CSxW58Gj6IejL6ARLRc4vglm
        nq3t9KV0yZ4GPdiXNZl/E2EqbwIjNnsvqwIp/A==
X-Google-Smtp-Source: APXvYqwtMCX2ktU7XP1vLiDif7HsVDYIGE5gPdIX/yIa4O+B0IDcNylxr73NToCcb42qbcuGNjawEioJubJ0X61Ew5M=
X-Received: by 2002:a05:620a:1eb:: with SMTP id x11mr115675qkn.254.1574797463436;
 Tue, 26 Nov 2019 11:44:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574458460.git.leonard.crestez@nxp.com> <CGME20191122214539epcas1p34d4ca24634642e8a79c33d7a7c9291ba@epcas1p3.samsung.com>
 <c0b332b85560e39d7dbb5e88b99bbed1d1b32373.1574458460.git.leonard.crestez@nxp.com>
 <f8838bc8-44db-551f-3199-eeea91e493f7@samsung.com>
In-Reply-To: <f8838bc8-44db-551f-3199-eeea91e493f7@samsung.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 26 Nov 2019 12:44:12 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJmZUVmM9BqQuD1npJ7Nqsh07CSEA5nB9-pt0v_X6HQCA@mail.gmail.com>
Message-ID: <CAL_JsqJmZUVmM9BqQuD1npJ7Nqsh07CSEA5nB9-pt0v_X6HQCA@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] PM / devfreq: Add dynamic scaling for imx8m ddr controller
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Silvano di Ninno <silvano.dininno@nxp.com>,
        devicetree@vger.kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Nov 24, 2019 at 4:53 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Hi Leonard,
>
> On 11/23/19 6:45 AM, Leonard Crestez wrote:
> > Add driver for dynamic scaling the DDR Controller on imx8m chips. Actual
> > frequency switching is implemented inside TF-A, this driver wraps the
> > SMC calls and synchronizes the clk tree.
> >
> > The DRAM clocks on imx8m have the following structure (abridged):
> >
> >  +----------+       |\            +------+
> >  | dram_pll |-------|M| dram_core |      |
> >  +----------+       |U|---------->| D    |
> >                  /--|X|           |  D   |
> >    dram_alt_root |  |/            |   R  |
> >                  |                |    C |
> >             +---------+           |      |
> >             |FIX DIV/4|           |      |
> >             +---------+           |      |
> >   composite:     |                |      |
> >  +----------+    |                |      |
> >  | dram_alt |----/                |      |
> >  +----------+                     |      |
> >  | dram_apb |-------------------->|      |
> >  +----------+                     +------+
> >
> > The dram_pll is used for higher rates and dram_alt is used for lower
> > rates. The dram_alt and dram_apb clocks are "imx composite" and their
> > parent can also be modified.
> >
> > This driver will prepare/enable the new parents ahead of switching (so
> > that the expected roots are enabled) and afterwards it will call
> > clk_set_parent to ensure the parents in clock framework are up-to-date.
> >
> > The driver relies on dram_pll dram_alt and dram_apb being marked with
> > CLK_GET_RATE_NOCACHE for rate updates.
> >
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> > ---
> >  drivers/devfreq/Kconfig      |   9 +
> >  drivers/devfreq/Makefile     |   1 +
> >  drivers/devfreq/imx8m-ddrc.c | 465 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 475 insertions(+)
> >  create mode 100644 drivers/devfreq/imx8m-ddrc.c
> >
> > diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> > index 59027d7ddf2a..5eac479dd05f 100644
> > --- a/drivers/devfreq/Kconfig
> > +++ b/drivers/devfreq/Kconfig
> > @@ -89,10 +89,19 @@ config ARM_EXYNOS_BUS_DEVFREQ
> >         Each memory bus group could contain many memoby bus block. It reads
> >         PPMU counters of memory controllers by using DEVFREQ-event device
> >         and adjusts the operating frequencies and voltages with OPP support.
> >         This does not yet operate with optimal voltages.
> >
> > +config ARM_IMX8M_DDRC_DEVFREQ
> > +     tristate "i.MX8M DDRC DEVFREQ Driver"
> > +     depends on ARCH_MXC && HAVE_ARM_SMCCC
>
> I'll edit it as following and applied it.

You corrupted the URLs in the binding patch when applying the series:

Traceback (most recent call last):
 File "/usr/local/lib/python3.6/dist-packages/jsonschema/validators.py",
line 774, in resolve_from_url
 document = self.store[url]
 File "/usr/local/lib/python3.6/dist-packages/jsonschema/_utils.py",
line 22, in __getitem__
 return self.store[self.normalize(uri)]
KeyError: 'https://protect2.fireeye.com/url?k=b51ff83f-e8cff0d7-b51e7370-000babff32e3-c25c03b8af1b12ee&u=http://devicetree.org/meta-schemas/core.yaml'

Rob

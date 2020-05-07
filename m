Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828B91C8C10
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 15:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgEGNZD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 09:25:03 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:53803 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgEGNZA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 09:25:00 -0400
Received: from mail-qv1-f48.google.com ([209.85.219.48]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MUGqT-1jgPph155X-00RJ9O; Thu, 07 May 2020 15:24:58 +0200
Received: by mail-qv1-f48.google.com with SMTP id a15so623335qvt.9;
        Thu, 07 May 2020 06:24:57 -0700 (PDT)
X-Gm-Message-State: AGi0PubcbnKfTZF/aTRyPpow6VVBcaniSl7c4HI7NWDL9wTgXkHef1PE
        TbO1w/BdjwN0hp/yhrV8ErY2M4V7OZgYKgTRLVc=
X-Google-Smtp-Source: APiQypLIAviOYBCYxRnII0AvfushamRE+8Q+7+nbZJVXRnY9HSekpz3+fnWiynyno8isRVxgoJHmyQo0K7lErlQsonk=
X-Received: by 2002:a0c:ea43:: with SMTP id u3mr12360811qvp.211.1588857896673;
 Thu, 07 May 2020 06:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200507112955.23520-1-geert+renesas@glider.be>
In-Reply-To: <20200507112955.23520-1-geert+renesas@glider.be>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 May 2020 15:24:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2TcOrWOhLKdovo0qTTx1PB4+iWVyFyzQOen7ZRwNZhJA@mail.gmail.com>
Message-ID: <CAK8P3a2TcOrWOhLKdovo0qTTx1PB4+iWVyFyzQOen7ZRwNZhJA@mail.gmail.com>
Subject: Re: [PATCH 0/4] qoriq: Add platform dependencies
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        IDE-ML <linux-ide@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:PgbK4jomL/oPmttcNNnNdvjMIBGCXYxepf+gQMxPOyS7UoUERQ/
 hW+ZUN4S6Wz5oQZDDsyqlH3P8NKPG6bDDMVnwBMiIDmMOL01fhNIiYpbmsqRAobYyDtdxAJ
 2O4Sg1SLW3ojyS9z8M/8Yrn2v3t9pOpKufGf+NtrKUtYS+0atpuVpIQBvjzp79GUiuPrsBD
 oNvy58oNqsh/cvEGxx0Ug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UKGBaAfyG2A=:ipOGl0fuZujD4juaVnmoX9
 t2Iq6oBdXx59XiTToq9LBoAlqD/08LcZnKcwP7sX6iAA5BLddg82vBftJKAo2AesDb8BK3KBn
 H5ClSqBp0gqKpvcpb/Tn+1ReWapcz1+wUCU82UvucS8WHy+D2pRw/7y3yjX16EMkWwKwwSZtM
 L6+4EXrpp/6DkQ+WV52GPMrAzy+sl5gIHrnr0ekmumxP9Mkc+zc3om4cGWy6Z+8rI0HpQsjbA
 P9AIIlFJnqFc7TNYJ78GEDpK8dY5pOx2p/6W2kES78vuAKT290c0sy5rRec4H7a56rmW7DYm7
 Nwm5VDMms9PUPuLn/cOy0PLHZTpqJqD2WPgSQfe54FC1SmBAcIOP949kJja1+dDof11JAqHHF
 5ZAHbPbprqiUOtlZNB70FV7NBBgOfhSngZ+RpFidKqqCERD7DLm9ubqVye3CNGCCSfv1kZkR1
 b75oHcDFUnqbQ2B5leNHUqoOk7tiUQ93FGiXMSxLfeIr2cFdKgXzD05r1MOleWLmke40zxiMe
 KleXNBIWbhMFJTUEEhQV8zi9C5G+qRsCO4lwtDL81MbooF2L6psOk8orZLXxdH7x1UXEJg4yn
 ToRzNBytYemhZ5omLilJBAFU1AhIvUHXZ12iaK1vE4QDj2ANFxjDcnmTamxEON6DeeHeDn8WO
 cByGB/07BOns8kkblHUxyI85+3byXg3zo5jgIBU4/8hHnSLlB5isxJepVARAlyWX8iKC82kDd
 Xonc6yh4nxVxPmBP7DqeWiJJK72LHhZtyJnloi+o1JStoMTM/D/g/xes0ZRLDZXvIjEm/speC
 KZVZOuczobNrMvl9K1Ur2GWXINeXsZBFiLjqvyrdCYybdc28zw=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 7, 2020 at 1:30 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
>         Hi all,
>
> Several QorIQ blocks are only present on Freescale or NXP SoCs.
> This series adds platform dependencies to the corresponding config
> ymbols, to avoid asking the user about them when configuring a kernel
> without support for these SoCs.
>
> Most patches in this series are independent, but the third patch may
> cause some Kconfig warnings when applied before the second patch, and
> enabling the QorIQ CPU frequency scaling driver in a non-Layerscape
> kernel.
>
> Thanks for your comments!

These all look good to me, thank you for the improvements!

Acked-by: Arnd Bergmann <arnd@arndb.de>

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8D81E9141
	for <lists+linux-pm@lfdr.de>; Sat, 30 May 2020 14:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgE3MlP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 30 May 2020 08:41:15 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:54527 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgE3MlO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 30 May 2020 08:41:14 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M42fG-1jf0nY3NJY-0004XU; Sat, 30 May 2020 14:41:13 +0200
Received: by mail-qk1-f182.google.com with SMTP id 205so4856598qkg.3;
        Sat, 30 May 2020 05:41:12 -0700 (PDT)
X-Gm-Message-State: AOAM532ekAxTBYq6oyJycdBdVG/WjYfjJULI0ytMjlDp4FbmlO9rZgO+
        a2IaEPwUIhyNiZkMW3XIxnjwIevfK3RoUwmpATA=
X-Google-Smtp-Source: ABdhPJydoZz/ssTjLXxCt2yeqV8hAaHbfCWOWY6wEJBIVgR/U5A4FoXmjwXzYGkUpjWGkYh20OdZtmbtwwVbzTOQYhs=
X-Received: by 2002:ae9:de85:: with SMTP id s127mr11396467qkf.352.1590842471556;
 Sat, 30 May 2020 05:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200529201731.545859-1-arnd@arndb.de> <20200530092052.ksuncmgx3cahokzo@vireshk-i7>
In-Reply-To: <20200530092052.ksuncmgx3cahokzo@vireshk-i7>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 30 May 2020 14:40:54 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2dADAG9-NnsR8opP++xq6T_BB3C6i-wvkzrKvXNOghiQ@mail.gmail.com>
Message-ID: <CAK8P3a2dADAG9-NnsR8opP++xq6T_BB3C6i-wvkzrKvXNOghiQ@mail.gmail.com>
Subject: Re: [PATCH] opp: avoid uninitialized-variable use
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:zj3+1RfAi2Y/LpsF8bm3Zq2xu2mtaVM8XjKxbIKNCoP80ODOuyh
 /amKCQAptrayWhr9F7hGhmK/Uujoz1v4xMy/4O7UlTPm6atRdTVaOpikNHKohJvWSNSX7hi
 5+hgMPPRY3Yt+eJYcyw3EYPHkEKhj5NEnS+i/0sY8jr57WyGLl3SsF+KQN4dVX5GOXifnnh
 AprDtpEIuC0S7gPMjkP2w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wbu0eVypBFo=:a7h3+yUlj+MQA08lBE+Vn9
 pWhPhuanuvemjezDgtfYVAMhDAlr/7l4xet8szPK2gkpdzY2p8Pcei3mvAL7HAJd9V1OWGl5c
 SLVNJwWArGuAqJvE09y2CoJicJm4TzPDCWYNfZPrdsgTeptouPWRKFr6cWEa61ior3RJAbogO
 CrexdDWbP0tJYPPP0ycBHq41skNVEOcyFPcsu3xoHV8MuFdJc9T9oqIkFpg5RbceGrHRZ0+v6
 UfpLslgBbl5AE9VOZ+gPpCCvhf6BnAhY6oecjhJoDDRINPvc1c3r0ZhqfztFWBTyoiUYqGpZ+
 MQhAInCubOlqg4qJYJ/vUv7nVdxq2yLI2bn68gtgzhTBMD7ZhsvHuRIxRRParNO41s4KE9oTn
 09+S2ZCFqnTWBpuHx/O5z2pSZeaJQoo2kVnSSQInEGTxpokhNj2gTkXLHjCIultPFZ8efcJFz
 A/rJujZuUZucvhyB5CotCPjrrlhvHLTzqhCaZF5SGq5G4yzvv8aYOWkwMNx0HaaRQV5cgr6vn
 I9LaMBiJsx4Ha3fnHqwdED+0JU4/Hwz6ynYPfElRRDhfSNWGS/NaL4KaSKV4vbjVQBUA3N4Wt
 yYHREsbmmJ9GZZ6IHEjXSArEtQLV+pG+tBAwUtwCmkGbK3S8GLjh8ZMiGl8t6Vk6nlnZvjMH1
 frDufCHY6c4ZZpFp+DXgFiPQEVC4/UVn8xt4VnhwBOv2OcLLj6HqHbRhonAWEad3RWVCA8Ww5
 67kmVkzgRPGdS2GrvmWa7VW+Hg48BiPJyDFHo7GQonrEbiPaCClcZC9k4Dpo6PmDn+ultvUHu
 lD4rcePW51CHDynpg5sE6zo9RLjUotIMnvSgnNjwdzg687H3EY=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, May 30, 2020 at 11:21 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 29-05-20, 22:17, Arnd Bergmann wrote:
> > An uninitialized pointer is passed into another function but
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -872,7 +872,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
> >                       goto put_opp_table;
> >               }
> >
> > -             ret = _set_opp_bw(opp_table, opp, dev, true);
> > +             ret = _set_opp_bw(opp_table, NULL, dev, true);
> >               if (ret)
> >                       return ret;
> >
>
> Not sure why people are still seeing this, I pushed a fix for this 2
> days back.

I was on next-20200528, which was the first version that was broken for me,
and I sent all my fixes after I had tested them. Since a lot of things
got broken
at once that day, it took me until the end of 20200529 to get it all tested
properly and then send them out.

      Arnd

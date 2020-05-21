Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27911DCCC0
	for <lists+linux-pm@lfdr.de>; Thu, 21 May 2020 14:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgEUMXM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 May 2020 08:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgEUMXM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 May 2020 08:23:12 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CA3C061A0E;
        Thu, 21 May 2020 05:23:12 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id c16so7205254iol.3;
        Thu, 21 May 2020 05:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dLRlXkQKfLYkmmwJc2IRcOiGHBn9i2amIFILrmeGCPA=;
        b=DfOg8Qx/GufnehWDt+lldTEiy0PT1YFGmMI0o0T6PYZezyt5e8QPWegcsRaT1sBEQz
         Z+8nlQHyvtRQKn4elyeRBmfdUxZfkCapBnyKlCCZzz5DIUgnPm4kebeJbsWBCBpY7hYB
         WpMMlmKcX/K6IMjT4u6pdGOc/ewXtu4OZxLiUwNmZA1xc/SNzTDljD6+E7SWwM5NgHAV
         TZFGdZrdWaI9S6s+qmRlMGQbLqpJqEqcBaFh/Fp3dztYb4+OfoiiKSPPSIBQX/BKlPak
         f42zgIaY6uWY9xWffR4WGtv2dXC3K/Xhab2VcgWIT4j+rZrtD09pwwXfV+DAf7Hvvv9n
         oUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dLRlXkQKfLYkmmwJc2IRcOiGHBn9i2amIFILrmeGCPA=;
        b=oOZxhu9CC9m4mCqLjQZDYLBa4UeFb16KOMfmvY6kir/63zjEZBPBzAzdsJ/+RtUTb7
         arJfK18m8KjFdxK1znu9L/Xi+pCl67ft9tqtn/PfUT+8UWiAIBGSG/hQaEBjO+syMCgY
         K/IhJxA0QDCMw1z7fM+U0UfMYdbmwCrXeBV4ZZ6gmMt32DDWKPneqKoDbqw4OE93PTEG
         qEwhuAJsqMCiTkFVJEi1QktM3hthmcIZtOaKCwji59/KEyGPZQ89GK4skA9ces2vfhIG
         j21N++CDSZnBfiQ/MXsN4aUulHIzOZy/NK0WVASNOHGevtDryL7U53gFu+pj2/2bwJeE
         4asQ==
X-Gm-Message-State: AOAM530XWcZXgv9LdwTxfnIcu1NVzT+6CDC8jGA1w30iEcDZRyfKnxLA
        VO9ITZ2n57FJBzk35mLpI6lB8ciEVS6z8Wl5OtUGFpW/QsI=
X-Google-Smtp-Source: ABdhPJxywRNWuEXqqJHmt35W0FgGHaOdScBGeQjIVzBw0Z3F5o/E5GG+U12fvQC0HIN/IrZPLnupCYcFH2Y5OJ9GrQI=
X-Received: by 2002:a02:ccd6:: with SMTP id k22mr3488037jaq.18.1590063791246;
 Thu, 21 May 2020 05:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589528491.git.viresh.kumar@linaro.org> <CAJiuCceftArjKPyiEW8AnT5TtuCJFsRGGA-_8y2zG5GDTxHO4Q@mail.gmail.com>
In-Reply-To: <CAJiuCceftArjKPyiEW8AnT5TtuCJFsRGGA-_8y2zG5GDTxHO4Q@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 21 May 2020 14:23:00 +0200
Message-ID: <CAJiuCcejjaM=+XWsmOe93idbC8TyyxLj30+Lf+5C=yv=hxT80g@mail.gmail.com>
Subject: Re: [PATCH 0/2] opp: core: add regulators enable and disable
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     k.konieczny@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Fri, 15 May 2020 at 14:00, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> Hi Viresh,
>
> On Fri, 15 May 2020 at 09:57, Viresh Kumar <viresh.kumar@linaro.org> wrot=
e:
> >
> > Hi,
> >
> > This series reintroduces the usage of regulator_enable/disable() to the
> > OPP core after the previous attempt was reverted [1] shortly after gett=
ing
> > applied. This time the regulator is enabled only after it is configured
> > by the OPP core.
> >
> > Marek, Kamil and Cl=C3=A9ment: Can you guys please test this out and re=
port
> > if this doesn't work as expected ?
>
> I have reviewed the patch and it seems fine for my use case.
> Unfortunately I can't test it until next week.

Ok, before the patch the regulator was released by regulator_late_cleanup()=
 :
[   33.756849] vdd-gpu: disabling

Now it works fine and the vdd-gpu is no more disabled.

Tested-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>

Regards,
Clement

>
> Acked-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
>
> Regards,
> Clement
>
>
> >
> > --
> > viresh
> >
> > [1] https://lore.kernel.org/lkml/20191017102758.8104-1-m.szyprowski@sam=
sung.com/
> >
> > Kamil Konieczny (1):
> >   opp: core: add regulators enable and disable
> >
> > Viresh Kumar (1):
> >   opp: Reorder the code for !target_freq case
> >
> >  drivers/opp/core.c | 39 ++++++++++++++++++++++++++++++++++-----
> >  drivers/opp/opp.h  |  2 ++
> >  2 files changed, 36 insertions(+), 5 deletions(-)
> >
> > --
> > 2.25.0.rc1.19.g042ed3e048af
> >

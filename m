Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA721045F
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 05:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfEADpI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 23:45:08 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36242 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfEADpI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 23:45:08 -0400
Received: by mail-it1-f194.google.com with SMTP id v143so8320254itc.1;
        Tue, 30 Apr 2019 20:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TkB4s1r5PgKZ71uFpCZrkh9Mfe0SQFgPVceh4zEIkSk=;
        b=r2U9bzmZ4Y6ku1VauS7d9URFGDT4u5JUD7x0BNTY8EPKVgOGKi4B0Rqy9IIPKuaQYz
         hG3GjtDOkNtEYw/aRPyUtfR0ouV2NDJGL+ytieVOP/7GGlVs31JK9wxyTQRi6WYM7LXQ
         GNupGNRgjxle5/iHjwCUgtFaz1x1+C7ukuwHKCgskbrzAuHQMG9hfI7ekZyQSDDxORe5
         l5YonGybDLIYk0hMmgNnDdBehyX2eZcEnIXhhEXLrD936AZ83a8ThriwX9BqauKOZHos
         XpRfNS0purqncEtQ7g4OPhcFNpzjQtrNbRdhBFo8gl2lvR/1q1rr+r92HLADczj9zzbs
         tt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TkB4s1r5PgKZ71uFpCZrkh9Mfe0SQFgPVceh4zEIkSk=;
        b=nixPt1PalCuQZbKD0skd68p7ejmLXEJSuU8iv7npvYoJfV7nTpkA0we72+XTZF6OO+
         9bncvXm/M0BMRyLgbJOeYIDc3869OocUzuxEp4qrUogLG430fcQJs65qWTldhMtGlvm2
         MktodUneHAe+VK7r2uSKfpGJQYRzDv0ZcLiglSd/iJLu3naQb6xdelO9VQX3vyVQxMfg
         C0rj9f9A2+jeB4E6s1vAcF4XHQPZSSegL5W9udmcEsBYTKocku9V/fVNrX0slxswWBvx
         7sjxtep0oFFjvbjBWazj0eG4W8BzwPHJVI0gAE+iwcGWx+Tfyj6N8cvhQU+hXqguCmbu
         YoPQ==
X-Gm-Message-State: APjAAAX7gngn+M/chZZRvLH0gowyHcpMXFBIy+p1wyuK46O9d1x4IewW
        rfgiSN1SBOfafYeno0SR8Qdo9+rEyA6mYYoNYS4=
X-Google-Smtp-Source: APXvYqzLrMqPKXV9+qRMezJD64nBLRaRn4e3qS42BmiTaPw+hgZdIxV+ckAZw+e3Lf1qZMsMEU3u87FCKEVCosnWcg0=
X-Received: by 2002:a24:6c54:: with SMTP id w81mr6507934itb.78.1556682307120;
 Tue, 30 Apr 2019 20:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190410174139.20012-1-tiny.windzz@gmail.com> <20190410174139.20012-3-tiny.windzz@gmail.com>
 <20190426211540.GA890@bogus> <CAEExFWs2UwPLzgyO0apMOZf56um5isdZmf+7-wj_TqMozxZJQg@mail.gmail.com>
 <CAL_Jsq+0mQYyAqfY3nmF-oFx2X4qHU567chQ1s8p-rgD2GEFnw@mail.gmail.com> <20190430044245.s4viduudej6q2eq6@vireshk-i7>
In-Reply-To: <20190430044245.s4viduudej6q2eq6@vireshk-i7>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Wed, 1 May 2019 11:44:55 +0800
Message-ID: <CAEExFWsAQ3b42YqfW-b8vuq_NZgfDe+0D5TzP09ber0Ljvv43g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: cpufreq: Document allwinner,cpu-operating-points-v2
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 30, 2019 at 12:42 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 29-04-19, 11:18, Rob Herring wrote:
> > On Sun, Apr 28, 2019 at 4:53 AM Frank Lee <tiny.windzz@gmail.com> wrote:
> > >
> > > On Sat, Apr 27, 2019 at 5:15 AM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Wed, Apr 10, 2019 at 01:41:39PM -0400, Yangtao Li wrote:
> > > > > Allwinner Process Voltage Scaling Tables defines the voltage and
> > > > > frequency value based on the speedbin blown in the efuse combination.
> > > > > The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> > > > > provide the OPP framework with required information.
> > > > > This is used to determine the voltage and frequency value for each
> > > > > OPP of operating-points-v2 table when it is parsed by the OPP framework.
> > > > >
> > > > > The "allwinner,cpu-operating-points-v2" DT extends the "operating-points-v2"
> > > > > with following parameters:
> > > > > - nvmem-cells (NVMEM area containig the speedbin information)
> > > > > - opp-microvolt-<name>: voltage in micro Volts.
> > > > >   At runtime, the platform can pick a <name> and matching
> > > > >   opp-microvolt-<name> property.
> > > > >                       HW:             <name>:
> > > > >                       sun50iw-h6      speed0 speed1 speed2
> > > >
> > > > We already have at least one way to support speed bins with QC kryo
> > > > binding. Why do we need a different way?
> > >
> > > For some SOCs, for some reason (making the CPU have approximate performance),
> > > they use the same frequency but different voltage. In the case where
> > > this speed bin
> > > is not a lot and opp uses the same frequency, too many repeated opp
> > > nodes are a bit
> > > redundant and not intuitive enough.
> > >
> > > So, I think it's worth the new method.
> >
> > Well, I don't.
> >
> > We can't have every SoC vendor doing their own thing just because they
> > want to. If there are technical reasons why existing bindings don't
> > work, then maybe we need to do something different. But I haven't
> > heard any reasons.
>
> Well there is a good reason for attempting the new bindings and I wasn't sure if
> updating the earlier bindings or adding another one for platform is correct. As
> we aren't really adding new bindings, but just documentation around it.
We didn't really add anything else, it still revolves around the
features that opp already supports.
>
> So there are two ways OPP core support this thing:
>
> - opp-supported-hw: This is a better fit if we have a smaller group of
>   frequencies to select from a bigger group, so we disable non-required OPPs
>   completely. This is what Qcom did as they wanted to select different
>   frequencies all together.
>
> - opp-microvolt-<name>: This is a better fit if the frequencies remain same and
>   only few of the properties like voltage/current have a different value. So we
>   don't disable any OPPs but just select the right voltage/current for those
>   frequencies. This avoids unnecessary duplication of the OPPs in DT and that's
>   what allwinner guys want.
>
> The kryo nvmem bindings currently supports opp-supported-hw, maybe we can add
> mention support for second one in the same file and rename it well.
So which way is correct?

Thx,
Yangtao
>
> --
> viresh

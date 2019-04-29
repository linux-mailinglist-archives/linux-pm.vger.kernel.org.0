Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0EF2E793
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 18:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfD2QSn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 12:18:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728542AbfD2QSn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Apr 2019 12:18:43 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D83BF20673;
        Mon, 29 Apr 2019 16:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556554722;
        bh=y+8rKTlzq61ygqpRLwRIKyd+HPW/HceVYVOZlw5ZooE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cAszN/xU6nogM20gyC6HXrHhU4HZtFzFs8Xz0vUh77Fokj1XAWwp3bh6DryIw11R2
         GfkPiX1NXpGSJRFIE3vm9LCIMdVrj/joj7rl/EAukRhXXAznX1W9Qc/OJnAMAWxlXb
         DgCdG4gX1SWabm5LQSftTtV9D2WcIlTKq/+YNsE8=
Received: by mail-qt1-f174.google.com with SMTP id d13so12583267qth.5;
        Mon, 29 Apr 2019 09:18:41 -0700 (PDT)
X-Gm-Message-State: APjAAAX2iJkBEw4scXg++JG3NSN7iak4VEAR8sp0fFUsdaqqV78TDzwZ
        5PXzrs5m9uHUR4zngZiUzNufCA7glDGU7MNmuA==
X-Google-Smtp-Source: APXvYqyzqs09hNBiab7wqw3JOVfJ9CFkM2ZcAO05H+2Yc6TdhfKWUtxNLYtavldF7yNklJkdWImkkMHYR0Y3l+v22yw=
X-Received: by 2002:aed:306c:: with SMTP id 99mr2856198qte.38.1556554721170;
 Mon, 29 Apr 2019 09:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190410174139.20012-1-tiny.windzz@gmail.com> <20190410174139.20012-3-tiny.windzz@gmail.com>
 <20190426211540.GA890@bogus> <CAEExFWs2UwPLzgyO0apMOZf56um5isdZmf+7-wj_TqMozxZJQg@mail.gmail.com>
In-Reply-To: <CAEExFWs2UwPLzgyO0apMOZf56um5isdZmf+7-wj_TqMozxZJQg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 29 Apr 2019 11:18:29 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+0mQYyAqfY3nmF-oFx2X4qHU567chQ1s8p-rgD2GEFnw@mail.gmail.com>
Message-ID: <CAL_Jsq+0mQYyAqfY3nmF-oFx2X4qHU567chQ1s8p-rgD2GEFnw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: cpufreq: Document allwinner,cpu-operating-points-v2
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
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

On Sun, Apr 28, 2019 at 4:53 AM Frank Lee <tiny.windzz@gmail.com> wrote:
>
> On Sat, Apr 27, 2019 at 5:15 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Apr 10, 2019 at 01:41:39PM -0400, Yangtao Li wrote:
> > > Allwinner Process Voltage Scaling Tables defines the voltage and
> > > frequency value based on the speedbin blown in the efuse combination.
> > > The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> > > provide the OPP framework with required information.
> > > This is used to determine the voltage and frequency value for each
> > > OPP of operating-points-v2 table when it is parsed by the OPP framework.
> > >
> > > The "allwinner,cpu-operating-points-v2" DT extends the "operating-points-v2"
> > > with following parameters:
> > > - nvmem-cells (NVMEM area containig the speedbin information)
> > > - opp-microvolt-<name>: voltage in micro Volts.
> > >   At runtime, the platform can pick a <name> and matching
> > >   opp-microvolt-<name> property.
> > >                       HW:             <name>:
> > >                       sun50iw-h6      speed0 speed1 speed2
> >
> > We already have at least one way to support speed bins with QC kryo
> > binding. Why do we need a different way?
>
> For some SOCs, for some reason (making the CPU have approximate performance),
> they use the same frequency but different voltage. In the case where
> this speed bin
> is not a lot and opp uses the same frequency, too many repeated opp
> nodes are a bit
> redundant and not intuitive enough.
>
> So, I think it's worth the new method.

Well, I don't.

We can't have every SoC vendor doing their own thing just because they
want to. If there are technical reasons why existing bindings don't
work, then maybe we need to do something different. But I haven't
heard any reasons.

Rob

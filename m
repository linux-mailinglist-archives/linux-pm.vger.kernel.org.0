Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 683CD17BCC9
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 13:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgCFMdL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 07:33:11 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44276 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgCFMdL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Mar 2020 07:33:11 -0500
Received: by mail-qk1-f193.google.com with SMTP id f198so2052140qke.11
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2020 04:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8jme23MILbS+eEi/mucEfUohC7POgRPBqp0gcQEH/IE=;
        b=xIv9xUeUtBuT7AeM6fG/sie44A14iRH6e5e3eKDBgdda7spKXVwKn/1WwVmuU1uuV8
         DrU0xsBSkqYXoFLEqNd+XAqmcnTMQ6QHekzp8Ru0+urbvSqC8lZ3NKtdYLCtApdQFqQa
         rO0SqXaslSzrTAMgZm4KNuVcoWOl9pOWYBzPVEXqREon5t23S67nZ1igNzt8RprdOjVF
         sWOJOTBUAnBNul7O/aqQ98AKTZjVv3iJoB3S5ubcsCQtRPT3g2tUR0zyrg952xQE/IoD
         cph0urfOlDSmQveRL1upLqXTMHXQps3z4UUjzfpp6gW5zX6sx5Lfxi15bVLg2hR5kiLa
         tDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8jme23MILbS+eEi/mucEfUohC7POgRPBqp0gcQEH/IE=;
        b=sNTFT9SPEORfA4uhjRfIOpTXOHi9RVjVvCe0E0vsa2mHtng/uqZutKhWczd4T49Y32
         9J4K9l4Bqamkeo7ZNiAK6Vnr7alTs4IduHY8NrJZ54kvoGhfqv214GGtY1vaHevfg/+6
         wzmO44oXpfhoprlmZFe1uvBsifLrZHzEbgd1GJ2zrl1zNbZOF0daTf4wes1S8qTB8Qck
         09VY/v84Aisc8ZBYfa0DoBIg0+CETPLQdvoT04k3YOpJEUK7xyiSQ+ZWwQ1VoCB0qPYk
         na42fRv64wLAI08tx95lFKvHzXWUcy7yc3rLeOaYO6e8zLF8euFtLsVN+Ql5n3sRSjIf
         d3GQ==
X-Gm-Message-State: ANhLgQ0NWGmAVsZ8wPWURYONsECTVn3thDHSoDCkTyPJV8O3KujJ0/EN
        +xbJdtdAym3eq4j8+4sh/U5hLP15Ze7FEnHk5yK43g==
X-Google-Smtp-Source: ADFU+vtnTdD+C52gOY5/bNyK5t7jRps/5HdzKnVhovJ39crWl3aPsIOQ9ygdHTvD51dOT3oHDu1anOJNOgnBPbmqZyA=
X-Received: by 2002:a05:620a:14b1:: with SMTP id x17mr2582656qkj.219.1583497990177;
 Fri, 06 Mar 2020 04:33:10 -0800 (PST)
MIME-Version: 1.0
References: <20200303203559.23995-1-ulf.hansson@linaro.org>
 <20200303203559.23995-5-ulf.hansson@linaro.org> <20200304122312.GE25004@bogus>
 <CAPDyKFpcN-p6sKqB0ujHAY29qPSg7qpSjYGymPaJ4W8jgCKGcg@mail.gmail.com>
 <20200305162321.GB53631@bogus> <CAPDyKFogjPG+mRsfPaxN7RjB7TQL9=qHNzA=K_t0F6M6Q9-TuA@mail.gmail.com>
 <20200306100431.GA16541@bogus> <CA+M3ks764moVU2h9iZJuN6B-e4wBUMymBfPnob_zraf50xqezA@mail.gmail.com>
 <20200306120646.GB44221@bogus>
In-Reply-To: <20200306120646.GB44221@bogus>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 6 Mar 2020 13:32:59 +0100
Message-ID: <CA+M3ks7+P=CjvUE28boANhrR6bhzLzyjBLovzWL_LjwL3UqmzQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] cpuidle: psci: Allow WFI to be the only state for
 the hierarchical topology
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lina Iyer <ilina@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Le ven. 6 mars 2020 =C3=A0 13:06, Sudeep Holla <sudeep.holla@arm.com> a =C3=
=A9crit :
>
> On Fri, Mar 06, 2020 at 11:47:40AM +0100, Benjamin Gaignard wrote:
> > Le ven. 6 mars 2020 =C3=A0 11:04, Sudeep Holla <sudeep.holla@arm.com> a=
 =C3=A9crit :
> > >
> > > On Fri, Mar 06, 2020 at 10:28:10AM +0100, Ulf Hansson wrote:
> > > > On Thu, 5 Mar 2020 at 17:23, Sudeep Holla <sudeep.holla@arm.com> wr=
ote:
> > > > >
> > >
> > > [...]
> > >
> > > > > OK. The only state that cluster can enter when CPUs are in WFI ar=
e
> > > > > cluster WFI and most hardware can handle it automatically. I don'=
t see
> > > > > the need to do any extra work for that.
> > > >
> > > > This isn't about cluster WFI, but about deeper cluster states, such=
 as
> > > > a cluster-clock-gated-state and a cluster-power-off-state. It's an =
ST
> > > > platform, which Benjamin is working on.
> > > >
> > >
> > > Then definitely something is completely wrong. You can't enter deeper
> > > cluster states(clock-gated and power-off to be specific) with CPU in
> > > just WFI state. So, if the attempt here is to enter those states, I
> > > disagree with the change.
> > >
> > > Benjamin, please share the complete hierarchical topology for your pl=
atform.
> >
> > The platform is stm32mp157 SoC which embedded two Cortex A7 in one clus=
ter.
>
> Hang on a minute, is this the same platform where you wanted high
> resolution timer and were hacking moving dirty tricks around[1]. Now I th=
ink
> you have landed here.

yes it has been fixed in this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/a=
rch/arm/kernel/time.c?h=3Dv5.6-rc4&id=3D022eb8ae8b5ee8c5c813923c69b5ebb1e96=
12c4c

>
> > I would like to be able to put the system in a state where clocks of CP=
Us and
> > hardware blocks are gated. In this state local timer are off.
>
> Sure, please create a deeper CPU state than WFI and enter so that the CPU
> state is saved and restored correctly. What is the problem doing that ?

This state stop the clocks for all the hardware blocks and not only the CPU=
s
so we can't go on it while devices aren't suspended.
I may have missed something but I don't believe that I could add this kind =
of
conditions in a cpu idle state, right ?
In this state I need to be able to enable the wake up sources because
it is the only
for hardware block used as broadcast timer to wake up the system.

>
> > The platform should be allowed to go in this state when the devices
> > within the power domain are pm_runtime_suspend and the CPUs in WFI.
>
> Nope, we don't save and restore state when we enter/exit WFI. And hence
> we can't allow deeper idle states in the hierarchy. No more discussion
> on that.

>
> > In DT I have one system power domain where the hardware blocks (i2,
> > uart; spi, etc..) are attached + a power per CPU.
>
> You really need a CPU idle state here.
>
> --
> Regards,
> Sudeep
>
> [1] https://lore.kernel.org/linux-arm-kernel/a42dd20677cddd8d09ea91a369a4=
e10b@www.loen.fr/

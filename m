Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C496F17BAB9
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 11:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgCFKrz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 05:47:55 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34081 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgCFKry (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Mar 2020 05:47:54 -0500
Received: by mail-qv1-f67.google.com with SMTP id o18so712740qvf.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2020 02:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L9qllgBetj+BEQWfT/OiX2QC0uNgMlThjG4S3HBEVvA=;
        b=bdhXAQ6gl3kdxFEBzTgcym4UaEMZ4lZe1QC4kNndxgcPzc9YZSwXW+SZoXj85K7NXN
         Jg9AmHG5ZpHiJaZ1JJqJuX69h0MBw2IgWMTWKp+qSf1IZ/rckzt0if7mIDkI28SWA8LO
         fjeBrXa93E6v8IS/KwAR5s2VMuHkA9E5YVXvhTd+gtaI+iKNz49+zhfcX4mcgLXr34Nv
         dxEibUj3oE/VBLenqtUBlI7fnSmCRuGcnJjTKYHEi8+jvNiv+AqgZoVzvKKJeNw6/zVd
         zkoSqxnqXbZwV54lkEgYg1sln4OuTWwKgGVYrWk4EMPUoh/cyC7J+603sACdDYtcOSB3
         WiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L9qllgBetj+BEQWfT/OiX2QC0uNgMlThjG4S3HBEVvA=;
        b=kQUN5O3Uzm5OMaiywN0zpvpSqM/wfkQPxdEVZor//Z20cUsP5v7sa0w85mFSBz0+xP
         7Ye30yeuzWBZB3MydyJ1vMd49l76/bhjGTG7nACqQqV6ww6tLEua18jlkmZVmIPvA10e
         6LsPBBCuCF3vOFKU8oz4z8z0XBdoiafk//Bc3fAqrj9S3bVC5weElbgtou2v5ZICpkWV
         y8DVYgtWJhjQ6ZYMEtBRveFSzuaaR35lQl9L6Ih/gjOpLDEcXp6eCMQ1VRO9gu5VFJ54
         u0cltpB2WluELgOL3DhfStuUsW2zOwVAzmQGsZUuzJ7tZ4Mr5WR7yCDU0k1qkl26x9wN
         hxDQ==
X-Gm-Message-State: ANhLgQ3ucaRWMS1XMsT3d7tVjwLCYVwosvmFS+h+SG+bwCNeYQ1w54jT
        WV9xkMFXd/GMNe7qjRkqKjoWqmivpoegUx+44Q27Sg==
X-Google-Smtp-Source: ADFU+vsTn3fA0kraMXMGFlj/616/+NyRO05/rAFKlvewIjoL2RL/94yrpoO1r5hTt6eGiANfTO/TbGs9/ExYxCs1yHM=
X-Received: by 2002:ad4:4861:: with SMTP id u1mr2220560qvy.233.1583491672115;
 Fri, 06 Mar 2020 02:47:52 -0800 (PST)
MIME-Version: 1.0
References: <20200303203559.23995-1-ulf.hansson@linaro.org>
 <20200303203559.23995-5-ulf.hansson@linaro.org> <20200304122312.GE25004@bogus>
 <CAPDyKFpcN-p6sKqB0ujHAY29qPSg7qpSjYGymPaJ4W8jgCKGcg@mail.gmail.com>
 <20200305162321.GB53631@bogus> <CAPDyKFogjPG+mRsfPaxN7RjB7TQL9=qHNzA=K_t0F6M6Q9-TuA@mail.gmail.com>
 <20200306100431.GA16541@bogus>
In-Reply-To: <20200306100431.GA16541@bogus>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 6 Mar 2020 11:47:40 +0100
Message-ID: <CA+M3ks764moVU2h9iZJuN6B-e4wBUMymBfPnob_zraf50xqezA@mail.gmail.com>
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

Le ven. 6 mars 2020 =C3=A0 11:04, Sudeep Holla <sudeep.holla@arm.com> a =C3=
=A9crit :
>
> On Fri, Mar 06, 2020 at 10:28:10AM +0100, Ulf Hansson wrote:
> > On Thu, 5 Mar 2020 at 17:23, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
>
> [...]
>
> > > OK. The only state that cluster can enter when CPUs are in WFI are
> > > cluster WFI and most hardware can handle it automatically. I don't se=
e
> > > the need to do any extra work for that.
> >
> > This isn't about cluster WFI, but about deeper cluster states, such as
> > a cluster-clock-gated-state and a cluster-power-off-state. It's an ST
> > platform, which Benjamin is working on.
> >
>
> Then definitely something is completely wrong. You can't enter deeper
> cluster states(clock-gated and power-off to be specific) with CPU in
> just WFI state. So, if the attempt here is to enter those states, I
> disagree with the change.
>
> Benjamin, please share the complete hierarchical topology for your platfo=
rm.

The platform is stm32mp157 SoC which embedded two Cortex A7 in one cluster.
I would like to be able to put the system in a state where clocks of CPUs a=
nd
hardware blocks are gated. In this state local timer are off.
The platform should be allowed to go in this state when the devices
within the power
domain are pm_runtime_suspend and the CPUs in WFI.
In DT I have one system power domain where the hardware blocks (i2,
uart; spi, etc..)
are attached + a power per CPU.

Benjamin

>
> > >
> > > > Then, after we have called pm_runtime_put_sync_suspend() a few line=
s
> > > > above, we may potentially have a "domain state" to use, instead of =
the
> > > > WFI state.
> > > >
> > >
> > > Are they any platforms with this potential "domain state" to use with
> > > CPU WFI. I want to understand this better.
> > >
> > > > In this case, if we would have called psci_enter_state(), that woul=
d
> > > > lead us to calling cpu_do_idle() from the __CPU_PM_CPU_IDLE_ENTER()
> > > > macro, becuase idx is zero. In other words, the domain state would
> > > > become unused.
> > > >
> > >
> > > For a domain state to become unused with WFI, it needs to be availabl=
e
> > > and I am not 100% sure of that.
> >
> > With these changes from the series, we can fully conform to the
> > hierarchical DT bindings for PSCI.
> >
>
> Theoretically may be, but may not confirm to the hardware states.
>
> > I am not sure I understand your concern, is there a cost involved by
> > applying this?
> >
>
> Yes as mentioned above.
>
> --
> Regards,
> Sudeep
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

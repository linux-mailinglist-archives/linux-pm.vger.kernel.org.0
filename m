Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCC4115315
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 15:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfLFO0z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Dec 2019 09:26:55 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33449 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfLFO0z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Dec 2019 09:26:55 -0500
Received: by mail-vs1-f68.google.com with SMTP id n27so5158269vsa.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Dec 2019 06:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sZyTKEpkqp2bs0AZzJDikttOK92FaSEis59tWv73Klo=;
        b=Ub05OABUX71c3Sd5RIDj00+eC+hc+BYbNZXXoJ1/SGpURI8Vpr8pGoFVqXADUAAK85
         YLrObq9486MNhO6AeqbSvZF6lb1Zp3OJLzqu/MDXiPyo5b+fkvONJMR8n+5r6vusJp6n
         YJlSfDM8kZkhRvrspxAhDUOkg/j/LehQSMAKFL/Hjd4kAkblm/1ZxVtr5HuQUPv0ItRW
         1vZApgukoMmAGIN1hkfqcUu26A1VHZfXCNKBvGnXA7G+4/QDhGVpDsQO8G993ASBqg8p
         y/rQvifhD4skJ0xVFqcmXnjhbGxadZZ3ABQItmdGfhkzZsqfGyidgkPT9VCLB15o57jl
         oHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sZyTKEpkqp2bs0AZzJDikttOK92FaSEis59tWv73Klo=;
        b=VdoGRr4S0TRzYaUGwNGDaPza/OUJfUiq5xLAGAnTmrvaF9xPn9Zr66bmcL5nutoQYA
         B6fLA4XOF95HwHu7n2UqhGocxrEyBn+w4KIYEWz8F5xLjQQIi1Ht5RqhWz/aM3cLuFy/
         wTUHK5g2Inc4jJSmJvcPtwOcnJxBh/j34HS/81WJY19BsnWmYMh3EoKqx7m7lteW6RiQ
         maTLb7jvDzQbo+1XOVri8AXMPxN3Q/yVDdihhzg3JDsz04CZgZT4EsHynufSKuBRBvov
         R38sVcf3gp45zcoKElgWO9qEPmZIEbupQedFtQr+pf+yrYZGSHZ+Sltrhnn8ZEaVWoq+
         PEJQ==
X-Gm-Message-State: APjAAAXHDzYL+SSGfmki98wmrD6edbGElEBGjpxr+u4aW8LBBPtRYxDD
        sRbyUB/pCd3a9wbQgKtIRaGRGivwmLd50egpf+wNYmCg9qY=
X-Google-Smtp-Source: APXvYqy9VUv5+eQYZxi7bdtnnGxixhEpgnm3PaekqyV4GcZq4nxnJQMBOmyzvYTaGxV5BbQQnLbx54v6XTifBF6LzuM=
X-Received: by 2002:a67:2087:: with SMTP id g129mr9963975vsg.191.1575642413970;
 Fri, 06 Dec 2019 06:26:53 -0800 (PST)
MIME-Version: 1.0
References: <20191127102914.18729-1-ulf.hansson@linaro.org>
 <20191127102914.18729-11-ulf.hansson@linaro.org> <20191205183544.GB1516@e121166-lin.cambridge.arm.com>
 <CAPDyKFra-C_EKrcec6Yys2P10bB+KBtVAKNtVFgqDvV=tzbDRQ@mail.gmail.com> <20191206112549.GA22964@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191206112549.GA22964@e121166-lin.cambridge.arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 6 Dec 2019 15:26:16 +0100
Message-ID: <CAPDyKFq0gS2fasU3Yyh+wPC7Pjnucv6_+vDN234ks+yuiURKCw@mail.gmail.com>
Subject: Re: [PATCH v3 10/13] cpuidle: psci: Prepare to use OS initiated
 suspend mode via PM domains
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 6 Dec 2019 at 12:25, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, Dec 05, 2019 at 09:25:54PM +0100, Ulf Hansson wrote:
> > On Thu, 5 Dec 2019 at 19:35, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > >
> > > On Wed, Nov 27, 2019 at 11:29:11AM +0100, Ulf Hansson wrote:
> > >
> > > [...]
> > >
> > > > -static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
> > > > +static int __init psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
> > > > +                                     struct device_node *cpu_node,
> > > >                                       unsigned int state_count, int cpu)
> > > >  {
> > > >       int i, ret = 0;
> > > > @@ -118,6 +152,11 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
> > > >               goto free_mem;
> > > >       }
> > > >
> > > > +     /* Manage the deepest state via a dedicated enter-function. */
> > > > +     if (dev)
> > > > +             drv->states[state_count - 1].enter =
> > > > +                     psci_enter_domain_idle_state;
> > >
> > >
> > > It is unfortunate to make this arbitrary choice, it would be best
> > > if you could detect which states are "domain" states aka are governed
> > > by multiple cpus.
> >
> > The domain states are managed and selected by the genpd providers, via
> > using runtime PM reference counting. Please have a closer look at the
> > code in cpuidle-psci-domain.c and in the generic PM domain, that
> > should give you the needed details.
> >
> > I am overriding the enter callback for the *deepest* known idle state
> > of the CPU, which is according to what you requested [1].
>
> Overriding it yes but I have not requested to do it only for the
> deepest idle state that, I repeat, in my opinion is an arbitrary
> choice that works for the platform you are testing on but is
> not generic as it should.

Right, I agree. I recall we have discussed this already.

>
> You can merge it as it is but that's how things stand and adding
> a comment to the *code* would help understand its logic.

Okay, how about adding a comment along the lines of this:

"Using the deepest state for the CPU to trigger a potential selection
of a shared state for the domain, assumes the domain states are all
deeper states. This assumption may not be true for all platforms, thus
we may consider to revisit this, if it turns out that optimizations
can be made."

>
> > So, unless I am missing your point, I think the above code does
> > exactly what you want, no?
> >
> > In regards to the "arbitrary choice" of what cpuidle state to use,
> > there are more details about why that is, in the changelog.
> >
> > >
> > > This inizialization though does not belong in here, it is done at driver
> > > level, it should not be done in this per-cpu path. IIUC the logic the
> > > enter pointer should only be overridden if and only if all cpus managed
> > > by the driver have a corresponding device associated.
> >
> > I think you have overlooked the fact that there are one cpuidle driver
> > registered per CPU. The above doesn't make sense to me, sorry.
>
> You are calling psci_dt_cpu_init_idle() for every possibile cpu.
>
> Every time psci_dt_attach_cpu() is called, we check dev and override
> the idle driver enter method. There is one driver, what I am saying
> is that it is not correct to check dev and override the enter pointer
> for *every* cpu that we try to attach to a power domain. This must
> be done once for all by checking that *all* devices could be attached
> to a power domain.

Ah, now I think get your point.

You want me to re-iterate through all the registered cpuidle drivers,
which means one per CPU - and then override the enter callback for
each of them, but only if all devices was successfully attached to a
PM domain. Is that correct?

My only worries with this, is that we have already registered the
cpuidle drivers and I don't think it's a good idea to update the enter
callbacks, beyond that point.

Perhaps another option is to track whether the first CPU gets attached
(and then update the enter callback), but after that require all the
remaining CPUs to be attached as well - else bail out with an error
code, failing to register all the driver instances.

What do you think about that?

>
> > > To be frank I would even move the psci_has_osi_support() check from
> > > psci_dt_attach_cpu() to this path and prevent calling
> > > psci_dt_attach_cpu() and the tail of the function if
> > > (!psci_has_osi_support()).
> > >
> > > >       data->dev = dev;
> > >
> > > I think Sudeep already mentioned that, by using psci_has_osi_support()
> > > as above you can prevent running this code, there is really no point,
> > > the data->dev NULL sentinel is already initialized.
> >
> > Yes, I discussed this with Sudeep, but we didn't reach a consensus.
>
> Consensus was already reached.
>
> http://www.open-std.org/jtc1/sc22/WG14/www/docs/n1570.pdf
>
> > Let me explain the reasons behind the selected approach, once more.
> >
> > The data->dev is a pointer within a static declared struct. Are you
> > sure it's assigned NULL by initialization? Don't we explicitly need to
> > set it to NULL, else it will be undefined, no?
>
> http://www.open-std.org/jtc1/sc22/WG14/www/docs/n1570.pdf
>
> 6.7.9 (10) page 140

Thanks for sharing, didn't know we could rely on this behaviour! Alright!

>
> > Of course, I can move the check for psci_has_osi_support() into here
> > and avoid calling psci_dt_attach_cpu(). Just wondering what that
> > actually gain us, especially if we need to explicitly set the pointer
> > to NULL anyway.
>
> See above.

Yes, makes more sense now. I will adopt your suggestions!

Kind regards
Uffe

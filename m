Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88373C250D
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 15:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhGINiQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 09:38:16 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:37398 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhGINiQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jul 2021 09:38:16 -0400
Received: by mail-vs1-f48.google.com with SMTP id r24so5586119vsg.4;
        Fri, 09 Jul 2021 06:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OUiqj2pYTGVyg1F1p+Q8pmS2dnsNzJeVHf3KG5X20wg=;
        b=XjHisf4qg3TCTn3WcaJbRt4EVJUUy3jGdDLmV1E0PwdNTOBcTUQvzf5a8ul/EL3v7B
         UuFViMfkpXpfPcx0d2rW80VTbbh5GDNEAghqcsQX8yKWDJ2bOgZjniCR0J1u4qZTdqPj
         1/jkOF/w3vf3ACXO0yk4AXETjcOAHaqg0tJH8zhvthye0DqRLqr8vU/aENzF+PWWUIBb
         LKBjAJRxHTiAMv4sKG3u2GLqJJuDSeMZ+WynMGNuym60oQb0pN8fCjAIsWbCXpDFIaJs
         i/xxeaN0w2zPSN7ONX8sOrO2ZCX92bK66gwuIbqG1JiRz5E4Z8nzLps/wElZJJShHg1o
         fMHw==
X-Gm-Message-State: AOAM530ZaVQMS9PcU5Y3zkhBnsCPcgemu4O5ZAP7NgpsB+/yNP1gPW99
        AnGpzVCACf7w7+FFrZ1EZzFr/+6w/0/okSVdoKo1YtN2
X-Google-Smtp-Source: ABdhPJxM/JyMhRD9CSimazxzd59RsvjtRZR0DAJ4dLzHufpl+XBlyFvG7dBHEpWm9B5g+YVuWo7F24RWbPHvRr+VyRI=
X-Received: by 2002:a67:db05:: with SMTP id z5mr37100117vsj.18.1625837731846;
 Fri, 09 Jul 2021 06:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210709125611.135920-1-ulf.hansson@linaro.org>
 <CAMuHMdU0AVFVb3tXW4wkEibSx50nzYKW1GopgZPfKp1SS7Mf1g@mail.gmail.com> <CAPDyKFpzw0mQPFs-jyMX=T6WpZ+vFqrWmoKUWD+9wW8LWqyHuA@mail.gmail.com>
In-Reply-To: <CAPDyKFpzw0mQPFs-jyMX=T6WpZ+vFqrWmoKUWD+9wW8LWqyHuA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 9 Jul 2021 15:35:20 +0200
Message-ID: <CAMuHMdWcvAeeif6HwBMrQUs2z+jKcfY1DuKRYeyB+GTkiXGjSw@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Don't attach a device to genpd that
 corresponds to a provider
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ulf,

On Fri, Jul 9, 2021 at 3:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Fri, 9 Jul 2021 at 15:07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Jul 9, 2021 at 2:56 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > According to the common power domain DT bindings, a power domain provider
> > > must have a "#power-domain-cells" property in its OF node. Additionally, if
> > > a provider has a "power-domains" property, it means that it has a parent
> > > domain.
> >
> > OK.
> >
> > > It has turned out that some OF nodes that represents a genpd provider may
> > > also be compatible with a regular platform device. This leads to, during
> > > probe, genpd_dev_pm_attach(), genpd_dev_pm_attach_by_name() and
> > > genpd_dev_pm_attach_by_id() tries to attach the corresponding struct device
> > > to the genpd provider's parent domain, which is wrong. Instead the genpd
> >
> > Why is that wrong?
>
> It may lead to that the struct device that corresponds to a genpd
> provider may be attached to the parent domain. In other words, the
> parent domain will not only be controlled by a child domain
> (corresponding to the provider), but also through the provider's
> struct device. As far as I can tell, this has never been the intent
> for how things should work in genpd.

Ah, you're worried about the case where the subdomain is a child of
the parent domain, but the actual subdomain controller (represented
by the platform device) isn't?

> So wrong or not, I guess it depends on what you expect to happen.
>
> Do you see an issue with changing this?

I don't have any hardware where the DTS describes a node as being
both a power domain consumer and a provider.
SH/R-Mobile uses a nested domain description in DT, but there are
no platform devices created for the nested child domains, only for
the top domain.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

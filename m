Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501B844B1B1
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 18:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240700AbhKIRGW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 12:06:22 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:41804 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239427AbhKIRGV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Nov 2021 12:06:21 -0500
Received: by mail-oi1-f171.google.com with SMTP id u74so13643196oie.8
        for <linux-pm@vger.kernel.org>; Tue, 09 Nov 2021 09:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C+3ltFQ3r9iQ7mC89FPKjfx4PssCHawRnGnwDT6M9nQ=;
        b=X2mIWfJ/AVt8hOGjHCKqM1BdbtUPoHLGlIKnn+er/FaUgtXN/eqAuAUT6mB997vROm
         8eNu/V2S6Mei4e97XibUhQdhzEzh95Sdnx+vEjYFDDeWkGfaYJ7VrMDIoEyEKp0pTDx2
         dTo9ZG45VdaE0aDqQcZCsMJ0YENgIKcHiaahoD8sSsErfXoiFMRSkNfrp6KsEzJYse8o
         Y+xKs/eYo4XJ3toI2i1pEgXwyDpMYzKiPjXth+dEpAqsonwK/T5ulGl4ahcfbkmG8L0J
         Ftdb0xS+eFYSuCFi4znww7pIGtIJlZ4rsMXhadqFVe1nMl6oEteb5JjyfoDV5XAqxSdw
         u7sA==
X-Gm-Message-State: AOAM530os9jcHbXGbG0VFUEq0XI3er627L49z/jVSpekBO1gepqhukmQ
        lZekA4+p+1/LqYkMfPN7pZGXlIj+3Ej2YxHkxS0=
X-Google-Smtp-Source: ABdhPJzOAoTUBCObqBAesrwj1daPWLyx9xcmNt4wh7VlNsXpL1WYTNti/WlhBOKd+5nBRuwBAwRIb0zAmfds6tyBPHY=
X-Received: by 2002:a05:6808:14d0:: with SMTP id f16mr7024036oiw.51.1636477415021;
 Tue, 09 Nov 2021 09:03:35 -0800 (PST)
MIME-Version: 1.0
References: <20211102035847.52yvfw4ywbxrtqhf@vireshk-i7> <CAJZ5v0inzRNAU3SAFahmobEkudHgzRETWHPZED4jgcBFN9S5Xg@mail.gmail.com>
 <20211108033736.dxybjouoepofgdnl@vireshk-i7>
In-Reply-To: <20211108033736.dxybjouoepofgdnl@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Nov 2021 18:03:23 +0100
Message-ID: <CAJZ5v0ixi5XV7g2HNS-Y3E39WMzPkQSJYccp+oOqbmOSbwYAQg@mail.gmail.com>
Subject: Re: OPP updates for 5.16-rc1
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 8, 2021 at 4:37 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 02-11-21, 17:55, Rafael J. Wysocki wrote:
> > On Tue, Nov 2, 2021 at 4:58 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > Hi Rafael,
> > >
> > > This pull request contains following changes:
> > >
> > > - Fix return value of _opp_add_static_v2() helper (YueHaibing).
> > >
> > > - Fix required-opp handle count (Pavankumar Kondeti).
> > >
> > > - Resource managed OPP helpers, type update to
> > >   dev_pm_opp_attach_genpd() and update to their devfreq users, and
> > >   minor DT binding change (Dmitry Osipenko).
> > >
> > > Thanks.
> > >
> > > --
> > > Viresh
> > >
> > > -------------------------8<-------------------------
> > >
> > > The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> > >
> > >   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
> > >
> > > for you to fetch changes up to 7ca81b690e598fdf16a6c738a466247ef9be7ac7:
> > >
> > >   dt-bindings: opp: Allow multi-worded OPP entry name (2021-11-02 09:25:05 +0530)
> >
> > Pulled, thanks!
>
> I don't see this in pm/linux-next.

Because I didn't push it out, sorry.

Will be included in my next PR.

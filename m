Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A8F3C23FB
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 15:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhGINJq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 09:09:46 -0400
Received: from mail-vs1-f47.google.com ([209.85.217.47]:35513 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhGINJo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jul 2021 09:09:44 -0400
Received: by mail-vs1-f47.google.com with SMTP id h18so5551172vsj.2;
        Fri, 09 Jul 2021 06:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f9K50uqbO+OiOIh+y9BZ3Xord6eCTGCDJbMPLK8l0eg=;
        b=EBEZzyR5U25hGognpAacPuMnX++dEbyHcSCf42Vk8NX4PGKN5e++z8eG8rdmDXvtLB
         wyN+OOzzgdhAx7e/iQw0wi9RrEKRTkG+yrqCfK3wv/kAfin/Vruih22OnH5Urw9s8/hz
         mXnuWREJRyEClrnZ90ovEBfUL3iOntHIn5cBQoeTDsU4SBW3qZpv+quV3S2jInhhpHPA
         hlAYKYTFRmJCXJK18a+9c3N4eMKT/ORECvGF3Q1MrGMvFmgnmVhVTBtehGXcs267hU/N
         f6RwM/J8yO9GOryHcpZraUNqxSAsK3yUshwUnN5laLlaPIX7R7EfkwXNrpf1FmC6Ei0k
         YEmQ==
X-Gm-Message-State: AOAM5319YE4ujcfL0NrJPFIy6n3r3r+kf6nvfj7XE7v24JpHyVisji1s
        dzqy0X0aYAUxGVhNjteTX8jk87gmzArGb+4EQKU=
X-Google-Smtp-Source: ABdhPJx3ZIltFRr1pc6I8+WpbqTDhmio+F0DH8vBQADE5fqcKRACpSnhwHDQdnzBNzZeeKxVuaR7iUkPgKNj5sKN05c=
X-Received: by 2002:a67:f98c:: with SMTP id b12mr36045844vsq.40.1625836019416;
 Fri, 09 Jul 2021 06:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210709125611.135920-1-ulf.hansson@linaro.org>
In-Reply-To: <20210709125611.135920-1-ulf.hansson@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 9 Jul 2021 15:06:48 +0200
Message-ID: <CAMuHMdU0AVFVb3tXW4wkEibSx50nzYKW1GopgZPfKp1SS7Mf1g@mail.gmail.com>
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

Thanks for your patch!

On Fri, Jul 9, 2021 at 2:56 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> According to the common power domain DT bindings, a power domain provider
> must have a "#power-domain-cells" property in its OF node. Additionally, if
> a provider has a "power-domains" property, it means that it has a parent
> domain.

OK.

> It has turned out that some OF nodes that represents a genpd provider may
> also be compatible with a regular platform device. This leads to, during
> probe, genpd_dev_pm_attach(), genpd_dev_pm_attach_by_name() and
> genpd_dev_pm_attach_by_id() tries to attach the corresponding struct device
> to the genpd provider's parent domain, which is wrong. Instead the genpd

Why is that wrong?

> provider should only assign a parent domain, through
> pm_genpd_add_subdomain() or of_genpd_add_subdomain().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

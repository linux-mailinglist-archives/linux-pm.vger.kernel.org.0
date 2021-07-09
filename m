Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4043C2535
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 15:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhGINtq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 09:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhGINtp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jul 2021 09:49:45 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C442C0613DD
        for <linux-pm@vger.kernel.org>; Fri,  9 Jul 2021 06:47:02 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so9446610otp.8
        for <linux-pm@vger.kernel.org>; Fri, 09 Jul 2021 06:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=38a/yCpbQAizTxxVhAWoHLTK7GmscFo2zxp/hlBhAY0=;
        b=hccc6SOQX1eh5P8oYfPB8i3ozA15dcvlUzJhM7Gp7HgNFjv9fsaRB/U+ioGrZqHiyy
         +vNppbXokExhJLY+Zcd0boh+LtTeJ0SJsiKVTrrZr2IkdzPkW3T7M95DGIQI9YZ/bV7Y
         I725++7CIkYoXnxt6SXXblbSqQhxsNd67L+JEtNF6NgYYpfplwG/DVvQCLwadnaEsxwK
         uIf6UdGWXmdeou3Ojt0SUtV40dDQKyuDYb9SCb9LPVG1y1g4QREu2hy8m3Ad0P6GkX6K
         dznBGWTtmxRKLf0TL7/cVhZfWjVruimCIgp8s54JsFZMy6x3BIlZEXY9rCLeuwgnicSa
         T5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=38a/yCpbQAizTxxVhAWoHLTK7GmscFo2zxp/hlBhAY0=;
        b=Q0blNXbUnn5d5yZmEvSh8MH4lTHzrzpJgo5d3a4Q5fOZSk+NCEyA+F6PVCjhPDVZQW
         DYH9rv9et9bm7BDYdy4yPTd30X5wcMVgayTrYjXgyxhwmdR5x9mkBzFMEA+JbX390tUn
         bcPhKAHh9LVr0XX1FPWhwm7AJgHSYSwjJkwMxFE0qhrG88+L9gZ9JfDKx8mVsCtqBeGq
         dIxtbo/hUESVf8mH8XOLcWvCNJ1ES96Hi/cK7aqsCUzViRcuhgViabu8J/am3DpCU90z
         lCkGNiPJoxnHJX4Fd8Gh5sXHEptjaU3EJhTU0CDkwSFTk/LULUgr24FdeEVk6ne+G8HE
         lm7w==
X-Gm-Message-State: AOAM532/22aCITi18k7u7k0alil3kQBVTzrnPXejPkM2P0O74gLuAk/k
        I5pMTbDvCdHbFbDdWx/YU/t+qw==
X-Google-Smtp-Source: ABdhPJwraxoH0jzrSTn2TqqqaypAHWkDVPLbZ7rjvlNevDkK3QG5DITzaGqgBgsldFWltfGr5/BVQA==
X-Received: by 2002:a05:6830:4022:: with SMTP id i2mr24250054ots.9.1625838421644;
        Fri, 09 Jul 2021 06:47:01 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p15sm1153341oth.1.2021.07.09.06.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 06:47:01 -0700 (PDT)
Date:   Fri, 9 Jul 2021 08:46:59 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM: domains: Don't attach a device to genpd that
 corresponds to a provider
Message-ID: <YOhTU0xUShJQXrL5@yoga>
References: <20210709125611.135920-1-ulf.hansson@linaro.org>
 <CAMuHMdU0AVFVb3tXW4wkEibSx50nzYKW1GopgZPfKp1SS7Mf1g@mail.gmail.com>
 <CAPDyKFpzw0mQPFs-jyMX=T6WpZ+vFqrWmoKUWD+9wW8LWqyHuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpzw0mQPFs-jyMX=T6WpZ+vFqrWmoKUWD+9wW8LWqyHuA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 09 Jul 08:22 CDT 2021, Ulf Hansson wrote:

> On Fri, 9 Jul 2021 at 15:07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Ulf,
> >
> > Thanks for your patch!
> >
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
> 
> So wrong or not, I guess it depends on what you expect to happen.
> 
> Do you see an issue with changing this?
> 

But this exactly what we have in the case of the "dispcc" in the
Qualcomm platform that Dmitry is working on.

The provider driver needs the parent power-domain to be powered in order
to poke the registers and then it is the parent of the power-domains
exposed.

If I understand your proposed patch we'll have to manually attach the
parent domain to the struct device of the controller with this patch?

Is the Qualcomm case unique or will this change cut power do other genpd
providers assuming the same?



Worth mentioning as we discuss this is that we have another genpd
provider, where I think the exposed genpds are parented by a few
different (each one with a specific) parent domains. In this case we'd
be forced to manually attach the genpd provider to the parent domain
that it actually is powered by (as no automatic attachment happens when
multiple domains are specified).

Regards,
Bjorn

> >
> > > provider should only assign a parent domain, through
> > > pm_genpd_add_subdomain() or of_genpd_add_subdomain().
> 
> Kind regards
> Uffe

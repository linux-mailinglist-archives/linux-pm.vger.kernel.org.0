Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8AD3B74DC
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jun 2021 17:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhF2PMD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Jun 2021 11:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbhF2PMC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Jun 2021 11:12:02 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C816DC061767
        for <linux-pm@vger.kernel.org>; Tue, 29 Jun 2021 08:09:34 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id s17so26703932oij.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Jun 2021 08:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wLi/ReYn+FMDqDclGBkonZrrzMrcsqsuKIgDcZh360Y=;
        b=BL7L2hE2loKs368r+ee+AI+RlZZQa58t+tkSRnZlRGSaJ+h1nwfmNe8qnpI0zT5yCu
         efdo6KHJrCsi8Oddswo+Fmcl8Fmh9ugakIP6DDUbft4mM9PAjcYe7Pv8Zej8EapJLd4t
         2EWK+aYAs/Q/S9Nu9kWhpMvK+BG4nfyPb8n9z0Z6DxqOVDFk4Mk/9/cgNJkrSxujQx63
         CVVqY1JQrFRGLIJ9mYP28NePKFU56iPb3MXt75DAHRZtWk1MIlxqBpxdrjaJIkHcCwsq
         xXYAqN+k3tV9BY9WWwW7lpfaC05EjLy49KDyzdZlHm+z4yt3/p3//k/namH03wOp8uCi
         32Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wLi/ReYn+FMDqDclGBkonZrrzMrcsqsuKIgDcZh360Y=;
        b=dugKrI82U15Ct3pY5s/JqY9yI/qT5JOGJuNmKtydX7cvhgMyLCS7VrgOR03koiYl6O
         mlE83YzxyFVtAjH7vFTz8806uScoAG5IUGUiG4J4Uz59z1oI34ymopZW4BzKqh21BSxz
         ca7TQpLG9STmFusmrANHrCnxaEZxIbCHGrsgBvBf6uLAFeIMj9YCIjz5cb5zw3rRZ9ls
         ukqeY8bJoxzPfqb5qf00kRLXipS1F+YTnbgD3I/NjAEKSSwrwY/FGmYxSzD+9h/9VIpZ
         z9A0/WkzjgCSCgMx39dZBpfSCPs//z6Imd9APdWajp6umGehOiJ+zFP8l9QXYPeinrHj
         cy5A==
X-Gm-Message-State: AOAM532YZY2yFENQobCDD/BThCBdzu0x+qaAuzo4CN3/zYDFVpJFe1Y7
        NAbf90bqQzF02FvhvIVwND3P0A==
X-Google-Smtp-Source: ABdhPJxa4uFuLShu97+yl5YJNgfKvOyAkVnMa60KVmDH49ai7iZpoup4XpN5W8AIj2bcCjCigHsnug==
X-Received: by 2002:aca:5dc6:: with SMTP id r189mr25530559oib.164.1624979374103;
        Tue, 29 Jun 2021 08:09:34 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 94sm4139981otj.33.2021.06.29.08.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 08:09:33 -0700 (PDT)
Date:   Tue, 29 Jun 2021 10:09:31 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH 2/2] PM: domain: use per-genpd lockdep class
Message-ID: <YNs3q0HI1WKrKOXx@yoga>
References: <20210611101540.3379937-1-dmitry.baryshkov@linaro.org>
 <20210611101540.3379937-3-dmitry.baryshkov@linaro.org>
 <CAPDyKFo5mUZZcPum9A5mniYSsbG2KBxqw628M622FaP+piG=Pw@mail.gmail.com>
 <CAA8EJprSj8FUuHkFUcinrbfd3oukeLqOivWianBrnt_9Si8ZRQ@mail.gmail.com>
 <CAPDyKFoMC_7kJx_Wb4LKgxvRCoqHYFtwsJ2b7Cr4OvjA94DtHg@mail.gmail.com>
 <YMjNaM0z+OzhAeO/@yoga>
 <CAPDyKFo_eNwEx5rryg3bHt_-pxBeeYfVrUZuTOHoL-x94LBwDA@mail.gmail.com>
 <c6e99362-56c1-f2bd-7170-7b001e0f96fe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6e99362-56c1-f2bd-7170-7b001e0f96fe@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 28 Jun 14:55 CDT 2021, Dmitry Baryshkov wrote:

> Hi,
> 
> On 17/06/2021 12:07, Ulf Hansson wrote:
> > + Rajendra
> > 
> > On Tue, 15 Jun 2021 at 17:55, Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
[..]
> > > But I am unable to find a way for the gdsc driver to get hold of the
> > > struct generic_pm_domain of the resources exposed by the rpmhpd driver.
> > 
> > You don't need a handle to the struct generic_pm_domain, to assign a
> > parent/child domain. Instead you can use of_genpd_add_subdomain(),
> > which takes two "struct of_phandle_args*" corresponding to the
> > parent/child device nodes of the genpd providers and then let genpd
> > internally do the look up.
> 
[..]
> 
> I think I'd need this function anyway for the gdsc code. During gdsc_init()
> we check gdsc status and this requires register access (and thus powering on
> the parent domain) before the gdsc is registered itself as a power domain.
> 

But this is a register access in the dispcc block, which is the context
that our gdsc_init() operates. So describing that MMCX is the
power-domain for dispcc should ensure that the power-domain is enabled.

We do however need to make sure that dispcc doesn't hog its
power-domain, and that any register accesses in runtime is done with the
parenting power-domain enabled. E.g. the clock framework wraps all
operations in pm_runtime_get/put(), but I don't see anything in the
gnepd code for this.


And for gcc I'm worried that we might have some GDSCs that are parented
by CX and some by MX, but I do still think that the register accesses
are only related to one of these.

But this seems like a continuation of the special case in dispcc, so I
think we should be able to focus on getting that right before we attempt
the general case (and I don't know if we have a need for this today).

Regards,
Bjorn

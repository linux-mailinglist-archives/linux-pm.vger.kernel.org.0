Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493B6349AB5
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 20:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhCYTyx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Mar 2021 15:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhCYTyS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Mar 2021 15:54:18 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD39C06174A;
        Thu, 25 Mar 2021 12:54:17 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id l3so3145265pfc.7;
        Thu, 25 Mar 2021 12:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2ox+lIoJoyg3Q3+HzxwjBXbGMuN52vbWPLtA7Qub7kg=;
        b=NFFwY8zQIwhkcU272Jm/tvrxR+e+zdpyEFg4BFxEIeC0Do8kt5hzS8pjCkG0kksnca
         AQyFQCGKeMbBqTUbaDz1DUHSbSlp+n7gnBE4n0to9D2ow9IL1MQcwH3/Jf+GINov9i85
         Xwbd+Rsh8KJHTUXXkrs93L4csDQUgnmlAylNYPrmzk5vVitnDmhXxzHX2dPEjykP7kRU
         pr8wY/5/CWCEzS8UHs/jHX3BJbFs/QxBblckmUyXwXCY6qi5kS/J3FTrs8jHysobQJ7d
         InuZk93Q76uhlfwAAzMb9L5cuqm6yGSZPAQf15W2LnCtfPWMbvANGjmM+rvm+bWmSjkv
         KsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2ox+lIoJoyg3Q3+HzxwjBXbGMuN52vbWPLtA7Qub7kg=;
        b=n2etdgYrscEaGbYWJ1VpRoRD9Jl5He3MBd0gMed6GUa0oDwjqUMwL4ZZEAS3O0gDMF
         o8NDJvedqNuevXAlbK0EJfwzAAYFb+pFufQD/a8MXfX6oLASXbt3t9QUgrq/zozF+5U8
         JZZhFDNkeN3FnjA/+aMJoE82mP6bSw4M1luoZjUkf0sqH8pYNOpm92+kSqzFioNHVdMa
         YDvLQolrYKUc6roLNUyNvk9dCO/2L7zOYdAeAb+DleNBBtIZBFrvNzsviElJelwjKqpO
         vLb8tu62EIVI9cof5egwxuiUEjQJwkbAjDFXjhYC7smV8MGdR8Za1Bv0dnzpySyaKeuR
         dA/w==
X-Gm-Message-State: AOAM530KPqZOz/S3xz57BZ2TS4mxamBgGZSLF9bkL0goj07Ae6mtGL1/
        SxGzjeTdyNguiiNtn1vaLohGU7awhv8=
X-Google-Smtp-Source: ABdhPJxlh1ihYtFSa2hkxdYyopMatC6jbdD80SMQE858q/3DidikvgrkbhDcaZEG7YAKz8XeBYnEng==
X-Received: by 2002:a17:902:8ec9:b029:e6:c5e:cf18 with SMTP id x9-20020a1709028ec9b02900e60c5ecf18mr11465115plo.47.1616702057095;
        Thu, 25 Mar 2021 12:54:17 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:3991:e59d:d2d4:59dd])
        by smtp.gmail.com with ESMTPSA id p1sm6576942pfn.22.2021.03.25.12.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 12:54:15 -0700 (PDT)
Date:   Thu, 25 Mar 2021 12:54:12 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [GIT PULL] Immutable branch between MFD and Input due for the
 v5.13 merge window
Message-ID: <YFzqZJeYd4nkF89C@google.com>
References: <cover.1611653995.git.cristian.ciocaltea@gmail.com>
 <20210309135302.GP4931@dell>
 <20210309200417.GZ4931@dell>
 <20210310111250.GM701493@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310111250.GM701493@dell>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lee,

On Wed, Mar 10, 2021 at 11:12:50AM +0000, Lee Jones wrote:
> On Tue, 09 Mar 2021, Lee Jones wrote:
> 
> > On Tue, 09 Mar 2021, Lee Jones wrote:
> > 
> > > Enjoy!
> > > 
> > > The following changes since commit fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8:
> > > 
> > >   Linux 5.12-rc1 (2021-02-28 16:05:19 -0800)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-input-v5.13
> > > 
> > > for you to fetch changes up to b58c808ca46c163c1924ec5d3285e67e9217ec74:
> > > 
> > >   MAINTAINERS: Add entry for ATC260x PMIC (2021-03-09 13:50:39 +0000)
> > > 
> > > ----------------------------------------------------------------
> > > Immutable branch between MFD and Input due for the v5.13 merge window
> > > 
> > > ----------------------------------------------------------------
> > > Cristian Ciocaltea (4):
> > >       dt-bindings: input: Add reset-time-sec common property
> > >       dt-bindings: mfd: Add Actions Semi ATC260x PMIC binding
> > >       mfd: Add MFD driver for ATC260x PMICs
> > >       input: atc260x: Add onkey driver for ATC260x PMICs
> > > 
> > > Manivannan Sadhasivam (1):
> > >       MAINTAINERS: Add entry for ATC260x PMIC
> > > 
> > >  Documentation/devicetree/bindings/input/input.yaml |   7 +
> > >  .../devicetree/bindings/mfd/actions,atc260x.yaml   | 183 ++++++++++++
> > >  MAINTAINERS                                        |  12 +
> > >  drivers/input/misc/Kconfig                         |  11 +
> > >  drivers/input/misc/Makefile                        |   2 +-
> > >  drivers/input/misc/atc260x-onkey.c                 | 305 ++++++++++++++++++++
> > >  drivers/mfd/Kconfig                                |  18 ++
> > >  drivers/mfd/Makefile                               |   3 +
> > >  drivers/mfd/atc260x-core.c                         | 310 +++++++++++++++++++++
> > >  drivers/mfd/atc260x-i2c.c                          |  64 +++++
> > >  include/linux/mfd/atc260x/atc2603c.h               | 281 +++++++++++++++++++
> > >  include/linux/mfd/atc260x/atc2609a.h               | 308 ++++++++++++++++++++
> > >  include/linux/mfd/atc260x/core.h                   |  58 ++++
> > >  13 files changed, 1561 insertions(+), 1 deletion(-)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
> > >  create mode 100644 drivers/input/misc/atc260x-onkey.c
> > >  create mode 100644 drivers/mfd/atc260x-core.c
> > >  create mode 100644 drivers/mfd/atc260x-i2c.c
> > >  create mode 100644 include/linux/mfd/atc260x/atc2603c.h
> > >  create mode 100644 include/linux/mfd/atc260x/atc2609a.h
> > >  create mode 100644 include/linux/mfd/atc260x/core.h
> > 
> > FYI, if anyone has pulled this, they should probably rebase it onto
> > v5.12-rc2 and delete the v5.12-rc1 tag from their tree:
> > 
> >  https://lwn.net/Articles/848431/
> 
> In case you haven't pulled this yet, I created a new tag:
> 
>   ib-mfd-input-v5.13-1

Did you push this one out? I can't seem to see it.

Thanks.

-- 
Dmitry

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3777F34A319
	for <lists+linux-pm@lfdr.de>; Fri, 26 Mar 2021 09:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhCZISw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Mar 2021 04:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhCZISc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Mar 2021 04:18:32 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59911C0613B1
        for <linux-pm@vger.kernel.org>; Fri, 26 Mar 2021 01:18:32 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id j3so5272598edp.11
        for <linux-pm@vger.kernel.org>; Fri, 26 Mar 2021 01:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vVLQWWeMoRmy2aS3RBI+QxFkLC7vNLSa/8Kp82BB7/4=;
        b=gUYuFDRcjU9OiTVCehZRUVHb9veVGV44Qt6mPlJufVM07cUE3yvOUc12UGbhkgeN07
         WUk/1zb97PfNyw9MGEad8MJ9CUP61chVPD07wwN2tI95nEQUOp9MQ2XhHtdPOe9DQoYK
         4VS3iHs7sMptpkEfwaldIqidr+NpZm1vB+K2y4BV2j2FQrH0ehS22nTy8FNod0scrdIm
         84RoaJnhI2k5kL6G9d45P2rZwOT8m/0QhLlq1Wit7ie2fMhSK7Ozf3g7G1vtDHWuLtDd
         qz/ERkzKu8O8KNVEKjv3LlykUoN7ZT8PVwzs6RfiECA4TRx38+q0AMaMS9eyWfpXE8qs
         wZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vVLQWWeMoRmy2aS3RBI+QxFkLC7vNLSa/8Kp82BB7/4=;
        b=fKmhwYDgDUivE4m+vxmI0dMQCAwb2jmD5tKakMfEJ57ycdN10viSrQL+ZMSGMokj35
         HipdyI0suUXi74RkwCuZJUbhlGnrasJdHRSQNA/ZcQQv/8LHfOymFIgHXc/oYEsJSi48
         noQPZiEHYRIArGsx8JbKX+vieblfRFmJEQaMP/XTuZIULB4E5YNPG6Cmf9GD56eq66Ni
         f3G3RHGsMRGvEN2whIYAIkW3+PtIOgeKmR0paa9HhSpdrWPbNssKQcyojalRCqhO5ou3
         I2JbU4AoDLhBwkylKgiWu7m0/RLmSTUpHrEYQtTGWT4vlSKKcGCWzr0CYkoV9cPvkwtG
         frsg==
X-Gm-Message-State: AOAM5305Vg62qg+g/f2ccYWjy3+GJBj1jta60bsrG02JJFz749Vj7yBD
        7vYQGcUok/V7lZDQKGkHNiZFZA==
X-Google-Smtp-Source: ABdhPJyGvc/Q1q6OUIMDE/e3r3sj4QZPNY5A/ebMa3M5iZJ8Q+P0SzWmEAmyp6Q4hUaxIAjyVBMRIg==
X-Received: by 2002:a05:6402:1855:: with SMTP id v21mr13579580edy.310.1616746711012;
        Fri, 26 Mar 2021 01:18:31 -0700 (PDT)
Received: from dell ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id m10sm3495486ejx.10.2021.03.26.01.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 01:18:30 -0700 (PDT)
Date:   Fri, 26 Mar 2021 08:18:28 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
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
Message-ID: <20210326081828.GY2916463@dell>
References: <cover.1611653995.git.cristian.ciocaltea@gmail.com>
 <20210309135302.GP4931@dell>
 <20210309200417.GZ4931@dell>
 <20210310111250.GM701493@dell>
 <YFzqZJeYd4nkF89C@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YFzqZJeYd4nkF89C@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 25 Mar 2021, Dmitry Torokhov wrote:

> Hi Lee,
> 
> On Wed, Mar 10, 2021 at 11:12:50AM +0000, Lee Jones wrote:
> > On Tue, 09 Mar 2021, Lee Jones wrote:
> > 
> > > On Tue, 09 Mar 2021, Lee Jones wrote:
> > > 
> > > > Enjoy!
> > > > 
> > > > The following changes since commit fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8:
> > > > 
> > > >   Linux 5.12-rc1 (2021-02-28 16:05:19 -0800)
> > > > 
> > > > are available in the Git repository at:
> > > > 
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-input-v5.13
> > > > 
> > > > for you to fetch changes up to b58c808ca46c163c1924ec5d3285e67e9217ec74:
> > > > 
> > > >   MAINTAINERS: Add entry for ATC260x PMIC (2021-03-09 13:50:39 +0000)
> > > > 
> > > > ----------------------------------------------------------------
> > > > Immutable branch between MFD and Input due for the v5.13 merge window
> > > > 
> > > > ----------------------------------------------------------------
> > > > Cristian Ciocaltea (4):
> > > >       dt-bindings: input: Add reset-time-sec common property
> > > >       dt-bindings: mfd: Add Actions Semi ATC260x PMIC binding
> > > >       mfd: Add MFD driver for ATC260x PMICs
> > > >       input: atc260x: Add onkey driver for ATC260x PMICs
> > > > 
> > > > Manivannan Sadhasivam (1):
> > > >       MAINTAINERS: Add entry for ATC260x PMIC
> > > > 
> > > >  Documentation/devicetree/bindings/input/input.yaml |   7 +
> > > >  .../devicetree/bindings/mfd/actions,atc260x.yaml   | 183 ++++++++++++
> > > >  MAINTAINERS                                        |  12 +
> > > >  drivers/input/misc/Kconfig                         |  11 +
> > > >  drivers/input/misc/Makefile                        |   2 +-
> > > >  drivers/input/misc/atc260x-onkey.c                 | 305 ++++++++++++++++++++
> > > >  drivers/mfd/Kconfig                                |  18 ++
> > > >  drivers/mfd/Makefile                               |   3 +
> > > >  drivers/mfd/atc260x-core.c                         | 310 +++++++++++++++++++++
> > > >  drivers/mfd/atc260x-i2c.c                          |  64 +++++
> > > >  include/linux/mfd/atc260x/atc2603c.h               | 281 +++++++++++++++++++
> > > >  include/linux/mfd/atc260x/atc2609a.h               | 308 ++++++++++++++++++++
> > > >  include/linux/mfd/atc260x/core.h                   |  58 ++++
> > > >  13 files changed, 1561 insertions(+), 1 deletion(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
> > > >  create mode 100644 drivers/input/misc/atc260x-onkey.c
> > > >  create mode 100644 drivers/mfd/atc260x-core.c
> > > >  create mode 100644 drivers/mfd/atc260x-i2c.c
> > > >  create mode 100644 include/linux/mfd/atc260x/atc2603c.h
> > > >  create mode 100644 include/linux/mfd/atc260x/atc2609a.h
> > > >  create mode 100644 include/linux/mfd/atc260x/core.h
> > > 
> > > FYI, if anyone has pulled this, they should probably rebase it onto
> > > v5.12-rc2 and delete the v5.12-rc1 tag from their tree:
> > > 
> > >  https://lwn.net/Articles/848431/
> > 
> > In case you haven't pulled this yet, I created a new tag:
> > 
> >   ib-mfd-input-v5.13-1
> 
> Did you push this one out? I can't seem to see it.

Seemingly not.  Thanks for the poke.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

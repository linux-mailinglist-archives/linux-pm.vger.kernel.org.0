Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60C3510CF95
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 22:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfK1Vno (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 16:43:44 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43061 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfK1Vno (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 16:43:44 -0500
Received: by mail-pg1-f194.google.com with SMTP id b1so13400364pgq.10
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2019 13:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K9FrLAOFp0g+hrdsabPVchjdViFjj8h0GNkeqZ4HQlM=;
        b=kZeh47RNC2BtHUa2wCS8rsZONatpvYYLR3K646pyo72NUYaJ/cDpbMeVmz5Yvj0lCo
         1g50TyX6V1STK60yAw+cgJZzEYfha6eRSBmYJKBnzZxOAzADErDowc173BZOHaPbENxU
         6XEK3SKBHCw4edPwidyFtxBU1GPm2Fc8/d6gF9GtscAYtRINmE3LoMEADij0to1zXv/u
         FDHww8EWCZu4DbibNnBJyYzbZkmBFEpKsZesGrvC9mPqVDMSsSLkonwZ+WIsJUl0grPT
         fpQubcqqSy7C7c9k6rCEm4zTvqF7lbdNMowTyWWA8U6O6FQ1eYS//74MurZ87a9CHWGH
         dCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K9FrLAOFp0g+hrdsabPVchjdViFjj8h0GNkeqZ4HQlM=;
        b=nKsHneh8jQr1t6GT0LYlxmaOLvFzOlMx7j1GZE8iM1r3SdBbsgljmsrMilnfjDOnvr
         rTG5wuB+jE8njzdcMUf2Me1nmlgO+Pjzp0ZpmZt2yfUZk1RBXABBJ4suHuJtEecTlcxO
         Aux2KgvYgrt6doqi5uSK61DzAOeHpFI2ypFUQgZSz/Z7beiuuQ7FcnOH1ABz3JtNDh0t
         xRP1zisT6RjdI0n+dC1GEaB75h0J4Ag/OiUKRo05JT+tvCiGvrEQz8EfMzhV3P2stIdT
         MVWVl1E1JJQ6dkhMkVBHJaq233TZN5/CbPJMyL7TnrGHtGG6qhnWmWt7KKJd1vBRjm6L
         0Q0g==
X-Gm-Message-State: APjAAAXTFIjYKdmKPaYeD7O2IBzkUpObOwTFj87pj8NGMtebAYsqpobX
        Xh1nyuEk+/ktRJJbJv4tqt/aRA==
X-Google-Smtp-Source: APXvYqxXK5VlxZHgjn3ehpw/1a/UvQMzGfyMHy3vxqme3i6QHac5tFm6KotaQWcLg7ThtP7KXY6L6w==
X-Received: by 2002:aa7:90d0:: with SMTP id k16mr55284524pfk.131.1574977423508;
        Thu, 28 Nov 2019 13:43:43 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o23sm21753750pgj.90.2019.11.28.13.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 13:43:42 -0800 (PST)
Date:   Thu, 28 Nov 2019 13:43:39 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/3] drivers: thermal: tsens: Add critical interrupt
 support
Message-ID: <20191128214339.GL82109@yoga>
References: <cover.1573499020.git.amit.kucheria@linaro.org>
 <4b949a4f401a7f9d403ed0f0c16c7feb083f3524.1573499020.git.amit.kucheria@linaro.org>
 <20191112193852.GC3140946@builder>
 <CAHLCerN1VXhU0VQWN15PB2R16mkCV0i6Mn3+LW=xXtB5_7Z6JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLCerN1VXhU0VQWN15PB2R16mkCV0i6Mn3+LW=xXtB5_7Z6JQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 28 Nov 10:46 PST 2019, Amit Kucheria wrote:

> On Wed, Nov 13, 2019 at 1:08 AM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Mon 11 Nov 11:21 PST 2019, Amit Kucheria wrote:
> >
> > > TSENS IP v2.x adds critical threshold interrupt support for each sensor
> > > in addition to the upper/lower threshold interrupt. Add support in the
> > > driver.
> > >
> > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > ---
> > >  drivers/thermal/qcom/tsens-common.c | 129 ++++++++++++++++++++++++++--
> > >  drivers/thermal/qcom/tsens-v2.c     |   8 +-
> > >  drivers/thermal/qcom/tsens.c        |  21 +++++
> > >  drivers/thermal/qcom/tsens.h        |  73 ++++++++++++++++
> > >  4 files changed, 220 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> > > index 4359a4247ac3..2989cb952cdb 100644
> > > --- a/drivers/thermal/qcom/tsens-common.c
> > > +++ b/drivers/thermal/qcom/tsens-common.c
> > > @@ -23,6 +23,10 @@
> > >   * @low_thresh:     lower threshold temperature value
> > >   * @low_irq_mask:   mask register for lower threshold irqs
> > >   * @low_irq_clear:  clear register for lower threshold irqs
> > > + * @crit_viol:      critical threshold violated
> >
> > "violated" as in "temperature is above crit_thresh"?
> 
> Yes.
> 
> >
> > > + * @crit_thresh:    critical threshold temperature value
> > > + * @crit_irq_mask:  mask register for critical threshold irqs
> > > + * @crit_irq_clear: clear register for critical threshold irqs
> > >   *
> > [..]
> > > diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> > > index 7d317660211e..784c4976c4f9 100644
> > > --- a/drivers/thermal/qcom/tsens.c
> > > +++ b/drivers/thermal/qcom/tsens.c
> > > @@ -121,6 +121,27 @@ static int tsens_register(struct tsens_priv *priv)
> > >
> > >       enable_irq_wake(irq);
> > >
> > > +     if (tsens_version(priv) > VER_1_X) {
> > > +             irq = platform_get_irq_byname(pdev, "critical");
> > > +             if (irq < 0) {
> >
> > Treating this as a fatal error breaks backwards compatibility with
> > current devicetree; and even within your patch series, tsens should fail
> > to probe between this patch and the application of patch 3.
> 
> Good catch.
> 
> > Please flip this around and do:
> >
> > irq = platform_get_irq_byname(pdev, "critical");
> > if (irq >= 0 && tsens_version(priv) > VER_1_X) {
> >         request_irq()...
> > }
> 
> Won't this still break with current devicetree since irq < 0 until
> patch 3? Or are you saying we shouldn't check for
> platform_get_irq_byname() failure?
> 

I'm trying to say that dtsi without "critical" defined should cause the
driver to simply skip this segment, not fail to initialize.

> I can see two ways out:
> 1. We patch the dtsi before the code change.

You're expected to maintain backwards compatibility with existing dtb
files out there. The support for critical interrupt is an additional
feature, so you should be able to do this by detecting if "critical" is
defined (e.g. by checking the return value of
platform_get_irq_byname()).

> 2. We make critical interrupt failure non-fatal by just printing some
> messages and still returning success.
> 

Try to make it as specific as possible (without adding a bunch of code)
and throw in a dev_info() if no "critical" is found.

Regards,
Bjorn

> Regards,
> Amit
> 
> 
> > > +                     ret = irq;
> > > +                     goto err_put_device;
> > > +             }
> > > +
> > > +             ret = devm_request_threaded_irq(&pdev->dev, irq,
> > > +                                             NULL, tsens_critical_irq_thread,
> > > +                                             IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> > > +                                             dev_name(&pdev->dev), priv);
> > > +             if (ret) {
> > > +                     dev_err(&pdev->dev, "%s: failed to get critical irq\n", __func__);
> > > +                     goto err_put_device;
> > > +             }
> > > +
> > > +             enable_irq_wake(irq);
> > > +     }
> > > +
> > > +     return 0;
> > > +
> > >  err_put_device:
> > >       put_device(&pdev->dev);
> > >       return ret;
> >
> > Regards,
> > Bjorn

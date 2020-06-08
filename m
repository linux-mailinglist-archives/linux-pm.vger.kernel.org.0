Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821861F1888
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jun 2020 14:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgFHMLU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 08:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbgFHMLU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2020 08:11:20 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EFDC08C5C2;
        Mon,  8 Jun 2020 05:11:19 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t7so8682091pgt.3;
        Mon, 08 Jun 2020 05:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ltyhMEkISX5kr7cpVF0JSUjRPfEgCrElNZMuYmRJ7Fs=;
        b=g21KG36UQZBZgT0ff9ZNcPra0WKx8ZP3mpu6p2d0+L2Auc6tKCoucLeRxERzyK2kIw
         g3uIktUQ7uP0kXuGVWz1NBNYvV3a4bEWVmbqE3E6/NiKyFVQ4xWE/FQEGsol/4Ia0ord
         XiFwyNap2P6+nzC0MdfIXZPILjtIpbrermT9vZh5xCvr+NfyS1EsMHC21RUFgcw0pQNr
         9xfzihQYHMDi8xDrt5Q4Jpb2QOAqcqAB8Esh3Y/IvoPS44GGi8197IpU/1FFaHpgn2Yi
         4EXyr4Af+Sx/JDoXmgxQE6NIjAhVXYg9JDrwKTAe+/Tm4ua9H0kRqKgcxBqS4Lpr35rV
         0BrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ltyhMEkISX5kr7cpVF0JSUjRPfEgCrElNZMuYmRJ7Fs=;
        b=CQpomzP+NxMmG5ZuGigJcaEOCf7VKX/uuPweGNF3nY0Anzcu8np38d6Rfkd8+4/ftN
         C28yyRM15vo0F/NExDFoTSrbTUKqKuDhLNp2FhcrGa2IcvZuDi4Ym6irnAAqCEZ9XC3v
         uh8DWkIXBNXgfa+EorIKrYspbHoMlsWR8sN8s5at7+EBatNBmCwMKNpCFRgC4Gd0y9eU
         GljahWc0Lj4j8R+gqAseWjwrFn4Z4FJbRnwuG3mhaIJ/wvz80SalgxKZzOvGt+BNBUQP
         9riFkaE2Nvr6Z7Bl10yosGrveE09LddlZebI7aU3rm//RVtBdQ9pyYpys6Kn2BkLE0vC
         xKVA==
X-Gm-Message-State: AOAM530UtFj9yJs5POYcfd19UXxp+A+OnY1GRv+vnC+e9PVr4cmzAUOS
        28Eyb6lLdTleXEpFSCqvYNeWPhOJJQGbBPzMfp0=
X-Google-Smtp-Source: ABdhPJx44q8S4qifyalZWMQom7WKFwfOCX1Qrq4jLFlVgpAbO87RQMtPOuOzn6ZLUFp7twftKCnxvLma5jPZUD2HaPA=
X-Received: by 2002:a63:305:: with SMTP id 5mr19335432pgd.74.1591618279199;
 Mon, 08 Jun 2020 05:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200324175719.62496-1-andriy.shevchenko@linux.intel.com>
 <20200325032901.29551-1-saravanak@google.com> <20200325125120.GX1922688@smile.fi.intel.com>
 <295d25de-f01e-26de-02d6-1ac0c149d828@arm.com> <20200326163110.GD1922688@smile.fi.intel.com>
 <20200608091712.GA28093@pengutronix.de> <CAHp75VfQvT1VSXhNtfLMLzwYcN+4g=jVRkBHc=ZS0180BRzAJg@mail.gmail.com>
 <20200608115917.f5dhazixnxunl5o5@pengutronix.de>
In-Reply-To: <20200608115917.f5dhazixnxunl5o5@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Jun 2020 15:11:07 +0300
Message-ID: <CAHp75VcnkSrb5B8dQE-Tg=mzzUbKZkk3ykm6sxEjNyHWLcF26w@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Grant Likely <grant.likely@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        artem.bityutskiy@linux.intel.com, Felipe Balbi <balbi@kernel.org>,
        Mark Brown <broonie@kernel.org>, Ferry Toth <fntoth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
        nd <nd@arm.com>, Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 8, 2020 at 2:59 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
> On 20-06-08 14:13, Andy Shevchenko wrote:
> > On Mon, Jun 8, 2020 at 12:20 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
> > > On 20-03-26 18:31, Andy Shevchenko wrote:

> > > sorry for picking this up again but I stumbled above the same issue
> > > within the driver imx/drm driver which is using the component framework.
> > > I end up in a infinity boot loop if I enabled the HDMI (which is the
> > > DesignWare bridge device) and the LVDS support and the LVDS bind return
> > > with EPROBE_DEFER. There are no words within the component framework docs
> > > which says that this is forbidden. Of course we can work-around the
> > > driver-core framework but IMHO this shouldn't be the way to go. I do not
> > > say that we should revert the commit introducing the regression but we
> > > should address this not only by extending the docs since the most
> > > drm-drivers are using the component framework and can end up in the same
> > > situation.
> > >
> > > > > It can be solved by refactoring the driver probe routine. If a resource is
> > > > > required to be present, then check that it is available early; before
> > > > > registering child devices.
> > > >
> > > > We fix one and leave others.
> > >
> > > E.g. the imx-drm and the sunxi driver...
> >
> > Just out of curiosity, does my patch fix an issue for you?
>
> I didn't applied your patch yet. I can test it if you want.

If you can, thanks!

> > > > > The proposed solution to modify driver core is fragile and susceptible to
> > > > > side effects from other probe paths. I don't think it is the right approach.

-- 
With Best Regards,
Andy Shevchenko

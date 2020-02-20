Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E795A165F05
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 14:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgBTNnb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 08:43:31 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44793 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbgBTNnb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 08:43:31 -0500
Received: by mail-vs1-f66.google.com with SMTP id p6so2650704vsj.11
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2020 05:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VHEgUpty5OrcYJGxbPFH9uNYoAV1sH/e0iu6cPEMqFw=;
        b=MOPvSlGHs9vY9i1zxdZVYvRucN1GCv+wIlEmZNcxvOVJgWieyOuK5t2FgeWXlgssoI
         mgJD2DDeUXPTIpGdhTzqk5XirwmPaMk6CAwFKtPLAPWngvQpSx0wvzDZ3QBI5chjHIfO
         KlmT5z1qkHUZ1uy+lLfwhjvhlJoHtsQuwvRing9iIyS86tsUJYRObuuaZR1A4VsrYEWk
         CWwFljQX7WEAW5jj6YS8yCvSvpKPzB2Ug+lVXbgZ5JfB92mkizAVa2b/yNk21crOhZrc
         gnOIAvQqaXvxMxoOcpWkdq6mv+MYWKnMO5YcMjsRyGPJRrqW9wjWseT53Fo8heW6kC0g
         R9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHEgUpty5OrcYJGxbPFH9uNYoAV1sH/e0iu6cPEMqFw=;
        b=TB0kJ6vmYAS2PuOxD+QD5bFFfPbAyjUFPPxZBMUe45ZMf2o7uoBb5VmBQx+9vpCZlc
         Up48YjXbVelYfJIZKRApZuV6iV2R48RQ3anprDDFnctkZa7XeqzVvTKl/L8uxkd5BLmb
         F5EXWc2kJVoOX8IodCqKmVkpvJeCAKO7AHDqbz24772C6BhY6GDJsLM0HPGLHwoQHa+u
         KldDtxyc94UlLmBx+C2OVLRv45qpxVm5DOzyA+8yzp/YY9RVFqXzcM7Lt+sBeobQ2MQ+
         FwTk7RUk8BLFnkUDGZW3K2orceUERFP8rxTdoaDGny+7K846NnOgLFvpEBB2KurwXunk
         t8HQ==
X-Gm-Message-State: APjAAAVD0Q3KBfOYuITR8wlciG1qr8pOtxsaq7PLQ3zlr7DE5JsGVuUW
        ZI1+uoMyvjN9kIiGzDSkoJhRLsk/8wPMjGC0UpXIyA==
X-Google-Smtp-Source: APXvYqzAicYKMyJevIEntfrmo+/YD/iJAwDqnrwi2s9zzjbgZoib9lZtdmSkXq/LWZ2YjZVuv7nGnV3Vfctk+AI50NM=
X-Received: by 2002:a05:6102:22d6:: with SMTP id a22mr16400744vsh.191.1582206209871;
 Thu, 20 Feb 2020 05:43:29 -0800 (PST)
MIME-Version: 1.0
References: <20200211160321.22124-1-paul@crapouillou.net> <20200211160321.22124-4-paul@crapouillou.net>
 <CAPDyKFquXSB+ztXZQS4MPV20dRN_-CKJkmCF0A97pG+vJYRsbg@mail.gmail.com>
In-Reply-To: <CAPDyKFquXSB+ztXZQS4MPV20dRN_-CKJkmCF0A97pG+vJYRsbg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 20 Feb 2020 14:42:52 +0100
Message-ID: <CAPDyKFrGTVZ9_d-rGDLiEJ-nxPhXtOmw5hTDekpt_+RNB2Sx2A@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] mmc: jz4740: Use pm_sleep_ptr() macro
To:     Paul Cercueil <paul@crapouillou.net>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        od@zcrc.me, Linux PM <linux-pm@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 20 Feb 2020 at 14:38, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 11 Feb 2020 at 17:03, Paul Cercueil <paul@crapouillou.net> wrote:
> >
> > Use the newly introduced pm_sleep_ptr() macro to simplify the code.
> >
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> >  drivers/mmc/host/jz4740_mmc.c | 12 +++---------
> >  1 file changed, 3 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> > index fbae87d1f017..09554f9831de 100644
> > --- a/drivers/mmc/host/jz4740_mmc.c
> > +++ b/drivers/mmc/host/jz4740_mmc.c
> > @@ -1099,24 +1099,18 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
> >         return 0;
> >  }
> >
> > -#ifdef CONFIG_PM_SLEEP
> > -
> > -static int jz4740_mmc_suspend(struct device *dev)
> > +static int __maybe_unused jz4740_mmc_suspend(struct device *dev)
> >  {
> >         return pinctrl_pm_select_sleep_state(dev);
> >  }
> >
> > -static int jz4740_mmc_resume(struct device *dev)
> > +static int __maybe_unused jz4740_mmc_resume(struct device *dev)
> >  {
> >         return pinctrl_select_default_state(dev);
> >  }
> >
> >  static SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
> >         jz4740_mmc_resume);
> > -#define JZ4740_MMC_PM_OPS (&jz4740_mmc_pm_ops)
> > -#else
> > -#define JZ4740_MMC_PM_OPS NULL
> > -#endif
>
> All of the above code can be simplified in this way, without having to
> convert into using the new pm_sleep_ptr() macro, below.
>
> The only "penalty" would be that, the struct dev_pm_ops
> (jz4740_mmc_pm_ops) would then be referenced even when CONFIG_PM* is
> unset, thus the compiler would be able to throw it away.

/s/would/would not

[...]

Kind regards
Uffe

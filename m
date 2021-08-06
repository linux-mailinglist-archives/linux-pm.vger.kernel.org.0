Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C29E3E2B56
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 15:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344029AbhHFN2T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 09:28:19 -0400
Received: from mail-oo1-f45.google.com ([209.85.161.45]:38850 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244222AbhHFN2T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Aug 2021 09:28:19 -0400
Received: by mail-oo1-f45.google.com with SMTP id y23-20020a4a62570000b029028727ffa408so227737oog.5;
        Fri, 06 Aug 2021 06:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EwaYK5QiZh6IiR8aTLx1BO+CiD1SZPRY4ebE2HYvd5w=;
        b=rXw6Xn6KVZk1RG46K0OljhAN5g0F9XEQRw4NBzN1xaohumgOV53BgZaoLbuCAQl5NY
         nN1YW/Q8YUDK/m+UxkfTWs/WbJFLzbMh0H2cBgIVczWc6SvGk61Buo71/9EzH1Qo2A6G
         g/qQGcDjsMU4U0qKI5awhLw8mf341L0ifaXPh+KUhKQ/Ou1tpanBtFOU03NMv8nY9h7s
         pb4tjFJ5ww8CcMLdk3hkoIZ7vk3LjdSdYbfNCGNbgb3lB4nXYTpyDICR8zJoVs0UC051
         Ul5USHh9SUCLLVGd3gxJi/2Ow6fpmX8zIVVtyVBnXVYtAGgMKa7aMvoB0rnjShX5FFfv
         YBYw==
X-Gm-Message-State: AOAM533nu467rQlEQvGVdgi69q/ioKmXUCMxMrvYbYSdXhzzrDIEHLXd
        K3GTs+YqfWCrec7TK3m/iPql4qgTgr3KLqtCOh8=
X-Google-Smtp-Source: ABdhPJw8ttVHgV+Oa1vdqUFxeArJcAXGBlUr5m9E2BY5sUKwfIHc7iA/RV3QbuZaxEP4hiE/yJfn+K/21JgqJ/gxR0c=
X-Received: by 2002:a4a:5dc6:: with SMTP id w189mr6803193ooa.1.1628256482887;
 Fri, 06 Aug 2021 06:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210731195034.979084-1-dmitry.baryshkov@linaro.org>
 <20210731195034.979084-2-dmitry.baryshkov@linaro.org> <CAJZ5v0gWD8WSQU4oPMSdZFM9VpNpc4TAFJ=_wQLB60XFxw-Ciw@mail.gmail.com>
 <CAA8EJpq5DB2a=C+eo_S7QgVMzpm=mvUcC4DkWwGoKQ1g8trmgA@mail.gmail.com>
In-Reply-To: <CAA8EJpq5DB2a=C+eo_S7QgVMzpm=mvUcC4DkWwGoKQ1g8trmgA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 Aug 2021 15:27:51 +0200
Message-ID: <CAJZ5v0gOZkXp3X3hNTAtyuFoBA2xUMX274qv=yaj0jYD8XRgBw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] PM: runtime: add devm_pm_runtime_enable helper
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 4, 2021 at 11:03 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, 4 Aug 2021 at 21:07, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Sat, Jul 31, 2021 at 9:50 PM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > A typical code pattern for pm_runtime_enable() call is to call it in the
> > > _probe function and to call pm_runtime_disable() both from _probe error
> > > path and from _remove function. For some drivers the whole remove
> > > function would consist of the call to pm_remove_disable().
> > >
> > > Add helper function to replace this bolierplate piece of code. Calling
> > > devm_pm_runtime_enable() removes the need for calling
> > > pm_runtime_disable() both in the probe()'s error path and in the
> > > remove() function.
> > >
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >  drivers/base/power/runtime.c | 17 +++++++++++++++++
> > >  include/linux/pm_runtime.h   |  4 ++++
> > >  2 files changed, 21 insertions(+)
> > >
> > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > index 8a66eaf731e4..ec94049442b9 100644
> > > --- a/drivers/base/power/runtime.c
> > > +++ b/drivers/base/power/runtime.c
> > > @@ -1447,6 +1447,23 @@ void pm_runtime_enable(struct device *dev)
> > >  }
> > >  EXPORT_SYMBOL_GPL(pm_runtime_enable);
> > >
> > > +static void pm_runtime_disable_action(void *data)
> > > +{
> > > +       pm_runtime_disable(data);
> > > +}
> > > +
> > > +/**
> > > + * devm_pm_runtime_enable - devres-enabled version of pm_runtime_enable.
> > > + * @dev: Device to handle.
> > > + */
> > > +int devm_pm_runtime_enable(struct device *dev)
> > > +{
> > > +       pm_runtime_enable(dev);
> > > +
> > > +       return devm_add_action_or_reset(dev, pm_runtime_disable_action, dev);
> >
> > When exactly is pm_runtime_disable_action() going to run by this rule?
> >  When the device goes away or when the driver is unbound from it?
>
> When the driver is unbound (either because probe() returns an error or
> because __device_release_driver() is being called).
> This corresponds to a typical call to pm_runtime_disable() from the
> probe()'s error path or in the remove() callback.

OK, so

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

for the PM-runtime framework changes in this series (patches [1-2/3])
and please feel free to route them in through whatever tree is most
suitable (or let me know if you want me to pick them up).

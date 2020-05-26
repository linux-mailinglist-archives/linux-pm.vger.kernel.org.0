Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24F51E1DA8
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 10:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgEZIwg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 04:52:36 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43275 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgEZIwg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 04:52:36 -0400
Received: by mail-oi1-f194.google.com with SMTP id i22so17997140oik.10;
        Tue, 26 May 2020 01:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oGPpj4I3FcCpdQx07sSJRfqTAreoAbABjbVK8kbfFPY=;
        b=FTV4aHn/webGuehlJulougjjsptJ067ki0VsZmMlUPoSu8EJWnnfEOG53dTYylZpHa
         +oJ9Nx3S76xl44y57HQdXBQvDmT0RuIfscQibck8fXamz0T/Mq9Lu1tvPOERBlEzgoND
         PEx2N100d4pKhTi6XGQ3f+aKcPSzYvuMTuw/o1AyS5Vq7hHTE03B1WC2/i5+3Q83iyFG
         0WRwmAjLf7vOFz+I2gK/FzJAPSPOAS0KHD+5RF2/7mMfxk4FPnpHI0ysFolm5jWFtpFs
         CAa1HPjzv/yk6fHM6aOv/CjJd0dKiCuGwH8tmy81T2yudk8LrMeeTVXrX4uMHlejGZLW
         t7ZQ==
X-Gm-Message-State: AOAM531pvMByO9WO/gxUbT2m/S6+4OIoC8zllqpJxx+JvepUASVvYoUL
        U1O97rpqAePJgE5ariaPnqVn5ig6JHU+esuwSBg=
X-Google-Smtp-Source: ABdhPJz7zwRcNIuQPmHebsyHMfO53EzEpIvXe4uMLrW0VmgDRueHlgUdBqcyN4P65CkbTAfxnkqshu83hZrk1jXnKVg=
X-Received: by 2002:aca:eb56:: with SMTP id j83mr14057671oih.110.1590483155441;
 Tue, 26 May 2020 01:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200521170817eucas1p13d9477a0a5d13d2df876134cf41131d8@eucas1p1.samsung.com>
 <5127441.yGvM1JjtLk@kreacher> <e9130ce8-fd22-c871-c089-585585c7133f@samsung.com>
 <CAJZ5v0j+bsHaQcxK41yph8eRpMZ3DoerqA7uwS2B8De41Jwi7Q@mail.gmail.com> <CAPDyKFrHcvhi+qZk-65+FpDMu6y_ZU-K=nRWQY63qMR21m9yMg@mail.gmail.com>
In-Reply-To: <CAPDyKFrHcvhi+qZk-65+FpDMu6y_ZU-K=nRWQY63qMR21m9yMg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 May 2020 10:52:23 +0200
Message-ID: <CAJZ5v0jUsPHfo7M3rocR2AFK43LG1p21D_S=t_MhcpGd2wLy6A@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: clk: Fix clk_pm_runtime_get() error path
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 25, 2020 at 11:31 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 22 May 2020 at 20:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, May 22, 2020 at 7:19 AM Marek Szyprowski
> > <m.szyprowski@samsung.com> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On 21.05.2020 19:08, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > clk_pm_runtime_get() assumes that the PM-runtime usage counter will
> > > > be dropped by pm_runtime_get_sync() on errors, which is not the case,
> > > > so PM-runtime references to devices acquired by the former are leaked
> > > > on errors returned by the latter.
> > > >
> > > > Fix this by modifying clk_pm_runtime_get() to drop the reference if
> > > > pm_runtime_get_sync() returns an error.
> > > >
> > > > Fixes: 9a34b45397e5 clk: Add support for runtime PM
> > > > Cc: 4.15+ <stable@vger.kernel.org> # 4.15+
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Frankly, I would rather fix the runtime_get_sync() instead of fixing the
> > > return path everywhere in the kernel. The current behavior of the
> > > pm_runtime_get_sync() is completely counter-intuitive then. I bet that
> > > in the 99% of the places where it is being called assume that no special
> > > fixup is needed in case of failure. This is one of the most common
> > > runtime PM related function and it is really a common pattern in the
> > > drivers to call:
> > >
> > > pm_runtime_get_sync()
> > >
> > > do something with the hardware
> > >
> > > pm_runtime_put()
> > >
> > > Do you really want to fix the error paths of the all such calls?
> >
> > No, I don't, and that's why I'm proposing this patch.
> >
> > The caller that does what you said above is OK now and if the behavior
> > of pm_runtime_get_sync() changed, that caller would need to be
> > updated.
> >
> > OTOH, a caller that fails to drop the reference on an error returned
> > by pm_runtime_get_sync() is buggy (and has ever been so).
> >
> > I'd rather update the buggy callers than the ones that are OK.
>
> I agree.
>
> In hindsight we should have dropped the usage count in
> pm_runtime_get_sync(), when it fails. However, that's too late,
> especially since there are many cases having no error handling at all
> - and in those cases, that would mean the subsequent call to
> pm_runtime_put() can mess up the usage count (if pm_runtime_get_sync()
> failed and has already dropped the count).
>
> So, feel free to add:
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks!

Given the lack of other comments, I'm applying this patch as 5.8 material.

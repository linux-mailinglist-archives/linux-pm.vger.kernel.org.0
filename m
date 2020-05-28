Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0481E60E5
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 14:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389694AbgE1MbR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 08:31:17 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36561 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389439AbgE1MbQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 08:31:16 -0400
Received: by mail-ot1-f68.google.com with SMTP id h7so2213994otr.3;
        Thu, 28 May 2020 05:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h5oVREdc8mZHk5DmSeaXI8D6G4iopJ7pfcXrcSkFGrY=;
        b=EVr4to3k3EHCkQeqabFyxc3GiuDkT4EVYWNm9QNpjSZuGyk4FX1uTSvtTA9L6oJf9x
         NoBVUZfZ+DjCsbgNbshlcQFpY6XxcSBLc9BEOZEZaxGZ5H6dxu7Dt2c3nytM0rz8rOEK
         A9ZiDVHIqTgni9z0D7znvdngGRUFduHkHZ0uyuAFKopWvHmpWcjLW3H+/Bs9Xpofe16i
         g1aEIzlUQLP47MPa/WL2q6UmFfiB4GcoqcF3eezL19N3F7XWZ1kgtZviZ/4dSxfcDsUG
         FroSa9vO/ifcOvEIXm3tt+GLNDW1Pc5RTYrs6s7Bcd280rJjrVaKNCRgxuCnyBy5Sc9o
         jx5w==
X-Gm-Message-State: AOAM5305o7do1ouzS4lDN2+nccBoOHDfO76SYYMywZmTEcsMfZcWeN0M
        TT6P3EihsstKnICR8kLi//IzhTtI7DFOl0PjIhU=
X-Google-Smtp-Source: ABdhPJyKoD2BsxDaFk6T06cjSPSPMBpWTdoeNgvL+Ub3VuSwISlOzyyyfmG5itLnmBGjAmW+MYKmN+Y05Xch3/WxUok=
X-Received: by 2002:a05:6830:20d1:: with SMTP id z17mr375006otq.167.1590669073023;
 Thu, 28 May 2020 05:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200520095148.10995-1-dinghao.liu@zju.edu.cn>
 <2b5d64f5-825f-c081-5d03-02655c2d9491@gmail.com> <20200520150230.GC30374@kadam>
 <2a46539d.b977f.1723553aa81.Coremail.dinghao.liu@zju.edu.cn>
 <20200521091505.GF30374@kadam> <CAJZ5v0irLayBUPRWNT1tcZivz9inS1YbUgGj5WXvucLKKwRQAw@mail.gmail.com>
 <20200521173901.GA22310@kadam> <20200522131031.GL2163848@ulmo>
 <20200522132318.GM30374@kadam> <20200522144312.GA2374603@ulmo> <20200528120818.GO22511@kadam>
In-Reply-To: <20200528120818.GO22511@kadam>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 May 2020 14:31:01 +0200
Message-ID: <CAJZ5v0hJY3_z-wBrgbpetqOF44JB9x6uQrosgStD+Sr+KZdvWg@mail.gmail.com>
Subject: Re: Re: [PATCH] media: staging: tegra-vde: fix runtime pm imbalance
 on error
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        devel@driverdev.osuosl.org, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Kangjie Lu <kjlu@umn.edu>, Dmitry Osipenko <digetx@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 28, 2020 at 2:08 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Fri, May 22, 2020 at 04:43:12PM +0200, Thierry Reding wrote:
> > On Fri, May 22, 2020 at 04:23:18PM +0300, Dan Carpenter wrote:
> > > On Fri, May 22, 2020 at 03:10:31PM +0200, Thierry Reding wrote:
> > > > On Thu, May 21, 2020 at 08:39:02PM +0300, Dan Carpenter wrote:
> > > > > On Thu, May 21, 2020 at 05:22:05PM +0200, Rafael J. Wysocki wrote:
> > > > > > On Thu, May 21, 2020 at 11:15 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > > > > >
> > > > > > > On Thu, May 21, 2020 at 11:42:55AM +0800, dinghao.liu@zju.edu.cn wrote:
> > > > > > > > Hi, Dan,
> > > > > > > >
> > > > > > > > I agree the best solution is to fix __pm_runtime_resume(). But there are also
> > > > > > > > many cases that assume pm_runtime_get_sync() will change PM usage
> > > > > > > > counter on error. According to my static analysis results, the number of these
> > > > > > > > "right" cases are larger. Adjusting __pm_runtime_resume() directly will introduce
> > > > > > > > more new bugs. Therefore I think we should resolve the "bug" cases individually.
> > > > > > > >
> > > > > > >
> > > > > > > That's why I was saying that we may need to introduce a new replacement
> > > > > > > function for pm_runtime_get_sync() that works as expected.
> > > > > > >
> > > > > > > There is no reason why we have to live with the old behavior.
> > > > > >
> > > > > > What exactly do you mean by "the old behavior"?
> > > > >
> > > > > I'm suggesting we leave pm_runtime_get_sync() alone but we add a new
> > > > > function which called pm_runtime_get_sync_resume() which does something
> > > > > like this:
> > > > >
> > > > > static inline int pm_runtime_get_sync_resume(struct device *dev)
> > > > > {
> > > > >         int ret;
> > > > >
> > > > >         ret = __pm_runtime_resume(dev, RPM_GET_PUT);
> > > > >         if (ret < 0) {
> > > > >                 pm_runtime_put(dev);
> > > > >                 return ret;
> > > > >         }
> > > > >         return 0;
> > > > > }
> > > > >
> > > > > I'm not sure if pm_runtime_put() is the correct thing to do?  The other
> > > > > thing is that this always returns zero on success.  I don't know that
> > > > > drivers ever care to differentiate between one and zero returns.
> > > > >
> > > > > Then if any of the caller expect that behavior we update them to use the
> > > > > new function.
> > > >
> > > > Does that really have many benefits, though? I understand that this
> > > > would perhaps be easier to use because it is more in line with how other
> > > > functions operate. On the other hand, in some cases you may want to call
> > > > a different version of pm_runtime_put() on failure, as discussed in
> > > > other threads.
> > >
> > > I wasn't CC'd on the other threads so I don't know.  :/
> >
> > It was actually earlier in this thread, see here for example:
> >
> >       http://patchwork.ozlabs.org/project/linux-tegra/patch/20200520095148.10995-1-dinghao.liu@zju.edu.cn/#2438776
>
> I'm not seeing what you're talking about.
>
> The only thing I see in this thread is that we don't want to call
> pm_runtime_mark_last_busy(dev) which updates the last_busy time that is
> used for autosuspend.

That shouldn't be a problem, though, because if pm_runtime_get_sync()
returns an error, PM-runtime is not going to work for this device
until it is explicitly disabled for it and fixed up.

> The other thing that was discussed was pm_runtime_put_noidle() vs
> pm_runtime_put_autosuspend().  "The pm_runtime_put_noidle() should have
> the same effect as yours variant".  So apparently they are equivalent
> in this situation.  How should we choose one vs the other?

The point is that pm_runtime_put_noidle() is *sufficient* to drop the
reference and nothing more is needed in the error path.

So you can always do something like this:

ret = pm_runtime_get_sync(dev);
if (ret < 0) {
        pm_runtime_put_noidle(dev);
        return ret;
}

However, it would not be a bug to do something like this:

        ret = pm_runtime_get_sync(dev);
        if (ret < 0)
                goto rpm_put;

        ...

rpm_put:
        pm_runtime_put_autosuspend(dev);

> I'm not trying to be obtuse.  I understand that probably if I worked in
> PM then I wouldn't need documentation...  :/

So Documentation/power/runtime_pm.rst says this:

  `int pm_runtime_get_sync(struct device *dev);`
    - increment the device's usage counter, run pm_runtime_resume(dev) and
      return its result

In particular, it doesn't say "decrement the device's usage counter on
errors returned by pm_runtime_resume(dev)", so I'm not sure where that
expectation comes from.

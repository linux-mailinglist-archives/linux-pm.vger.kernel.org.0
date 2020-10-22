Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4AE2960C4
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 16:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900748AbgJVOQh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 22 Oct 2020 10:16:37 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46431 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443913AbgJVOQh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 10:16:37 -0400
Received: by mail-oi1-f196.google.com with SMTP id l4so1836639oii.13;
        Thu, 22 Oct 2020 07:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VmqFptAKOhB1kwEn7QNAQ1eEtfGRIzRebrKouxM4Uzo=;
        b=Ry3XC5BfnDaBUKmmQN+gJhiUy5BF6QGArnbJYivjXt0T1TqJY85stkTERZtcqlPq0B
         0OimRCQli9JtWayF6r9UmWoq0NRWpYIczSCuVDZaokWPQPVdFxvOTmtmFJ7fFI9/4Ssx
         8DKSl4kNErzmUziZ4esEPJ6rm8lAGa9Pc5aO96LWB4vus2KneRaqFLenANGCduy1sTh4
         2kTsXakchQb4r9GmbxbblAUnPctYmrmUnNLpLGcQFpFP4N1yoZjqjCrj5gCbIyJv4X/f
         IPPaxuyoWr3OYJM8An+R6tHMPJTqnaKs/Cn8EbcFnGljyyaX8ayMBGMCFK3Z8entjd6O
         OOiA==
X-Gm-Message-State: AOAM533PUmIqMDGE/axFeoVek1mFs7KSIkZtOp9zm6ZVL4+72LXtKM00
        ld25Dfun9LyDr9Gim9I0lMiw7smjUl6F675azk3ovuF5
X-Google-Smtp-Source: ABdhPJw+W2JnimijRswZBSSGyu+7MSACzddlHGMXLjsXwuqMfI9UeuRBsd0CGkqiM1oAzX++nPq9MqBcWSyMRZfFuqA=
X-Received: by 2002:aca:724a:: with SMTP id p71mr1680623oic.157.1603376195959;
 Thu, 22 Oct 2020 07:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <6543936.FbWAdBN1tG@kreacher> <1708806.S9fAqql2gf@kreacher> <e9466a28-5c6a-f88a-51ab-547ecc21e5d0@hisilicon.com>
In-Reply-To: <e9466a28-5c6a-f88a-51ab-547ecc21e5d0@hisilicon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Oct 2020 16:16:25 +0200
Message-ID: <CAJZ5v0hdWtUyDFBJpXH5tkFUtRF4y7P6SvcepEA24H1K4dy+iQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] PM: runtime: Resume the device earlier in __device_release_driver()
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 22, 2020 at 3:40 PM chenxiang (M) <chenxiang66@hisilicon.com> wrote:
>
> Hi Rafael,
>
> 在 2020/10/22 3:14, Rafael J. Wysocki 写道:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Since the device is resumed from runtime-suspend in
> > __device_release_driver() anyway, it is better to do that before
> > looking for busy managed device links from it to consumers, because
> > if there are any, device_links_unbind_consumers() will be called
> > and it will cause the consumer devices' drivers to unbind, so the
> > consumer devices will be runtime-resumed.  In turn, resuming each
> > consumer device will cause the supplier to be resumed and when the
> > runtime PM references from the given consumer to it are dropped, it
> > may be suspended.  Then, the runtime-resume of the next consumer
> > will cause the supplier to resume again and so on.
> >
> > Update the code accordingly.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Fixes: 9ed9895370ae ("driver core: Functional dependencies tracking support")
> > Cc: All applicable <stable@vger.kernel.org> # All applicable
> > ---
> >   drivers/base/dd.c |    4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Index: linux-pm/drivers/base/dd.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/dd.c
> > +++ linux-pm/drivers/base/dd.c
> > @@ -1117,6 +1117,8 @@ static void __device_release_driver(stru
> >
> >       drv = dev->driver;
> >       if (drv) {
> > +             pm_runtime_get_sync(dev);
> > +
> >               while (device_links_busy(dev)) {
> >                       __device_driver_unlock(dev, parent);
> >
> > @@ -1132,8 +1134,6 @@ static void __device_release_driver(stru
>
> pm_runtime_put_sync() is required to be called if existed from here.
>
> >                               return;

Right, I overlooked this, thanks!

> >               }
> >
> > -             pm_runtime_get_sync(dev);
> > -
> >               driver_sysfs_remove(dev);
> >
> >               if (dev->bus)

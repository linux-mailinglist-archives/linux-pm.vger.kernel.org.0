Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD9E227D45
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 12:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgGUKkW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 06:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbgGUKkV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 06:40:21 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AC6C061794;
        Tue, 21 Jul 2020 03:40:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so2324079wmi.3;
        Tue, 21 Jul 2020 03:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/hrwegn9jIZlfwVSBJg2Q9e2hdiS+7p2jeJiI2B1tZg=;
        b=GUZPnTeD2J8NqDSP9WWLzmOQJngE2JShWf5MnBF9DhXIO/nlj0hJgKgpsEtvY5gEbT
         RCsYzV5kY8oVxrlmD95NjoEa0D8dZhsUismEAoQ3/sm0kJ47GRMw9iDejtWbEyoyfS60
         9YrWiHDKQkR9dyIB67BVyHXal3r4JKDYxEdyMqK6H5Fvel4goKQwe0ILREBJzKfsD4IL
         oddpaPTwduKzajzjyV05JLwl+s0+et5ixn79RXRh9EI82rglF6wwQrOLezuDOr+e8Stf
         azffswxDOcsC65h6P/eNXvi0ziU7FCHgS/2xFoF7c6qyO3lb+LIBxEEpvoNumaetTZ2I
         7BrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/hrwegn9jIZlfwVSBJg2Q9e2hdiS+7p2jeJiI2B1tZg=;
        b=tvJLqUog5yC9SD1jEBZU0qhftR1sQcQeGbgUSCmRx0znMoj5+8YGkt3PAOQqbiPbYB
         cikrsLd0HEpeWoCqoxlZKIOSIiE+vRnmz8h+745JxE0fGZf3zK1/EtkEIre1UWYSuAAV
         2mij26bD8ExQrZ4MZXyQkqST7DFAD5eZ+UMK307uCUEw0BLn/zE6wed3Q+2RKZNaKj4A
         q2pmenLgTx/QSDl+IOpoTeDyZVkXTSMml4xRNEHLw3gIOk3fE4naT/uwunR+P3cEUEN5
         r3Ytbscghp27LD25YF8/KQbO97wmmCcJun166X2tnYIvpTuvoTH52kK6Zquu/CQ+Vl+N
         yOYQ==
X-Gm-Message-State: AOAM532cxc40DNGCt/xn989Sb4Znxb6u2FIocv68KZYdaaotYTGL2WQd
        G219KAo8s6NEwIw7Cduf3raiFrW5izbrpj8n3fARAKn5WKPBsw==
X-Google-Smtp-Source: ABdhPJyT/1LtNdoeP9Cg9cvSP4SEo5TegkCuPatOEblBQakvVJOOQBQ9X5N76GvU79QNd1w1mkIoxMmbdiwNl8D/88w=
X-Received: by 2002:a7b:c921:: with SMTP id h1mr3228394wml.29.1595328020057;
 Tue, 21 Jul 2020 03:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595301250.git.huangqiwu@xiaomi.com> <f58e4cc6f5235d463d96c950f2af2b9a47920e9d.1595301250.git.huangqiwu@xiaomi.com>
 <20200721082128.GE1655283@kroah.com>
In-Reply-To: <20200721082128.GE1655283@kroah.com>
From:   ivan <yanziily@gmail.com>
Date:   Tue, 21 Jul 2020 18:40:08 +0800
Message-ID: <CAPtXDt25yjb6twRC2xdL7k4rOanyJicEFGuW6P84eFjNa0J80g@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] power: supply: core: property to control reverse charge
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 21, 2020 at 4:21 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 21, 2020 at 01:59:37PM +0800, Qiwu Huang wrote:
> > From: Qiwu Huang <huangqiwu@xiaomi.com>
> >
> > Interface to control wireless reverse charge.
> > Supply reverse charge function when enabled.
> >
> > Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> > ---
> >  Documentation/ABI/testing/sysfs-class-power | 12 ++++++++++++
> >  drivers/power/supply/power_supply_sysfs.c   |  1 +
> >  include/linux/power_supply.h                |  1 +
> >  3 files changed, 14 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> > index 75ec7de2fe78..54647d6995d3 100644
> > --- a/Documentation/ABI/testing/sysfs-class-power
> > +++ b/Documentation/ABI/testing/sysfs-class-power
> > @@ -767,3 +767,15 @@ Description:
> >
> >               Access: Read-Only
> >               Valid values: 0 - 100
> > +
> > +What:                /sys/class/power_supply/<supply_name>/reverse_chg_mode
> > +Date:                Jul 2020
> > +Contact:     Fei Jiang <jiangfei1@xiaomi.com>
> > +Description:
> > +             Some phones support wireless reverse charge function which charge other phones.
>
> Replace "phones" with "devices"?

 Yes,  devices better than phones

>
> And shouldn't these lines be wrapped properly at 72 colums or so?

Sorry, I will modify the format  to match this standard.


>
> > +             The property supply interface to control wireless reverse charge.
>
> I can't understand this sentance.

The property provider interface to enable/disable wireless reverse charge.

>
> > +             If enabled, start TX mode and detect RX. Disabled when timeout or manual setting.
>
> Can this be set, or is it just something to be read?

Sorry,I forgot the permission statement

Access: Read, Write




>
> thanks,
>
> greg k-h



--
Thanks

Qiwu

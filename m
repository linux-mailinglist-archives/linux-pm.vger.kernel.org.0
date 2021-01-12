Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399712F2429
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 01:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403928AbhALAZl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 19:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404254AbhALAP5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2021 19:15:57 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A249AC061786
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2021 16:15:16 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id k4so521922ybp.6
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2021 16:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fc5a4hAhJ0U9BAhymt1K2IV9OCgvqNN915qhRxj3a0A=;
        b=FzgCAPKursjzIMbGBkZ3eH2LGTIcSWMdRXFZNb0iI3dW4FJfXN+URBiA/7Xr+TVtlN
         ZsuEticrEnOZQYGu0X3IURnQHoVxez1gbevX2V+Rjbl2KQIcP+gd3S9jBPvKE/vFM9fA
         gC+3kvYqIKAPySd/E91vcBp6hfdVkgHZ3ZzveccYyg/KfXQYsqrciKw/K+9x5p2/vwe4
         72SM8FYv8L3RaHi6niX74hsTtEOKwN8NTWRejFUphdQCu5D/FBNb9AAYCKfWaixWTFJy
         VDsV/HgHRNk0K3kkGfTwX2vRF5evlUidVnWhYu07t79EZxSitSNx8GFUOeWtA+dDxQrA
         C3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fc5a4hAhJ0U9BAhymt1K2IV9OCgvqNN915qhRxj3a0A=;
        b=YqYddaeSfKT/O1Q2yPfJJH3HDdA5N19+oduej0fArVfYQlL1/91hQSRKMxEaRfA31Z
         3fz7fzKON8v26hOR8vJFHgJsDO5rc+pIRSoxbdn0JSQ5jfOGYX1s0R2I5Ld4P2cBHunO
         73S+YI3YZGehQmOKPYJ/J7dd+L/eZ7Dml2SQoVJ2d6JBEXQdcNKmghJoIw0gfp1NAx/+
         jp+4V8rgfeHNJP2C5cZRzjVQWJmXWJ9VuEE+WnTMn44DPJEWClq6EN3zvP5SXEuxCvr1
         pSWOuztB1LefkxN9vWPdbXiYvJPOPycSk+Kw3kplL3T0MiCiGVY1p66uPMwnwiy52fHL
         IylQ==
X-Gm-Message-State: AOAM530d3b2Cqaj2d4tFA5/DHxj6jLUqVfHnAwQ+T14EAD+nDTcAhehc
        IhdZzymMEskkYaUa6qBOYmnanlFn4d+0vTovS8ZWTg==
X-Google-Smtp-Source: ABdhPJxJqSOmEsqdTeDCPTa7EFhYl9pJJKu4sfDgU6Qpp/aNyX+mQBLDMHr8nyNikVp5Tk7R/XBhnLtRzCsI8xCnWCw=
X-Received: by 2002:a25:b703:: with SMTP id t3mr3722472ybj.96.1610410515726;
 Mon, 11 Jan 2021 16:15:15 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2101102010200.25762@eggly.anvils>
 <X/xV7ZV5jzI7RvAe@ulmo> <CAJZ5v0iriRkEN8dVJ9gE3+Wyn_96=SNhav1QaQ59i9O0genTNQ@mail.gmail.com>
 <X/x49o3EtrUh6vuO@ulmo> <CAJZ5v0hyvdcKsPJ7U5WioXb1c8Pg_F1BLC_dbKesFBLTUSiVaw@mail.gmail.com>
 <CAGETcx_odme9ufTps6tctOW+zfOox6iXgTx_9GAjoYn=+jy1BQ@mail.gmail.com> <alpine.LSU.2.11.2101111539070.2728@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2101111539070.2728@eggly.anvils>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 11 Jan 2021 16:14:39 -0800
Message-ID: <CAGETcx-gPA3HeSKS6XW1zYj_imjDH_86897Jub56b9ctBOqmwg@mail.gmail.com>
Subject: Re: 5.11-rc device reordering breaks ThinkPad rmi4 suspend
To:     Hugh Dickins <hughd@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Huang <vincent.huang@tw.synaptics.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Duggan <aduggan@synaptics.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 11, 2021 at 3:42 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Mon, 11 Jan 2021, Saravana Kannan wrote:
> >
> > I happen to have an X1 Carbon (different gen though) lying around and
> > I poked at its /sys folders. None of the devices in the rmi4_smbus are
> > considered the grandchildren of the i2c device. I think the real
> > problem is rmi_register_transport_device() [1] not setting up the
> > parent for any of the new devices it's adding.
> >
> > Hugh, can you try this patch?
>
> Just tried, but no, this patch does not help; but I bet
> you're along the right lines, and something as simple will do it.

Did you see this patch change the organization of devices under /sys/devices/?
The rmi* devices need to be under one of the i2c devices after this
patch. Is that not the case? Or is that the case, but you are still
seeing suspend/resume issues?

-Saravana

>
> >
> > diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> > index 24f31a5c0e04..50a0134b6901 100644
> > --- a/drivers/input/rmi4/rmi_bus.c
> > +++ b/drivers/input/rmi4/rmi_bus.c
> > @@ -90,6 +90,7 @@ int rmi_register_transport_device(struct
> > rmi_transport_dev *xport)
> >
> >         rmi_dev->dev.bus = &rmi_bus_type;
> >         rmi_dev->dev.type = &rmi_device_type;
> > +       rmi_dev->dev.parent = xport->dev;
> >
> >         xport->rmi_dev = rmi_dev;
> >
> > -Saravana
> >
> > [1] - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/input/rmi4/rmi_bus.c#n74

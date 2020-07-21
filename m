Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570E7227CCF
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 12:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgGUKVe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 06:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGUKVd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 06:21:33 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876E8C061794;
        Tue, 21 Jul 2020 03:21:33 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so20637092wru.6;
        Tue, 21 Jul 2020 03:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tg7ZtznRb+b+yekzNeH8rbjkvPZT0rO0PfuB04Vn+lE=;
        b=fOftbt2BlRb6Sdks3/IcQAdA5xeuHcFYKe+fcVO4MR3zvlKV0j2v8FojJ7NP4bgjCm
         7kMxyrn2slElFlU2ueveJ8SB+z7sSw5RAzPAGCc2BpOVRJod8w74BWiJw/Q2SO25vw6f
         WxWtfcOW3lWYk6jjq6qIRCy7hIY+LR6Yso+KJp3GnoI+Vaig9wMGwX5+DWY5N5tcUyKW
         VwNRAyWBKJLEY4nNED0dtTojZFRnVOjXFCD1qgsFDdQG56VZNs4PKM/DqHn6OT2PD4h7
         4Itp3AG66CA1RVLOUMqAXpCYcfD9LkzoGXdyTkrM/l6fQZ+Oc7dNEDK9wOszhKNLXILX
         haZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tg7ZtznRb+b+yekzNeH8rbjkvPZT0rO0PfuB04Vn+lE=;
        b=JYPMaFThCez7Ua3qyyNkvG17JnlF650STsXPo1OlBWTZLOCgnPRhGh0TJanwsDRa+L
         hjOInRsuP30EyAJmnPwpi6440mQDiTMLF06iM9VSNRAdYqHVWJv9dXH+ZDd6DLrWKg9a
         hOdJ0ueai0TenJOnRW4Jby/+ev8sXMGbYjc5mOMWva84nPL4hVEFelqtRbH1u5EHpgNB
         mxAq+4YjC01jzSf+S/gPduuyiFAqh41kcCANbTp1vBnFSp/8LsQ9P/tWwl31U2RKh5k6
         5iGCammbuvqZoWnGHEgiXn9tdwH3pwH3gKO8EkXbLsJK6KYxkZDWtr23Dl+NJACDpFTk
         NpdA==
X-Gm-Message-State: AOAM5318nEwFGa+U6aN8hE5NmhuKK6WfGILgUQAOtra2a1/HL/TrsR84
        EEX/O9XjIeZwwqzcwdm+oWYwEA+CWUVHRztmqdI=
X-Google-Smtp-Source: ABdhPJy/mfKYuTq2/E8DzFaP+q62IINJNJXkBqAMMUm3eKnVccRT6EEgv2aBQUj1kf0++jJNo/hcxHDPPg1g5kTKxNI=
X-Received: by 2002:a5d:6683:: with SMTP id l3mr27206827wru.288.1595326892226;
 Tue, 21 Jul 2020 03:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595301250.git.huangqiwu@xiaomi.com> <b383d79629d0afca00838fcbaad4458e383d7262.1595301250.git.huangqiwu@xiaomi.com>
 <20200721082000.GD1655283@kroah.com>
In-Reply-To: <20200721082000.GD1655283@kroah.com>
From:   ivan <yanziily@gmail.com>
Date:   Tue, 21 Jul 2020 18:21:20 +0800
Message-ID: <CAPtXDt2CXYJNoqnu3r7+vV2BZzT3fMR_G1yOyu1v0dgS8EkjNg@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] power: supply: core: add wireless signal strength property
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 21, 2020 at 4:19 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 21, 2020 at 01:59:36PM +0800, Qiwu Huang wrote:
> > From: Qiwu Huang <huangqiwu@xiaomi.com>
> >
> > reports wireless signal strength.
> > The value show degree of coupling between tx and rx.
> >
> > Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> > ---
> >  Documentation/ABI/testing/sysfs-class-power | 10 ++++++++++
> >  drivers/power/supply/power_supply_sysfs.c   |  1 +
> >  include/linux/power_supply.h                |  1 +
> >  3 files changed, 12 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> > index 03ab449fae8a..75ec7de2fe78 100644
> > --- a/Documentation/ABI/testing/sysfs-class-power
> > +++ b/Documentation/ABI/testing/sysfs-class-power
> > @@ -757,3 +757,13 @@ Description:
> >                       13: ADAPTER_VOICE_BOX,
> >                       14: ADAPTER_PRIVATE_PD_50W.
> >
> > +What:                /sys/class/power_supply/<supply_name>/signal_strength
> > +Date:                Jul 2020
> > +Contact:     Fei Jiang <jiangfei1@xiaomi.com>
> > +Description:
> > +             In PING phase, RX transmits a signal strength packet as the first
>
> What does "PING phase" mean?

The Qi Wireless Power Transfer System is published by the Wireless
Power Consortium.
The ping phase is the necessary stage for matching transmitter and
receiver. In this phase,
the Power Transmitter executes a Digital Ping, and listens for a
response. If the
Power Transmitter discovers a Power Receiver, the Power Transmitter
may extend the Digital Ping,
i.e. maintain the Power Signal at the level of the Digital Ping. This
causes the system to proceed to the
identification & configuration phase. If the Power Transmitter does
not extend the Digital Ping, the
system shall revert to the selection phase.

>
> Other than that, seems sane to me, thanks for the changes.
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>



-- 
Thanks

Qiwu

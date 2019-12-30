Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5CB612D070
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2019 14:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfL3Nuq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Dec 2019 08:50:46 -0500
Received: from mail-vk1-f179.google.com ([209.85.221.179]:33014 "EHLO
        mail-vk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfL3Nuq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Dec 2019 08:50:46 -0500
Received: by mail-vk1-f179.google.com with SMTP id i78so8281091vke.0;
        Mon, 30 Dec 2019 05:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkMGH5DQxq4vpQ2V6RpbSRMhiMiNZc/V1Nq34hSwIJk=;
        b=CdmuDXJVWhggBHQW+pJHb6TNOzPvoOAZ7687gifPylrQZxVlozKmptWbBXg6ZvIkZu
         cSqCpWBasg60LSZFxQc68XKGx9tGCTYU/1glw3qAd+j+PnScVx8y7/q7mH8JpjHAT5W9
         Z/9McLaAraQ3JOb8JHt6V0DPC6dpkL0tKD7GiqySLNj0KbpcRoSq8VLLF/YFzGp4277e
         yuOUGCFS3HHDim9Piq8i4Ve//zYDej7JIhFASN0gjkPfAca7mPla61VF7h1NhswQaTSP
         Bh/xohmtzFWp2TZ40Oq/berVwITGSAmsaECxo+5Kdz28ttDCRmv2KCr0fO77F+miqcHk
         Vwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkMGH5DQxq4vpQ2V6RpbSRMhiMiNZc/V1Nq34hSwIJk=;
        b=QjVyWzHhxhTz1NxB8qEZgYOjO4TBt/FVZAotivmP9xNRDsOsdqAMD9vEPUjplQYNJ3
         ynlCfLH5iSjnuWYveRhtzsfMNGx1RIiu3UO6R8pUjpnubLy6vDDqXfrA98y0BwKe3IwY
         8MAYvtI9JqRa8N0AX4n0G1A7tdc9ODFYDYulTZARudGTsHDR2Gv/YgXOCqYT7TH+rfP1
         30nqfg+K2G4Jr9aLE9ZipmLEGKxI0nPFSMXDzHLEp6N7OL6Ep2ERcbxyiG/DIG0KSMSK
         3KWVcHIJ5jgYgwiN0yTEDPr+6LPjJXdY9BDOVtUOSOiUfvBhtuvcGAgN14ByQg24E3S1
         eXWA==
X-Gm-Message-State: APjAAAUu2pnmN04if3jKOUXSoXGGgv6UpHOR0kp8BQMbnQ+FuWlEfE2d
        VWXJ2UXblWOcROHKV6d9Z5+kp3d2JNUELuZd3/XKE2eQ
X-Google-Smtp-Source: APXvYqxLXFi9J20jdLU7H/ZiNuY8RrLKbXtPjBGXHbT9hV1C1voWZ2Ea3/nczoyLc4wggA/hUuYx3UiwGsQLQlVnEL0=
X-Received: by 2002:a1f:7c0c:: with SMTP id x12mr38200964vkc.41.1577713845386;
 Mon, 30 Dec 2019 05:50:45 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLh8dsSCq850afbj4OiHhZ2swBWZP=BTUrXrXhdpTjZs+A@mail.gmail.com>
 <CAK7N6vpawfLSVcHCg_3aQ0M8L=j77ZeGfmUZ-J4hpUkWu0fkWA@mail.gmail.com>
 <CAOuPNLii26WcDnwD7ZkMX6ux7VRspw7nMEKJK0QF+j95YCHPOw@mail.gmail.com> <CAK7N6vrSKM8pU0+gquCu1x52GjBTaqFbwqtj_v8dzd+3-g4D1A@mail.gmail.com>
In-Reply-To: <CAK7N6vrSKM8pU0+gquCu1x52GjBTaqFbwqtj_v8dzd+3-g4D1A@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Mon, 30 Dec 2019 19:20:34 +0530
Message-ID: <CAOuPNLicwavzWQZAqzyLdc12Rb=yo49QxrRM3Zr0KOGrhCtJpg@mail.gmail.com>
Subject: Re: interrupt handler not getting called after resume
To:     anish singh <anish198519851985@gmail.com>
Cc:     Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Anish,

On Thu, 5 Dec 2019 at 00:55, anish singh <anish198519851985@gmail.com> wrote:
>
> On Wed, Dec 4, 2019 at 1:49 AM Pintu Agarwal <pintu.ping@gmail.com> wrote:
> >
> > On Wed, 4 Dec 2019 at 00:28, anish singh <anish198519851985@gmail.com> wrote:
> > >
> > > On Tue, Dec 3, 2019 at 6:12 AM Pintu Agarwal <pintu.ping@gmail.com> wrote:
> > > >
> > > > Hi All,
> > > >
> > > > I have one general query.
> > > >
> > > > If an interrupt handler is NOT getting called (for one device) after
> > > > the system resume (from snapshot image), then what could be the issue?
> > >
> > > Most likely during resume the interrupt was not enabled. So check
> > > irq status registers to see in the working and non working case.
> > >
> > Oh sorry, I forgot to mention one thing.
> > After resume, I can see that the interrupts are visible under /proc/interrupts.
> > # cat /proc/interrupts
> >            CPU0       CPU1
> > [...]
> > 416:          1          0       IPU  (null)
> > 417:          0          0       IPU  (null)
> > 418:          0          0       IPU  imx_drm  ===> HDMI
> > 419:       2242       2       IPU  imx_drm   ===> LCD
> > [...]
> >
> > The interrupts are coming only for LCD display and thus its irq
> > handler is getting called.
> > But the interrupts are not coming for HDMI case, thus HDMI gives
> > "vblank timeout issue".

Just wanted to update you that I have resolved the "vblank timeout
issue" for HDMI (by restoring clock data during resume path).
Now the ipu-v3 interrupts are coming even for HDMI crtc.

But HDMI display is still not working. May be this is another issue.

Anyways, thank you so much for your support :)


Regards,
Pintu

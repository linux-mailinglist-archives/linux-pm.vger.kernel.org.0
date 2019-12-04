Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E25BC1135A8
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 20:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfLDTZg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 14:25:36 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:42983 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbfLDTZf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 14:25:35 -0500
Received: by mail-oi1-f172.google.com with SMTP id j22so307100oij.9;
        Wed, 04 Dec 2019 11:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pFUOvAm3fm348kgwrvmev1YNw19TgoAC7QPtF9q0W9g=;
        b=tavjmU/Q3DfvERF7bhd3q/fapLDjBaceWr0h20GkAqynBwFQMUwfUlK4JhVKg6DNba
         YcTrdtYwr9rzEBR4ioJALzSV7YV3HPPFYHcud6qn6L+QOAR5ZZWOyyXYIc+k/MqSde7Q
         KfnTP5KxI5P4mbTDuXUJp8Qyp6pBDieNXRGyaw6F2q4sBWmws/FiBMXMsX82JHHH7Ri2
         zda5XYPi19vtq2GGB512vz3f72AXQfAZO7gQo89mrt/EjTshdpJ7t2GNV6x3qATQYnSo
         e5CFH7FHMs+hgaDF/YiW2ZIpHhfzssyZNkz+XapRCUModCWBJN82m2lpiTFd5a6Q+IoE
         wDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pFUOvAm3fm348kgwrvmev1YNw19TgoAC7QPtF9q0W9g=;
        b=SJVX5HZYLhIkVgczuwf0obe7Fuc4Yzo2RlatqXA7mSkje2WmWP51Y/wDo/kD66nrYW
         UChWeqXmZQfQhKiENiYsyrSDLCi85zHRbSUVLLtLFITZ2xmSiNOcigAxuSoD4PKzgznk
         Y2xk7K8p2i0OSeGwzxS3Z1zRxZQPbH15Yew8SLnN0qAeF0JPceKnjdB64QBgyS0OFTQc
         xugaslIa6W7bISqPGcaJBNjORdDKjjVCLGFbJ+ikSr/WXoK/b8QiAC1V3hoXGBrvngm2
         lBXAsC+E6Kirnk+FX1N6qVerzPODku4Bvdnit1CjEWtN55gvcmmiGgmmyDwcIywiE0pT
         SVOw==
X-Gm-Message-State: APjAAAXUNojqU+Qtz7n3GpxOUsUdQ6hVQag7DJ728FlSwJlP6cv485gp
        QhqUm0nsQL3dvLGLPj43KaeIdCBku6+sVEirlWW4KkpL
X-Google-Smtp-Source: APXvYqygeXnEPPwtKFRW0Y36WS+lxc9iXT3BUpe6OWDmYYx7OmzTFEQc+TYv16vi+70aFchYa1GmHEKib44SVaBMTL0=
X-Received: by 2002:aca:c3c6:: with SMTP id t189mr4090470oif.98.1575487535056;
 Wed, 04 Dec 2019 11:25:35 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLh8dsSCq850afbj4OiHhZ2swBWZP=BTUrXrXhdpTjZs+A@mail.gmail.com>
 <CAK7N6vpawfLSVcHCg_3aQ0M8L=j77ZeGfmUZ-J4hpUkWu0fkWA@mail.gmail.com> <CAOuPNLii26WcDnwD7ZkMX6ux7VRspw7nMEKJK0QF+j95YCHPOw@mail.gmail.com>
In-Reply-To: <CAOuPNLii26WcDnwD7ZkMX6ux7VRspw7nMEKJK0QF+j95YCHPOw@mail.gmail.com>
From:   anish singh <anish198519851985@gmail.com>
Date:   Wed, 4 Dec 2019 11:25:23 -0800
Message-ID: <CAK7N6vrSKM8pU0+gquCu1x52GjBTaqFbwqtj_v8dzd+3-g4D1A@mail.gmail.com>
Subject: Re: interrupt handler not getting called after resume
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 4, 2019 at 1:49 AM Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> On Wed, 4 Dec 2019 at 00:28, anish singh <anish198519851985@gmail.com> wrote:
> >
> > On Tue, Dec 3, 2019 at 6:12 AM Pintu Agarwal <pintu.ping@gmail.com> wrote:
> > >
> > > Hi All,
> > >
> > > I have one general query.
> > >
> > > If an interrupt handler is NOT getting called (for one device) after
> > > the system resume (from snapshot image), then what could be the issue?
> >
> > Most likely during resume the interrupt was not enabled. So check
> > irq status registers to see in the working and non working case.
> >
> Oh sorry, I forgot to mention one thing.
> After resume, I can see that the interrupts are visible under /proc/interrupts.
> # cat /proc/interrupts
>            CPU0       CPU1
> [...]
> 416:          1          0       IPU  (null)
> 417:          0          0       IPU  (null)
> 418:          0          0       IPU  imx_drm  ===> HDMI
> 419:       2242       2       IPU  imx_drm   ===> LCD
> [...]
>
> The interrupts are coming only for LCD display and thus its irq
> handler is getting called.
> But the interrupts are not coming for HDMI case, thus HDMI gives
> "vblank timeout issue".

Is it something to do with MHL cable? Have you used scope
to find out if the interrupt was actually triggered?

> Apart from this I also tried calling enable_irq(irq) after resume, but
> it did not help much.

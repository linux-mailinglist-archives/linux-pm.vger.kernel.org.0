Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04F55112864
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 10:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfLDJt7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 04:49:59 -0500
Received: from mail-vk1-f176.google.com ([209.85.221.176]:36345 "EHLO
        mail-vk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfLDJt7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 04:49:59 -0500
Received: by mail-vk1-f176.google.com with SMTP id i4so1952157vkc.3;
        Wed, 04 Dec 2019 01:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pPIJ9M8+mSe3OeAXCE+fj/3dGRagMu8jXvBF/uDza34=;
        b=cXtA9Yptfjo8ePQAqvUGePG60nWRObXSX42QTc+c9FwtujDvR9ZEnH4F+TSMnpA0Wh
         oC4zo10iCmvaHbQ2tY1mcsutd71XBkBZxHBpsa+OMIKSFjHw4DnqKkNjBnaBdNVgZviZ
         QStk480dlgw0qkHufnq0myyOQrwFKS1amp6vOXy/nBAFHKrwjti4hyS6QMgMwxx/ASDc
         z/w0o3d1mdWNZHgbRAbxXVgP/yR470eozuhigjg+M5z0ew7sPRoOajiP0UZ8c6N6aGgR
         Nwcx0wY1PaA3VUwL4oum8Zse0r9sHnQx7iwt5Al5bti6ru0vs0kz9S8lEAIy5Hf4AegX
         pBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pPIJ9M8+mSe3OeAXCE+fj/3dGRagMu8jXvBF/uDza34=;
        b=UO92pHQSGzMRcZ3RRqdt/sJVurbaeR1l5MVFaCvM6jzNAdtaSS2raLNURdgrk+rPRH
         XReOJKAtET26Ta/Z+iW6ybXGRI4a34OFzAHGRtUTctBZqfCjVfrcnQByf5/54l/lhfiC
         AtsWjKpotvrZP8jZQWCdHjdBE5OAitBZq9vqcV6p5aegrwINNsAbXoly4XaaWwWQ1kUZ
         vJJRxPza9uvSnKn/JO5i9fbMD7QXlFeWCZyPom/8pEzOxjRvau0ASU8gsS+qBJdNNFBO
         qW/6AYsXC0w/zMp4rpg6o1zd1G9lFCcmUP361xcob5IguT076RiKVa6S0oZ2Ha8E9G9v
         BOzg==
X-Gm-Message-State: APjAAAVngQ9dfJYI3WAG2GdRoRaDk0LE7ML8MCuge5m8X74lt/QmfOoH
        2wjjq/dxU1plKcCR50FOV7YqofuXNKGwjhlxNJY=
X-Google-Smtp-Source: APXvYqwcmEszgaP2f+aEFuCk64GgbEQC+Y3ruLWXWwDDA0lNHGnXECgPDn5L2c4lKmDY2WgkAnD6nw9PVtHk309L/8c=
X-Received: by 2002:a05:6122:1065:: with SMTP id k5mr1378302vko.14.1575452997897;
 Wed, 04 Dec 2019 01:49:57 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLh8dsSCq850afbj4OiHhZ2swBWZP=BTUrXrXhdpTjZs+A@mail.gmail.com>
 <CAK7N6vpawfLSVcHCg_3aQ0M8L=j77ZeGfmUZ-J4hpUkWu0fkWA@mail.gmail.com>
In-Reply-To: <CAK7N6vpawfLSVcHCg_3aQ0M8L=j77ZeGfmUZ-J4hpUkWu0fkWA@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Wed, 4 Dec 2019 15:19:46 +0530
Message-ID: <CAOuPNLii26WcDnwD7ZkMX6ux7VRspw7nMEKJK0QF+j95YCHPOw@mail.gmail.com>
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

On Wed, 4 Dec 2019 at 00:28, anish singh <anish198519851985@gmail.com> wrote:
>
> On Tue, Dec 3, 2019 at 6:12 AM Pintu Agarwal <pintu.ping@gmail.com> wrote:
> >
> > Hi All,
> >
> > I have one general query.
> >
> > If an interrupt handler is NOT getting called (for one device) after
> > the system resume (from snapshot image), then what could be the issue?
>
> Most likely during resume the interrupt was not enabled. So check
> irq status registers to see in the working and non working case.
>
Oh sorry, I forgot to mention one thing.
After resume, I can see that the interrupts are visible under /proc/interrupts.
# cat /proc/interrupts
           CPU0       CPU1
[...]
416:          1          0       IPU  (null)
417:          0          0       IPU  (null)
418:          0          0       IPU  imx_drm  ===> HDMI
419:       2242       2       IPU  imx_drm   ===> LCD
[...]

The interrupts are coming only for LCD display and thus its irq
handler is getting called.
But the interrupts are not coming for HDMI case, thus HDMI gives
"vblank timeout issue".
Apart from this I also tried calling enable_irq(irq) after resume, but
it did not help much.

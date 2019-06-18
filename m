Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D24F44A44B
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2019 16:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfFROqD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 10:46:03 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:40881 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfFROqD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2019 10:46:03 -0400
Received: by mail-ua1-f67.google.com with SMTP id s4so6244607uad.7;
        Tue, 18 Jun 2019 07:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/f14cHYF/JwNNEW7ZZ5tU2/Q+E6LWRIS5CopK+Dp/ws=;
        b=tO8Fsho/8ZrXFwXiDsWwBqJ0ukz1/kUdIS6NDsUPNHp4wR7PH0Qpr8pqVtqeOyQvwe
         ZCdCsl/x8ghDwv+91RrzEhYehxPH9/ZU8nswFi9vgpFqUd8aVx+RIJ+B8B7W+lKpqN8q
         oVZqEnfnoMwUGJnYn4DFbG9W8in/zQWU/EXoEFdg5XjQ1K3cTd+FrQPYfJ5ZccEgDmyz
         MNagThdbCpX8jKLrSGXXMR5hMhj2nFnuK2Zexrpja2BQVJf1a77FV+NCWGlsRQWjFvI+
         tIaE/NsQIfNIag1Ot61qgL5xc9dlxn1UNL1Ly4CYopbH7jg3eVqTuV6wcERxcsWXY8L2
         W+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/f14cHYF/JwNNEW7ZZ5tU2/Q+E6LWRIS5CopK+Dp/ws=;
        b=MmLGPJFe+MNPUakRnQIOI0LBDmko5s8TFQeSi23++u871ObTqdSQy+FN+m9jM4KGtm
         upAL1z5uTas4biqZ03XmEp9x92+R0kUBYMAX+WYohlnYQ4yiTTSeyr4IvYm4J9hs34c+
         o/R85MT+B3Msy9EzP3ATDCI8L6qeLjkBajZhRrCTCnbjQKB6ecGr3DcUM9OOF/9LYGFw
         iI98VeNt/r3UoKZUO4AvclZ/9G8ViL+syyYDIPVRCjvbjC/SbIDJB5nG3gYcZf0EhWnw
         +Me2x7EeO0/vxehOC13LRtQ3a3db82eIyVfsACSHDQOzpsEYz+PSQaH7Hja87J7QtHhh
         XK9Q==
X-Gm-Message-State: APjAAAW12u2uRpnCKWH17tu19tS5B5wBCTsW5P2oj5yKm9aEzXAGCecb
        UfEsykDJRl1beabTYJAIK+WWEvhjFq5ZgJrnnW8=
X-Google-Smtp-Source: APXvYqwtowx0jtZrX1Tnda+aSiwu1+T/1zNbO4rK+It/3z/Xya6kgIlPAocEw5taRgj7RNINbPtPoDBEuvrYufn2K4Y=
X-Received: by 2002:a67:f259:: with SMTP id y25mr53460097vsm.50.1560869161931;
 Tue, 18 Jun 2019 07:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLiBA9VjEoG_D2y2O5mKiqsDNW1VZXOk1eWXpGY+h86acg@mail.gmail.com>
 <CAOMZO5BcLaS0gXUPi6oN6vjqagS5yf+rHh+EUjmi-Wi1OX7vqQ@mail.gmail.com>
In-Reply-To: <CAOMZO5BcLaS0gXUPi6oN6vjqagS5yf+rHh+EUjmi-Wi1OX7vqQ@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Tue, 18 Jun 2019 20:15:50 +0530
Message-ID: <CAOuPNLgEEfDca4aeT1+q8GfUfGzbJ4x6JwGf-ROB1pgpXUBHSw@mail.gmail.com>
Subject: Re: [IMX] [DRM]: suspend/resume support
To:     Fabio Estevam <festevam@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 18, 2019 at 7:32 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Pintu,
>
> On Mon, Jun 17, 2019 at 10:50 AM Pintu Agarwal <pintu.ping@gmail.com> wrote:
> >
> > Hi All,
> >
> > I am trying to implement suspend/resume functionality to to imx-hdmi driver:
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/gpu/drm/imx/dw_hdmi-imx.c?h=v4.9.181
>
> Please test a recent kernel, such as 5.1.11. I recall that last time
> you reported an issue with the dw hdmi you were running kernel 3.10
> with backported patches from 4.9.
>
> Just tried suspend/resume on a imx6q board and HDMI behaves correctly.

Thank you so much for your reply.
Yes, I already checked the latest mainline kernel changes until 5.2-**.
I see that there are many cleanup related changes, but still I see
that suspend/resume functions are missing in dw_hdmi-imx driver.
So, I am trying to implement myself.
Also, I see that suspend/resume is missing even in :
drivers/gpu/drm/imx/ipuv3-crtc.c
I am trying this also (not sure if we need this as well).

Can you point out some specific patches which can be helpful ?

Currently, what I observed is that hdmi bind() functions are not getting called.
Not sure who is responsible for triggering this bind function.
Or, irq remains disabled after resume, and we need to enable it back
again (but how ?)
Or, we may need to enable vblank events and thus irqs can be enabled.

So, I am exploring many possibilities.
If you have any suggestions please let me know.

Thanks,
Pintu

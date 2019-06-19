Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF92B4BA5C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 15:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfFSNoV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 09:44:21 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43389 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFSNoU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 09:44:20 -0400
Received: by mail-lf1-f65.google.com with SMTP id j29so12158816lfk.10;
        Wed, 19 Jun 2019 06:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sh/qIBw1XKDUdQ0Wxpr8WG15MJA13mpU4YtnzOpaKLE=;
        b=OIdFgOcig0sQN7irVtXlKzuUYnNpdV1QiD1wZV9NUpIz3rzt9QrMhB2vZdMgO0dDZ5
         N05RhZia6MmkDuZ9lReuExcnttV/eCkIHQgXv/bZyL0H2+jP84zT/qvY96zXDf4iJop7
         UQyt7pn+TmFRgSRFTdk2qnP0JvNi5N6WNQWx0sWNnI/PczhgPk4YRwlkPDEM98kTV7wX
         Ei2qA5i40HrzUql+JbtY/4oYdMRtBrcpkVpmBHsd1GrLZcDURYD1zf2IPuovqT1PZ3jA
         NeBkY8lEZtzL6WQs4D644wb00nPn5IdFpZssFJDs5AGV5X4+jfZu2clZjaHYEiJUIIji
         Vokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sh/qIBw1XKDUdQ0Wxpr8WG15MJA13mpU4YtnzOpaKLE=;
        b=s3wPYw1fGvCo5/eGhk7T2Ytkub/vVuqcBPZqRZAITHzxfUAhCaI/k+TOBmbKJy7C+C
         ENwhoJi6Wv8zxnSkao+WHc4hXW5x9772k67IHIo91PElNvEl4fuNtfFf5uIZwmFF8lcR
         Hxn2oOW4FQR2W2l0ipWrB5qwurGbHBY87bNXlUgjfNsw/RfOv52iLEeOE00/WaD29EOj
         hvbkpZw0FPtD2Yicz5mpLqPWbuWcsP4oPWwkbPuFiUz9/O+yENLRpTpuu1oevniacxNy
         CNYlk1aEe+mW2OgqTUaQupIjwNiAOf1ZMWIXPi1nZeC7z/w293L8oXtpIrjlAXmHvsFa
         5T0w==
X-Gm-Message-State: APjAAAUWANhfHEOHB5uIvCGsRvbZYCrVdP1E9bqA2sTUnwt1bXZXkR3J
        8LY+daKT0KnpNiX+aVzEUbnm/1JAdf9SnrLR0Ks=
X-Google-Smtp-Source: APXvYqzIHC2qwwy1WwyVkFuivPy0ti/t0LmJDTX/uQQG/dGgpZBVy8Yf6Ax2JhyVKa5qoMS4Z7Nr8uBXW6Fx5oQqAF8=
X-Received: by 2002:a05:6512:29a:: with SMTP id j26mr28443954lfp.44.1560951858594;
 Wed, 19 Jun 2019 06:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLiBA9VjEoG_D2y2O5mKiqsDNW1VZXOk1eWXpGY+h86acg@mail.gmail.com>
 <CAOMZO5BcLaS0gXUPi6oN6vjqagS5yf+rHh+EUjmi-Wi1OX7vqQ@mail.gmail.com>
 <CAOuPNLgEEfDca4aeT1+q8GfUfGzbJ4x6JwGf-ROB1pgpXUBHSw@mail.gmail.com>
 <CAOMZO5BY8JcLNMCRCC_d=emy8HR6kE=dB9f5qfZ=ci_c+Jak0w@mail.gmail.com> <CAOuPNLjYhkP_kL+q-ZpiDZMMpOHrU88BFBc2agtnCzXt8dihOg@mail.gmail.com>
In-Reply-To: <CAOuPNLjYhkP_kL+q-ZpiDZMMpOHrU88BFBc2agtnCzXt8dihOg@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 19 Jun 2019 10:44:31 -0300
Message-ID: <CAOMZO5ADK1L5UMM9XZetHvmjTvmvUg99G7VPdeXitgpctGLCkw@mail.gmail.com>
Subject: Re: [IMX] [DRM]: suspend/resume support
To:     Pintu Agarwal <pintu.ping@gmail.com>
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

On Wed, Jun 19, 2019 at 10:33 AM Pintu Agarwal <pintu.ping@gmail.com> wrote:

> You can think that the version I am using right now is almost 4.9 itself.

"almost 4.9" does not help, sorry.

> Upgrading again to higher kernel version is again difficult, also
> customer does not want it.

dw-hdmi is well supported on i.MX6 with mainline, so you could simply try that.

Try booting 5.1.11 on your custom board with a very minimal dts with
HDMI support.

Then you can test suspend/resume and see if HDMI hangs or not.

> Another approach I tried is, installing hdmi {dw-hdmi.ko,
> dw_hdmi-imx.ko} as a module, just after the resume.
> With this also system hangs during installation of dw_hdmi-imx.ko at
> below location:
>
> imx_drm_driver_load(..)
> |
> |--> component_bind_all(...)
>      |
>      |-> component_bind(ipu)
>          |
>          |
>          ipu_drm_bind(..)
>          |
>          |-> ipu_crtc_init(..)
>              |
>              |-> ipu_plane_irq(..)
>              |
>              | ----> << __HANGS HERE__ >>

I am not able to reproduce this hang. As I mentioned yesterday
suspend/resume is working just fine.

We would be glad to help fixing the hang if you could reproduce it
with a mainline kernel.

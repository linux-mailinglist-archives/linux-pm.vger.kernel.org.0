Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17DAA4BA0C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 15:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfFSNdx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 09:33:53 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36441 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfFSNdx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 09:33:53 -0400
Received: by mail-ua1-f66.google.com with SMTP id v20so4476069uao.3;
        Wed, 19 Jun 2019 06:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/hOvNsnkdNjDa+A6/yfZ/Thg3iaWZ4X1bBVE79rdUH4=;
        b=ra8QE7eBnzaOXjOx0RMs0LZQe2kPZTC6xR1Rt/o70uPhVeniKXcCavDC3PrQDG92pU
         ErmTmVNphJLe6VZA2E7mn+lz4XP2Hn3Ji2Cdx9QWjH/COc1dbYOt0+uPQFwwzEzMXp8e
         6Jj9ID6vXj/RGBIMl0BSHp9hJqpX8Z+7HM1tpHFG9eYWrQJcSWJszuCedusibuJmFTpE
         i9HIKEvITQsMqq8gOYlNfKCUqAcMK/IoydTG2YSBI9duQVaA5JX7MoE1cKslCGoH8HxB
         fq+n3cIcrKOae3POoib/yOj4IxWA4FqsIoc48CljZJfyOTagnzo8yQHI/J0LW8zpNYd2
         hNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/hOvNsnkdNjDa+A6/yfZ/Thg3iaWZ4X1bBVE79rdUH4=;
        b=AuSFJlOnr+BtPE7lLc6/W0HplbQEyQGXq8F5ZBqQwqwa7mFzNL7CX+YTxMwWs1pI1v
         HZ8kXzNphbK6JSqXfGTm98/9YC9Lm9pP983q/ag8A/FcQs/TujsgzYK+ZnCjxJ3+uSHq
         E5GSXgkx3ND2Gh17MhPTP6iwqFPXjgkwr+gh/1FiQtJfemZKETMRSjTRaIXAA3DBKS62
         k9Osv4X67DJvuIkxA+APOn3UdlOTrwjkMzhUnAF+qLaxSdKxzJ9WBx/JhGHgzWuAJiYb
         HMW3qtXgTU3l4ynH81PD0d5DyUrZI8CpqPv+VhWDNHsBf9fkj+Ryc9qrMa+HVVsGkPdP
         oozg==
X-Gm-Message-State: APjAAAXZVdkDROgT+EbaOnsnnyeqNPY5y8OrjCh3duzx0asIIzBmPMUl
        u69aqcQnh0uiXdHA4CCOqG64julREpR13o4Rh1g=
X-Google-Smtp-Source: APXvYqzXc0QxvHUX0+Zq6+MSDbGCxesWmtXJbSYuo788EfEdCW+LbJBYo7MWWKhK0YKIbtRHuEZqD16YL5NCdT/noa4=
X-Received: by 2002:ab0:6988:: with SMTP id t8mr22144122uaq.49.1560951231950;
 Wed, 19 Jun 2019 06:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLiBA9VjEoG_D2y2O5mKiqsDNW1VZXOk1eWXpGY+h86acg@mail.gmail.com>
 <CAOMZO5BcLaS0gXUPi6oN6vjqagS5yf+rHh+EUjmi-Wi1OX7vqQ@mail.gmail.com>
 <CAOuPNLgEEfDca4aeT1+q8GfUfGzbJ4x6JwGf-ROB1pgpXUBHSw@mail.gmail.com> <CAOMZO5BY8JcLNMCRCC_d=emy8HR6kE=dB9f5qfZ=ci_c+Jak0w@mail.gmail.com>
In-Reply-To: <CAOMZO5BY8JcLNMCRCC_d=emy8HR6kE=dB9f5qfZ=ci_c+Jak0w@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Wed, 19 Jun 2019 19:03:39 +0530
Message-ID: <CAOuPNLjYhkP_kL+q-ZpiDZMMpOHrU88BFBc2agtnCzXt8dihOg@mail.gmail.com>
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

On Tue, Jun 18, 2019 at 8:39 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Tue, Jun 18, 2019 at 11:46 AM Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> > Thank you so much for your reply.
> > Yes, I already checked the latest mainline kernel changes until 5.2-**.
> > I see that there are many cleanup related changes, but still I see
> > that suspend/resume functions are missing in dw_hdmi-imx driver.
>
> Please see this recently submitted patch:
> https://lore.kernel.org/patchwork/patch/1084057/
>
Okay. Thank you for this reference. This can be definitely helpful.
But a quick look may be feel, this is slightly different.
Anyways, I will have a deeper look.

> > So, I am trying to implement myself.
> > Also, I see that suspend/resume is missing even in :
> > drivers/gpu/drm/imx/ipuv3-crtc.c
> > I am trying this also (not sure if we need this as well).
> >
> > Can you point out some specific patches which can be helpful ?
> >
> > Currently, what I observed is that hdmi bind() functions are not getting called.
> > Not sure who is responsible for triggering this bind function.
> > Or, irq remains disabled after resume, and we need to enable it back
> > again (but how ?)
> > Or, we may need to enable vblank events and thus irqs can be enabled.
> >
> > So, I am exploring many possibilities.
> > If you have any suggestions please let me know.
>
> The suggestion I have is to try to use latest mainline kernel. If you
> see any issues with it, please report.
>
> The combination you mentioned in a prior thread (kernel 3.10 +
> backported drm patches 4.9) is not really something the community can
> help you.

You can think that the version I am using right now is almost 4.9 itself.
Upgrading again to higher kernel version is again difficult, also
customer does not want it.
BTW, I am not talking about runtime suspend/resume.
I know it works normally.

I just need some approach and pointers.
Like someone said rightly, I may need to re-implement bind() function
again in resume path.
I already tried doing hdmi_power_on/off and with that I could invoke
hdmi_setup() function, but the system hang after that.

Another approach I tried is, installing hdmi {dw-hdmi.ko,
dw_hdmi-imx.ko} as a module, just after the resume.
With this also system hangs during installation of dw_hdmi-imx.ko at
below location:

imx_drm_driver_load(..)
|
|--> component_bind_all(...)
     |
     |-> component_bind(ipu)
         |
         |
         ipu_drm_bind(..)
         |
         |-> ipu_crtc_init(..)
             |
             |-> ipu_plane_irq(..)
             |
             | ----> << __HANGS HERE__ >>
             |
             |-> devm_request_irq(ipu_irq_handler)

So, ipu_drm_bind() never returns, and hangs.
----------
So, my question is, which approach is better (as a first trial):
1) Installing hdmi as a module, after resume ?
2) Or, implementing the suspend/resume itself ?

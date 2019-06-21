Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC4EA4EB99
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2019 17:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfFUPNG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jun 2019 11:13:06 -0400
Received: from mail-ua1-f45.google.com ([209.85.222.45]:34715 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfFUPNF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jun 2019 11:13:05 -0400
Received: by mail-ua1-f45.google.com with SMTP id c4so3141803uad.1;
        Fri, 21 Jun 2019 08:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zXpqDxLfIfBJYYRkrryXotHeuidmyZAFttzUi4vHcZ8=;
        b=QtvZ8Caqy3Wd/V+8GkF4ZDcxgC1HDyeytgaDVWRX/AWNPdSuaPd+lCKUIN4BRKFLEt
         2nkUJcDcAA8tP4Xv5RH8b0XdGIw53gLwURKJr3peTUyU+lSdbw2rIoH96x+otXE4awDQ
         GM8fODsYP7mv/dMJslqR81lOwMdR9dq+u0ZIgzlaw67LJBTNd1btB0TEv0RoxzdaDkPg
         1iZtD/0L1klrJe/sWBTWjV8ds8+3mfFoSqS39ft3bSLdLxkptb4r55ImsRVOlP1+zkQ3
         56Q8d0SuIAoYq3WkJ9sXOINgFaWLxsPCmPclIbEB5SK6Jrnwq0mnNBbEIHbIvbaA+DlX
         6m5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXpqDxLfIfBJYYRkrryXotHeuidmyZAFttzUi4vHcZ8=;
        b=J/jIPlMj98cQr8RJ1sI06qjohEhexOfCiaNmeti2Kcod9p5fzslFuBCJJt8AMVWx4V
         lguIBS6jwtSeRx/pyn/aj6Zr/Lr8NgSrCyezAR1l73b+YFoyFVfRbQoEVAtr02l8PR/S
         zCtge/BkXW/CM8QNBDHIa7OZiVcSE1+/FXXOupDnJTu6SqkKSLRFqmRXVL3ashiv93UK
         hAT1KQYClzMghZY2sF5BkxWuz9v2ma2qK3EW6/bdAVk8UFXBQHJTr2nDrjDp2xGVLOyF
         t+tBbTPMQTTl6wXAnv2m8IZuLdCBVcL6hw+BscbM6BvFPGwFs3TMAP/eGmcjuUuhWQlX
         vzDg==
X-Gm-Message-State: APjAAAVcti3RlY7z8n148y/YK7xki0iNNlYYjSI2KJwUkVChVYPsBSyv
        3KEdvsz5vSsY23eMMzIKilzpgqVvL0c19LN71/A=
X-Google-Smtp-Source: APXvYqxq5W/TRSvncldtz8iA0RwP6LGygzVHQZ26gcAflq59Xaw8C/VKTE5QdEWv+gLzgMtBZqD/vC1l6+JWvJfv52I=
X-Received: by 2002:ab0:4744:: with SMTP id i4mr21428220uac.63.1561129984537;
 Fri, 21 Jun 2019 08:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLiBA9VjEoG_D2y2O5mKiqsDNW1VZXOk1eWXpGY+h86acg@mail.gmail.com>
 <CAOMZO5BcLaS0gXUPi6oN6vjqagS5yf+rHh+EUjmi-Wi1OX7vqQ@mail.gmail.com>
 <CAOuPNLgEEfDca4aeT1+q8GfUfGzbJ4x6JwGf-ROB1pgpXUBHSw@mail.gmail.com>
 <CAOMZO5BY8JcLNMCRCC_d=emy8HR6kE=dB9f5qfZ=ci_c+Jak0w@mail.gmail.com>
 <CAOuPNLjYhkP_kL+q-ZpiDZMMpOHrU88BFBc2agtnCzXt8dihOg@mail.gmail.com>
 <CAOMZO5ADK1L5UMM9XZetHvmjTvmvUg99G7VPdeXitgpctGLCkw@mail.gmail.com>
 <CAOuPNLhZhgN26rquLQq9zHBct1QxK-7hXAza0xk-0QooPGYLNw@mail.gmail.com>
 <CAOMZO5BsJWTw0nCeUboam4kuKyCO3N_Ch5ZW8k5Y9KFtQBanhQ@mail.gmail.com> <CAOuPNLjrAU_C_TUKFMs1d0eGsw=AxuG6d6FhNHtHFwVhfYZGgA@mail.gmail.com>
In-Reply-To: <CAOuPNLjrAU_C_TUKFMs1d0eGsw=AxuG6d6FhNHtHFwVhfYZGgA@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 21 Jun 2019 20:42:53 +0530
Message-ID: <CAOuPNLhstoCjxijrnKNmV1iKWjAXvSZ38Z13tfd5bvGbYSqPAA@mail.gmail.com>
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

On Wed, Jun 19, 2019 at 8:59 PM Pintu Agarwal <pintu.ping@gmail.com> wrote:

> > > This scenario is not with suspend/resume.
> > > This hang is, when we make hdmi as a loadable module (.ko) and trying
> > > to install it after resume.
> > > In this case, suspend/resume will not come into picture. Not sure why
> > > it still hangs.
> > > Do you have any clue for this scenario?
> >
> > I haven't tried this one.
> >

Okay there is some update on the 2nd part.
Now I am able to successfully install all imx modules after the resume
(no hang).
But, I got some errors after install finish:
[drm] disabling vblank on crtc 1
[IMX]: imx_drm_disable_vblank - called
[drm:drm_atomic_helper_commit_cleanup_done] *ERROR* [CRTC:24:crtc-0]
flip_done timed out

Also I am able to start the weston successfully.
But I see LCD/HDMI display is not working (only some backlight is visible).

And, I noticed, weston also reports the following errors:
imx-ipuv3 2400000.ipu: DC stop timeout after 50 ms
[IMX]: drm_crtc_vblank_off - called
[IMX]: imx_drm_disable_vblank - called
INFO: rcu_preempt detected stalls on CPUs/tasks: { 1} (detected by 0,
t=6002 jiffies, g=289, c=288, q=8)
Task dump for CPU 1:
weston          R running      0   306      1 0x00000000
[<c05282d8>] (__schedule) from [<00080193>] (0x80193)

Do you have any clue about these errors ?

Thanks,
Pintu

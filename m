Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98D174BC52
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 17:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfFSPFI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 11:05:08 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39768 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfFSPFI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 11:05:08 -0400
Received: by mail-ua1-f68.google.com with SMTP id j8so10173460uan.6;
        Wed, 19 Jun 2019 08:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pkwqFDU1m9y1SmwwSPbuxARBXbcsz4Hg+ImtIjkxe0I=;
        b=fU0DJtyNLrcixK/O0KvTyH0V+rJYMHK4QbYcOjT2Rh7QaHKwWZOt+i3x+KCpYcfPVe
         /ifw9OBIcAIwu0gj3TlxpRPlmtzmnNdySQvWwbR7E3+WQWLRc6A4icFLP5pupx82L+4K
         GjG7iQvhlJi5aPBzh2l1p5k44weDEcw0zJHTLqTx6hMNG5bkDtHRrTD0ajwbF47PvVvB
         1+RMqBuvg1de+T4WXa44lUd0lF42/Sf2Kqb8mqtmqoUoTToWxAAX6qeumOA/DdjL9W2D
         atuV1iDF4pnKrsCvPOYsoUKV/RlDsYZjwv8KtKUHaqlYGtw+ek1WErJN8v/kIHXqN1+7
         T3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pkwqFDU1m9y1SmwwSPbuxARBXbcsz4Hg+ImtIjkxe0I=;
        b=DVFv1xuwwzCLM42DYZVrkKgx+0ykSGA3YraB7h09H0Nhej0hWBGEG1XMdHTEtYa8Ri
         pzSsSziVCgWK9w2X8v7DiNkZK+M3VfRHcl+u26WLaQuWpDIUKyt9RgNJXQkOSyL3ZBqA
         PtsmAJhn7oW9NGvCmzg+Pdpsf9/r7QMuO4dzqKDTeu52hCslHLyLHrHvALN3naHR3ib8
         W9stPb//Ik00uymV/yr+0K8+tgDNMd6bUYnbrRePXD4ynQ6ItlisPECZIKmzBpJzbFmq
         3vikrtNtagYzU+mV3is3r5HZ+k7GQVA1C52VW/AgjRD+fIuoB9c8ljRLgQm80IHbqUrF
         2ePw==
X-Gm-Message-State: APjAAAVbrXaP5FzpMi+Edn1S81x08KJV53BGqRgIw+PmigSGswHzfu0Z
        /GEaYDbVHM9GC0HggVb9ssYqPUwUT1AhWV1yC0A=
X-Google-Smtp-Source: APXvYqwK/xA+axdU8X8NLuJu0qn2jf1SXM8PkR8+V9KMrB2p3kYXqlcm7OSWbUsoqisq6XlVx7wqtBrHHdaDOCqLpxs=
X-Received: by 2002:a67:e419:: with SMTP id d25mr6657505vsf.196.1560956706613;
 Wed, 19 Jun 2019 08:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLiBA9VjEoG_D2y2O5mKiqsDNW1VZXOk1eWXpGY+h86acg@mail.gmail.com>
 <CAOMZO5BcLaS0gXUPi6oN6vjqagS5yf+rHh+EUjmi-Wi1OX7vqQ@mail.gmail.com>
 <CAOuPNLgEEfDca4aeT1+q8GfUfGzbJ4x6JwGf-ROB1pgpXUBHSw@mail.gmail.com>
 <CAOMZO5BY8JcLNMCRCC_d=emy8HR6kE=dB9f5qfZ=ci_c+Jak0w@mail.gmail.com>
 <CAOuPNLjYhkP_kL+q-ZpiDZMMpOHrU88BFBc2agtnCzXt8dihOg@mail.gmail.com> <CAOMZO5ADK1L5UMM9XZetHvmjTvmvUg99G7VPdeXitgpctGLCkw@mail.gmail.com>
In-Reply-To: <CAOMZO5ADK1L5UMM9XZetHvmjTvmvUg99G7VPdeXitgpctGLCkw@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Wed, 19 Jun 2019 20:34:55 +0530
Message-ID: <CAOuPNLhZhgN26rquLQq9zHBct1QxK-7hXAza0xk-0QooPGYLNw@mail.gmail.com>
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

On Wed, Jun 19, 2019 at 7:14 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Wed, Jun 19, 2019 at 10:33 AM Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> > You can think that the version I am using right now is almost 4.9 itself.
>
> "almost 4.9" does not help, sorry.
>
> > Upgrading again to higher kernel version is again difficult, also
> > customer does not want it.
>
> dw-hdmi is well supported on i.MX6 with mainline, so you could simply try that.
>
> Try booting 5.1.11 on your custom board with a very minimal dts with
> HDMI support.
>
Okay. I will surely try it on another IMX6 fresh board.
With 5.1.11 you mean the kernel from mainline kernel.org
Or, is there a separate kernel repo for imx6. If yes, please let me know.

> Then you can test suspend/resume and see if HDMI hangs or not.
>
By this suspend/resume, you mean "suspend-to-ram" or "suspend-to-disk" ?

> > Another approach I tried is, installing hdmi {dw-hdmi.ko,
> > dw_hdmi-imx.ko} as a module, just after the resume.
> > With this also system hangs during installation of dw_hdmi-imx.ko at
> > below location:
> >
> > imx_drm_driver_load(..)
> > |
> > |--> component_bind_all(...)
> >      |
> >      |-> component_bind(ipu)
> >          |
> >          |
> >          ipu_drm_bind(..)
> >          |
> >          |-> ipu_crtc_init(..)
> >              |
> >              |-> ipu_plane_irq(..)
> >              |
> >              | ----> << __HANGS HERE__ >>
>
> I am not able to reproduce this hang. As I mentioned yesterday
> suspend/resume is working just fine.
>
This scenario is not with suspend/resume.
This hang is, when we make hdmi as a loadable module (.ko) and trying
to install it after resume.
In this case, suspend/resume will not come into picture. Not sure why
it still hangs.
Do you have any clue for this scenario?

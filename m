Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E73313925A
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 14:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgAMNmz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 08:42:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52448 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgAMNmz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 08:42:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so9728585wmc.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2020 05:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zJrfuhvY4deSpuDK2tf/dm3JvOsouNbsqMAp9wxIM1M=;
        b=KMPbZcnz9vukXKprPKOdWKj37bmBltDFfwldexD0qpEQ7goAhIIQLRSymM8xmxNip3
         dlpK6Uu4TK8esQQhi5jfSu1zr0yBb4Q2J+VhHQqhShG0JRmoG+6E/7MRv9djJ+GAFRXb
         4wNbWtTS6UxvCoN7xW0q3U49nwTr+EZKxhenreWS/3IaZMmfVyya2WQw/IjMSCHk87sa
         JLMKiVYgeLMr3nBgKzFAz7z1irK1f/IgVpMehvGqJfgzaf7LLQFGEJkcUpqMBzKyypIA
         YMPe66tjv7UByVF4UpCM/XX64cJ492jgO/qbwHGqpTe2Ymqgnu+UWda7NJyrAIglW49y
         Iftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zJrfuhvY4deSpuDK2tf/dm3JvOsouNbsqMAp9wxIM1M=;
        b=n1563ldq2QMf8PGFruTx7napyekSl51i1v1bisI+ShFuLEnOAupP2jSVTltfanbb33
         I1JvedCsiGojgC9agVAQG5AyUMwcXyNND58gZrHZLopiaUMJileEtn/X9A4sSf8JLazA
         eH3cptwvyW1IQe3chl5yYosBcqYeJJt+gCXf0DbTC81gXe8DCblTp+nPz90NBuYuLPpm
         eM170MrWKAXwwTY1SCPNgXOGtWG7xi1pxlkxLnwFqFTTW8jNtaPFAust+KpaNd7mwAEu
         HqCNW4Y+eSA9Jyzi48ntyBakuAoDdgvEAMee4RjfQ7i1EXfRTXUfZ6RzpOyH7HdxzFAG
         UnaQ==
X-Gm-Message-State: APjAAAXQ6d83+ozVKuT8O2+yYCalJ7itCGF95hnRT3FjC3U9otPausbB
        4V4VmDze8TsGoaFGweoGf0p7c/F+uDfyxZ5XNd4E3Q==
X-Google-Smtp-Source: APXvYqwRZG5006daKrcHDqU3irnIL6xTWPGqAzROYb6FqiJu3vuxf/DZg7ciW9xTIR2Aj4VCatLdKHWL5NFMYx4ApfU=
X-Received: by 2002:a7b:c3d8:: with SMTP id t24mr19619056wmj.175.1578922973019;
 Mon, 13 Jan 2020 05:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20191223211309.GA4609@sig21.net> <20200113092604.GA26365@sig21.net>
 <2661668.lOhekKA4Va@kreacher>
In-Reply-To: <2661668.lOhekKA4Va@kreacher>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 13 Jan 2020 14:42:41 +0100
Message-ID: <CAG_fn=WZTyaeG=Vy3XqX84gMOob3KKVWHM6G9=mEGe3XA7sfKA@mail.gmail.com>
Subject: Re: init_on_free breaks hibernate
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Johannes Stezenbach <js@sig21.net>,
        "Acked-by: Kees Cook" <keescook@chromium.org>,
        "Acked-by: Michal Hocko" <mhocko@suse.cz>,
        linux-pm@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 13, 2020 at 12:07 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrot=
e:
>
> On Monday, January 13, 2020 10:26:04 AM CET Johannes Stezenbach wrote:
> > Hi,
> >
> > On Mon, Dec 23, 2019 at 10:13:09PM +0100, Johannes Stezenbach wrote:
> > > I upgraded the kernel on one of my machines to 5.3.18 (from 5.2.x)
> > > and found it failed after resume from hibernate due to what seemed
> > > to be memory corruption. I had a hunch it could be related to
> > > CONFIG_INIT_ON_ALLOC_DEFAULT_ON or CONFIG_INIT_ON_FREE_DEFAULT_ON,
> > > and a quick web search found this which seems to confirm:
> > > https://bbs.archlinux.org/viewtopic.php?pid=3D1877845#p1877845
> > >
> > > I rebuilt the kernel with CONFIG_INIT_ON_FREE_DEFAULT_ON disabled,
> > > and hibernate works again.  I'm fine with this workaround and
> > > just wanted to share this information.
> > >
> > > The commit that introduces CONFIG_INIT_ON_FREE_DEFAULT_ON:
> > > 6471384af2a6 mm: security: introduce init_on_alloc=3D1 and init_on_fr=
ee=3D1 boot options
> >
> > I tested 5.4.11 and current git master (b07f636fca1c8)
> > in Qemu and was able to reproduce the issue in both.
>
> Let's add more people and the LKML to the CC.
>
> Alex, Kees, Michal, any comments?
Hm, I cannot think of a reason for initialization to break hibernate
off the top of my head.
Maybe after hibernation certain pages land in the page freelist
without being wiped?
I'll try to reproduce this problem locally.

> > Basically I followed the description here
> > http://ncmiller.github.io/2016/05/14/linux-and-qemu.html
> > to build a minimal image using busybox (I'm using
> > the binary from Debian's busybox-static package),
> > then added s swap image (-drive file=3Ddisk.img,if=3Dvirtio),
> > do "mkswap /dev/vda" the first time.
> >
> > hibernate: swapon /dev/vda; echo disk >/sys/power/state
> > resume: echo 254:0 >/sys/power/resume
> >
> > Since busybox is very light on memory usage it doesn't
> > trigger immediately, but these commands seem to do it
> > reliably:
> >
> >   dmesg | gzip >/dev/null
> >   find /sys | bzip2 | sha512sum
> >
> >
> > my initramfs:
> >   6012997      4 drwxr-xr-x   4 js       js           4096 Jan  8 21:25=
 initramfs
> >   6022584      4 drwxr-xr-x   2 js       js           4096 Jan  8 21:21=
 initramfs/dev
> >   5909013      4 -rwxr-xr-x   1 js       js            514 Jan  8 21:25=
 initramfs/init
> >   6012998      4 drwxr-xr-x   2 js       js           4096 Jan  8 20:41=
 initramfs/bin
> >   5909011   1904 -rwxr-xr-x   1 js       js        1945856 Apr  1  2019=
 initramfs/bin/busybox
> >   5909012      0 lrwxrwxrwx   1 js       js              7 Feb 14  2018=
 initramfs/bin/sh -> busybox
> >
> > my /init:
> > #!/bin/sh
> >
> > PATH=3D/bin
> > export PATH
> >
> > # Create dirs
> > /bin/busybox mkdir -p /proc /sys /etc /tmp /usr
> > /bin/busybox ln -s /bin /sbin
> > /bin/busybox ln -s /bin /usr/bin
> > /bin/busybox ln -s /bin /usr/sbin
> > # Create all the symlinks to busybox
> > /bin/busybox --install -s
> >
> > mount -t proc proc /proc
> > mount -t sysfs sysfs /sys
> > mount -t devtmpfs devtmpfs /dev
> >
> > echo -e "\nBoot took $(cut -d' ' -f1 /proc/uptime) seconds\n"
> >
> > # shell where ^C works
> > setsid busybox cttyhack sh
> > # avoid "PID 1 exited" oops
> > poweroff -f
> > ---------
> >
> >
> > qemu-system-x86_64 -m 128 -enable-kvm \
> >   -kernel ../linux/arch/x86/boot/bzImage \
> >   -initrd initramfs.cpio \
> >   -drive file=3Ddisk.img,if=3Dvirtio \
> >   -nographic -append "console=3DttyS0 init_on_alloc=3D1 init_on_free=3D=
1"
> >
> >
> > Johannes
> >
>
>
>
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBE213949C
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 16:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgAMPSa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 10:18:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39693 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgAMPS3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 10:18:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so10081228wmj.4
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2020 07:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t7FO5hsWp93uc+DHcVfF9nMHSxNEUVmCdVeIVTw/6WQ=;
        b=wOWisS6AJAHdpdm0m5U9aQfrku3u1eUCzqdQL2QpLqfy9PjjDA/AwArNrlVY5AnAf2
         KKfCMP2eyvBpKNRaDO4iQ2yyGqGeD/Et23wzAFUSlAlKt2s+2d05a2sDgy3lXIjmgRgW
         rtd7TsZe1pkyteH+e0cU4jV6RP+QgRSxk3BxA+Rw5+0aoW4iVME+l6vXjt3HtmjetpRd
         MXO5/JHR54bzzROpBoxStAtExgG8HXtqNkkClj2zKzDC8sWKzkXz0XCrYlMcbKQpdbRk
         7JTPXVkkUOJDwNBXawun7NwFb4gC5XQtL5PGvgJGqlrkeJCyCoRZOD5hMNOpDaH65w5a
         NmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t7FO5hsWp93uc+DHcVfF9nMHSxNEUVmCdVeIVTw/6WQ=;
        b=YIqAE3Eehh6XkTXN1iJC0ag3E5KzxiWx/0fZiA+Sb+OLILOe/q9snA8aK+umO2kT1q
         uurKfI81SUj/SWuO8y30o3EcVyFgnrZrZu+6KUuMMf/xiSHkPMD/NAeL8AZkvbvgLwVe
         PrRKtK2AiKHiOe7OqGCLf9n/Qkx0tJRC98SklCj8mzHH8dRkIOHD/iLpt6gICHGupszY
         Ug0aH0gtJxpjFn48UrxTBjeKneTwpz9t6jaRE0uHuX/IeNZ+rLHUP4sOVxTHFoI6sENc
         MmhCHSKTL/P0T8cJZDa8jqUtl0sCDmWM1wZDHk3/hW9FLl6q/57cW6RGmUAk/v+Rx+Pw
         oVeg==
X-Gm-Message-State: APjAAAWM5P9pMgQ1es85SXucDRfM3geC7oRn+jgs/Xi0xdWilRRhZTRF
        jQfG/cxR/B4P6LhCbzYwCYxlGrZP4B8WXStgRswwAQ==
X-Google-Smtp-Source: APXvYqz111v1WQE1b9dVZCabuYwAxr/W2Pwh/YmWHzlNl8A5JhGfI0NTr7xrnnsOOZSIqTszX2p9+r2ab4SpoWC0/04=
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr20622709wmj.117.1578928707493;
 Mon, 13 Jan 2020 07:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20191223211309.GA4609@sig21.net> <20200113092604.GA26365@sig21.net>
In-Reply-To: <20200113092604.GA26365@sig21.net>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 13 Jan 2020 16:18:03 +0100
Message-ID: <CAG_fn=WSUGq_UZZOCQRbaKDE01yA6dLLqToOBWZ=0s5uxMwatw@mail.gmail.com>
Subject: Re: init_on_free breaks hibernate
To:     Johannes Stezenbach <js@sig21.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.cz>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 13, 2020 at 10:26 AM Johannes Stezenbach <js@sig21.net> wrote:
>
> Hi,
Hi Johannes,

> On Mon, Dec 23, 2019 at 10:13:09PM +0100, Johannes Stezenbach wrote:
> > I upgraded the kernel on one of my machines to 5.3.18 (from 5.2.x)
> > and found it failed after resume from hibernate due to what seemed
> > to be memory corruption. I had a hunch it could be related to
> > CONFIG_INIT_ON_ALLOC_DEFAULT_ON or CONFIG_INIT_ON_FREE_DEFAULT_ON,
> > and a quick web search found this which seems to confirm:
> > https://bbs.archlinux.org/viewtopic.php?pid=1877845#p1877845
> >
> > I rebuilt the kernel with CONFIG_INIT_ON_FREE_DEFAULT_ON disabled,
> > and hibernate works again.  I'm fine with this workaround and
> > just wanted to share this information.
> >
> > The commit that introduces CONFIG_INIT_ON_FREE_DEFAULT_ON:
> > 6471384af2a6 mm: security: introduce init_on_alloc=1 and init_on_free=1 boot options
>
> I tested 5.4.11 and current git master (b07f636fca1c8)
> in Qemu and was able to reproduce the issue in both.
>
> Basically I followed the description here
> http://ncmiller.github.io/2016/05/14/linux-and-qemu.html
> to build a minimal image using busybox (I'm using
> the binary from Debian's busybox-static package),
> then added s swap image (-drive file=disk.img,if=virtio),
> do "mkswap /dev/vda" the first time.
>
> hibernate: swapon /dev/vda; echo disk >/sys/power/state
> resume: echo 254:0 >/sys/power/resume

Resuming doesn't work for me in your setup with upstream kernel and
init_on_alloc/init_on_free disabled.
To hibernate, I did:

# mkswap /dev/vda
Setting up swapspace version 1, size = 268431360 bytes
[   17.128392] random: mkswap: uninitialized urandom read (16 bytes read)
# swapon /dev/vda
[   19.191236] Adding 262140k swap on /dev/vda.  Priority:-2 extents:1
across:262140k
# echo disk >/sys/power/state

, which succeeded:

[   19.867905] PM: hibernation entry
[   19.876320] Filesystems sync: 0.000 seconds
...
[   20.278736] PM: Image saving progress: 100%
[   20.279739] PM: Image saving done
[   20.280232] PM: Wrote 44036 kbytes in 0.12 seconds (366.96 MB/s)
[   20.281340] PM: S|

Then QEMU stopped, so I had to restart it.
Simply running:

# echo 254:0 >/sys/power/resume

didn't do the trick, I saw the following line in dmesg:

[   57.558499] PM: Image not found (code -5)

I tried doing swapon again, but it also didn't work:

# swapon /dev/vda
[  105.415845] Unable to find swap-space signature
swapon: /dev/vda: Invalid argument

Could it be so that the contents of /dev/vda didn't survive the reboot?

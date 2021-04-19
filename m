Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E3B3646F0
	for <lists+linux-pm@lfdr.de>; Mon, 19 Apr 2021 17:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240908AbhDSPRe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 11:17:34 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:34314 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240100AbhDSPRd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Apr 2021 11:17:33 -0400
Received: by mail-oi1-f173.google.com with SMTP id k18so30834238oik.1;
        Mon, 19 Apr 2021 08:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6QFU6W/Yv/iff9BYtQjDyNQVSjl+oi9h9IVTK+LWn9A=;
        b=Ct746Jz/HL5B4idhWThfdFgElUvRuv/e8+F1aSeu5xdg7R+paFyMTgM2n28j+mmR/L
         vgxl2T1erfyJUz/O8R4U+2gmsGIIF5MmR3MfJ8Vktkso6gtTaNf12pOCBdGdqhKcsh72
         VYyIxJ3cSr/JOjn9d2CkMV98gr4AxiOxSE+XFmHPEmsttpY0smsTS9EuE0+E5M45MChX
         DI+T3tPhhd9LlVLH9MRpyXZkSODgN1eS5s5NrSvg02v5TwEyrbARUnkdFI6+BZJYUt57
         O9VG3943SRkzl10q3ad/9j9v0/e1JxY//QXg9gy2c/Thz3oEdNRWoLj5LbyvVruj/1JI
         qeEw==
X-Gm-Message-State: AOAM531+yxRr83RoOaUAB5jC7GlhnkgYD+kIRAv0fqL1nmJvWiZjFnMb
        Kl72cLZfgIlFkwNoMXBS1Y1YVATIq+7hk/khErc=
X-Google-Smtp-Source: ABdhPJxshSfiDj1WCzvK2Tr9dl53s6FXlT8y20rKxihqfzwfPfTf5vYUMLNzXPZIps9ZtwPKMFVqdAgLwljAF+IYa7A=
X-Received: by 2002:aca:bc89:: with SMTP id m131mr7955057oif.71.1618845423618;
 Mon, 19 Apr 2021 08:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210418060800.8833-1-sebastian.fricke@posteo.net>
 <794c957472f826b0f2860aecd365376266e2253a.camel@perches.com>
 <20210418091143.6h466qqd52uf766z@basti-TUXEDO-Book-XA1510> <3886b37dacd9fcf84d5211322807128e638a8222.camel@perches.com>
In-Reply-To: <3886b37dacd9fcf84d5211322807128e638a8222.camel@perches.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 19 Apr 2021 17:16:52 +0200
Message-ID: <CAJZ5v0j0ZVqydWDhxWbvVrYW7cvc-bTWUdNwq5sZYyAbgJsTAg@mail.gmail.com>
Subject: Re: [PATCH] base: power: runtime.c: Remove a unnecessary space
To:     Joe Perches <joe@perches.com>,
        Sebastian Fricke <sebastian.fricke@posteo.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 18, 2021 at 11:22 AM Joe Perches <joe@perches.com> wrote:
>
> On Sun, 2021-04-18 at 09:11 +0000, Sebastian Fricke wrote:
> > Hey Joe,
>
> Hi Sebastian.
>
> > On 18.04.2021 00:09, Joe Perches wrote:
> > > On Sun, 2021-04-18 at 06:08 +0000, Sebastian Fricke wrote:
> > > > Remove a redundant space to improve the quality of the comment.
> > > I think this patch is not useful.
> > > It's not redundant.
> >
> > Thank you, I actually found this pattern a few more times but I wanted
> > to check first if this is a mistake or chosen consciously.

I write a double space after a period ending a sentence as a rule and
it is not a mistake.

> []
> > > For drivers/base/power/runtime.c, that 2 space after period style is used
> > > dozens of times and changing a single instance of it isn't very useful.
>
> Even in that single file it's not consistent.
> It's something like 3:1 for 2 spaces over 1 space after period.
>
> I believe it's done more by habit and author age than anything.
> If you learned to type using a typewriter and not a keyboard, then
> you likely still use 2 spaces after a period.

By habit and because I prefer it this way (I find it somewhat easier
to separate sentences from one another this way).

> > True and if I understand you correctly you would rather keep it as is
> > right?
>
> Yes.  IMO: Whitespace in comments like this should not be changed
> unless there's some other significant benefit like better alignment.

Agreed.

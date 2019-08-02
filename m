Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD65B7FBD8
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2019 16:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388957AbfHBON2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Aug 2019 10:13:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41603 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389189AbfHBON1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Aug 2019 10:13:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so25794008pgg.8
        for <linux-pm@vger.kernel.org>; Fri, 02 Aug 2019 07:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5treBjW4ojfofZKzbstHsda4v5OqUABJGRx6t6ZH9CA=;
        b=DXHR6ABYqH0h3ErX1CGCyj9oFdGOkuWQz5xaeVmLGPxQHExg2mLZ8afYJcvtHmuXqE
         L20AgP7+xUJ4V7qAQs5B/BJ11bjm8pSt9u+EnbShqDMGU0uhL+rRktj+PNPGxttUDcUO
         IHhV4g3O+mQnpNSZgujQMBw0vY29Y5UlWzexdAaWhAtBOlJ7D06vuhabLGuonB0TomkS
         5SlnmCjTIB5CDwJrozyi7Go3G8ThnoANR0iexUYoHhIr0PjXnnJdp3HWMh0wexSPboUD
         +C8GOmO09pobgglUY/dTY1X3abZWEATbRdfmlraPBN2dxmD5GKuMW7DdLI3cpjayxpml
         TVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5treBjW4ojfofZKzbstHsda4v5OqUABJGRx6t6ZH9CA=;
        b=fG1ART5t8E7k4LVJPFFUmN9mMVvCbVY0UdiJzEiRy034UE22PfMX86cxfQSRlDONq9
         D0MB51fy5TADepTAiNnMtacyp447QhCfIwXD2cfKWt69HvZwiK9m3i58/fP47byHXA/1
         O0+R5+lFbQnNZ86hCau+R+fdatM1a+VgDD52SLSTPVhqOz63p6uwVoqopslnI/6eSW7p
         amVLl7M9HXs10mm2+2ytspARaE8d57rQZmzP+8rOi9u5SYgqLqKdliIYYAMYOLcrHBwz
         mafg3hc1oLJGEHyRLbqOPz4k6J/u+QaZyvBk3FcZ2vblPPo9frkVYCYQeX7dakIAXdw2
         8G5w==
X-Gm-Message-State: APjAAAWBtwE2O55YiKOVjSpObwVmd/Dj0GWKOUHA9MHbbcaU82vwF4wM
        LLSZqi8dbDqnFvComN4Cr2s5PGbkeaD6pcGzDQxoiQ==
X-Google-Smtp-Source: APXvYqzJzMIq2BOAXKkfk2ONCggXPJ354hGozdppgPTsk/gVMr7/MXdnjVkdh4xqKYqTMjZSIuwIvWZwZ8GOnQ6Cmbo=
X-Received: by 2002:a65:4b8b:: with SMTP id t11mr123928876pgq.130.1564755206144;
 Fri, 02 Aug 2019 07:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cd0435058f21e8c3@google.com> <20190802133317.GA5538@amd>
In-Reply-To: <20190802133317.GA5538@amd>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 2 Aug 2019 16:13:15 +0200
Message-ID: <CAAeHK+ziKCz=SZss7mnWZWQXWBGyXkw5dcPfjdH-6MJLUJqO8Q@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in __pm_runtime_resume
To:     Pavel Machek <pavel@denx.de>
Cc:     syzbot <syzbot+b156665cf4d1b5e00c76@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        len.brown@intel.com, LKML <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        rjw@rjwysocki.net, syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 2, 2019 at 3:33 PM Pavel Machek <pavel@denx.de> wrote:
>
> On Fri 2019-08-02 05:58:05, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=146071b4600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=792eb47789f57810
> > dashboard link: https://syzkaller.appspot.com/bug?extid=b156665cf4d1b5e00c76
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
>
> I asked a question, noone bothered to reply, yet you spam me again?
>
> You are a bad bot. Go away. Come back when your human master is
> willing to communicate.

Hi Pavel,

What was the question that you've asked and where did you send it? I
can't find anything in my inbox.

Thanks!

>
>                                                                 Pavel
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8834371DA0
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 19:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391028AbfGWRZ7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 13:25:59 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42895 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfGWRZ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 13:25:59 -0400
Received: by mail-qk1-f196.google.com with SMTP id 201so31694602qkm.9
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 10:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EUphuEwrZLhheaivYxOs3+IP5xczivEPWWhKQbWqQ58=;
        b=RUIRiGCv3r2B0G7EM/oszmuYFak/HPhbNhHVHSOw6GfhPSmI27qdHWWzbjPLNujhku
         vKvw7tsmMJcEem2MDYaqZvuSLJ+iVj0LkkO4QOSg7LaEoNGsY+6N8l8XrAF++jqBK+Jp
         yy0Bt21MGZqulZ68hVt935Qosr6mEE0Br7sgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EUphuEwrZLhheaivYxOs3+IP5xczivEPWWhKQbWqQ58=;
        b=ZoPvOxG/Ts8rqHUQkOu+2/s2gnxgni+6Om97DIRuxAY7GMxxrXHvdFhD9SsAOZ1Amn
         tlZWpgx1tEumfTMqaGU3yxZsDGWzojV7vRCHvJwwKmGjuQwyvMo1c0UK9jvPMKRACYJk
         fdc1xp7ghfKpGmdaoBWkJ2BCd9dl0YvOfrxWmvxVSF+3ZAE9hs+xvtnEOfai+D5RSykj
         fSIkaamrAM0fRPdInFVTsnay7sjx9Uoc0eleBMra6grSDiLGzB2bupXqzT80K4h6Nkb1
         Yd7iI6f8LTKToRvy+R3ZrZsjR+PACWN3IkwqMZ5yRzEooCUerO+10tzemdnZagLi0BhS
         mTWA==
X-Gm-Message-State: APjAAAXx6a2iPP7O3w7vfL5GvouTyA5IRJKx4uTyVY1C1nB2izPIFaKL
        wng0RmO8+hPvsRoEvj2T0SW6EaXxos1oMUOBRbaAvQ==
X-Google-Smtp-Source: APXvYqw/KYvGT8AjEz2Oi5MYCARnmBO009jytp3nugfUE/B/EQ1VNgD6XwtLYNA69KGDktQR4LNR+NAr7ZVhhAacF6Q=
X-Received: by 2002:a05:620a:1425:: with SMTP id k5mr51778003qkj.146.1563902758554;
 Tue, 23 Jul 2019 10:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190722182451.GB24412@kroah.com> <20190722223337.36199-1-ravisadineni@chromium.org>
 <CAJZ5v0ikknRGPg0fhPRB2oLxtC0kD=8DX=6Z9MgtAYTO+YZ3ng@mail.gmail.com>
 <CAEZbON5aC+iYzg58YH59rvfvcUYkjwQyjA9wAJstFEQvUei_-A@mail.gmail.com> <CAJZ5v0hk8kvRUzw1Xs0S8+kcn++=4JNO7fjty3S9nq5iM=BG3w@mail.gmail.com>
In-Reply-To: <CAJZ5v0hk8kvRUzw1Xs0S8+kcn++=4JNO7fjty3S9nq5iM=BG3w@mail.gmail.com>
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
Date:   Tue, 23 Jul 2019 10:25:47 -0700
Message-ID: <CAEZbON4PSUtmgAy7OCXuMM0k4+0S=JjpgQfyUq09ijVxpq-rfw@mail.gmail.com>
Subject: Re: [PATCH 0/2] power: Refactor device level sysfs.
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Todd Broch <tbroch@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks Rafael. I will abandon this patch set and try to create a
symlink as you suggested.

Thanks,
Ravi

On Tue, Jul 23, 2019 at 10:02 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Jul 23, 2019 at 6:57 PM Ravi Chandra Sadineni
> <ravisadineni@chromium.org> wrote:
> >
> > Hi Greg,
> >
> > https://patchwork.kernel.org/patch/11045069/ seems to create a virtual
> > device under wakeup class with the same name as the actual device. I
> > don't see a way to reliably map these virtual devices to the actual
> > device sysfs node. For example if we have to know if a particular
> > input device has triggered a wake event, we have to look for a virtual
> > device under /sys/class/wakeup with the same name. I am afraid that
> > depending just on the name might be too risky as there can be multiple
> > devices under different buses with the same name.  Am I missing
> > something?
>
> There can be a symlink (say "wakeup_source") from under the actual
> device to the virtual wakeup one associated with it.
>
> Then we can advise everybody to use the symlink for the stats and
> deprecate the stats attributes under the actual device going forward.
> :-)
>
> I have a plan to cut a patch to add such a symlink, but you can try to
> beat me to that if you want.
>
> > On Tue, Jul 23, 2019 at 12:44 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Tue, Jul 23, 2019 at 12:33 AM Ravi Chandra Sadineni
> > > <ravisadineni@chromium.org> wrote:
> > > >
> > > > wakeup_abort_count and wakeup_count attributes print the
> > > > same (wakeup_count) variable. Thus this patchset removes the
> > > > duplicate wakeup_abort_count sysfs attribute. This patchset also
> > > > exposes event_count as a sysfs attribute.
> > > >
> > > > Ravi Chandra Sadineni (2):
> > > >   power: sysfs: Remove wakeup_abort_count attribute.
> > > >   power:sysfs: Expose device wakeup_event_count.
> > >
> > > I don't think you need this at all, because
> > > https://patchwork.kernel.org/patch/11045069/ is exposing what you need
> > > already.
> > >
> > > Thanks!

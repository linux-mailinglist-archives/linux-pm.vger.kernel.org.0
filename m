Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08B9A71D46
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 19:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbfGWRCi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 13:02:38 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40091 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731062AbfGWRCh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 13:02:37 -0400
Received: by mail-oi1-f193.google.com with SMTP id w196so11509311oie.7;
        Tue, 23 Jul 2019 10:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KgfRmlcrUJGTDhuXTiU2E03uzZT7aOuQamw3pXJdIpM=;
        b=EPJdgu4M1PKSlLXxh4YXgDwsf0g5g65L3GlDbqLwyTrU+zGqJyL3ps20VJL0AiPfZL
         rl6BQ8aS97aZDDFfE1AIGGbvX6MJDiwzz/JXmSxHLjRUWBjgXmREkbs7AjsSjwvdr7rH
         XMuWrUsBu3D5QMlGuaQFIOrVUmsvamwPfMoYU1EANR1hwxk6vYdl7gv3e7ca3p82j2AB
         buBljq2Z0cqEHXJ/ULvkENJMhqVbBk/kZNHwTqwsRWuLNsTu6in2kk4snkHaEPdsN/FP
         9u6lxYdwEadrUKW7nRuhXJq4HXk4NOLZAk6G0bxg6LZG/h3wt/oKT+pXeNGFAGy4eVMS
         le/Q==
X-Gm-Message-State: APjAAAUGiCDyjE6DL4HhYiGK4KCp8DSzRqucDJ910wr8J2f3FUOiqUky
        tE3sCIyEUnRKnmcDAJq2VO8ktnM7nFr1M2wfCEc=
X-Google-Smtp-Source: APXvYqxqbROdwpT75E96TYLktPE5J7300pzz8aqHDaKgjFhFHAChVD1Ln2hhsPN+74SAx5729mrBpJC1ZYLzuVLbNT4=
X-Received: by 2002:a54:4109:: with SMTP id l9mr38891416oic.93.1563901356701;
 Tue, 23 Jul 2019 10:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190722182451.GB24412@kroah.com> <20190722223337.36199-1-ravisadineni@chromium.org>
 <CAJZ5v0ikknRGPg0fhPRB2oLxtC0kD=8DX=6Z9MgtAYTO+YZ3ng@mail.gmail.com> <CAEZbON5aC+iYzg58YH59rvfvcUYkjwQyjA9wAJstFEQvUei_-A@mail.gmail.com>
In-Reply-To: <CAEZbON5aC+iYzg58YH59rvfvcUYkjwQyjA9wAJstFEQvUei_-A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Jul 2019 19:02:25 +0200
Message-ID: <CAJZ5v0hk8kvRUzw1Xs0S8+kcn++=4JNO7fjty3S9nq5iM=BG3w@mail.gmail.com>
Subject: Re: [PATCH 0/2] power: Refactor device level sysfs.
To:     Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Tue, Jul 23, 2019 at 6:57 PM Ravi Chandra Sadineni
<ravisadineni@chromium.org> wrote:
>
> Hi Greg,
>
> https://patchwork.kernel.org/patch/11045069/ seems to create a virtual
> device under wakeup class with the same name as the actual device. I
> don't see a way to reliably map these virtual devices to the actual
> device sysfs node. For example if we have to know if a particular
> input device has triggered a wake event, we have to look for a virtual
> device under /sys/class/wakeup with the same name. I am afraid that
> depending just on the name might be too risky as there can be multiple
> devices under different buses with the same name.  Am I missing
> something?

There can be a symlink (say "wakeup_source") from under the actual
device to the virtual wakeup one associated with it.

Then we can advise everybody to use the symlink for the stats and
deprecate the stats attributes under the actual device going forward.
:-)

I have a plan to cut a patch to add such a symlink, but you can try to
beat me to that if you want.

> On Tue, Jul 23, 2019 at 12:44 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Jul 23, 2019 at 12:33 AM Ravi Chandra Sadineni
> > <ravisadineni@chromium.org> wrote:
> > >
> > > wakeup_abort_count and wakeup_count attributes print the
> > > same (wakeup_count) variable. Thus this patchset removes the
> > > duplicate wakeup_abort_count sysfs attribute. This patchset also
> > > exposes event_count as a sysfs attribute.
> > >
> > > Ravi Chandra Sadineni (2):
> > >   power: sysfs: Remove wakeup_abort_count attribute.
> > >   power:sysfs: Expose device wakeup_event_count.
> >
> > I don't think you need this at all, because
> > https://patchwork.kernel.org/patch/11045069/ is exposing what you need
> > already.
> >
> > Thanks!

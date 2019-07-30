Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAE97B60C
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 01:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfG3XGI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 19:06:08 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41881 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfG3XGI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 19:06:08 -0400
Received: by mail-oi1-f195.google.com with SMTP id g7so49175540oia.8;
        Tue, 30 Jul 2019 16:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VimY03f5aoVN/yYxs3dYpIJvqLgBI3pDDuk5hgLPs/4=;
        b=ggE7PkpVTs0MSwxu+UtKwqyFOI+j5VUyM6rGPtN96hkLwtGQaTw1SLmjaAI6iLrQ8B
         YWFyTIWdVaCjZd61L1iBEBNTTe9RSc07ZcGBzYl7XRp6ogOVb11HiIyrARe4Ln3o2umL
         uEm59U3y3zIrcvPvACUDL5XjhQxNooX1u3qtSTLPOtlwIPmkxquabJXEiU1QMBzq14UI
         akRHC66KSngkaOQmvmL9rrHwduVLcoyp432/fJxYgSlF6rKn5eNwAn/MtYxQpsgU8/Bq
         vxVoxdzRDo0mel79GnaZ17ky1e76Eb6pmZVgmgxriDXHcEiM1F4RRl3kywbneMM1DSIB
         xlHQ==
X-Gm-Message-State: APjAAAVPId8t52fXDdImnIuvuhMS7niyFCy6PI0/phj219dpfqIlLR4w
        yLh0cHPwueLeVKhhpUQEEAMair/2cIpGuaM26nw=
X-Google-Smtp-Source: APXvYqys8f5L2s8Ry50x9g2wiZZVapo/nQkID81U6f6jdXRV6XlP08oDVuGarxxjQHWgRo3Fj6LqngpKNPQhrxkRwPU=
X-Received: by 2002:aca:5a41:: with SMTP id o62mr57540516oib.110.1564527966936;
 Tue, 30 Jul 2019 16:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190730024309.233728-1-trong@android.com> <CANA+-vBKg_W88Oy_wJs1NNYaZ2ciJKO=Mrs47etYTDNXUKW9Uw@mail.gmail.com>
 <5d4090ea.1c69fb81.d5cab.4dcd@mx.google.com> <2085893.cJkfNvi94x@kreacher> <5d40c41f.1c69fb81.ac63f.947f@mx.google.com>
In-Reply-To: <5d40c41f.1c69fb81.ac63f.947f@mx.google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 31 Jul 2019 01:05:55 +0200
Message-ID: <CAJZ5v0hj+e3+LZ+J1eOAT2REQne_J6aAXzkKVb0tJM4u9u--Rw@mail.gmail.com>
Subject: Re: [PATCH v5] PM / wakeup: show wakeup sources stats in sysfs
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tri Vo <trong@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 31, 2019 at 12:26 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Rafael J. Wysocki (2019-07-30 15:17:55)
> > On Tuesday, July 30, 2019 8:48:09 PM CEST Stephen Boyd wrote:
> > > Quoting Tri Vo (2019-07-30 11:39:34)
> > > > On Mon, Jul 29, 2019 at 10:46 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > > On Tue, Jul 30, 2019 at 4:45 AM Tri Vo <trong@android.com> wrote:
> > > > > > - Device registering the wakeup source is now the parent of the wakeup source.
> > > > > >   Updated wakeup_source_register()'s signature and its callers accordingly.
> > > > >
> > > > > And I really don't like these changes.  Especially having "wakeup"
> > > > > twice in the path.
> > > >
> > > > I can trim it down to /sys/class/wakeup/<ID>/. Does that sound good?
> > >
> > > Using the same prefix for the class and the device name is quite common.
> > > For example, see the input, regulator, tty, tpm, remoteproc, hwmon,
> > > extcon classes. I'd prefer it was left as /sys/class/wakeup/wakeupN. The
> > > class name could be changed to wakeup_source perhaps (i.e.
> > > /sys/class/wakeup_source/wakeupN)?
> >
> > Alternatively /sys/class/wakeup/wsN
> >
>
> Or /sys/class/wakeup/eventN? It's your bikeshed to paint.

So actually the underlying problem here is that device_wakeup_enable()
tries to register a wakeup source and then attach it to the device to
avoid calling possibly sleeping functions under a spinlock.

However, it should be possible to call wakeup_source_create(name)
first, then attach the wakeup source to the device (after checking for
presence), and then invoke wakeup_source_add() (after dropping the
lock).  If the wakeup source virtual device registration is done in
wakeup_source_add(), that should avoid the problem altogether without
having to introduce extra complexity.

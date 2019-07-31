Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C307BBC0
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 10:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfGaIeZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 04:34:25 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43863 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfGaIeY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 04:34:24 -0400
Received: by mail-ot1-f66.google.com with SMTP id j11so12025731otp.10;
        Wed, 31 Jul 2019 01:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AB8Hs1jyVm8RnPRFNhSx7PcKVllFtK5cSajR3rR52nI=;
        b=KOwnd+Uv3zA5G86muDK28NkoIOBlEFh97YaNPc+yEUgFl4M7ngpDMhpjxGWUbhBsO5
         6atiOe0wvF1tDRds8iQsgOV/CpAZqCwktA1hSrNJBn1DDJHlBQWUqw3iOJRV3C/92fM+
         17KVdn22e0aRp7pzicMEMCsY1olo2S9YrBCykTURtGQBu57sb6lVmOqIDno0Y5aDFJyy
         BRXIP17dYgbW2YX4zFA/yol8j/of6OFdviLmkRoWF/TyoVCf4SeJXxZEKrs8W9yqGFks
         7752rvpnzWpWU4Xvltv/cEgs4eEYlb41xpRQaUOLVrPvDllNS8fXla+500CkjHBBXQsj
         cvUw==
X-Gm-Message-State: APjAAAWAnazlI58zcoyaWmRLy0fb2w3mKmWGHz2t3MmR691wKkHX4aIp
        tbf0cGjCBFTDovqrwNn6qpSE0lvwzdJJhSTCWIw=
X-Google-Smtp-Source: APXvYqyO+qCi+ceNoUV7NyMgDZqz9y+y6uuENZytW9BejICpGIGD7X9KWd3XPMOOR2Z0tAFzdtL+a06XvDdsXEB6vVo=
X-Received: by 2002:a9d:7a51:: with SMTP id z17mr3227635otm.266.1564562063546;
 Wed, 31 Jul 2019 01:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190730024309.233728-1-trong@android.com> <CANA+-vBKg_W88Oy_wJs1NNYaZ2ciJKO=Mrs47etYTDNXUKW9Uw@mail.gmail.com>
 <5d4090ea.1c69fb81.d5cab.4dcd@mx.google.com> <2085893.cJkfNvi94x@kreacher>
 <5d40c41f.1c69fb81.ac63f.947f@mx.google.com> <CAJZ5v0hj+e3+LZ+J1eOAT2REQne_J6aAXzkKVb0tJM4u9u--Rw@mail.gmail.com>
 <5d40d5b3.1c69fb81.6047f.1cc3@mx.google.com>
In-Reply-To: <5d40d5b3.1c69fb81.6047f.1cc3@mx.google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 31 Jul 2019 10:34:11 +0200
Message-ID: <CAJZ5v0hj-GpiYN7nwPJvKJag71MG6zEFbJ6BNwzDidD+7fNFWw@mail.gmail.com>
Subject: Re: [PATCH v5] PM / wakeup: show wakeup sources stats in sysfs
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Wed, Jul 31, 2019 at 1:41 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Rafael J. Wysocki (2019-07-30 16:05:55)
> > On Wed, Jul 31, 2019 at 12:26 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Rafael J. Wysocki (2019-07-30 15:17:55)
> > > > On Tuesday, July 30, 2019 8:48:09 PM CEST Stephen Boyd wrote:
> > > > >
> > > > > Using the same prefix for the class and the device name is quite common.
> > > > > For example, see the input, regulator, tty, tpm, remoteproc, hwmon,
> > > > > extcon classes. I'd prefer it was left as /sys/class/wakeup/wakeupN. The
> > > > > class name could be changed to wakeup_source perhaps (i.e.
> > > > > /sys/class/wakeup_source/wakeupN)?
> > > >
> > > > Alternatively /sys/class/wakeup/wsN
> > > >
> > >
> > > Or /sys/class/wakeup/eventN? It's your bikeshed to paint.
> >
> > So actually the underlying problem here is that device_wakeup_enable()
> > tries to register a wakeup source and then attach it to the device to
> > avoid calling possibly sleeping functions under a spinlock.
>
> Agreed, that is one problem.
>
> >
> > However, it should be possible to call wakeup_source_create(name)
> > first, then attach the wakeup source to the device (after checking for
> > presence), and then invoke wakeup_source_add() (after dropping the
> > lock).  If the wakeup source virtual device registration is done in
> > wakeup_source_add(), that should avoid the problem altogether without
> > having to introduce extra complexity.
>
> While reordering the code to do what you describe will fix this specific
> duplicate name problem, it won't fix the general problem with reusing
> device names from one bus on a different bus/class.

Fair enough.

> We can run into the same problem when two buses name their devices the
> same name and then we attempt to attach a wakeup source to those two
> devices. Or we can have a problem where a virtual wakeup is made with
> the same name, and again we'll try to make a duplicate named device.
> Using something like 'event' or 'wakeup' or 'ws' as the prefix avoids this
> problem and keeps things clean.

Or suffix, like "<devname-wakeup>.

But if prefixes are used by an existing convention, I would prefer
"ws-" as it is concise enough and should not be confusing.

> We should probably avoid letting the same virtual wakeup source be made
> with the same name anyway, because userspace will be confused about what
> virtual wakeup it is otherwise. I concede that using the name of the
> wakeup source catches this problem without adding extra code.
>
> Either way, I'd like to see what you outline implemented so that we
> don't need to do more work than is necessary when userspace writes to
> the file.

Since we agree here, let's make this change first.  I can cut a patch
for that in a reasonable time frame I think if no one else beats me to
that.

> I just don't want to see us need to change the name of the
> wakeup device later on and then add a 'name' attribute to the class so
> that we can avoid name collisions due to various buses controlling the
> string we use to create the name of the wakeup device.

OK

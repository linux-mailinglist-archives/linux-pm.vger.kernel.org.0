Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F1DB744E
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 09:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfISHkJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 03:40:09 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45193 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfISHkJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 03:40:09 -0400
Received: by mail-oi1-f196.google.com with SMTP id o205so1852312oib.12
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 00:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mw1LJt4Z3uk56iea27opFvMoJdnpkJxLw2Qc2lTsIzU=;
        b=QSUDk2sKLgCwkz8kh0ezlom3ytDAmGg4+r/hMXYXQ7vE3y+xb9WNLAViZSIRdH2U0O
         8qOle9ElB4TS/4dKgYe+zSpkSxY8v8+RcSeXwoNXzfzODkwF6aeS28VKW+isPcoTcXV5
         OyIYg3oa7StLoLMkFgakUNu6b8aEQmpTtCByfTMlHGd+qpheWaPeGdxpalsCyd7ztMX2
         4XL37O3t9yBn5ep8VzAgcC+0J9Lf6ESMKD6K27eshg88swugSu82tjHlklG8Hi7jxLg9
         roy27arlCJNJWjwnb/EYiNPYlguCrFC6LnINOFPqWDixvV43ynbfWKDJJl2jdUNdPlCL
         XSUA==
X-Gm-Message-State: APjAAAXLL234BvUgTNP3oCwRaxpeYfIDbXDPlO38Z/5OC3wtxpkJxbjm
        4qjkp/5hIVqU3sFKfVojFKg3TkhmHw7wKAGKUd4=
X-Google-Smtp-Source: APXvYqz/v9iRqGJLaRmhNeAgfrr/Ryoz1JmF+k3DSAJP9hhhQEeozvWwyT7qLI1AJJVpZH3JIuD84WBFIxJXR9tR/Qw=
X-Received: by 2002:aca:ab84:: with SMTP id u126mr1127066oie.115.1568878808691;
 Thu, 19 Sep 2019 00:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1909181742470.2771@hp-x360n>
In-Reply-To: <alpine.DEB.2.21.1909181742470.2771@hp-x360n>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Sep 2019 09:39:56 +0200
Message-ID: <CAJZ5v0gYGPkJ0-=HSzFCpMLqky2Q6JN3qnov3c2ZaUAeCeaSag@mail.gmail.com>
Subject: Re: Help me help you debug what seems to be an EC resume issue
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 19, 2019 at 3:24 AM Kenneth R. Crudup <kenny@panix.com> wrote:
>
>
> I have a 2019-era HP Spectre X360 13". I generally like it, but it's plagued
> with "Modern Suspend" (s2idle) instead of a genuine S3, and as such I'm doing
> whatever I (and you and Linux' PM) can to keep the power consumption down during
> "suspend" (for now, "rfkill block all" before suspending, and removing the
> XHC[I] as a wakeup source via "/proc/acpi/wakeup" during boot).

You may still be able to use S3 on this machine if that's supported by
the platform firmware.

If reading from /sys/power/mem_sleep returns something like "[s2idle] deep" do

# echo deep > /sys/power/mem_sleep

(as root) and then it should change to "s2idle [deep]".  In that
configuration, try to suspend and see if you can wake up etc and if it
works reliably, you may use it going forward (in which case you'll
probably want to add mem_sleep_default=deep to the kernel command line
persistently).

> I bought one of those USB-C inline power meters and I can tell when the system
> is burning more power than "normal" - on a full-charged battery during s2idle
> it draws ~30-50 mA @ 20v, and if I see more than that I know something is amiss,
> even though the laptop (and dmesg) think it's fully suspended.
>
> I'm running the tip of Linus' tree as of now (b60fe990c6b07) and it's got
> your latest PM/s2idle fixes in it. Before these commits, I used to set
> "acpi.ec_no_wakeup=1" because the orientation sensor (at least, and probably
> other things) would wake up the laptop (then immediately suspend), which
> I'm sure was using up battery while I'm just walking around.
>
> I've turned off "ec_no_wakeup" for testing and the good news is the orientation
> sensor doesn't cause the laptop to draw more power when shaking it.
>
> However:
>
> - Randomly, it'll draw 250-300 mA when suspended, vs. the 30-50 mA
> - Randomly, if left suspended, nothing other than a hard power off will get
>   it back (and I can't be sure, but I think current consumption can be normal
>   when it suspends, but this seems to only happen if I've unplugged the
>   charger after suspending (so no power meter)).
>
> I have pstore set up to catch BUG_*/oopses and save them away on boots, but
> nothing comes thru, so I'm guessing it's just hanging somewhere either on
> suspend or resume.
>
> What can I do to diagnose where it's getting hung up? It appears my normal
> "ec_no_wakeup=1" case has no such issues, but I wouldn't mind being able to
> resume via the lid switch again.

I would recommend to try 5.4-rc1 when it's out to see if the problems
above are still there.

Cheers,
Rafael

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A755010841E
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2019 17:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKXQC6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Nov 2019 11:02:58 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:35877 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfKXQC6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Nov 2019 11:02:58 -0500
Received: by mail-ot1-f42.google.com with SMTP id f10so10462393oto.3
        for <linux-pm@vger.kernel.org>; Sun, 24 Nov 2019 08:02:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pgtTMDRLMsINDI90Oaa8s7ELM7N23s1SMYnXteFyuJU=;
        b=fmW293W5SS16m9IgrQsv/rnGCfThQh/3HpkNpghwKybYG9U7ekTUncXiEImZ/sZoo+
         VGjsnKooHmTH7QhsO1YTaRiKtk7sp5mFoZca/Hw13Xqtta/IaEHQyi/xSnUUQEW5ZSDn
         fCAMUpmXrmosLE0Og+9Wpi9Q7k0IimWxFPD3b/D1N/8uehl/Esws5MYHnl2/7P5M0kCc
         TaywuMfKzXOh2M2+UIb+s+OZi6uUY063HJR2C4XXGHhZvD2Y2F+o3ZnzXhqXNxPFOZk9
         YoIlIqKLxwQSaObw0tNh3eSuOHJTjFZfScULroV69vE0ucwVVbXsryoZC8qLKBQo650X
         6qew==
X-Gm-Message-State: APjAAAUhagz3Ot3Fdn9PONvxiBOdWpOOhGpVG7i89diGQQZ3TJAGFEDW
        hlDOv9W31MEKiVxfsGWhlqVcJcb33mLsB8594CY=
X-Google-Smtp-Source: APXvYqyIncPjyQ1sZ5bISWG7Ih/tut88q410VgCjMbWSGNsv2vbkkG3QcW8O4iCXK7GP96nz6VMzZHagUOOqstfmgKc=
X-Received: by 2002:a9d:4c85:: with SMTP id m5mr16672362otf.118.1574611377361;
 Sun, 24 Nov 2019 08:02:57 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <CAJZ5v0jQ3RY8An+V2VYH+ZKLC6=HrCYUMomM6jyEXJ47aeLT+A@mail.gmail.com>
 <CAJZ5v0gKvDb8=Y04DB3wQe0rK8Zfw5yNuAybV980ozxfmem=BQ@mail.gmail.com> <alpine.DEB.2.21.1911230213510.2531@hp-x360n>
In-Reply-To: <alpine.DEB.2.21.1911230213510.2531@hp-x360n>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 24 Nov 2019 17:02:43 +0100
Message-ID: <CAJZ5v0i2oC-w1RJ2X35fYyHdysorjLRYs-OBn+y_r6ksEZzVtg@mail.gmail.com>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep:
 Simplify suspend-to-idle control flow)
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Nov 23, 2019 at 11:24 AM Kenneth R. Crudup <kenny@panix.com> wrote:
>
>
> On Fri, 22 Nov 2019, Rafael J. Wysocki wrote:
>
> > BTW, is the ec_no_wakeup=1 workaround still effective?
>
> OK, I was wrong the first time, at least from the new Linus' tip (as of
> merge commit 2027cabe6af anyway). So I did some testing, and I now have a matrix:
>
> If "sleep_no_lps0" == 1, the machine never goes fully to sleep; the power
> light stays on and the backlight goes off, but if I have external monitors
> connected they're still showing dmesg activity. This is independent of the
> state of "ec_no_wakeup".

Hmm.  The external monitors part is something you have never mentioned.

> If "ec_no_wakeup" == 1, the system *at times* will go to sleep and never return

This is unclear.

What exactly do you mean by "go to sleep"?

Which part of the behavior does the "at times" phrase apply to?  The
"going to sleep" or coming back?  Or both?

> (i.e. no power light comes on, it's totally unresponsive until I do a hard
> reset with a power-button long-press) whether I'm plugged in or not.
> This is new behavior.

So how did it behave in 5.3.y?

> If "ec_no_wakeup" == 0, the system goes fully to sleep and either of the
> power button, lid opening or hitting a key resumes the laptop, but if I'm
> plugged in and actually charging when I suspend (and I suspect if I plug
> it in during suspend) it never returns, as in the case above.

OK, so ec_no_wakeup doesn't really change the behavior substantially,
it only makes certain things more or less likely to happen.

Does it still hang if you use the keyboard to wake up the system?

> Help! What can I do to return to the behavior of right before the s0 rework?

I guess you mean the 5.3.y behavior.  And what was it?

> Where in the code could I start looking to try to find out where the machine
> goes dead?

Well, because you identified 56b991849 as the first bad commit, the
following three lines of code in drivers/acpi/sleep.c are likely to be
the source of the problem:

        acpi_os_wait_events_complete(); /* synchronize EC GPE processing */
        acpi_ec_flush_work();
        acpi_os_wait_events_complete(); /* synchronize Notify handling */

Can you please try to comment them out and retest?

Note that you most likely won't be able to wake up the system via the
lid/power button without them, so use the keyboard to way it up during
that test.

Thanks!

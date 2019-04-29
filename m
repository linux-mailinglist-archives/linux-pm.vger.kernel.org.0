Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D661DCB5
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 09:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfD2HRn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 29 Apr 2019 03:17:43 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37183 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbfD2HRn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 03:17:43 -0400
Received: by mail-oi1-f195.google.com with SMTP id k6so7517836oic.4;
        Mon, 29 Apr 2019 00:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U0ILNQQnANwDaULFq9BnSLE4JegKbYYRqIG6pRQ8vEk=;
        b=AzPOYPlmRlFY1ZMZ6XdFpNqOKSufwIYjmGx6OGsZaW2CFkoWeQ6tQ3+x8AJxK/B3W+
         ZbZAhrJa90LxJVakt7HwjulDgHy/2xw6As8QtZsW2n/WnB5hJqwdl0ykQm6y2X/C42ix
         LOmm27gFtTdSz+yQxeiQwWEtDhffXj6EpLDK6K8V4T2mShRuJr8EQHCjInEEHawPOU+V
         6llXpBVfNduP81z5Ct+rJ/0Sq6EfdbDspDf+b/7h7dGaaW1m9PodJQNAWvcJg+U/zOvZ
         otiXCGk3DVoUrGE1a38sOpdzQCrQfyHOP2J8i9Kj2y6ZvgkXfFxxZjtirDpNm8a2vhCu
         C3tw==
X-Gm-Message-State: APjAAAW+sC75NcFvGrNR6Dnmegz+pmG7Kt6jSOnLArpu9xnCNvoWj+gG
        yIQPSz+QhR7tAsqdEy4koU9PwEyhKqJnfdw+0bknmRLI
X-Google-Smtp-Source: APXvYqwr1JzPOuSpeIEP+9sUUFOH+slhC9WrQ3DVJQkPqRABjuPtCwtvgu2tX7fhE9UKdsflW3QhNDNgQMdTGy0lX/Q=
X-Received: by 2002:aca:4a8a:: with SMTP id x132mr7422695oia.68.1556522262049;
 Mon, 29 Apr 2019 00:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <5fdabbb9-0a62-4802-f1ca-f83584f935fa@molgen.mpg.de>
In-Reply-To: <5fdabbb9-0a62-4802-f1ca-f83584f935fa@molgen.mpg.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 29 Apr 2019 09:17:26 +0200
Message-ID: <CAJZ5v0gobp60Pn5cdh0CohGAXSBs-EvntNqKc_dj_UTnOiogkQ@mail.gmail.com>
Subject: Re: Why is suspend with s2idle available on POWER8 systems?
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Apr 27, 2019 at 12:54 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Linux folks,
>
>
> Updating an IBM S822LC from Ubuntu 18.10 to 19.04 some user space stuff
> seems to have changed, so that going into sleep/suspend is enabled.
>
> That raises two questions.
>
> 1.  Is suspend actually supported on a POWER8 processor?

Suspend-to-idle is a special variant of system suspend that does not
depend on any special platform support.  It works by suspending
devices and letting all of the CPUs in the system go idle (hence the
name).

Also see https://www.kernel.org/doc/html/latest/admin-guide/pm/sleep-states.html#suspend-to-idle

>
> > Apr 27 10:18:13 power NetworkManager[7534]: <info>  [1556353093.7224] manager: sleep: sleep requested (sleeping: no  e
> > Apr 27 10:18:13 power systemd[1]: Reached target Sleep.
> > Apr 27 10:18:13 power systemd[1]: Starting Suspend...
> > Apr 27 10:18:13 power systemd-sleep[82190]: Suspending system...
> > Apr 27 10:18:13 power kernel: PM: suspend entry (s2idle)
> > -- Reboot --
>
> > $ uname -m
> > ppc64le
> > $ more /proc/version
> > Linux version 5.1.0-rc6+ (joey@power) (gcc version 8.3.0 (Ubuntu 8.3.0-6ubuntu1)) #1 SMP Sat Apr 27 10:01:48 CEST 2019
> > $ more /sys/power/mem_sleep
> > [s2idle]
> > $ more /sys/power/state
> > freeze mem
> > $ grep _SUSPEND /boot/config-5.0.0-14-generic # also enabled in Ubuntu’s configuration
> > CONFIG_ARCH_SUSPEND_POSSIBLE=y
> > CONFIG_SUSPEND=y
> > CONFIG_SUSPEND_FREEZER=y
> > # CONFIG_SUSPEND_SKIP_SYNC is not set
> > # CONFIG_PM_TEST_SUSPEND is not set
>
> Should the Kconfig symbol `SUSPEND` be selectable? If yes, should their
> be some detection during runtime?
>
> 2.  If it is supported, what are the ways to getting it to resume? What
> would the IPMI command be?

That would depend on the distribution.

Generally, you need to set up at least one device to generate wakeup interrupts.

The interface to do that are the /sys/devices/.../power/wakeup files,
but that has to cause enble_irq_wake() to be called for the given IRQ,
so some support in the underlying drivers need to be present for it to
work.

USB devices generally work as wakeup sources if the controllers reside
on a PCI bus, for example.

Thanks,
Rafael

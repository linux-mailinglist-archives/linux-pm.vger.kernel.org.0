Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68058166A0D
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 22:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgBTVsl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 16:48:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36127 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbgBTVsl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 16:48:41 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so162322wma.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2020 13:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WTVfgaoOc7Aubo1Fbnig9Cv2m0AIMq6Ne61JqyVLG9E=;
        b=MbjRM2+ZXKEzdMcW4Yqh2rqfq1l84Tbm4IUXg1VlOQ7uZsAlKU8wXaNe39awho+THs
         m1nZXfUiHkSrquIVX88Dsh8PZbhAQ8k7aleP5PlF6wjVWqnfLZwZj4MUIeDyKXUb48IO
         7e83lOh9O4lkJc6RoNbkRc2SI7cBLPj3r+NinMDZK0QAec/xbb49x7ZpQ6uDpOW6dY0j
         AHo3QG05Sxsjuc1Gujp25h4Vfe8756Ov05OKLAZ58RO6RqfoRGe0o6rgMVUwtzo5YNyv
         ajBfave1aAxpaGD0fkjWbmObpMIVV2e8qASRvWJBuJzH4NPJijsLm3XIVpIx3boSVMJR
         ezZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WTVfgaoOc7Aubo1Fbnig9Cv2m0AIMq6Ne61JqyVLG9E=;
        b=DbYUBvriNXdXRgrxcV5CBLo4RiGAsZzzVu2E0zyJ1upqCJ+yUtNKU4MPBEbPx/pmfS
         +shC9I7zPUgtRy3D1Zh5TiT3gngGsGvocCVarXp5MYjQHdecPPzh5ua72aV/e0DGJlJD
         Qpq/1edrYHXew+EHEmDUeB2bt2nS9o9PFOxUo4Jty1B/m6u5Pgn8JqeqvCOjR/0t4e9j
         vYQUju1j+YQrLpBn4sc8i1Pac++6u634gBsyEREeZLS+KPHCN9keHE9ICdFUYlLVbheS
         vZyrI5SAA/C7f/30NTqrxsEhu0IOt8F1Izri21hZwK0BgC4czhuq7YSlT3U2K6H7cQtH
         ocew==
X-Gm-Message-State: APjAAAVmAEMofpY6j9CGBLUzTDSCpRBvkb9Ni7UtHBkJh03ze25+QwwR
        poAGk3F55P2I2Egylem5uByLmJGJOv7GmFqNKmf/aA==
X-Google-Smtp-Source: APXvYqyDhXbsrP0OJoJzPOTLfHKpbwYUPv45kXxa7TYJoFtbmqA6RHvFE+3PyaFELoBzsq+yqi0jjXzJ/PX4t1DCDKM=
X-Received: by 2002:a05:600c:294a:: with SMTP id n10mr6639587wmd.11.1582235318995;
 Thu, 20 Feb 2020 13:48:38 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtTPSC8666h5fuW=iSaVvuRq9to731W2-sAT6xUuESAzsw@mail.gmail.com>
 <CAA25o9TvFMEJnF45NFVqAfdxzKy5umzHHVDs+SCxrChGSKczTw@mail.gmail.com>
 <CAJCQCtQw7EJwREM8Fy_PWCwy3E7Jc=kLTRo_kgLNwNhYA32ABA@mail.gmail.com>
 <CAJCQCtQkK+J-6eoadBLr+CkJ6CLf3Kt+6CeTJANRiU+M7A9CNQ@mail.gmail.com>
 <CAA25o9T2wwqoopoNRySdZoYkD+vtqRPsB1YPnag=TkOp5D9sYA@mail.gmail.com>
 <CAJCQCtScZg1CP2WTDoOy4-urPbvP_5Hw0H-AKTwHugN9YhdxLg@mail.gmail.com> <CAA25o9Q=36fiYHtbpcPPmGEPnORm2ZM7MfqRcsvNxsO0Sys9ng@mail.gmail.com>
In-Reply-To: <CAA25o9Q=36fiYHtbpcPPmGEPnORm2ZM7MfqRcsvNxsO0Sys9ng@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 20 Feb 2020 14:48:22 -0700
Message-ID: <CAJCQCtSx0FOX7q0p=9XgDLJ6O0+hF_vc-wU4KL=c9xoSGGkstA@mail.gmail.com>
Subject: Re: is hibernation usable?
To:     Luigi Semenzato <semenzato@google.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 20, 2020 at 12:45 PM Luigi Semenzato <semenzato@google.com> wrote:
>
> On Thu, Feb 20, 2020 at 11:09 AM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > On Thu, Feb 20, 2020 at 10:16 AM Luigi Semenzato <semenzato@google.com> wrote:
> > >
> > > I think this is the right group for the memory issues.
> > >
> > > I suspect that the problem with failed allocations (ENOMEM) boils down
> > > to the unreliability of the page allocator.  In my experience, under
> > > pressure (i.e. pages must be swapped out to be reclaimed) allocations
> > > can fail even when in theory they should succeed.  (I wish I were
> > > wrong and that someone would convincingly correct me.)
> >
> > What is vm.swappiness set to on your system? A fellow Fedora
> > contributor who has consistently reproduced what you describe, has
> > discovered he has vm.swappiness=0, and even if it's set to 1, the
> > problem no longer happens. And this is not a documented consequence of
> > using a value of 0.
>
> I am using the default value of 60.
>
> A zero value should cause all file pages to be discarded before any
> anonymous pages are swapped.  I wonder if the fellow Fedora
> contributor's workload has a lot of file pages, so that discarding
> them is enough for the image allocator to succeed. In that case "sync;
> echo 1 > /proc/sys/vm/drop_caches" would be a better way of achieving
> the same result.  (By the way, in my experiments I do that just before
> hibernating.)

Unfortunately I can't reproduce graceful failure you describe, myself.
I either get successful hibernation/resume or some kind of
non-deterministic and fatal failure to enter hibernation - and any
dmesg/journal that might contain evidence of the failure is lost. I've
had better success with qemu-kvm testing, but even in that case I see
about 1/4 of the time (with a ridiculously small sample size) failure
to complete hibernation entry. I can't tell if the failure happens
during page out, hibernation image creation, or hibernation image
write out - but the result is a black screen (virt-manager console)
and the VM never shutsdown or reboots, it just hangs and spins ~400%
CPU (even though it's only assigned 3 CPUs).

It's sufficiently unreliable that I can't really consider it supported
or supportable.

Microsoft and Apple have put more emphasis lately on S0 low power
idle, faster booting, and application state saving. The behavior in
Windows 10 with hiberfil.sys is a limited environment, essentially
that of the login window (no user environment state is saved in it),
and is used both for resuming from S4, as well as fast boot. A
separate file pagefile.sys is used for paging, so there's never a
conflict where a use case that depends on significant page out can
prevent hibernation from succeeding. It's also Secure Boot compatible.
Where on linux with x86_64 it isn't.

Between kernel and ACPI and firmware bugs, it's going to take a lot
more effort to make it reliable and trustworthy for the general case.
Or it should just be abandoned, it seems to be mostly that way
already.

-- 
Chris Murphy

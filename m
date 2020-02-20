Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40085166765
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 20:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgBTTpA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 14:45:00 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40293 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbgBTTpA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 14:45:00 -0500
Received: by mail-io1-f66.google.com with SMTP id x1so6028686iop.7
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2020 11:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KKqN/iwJgPWQoJZqKIuSVEOU9r8dfik/qZjVm2BXQc8=;
        b=qp7sI58vKnxDEgfQm4XoQP6FZPCPQS5IP4OpMn+j72GBlwxd2aNcpvX8/CFJ0HQ14+
         rm4iEzfpboU/cipjMf7aj64przNVjkw4spKqiM1lbd7J4mDjKT43xe0FICJh5qHGYC8E
         f5mJA7abjqmxDLwAkKb0gwJv+xqcR7sqGSgTcklkSy8mwF410jZpWewEwbWnN8Sx+sWK
         UNzAzDv0/2c75KmMJUWYy1jHf46/G0BeMJJw5m2tFgydqvj6dRO54k1HEQNxLY1CIvrz
         5Ts3muKbj2NMfK65NspiAOPM5yAg26hfYlEwsbHJkC4/RAuug//HaPzceJb6GrhvABvv
         CP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KKqN/iwJgPWQoJZqKIuSVEOU9r8dfik/qZjVm2BXQc8=;
        b=f0mTUs7W+JCtqpQmii5vAYwOEcavDnJrX8KcHVxJtD3uerYOOyEERMJWIcSt/Uo5SU
         IW8F3NsQzaXve5wIqV7/Qc/vZ9tgiusIFioYauqMLgmiJOPxh2f3fq2YkYIvEgAwqKZz
         3i7UH2oAy5V5G9DVuauOZooQOEK4HNWsjx958tiq1I1PxYEAIo6DJvrh/sLtJ1wC5cFg
         NAoPtg6IokmctPHozGqz/bgQDZlkwHDL1b4zppuCasdWltsjBCdh7bEkt8RrhrhAB0pc
         SF/saDKVkdUVCxkCfC2TDdtrhQrPJBBX/JrwwjMEX9Bh2rb/hXpe8Ul/54MO9/6iJ6NV
         vG3A==
X-Gm-Message-State: APjAAAVizosZrgR45Q68OXcxCLZyLPQkbvfCp7/pDe0poWaupVBKJA8u
        xGN2d2sbXC5E5bse8lJL69nKrFtgkixcFiaU72oxDA==
X-Google-Smtp-Source: APXvYqzscVpFdCqhjUQe92nHPxDt4DpukOfwNBi734w8X8KKwFVbjP7izMIRThwIuJid5Dra6O7Kck2EJITgazEU13c=
X-Received: by 2002:a5d:8952:: with SMTP id b18mr26111252iot.40.1582227899224;
 Thu, 20 Feb 2020 11:44:59 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtTPSC8666h5fuW=iSaVvuRq9to731W2-sAT6xUuESAzsw@mail.gmail.com>
 <CAA25o9TvFMEJnF45NFVqAfdxzKy5umzHHVDs+SCxrChGSKczTw@mail.gmail.com>
 <CAJCQCtQw7EJwREM8Fy_PWCwy3E7Jc=kLTRo_kgLNwNhYA32ABA@mail.gmail.com>
 <CAJCQCtQkK+J-6eoadBLr+CkJ6CLf3Kt+6CeTJANRiU+M7A9CNQ@mail.gmail.com>
 <CAA25o9T2wwqoopoNRySdZoYkD+vtqRPsB1YPnag=TkOp5D9sYA@mail.gmail.com> <CAJCQCtScZg1CP2WTDoOy4-urPbvP_5Hw0H-AKTwHugN9YhdxLg@mail.gmail.com>
In-Reply-To: <CAJCQCtScZg1CP2WTDoOy4-urPbvP_5Hw0H-AKTwHugN9YhdxLg@mail.gmail.com>
From:   Luigi Semenzato <semenzato@google.com>
Date:   Thu, 20 Feb 2020 11:44:48 -0800
Message-ID: <CAA25o9Q=36fiYHtbpcPPmGEPnORm2ZM7MfqRcsvNxsO0Sys9ng@mail.gmail.com>
Subject: Re: is hibernation usable?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 20, 2020 at 11:09 AM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Thu, Feb 20, 2020 at 10:16 AM Luigi Semenzato <semenzato@google.com> wrote:
> >
> > I think this is the right group for the memory issues.
> >
> > I suspect that the problem with failed allocations (ENOMEM) boils down
> > to the unreliability of the page allocator.  In my experience, under
> > pressure (i.e. pages must be swapped out to be reclaimed) allocations
> > can fail even when in theory they should succeed.  (I wish I were
> > wrong and that someone would convincingly correct me.)
>
> What is vm.swappiness set to on your system? A fellow Fedora
> contributor who has consistently reproduced what you describe, has
> discovered he has vm.swappiness=0, and even if it's set to 1, the
> problem no longer happens. And this is not a documented consequence of
> using a value of 0.

I am using the default value of 60.

A zero value should cause all file pages to be discarded before any
anonymous pages are swapped.  I wonder if the fellow Fedora
contributor's workload has a lot of file pages, so that discarding
them is enough for the image allocator to succeed. In that case "sync;
echo 1 > /proc/sys/vm/drop_caches" would be a better way of achieving
the same result.  (By the way, in my experiments I do that just before
hibernating.)

> > I have a workaround in which I use memcgroups to free pages before
> > starting hibernation.  The cgroup request "echo $limit >
> > .../memory.limit_in_bytes"  blocks until memory usage in the chosen
> > cgroup is below $limit.  However, I have seen this request fail even
> > when there is extra available swap space.
> >
> > The callback for the operation is mem_cgroup_resize_limit() (BTW I am
> > looking at kernel version 4.3.5) and that code has a loop where
> > try_to_free_pages() is called up to retry_count, which is at least 5.
> > Why 5?  One suspects that the writer of that code must have also
> > realized that the page freeing request is unreliable and it's worth
> > trying multiple times.
> >
> > So you could try something similar.  I don't know if there are
> > interfaces to try_to_free_pages() other than those in cgroups.  If
> > not, and you aren't using cgroups, one way might be to start several
> > memory-eating processes (such as "dd if=/dev/zero bs=1G count=1 |
> > sleep infinity") and monitor allocation, then when they use more than
> > 50% of RAM kill them and immediately hibernate before the freed pages
> > are reused.  If you can build your custom kernel, maybe it's worth
> > adding a sysfs entry to invoke try_to_free_pages().  You could also
> > change the hibernation code to do that, but having the user-level hook
> > may be more flexible.
>
> Fedora 31+ now uses cgroupsv2. In any case, my use case is making sure
> this works correctly, sanely, with mainline kernels because Fedora
> doesn't do custom things with the kernel.
>
>
>
> --
> Chris Murphy

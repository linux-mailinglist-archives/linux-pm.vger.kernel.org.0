Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD19D1666DC
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 20:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgBTTJu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 14:09:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55910 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbgBTTJu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 14:09:50 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so3194144wmj.5
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2020 11:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uxgm65AiGAZd1c3mWrOHtCMe0ItoHLyc5sH5oQlZuOk=;
        b=bEQw8fRxTq9gK07ho/vlQ9mY5JSMzS2lukVBuNH0s+QSj+sRKmetC8CtlXbAtzbG4e
         aJruoBKjDFJSWooUYK1iuNZEcB/VrLZbIw8hwZFTZItHR6KTIVdQjkmfEiwd2lGNrFUE
         Eeeca6ZkuLTHGzDBqzesneJFeeEqvesNEt0OE1JiSlh9R6nA4yrKlJfxicXpEO9sdOvr
         +L9FexC9L/v28qwJ8CDQsTnY8r7e20mJe2ePeYLthO+PLa0vcq7QDNxrKlAbURFR2/Rv
         QMRbUZxmDEuFHVYZcAx88AHaxSVLl7Jp+eXSlYA83v1Qro+cu5iGyjlDu0IuZR9u123X
         wWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uxgm65AiGAZd1c3mWrOHtCMe0ItoHLyc5sH5oQlZuOk=;
        b=idrgUW2zC9FLNhVihbu5Yi+dEgA+ekMAR0kplZd2zEFaSsd/c7ogYfrL9MG7TmC2KM
         fuu6ie87sridkD4Stw5s9QBozr/DHOXqoYUaDRw9cI3muTFEn83enCA46qUl4OSb1Aic
         3vDTAB9m4aG+QuqMowt7tgU1rUHkRh18Pm7osKNsVr/gf4Drpr18/9Xj4A0qDBvl2Y3z
         waSFI2IaGAf61HBiW9Sdj9Amx5zM9FnD6OiHqeO2wsepGk9bESV0ar1zh/p9VeG3TVek
         N9JGR8JHoj2wO9mUgMeMJrEDDyesU/m4ClSuePWzUeOg533nHtW0tMM6zmeXP6NQFKbP
         Cjig==
X-Gm-Message-State: APjAAAWMVp4F+u5RTY6m+ygm98hM3P5k1fYs+rBWgLOI0QSea+MQwZzG
        qnIE6Vk8aE9jAX5on0m6sscuRTc9mBAr7qgeJnMrB3dkJJ0=
X-Google-Smtp-Source: APXvYqxAlqZf0rk14n919Xz1clF4UrM8WARcg9j48fX51IWAABGXvZV+D2jB3/8POfgO6hJ00yPKZyUtwOdraO04dtc=
X-Received: by 2002:a7b:c147:: with SMTP id z7mr5887766wmi.168.1582225788812;
 Thu, 20 Feb 2020 11:09:48 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtTPSC8666h5fuW=iSaVvuRq9to731W2-sAT6xUuESAzsw@mail.gmail.com>
 <CAA25o9TvFMEJnF45NFVqAfdxzKy5umzHHVDs+SCxrChGSKczTw@mail.gmail.com>
 <CAJCQCtQw7EJwREM8Fy_PWCwy3E7Jc=kLTRo_kgLNwNhYA32ABA@mail.gmail.com>
 <CAJCQCtQkK+J-6eoadBLr+CkJ6CLf3Kt+6CeTJANRiU+M7A9CNQ@mail.gmail.com> <CAA25o9T2wwqoopoNRySdZoYkD+vtqRPsB1YPnag=TkOp5D9sYA@mail.gmail.com>
In-Reply-To: <CAA25o9T2wwqoopoNRySdZoYkD+vtqRPsB1YPnag=TkOp5D9sYA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 20 Feb 2020 12:09:32 -0700
Message-ID: <CAJCQCtScZg1CP2WTDoOy4-urPbvP_5Hw0H-AKTwHugN9YhdxLg@mail.gmail.com>
Subject: Re: is hibernation usable?
To:     Luigi Semenzato <semenzato@google.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 20, 2020 at 10:16 AM Luigi Semenzato <semenzato@google.com> wrote:
>
> I think this is the right group for the memory issues.
>
> I suspect that the problem with failed allocations (ENOMEM) boils down
> to the unreliability of the page allocator.  In my experience, under
> pressure (i.e. pages must be swapped out to be reclaimed) allocations
> can fail even when in theory they should succeed.  (I wish I were
> wrong and that someone would convincingly correct me.)

What is vm.swappiness set to on your system? A fellow Fedora
contributor who has consistently reproduced what you describe, has
discovered he has vm.swappiness=0, and even if it's set to 1, the
problem no longer happens. And this is not a documented consequence of
using a value of 0.


> I have a workaround in which I use memcgroups to free pages before
> starting hibernation.  The cgroup request "echo $limit >
> .../memory.limit_in_bytes"  blocks until memory usage in the chosen
> cgroup is below $limit.  However, I have seen this request fail even
> when there is extra available swap space.
>
> The callback for the operation is mem_cgroup_resize_limit() (BTW I am
> looking at kernel version 4.3.5) and that code has a loop where
> try_to_free_pages() is called up to retry_count, which is at least 5.
> Why 5?  One suspects that the writer of that code must have also
> realized that the page freeing request is unreliable and it's worth
> trying multiple times.
>
> So you could try something similar.  I don't know if there are
> interfaces to try_to_free_pages() other than those in cgroups.  If
> not, and you aren't using cgroups, one way might be to start several
> memory-eating processes (such as "dd if=/dev/zero bs=1G count=1 |
> sleep infinity") and monitor allocation, then when they use more than
> 50% of RAM kill them and immediately hibernate before the freed pages
> are reused.  If you can build your custom kernel, maybe it's worth
> adding a sysfs entry to invoke try_to_free_pages().  You could also
> change the hibernation code to do that, but having the user-level hook
> may be more flexible.

Fedora 31+ now uses cgroupsv2. In any case, my use case is making sure
this works correctly, sanely, with mainline kernels because Fedora
doesn't do custom things with the kernel.



-- 
Chris Murphy

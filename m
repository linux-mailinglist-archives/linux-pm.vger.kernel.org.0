Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71F2316650E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 18:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgBTRiT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 12:38:19 -0500
Received: from mail-il1-f176.google.com ([209.85.166.176]:42437 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbgBTRiT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 12:38:19 -0500
Received: by mail-il1-f176.google.com with SMTP id x2so15570827ila.9
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2020 09:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=09KCaYoy2RCgOUWekQOBry08/RITy2C45iW7MfQatT0=;
        b=I120KkGBiZ/RnK1THwXaeDT/JwAsQz0AIndg8NiS8d1xkUgrjB8/KEskX6jfopYmL8
         EtwTudOm66nfrNRPnVbHk4ioCh4Kz1zOjr4bPgtCquuLwSbJbDMALj3S8QI+TI3ZOTIl
         ffTQHgyaNLNogW20tOd5PIE0CloOyiPhzgtFV6OAm1ALHW2ct0bCYkxnhdDXhzoQsx+P
         X2lkiBMsomNljqyKtVQ/0spX58OMAbY7dJD+vYaQrKPwHQE56ZxvExS3XFsOHyUYpWIO
         gcExV8MHU8jcthyXTuAOAgf68uEOGDTh8vc/ANT8WHP48jE2H+efj/KGxkFzGh+3qemd
         vtdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=09KCaYoy2RCgOUWekQOBry08/RITy2C45iW7MfQatT0=;
        b=p286nbjFg/+e9KfLxpBlIJSBiqvJ4QFhbq8dokNt7d3Xdy+Yt4jQLhNlqc4s0Dy78X
         JbJXqDy19gCeF+jr0gmqkL82x3FKZ6LFJsK1t0r8iaGY7+EPw/X/2keOWmXzPdoDyYZ6
         uC6ih+EMaEKOzB0M9MpbpoT9XMkW/OK7tzkVDJUD0gWSDt90XPSorVoSP7/KTX2gnx/B
         +ZNv3KjPGUnl5k2aDtNQhSMlYroVAO/Sdlw4Mwf+gqlUuzJhxDdesAEh70VPHNt9XO4S
         tzUvIj/W0ejcXuBjGf24Gc4CV6pEKxQJ3HjOAdI6TcM+9DdTLhLqwrenyaK/6yd+LvCg
         cxOw==
X-Gm-Message-State: APjAAAUf9KDzRHhYQqsRhlYJR+hK1MymUr4MqIR86el3fUySo33K5VHn
        t7scvexThFll94JvtgjjM+OfFnKQ2yDLFjw9OOmq9g==
X-Google-Smtp-Source: APXvYqyHbZdoZSA+TXdjzBr5fSRBLQykpIqX5ldMA8W56fN3JwAFX3qnaNIdgJRnxnmHxMgY7pIpCuwYhtyoMpIzBJk=
X-Received: by 2002:a92:8dda:: with SMTP id w87mr30192090ill.55.1582220297799;
 Thu, 20 Feb 2020 09:38:17 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtTPSC8666h5fuW=iSaVvuRq9to731W2-sAT6xUuESAzsw@mail.gmail.com>
 <CAA25o9TvFMEJnF45NFVqAfdxzKy5umzHHVDs+SCxrChGSKczTw@mail.gmail.com>
 <CAJCQCtQw7EJwREM8Fy_PWCwy3E7Jc=kLTRo_kgLNwNhYA32ABA@mail.gmail.com>
 <CAJCQCtQkK+J-6eoadBLr+CkJ6CLf3Kt+6CeTJANRiU+M7A9CNQ@mail.gmail.com> <CAA25o9T2wwqoopoNRySdZoYkD+vtqRPsB1YPnag=TkOp5D9sYA@mail.gmail.com>
In-Reply-To: <CAA25o9T2wwqoopoNRySdZoYkD+vtqRPsB1YPnag=TkOp5D9sYA@mail.gmail.com>
From:   Luigi Semenzato <semenzato@google.com>
Date:   Thu, 20 Feb 2020 09:38:06 -0800
Message-ID: <CAA25o9SCanFH3nV52BwN=7EuSUFjX=Jrd+FCiV=6ThW=beKKMw@mail.gmail.com>
Subject: Re: is hibernation usable?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I was forgetting: forcing swap by eating up memory is dangerous
because it can lead to unexpected OOM kills, but you can mitigate that
by giving the memory-eaters a higher OOM kill score.  Still, some way
of calling try_to_free_pages() directly from user-level would be
preferable.  I wonder if such API has been discussed.


On Thu, Feb 20, 2020 at 9:16 AM Luigi Semenzato <semenzato@google.com> wrote:
>
> I think this is the right group for the memory issues.
>
> I suspect that the problem with failed allocations (ENOMEM) boils down
> to the unreliability of the page allocator.  In my experience, under
> pressure (i.e. pages must be swapped out to be reclaimed) allocations
> can fail even when in theory they should succeed.  (I wish I were
> wrong and that someone would convincingly correct me.)
>
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
>
>
> On Wed, Feb 19, 2020 at 6:56 PM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > Also, is this the correct list for hibernation/swap discussion? Or linux-pm@?
> >
> > Thanks,
> >
> > Chris Murphy

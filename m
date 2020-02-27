Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE9B17111A
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 07:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgB0GoH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 01:44:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37708 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgB0GoH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 01:44:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id l5so1890832wrx.4
        for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2020 22:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5k/UXfrWLI4mANPK0AmIZbwo/obrmKZTvxvRYX7gFyM=;
        b=XeRh5ylHwIimqU1VI3Iigi0JgnwuaRH17TbsQR+yz7jdd28UzaMM9PH7jQwwkivhJX
         tBQg6BNOiBfOXckE+B5sszyFFWLqGWh3LzpaPm3JhWuqR2FG5ayPLJ4f0EuaIYaajRe9
         5rjcRK9S4l3cA2CynqHGnF1mgrtsOStyZXlwQC+xcp5q5AfJBVgjD7aJut48ZYia8OEL
         ke8WHmtta/qR2HuaeJZJVl4lmOiu4fOgfnDy8wYSQWQNXkkcOtFsX+uRD+jP2uiS5TNW
         T9aJcUXFOE7qf7mMntGg4hM0j9QPkYodhHB3frUf7OjPu91kv1RuuLW+xNYQsF7onnIV
         RPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5k/UXfrWLI4mANPK0AmIZbwo/obrmKZTvxvRYX7gFyM=;
        b=He4z+upP/BzOAlVmXWWZb/U86kBZofPIk+FYotwWDfHu6E74YfIqQRheWtiuVMtJqq
         oJAYaSAGbjC4KEYMNpU196LFH9IOkKwvTziRKAe5eMYHBuO5Prztz9mncE0DWuhWPUX3
         +V421IzHVFgc92qwSoQqgsdHAayr3Ou8u/xHb2M8OtAyryTcTEBQhe0sjlNnZ0UZgAji
         KQHt+Oi6aIBQN53yGEm1eHc5CZmjcrl0lziOIoVzwZHV3hLjmraPeuZvlh0DuZWWr58c
         DXCORrTxxVsDXAgiP2j/4XTYKTIrlR6oXqOgqzkMaC3d1hCmXXzl5K7YY+cOzKtczqq0
         w2bA==
X-Gm-Message-State: APjAAAVgJiCcoMeEb7N8GWUKytY14j7BpV0e0UKGHgQgmBS7pmKm2Hee
        +kLw8UPHaC/wJYrqn5SUnNY9lbzhgsn2Q3DIZXgq9A==
X-Google-Smtp-Source: APXvYqwi6h8DxqwgRjEDYxp3+HdqRqJZQqprNp5Oq7mYt+KtBB9cSIIjBh8mAhp0QJaOrSrs9wn223gU9S5yq9okiZ4=
X-Received: by 2002:a5d:4dce:: with SMTP id f14mr2919645wru.65.1582785843421;
 Wed, 26 Feb 2020 22:44:03 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtTPSC8666h5fuW=iSaVvuRq9to731W2-sAT6xUuESAzsw@mail.gmail.com>
 <CAA25o9TvFMEJnF45NFVqAfdxzKy5umzHHVDs+SCxrChGSKczTw@mail.gmail.com>
 <CAJCQCtQw7EJwREM8Fy_PWCwy3E7Jc=kLTRo_kgLNwNhYA32ABA@mail.gmail.com>
 <CAJCQCtQkK+J-6eoadBLr+CkJ6CLf3Kt+6CeTJANRiU+M7A9CNQ@mail.gmail.com>
 <CAA25o9T2wwqoopoNRySdZoYkD+vtqRPsB1YPnag=TkOp5D9sYA@mail.gmail.com>
 <CAJCQCtScZg1CP2WTDoOy4-urPbvP_5Hw0H-AKTwHugN9YhdxLg@mail.gmail.com> <CAA25o9Q=36fiYHtbpcPPmGEPnORm2ZM7MfqRcsvNxsO0Sys9ng@mail.gmail.com>
In-Reply-To: <CAA25o9Q=36fiYHtbpcPPmGEPnORm2ZM7MfqRcsvNxsO0Sys9ng@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 26 Feb 2020 23:43:47 -0700
Message-ID: <CAJCQCtTU4+5PmjOt+jO5zfkZFA2xEB7hHkRadNoQ8rzYCqnyAw@mail.gmail.com>
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

He reports hibernation failure even if he drops caches beforehand.

https://lists.fedoraproject.org/archives/list/desktop@lists.fedoraproject.org/message/XYWYF33RFVISVZTPYSJRRXP7TFXPV4GD/

-- 
Chris Murphy

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C60BB168493
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 18:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgBURNX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 12:13:23 -0500
Received: from mail-il1-f172.google.com ([209.85.166.172]:41170 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgBURNX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 12:13:23 -0500
Received: by mail-il1-f172.google.com with SMTP id f10so2201855ils.8
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 09:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bR4lHzdd7hFGSOfT6wjCLMaQmFgxgzcu/EhXcaZsebQ=;
        b=qh8dozjsctmQVD6+hAItWi6rwODWcT0x8935378dY0i+7F68q4f1Z+nhwqWQzXUjon
         0+mt4fMd+pKGWyPF70eeJ4So0QIP0Dz9/sFJTLb09DtfyKeu+iq5smh08/pok2huvcUe
         Q4xkAeoNxwgjAH1amjvB/69GUAuET15/YzX4DFYC3X4Nr+5ZfeBmia3Uz7tQaHoPjze3
         +PP20TlRmnZOr0VgrzghowxkW3e2P/nSmj0F8si25Wx/MEMvpUPuOuBOBUn6N5UX+a2v
         ZGFXedWfKMeBXCHw9Dy3+7ujpOsJ2H8F8Gli2G3rfBxVbDhFPlLw4fwo0XkdCWCtPpBC
         AZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bR4lHzdd7hFGSOfT6wjCLMaQmFgxgzcu/EhXcaZsebQ=;
        b=AblpZSmnc8Plq15OviBKbvCToPMUvgD0TJVwG6V8lylUGQIqv7dvdUHaWABumvuDp/
         /8ss44pmQ4/bx2m02iGsd3K2/c87QledImrW2RCV3EfB8S1Ka2cTBQeIbB+DoJtOwn/4
         jOeJnsRwopKXRTZ0a3x6LmVKxQX1F3FEB9LVl69JsiH8Xm4aJ0UYAKfSLlkWcsJci2WQ
         1g8M02q2k/TnOnbYTuz3pzjqHfpBVyEajx1a2hOGxqFACBJXHgXSGoJ4GTOv4smmsKIp
         kEcZiV4819CTYHAHS1nNAclvZ3jqoYAmKnOCvTs5Hri68XfF7q5ZunZjT43ufrlH7N9f
         TVtw==
X-Gm-Message-State: APjAAAWKBZJMpmebAuzLqA97C9smTpi2KJvjoofIPH4m6cCBTCsfvmDG
        FRrP2+oHbyAzvL2Ewvt9GaNmqRSMlF/3qb7sY9IWpw==
X-Google-Smtp-Source: APXvYqztHZabXw7bx19dBMXUx8qWPmbjO8MeCOuuKPbKnHXSxH2rxcNkSfUoHY2wGoFbYsm+2JCRKB+YNw5gBeOb86w=
X-Received: by 2002:a92:884e:: with SMTP id h75mr37619356ild.199.1582305202309;
 Fri, 21 Feb 2020 09:13:22 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtTPSC8666h5fuW=iSaVvuRq9to731W2-sAT6xUuESAzsw@mail.gmail.com>
 <CAA25o9TvFMEJnF45NFVqAfdxzKy5umzHHVDs+SCxrChGSKczTw@mail.gmail.com>
 <CAJCQCtQw7EJwREM8Fy_PWCwy3E7Jc=kLTRo_kgLNwNhYA32ABA@mail.gmail.com>
 <CAJCQCtQkK+J-6eoadBLr+CkJ6CLf3Kt+6CeTJANRiU+M7A9CNQ@mail.gmail.com>
 <CAA25o9T2wwqoopoNRySdZoYkD+vtqRPsB1YPnag=TkOp5D9sYA@mail.gmail.com>
 <CAA25o9SCanFH3nV52BwN=7EuSUFjX=Jrd+FCiV=6ThW=beKKMw@mail.gmail.com>
 <20200221084910.GM20509@dhcp22.suse.cz> <CAJZ5v0h5MnpK9YjO+Z7_M1Cj8tup4qPriALx-EHt4ypbmCWfUw@mail.gmail.com>
 <20200221093635.GN20509@dhcp22.suse.cz>
In-Reply-To: <20200221093635.GN20509@dhcp22.suse.cz>
From:   Luigi Semenzato <semenzato@google.com>
Date:   Fri, 21 Feb 2020 09:13:10 -0800
Message-ID: <CAA25o9SxajRaa+ZyhvTYdaKdXokcrNYXgEUimax4sUJGCmRYLA@mail.gmail.com>
Subject: Re: is hibernation usable?
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 21, 2020 at 1:36 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 21-02-20 10:04:18, Rafael J. Wysocki wrote:
> > On Fri, Feb 21, 2020 at 9:49 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Thu 20-02-20 09:38:06, Luigi Semenzato wrote:
> > > > I was forgetting: forcing swap by eating up memory is dangerous
> > > > because it can lead to unexpected OOM kills
> > >
> > > Could you be more specific what you have in mind? swapoff causing the
> > > OOM killer?

No, not swapoff, just fast allocation.

Also, in some earlier experiments I tried gradually increasing
min_free_kbytes (precisely as suggested) and this would randomly
trigger OOM kills when swap space was still available.

> > > > , but you can mitigate that
> > > > by giving the memory-eaters a higher OOM kill score.  Still, some way
> > > > of calling try_to_free_pages() directly from user-level would be
> > > > preferable.  I wonder if such API has been discussed.
> > >
> > > No, there is no API to trigger the global memory reclaim. You could
> > > start the reclaim by increasing min_free_kbytes but I wouldn't really
> > > recommend that unless you know exactly what you are doing and also I
> > > fail to see the point. If s2disk fails due to insufficient swap space
> > > then how can a pro-active reclaim help in the first place?
> >
> > My understanding of the problem is that the size of swap is
> > (theoretically) sufficient, but it is not used as expected during the
> > preallocation of image memory.
> >
> > It was stated in one of the previous messages (not in this thread,
> > cannot find it now) that swap (of the same size as RAM) was activated
> > (swapon) right before hibernation, so theoretically that should be
> > sufficient AFAICS.

Correct, those were my experiments.  Search the archives for
"semenzato", there are a couple of threads on the topic.

But really, why not have a user-level interface for reclaim?  I find
it very difficult to understand the behavior of the reclaim code, and
any attempt to reclaim from user level (memory-eating processes,
raising min_free_kbytes) can end in the OOM-kill path.  Using cgroups'
memory.limit_in_bytes doesn't have this problem, precisely because it
only calls try_to_free_pages(), which doesn't trigger OOM killing.  If
I could make that call from user level (without cgroups) it would
greatly simplify my current workaround, and would be useful in other
situations as well.

Something like

  echo $page_count > /proc/sys/vm/try_to_free_pages
  cat /proc/sys/vm/pages_freed   # the number of pages freed at the
latest request

> Hmm, this is interesting. Let me have a closer look...
>
> pm_restrict_gfp_mask which would completely rule out any IO
> happens after hibernate_preallocate_memory is done and my limited
> understanding tells me that this is where all the reclaim happens
> (via shrink_all_memory). It is quite possible that the MM decides to
> not swap in that path - depending on the memory usage - and miss it's
> target. More details would be needed. E.g. vmscan tracepoints could tell
> us more.
>
> --
> Michal Hocko
> SUSE Labs

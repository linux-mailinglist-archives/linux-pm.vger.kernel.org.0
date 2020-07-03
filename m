Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671672141D5
	for <lists+linux-pm@lfdr.de>; Sat,  4 Jul 2020 00:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGCWxd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jul 2020 18:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgGCWxd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2020 18:53:33 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17406C061794
        for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2020 15:53:33 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f5so22816805ljj.10
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2020 15:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xCR5VvhKlbkEFM6sZwEPdCYNVIQ/fI7Y+3OKvD7Y5CE=;
        b=M7+yQAj4FyVF9DU+YNPXjKkVGTGKftdJcKKszBlVnX5aS/jz3jwzpl3oRMTykHtghk
         CMx1MmsupZzmxYmq0YdqHf4JFlGmU+ghnqWOKgIEdrvyFQ8Qa99a2FdkXrdi2Se/MLsL
         nlVcruJkxMDHASJOxyYFVac4TY50weNssjd+pcNnCBmcp3Oz3AkyGCqXTM+LdkZ0pRFo
         SJAmicXgGy4doAWU9fLljh5vtUNMBTr+DM4EVbJvY2Mmd+0/V3H4Ly/4mbVGWiUWaTQs
         5AIO+GujEt3x4dZHcu5ilq/o638RybF8ne644ndhtl4BYMHpGmDujSfX0aKEpdomjKD8
         kEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xCR5VvhKlbkEFM6sZwEPdCYNVIQ/fI7Y+3OKvD7Y5CE=;
        b=HaHKHjhtV0JRW0foiJynWtwwtSFLq+sorip2ZIs3iaBFsxvj1dP9gTyagddLBu5SYS
         E09MyAaec9yKBUmc2ghLob72yGSFrJR/bjXdT9eP5LIW6MY3Dx+dVuv1lRQHrAUEJW7+
         5GQfNaGK2V0PDp0B2RZr2BfTVcbcXLGn+O6zgOFqp4Xqd48q9M7I+4zkPvWCmadSYVv6
         GyHnlGJ2qqKJG5tT+jvNzbNL4ibvK2g1ZLmrf+gLyPBtuZdOuAkVsIGZf89KKRvACzI1
         cI4mxx/suyMRjp0vj3SrmWbKrMbXwQ1mS6QGRfqcvuKdfHAUhOqpNPoLja0f5jeICPRi
         QeQQ==
X-Gm-Message-State: AOAM531932N+NZ3N3UAjBNq3CtxXe3vm+neVIelPF0jpaZvek+ceIYgk
        pfbBZh7KtQ8IkcwD768tojL7MKsvs6k4ZIera1guuA==
X-Google-Smtp-Source: ABdhPJy0/d7YQxkDTsZvXO7ow32yFdRcjugFg1twpCSkcbrbcdxZ/z4wQIr7NksLBKL4GwroBCtrf1lXG19AlZ5fv5c=
X-Received: by 2002:a2e:9dcc:: with SMTP id x12mr4527117ljj.415.1593816811282;
 Fri, 03 Jul 2020 15:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <20200703113026.GT18446@dhcp22.suse.cz> <CAG48ez2O2z4L=n57Omwy6s1sWQkdTkPKiikhbfdVhiyd_TGRRw@mail.gmail.com>
 <20200703223453.GA25072@amd>
In-Reply-To: <20200703223453.GA25072@amd>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 4 Jul 2020 00:53:04 +0200
Message-ID: <CAG48ez0JkDb84FD8xgpNmERhWcjqbZuXfWbxzmnkM_CH_mXAnQ@mail.gmail.com>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Michal Hocko <mhocko@kernel.org>,
        "Catangiu, Adrian Costin" <acatan@amazon.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "wad@chromium.org" <wad@chromium.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "bonzini@gnu.org" <bonzini@gnu.org>,
        "Graf (AWS), Alexander" <graf@amazon.de>,
        "MacCarthaigh, Colm" <colmmacc@amazon.com>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Sandu, Andrei" <sandreim@amazon.com>,
        "Brooker, Marc" <mbrooker@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "Manwaring, Derek" <derekmn@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jul 4, 2020 at 12:34 AM Pavel Machek <pavel@ucw.cz> wrote:
> On Fri 2020-07-03 15:29:22, Jann Horn wrote:
> > On Fri, Jul 3, 2020 at 1:30 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > On Fri 03-07-20 10:34:09, Catangiu, Adrian Costin wrote:
> > > > This patch adds logic to the kernel power code to zero out contents of
> > > > all MADV_WIPEONSUSPEND VMAs present in the system during its transition
> > > > to any suspend state equal or greater/deeper than Suspend-to-memory,
> > > > known as S3.
> > >
> > > How does the application learn that its memory got wiped? S2disk is an
> > > async operation and it can happen at any time during the task execution.
> > > So how does the application work to prevent from corrupted state - e.g.
> > > when suspended between two memory loads?
> >
> > You can do it seqlock-style, kind of - you reserve the first byte of
> > the page or so as a "is this page initialized" marker, and after every
> > read from the page, you do a compiler barrier and check whether that
> > byte has been
>
> That would also need smp cpu barriers, and guarantee that first byte
> is always ... cleared first, and matching barriers in kernel space,
> too, no?

Not if it happens in the guts of the suspend stuff, when userspace is
frozen, I think?

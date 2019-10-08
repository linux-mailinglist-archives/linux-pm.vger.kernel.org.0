Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBF6CFEC7
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2019 18:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfJHQSQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Oct 2019 12:18:16 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:36685 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfJHQSP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Oct 2019 12:18:15 -0400
Received: by mail-wm1-f42.google.com with SMTP id m18so3764563wmc.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Oct 2019 09:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fq39f35/DAgMRpFzxjAJpDDxpwFQXNEdjkCjZJk2WaE=;
        b=MFiJsDlqQpsJ7yc1KIekhPsKXUGVrQLR8QCHMXLz0rNsjXV9yLXnleym3LN7q9PM5/
         U7vxkx6EBY7fAFZFHdZOBPBBKcWvn9dY6k2tqofLfqVKYX36PRl2lk+mb88hdzMEG8hK
         coK1QJyE++VVUjY/6p38xFY7azdUlWRmSd5dLMMLq4kDH8toCP0q3I9tAxRfJm5WusXE
         4va27WxziGwOUcjU4kMjLvyJjhhjzXjcVNcKtn7RGs51nUM37jIehTogenUxjJYNaLO4
         m1qPB0AVKx/49/g8ylSWy/Bh0Wzidw3sfIcypzeHP3EfRhUV8h0dqRT5ilWlKDOjV86Z
         AlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fq39f35/DAgMRpFzxjAJpDDxpwFQXNEdjkCjZJk2WaE=;
        b=OLQtHP4VuSnY2IA+KDOx1gzlGxXsNVxJnh4HG5l/+u/45QZKXDpfgQWwNEVY1zM5tN
         tB0wlIf0pD9X8DHEKBBgF69LeURYr2ZlKvk6dWYBImF/L4m02QY+8MgK+71hhVsHzHgG
         C5ZghShWolJhp8NEy2L2kKOHG0ES8UgQDfZhyJWx/7M3FGPNhmj8oG2DNoS8G+Lr5XNx
         wNHLWKwMht3xpVtKheHJQGmcsjAFxWiwLOVvrA40Rx8j2Sii7JqhdL0cYVZVkoP+TJUf
         hjS3SON+yk3e4ymLPV3RhIn+M3HVbUwmKq2JxZ05XhiWa/+ka+m4F3/bvlTtBNiEpt2A
         Iwtg==
X-Gm-Message-State: APjAAAWf9o/CS9sQxM89B2KOdRcWRW+JsUfXBGfQMw3UVl0QXTl99cm/
        fhFRl75QOqhPv++aJg7+bqm2VfuzeRpHTDYolLJtSg==
X-Google-Smtp-Source: APXvYqxsu6hqSZm4NEsa823qu9Zop5Q8ujIDa+7yw5bajhKeIQZYNvOBuV3urJTh7zAUqKF6ux+s+qJmJWuumc9FSmc=
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr4206355wmi.160.1570551493022;
 Tue, 08 Oct 2019 09:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAA25o9T6C4VCVbqzS0hJgmvpJb6h+htFpH3OUY30E2VtuG8fxQ@mail.gmail.com>
 <56319808-87dc-76ed-c1e0-9f60108e94a6@arm.com> <CAA25o9TpBm+LNwVccTaUng4vQ1Q9_Wz2QftGho7DG_+26CCYoA@mail.gmail.com>
 <CAJZ5v0jCb5jLVQ2Oj0bSNf987apxi7SHx4duX9eALMD6QQXB+w@mail.gmail.com>
In-Reply-To: <CAJZ5v0jCb5jLVQ2Oj0bSNf987apxi7SHx4duX9eALMD6QQXB+w@mail.gmail.com>
From:   Luigi Semenzato <semenzato@google.com>
Date:   Tue, 8 Oct 2019 09:18:01 -0700
Message-ID: <CAA25o9SUnwc908Grh8qYMDi_tnyhov00Y11RT69MuK8gXcrN4A@mail.gmail.com>
Subject: Re: hibernation memory usage
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Bas Nowaira <bassem@google.com>, Geoff Pike <gpike@google.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Yes, that makes sense, thank you.  Use separate partitions for swap
and hibernation.

Normally the kernel starts swapping out when there's no reclaimable
memory, so anon usage will be high.  Do you think cranking up
/proc/vm/swappiness would be enough to ensure that file pages stay
over 50%?  Or would you use some tricks, such as running a
high-priority process which allocates >50% of RAM, thus forcing other
anon pages to be swapped out, then killing that process and quickly
hibernating before too many pages are brought back in?  Or changing
the kernel so that in the first part of hibernation we'll just swap
stuff out?

On Tue, Oct 8, 2019 at 8:39 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Oct 8, 2019 at 5:26 PM Luigi Semenzato <semenzato@google.com> wrote:
> >
> > Thank you for your reply!
> >
> > I understand the need for saving all state, not just process/task
> > state.  But for many of the systems that could benefit from
> > hibernation, the majority of RAM is taken by user processes (I am
> > thinking laptops).  It should be possible to copy their anonymous
> > pages to disk more or less directly, without making an extra copy like
> > it's done for all other pages.  I am not sure what happens with kernel
> > tasks, but they don't have anonymous pages (that I know).
> >
> > I am curious to know how/if hibernation is currently used in practice.
> > It doesn't seem practical to require that user processes take less
> > than 50% of RAM at all times.  There may be special cases in which the
> > restriction can be achieved by terminating non-essential processes
> > before hibernating, but I don't know of any.
> >
> > I would also like to know how much work it might take to avoid the
> > extra copy of the anonymous pages of frozen processes.
>
> Whatever doesn't fit into 50% of RAM needs to be swapped out before
> hibernation.  The efficiency of that depends on the swap handling code
> and the underlying hardware.  If that is efficient enough overall,
> trying to avoid it altogether isn't going to make much of a
> difference.

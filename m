Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8A6655D7F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 03:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfFZBdU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 21:33:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39887 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfFZBdU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 21:33:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id r21so867658otq.6
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 18:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VVnzFsR1solrbhevdTsXVX+Ex8gYtEcQN0RWhGvtNyk=;
        b=kSHpaSnkgeS/BsbriFI9eSDuwr1sEjGmgFxxXI+nQIrKVjQ4s50ErtfHe9lYgRmNCv
         Bkl88QBc2kijsyTb4CFaeF2DLB3tqZVDYVkAROMhPxROtnL/cvM/D2lZvStIl/NF48IW
         02wr2mcDC7G2RBzcPM18dWr9ttPU2et+htrNMrnZfSIWPJ1qk9ddTi3nyVc03DeQ3BX+
         JaW6KdavGqEjPW7i+seR06HIrcCuFmbeLCs7NcNvnl8Z9YFEKNZjGc9bbB3legVIHLA2
         vVPJKQq4VoBYw1qt+qiTzVBG6VcfbQs1P/u3P+1tqa/cmF+Ej992IKuSeixCuiR8SLfE
         yZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVnzFsR1solrbhevdTsXVX+Ex8gYtEcQN0RWhGvtNyk=;
        b=VZH0/HtqMPf2LP64r+7tPdmLe+WUjvby9/VQRtqmYMzwD3KQToVkOW0wJRRxpHcKgT
         25CJZVLR5ZfZHrOVP0Izg6X1haAI1HwgqBSXo2vGbYbYtROgG6hNYl3R6CQCiUCA6XkJ
         brUDAV9Foq7mQStdiXuvuzJlNjeI7Be3NATxiOQQfjnfjocZ86QJTQxvwygXLucQ7hhf
         i0ZA2/9SA8x7D9bMiIAVr6wavjZNCxhbsitn03sUFKUbHTy6qgnuBmSanjucW0Z2CIc2
         jr0ixmKvjGI4hOhCfNV9tOHvQyqFhZwhxscLWQPW0iIOBomtcxHMzV4Xtgmmx/FKHWWx
         WGVg==
X-Gm-Message-State: APjAAAXMe5RP9YdZTOBHXmUweT2HQmdSGTTkvToRCpajz18RWkbYlQiA
        +vKj+Ru3kXg20ViOh6OwU583ofP/qNJb/0Uq0+wqyA==
X-Google-Smtp-Source: APXvYqywRDjbdY4AqFVYejcaJ73/70eyyldi5CPQ/mAGyGTaEGTVNtdjpI6X9K30GsFjhIUsZ9arXTldZGotZSJTOnY=
X-Received: by 2002:a9d:5911:: with SMTP id t17mr1129812oth.159.1561512799820;
 Tue, 25 Jun 2019 18:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190626005449.225796-1-trong@android.com> <20190626011221.GB22454@kroah.com>
In-Reply-To: <20190626011221.GB22454@kroah.com>
From:   Tri Vo <trong@android.com>
Date:   Tue, 25 Jun 2019 18:33:08 -0700
Message-ID: <CANA+-vBoabFTD=fMz+0d5Sbe9rPwnxcuxJxaMCT3KAwXYHSD7w@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeup: show wakeup sources stats in sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 25, 2019 at 6:12 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 25, 2019 at 05:54:49PM -0700, Tri Vo wrote:
> > Userspace can use wakeup_sources debugfs node to plot history of suspend
> > blocking wakeup sources over device's boot cycle. This information can
> > then be used (1) for power-specific bug reporting and (2) towards
> > attributing battery consumption to specific processes over a period of
> > time.
> >
> > However, debugfs doesn't have stable ABI. For this reason, expose wakeup
> > sources statistics in sysfs under /sys/power/wakeup_sources/<name>/
> >
> > Add following attributes to each wakeup source. These attributes match
> > the columns of /sys/kernel/debug/wakeup_sources.
> >
> >   active_count
> >   event_count
> >   wakeup_count
> >   expire_count
> >   active_time (named "active_since" in debugfs)
> >   total_time
> >   max_time
> >   last_change
> >   prevent_suspend_time
>
> Can you also add a Documentation/ABI/ update for your new sysfs files so
> that we can properly review this?
>
> > Embedding a struct kobject into struct wakeup_source changes lifetime
> > requirements on the latter. To that end, change deallocation of struct
> > wakeup_source using kfree to kobject_put().

Will do.
>
> Ick, are you sure you need a new kobject here?  Why wouldn't a named
> attribute group work instead?  That should keep this patch much smaller
> and simpler.

Yeah, named attribute groups might be a much cleaner way to do this.
Let me investigate.
>
> > +static ssize_t wakeup_source_count_show(struct wakeup_source *ws,
> > +                                     struct wakeup_source_attribute *attr,
> > +                                     char *buf)
> > +{
> > +     unsigned long flags;
> > +     unsigned long var;
> > +
> > +     spin_lock_irqsave(&ws->lock, flags);
> > +     if (strcmp(attr->attr.name, "active_count") == 0)
> > +             var = ws->active_count;
> > +     else if (strcmp(attr->attr.name, "event_count") == 0)
> > +             var = ws->event_count;
> > +     else if (strcmp(attr->attr.name, "wakeup_count") == 0)
> > +             var = ws->wakeup_count;
> > +     else
> > +             var = ws->expire_count;
> > +     spin_unlock_irqrestore(&ws->lock, flags);
> > +
> > +     return sprintf(buf, "%lu\n", var);
> > +}
>
> Why is this lock always needed to be grabbed?  You are just reading a
> value, who cares if it changes inbetween reading it and returning the
> buffer string as it can change at that point in time anyway?

Right, we don't care if the value changes in between us reading and
printing it. However, IIUC not grabbing this lock results in a data
race, which is undefined behavior.

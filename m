Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFB357B325
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 21:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbfG3TU2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 15:20:28 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33606 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbfG3TU2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 15:20:28 -0400
Received: by mail-ot1-f66.google.com with SMTP id q20so67435474otl.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2019 12:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lG7iy+1TUm+VzW+0drIYHjU3Qdez5tE551tVEBNTmeo=;
        b=OQQuPmBcpMZJBJouO1aP91Dqm5eUdHs6vf8Es3y6gatwl7fi640xxXvrSF2orp8jgg
         mWDqfiijza5vmEP8V1sCwsXqhTJzcFycCdGjbwFB9FL0dvUQSdLXwaQckaD405bDvXeu
         pq66QciEHh3BNsSIWLZnw9pxvC3lJC0/HNKsb9d/WAnGlAEeWBXnj2mers2MQDqKwhwO
         SRQhEDYTpGoyXNvmpt0O3qyx+FYCpoY7x6PuXKtOKeTBuxDMR2xS1J6iZV0bBHEH8hoG
         y6azRXHRg0lTQovJi+biD14b6lJG9drbO/cWsLgXzEpmHKCzTdFnqoAPe6XWOYE6oO8P
         +emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lG7iy+1TUm+VzW+0drIYHjU3Qdez5tE551tVEBNTmeo=;
        b=S+4FTKu+/cIiRHNW2V5Jf+ipmhFBYz5ZEJJbphg5B0xzliqJPD4ZzVp/TKUXiXpK4W
         E3DNxannNlQLs0jK07skzTdAi9Gt/5jhpNWa3i6/ukAIHP2rJfp67Rr+PvCk/Bx8bpym
         /ahnQDuwdIDsiD8jA5iIYSS0d9CGaBpWiZ4N17b+OLIAPngZ+3Y7FCfYY/9+59Y4emAf
         SmmcVYVNRs+/skHbmmcfBxFczrfOtyDg8CNeDKqNwNcp1wifWDNCYQVd0FS7HTL6isRd
         VlpApaAwbv57WNU/g+GxHvOMFvkioEvQ9VUNRcpKTt09VrI/uzp+rwreK8bC7atgJEFA
         JNgw==
X-Gm-Message-State: APjAAAVnP3NKpjrjpciDK4l1gVDHpmhl16ATW78MH5VemcXitQyjaYCS
        /LAod02ZFqpPtsimqBfOQa9heihr39UkQEwThZA=
X-Google-Smtp-Source: APXvYqxDLgQC6sU6Gvr2uWSUyy6YFhHal6IoQSyORWGJqTbWRGkciZAL9GeLKHdPbtGdlIt9djDId/kCFPhrR2l1nQg=
X-Received: by 2002:a9d:5f02:: with SMTP id f2mr1883265oti.148.1564514427329;
 Tue, 30 Jul 2019 12:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190730024309.233728-1-trong@android.com> <20190730064657.GA1213@kroah.com>
In-Reply-To: <20190730064657.GA1213@kroah.com>
From:   Tri Vo <trong@android.com>
Date:   Tue, 30 Jul 2019 12:20:16 -0700
Message-ID: <CANA+-vA7TcGMndqwmYk4y8Kyi6LbcmtnBBhzWca2qreJ0dU_Hw@mail.gmail.com>
Subject: Re: [PATCH v5] PM / wakeup: show wakeup sources stats in sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 29, 2019 at 11:47 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 29, 2019 at 07:43:09PM -0700, Tri Vo wrote:
> > Userspace can use wakeup_sources debugfs node to plot history of suspend
> > blocking wakeup sources over device's boot cycle. This information can
> > then be used (1) for power-specific bug reporting and (2) towards
> > attributing battery consumption to specific processes over a period of
> > time.
> >
> > However, debugfs doesn't have stable ABI. For this reason, create a
> > 'struct device' to expose wakeup sources statistics in sysfs under
> > /sys/class/wakeup/wakeup<ID>/*.
>
> I agree with Rafael here, no need for the extra "wakeup" in the device
> name as you are in the "wakeup" namespace already.
>
> If you have an IDA-allocated name, there's no need for the extra
> 'wakeup' at all.
>
> > +int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *ws)
> > +{
> > +     struct device *dev;
> > +     int id;
> > +
> > +     id = ida_simple_get(&wakeup_ida, 0, 0, GFP_KERNEL);
> > +     if (id < 0)
> > +             return id;
>
> No lock needed for this ida?  Are you sure?
>
> > +     ws->id = id;
> > +
> > +     dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
> > +                                     wakeup_source_groups, "wakeup%d",
> > +                                     ws->id);
> > +     if (IS_ERR(dev)) {
> > +             ida_simple_remove(&wakeup_ida, ws->id);
> > +             return PTR_ERR(dev);
> > +     }
> > +
> > +     ws->dev = dev;
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(wakeup_source_sysfs_add);
> > +
> > +/**
> > + * wakeup_source_sysfs_remove - Remove wakeup_source attributes from sysfs.
> > + * @ws: Wakeup source to be removed from sysfs.
> > + */
> > +void wakeup_source_sysfs_remove(struct wakeup_source *ws)
> > +{
> > +     device_unregister(ws->dev);
> > +     ida_simple_remove(&wakeup_ida, ws->id);
>
> Again, no lock, is that ok?  I think ida's can work without a lock, but
> not always, sorry, I don't remember the rules anymore given the recent
> changes in that code.

Documentation says, "The IDA handles its own locking. It is safe to
call any of the IDA functions without synchronisation in your code."
https://www.kernel.org/doc/html/latest/core-api/idr.html#ida-usage

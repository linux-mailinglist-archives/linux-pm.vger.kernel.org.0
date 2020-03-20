Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 988FA18D8D9
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 21:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgCTUKq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 16:10:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44941 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgCTUKp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 16:10:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id 37so3607531pgm.11
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2020 13:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8wBJM863apF0IwOPmO9fuaOOqzaQw306izkJnc0/fII=;
        b=fvAklPMvJlNS9vNQhJdK1AuiQZmkjC9vvIRMZAQNcvfDDWR0w81khYqp5RiIul11WS
         WNDSy3c75Luwy9fag1iFfAx9/w70boBzrfy11P7KavWhZ+KyL4ceLQOJRHR1B3zrPJUZ
         qdClxBt0eYYcn70/mYeISAvctswbPnd48V7CRpzrwo3NX8m/mAo6R6EhXlXVD9++v7TH
         uYxvLdjJRlOBxjGld2ZPPSL3GxoFznoZ8mkQV+c9Q3N7U+vOYd5Lmjf43xm/r76g91X/
         AUhtUkfSWDvveqHe5UZzR9+cCVaNJjrJ+Pco0WFaX1iLxXn9O15Mu5/ruLY0L6YUn2/+
         4ONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8wBJM863apF0IwOPmO9fuaOOqzaQw306izkJnc0/fII=;
        b=O4RaxSDgVK0yPqCyGJtnoZVx8EMNWi7fqcJbjzB9kUfiNix+RIQG3W+HS3kRKln7Xm
         SwONNbdr9lS1EmQDbpy3ooSDKtOp8yPvQ3fqmuw40GiNMonCJaPdvWKZtgw9ZR66bsY3
         /F3iNqRJd1NqessA3CZ//xeh7lLufj8snfZSDkhOsSUlFPUyFMXx6dij/EqI2Lj7tHOp
         9QYOFJrZWy9basgGYTHNydOe8LcMm0J4XaJ6vXDy+iKeVW87ZDW//xd/TjrVcNfQFFgu
         KZ1GjdT11ip/HzAiSmsgqvnYrbFIzhtmtxgZXQ0CdFNbtDVeDpn8qw2N4meZ0PCXjBM6
         zj4A==
X-Gm-Message-State: ANhLgQ0WjMVYqxxLmf0FpZO6d8/8LGz74QoqVZJ5023/zrVu/paXkMgN
        p4YB4222DtBH7gorNOT3wpgDSA==
X-Google-Smtp-Source: ADFU+vt4bqdyXNnRbChIEYqGnF9tjkMzkpQ2TcoyY685E+bmpfFRtb9zrOeEKlZxBHUT4jtOCkI9MQ==
X-Received: by 2002:a63:4d6:: with SMTP id 205mr10113365pge.10.1584735044151;
        Fri, 20 Mar 2020 13:10:44 -0700 (PDT)
Received: from google.com ([2620:15c:211:202:ae26:61fb:e2f3:92e7])
        by smtp.gmail.com with ESMTPSA id t142sm5878431pgb.31.2020.03.20.13.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 13:10:43 -0700 (PDT)
Date:   Fri, 20 Mar 2020 13:10:38 -0700
From:   Marco Ballesio <balejs@google.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        cgroups@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>, lizefan@huawei.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, rjw@rjwysocki.net,
        Pavel Machek <pavel@ucw.cz>, len.brown@intel.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-pm@vger.kernel.org, Minchan Kim <minchan@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] cgroup-v1: freezer: optionally killable freezer
Message-ID: <20200320201038.GB79184@google.com>
References: <20200219183231.50985-1-balejs@google.com>
 <20200303134855.GA186184@mtj.thefacebook.com>
 <CAKOZuevzE=0Oa8gn--rkVJ8t69S+o2vK--pki65XXg6EVuOhMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuevzE=0Oa8gn--rkVJ8t69S+o2vK--pki65XXg6EVuOhMQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 11, 2020 at 10:46:15AM -0700, Daniel Colascione wrote:
> On Tue, Mar 3, 2020 at 5:48 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello,
> >
> > On Wed, Feb 19, 2020 at 10:32:31AM -0800, Marco Ballesio wrote:
> > > @@ -94,6 +94,18 @@ The following cgroupfs files are created by cgroup freezer.
> > >    Shows the parent-state.  0 if none of the cgroup's ancestors is
> > >    frozen; otherwise, 1.
> > >
> > > +* freezer.killable: Read-write
> > > +
> > > +  When read, returns the killable state of a cgroup - "1" if frozen
> > > +  tasks will respond to fatal signals, or "0" if they won't.
> > > +
> > > +  When written, this property sets the killable state of the cgroup.
> > > +  A value equal to "1" will switch the state of all frozen tasks in
> > > +  the cgroup to TASK_INTERRUPTIBLE (similarly to cgroup v2) and will
> > > +  make them react to fatal signals. A value of "0" will switch the
> > > +  state of frozen tasks to TASK_UNINTERRUPTIBLE and they won't respond
> > > +  to signals unless thawed or unfrozen.
> >
> > As Roman said, I'm not too sure about adding a new cgroup1 freezer
> > interface at this point. If we do this, *maybe* a mount option would
> > be more minimal?
> 
> I'd still prefer a cgroup flag. A mount option is a bigger
> compatibility risk and isn't really any simpler than another cgroup
> flag. A mount option will affect anything using the cgroup mount
> point, potentially turning non-killable frozen processes into killable
> ones unexpectedly. (Sure, you could mount multiple times, but only one
> location is canonical, and that's the one that's going to get the flag
> flipped.) A per-cgroup flag allows people to opt into the new behavior
> only in specific contexts, so it's safer.

It might also be desirable for userland to have a way to modify the behavior of
an already mounted v1 freezer.

Tejun, would it be acceptable to have a flag but disable it by default, hiding
it behind a kernel configuration option?

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 812B5F43C2
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 10:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbfKHJpS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 04:45:18 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44062 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730069AbfKHJpS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 04:45:18 -0500
Received: by mail-oi1-f195.google.com with SMTP id s71so4683939oih.11;
        Fri, 08 Nov 2019 01:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2UcYEqpXM4Ks5cSeDXBgcT+UaloVWs40SjYreEdd2/E=;
        b=eOeheU5Y+zTGOcagb5GAR6eBrbWUVjyYDLhBA5gs7wKhGjEtVoE/h+5lToDnmximL0
         +UaXOdrCXR2ee5qecn5o7AP7rkHvzvbWT5fLDc8dB8m9s9ixKLk9eEmiF+LwOW3FNjhP
         UK7YxckIwB4+XieYMA2VVL3OzXopD7WxcgAJgE1iPYKt0U9/LvWIgtpojh/L75ClP18K
         vxUHqx8u2AkGY6LsrjmpXGKKx+pjcnBWDEuI8T6R0AAa13Tvtmxa555p1cqkHjJbbAFN
         cDwyt0XKAC86qJxjHIKK7FNTm53ke59x5VlcP/JFU6csT7rq6o43a+22hxfnnbKIcyrk
         cQfA==
X-Gm-Message-State: APjAAAXFQjwOu4+hRXrXOPi0m0DooRvpbdZizc8QTQ6oiOeIa1N+tw4d
        2XJ2QD/qT85Vid64bIHOTx5vffs4MoxNHvW5sD4=
X-Google-Smtp-Source: APXvYqxCGQtKJWcBpHJX65cp2GU/cjS3W5KP9vfqBCFJwJo6ZAHeabdQN3yBAgkA6Sc/z9oEmO8Ff7VpUXttTzhC1jg=
X-Received: by 2002:a05:6808:8c5:: with SMTP id k5mr8874416oij.57.1573206315744;
 Fri, 08 Nov 2019 01:45:15 -0800 (PST)
MIME-Version: 1.0
References: <10494959.bKODIZ00nm@kreacher> <3269796.AzLOQfDnpo@kreacher>
 <CAJZ5v0jM3+qMvO6dx=FmK-xF0q3YKOwBf-yUPXSBfRjxJ59Cpg@mail.gmail.com> <000701d59610$e0b3caa0$a21b5fe0$@net>
In-Reply-To: <000701d59610$e0b3caa0$a21b5fe0$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Nov 2019 10:45:03 +0100
Message-ID: <CAJZ5v0gsK0OmqAvw2BVGvajPmCTrRGFVVZ0+Y99ZkbbUcWYGOg@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: Use nanoseconds as the unit of time
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 8, 2019 at 9:45 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2019.11.07 17:44 Rafael J. Wysocki wrote:
> > On Thu, Nov 7, 2019 at 3:25 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >>
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> Currently, the cpuidle subsystem uses microseconds as the unit of
> >> time which (among other things) causes the idle loop to incur some
> >> integer division overhead for no clear benefit.
> >>
> >> In order to allow cpuidle to measure time in nanoseconds, add two
> >> additional fields, exit_latency_ns and target_residency_ns, to
> >> represent the exit latency and target residency of an idle state
> >> in nanoseconds, respectively, to struct cpuidle_state_usage and
> >> initialize them with the help of the corresponding values in
> >> microseconds provided by drivers.  In addition to that, change
> >> cpuidle_governor_latency_req() to return the idle state exit
> >> latency constraint in nanoseconds.
> >>
> >> With that, meeasure idle state residency (last_residency_ns in
> >> struct cpuidle_device and time_ns in struct cpuidle_driver) in
> >> nanoseconds and update the cpuidle core and governors accordingly.
> >>
> >> However, the menu governor still computes typical intervals in
> >> microseconds to avoid integer overflows.
> >
> > Since this addresses all of the comments received by the RFC version
> > that was posted over a month ago and I don't see any more issues with
> > it, I'm tempted to simply queue it up for 5.5 unless somebody sees a
> > good enough reason why that would be a bad idea.
>
> Could I please have another day or two?

Sure, it won't go straight into linux-next anyway. :-)

> I did try the RFC version, but not much as I went off on those
> teo issues and backtracked pretty quickly.
>
> I have been running this v2 today, with both menu and teo
> governors. Acquiring some baseline reference data to compare
> to now. The menu governor response seems different (Supporting
> information/graphs will come later).

That may be good or bad, depending in what way it is different. :-)

> teo just started.
>
> I lost a bunch of time due to being somewhat linux-next challenged.

No worries, please take your time!

I very much appreciate the testing work you are doing.

Cheers!

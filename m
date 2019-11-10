Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0212F6A40
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2019 17:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfKJQsi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Nov 2019 11:48:38 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34157 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfKJQsi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Nov 2019 11:48:38 -0500
Received: by mail-ot1-f65.google.com with SMTP id t4so9382833otr.1;
        Sun, 10 Nov 2019 08:48:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+Hr26sKlbLNkFabRdYHJh0Vikgffq61go87PtY2UhY=;
        b=WkiBwAkeGj3UN+no84lM+DuSqJW8lTahaG6c8SnsN13trd8K6AUtiblhRV7MUlu2CW
         uwoejGjXbAd2YwBNbYjv9JGtNzVv1VrBzGzuIay6NEoecVWcDvdsCd7RcsBJHBcJmGi+
         0U9zhqbiYMIgDam2E9gKbo0lqLTpwsdTmvdxs1VAvsWBx4BBJD7v7qpK52GepldhyYPd
         D5aJjXo9zSkrYRvUwYz9a42NZ/RHhIQwlxb7vFOedHQoLcMbj5QPbtTbZQwByU9iaWqk
         NEodSVVRpfCxv4xJr3rrLrTi2J8oLCyr59sOVqhFrCBgrz2Kk4aFdbLHfzve9yJxZ0jI
         CToA==
X-Gm-Message-State: APjAAAXV+tXPBDI2C/9OdZPxBnlDFDCDB0pYJ3v95irWIR2gBr81LQmk
        RaMtCUJppZYo22UMX4yET7o0R+WKE1SeLC04w/4=
X-Google-Smtp-Source: APXvYqxuVzOnIt2l3F8NIGk/yDQJdv9j9+oZHfSr+qXwah8ELqgiaaMixwOSIRXvdrhjma0/WrY8jCGcq1ir1wGunhI=
X-Received: by 2002:a9d:590f:: with SMTP id t15mr17448636oth.118.1573404515975;
 Sun, 10 Nov 2019 08:48:35 -0800 (PST)
MIME-Version: 1.0
References: <10494959.bKODIZ00nm@kreacher> <3269796.AzLOQfDnpo@kreacher>
 <CAJZ5v0jM3+qMvO6dx=FmK-xF0q3YKOwBf-yUPXSBfRjxJ59Cpg@mail.gmail.com>
 <000701d59610$e0b3caa0$a21b5fe0$@net> <CAJZ5v0gsK0OmqAvw2BVGvajPmCTrRGFVVZ0+Y99ZkbbUcWYGOg@mail.gmail.com>
 <000a01d59656$99798710$cc6c9530$@net>
In-Reply-To: <000a01d59656$99798710$cc6c9530$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 10 Nov 2019 17:48:21 +0100
Message-ID: <CAJZ5v0gZDJ2=PiiGw2mcCcVKBM2OyM1G9nRvJ+iWLFUQcXqZuw@mail.gmail.com>
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

On Fri, Nov 8, 2019 at 6:04 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2019.11.08 01:45 Rafael J. Wysocki wrote:
> > On Fri, Nov 8, 2019 at 9:45 AM Doug Smythies <dsmythies@telus.net> wrote:
> >
> ...
> >> I have been running this v2 today, with both menu and teo
> >> governors. Acquiring some baseline reference data to compare
> >> to now. The menu governor response seems different (Supporting
> >> information/graphs will come later).
> >
> > That may be good or bad, depending in what way it is different. :-)
>
> My thinking was that the differences should be minimal between
> the baseline (linux-next as of 2019.11.07) and plus your two patches.
> Because this was a change of units, but not functionality.
> Such is the case with the teo governor, but not the menu governor.
> I have not tried the ladder or haltpoll governors, and don't intend to.
>
> Now to attempt to isolate the issue in the code, which might take
> considerable time.

Thanks!

It looks like I have overlooked a unit conversion in menu or done a
unit conversion twice somewhere.

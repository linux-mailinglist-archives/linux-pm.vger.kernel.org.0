Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 956CB19850D
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 22:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgC3UC5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 16:02:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39754 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbgC3UC4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 16:02:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so23231920wrt.6;
        Mon, 30 Mar 2020 13:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lUoPyqpOq6RP3wBIxyXoInQVTdgsWS5bkgCqjwXu9nU=;
        b=fF3lDVd0+nOdf+SmI3pdq4CKWRPLEbKg+Iddc3FCIGFItLiFnhUd9ww8ytaaQzoVWm
         isPZdjckh/nSC1WxgrhgigRTHzwEOPtTRnjBlYsbAEQTTi+NEA31IxAKVM32weUbryu7
         Fsl/jare2y6apJbP5hmgKtocnok1+DZCqU0qb5dT/jo/FlsvvXBiY9pRyTx3HE4LCiBv
         SupTvFWu7Jn5rcGOLaaUgrIaspQXX2WK3mAmQ9HHiQwHZVZ3Yx3gkDzfaZ7AXhWxLbm4
         q7gWsytDf8liDhZ+vCwAgw7ioTuol++Gj+8BOWBSLTm36A32ULVHpPm2J9BUSVlLRVvv
         o7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lUoPyqpOq6RP3wBIxyXoInQVTdgsWS5bkgCqjwXu9nU=;
        b=jlF9TbFUUlew41f0yQ+mVRXEot8zFj4r4UjqJmwiolF3KwXrRWWIf9Gt7WK0rWyKpP
         l3S8Z9+KIOP9hG+COWoLP4Exdnovo/vjGgvh/LQCEzSRBJ6HifLqjRzre3tHNnX8bkWJ
         QUBJfw7qpSXOhDPmubAEf+1/ncUZ5/V1nxL1X5Coe6D0jWjcu2OfY1yYHB9j2mcbGzg8
         rGzV8Kd8e2MZfXO93E0p4rFbGPU1Nm3q87QnyoY7DE3T5dzbnDxyt4VGkep88S+1iDAN
         r9TuUmL6AKVLAl/JaOAkqYbJC7oiZFmIZnEXc0ThPqtBiYpwthjutaKqoDyCWZcNBUo8
         ueqQ==
X-Gm-Message-State: ANhLgQ3oJgKGm2MeqSgh8Bp90ah/IrcHo7jeF+F0loIJnrvGsQL064lM
        VMsMU0m5Dio42cUp72VOaYmRi6Qj3bgKzXuAhWg=
X-Google-Smtp-Source: ADFU+vtQlK+r3Yrpq43PZR2UUtb2/43lw4wmabJo+l6BQcrfH3L3MQhoDPa7agHgdNMp3nuYxd0qACHoAz+25H8MyNg=
X-Received: by 2002:adf:ecc3:: with SMTP id s3mr16006565wro.32.1585598573917;
 Mon, 30 Mar 2020 13:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200324122023.9649-1-andriy.shevchenko@linux.intel.com>
 <20200324122023.9649-3-andriy.shevchenko@linux.intel.com> <CAJZ5v0gg=V8uDd4afJ3MULsgKYvWajKJioANk4jj7xEhBzrRrQ@mail.gmail.com>
 <CA+G9fYvFnXqSnoQSJ-DkQvAFv87iWmhH6dT1N79qrq=Aeuv4rw@mail.gmail.com>
 <028b636f-6e0f-c36a-aa4e-6a16d936fc6a@arm.com> <20200330095707.GA10432@bogus>
 <0a374eaa-92b3-0201-f357-4181542c98b6@arm.com> <CAHp75VdBm8ZYOMWmQEA8LD6uGcJ0sZ=M6n3MSYxmO6UkXbu+-A@mail.gmail.com>
 <f2706518-def8-1566-149f-00fc1d8cc19f@arm.com>
In-Reply-To: <f2706518-def8-1566-149f-00fc1d8cc19f@arm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 30 Mar 2020 13:02:43 -0700
Message-ID: <CANcMJZBEiXaw5=VW1tjShkULa0YdcKxAgudaBKhrgyRFe7HacQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] driver core: Replace open-coded list_last_entry()
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Ferry Toth <fntoth@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 30, 2020 at 6:30 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-03-30 2:11 pm, Andy Shevchenko wrote:
> > On Mon, Mar 30, 2020 at 3:49 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >> On 2020-03-30 11:13 am, Sudeep Holla wrote:
> >>> On Fri, Mar 27, 2020 at 07:40:25PM +0000, Robin Murphy wrote:
> >
> > ...
> >
> >> AFAICS the difference is down to whether deferred_probe_timeout has
> >> expired or not - I'm not familiar enough with this code to know
> >> *exactly* what the difference is supposed to represent, nor which change
> >> has actually pushed the Juno case from one state to the other (other
> >> than it almost certainly can't be $SUBJECT - if this series is to blame
> >> at all I'd assume it would be down to patch #1/3, but there's a bunch of
> >> other rework previously queued in -next that is probably also interacting)
> >
> > JFYI: patch #1/3 wasn't applied.
>
> OK, so if anyone's invested enough to want to investigate, it must be
> something in John's earlier changes here:
>
> https://lore.kernel.org/lkml/20200225050828.56458-1-john.stultz@linaro.org/

Hey all,
  Sorry, I just got a heads up about this thread.

So yea, it looks like the change is due likely to the first patch in
my series. Previously, after initcall_done, (since
deferred_probe_timeout was -1 unless manually specified) if the driver
wasn't already loaded we'd print "ignoring dependency for device,
assuming no driver" and return ENODEV.

Now, if modules are enabled (as without modules enabled, I believe
you'd see the same behavior as previous), we wait 30 seconds  (for
userspace to load any posssible modules that meet that dependency) and
then the driver_deferred_probe_timeout fires and we print "deferred
probe timeout, ignoring dependency".

It seems the issue here is the first message was printed with
dev_warn() and the second with dev_WARN() which provides the scary
backtrace.

I think functionally as mentioned above, there's no real behavioral
change here. But please correct me if that's wrong.

Since we are more likely to see the second message now, maybe we
should make both print via dev_warn()?

I'll spin up a patch.

thanks
-john

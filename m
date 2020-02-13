Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 203A015BDB8
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 12:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbgBMLgW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 06:36:22 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41002 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgBMLgW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 06:36:22 -0500
Received: by mail-ot1-f68.google.com with SMTP id r27so5231069otc.8;
        Thu, 13 Feb 2020 03:36:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zj3Cy+ZdryRl51K+ddpsg8bzCDF5qrepn0JC6SP151s=;
        b=oLKZ7odfEwjg/v8T2Eb/YMbE2VaqpMQXvdwuQeJZ2sR0u2loHQo21pkn+VSgxBsaSn
         IJJn2aP7tJWayM2iGo3qylSyF0cUH3TzXKYTBzNQ2fotZr+FooXDzUkAO1Pj+V1WUYdl
         oVNvNqe3suOudiE6tzgzeejBcpwqNmWotEgozde6pf4FPStbnW5XhuiJhN7djcXAWCRN
         /UX57NJHdGIJs/QZXfV7ozIf1AKKd/jpHmlcWn0/RIcP8lN4OuTtx8EGn9BddoVglni9
         0TNCxyeVK1Syc7Aeyxu34RK/sDHQCed0Xwtaa1pIpafG44wlskbi2WX2l8s4ZJUQmjoF
         FrHQ==
X-Gm-Message-State: APjAAAVjZ+iE0e945LqNIkDI8MQhPEPAesevcjDkBE2GEWFcU6Kb4RJG
        QpdsqNLPK5alUpjWVfZFNG8NcpjUKHRBY/MxL8+8JLbw
X-Google-Smtp-Source: APXvYqzAm9MzCByym4P/YRlcLqRVNha6O0/BpwrLcVv7wOIqwuyXJbLDHEA9CTGKKS21NF/xnO2dOiQ7oY4qUh3/v+E=
X-Received: by 2002:a9d:7653:: with SMTP id o19mr12549270otl.118.1581593780696;
 Thu, 13 Feb 2020 03:36:20 -0800 (PST)
MIME-Version: 1.0
References: <1654227.8mz0SueHsU@kreacher> <CAP245DXY2MsV6rf95QdATTXXZWoYYLFBO3QxQgkg=44Fw0cLNA@mail.gmail.com>
 <CAJZ5v0i5thgrdGNQ+a1tuw=CGa8PAhHt19GoDpC8KLLjNVoQLQ@mail.gmail.com> <CAP245DUGieaBgN6NCOpjbZtWsX5Bext1S4NqySYXK_H6Go5FgA@mail.gmail.com>
In-Reply-To: <CAP245DUGieaBgN6NCOpjbZtWsX5Bext1S4NqySYXK_H6Go5FgA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Feb 2020 12:36:09 +0100
Message-ID: <CAJZ5v0gn=retwWpDaZC5jikyRQdYTRVQUqMaYKGkdMeNqz7wuw@mail.gmail.com>
Subject: Re: [PATCH 00/28] PM: QoS: Get rid of unuseful code and rework CPU
 latency QoS interface
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 13, 2020 at 11:50 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> On Thu, Feb 13, 2020 at 3:47 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Feb 13, 2020 at 8:10 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
> > >
> > > On Wed, Feb 12, 2020 at 5:09 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > >
> > > > Hi All,
> > > >
> > > > This series of patches is based on the observation that after commit
> > > > c3082a674f46 ("PM: QoS: Get rid of unused flags") the only global PM QoS class
> > > > in use is PM_QOS_CPU_DMA_LATENCY, but there is still a significant amount of
> > > > code dedicated to the handling of global PM QoS classes in general.  That code
> > > > takes up space and adds overhead in vain, so it is better to get rid of it.
> > > >
> > > > Moreover, with that unuseful code removed, the interface for adding QoS
> > > > requests for CPU latency becomes inelegant and confusing, so it is better to
> > > > clean it up.
> > > >
> > > > Patches [01/28-12/28] do the first part described above, which also includes
> > > > some assorted cleanups of the core PM QoS code that doesn't go away.
> > > >
> > > > Patches [13/28-25/28] rework the CPU latency QoS interface (in the classic
> > > > "define stubs, migrate users, change the API proper" manner), patches
> > > > [26-27/28] update the general comments and documentation to match the code
> > > > after the previous changes and the last one makes the CPU latency QoS depend
> > > > on CPU_IDLE (because cpuidle is the only user of its target value today).
> > > >
> > > > The majority of the patches in this series don't change the functionality of
> > > > the code at all (at least not intentionally).
> > > >
> > > > Please refer to the changelogs of individual patches for details.
> > >
> > > Hi Rafael,
> > >
> > > Nice cleanup to the code and docs.
> > >
> > > I've reviewed the series, and briefly tested it by setting latencies
> > > from userspace. Can we not remove the debugfs interface? It is a quick
> > > way to check the global cpu latency clamp on the system from userspace
> > > without setting up tracepoints or writing a program to read
> > > /dev/cpu_dma_latency.
> >
> > Come on.
> >
> > What about in Python?
> >
> > #!/usr/bin/env python
> > import numpy as np
> >
> > if __name__ == '__main__':
> >     f = open("/dev/cpu_dma_latency", "r")
> >     print(np.fromfile(f, dtype=np.int32, count=1))
> >     f.close()
> >
> > And probably you can do it in at least 20 different ways. :-)
>
> Indeed, I can, just not as straightforward as "cat /debugfs/filename"
> when you don't have python or perl in your buildroot initramfs.
>
> Some hexdump/od acrobatics will yield the value, I guess.

Right,

# hexdump --format '"%d\n"' /dev/cpu_dma_latency

works just fine, actually.

Thanks!

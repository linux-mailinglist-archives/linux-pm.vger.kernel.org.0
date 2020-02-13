Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F67A15BCAE
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 11:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgBMKWy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 05:22:54 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37656 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgBMKWy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 05:22:54 -0500
Received: by mail-oi1-f193.google.com with SMTP id q84so5256369oic.4;
        Thu, 13 Feb 2020 02:22:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W2C9FXZyeBSP5qnOj9RpvcHEqx78H3IZjKkqnNTsiE4=;
        b=FS/IJ/0KnJxvIWO1RBXS1sfhKI4MH95WVJLwv7aOIvUfC6vaDDFjNsIZw63XsuB7EZ
         /p/a5tgbAkO+rauf5EJUzsuEgWLr5TPVr7k4c7/vpUkxsyvIB4QLjYuPfcwQzSmPmv67
         /OkV8CR2j5+XYNVN+8AVhE+xQV2lGEfiyrSYgY5suKnVhi6uF99mJZf7/pKyHJ7+nkFy
         cfSq5yWdoE4HRpL/YA4urjGActSji9I9msPJws/ZGKuKs7Q+7/WMwrxYmHRQMu7u6xm4
         0+iEjRIDmaBHH9BQsS+GcareiOWAVQpS4oJe8+2JYyAo4SJGnNps+IWJEBBS0FeuHZDX
         WRKA==
X-Gm-Message-State: APjAAAUgJbchAHEtqwaWuIpI5Jgj75L35pWJugVyGYEuBjbUbKeMmywd
        ePVAy7ti3sPCzaH9ZHt1Oxwanv0goh0ZKVxVRTk=
X-Google-Smtp-Source: APXvYqxwqwsWdokR16/UlVETgb52cFCxF++w+DEYlicYB2NSWXaxFv6EFBsEuje4nrJSOnBZxF/fmBBu+t+QzKV85/s=
X-Received: by 2002:a54:488d:: with SMTP id r13mr2279161oic.115.1581589372343;
 Thu, 13 Feb 2020 02:22:52 -0800 (PST)
MIME-Version: 1.0
References: <1654227.8mz0SueHsU@kreacher> <CAP245DXY2MsV6rf95QdATTXXZWoYYLFBO3QxQgkg=44Fw0cLNA@mail.gmail.com>
 <CAJZ5v0i5thgrdGNQ+a1tuw=CGa8PAhHt19GoDpC8KLLjNVoQLQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0i5thgrdGNQ+a1tuw=CGa8PAhHt19GoDpC8KLLjNVoQLQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Feb 2020 11:22:41 +0100
Message-ID: <CAJZ5v0g5+k3GRy+p-6GxmsbpVNiRwvWXZ+w7-Jhq53oxJpZCgw@mail.gmail.com>
Subject: Re: [PATCH 00/28] PM: QoS: Get rid of unuseful code and rework CPU
 latency QoS interface
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 13, 2020 at 11:17 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Feb 13, 2020 at 8:10 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
> >
> > On Wed, Feb 12, 2020 at 5:09 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > Hi All,
> > >
> > > This series of patches is based on the observation that after commit
> > > c3082a674f46 ("PM: QoS: Get rid of unused flags") the only global PM QoS class
> > > in use is PM_QOS_CPU_DMA_LATENCY, but there is still a significant amount of
> > > code dedicated to the handling of global PM QoS classes in general.  That code
> > > takes up space and adds overhead in vain, so it is better to get rid of it.
> > >
> > > Moreover, with that unuseful code removed, the interface for adding QoS
> > > requests for CPU latency becomes inelegant and confusing, so it is better to
> > > clean it up.
> > >
> > > Patches [01/28-12/28] do the first part described above, which also includes
> > > some assorted cleanups of the core PM QoS code that doesn't go away.
> > >
> > > Patches [13/28-25/28] rework the CPU latency QoS interface (in the classic
> > > "define stubs, migrate users, change the API proper" manner), patches
> > > [26-27/28] update the general comments and documentation to match the code
> > > after the previous changes and the last one makes the CPU latency QoS depend
> > > on CPU_IDLE (because cpuidle is the only user of its target value today).
> > >
> > > The majority of the patches in this series don't change the functionality of
> > > the code at all (at least not intentionally).
> > >
> > > Please refer to the changelogs of individual patches for details.
> >
> > Hi Rafael,
> >
> > Nice cleanup to the code and docs.
> >
> > I've reviewed the series, and briefly tested it by setting latencies
> > from userspace. Can we not remove the debugfs interface? It is a quick
> > way to check the global cpu latency clamp on the system from userspace
> > without setting up tracepoints or writing a program to read
> > /dev/cpu_dma_latency.
>
> Come on.
>
> What about in Python?
>
> #!/usr/bin/env python
> import numpy as np
>
> if __name__ == '__main__':
>     f = open("/dev/cpu_dma_latency", "r")
>     print(np.fromfile(f, dtype=np.int32, count=1))
>     f.close()
>
> And probably you can do it in at least 20 different ways. :-)
>
> Also note that "echo the_debugfs_thing" does the equivalent, but the

I obviously meant "cat the_debugfs_thing" here, sorry.

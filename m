Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0131F15BD14
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 11:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgBMKuK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 05:50:10 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39294 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgBMKuK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 05:50:10 -0500
Received: by mail-lj1-f193.google.com with SMTP id o15so6035556ljg.6
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2020 02:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fXD3NUgPbItg+EdbT8uLMEndhqABRKbmudYKP6OTeTY=;
        b=tEK2VNcvvP/Fs8a1XfdgXwXHAOHziWPxDjtTpPnfs0njU9+Z6xURNs5tbTbgsTdhSW
         et1ExI+S25xMn8ikhaf6LY2hQYaT/rUBAXh1BHPIKTWBgP7ZSeNgtHjVcK9ZngzHSOkl
         vPICzA2jGI8DmbzYqLApFKFoX975IEB1MmG03dvR6DqsTw7rGYzIyY7gZGZwa3eXqkRW
         Utt1Bo/TtLIjbpDEJRtVBZLLo/SjZ8ZsTMh293ElsFy4pLGm3jN0cnVO6dFG0fGRgW89
         k74WVlE/X7pNhpyUq9Px0DDsLB3Tl8hTxC+lLpMRpidtjejTf/TJCdh/B/pKLIA2JUfQ
         v7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fXD3NUgPbItg+EdbT8uLMEndhqABRKbmudYKP6OTeTY=;
        b=nJFYJ1i/8uaxZ2zcaq7PtDIFpX8wJhDtzMjt0pawvUm0H3MgFMKFIBOYY/GYFgiZcV
         Onyi75zlA2eIdfS1EqWQlJ41gyFjJtwNV7SNI53mqU6FAXvae8VMMQoY0IBXKzZeGgPX
         m0jTUCH143YvFVMib0fV+zWFFIzcHsBhogEIZ9oiVe9+uwnv5+xU8BzyLjYGFi3468hP
         po3aCJiXKm1YvvxHy38Gr1kNSEbhKW7WovgEpkPqZMLUHclDOfItIKYHkJT9BBgUGlGU
         p3V/2QzmsvUYbB3IUKgN3PuOrRfZ8rd2vE8PqeZVUjonP4mHKQ51/XEUarJZaY8aaWSQ
         F/Ow==
X-Gm-Message-State: APjAAAWwaVb3nCHjZWb1IRdR5FgJrzW7hgkJ0pAUB7H4prOcv0LXjBPS
        Yls2AmUnLEwElSqY5xGiVCnVUZIX/6AU5QiJcBwZKg==
X-Google-Smtp-Source: APXvYqyMQjetx0saudaTZFe7piFiYoReolaCxitIUPkUXnWVRMTfqYurmvJRIyNi0I8RKA/8Fczfx3OYaZFvTZVl6Ig=
X-Received: by 2002:a2e:8e91:: with SMTP id z17mr10501916ljk.13.1581591007651;
 Thu, 13 Feb 2020 02:50:07 -0800 (PST)
MIME-Version: 1.0
References: <1654227.8mz0SueHsU@kreacher> <CAP245DXY2MsV6rf95QdATTXXZWoYYLFBO3QxQgkg=44Fw0cLNA@mail.gmail.com>
 <CAJZ5v0i5thgrdGNQ+a1tuw=CGa8PAhHt19GoDpC8KLLjNVoQLQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0i5thgrdGNQ+a1tuw=CGa8PAhHt19GoDpC8KLLjNVoQLQ@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 13 Feb 2020 16:19:56 +0530
Message-ID: <CAP245DUGieaBgN6NCOpjbZtWsX5Bext1S4NqySYXK_H6Go5FgA@mail.gmail.com>
Subject: Re: [PATCH 00/28] PM: QoS: Get rid of unuseful code and rework CPU
 latency QoS interface
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 13, 2020 at 3:47 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
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

Indeed, I can, just not as straightforward as "cat /debugfs/filename"
when you don't have python or perl in your buildroot initramfs.

Some hexdump/od acrobatics will yield the value, I guess.

> Also note that "echo the_debugfs_thing" does the equivalent, but the
> conversion takes place in the kernel.  Is it really a good idea to
> carry the whole debugfs interface because of that one conversion?
>
> > Except for patch 01/28 removing the debugfs interface, please feel to add my
> >
> > Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
> > Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
>
> Thanks!

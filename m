Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E29F715BC8D
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 11:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgBMKRZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 05:17:25 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36344 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbgBMKRY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 05:17:24 -0500
Received: by mail-oi1-f193.google.com with SMTP id c16so5241065oic.3;
        Thu, 13 Feb 2020 02:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UmM5NXNcETsSD9gaokm/HGtL7fBM7CvM2iUBsAPp3HY=;
        b=bmO0XlLPkHLs6xm3pJaJ1CSMnWD1aIfeUtKi+3DemROzU++4C3A9C/rw3O5LAN7APM
         ohFWGZTERwohzs2yKEh8lApWsWGtq6+fRNWTtBbPiahAzSd5lt5SutkszzNG2M6oTZH+
         8pvmFprkq2SMDNtO8sS8EtaIHZO5MK/tAm/8/7pcMRa5iP/788SB12dgtOgIQbKF+/az
         tyEgJqRYDP30C3piRpDyGSA4+AmczGIKNv4DmyQdTOGVYj/tp/dfZVy6HEaEX8WjNS7a
         cm1toxVxKLzDN631htCG2P9eha+ckVaNQCzNnFbr1e3T9uGIqoo2wCMO9Ogd+uPOcNFN
         Y04Q==
X-Gm-Message-State: APjAAAVtdfNM61AqlDhUq8rulg0fKu16w6O3RMAldxLA0accV4RVQZ/X
        Ce9SmNPBVdwRf3OEZJmYhJEc30tUIFp/+6eJ618=
X-Google-Smtp-Source: APXvYqx1gOwRIVhZqmxsMzXdhmTZ6mkSJd6vLVA+opgY3Sr/vxNAVShGOvP858qENQKEqxMP7NLYej+IvIZ/4vr7iKc=
X-Received: by 2002:a54:4e96:: with SMTP id c22mr2458959oiy.110.1581589042574;
 Thu, 13 Feb 2020 02:17:22 -0800 (PST)
MIME-Version: 1.0
References: <1654227.8mz0SueHsU@kreacher> <CAP245DXY2MsV6rf95QdATTXXZWoYYLFBO3QxQgkg=44Fw0cLNA@mail.gmail.com>
In-Reply-To: <CAP245DXY2MsV6rf95QdATTXXZWoYYLFBO3QxQgkg=44Fw0cLNA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Feb 2020 11:17:11 +0100
Message-ID: <CAJZ5v0i5thgrdGNQ+a1tuw=CGa8PAhHt19GoDpC8KLLjNVoQLQ@mail.gmail.com>
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

On Thu, Feb 13, 2020 at 8:10 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> On Wed, Feb 12, 2020 at 5:09 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > Hi All,
> >
> > This series of patches is based on the observation that after commit
> > c3082a674f46 ("PM: QoS: Get rid of unused flags") the only global PM QoS class
> > in use is PM_QOS_CPU_DMA_LATENCY, but there is still a significant amount of
> > code dedicated to the handling of global PM QoS classes in general.  That code
> > takes up space and adds overhead in vain, so it is better to get rid of it.
> >
> > Moreover, with that unuseful code removed, the interface for adding QoS
> > requests for CPU latency becomes inelegant and confusing, so it is better to
> > clean it up.
> >
> > Patches [01/28-12/28] do the first part described above, which also includes
> > some assorted cleanups of the core PM QoS code that doesn't go away.
> >
> > Patches [13/28-25/28] rework the CPU latency QoS interface (in the classic
> > "define stubs, migrate users, change the API proper" manner), patches
> > [26-27/28] update the general comments and documentation to match the code
> > after the previous changes and the last one makes the CPU latency QoS depend
> > on CPU_IDLE (because cpuidle is the only user of its target value today).
> >
> > The majority of the patches in this series don't change the functionality of
> > the code at all (at least not intentionally).
> >
> > Please refer to the changelogs of individual patches for details.
>
> Hi Rafael,
>
> Nice cleanup to the code and docs.
>
> I've reviewed the series, and briefly tested it by setting latencies
> from userspace. Can we not remove the debugfs interface? It is a quick
> way to check the global cpu latency clamp on the system from userspace
> without setting up tracepoints or writing a program to read
> /dev/cpu_dma_latency.

Come on.

What about in Python?

#!/usr/bin/env python
import numpy as np

if __name__ == '__main__':
    f = open("/dev/cpu_dma_latency", "r")
    print(np.fromfile(f, dtype=np.int32, count=1))
    f.close()

And probably you can do it in at least 20 different ways. :-)

Also note that "echo the_debugfs_thing" does the equivalent, but the
conversion takes place in the kernel.  Is it really a good idea to
carry the whole debugfs interface because of that one conversion?

> Except for patch 01/28 removing the debugfs interface, please feel to add my
>
> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
> Tested-by: Amit Kucheria <amit.kucheria@linaro.org>

Thanks!

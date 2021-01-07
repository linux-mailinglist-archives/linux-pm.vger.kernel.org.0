Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892FF2EE784
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jan 2021 22:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbhAGVQW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jan 2021 16:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbhAGVQV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jan 2021 16:16:21 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A89FC0612F5
        for <linux-pm@vger.kernel.org>; Thu,  7 Jan 2021 13:15:29 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o10so7051275lfl.13
        for <linux-pm@vger.kernel.org>; Thu, 07 Jan 2021 13:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TKs0fV6NhoCyOBE5f3/MGawBR0S3YXYEf2e8DTZq60I=;
        b=uOFERN45dgTYuB9A1SChV46j7m+Puc+TMuLTbVa+aO+MpTkMo0jNiVR149K9x/3Xxg
         b8bDLsBSNOkzt0W91UElG89VlcVdZD3brDOy8J2A876Bk9/A0Q3Nft/ZHbFICXjCrEQt
         9/SkUmrjrsf9fMBc2F31ItnpsrbJ+V4+VdgsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TKs0fV6NhoCyOBE5f3/MGawBR0S3YXYEf2e8DTZq60I=;
        b=faEES4+klhMvNt7zqkxfWNaC9cv7c5yWIrd3FH9ihaVbWocIvt+Ezlgc2uIL4R2oqD
         GmsgUWKijaZyorK78meGvSodt+eHzRsZUExQc4gGBXU0G/edoBgOTGV2MuRv1VsOJvBl
         VMVARJ+cXYZHDH6PCBtymafSsw7pGMFVA5xFQHxtslaZS7lLMhVKHSf7hFI8jErkH4eI
         UMtlTlS3jrTi4pzZpawa8bRUDNFOHrGqRmFCQgrIy0KW6dTJxenCsNQMFqGUl3+vzJR5
         SwtfIBWxmxY0Npg1fn98208aN4VUKqNRGRKWDysJWZg3ePVgEE+mxWnk/s05X1zdiqEP
         AGIg==
X-Gm-Message-State: AOAM5300VRJ/M6Nl/SQIGuo6YaYGsE+kji1oI3aHiFwXMN46qdDndAH3
        cOOlM8NFS2+LblOkjWxG977yoxOBDEDhyMSnarISIA==
X-Google-Smtp-Source: ABdhPJy55liTZNWi1UXpuwUDkKD4fqjRFNCx1C0skwjNBj5h2D+6PI2TrEVVftvoWVd1az66O6k3tPK/k8c427OSGrw=
X-Received: by 2002:a2e:574d:: with SMTP id r13mr149988ljd.479.1610054127441;
 Thu, 07 Jan 2021 13:15:27 -0800 (PST)
MIME-Version: 1.0
References: <20210104235719.13525-1-ivan@cloudflare.com> <2100533.HVZEckHxcR@c100>
 <CABWYdi0sne=6reP5oZMFbYk9Nctws=FLoYkjdmnBwXu0bVFozA@mail.gmail.com> <3977966.bfq5YHlNPR@c100>
In-Reply-To: <3977966.bfq5YHlNPR@c100>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Thu, 7 Jan 2021 13:15:16 -0800
Message-ID: <CABWYdi3yOYrLq_Zo2qrvFVZtwhbS85zWbt2+by0Fm6D3S17ZQw@mail.gmail.com>
Subject: Re: [PATCH] cpupower: add Makefile dependencies for install targets
To:     Thomas Renninger <trenn@suse.com>
Cc:     linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 7, 2021 at 12:59 PM Thomas Renninger <trenn@suse.com> wrote:
>
> Am Donnerstag, 7. Januar 2021, 18:42:25 CET schrieb Ivan Babrou:
> > On Thu, Jan 7, 2021 at 2:07 AM Thomas Renninger <trenn@suse.com> wrote:
> > > Am Dienstag, 5. Januar 2021, 00:57:18 CET schrieb Ivan Babrou:
> > > > This allows building cpupower in parallel rather than serially.
> > >
> > > cpupower is built serially:
> > >
> > > [ make clean ]
> > >
> > > time make
> > > real    0m3,742s
> > > user    0m3,330s
> > > sys     0m1,105s
> > >
> > > [ make clean ]
> > >
> > > time make -j10
> > > real    0m1,045s
> > > user    0m3,153s
> > > sys     0m1,037s
> > >
> > > Only advantage I see is that you can call
> > > make install-xy
> > > targets without calling the corresponding build target
> > > make xy
> > > similar to the general install target:
> > > install: all install-lib ...
> > >
> > > Not sure anyone needs this and whether all targets
> > > successfully work this way.
> > > If you'd show a useful usecase example...
> >
> > We build a bunch of kernel related tools (perf, cpupower, bpftool,
> > etc.) from our own top level Makefile, propagating parallelism
> > downwards like one should.
> I still do not understand why you do not simply build:
> Also if I call this from /tools directory I get a quick build:
> make -j20 cpupower
>
> Can you please show the make calls, ideally with a timing to better understand
> and also to reproduce the advantages this patch introduces.
> From what I can see, it only helps if one calls "sub-install" targets
> directly?

That's exactly what we do: make install directly:

/linux-5.10.5$ make -C ./tools/power/cpupower DESTDIR=/tmp/cpupower
install -j $(nproc)

make: Entering directory '/state/home/ivan/linux-5.10.5/tools/power/cpupower'
  CC       cpupower
  MSGFMT   po/de.gmo
  MSGFMT   po/fr.gmo
  MSGFMT   po/it.gmo
  MSGFMT   po/cs.gmo
/usr/bin/install -c -d /tmp/cpupower/usr/lib64
  MSGFMT   po/pt.gmo
/usr/bin/install -c -d /tmp/cpupower/usr/bin
/usr/bin/install -c -m 644 -D man/cpupower.1
/tmp/cpupower/usr/man/man1/cpupower.1
/usr/bin/install -c -d /tmp/cpupower/usr/share/locale
cp -fpR ./libcpupower.so* /tmp/cpupower/usr/lib64/
/usr/bin/install -c ./cpupower /tmp/cpupower/usr/bin
/usr/bin/install -c -m 644 -D man/cpupower-frequency-set.1
/tmp/cpupower/usr/man/man1/cpupower-frequency-set.1
make[1]: Entering directory
'/state/home/ivan/linux-5.10.5/tools/power/cpupower/bench'
for HLANG in de fr it cs pt; do \
echo '/usr/bin/install -c -m 644 -D ./po/$HLANG.gmo
/tmp/cpupower/usr/share/locale/$HLANG/LC_MESSAGES/cpupower.mo'; \
/usr/bin/install -c -m 644 -D ./po/$HLANG.gmo
/tmp/cpupower/usr/share/locale/$HLANG/LC_MESSAGES/cpupower.mo; \
done;
  CC       main.o
/usr/bin/install -c -d /tmp/cpupower/usr/share/bash-completion/completions
/usr/bin/install -c -m 644 -D ./po/$HLANG.gmo
/tmp/cpupower/usr/share/locale/$HLANG/LC_MESSAGES/cpupower.mo
  CC       parse.o
/usr/bin/install -c -m 644 -D man/cpupower-frequency-info.1
/tmp/cpupower/usr/man/man1/cpupower-frequency-info.1
  CC       system.o
/usr/bin/install: cannot stat './po/de.gmo'/usr/bin/install -c -d
/tmp/cpupower/usr/include
: No such file or directory
make[1]: Entering directory
'/state/home/ivan/linux-5.10.5/tools/power/cpupower/bench'
mkdir -p /tmp/cpupower//usr/sbin
/usr/bin/install -c -m 644 cpupower-completion.sh
'/tmp/cpupower/usr/share/bash-completion/completions/cpupower'
/usr/bin/install -c -m 644 -D ./po/$HLANG.gmo
/tmp/cpupower/usr/share/locale/$HLANG/LC_MESSAGES/cpupower.mo
  CC       benchmark.o
/usr/bin/install -c -m 644 -D man/cpupower-idle-set.1
/tmp/cpupower/usr/man/man1/cpupower-idle-set.1
/usr/bin/install: cannot stat './po/fr.gmo': No such file or directory
/usr/bin/install -c -m 644 -D ./po/$HLANG.gmo
/tmp/cpupower/usr/share/locale/$HLANG/LC_MESSAGES/cpupower.mo
mkdir -p /tmp/cpupower//usr/bin
/usr/bin/install -c -m 644 lib/cpufreq.h /tmp/cpupower/usr/include/cpufreq.h
/usr/bin/install -c -m 644 -D man/cpupower-idle-info.1
/tmp/cpupower/usr/man/man1/cpupower-idle-info.1
mkdir -p /tmp/cpupower//usr/share/doc/packages/cpupower
/usr/bin/install -c -m 644 -D ./po/$HLANG.gmo
/tmp/cpupower/usr/share/locale/$HLANG/LC_MESSAGES/cpupower.mo
/usr/bin/install -c -m 644 lib/cpuidle.h /tmp/cpupower/usr/include/cpuidle.h
mkdir -p /tmp/cpupower//etc/
/usr/bin/install -c -m 644 -D man/cpupower-set.1
/tmp/cpupower/usr/man/man1/cpupower-set.1
/usr/bin/install -c -m 644 -D ./po/$HLANG.gmo
/tmp/cpupower/usr/share/locale/$HLANG/LC_MESSAGES/cpupower.mo
install -m 755 .//cpufreq-bench /tmp/cpupower//usr/sbin/cpufreq-bench
/usr/bin/install -c -m 644 -D man/cpupower-info.1
/tmp/cpupower/usr/man/man1/cpupower-info.1
/usr/bin/install -c -m 644 -D man/cpupower-monitor.1
/tmp/cpupower/usr/man/man1/cpupower-monitor.1
install: cannot stat './/cpufreq-bench': No such file or directory
Makefile:31: recipe for target 'install' failed
make[1]: *** [install] Error 1
make[1]: Leaving directory
'/state/home/ivan/linux-5.10.5/tools/power/cpupower/bench'
Makefile:304: recipe for target 'install-bench' failed
make: *** [install-bench] Error 2
make: *** Waiting for unfinished jobs....
  CC       cpufreq-bench
make[1]: Leaving directory
'/state/home/ivan/linux-5.10.5/tools/power/cpupower/bench'
make: Leaving directory '/state/home/ivan/linux-5.10.5/tools/power/cpupower'

It works with -j 1. My patch makes it work with arbitrary parallelism,
same as any other tool we build internally (perf, bpftool, turbostat,
etc.).

> And I still do not understand why things should be more parallel now.
>
> > Without this patch we have to remove parallelism for cpupower,
> Why?
>
> > which doesn't seem like a very clean thing
> > to do, especially if you consider that it's 3x faster with parallelism
> > enabled in wall clock terms.
> Sure, you want to build in parallel. I still do not understand how this
> patch helps in this regard.
>
> BTW, I recently had a bunch of userspace tools Makefile patches.
> I'd like to add you to CC for a review if they are not submitted already.

Don't know how useful I can be, but feel free to.

>     Thomas
>
>

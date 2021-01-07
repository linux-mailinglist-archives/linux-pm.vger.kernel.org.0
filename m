Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8685B2ED5DE
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jan 2021 18:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbhAGRnY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jan 2021 12:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbhAGRnY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jan 2021 12:43:24 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCF7C0612F5
        for <linux-pm@vger.kernel.org>; Thu,  7 Jan 2021 09:42:38 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id h205so16530688lfd.5
        for <linux-pm@vger.kernel.org>; Thu, 07 Jan 2021 09:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LRqxwEPJISEBHpjqZE2l6FmdiTZQs0jM9TpD8cQN+YA=;
        b=V0YYF8gWI5uIyBICJ6udbyu5HQC3NPDSYKcM0W27RFdEEv//zmAWylWYvEw3vVGTLk
         7shGRVqcO5n0D/CR7V6LG8naB6ZmufIvZoX0HqL5BSNYe7lr1TVddGvzs3mMPz0MCPKo
         +zVPhNZ4dqAaZf48kkvaUOFLNxKSL/LGiN9TI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LRqxwEPJISEBHpjqZE2l6FmdiTZQs0jM9TpD8cQN+YA=;
        b=CY0wVWB6Vly2oTczy7CxlMYA7zPbzFExd1v+W0JfJN2ieVP2IrSZUh0hM0GI0Q5a7b
         yd0+vpi8Y8QGdORzNlC0fqQq9bHdwDd6F+jZns60BNDtV1hlSdZswEDFqAo1yFxhJEbw
         QTjrl5Q0wdAKVW8dQGj6JNB+u9jY3qPDduV1C6/12Txo8TgiHK9Ky5DbqtNRCQ5El2Ur
         2wVS9aFLtzkylxBCmz/0obsLGaKeXj6n8CddNG9Ca3BmciQzYdJ4NjtaKqE6iA06a9tr
         wEm9dxUJJivTdLIMRhTiYeZ1EjR6aNAjuk1Ig9NI+vLbtpVCJbEpvvXFAaZEZ+6rNIbm
         YRPA==
X-Gm-Message-State: AOAM532J44AX/t+C6DeYiWwnTSVKWVVFtOIAHmwzv8CXVXIONhZO1sYn
        BgWpDkUncUZ/S9SYvRz/MQJDeOM/swwEDuLyxsikEw==
X-Google-Smtp-Source: ABdhPJygMEw3KJuTWrlpSqVWGq/if+SbZTegdcW3m7/dcUQTyYrmU8L70iiNQ3ssYUB7pnsZwuPEnSXXThhWN89nycE=
X-Received: by 2002:a2e:361a:: with SMTP id d26mr4804735lja.115.1610041356957;
 Thu, 07 Jan 2021 09:42:36 -0800 (PST)
MIME-Version: 1.0
References: <20210104235719.13525-1-ivan@cloudflare.com> <2100533.HVZEckHxcR@c100>
In-Reply-To: <2100533.HVZEckHxcR@c100>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Thu, 7 Jan 2021 09:42:25 -0800
Message-ID: <CABWYdi0sne=6reP5oZMFbYk9Nctws=FLoYkjdmnBwXu0bVFozA@mail.gmail.com>
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

On Thu, Jan 7, 2021 at 2:07 AM Thomas Renninger <trenn@suse.com> wrote:
>
> Am Dienstag, 5. Januar 2021, 00:57:18 CET schrieb Ivan Babrou:
> > This allows building cpupower in parallel rather than serially.
>
> cpupower is built serially:
>
> [ make clean ]
>
> time make
> real    0m3,742s
> user    0m3,330s
> sys     0m1,105s
>
> [ make clean ]
>
> time make -j10
> real    0m1,045s
> user    0m3,153s
> sys     0m1,037s
>
> Only advantage I see is that you can call
> make install-xy
> targets without calling the corresponding build target
> make xy
> similar to the general install target:
> install: all install-lib ...
>
> Not sure anyone needs this and whether all targets
> successfully work this way.
> If you'd show a useful usecase example...

We build a bunch of kernel related tools (perf, cpupower, bpftool,
etc.) from our own top level Makefile, propagating parallelism
downwards like one should. Without this patch we have to remove
parallelism for cpupower, which doesn't seem like a very clean thing
to do, especially if you consider that it's 3x faster with parallelism
enabled in wall clock terms.

>        Thomas
>
> >
> > Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> > ---
> >  tools/power/cpupower/Makefile       | 8 ++++----
> >  tools/power/cpupower/bench/Makefile | 2 +-
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
> > index c7bcddbd486d..3b1594447f29 100644
> > --- a/tools/power/cpupower/Makefile
> > +++ b/tools/power/cpupower/Makefile
> > @@ -270,14 +270,14 @@ clean:
> >       $(MAKE) -C bench O=$(OUTPUT) clean
> >
> >
> > -install-lib:
> > +install-lib: libcpupower
> >       $(INSTALL) -d $(DESTDIR)${libdir}
> >       $(CP) $(OUTPUT)libcpupower.so* $(DESTDIR)${libdir}/
> >       $(INSTALL) -d $(DESTDIR)${includedir}
> >       $(INSTALL_DATA) lib/cpufreq.h $(DESTDIR)${includedir}/cpufreq.h
> >       $(INSTALL_DATA) lib/cpuidle.h $(DESTDIR)${includedir}/cpuidle.h
> >
> > -install-tools:
> > +install-tools: $(OUTPUT)cpupower
> >       $(INSTALL) -d $(DESTDIR)${bindir}
> >       $(INSTALL_PROGRAM) $(OUTPUT)cpupower $(DESTDIR)${bindir}
> >       $(INSTALL) -d $(DESTDIR)${bash_completion_dir}
> > @@ -293,14 +293,14 @@ install-man:
> >       $(INSTALL_DATA) -D man/cpupower-info.1
> > $(DESTDIR)${mandir}/man1/cpupower-info.1 $(INSTALL_DATA) -D
> > man/cpupower-monitor.1 $(DESTDIR)${mandir}/man1/cpupower-monitor.1
> >
> > -install-gmo:
> > +install-gmo: create-gmo
> >       $(INSTALL) -d $(DESTDIR)${localedir}
> >       for HLANG in $(LANGUAGES); do \
> >               echo '$(INSTALL_DATA) -D $(OUTPUT)po/$$HLANG.gmo
> > $(DESTDIR)${localedir}/$$HLANG/LC_MESSAGES/cpupower.mo'; \ $(INSTALL_DATA)
> > -D $(OUTPUT)po/$$HLANG.gmo
> > $(DESTDIR)${localedir}/$$HLANG/LC_MESSAGES/cpupower.mo; \ done;
> >
> > -install-bench:
> > +install-bench: compile-bench
> >       @#DESTDIR must be set from outside to survive
> >       @sbindir=$(sbindir) bindir=$(bindir) docdir=$(docdir) confdir=$
> (confdir)
> > $(MAKE) -C bench O=$(OUTPUT) install
> >
> > diff --git a/tools/power/cpupower/bench/Makefile
> > b/tools/power/cpupower/bench/Makefile index f68b4bc55273..d9d9923af85c
> > 100644
> > --- a/tools/power/cpupower/bench/Makefile
> > +++ b/tools/power/cpupower/bench/Makefile
> > @@ -27,7 +27,7 @@ $(OUTPUT)cpufreq-bench: $(OBJS)
> >
> >  all: $(OUTPUT)cpufreq-bench
> >
> > -install:
> > +install: $(OUTPUT)cpufreq-bench
> >       mkdir -p $(DESTDIR)/$(sbindir)
> >       mkdir -p $(DESTDIR)/$(bindir)
> >       mkdir -p $(DESTDIR)/$(docdir)
>
>
>
>

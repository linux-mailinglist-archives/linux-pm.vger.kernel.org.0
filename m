Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5395E2ECD7A
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jan 2021 11:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbhAGKIO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jan 2021 05:08:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:59432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbhAGKIO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 Jan 2021 05:08:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610014046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ag8XU2LBrp1mFu8W7SfzzMZ0Tky5q4LXKgHAQJA9POU=;
        b=Yv4KUd9HPo25TBD1RfVzdqzlBDuHgQTJRzGeJDXyYnc8avx5uH7380ae4VHzA8zwCwXF/I
        l5p64O2IV6ZNJTa9TZlrBB8xjitp5WBA9m+B232e8Y0uNoou+XAcVkkc8eGXNoONGw9HY+
        2nHa6aa6nvYe6bMeCGckho4xOeem0eg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9B751ACAF;
        Thu,  7 Jan 2021 10:07:26 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.com>
To:     linux-pm@vger.kernel.org, Ivan Babrou <ivan@cloudflare.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Ivan Babrou <ivan@cloudflare.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] cpupower: add Makefile dependencies for install targets
Date:   Thu, 07 Jan 2021 11:07:25 +0100
Message-ID: <2100533.HVZEckHxcR@c100>
In-Reply-To: <20210104235719.13525-1-ivan@cloudflare.com>
References: <20210104235719.13525-1-ivan@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Dienstag, 5. Januar 2021, 00:57:18 CET schrieb Ivan Babrou:
> This allows building cpupower in parallel rather than serially.

cpupower is built serially:

[ make clean ]

time make
real    0m3,742s
user    0m3,330s
sys     0m1,105s

[ make clean ]

time make -j10
real    0m1,045s
user    0m3,153s
sys     0m1,037s

Only advantage I see is that you can call
make install-xy
targets without calling the corresponding build target
make xy
similar to the general install target:
install: all install-lib ...

Not sure anyone needs this and whether all targets
successfully work this way.
If you'd show a useful usecase example...

       Thomas

> 
> Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> ---
>  tools/power/cpupower/Makefile       | 8 ++++----
>  tools/power/cpupower/bench/Makefile | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
> index c7bcddbd486d..3b1594447f29 100644
> --- a/tools/power/cpupower/Makefile
> +++ b/tools/power/cpupower/Makefile
> @@ -270,14 +270,14 @@ clean:
>  	$(MAKE) -C bench O=$(OUTPUT) clean
> 
> 
> -install-lib:
> +install-lib: libcpupower
>  	$(INSTALL) -d $(DESTDIR)${libdir}
>  	$(CP) $(OUTPUT)libcpupower.so* $(DESTDIR)${libdir}/
>  	$(INSTALL) -d $(DESTDIR)${includedir}
>  	$(INSTALL_DATA) lib/cpufreq.h $(DESTDIR)${includedir}/cpufreq.h
>  	$(INSTALL_DATA) lib/cpuidle.h $(DESTDIR)${includedir}/cpuidle.h
> 
> -install-tools:
> +install-tools: $(OUTPUT)cpupower
>  	$(INSTALL) -d $(DESTDIR)${bindir}
>  	$(INSTALL_PROGRAM) $(OUTPUT)cpupower $(DESTDIR)${bindir}
>  	$(INSTALL) -d $(DESTDIR)${bash_completion_dir}
> @@ -293,14 +293,14 @@ install-man:
>  	$(INSTALL_DATA) -D man/cpupower-info.1
> $(DESTDIR)${mandir}/man1/cpupower-info.1 $(INSTALL_DATA) -D
> man/cpupower-monitor.1 $(DESTDIR)${mandir}/man1/cpupower-monitor.1
> 
> -install-gmo:
> +install-gmo: create-gmo
>  	$(INSTALL) -d $(DESTDIR)${localedir}
>  	for HLANG in $(LANGUAGES); do \
>  		echo '$(INSTALL_DATA) -D $(OUTPUT)po/$$HLANG.gmo
> $(DESTDIR)${localedir}/$$HLANG/LC_MESSAGES/cpupower.mo'; \ $(INSTALL_DATA)
> -D $(OUTPUT)po/$$HLANG.gmo
> $(DESTDIR)${localedir}/$$HLANG/LC_MESSAGES/cpupower.mo; \ done;
> 
> -install-bench:
> +install-bench: compile-bench
>  	@#DESTDIR must be set from outside to survive
>  	@sbindir=$(sbindir) bindir=$(bindir) docdir=$(docdir) confdir=$
(confdir)
> $(MAKE) -C bench O=$(OUTPUT) install
> 
> diff --git a/tools/power/cpupower/bench/Makefile
> b/tools/power/cpupower/bench/Makefile index f68b4bc55273..d9d9923af85c
> 100644
> --- a/tools/power/cpupower/bench/Makefile
> +++ b/tools/power/cpupower/bench/Makefile
> @@ -27,7 +27,7 @@ $(OUTPUT)cpufreq-bench: $(OBJS)
> 
>  all: $(OUTPUT)cpufreq-bench
> 
> -install:
> +install: $(OUTPUT)cpufreq-bench
>  	mkdir -p $(DESTDIR)/$(sbindir)
>  	mkdir -p $(DESTDIR)/$(bindir)
>  	mkdir -p $(DESTDIR)/$(docdir)





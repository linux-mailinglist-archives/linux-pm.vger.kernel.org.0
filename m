Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C67C2440D5
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 23:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgHMVni (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 17:43:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45569 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgHMVni (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 17:43:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id di22so5305688edb.12;
        Thu, 13 Aug 2020 14:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P2eZuP6c506YZ5zFEOeI1NqJOh6HdWASDT5YVO36Yfc=;
        b=MXxoEzbv/R7sMMN1okBlMNVuvbdhbtqaSV82wFn9kzSHk3SCKfKKMtufntnxyb7VP1
         7KRWjlR28PLzL+glBKTaR0Yeir9jOOOOSlbk92Zn3JnKcmbWB72KCG/xQ0zDMRkac070
         vi/QyfVnQI5kzQLlt9NICAUE2JomaNhnFhqPS7+KaPb64QCT8D9hefmED0bDJsW/cJBP
         cYSKuGE4p8PlXcXoyfFiK8U1vcfn6E0HOnBdRv4CmtV+8s2t412kAQO+uO8Xb7FmQZbj
         2/2n5KoMoJvYvdgahO8o1JWOKy1Uhk4QuK859H/7rNTmdw/HkAVXNi36lWuSDP+O+egH
         lQKA==
X-Gm-Message-State: AOAM533cPProeDKbAmEDXSOc6ScGKoiEPg1qgjsvnn6CvU2tGcxW/isX
        g290+AbWyPyHHmgIHvamVqTcbomGT12EI0i78zU=
X-Google-Smtp-Source: ABdhPJzd09nmrrCJYoR3gE7APmEQpllycPVmHXQVWNHLO79PNceUxD67BkFknbF7vgEWXuPDaTov9VIKDiVyDBBgmdo=
X-Received: by 2002:a50:af86:: with SMTP id h6mr6825875edd.132.1597355016709;
 Thu, 13 Aug 2020 14:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200717060849.12469-1-liwei.song@windriver.com>
In-Reply-To: <20200717060849.12469-1-liwei.song@windriver.com>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 13 Aug 2020 17:43:25 -0400
Message-ID: <CAJvTdKm9WHgQuP38Y2o1zQ-VgLKMMDup4crAPrW3pexoWft+6Q@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: call pread64 in kernel directly
To:     Liwei Song <liwei.song@windriver.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Huh?

On Fri, Jul 17, 2020 at 2:09 AM Liwei Song <liwei.song@windriver.com> wrote:
>
> with 32-bit rootfs, the offset may out of range when set it
> to 0xc0010299, define it as "unsigned long long" type and
> call pread64 directly in kernel.
>
> Signed-off-by: Liwei Song <liwei.song@windriver.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 33b370865d16..4c5cdfcb5721 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -33,6 +33,7 @@
>  #include <sys/capability.h>
>  #include <errno.h>
>  #include <math.h>
> +#include <sys/syscall.h>
>
>  char *proc_stat = "/proc/stat";
>  FILE *outf;
> @@ -381,11 +382,11 @@ int get_msr_fd(int cpu)
>         return fd;
>  }
>
> -int get_msr(int cpu, off_t offset, unsigned long long *msr)
> +int get_msr(int cpu, unsigned long long offset, unsigned long long *msr)
>  {
>         ssize_t retval;
>
> -       retval = pread(get_msr_fd(cpu), msr, sizeof(*msr), offset);
> +       retval = syscall(SYS_pread64, get_msr_fd(cpu), msr, sizeof(*msr), offset);
>
>         if (retval != sizeof *msr)
>                 err(-1, "cpu%d: msr offset 0x%llx read failed", cpu, (unsigned long long)offset);
> --
> 2.17.1
>


-- 
Len Brown, Intel Open Source Technology Center

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4478B8A238
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 17:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfHLPYk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 11:24:40 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:28767 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfHLPYk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 11:24:40 -0400
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x7CFOFVG015133;
        Tue, 13 Aug 2019 00:24:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x7CFOFVG015133
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1565623456;
        bh=/ZLs0+GV+nR6TLnoM6cTJUiEDAyiLErBYzFGbX3v72M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OJzpQWw2Fwn/3fQ8DT/dj2bh1YFydaCAq5v8YJE8AxCIe3WPS2T5YtkW77TWjg9Tz
         NoPYiwNyTZ1D4o7k8CKS1haSTcSef3BiTAMomiGs87V+5ICLpWQfMf9oiUGg/NdJVa
         XR/HQovpgZ5u/XigRZl1C435CMvqiCsSUiMIch+Wvjr3r+UX2mL8LAttxrl0kqyAOH
         GanJ99UvCbY4bHWZ/zsww5K0gRvD2Ezm7Tx8AWjUNbXiMzoe7Saef+lIqw8OrswMSy
         VLezLRZfFoAtfQ8/5mqinYzP2XYhoQ0knpYwMA0q5isCpqxmy4PKpUdZaJ2QyPTriE
         7FK8Zf13mX2xQ==
X-Nifty-SrcIP: [209.85.221.182]
Received: by mail-vk1-f182.google.com with SMTP id r13so292799vke.12;
        Mon, 12 Aug 2019 08:24:16 -0700 (PDT)
X-Gm-Message-State: APjAAAVMe2zbbQ5LGhS2eWq39HREyZFrilPa36wIzmT03ve3zkXzkpQM
        WLG01bFqrJDQRsZ72sSK5Y+it/954scagU/RzWM=
X-Google-Smtp-Source: APXvYqyf2GMOFUsRxNDu7JdMijybibC42MDZO/L+m1JKVxZCXdD83lEdp4K2xTiKxVjtWaNp/waolXng2NwGRKVWNbI=
X-Received: by 2002:a1f:93cd:: with SMTP id v196mr5084585vkd.84.1565623454953;
 Mon, 12 Aug 2019 08:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190809002104.18599-1-stancheff@cray.com> <20190809002104.18599-2-stancheff@cray.com>
In-Reply-To: <20190809002104.18599-2-stancheff@cray.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 13 Aug 2019 00:23:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAScm9P+QMZiqqSQnOoPsN54OTcTGpaDgxTbjJ_knoeGhA@mail.gmail.com>
Message-ID: <CAK7LNAScm9P+QMZiqqSQnOoPsN54OTcTGpaDgxTbjJ_knoeGhA@mail.gmail.com>
Subject: Re: [PATCH 1/1] kbuild: recursive build of external kernel modules
To:     Shaun Tancheff <shaun@tancheff.com>
Cc:     Shaun Tancheff <stancheff@cray.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Renninger <trenn@suse.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 9, 2019 at 9:21 AM Shaun Tancheff <shaun@tancheff.com> wrote:
>
> When building a tree of external modules stage 2 fails
> silently as the root modules.order is empty.
>
> Modify the modules.order location to be fixed to the
> root when KBUILD_EXTMOD is specified and write all
> module paths to the single modules.order file.

Could you try v5.3-rc4 please?




> Signed-off-by: Shaun Tancheff <stancheff@cray.com>
> ---
>  Makefile               | 1 +
>  scripts/Makefile.build | 8 +++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 23cdf1f41364..a9964492f47e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1622,6 +1622,7 @@ $(module-dirs): prepare $(objtree)/Module.symvers
>
>  modules: $(module-dirs)
>         @$(kecho) '  Building modules, stage 2.';
> +       $(Q)$rm -f $(KBUILD_EXTMOD)/modules.order
>         $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
>
>  PHONY += modules_install
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 0d434d0afc0b..f9908b3d59e0 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -64,7 +64,13 @@ builtin-target := $(obj)/built-in.a
>  endif
>
>  ifeq ($(CONFIG_MODULES)$(need-modorder),y1)
> +ifneq ($(KBUILD_EXTMOD),)
> +modorder-target := $(KBUILD_EXTMOD)/modules.order
> +modorder-add := >>
> +else
>  modorder-target := $(obj)/modules.order
> +modorder-add := >
> +endif
>  endif
>
>  mod-targets := $(patsubst %.o, %.mod, $(obj-m))
> @@ -423,7 +429,7 @@ endif # builtin-target
>  $(modorder-target): $(subdir-ym) FORCE
>         $(Q){ $(foreach m, $(modorder), \
>         $(if $(filter %/modules.order, $m), cat $m, echo $m);) :; } \
> -       | $(AWK) '!x[$$0]++' - > $@
> +       | $(AWK) '!x[$$0]++' - $(modorder-add) $@
>
>  #
>  # Rule to compile a set of .o files into one .a file (with symbol table)
> --
> 2.20.1
>


-- 
Best Regards
Masahiro Yamada

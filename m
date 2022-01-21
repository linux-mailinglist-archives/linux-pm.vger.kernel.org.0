Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DC14961FF
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jan 2022 16:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351305AbiAUPYd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jan 2022 10:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbiAUPYd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jan 2022 10:24:33 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDE3C06173D
        for <linux-pm@vger.kernel.org>; Fri, 21 Jan 2022 07:24:32 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id m1so28589928ybo.5
        for <linux-pm@vger.kernel.org>; Fri, 21 Jan 2022 07:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lHv4QGKyWaC8pJttpt8QUbf3yyP/jMKn3N+flk/PW10=;
        b=TuYOvf2B9HOi6a6+5H3dsW8U3FeTz9UocCY2hj9gLGhDsiqoc/vJ4m/8w6bS1mIXAx
         DfzIIKlVbbDQ2XO53YTs+3KImo9w77vLdnlNocWdvZhBO69EUV1qCkr/K/tJYMeQkQIB
         a1ZSJe9u2MwXLlhK0yvgZNH0jSsNAf+fk6xNknc5OOrvmGPN0OsDYtfU1iEO4oSKz3px
         FWRYKaz5l7DLNHgHH/Daee6JLM0IhoUGnE2mmF1uDk32AkvK/k0h+7NlhLM5Lwy/3hlB
         zU8a6LtNI62avuO/YK+UPiDllbENyvd6MONG7fd86WC/2etQOle1gOmHUJYrL2nHP+lv
         qrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHv4QGKyWaC8pJttpt8QUbf3yyP/jMKn3N+flk/PW10=;
        b=nM6XKbbl1nSZZlsLEtNOqxZ3g+qgEHHzheaveYuSzE50xS9zORFnPMWT7I90Yr75Gz
         irv7xaTpmHtOFs/Tc6NTLc1k65czPsGw+GUkheN5xQMpOg2987vlM9hBnNvtG0i5hHff
         a5af8YOLpqocVMl5JT2MJ5b44F/r3pgZDtyugDBPUqpqkRFx4ZdximnaaKR6IdVb/UN5
         460fMzWv42Ryjl7uSWDelDGfzLnAMxi5cWGG0ANsZX7B3Zz3hhoKBb2hSxHbU1qFuWYe
         GTJY/swnfXzWBz+smuRoAUMHKHmYzUe3Mj2xmFosYDdkMN66Y1SVtkEiq8XhXa/HbL7J
         KdHQ==
X-Gm-Message-State: AOAM530ZHbkWhSVgv+/0Po1b7gK6Ei9oipotC4LqKWL38s9Eg9Rq33yX
        OLo0p8pHbq+tJzzPfSWNy4nSgbym/SkUWDuTFCd9Ng==
X-Google-Smtp-Source: ABdhPJx9UVWg3EfP5/63PnvEnF1YOj5Isounp9ZYZMOzIVLh11iewxgOKv8wxnLSIL7XfldkUQ5A1Lpj9PcvCTC39xs=
X-Received: by 2002:a25:838b:: with SMTP id t11mr4282883ybk.146.1642778671696;
 Fri, 21 Jan 2022 07:24:31 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvuEqeoLO6dC_qtGyRUz=UPv5i0C3jZ_n9nz5kWOuCHYQ@mail.gmail.com>
In-Reply-To: <CA+G9fYvuEqeoLO6dC_qtGyRUz=UPv5i0C3jZ_n9nz5kWOuCHYQ@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 21 Jan 2022 20:54:20 +0530
Message-ID: <CA+G9fYuKGaDfyke81wbSe2yqTm6GqWNuKw2wB6NFaCLa1q7z6A@mail.gmail.com>
Subject: Re: [next] parisc: allnoconfig: ERROR: modpost: Section mismatches
 detected. Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.
To:     John David Anglin <dave.anglin@bell.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-parisc <linux-parisc@vger.kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, pavel@ucw.cz,
        rppt@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Helge Deller <deller@gmx.de>, Deller <deller@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 21 Jan 2022 at 13:16, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Linux next-20220121 parisc allnoconfig build failed with gcc-9/10/11.
>
> make --silent --keep-going --jobs=8 ARCH=parisc
> CROSS_COMPILE=hppa-linux-gnu- 'CC=sccache hppa-linux-gnu-gcc'
> 'HOSTCC=sccache gcc'
>
> WARNING: modpost: vmlinux.o(.text+0x1c8): Section mismatch in
> reference from the function ksys_sync() to the function
> .init.text:memblock_alloc_try_nid()
> The function ksys_sync() references
> the function __init memblock_alloc_try_nid().
> This is often because ksys_sync lacks a __init
> annotation or the annotation of memblock_alloc_try_nid is wrong.
>
> ERROR: modpost: Section mismatches detected.
> Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.
> make[2]: *** [/builds/linux/scripts/Makefile.modpost:59:
> vmlinux.symvers] Error 1

Anders bisected this build and the first bad commit is point to,

first bad commit: [4f05e5a3946923676e147ad0e33c80df8249b2fe]
parisc: Drop __init from map_pages declaration


> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> metadata:
>   git branch: master
>   git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git describe: next-20220121
>   kernel-config: https://builds.tuxbuild.com/23zIAxC4uCgy4zadA01JYyOwCR4/config
>   build: https://builds.tuxbuild.com/23zIAxC4uCgy4zadA01JYyOwCR4/
>
> # To install tuxmake on your system globally:
> # sudo pip3 install -U tuxmake
> #
> # See https://docs.tuxmake.org/ for complete documentation.
> # Original tuxmake command with fragments listed below.
>
> tuxmake --runtime podman --target-arch parisc --toolchain gcc-11
> --kconfig allnoconfig
>
> --
> Linaro LKFT
> https://lkft.linaro.org

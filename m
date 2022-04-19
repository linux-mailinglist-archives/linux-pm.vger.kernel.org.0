Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9424E50721B
	for <lists+linux-pm@lfdr.de>; Tue, 19 Apr 2022 17:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243940AbiDSPvR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Apr 2022 11:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354014AbiDSPvQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Apr 2022 11:51:16 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592611DA6D
        for <linux-pm@vger.kernel.org>; Tue, 19 Apr 2022 08:48:33 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id i20so31762738ybj.7
        for <linux-pm@vger.kernel.org>; Tue, 19 Apr 2022 08:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YFcYhbvVH3rt2ACTFvnIJaAlZdDNaWtokMnVWRolbtg=;
        b=nr/1K9/mhGIV8mCGvpOrccz/o7hYAsmFQ5qtuWoogm311q8D0JkXzAzQe/f/NWwyKf
         r3AJP9rDh958WVB1UbgSZyRYCHG1axZyLVQQAs0MAgYo0DXOdSHXquh+bCUN759YdNFu
         COd1WDO+vSXqLiprPUh34qo9hx5xeOZT7sSzuwBjImpOYghnZIvA1dYvjBnCf8w8M7/a
         3iVfKSq7TJnQqJBs2+hLSwjGs1ugj6u0FzrZwxlII4ANxEII2P5fQ1DgwiG7YK1yEb0y
         cBxwaILWLI78dSpfIhtm7fSzR92YFnqOK+tDIZtpfnxAAwhFA5bDsq/g9By0dp4F0OtK
         Bhbg==
X-Gm-Message-State: AOAM533aGRkKn6Ey4+JONRkvOd0zV8/Eqg20yKD4WhOVVMoyJRNhPCXC
        evS5ZeOQd/jnNhgx7yUegWlWUmYifI0JWvkqw8tQx8Ls
X-Google-Smtp-Source: ABdhPJwlz+REH9mz2+tc1r2+J/zxovXGNLkhrPkvk6tBGR8itzSnrWW6DyxZT0xTe7kXTVQgMN/ZHXgvUazcPXnJw20=
X-Received: by 2002:a05:6902:1543:b0:642:3fd:316c with SMTP id
 r3-20020a056902154300b0064203fd316cmr15190190ybu.622.1650383312564; Tue, 19
 Apr 2022 08:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvTdKm=LUqHRHZ6DwvEEK-3ReOhJF7h+NLRKP7+Lqfb=dAXyg@mail.gmail.com>
In-Reply-To: <CAJvTdKm=LUqHRHZ6DwvEEK-3ReOhJF7h+NLRKP7+Lqfb=dAXyg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Apr 2022 17:48:21 +0200
Message-ID: <CAJZ5v0gjZHGVes4G7c=4CXMfjgtERhYy-6JmoJ3x18u2-GqqjA@mail.gmail.com>
Subject: Re: [GIT PULL] turbosat 2022.04.16
To:     Len Brown <lenb@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 17, 2022 at 6:21 AM Len Brown <lenb@kernel.org> wrote:
>
> Hi Rafael,
>
> Please pull these turbostat patches to sync upstream with turbostat 2022.04.06.
>
> thanks!
> Len Brown, Intel Open Source Technology Center
>
> The following changes since commit f443e374ae131c168a065ea1748feac6b2e76613:
>
>   Linux 5.17 (2022-03-20 13:14:17 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat
>
> for you to fetch changes up to 58990892ca29c310eca7df1d39d3dbc1b18c2d0e:
>
>   tools/power turbostat: version 2022.04.16 (2022-04-17 00:05:25 -0400)
>
> ----------------------------------------------------------------
> Chen Yu (1):
>       tools/power turbostat: Support thermal throttle count print
>
> Dan Merillat (1):
>       tools/power turbostat: fix dump for AMD cpus
>
> Len Brown (5):
>       tools/power turbostat: tweak --show and --hide capability
>       tools/power turbostat: fix ICX DRAM power numbers
>       tools/power turbostat: be more useful as non-root
>       tools/power turbostat: No build warnings with -Wextra
>       tools/power turbostat: version 2022.04.16
>
> Sumeet Pawnikar (2):
>       tools/power turbostat: Add Power Limit4 support
>       tools/power turbostat: print power values upto three decimal
>
> Zephaniah E. Loss-Cutler-Hull (2):
>       tools/power turbostat: Allow -e for all names.
>       tools/power turbostat: Allow printing header every N iterations
>
>  arch/x86/include/asm/msr-index.h      |   1 +
>  tools/power/x86/turbostat/Makefile    |   2 +-
>  tools/power/x86/turbostat/turbostat.8 |   2 +-
>  tools/power/x86/turbostat/turbostat.c | 594 ++++++++++++++++++++++------------
>  4 files changed, 389 insertions(+), 210 deletions(-)

Pulled and pushed out, thanks!

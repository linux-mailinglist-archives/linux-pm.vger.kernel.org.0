Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D4C3EF24C
	for <lists+linux-pm@lfdr.de>; Tue, 17 Aug 2021 20:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhHQS4D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 14:56:03 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:44896 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhHQS4D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Aug 2021 14:56:03 -0400
Received: by mail-ot1-f46.google.com with SMTP id l36-20020a0568302b24b0290517526ce5e3so18635548otv.11
        for <linux-pm@vger.kernel.org>; Tue, 17 Aug 2021 11:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0oVA9ax9HIRa42n7TWrU5sO636ECPXB6T2mdsUie4rs=;
        b=DJZ4r2zc8rapwvFxs+S9Nc1xlZM8xHleD9j2YPQ3YCDJF6M0xO16PtQ+zKunzy1HCq
         p9vek+2BFVW/HLj3fBnOV2ozITbhKSiSU2fYQlpCcyzzQN80lzBdHKeNKd8tNNJGhJgs
         FFfrXWnA6jyk4e62iEOFHlbUsj+Mh0oTDzFB/XvHPXJStHFwC5EquI3AThb2hZFRY+wE
         l/pbAl/JvCWFi1NN3Wx0mYZ7mBxPTdOKXTbwP4Zu4CgaCCclsavAaNSFd7xpbTFnYo61
         KpkcDDbXdBxTD/4HMLxjeNjSqF9xcx/+zcydVQ+j1lxRcYN4aiYcizZminPj/IbmFhlu
         Ndcg==
X-Gm-Message-State: AOAM533hEzywtu6ovDviuke0/Axdr8p1JigByiQ3BxSxiKOG9eD78NiM
        BuVBRvUGR2qP04i9d6juTYG+D7cHNA+XAHJIPOY=
X-Google-Smtp-Source: ABdhPJxDKwRL5+lvzFQCac2puXfkDHwL3i2HKD85W1XvvywYjNfMUkTP5qj3PRm1IpgjPN2IFofcPV+pxAo2domlo/4=
X-Received: by 2002:a9d:a75:: with SMTP id 108mr3706256otg.260.1629226529374;
 Tue, 17 Aug 2021 11:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210810085838.d3hv3rxli5vxozlz@vireshk-i7> <CAJZ5v0j4N+puor2x2_vqB-zaJe-m_-pv6cipV_fCbRyKAd6Zgg@mail.gmail.com>
 <20210817034516.pvyxlmq5do733ock@vireshk-i7>
In-Reply-To: <20210817034516.pvyxlmq5do733ock@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Aug 2021 20:55:18 +0200
Message-ID: <CAJZ5v0jgyLJ=BDtXeFfjxh4J_OgKSM_uuQ1MQPX=vu+52pLc_A@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm fixes for 5.14
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 17, 2021 at 5:45 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 16-08-21, 16:42, Rafael J. Wysocki wrote:
> > And now it looks like there's more stuff on this branch.
>
> Sorry about that.
>
> Hi Rafael,
>
> This pull request contains:
>
> - Addition of SoCs to blocklist for cpufreq-dt driver (Bjorn Andersson
>   and Thara Gopinath).
>
> - Fix error path for scmi driver (Lukasz Luba).
>
> - Temporarily disable highest frequency for armada, its unsafe and
>   breaks stuff.
>
> -------------------------8<-------------------------
>
> The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:
>
>   Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/fixes
>
> for you to fetch changes up to 484f2b7c61b9ae58cc00c5127bcbcd9177af8dfe:
>
>   cpufreq: armada-37xx: forbid cpufreq for 1.2 GHz variant (2021-08-09 09:31:22 +0530)

Pulled, thanks!

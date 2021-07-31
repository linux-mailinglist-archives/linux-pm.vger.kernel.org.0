Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB58F3DC310
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jul 2021 06:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbhGaEE0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Jul 2021 00:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhGaEE0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Jul 2021 00:04:26 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F35BC06175F
        for <linux-pm@vger.kernel.org>; Fri, 30 Jul 2021 21:04:19 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id r18so13907671iot.4
        for <linux-pm@vger.kernel.org>; Fri, 30 Jul 2021 21:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZFmzRvrQwwX+/h5T5pEHk6Y9rzp+9zbf/fzAExZsDUs=;
        b=ByDAtRrTejpUQn1ptsavPV5TqWsShnWxLIUUnQGbO8wetrhp+7fwCXl/tUk+a48ojP
         wHMNDd5ICBsX7VxtJPbE+nOGBb25m8zC9e4wKVGaj6F450uWc9Cyzdt5BNha9AG9P29x
         SAQ5Tv0znx3sw8topp2ax9llpLOUB7V+onfECLECVLjgzdrlRxGEPmQCzdaDoutxjzPy
         VTR3vMCMpQvNbeKwmHnhb9TYUNMI28LGf9Hp/QBDjRu3Z/dBd5GrmsJ15OMolioT7zIE
         hdRBLvRf7oZp7KQieTTwl5PpHo4DIlPmJNM9dBABnVAFVGQwhKoIcGAmv+IHNOcCm38G
         WsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZFmzRvrQwwX+/h5T5pEHk6Y9rzp+9zbf/fzAExZsDUs=;
        b=HfTbemvVEU/ONk+zvamETagveQQst1qkNjZVt4TZP/q/sbOrr+UI+Y9XPkeb0mLKUq
         UKYPnlcK7xHNif4oaIkSFrlFqwYL5i4w7seCdXZcmzM43q+bWwX4Bhq/fb+XjWSOF/vW
         zNIZOU12BQ61YG9TL2BnWi7h0z7ldkyhHOY+ipxkIxRA8QWKCPpm4ZApmCutKE4696KG
         QfKJuzxzkRE9SCpSXBg9Ae4aAdDoi2pJQTph73rru+daktvEiDZbtR9BQny/ZthQFuBJ
         m3xERmdsdDwc0pPY2JRKBZ6p0wgggoC91aiyn78Z0VQSfnQnNcL/4de0jXrUhrid7xX6
         E+ww==
X-Gm-Message-State: AOAM532umKiMhX5LDP8LaQ5+m9WUq/uj0rgguZzHXogdoHki6qlqR5Zi
        nk/j7b8+2/h7H7LXrENElGK0rfEUPforXcnAWtXZmw==
X-Google-Smtp-Source: ABdhPJwY3j+LM5B6toBq9lu8MGJoV4JDSVu8zpnYQkps2H8n0WGIKR+RVJmqF922K1TxIS0ed5QMXZ4HuRFNkqHSU+M=
X-Received: by 2002:a05:6638:204c:: with SMTP id t12mr4753823jaj.129.1627704259008;
 Fri, 30 Jul 2021 21:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <4336554.LvFx2qVVIh@kreacher>
In-Reply-To: <4336554.LvFx2qVVIh@kreacher>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Fri, 30 Jul 2021 21:04:10 -0700
Message-ID: <CAAYoRsX+NnOom6f7s6=xOM8rwa_S6tPaQyReYfgDGU4wDkG2uQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] cpuidle: teo: Fix selection when idle state 0 is disabled
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 30, 2021 at 7:39 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi,
>
> Patch [1/2] fixes idle state selection in the teo governor when idle state 0
> is disabled (which is broken after recent changes in that governor) and patch
> [2/2] renames two local variables on top of that change.
>
> Please see the patch changelogs for details.

Hi Rafael,

I tested this version of the patches, and the idle state 0
disabled issue has been fixed.

... Doug

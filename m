Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA9D3E0772
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 20:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238510AbhHDSUm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 14:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhHDSUm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 14:20:42 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA80C0613D5;
        Wed,  4 Aug 2021 11:20:28 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id r1so2499299iln.6;
        Wed, 04 Aug 2021 11:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9vbn3IGtHcTcNDp0+D9iweX1dlLe8GLnPRA76GHZZSs=;
        b=XFNf5UYmKGhSUGRcdTrxsPeb3fy31xkfRTn3JmUjDsLoa53Hj9ZYhGxWv3Q8L7Qw27
         Ur8GoTPux0pIJtKrO6L3YvSKWtwnqmhAEY66S1jwhtlD1Veio42MwaXnoRhblz2v2dIt
         rdbsaBIsoVUmkexl6pkU92c95MvMCLe5lHs1Fa/ftDXGnVQUvAZ7+9LbaKCpwprEyb+j
         uTL45u/929X+PI40KcHNqtNbPw7ifsFQutxmWOJeQzlood8/CGuQo01petzPzIRaR/rF
         /7NV8OAYIWkvobAx7k0mpeA3TQ2Ea9YaCEu4lQwnO56AC0bNjD6DP/rHqL3ic7/8LUsY
         6N9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9vbn3IGtHcTcNDp0+D9iweX1dlLe8GLnPRA76GHZZSs=;
        b=chpaCFEGBY37Hma/zjkgGgPV+J9/eUYUYWBFSU7G/guLsQ+q/+TIREED2mIKtNBuxZ
         Iu/aBLqkayVnUUHD84tV/yx7sQaOo0U3/4aY7u2zGDpttRUx0Kz1Z2e5/CHk/6aeJRSe
         JkaGe3aI1S1zzAyEEZ82q9YH4W1KB+l5lA6kCgT/GbfQ1KzPaldiAp3uR6obD0x5CQJk
         MCJWRAl8B9dnEfzIu6NsuN5sjBE64kYpjrwD/L5UtD2fwB8DWlaHv2j5WQVKZ5orsw/5
         SbN9BGjnrkQltF/kbDozG3dpqHAaUaPm2DD0bMU3xwaMrvfY/QhDMaPaDVhOKQycdGX5
         hf4A==
X-Gm-Message-State: AOAM533PL1Yu/M6N2rrxGv5qn2ncvixFAZbNYz9atbaHvDa/7Hm+dMmd
        C3IB8HxxT6gFglO6KDR3hQpTI+FgELJqFLY/+LE=
X-Google-Smtp-Source: ABdhPJw5V3dNWAh5OJm6/bpyvglL4l4hfkyDfDiaZCBZuimcqhSFtGMHGG8G7Yx01RQ+KA++RjpCnETzYZEhirCVlEk=
X-Received: by 2002:a92:1e03:: with SMTP id e3mr733041ile.89.1628101228344;
 Wed, 04 Aug 2021 11:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210723182759.74491-1-pankaj.gupta.linux@gmail.com> <CAJZ5v0hV-3KXJM0WiQ=5nLoO06-A5ky_E7FViokj9uDax8zg1Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0hV-3KXJM0WiQ=5nLoO06-A5ky_E7FViokj9uDax8zg1Q@mail.gmail.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Wed, 4 Aug 2021 20:20:17 +0200
Message-ID: <CAM9Jb+jLrFakv6yQGE1V2zEhfweu5mdCxGg_YMSPUy9DcbcRiQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: set poll_limit_ns out of if-else
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pankaj Gupta <pankaj.gupta@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> <pankaj.gupta.linux@gmail.com> wrote:
> >
> > From: Pankaj Gupta <pankaj.gupta@ionos.com>
> >
> >  Since poll_limit_ns is being set at the end of both if and else statement.
>
> But they are if () and else if (), so not really.

So sorry!

Thanks,
Pankaj

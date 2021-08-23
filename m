Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237013F4A33
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 14:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbhHWMBJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 08:01:09 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:41608 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbhHWMBI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Aug 2021 08:01:08 -0400
Received: by mail-ot1-f43.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso20783150ota.8
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 05:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=blanjJiqa18Ws+C3xYfyg3iv0ipvqHMPxqRwYr2MkoQ=;
        b=LFWVtrgSxIXMz9+lDJxkyQ9HDROB2r9JX2phOdbzOD4veO/iqBGriYyoMdUNeM8LX4
         bcFqWQ3Uqa9Pzl0VhbciDhuQ7kfvZGt498XBWQUwgMBeNz0z7R+Akgern+JchkyRxXj1
         U3VDADgyGWQ0Np7pOG7GKAPTyhqI2tA/6JXXce7lsYd3AzgOCxP4NKth7NIT4liRfGsn
         MBHW5m7RfF65zXxOyscP/NtdaRFvfwvsyc+DSQ7mbR0kkY2hxHl7DlFjtWAV07SeAh2r
         TEaWL3OVf1xKsm48OlgIJGIpzOuQ8kZ/jFM3X45Z4cZ2dRiTd1aYbyhhmPMNt8am7FLj
         biYg==
X-Gm-Message-State: AOAM533k0pR71lBi5pSaSJysyzUf+BKGc4u9PC572qzgypY0XYRhnb7m
        B7YX/xTh30VSEpTYbJgbjkMuoU+odeaVcSbxFEc=
X-Google-Smtp-Source: ABdhPJw3Aqdg5lk2it0XF0K3Ex3MebtyifzmLl7hNsMCCYY279ahgVS09JlgnT7cwGGcJdFnSaRB4G6uFdotPK/aJ08=
X-Received: by 2002:a05:6808:10c1:: with SMTP id s1mr10672511ois.69.1629720025846;
 Mon, 23 Aug 2021 05:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210823071855.l6wklzvuomizklsw@vireshk-i7>
In-Reply-To: <20210823071855.l6wklzvuomizklsw@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Aug 2021 14:00:10 +0200
Message-ID: <CAJZ5v0jykTj5LpewUmRs9CKcEZybEOX8ZbQNVmGoa_7yLa1+9w@mail.gmail.com>
Subject: Re: [GIT PULL] OPP fixes for 5.14
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 23, 2021 at 9:18 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request fixes regression in the OPP core for a corner case.
>
> Thanks.
>
> --
> Viresh
>
> -------------------------8<-------------------------
> The following changes since commit c3ddfe66d2bb511f7fbcdc8e64952c7859e7e69d:
>
>   opp: Drop empty-table checks from _put functions (2021-08-16 09:42:08 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/fixes
>
> for you to fetch changes up to 19526d092ceb32d619fce73fe0bdca4370890124:
>
>   opp: core: Check for pending links before reading required_opp pointers (2021-08-23 12:44:55 +0530)

Pulled, thanks!

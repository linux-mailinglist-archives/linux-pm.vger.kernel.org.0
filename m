Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B303DEEF4
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 15:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbhHCNSk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 09:18:40 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:36642 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbhHCNSk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Aug 2021 09:18:40 -0400
Received: by mail-oo1-f49.google.com with SMTP id z3-20020a4a98430000b029025f4693434bso5180470ooi.3;
        Tue, 03 Aug 2021 06:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jzgmo5C/b0+xzlET/lKyhYqyoM2IpN27wZmzahcw0Uw=;
        b=CtcIu0ZvnHYje+pDG6zVlm4v8+5Ki691e0v89aVwiyCwdkAMWN08StGuj0EBmpGLzD
         I3dMt0T8lH86KtGEJJ25L9uEBlhAwSS+vOreaRnJMeAbz6f+1yB/YeXLkBDnSI/SUevB
         L06NbdefgIYIwNF+y92TSzfyleX7Oaz5meTyqqQm2DOSXteYdK4g6i2rAqKhJR3y/mrP
         hfjdL2lCn3UrJzYjjg987nbA8NJ3tmzbPsabIVe+kaS/LbfrgEkW7YqT0ivuz4zIOk+x
         YwU8YMu+pRKa2rOl2bp52mRlqfYpZAkbgUXrAiN096IgZrkYU1ntQ2SSstvkv4pSmxx/
         wSHQ==
X-Gm-Message-State: AOAM533lptcGeSblBArJKRvRQqsjt3b6enGMVDmQs8Q7GirU21QNRk8u
        KON9TnaawHuZMXOxnwEf3qiY7Zwp173GpHKflOcFIYOL
X-Google-Smtp-Source: ABdhPJwUnCpBnG7Hm+qjkkQ1D0gAVQYjd5Q+13WU0ZbW44GFeWdqxs87Bjnlug4/L+rQJcjvsxdtbFL+9lAtCQCCmxE=
X-Received: by 2002:a05:6820:161f:: with SMTP id bb31mr14245725oob.44.1627996708797;
 Tue, 03 Aug 2021 06:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <4336554.LvFx2qVVIh@kreacher> <CAAYoRsX+NnOom6f7s6=xOM8rwa_S6tPaQyReYfgDGU4wDkG2uQ@mail.gmail.com>
In-Reply-To: <CAAYoRsX+NnOom6f7s6=xOM8rwa_S6tPaQyReYfgDGU4wDkG2uQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Aug 2021 15:18:11 +0200
Message-ID: <CAJZ5v0hFZV6xucCmdDhg6=ActBZarr4so9tkAvzA5cuT5WWjMA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] cpuidle: teo: Fix selection when idle state 0 is disabled
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jul 31, 2021 at 6:04 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> On Fri, Jul 30, 2021 at 7:39 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > Hi,
> >
> > Patch [1/2] fixes idle state selection in the teo governor when idle state 0
> > is disabled (which is broken after recent changes in that governor) and patch
> > [2/2] renames two local variables on top of that change.
> >
> > Please see the patch changelogs for details.
>
> Hi Rafael,
>
> I tested this version of the patches, and the idle state 0
> disabled issue has been fixed.

Thanks for the confirmation!

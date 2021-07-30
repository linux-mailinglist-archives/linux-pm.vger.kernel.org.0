Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1933DB948
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jul 2021 15:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhG3NZc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Jul 2021 09:25:32 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:36779 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhG3NZc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jul 2021 09:25:32 -0400
Received: by mail-oi1-f174.google.com with SMTP id y18so13188586oiv.3;
        Fri, 30 Jul 2021 06:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WsleGekh6aK7vZy8g53nkd2fvHgVkIg/TMHUuzWRMI4=;
        b=tsa4JZkgX8W9vERQ/VFKKDbO/1wj9PRP/XQZ5UumTi5yhyAPMki1TVDlSMRL3k2YbR
         Ji8CeqA6P+o/zF9Ix0wK0uiTZadorX5ppoCiZySnD76RjxERm/NnMKLuGddgovrqmDcH
         /aLLPUH2d760tGOMJEVol4+5Nsiy7Aea9yOEIq7Q9YxcFz2jY6DZsMcBvYwWw/73NO+M
         5fhLFrKq3iyFcuGtv1wzzRnEtlnRkSN8mH0TLbbFIHt0bD8ZpF/ZPb314Y1+sEOV7awe
         2Uld856weDcfIoGifIyrVqMxsb6wr5EKnv6YZOMHnjoGghf68zXTGxiWSFiXl5qpDND7
         gugw==
X-Gm-Message-State: AOAM533UcgmU05+noN0f3o51meH/CLZuixkM9HUuEHXMrifKDDwysRId
        4P7jWnyhOFqapDRXiC/1Pu2yuujInSg3H1PknzUqKdB7
X-Google-Smtp-Source: ABdhPJzY4kSu6euNjBpfLjCKwo4Ca5mEdybD2D+bwZW+lcJi+atNvrVCL7R6U4T7K0FVvp7xu3r1eCl8TssjXlmQLi0=
X-Received: by 2002:aca:3502:: with SMTP id c2mr1905473oia.157.1627651526075;
 Fri, 30 Jul 2021 06:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <1867445.PYKUYFuaPT@kreacher> <2178828.iZASKD2KPV@kreacher>
 <CAAYoRsVko5jG=xqH=KTochqQu95i7PDo_6f1LCPGvAP0=XdVTA@mail.gmail.com>
 <4334837.LvFx2qVVIh@kreacher> <CAAYoRsUn853=yFbYtD+GkbGVTxw8pzo8iZGp1NWkab0vHGpanw@mail.gmail.com>
In-Reply-To: <CAAYoRsUn853=yFbYtD+GkbGVTxw8pzo8iZGp1NWkab0vHGpanw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Jul 2021 15:25:15 +0200
Message-ID: <CAJZ5v0h6w9GCZjOcVwHg4ZWy5hOT61x1w=d6Q2ExVnf=T4gZBw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] cpuidle: teo: Rework the idle state selection logic
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 30, 2021 at 5:36 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> On Thu, Jul 29, 2021 at 9:14 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> ... [snip]...
> >
> > This means that idle state 0 data are disregarded after disabling it
> > and that most likely is because the second loop in teo_select() should
> > be over all states down to idle state 0 (not only down to the first
> > enabled one).
> >
> > So below is an updated patch (not tested yet).
>
> Hi Rafael,
>
> This updated patch works great / solves the problem.
> Tested-by: Doug Smythies <dsmythies@telus.net>
>
> Thank you very much.

Thank you and you're welcome!

I've found a small issue in the patch though (it needs to check the
time span before setting the "last enabled" index), so let me submit a
proper patch with a changelog based on this one.

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FF61DC686
	for <lists+linux-pm@lfdr.de>; Thu, 21 May 2020 07:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgEUFLx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 May 2020 01:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgEUFLw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 May 2020 01:11:52 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFD0C061A0E
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2020 22:11:51 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id u79so3346130vsu.4
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2020 22:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AD8unmgm6oauUOHFj/P0iocD1WUvsir6u2NUntElyR0=;
        b=UvUOZ2wnJ60BygQT1sHXXCrN2Tzvau1CgvUsJ7S7Zr6X7l7wgj+zG5uvyALUYk7B1w
         HQfIDrgd+fRc779lt2xg0fEuyit4c/VliPIE0tqVrmAStjcAHlYwUhfnVSw71bXKFFTg
         jkVOIgJG4BxuuOzdOJWjxoav6F3ddgx9Q50aog3PRXTt7dLq5VWDL50Ko4KS1o2G3VNq
         hjFjUIwBP/JiO/+CN0eiAPETP6MkWHYkue378fKFkcKGq/RRG57ajLA8OWKMOID+VzAh
         653VA97SNo5MISFjtUdnQsi5tFf2FHisn1O0A2sPHvVD3oJSyOOcB/YLNcQQIxxBILHE
         iGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AD8unmgm6oauUOHFj/P0iocD1WUvsir6u2NUntElyR0=;
        b=YlFa+pfDbFiFOn3Zf0uzNPN7vc2qJ4qV5iqieiTrwT846LmUO0wopgxuwdobGdnqEE
         vzNPfMyzSY9ev5e9KQNV9mNYW0o5TGtAffKLGMgsc6cQvKGKz9spy9j8HP94FHaw5FfN
         4hJ6fuWuQ2Mt1Lz87De5ZpDLU/wUAVeIFQvzOg6sZZ3fcRap019CeqWWhvkQaicIJ/6a
         Gn91i8sTfHtqj2suek4y2jXk181GApx0517O4uHb5lR71Sjc4J/JXuc1Qwx6tXhpOn0e
         M4oLDKLuUCYsUGjXW4S1iGlEUTeeeSf4yZYbNe49v+aNvpRbBVnMT5VpHKrSdAAuBKSb
         VmKw==
X-Gm-Message-State: AOAM531mH3HqFNsxuIDd9N+RkKNVslO5/wHiUkKE50QCR6fCjGhZQBKL
        xC5yUNLt1ukZXKDhIZWoRIOuN7vZelVaZh3ZGSs3eA==
X-Google-Smtp-Source: ABdhPJwEolPuzTzn2SxjV+akxq1Zpi4fVI2XbgJG+xqPfsBq7KtXfbSJyzUcQrtxJCxj7c+hIGaAMMYcrGq1QNVIXgw=
X-Received: by 2002:a67:407:: with SMTP id 7mr5683332vse.95.1590037909533;
 Wed, 20 May 2020 22:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200504181616.175477-1-srinivas.pandruvada@linux.intel.com>
 <20200504181616.175477-4-srinivas.pandruvada@linux.intel.com>
 <a9af415d-9fd0-dcea-79ee-0fb90f45045e@linaro.org> <2cd6c73b890b3eab12420adf4ae29101672e6a0b.camel@linux.intel.com>
 <CAHLCerMfnHPuJnj6G4EvRPvODf1_Se4xM-OobA1o7eao5eetzg@mail.gmail.com> <703fcf3b2b6769f5e469f0b035846ee95193ef7d.camel@linux.intel.com>
In-Reply-To: <703fcf3b2b6769f5e469f0b035846ee95193ef7d.camel@linux.intel.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 21 May 2020 10:41:04 +0530
Message-ID: <CAHLCerOsZrrZYcRLH+iZFT9FPL8zfmy2Y-Py6f61YXUrMrkcbg@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/5] thermal: Add support for setting notification thresholds
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Srinivas,

On Wed, May 20, 2020 at 11:46 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Wed, 2020-05-20 at 09:58 +0530, Amit Kucheria wrote:
> > On Tue, May 19, 2020 at 5:10 AM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > > On Mon, 2020-05-18 at 18:37 +0200, Daniel Lezcano wrote:
> > > > On 04/05/2020 20:16, Srinivas Pandruvada wrote:
> > > > > Add new attributes in thermal syfs when a thermal drivers
> > > > > provides
> > > > > callbacks for them and CONFIG_THERMAL_USER_EVENT_INTERFACE is
> > > > > defined.
> > > > >
> > > > > These attribute allow user space to stop polling for
> > > > > temperature.
> > > > >
> > > > > These attributes are:
> > > > > - temp_thres_low: Specify a notification temperature for a low
> > > > > temperature threshold event.
> > > > > temp_thres_high: Specify a notification temperature for a high
> > > > > temperature threshold event.
> > > > > temp_thres_hyst: Specify a change in temperature to send
> > > > > notification
> > > > > again.
> > > > >
> > > > > This is implemented by adding additional sysfs attribute group.
> > > > > The
> > > > > changes in this patch are trivial to add new attributes in
> > > > > thermal
> > > > > sysfs as done for other attributes.
> > > >
> > > > Isn't it duplicate with the trip point?
> > > A trip point is where an in-kernel governor takes some action. This
> > > is
> > > not same as a notification temperature. For example at trip point
> > > configured by ACPI at 85C, the thermal governor may start
> > > aggressive
> > > throttling.
> > > But a user space can set a notification threshold at 80C and start
> > > some
> > > active controls like activate some fan to reduce the impact of
> > > passive
> > > control on performance.
> >
> > Then what is the use of thermal trip type "ACTIVE" ?
> This is an example.
> The defaults are set by the OEMs via ACPI. User can't modify that if
> they want to optimize for their usage on Linux. There are fan control
> daemon's which user use on top.

-ENOPARSE. Are you saying users "can" modify these?

In any case, how is what you described earlier not possible with an
ACTIVE trip point directly wired to the fan as a cooling device or
with a HOT trip point that causes the platform driver to send
notification to userspace where a fan control daemon can do what it
needs to?

Basically, I think the issue of polling is orthogonal to the
introduction of the new attributes introduced in this patch and I
don't understand the reason for these attributes from your commit
description.

> > > We need a way to distinguish between temperature notification
> > > threshold
> > > and actual trip point. Changing a trip point means that user wants
> > > kernel to throttle at temperature.
>

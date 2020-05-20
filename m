Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28AE71DA938
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 06:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgETE3E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 00:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgETE3D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2020 00:29:03 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63032C061A0E
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2020 21:29:02 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id k3so806167ual.8
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2020 21:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+qZZbuT843G0ykcP4WOBCe4Afr8ELi6EnDD0MmBi+I4=;
        b=e4GAUZr0pYYlAbmqzr5mBscJHnTVsJRtiQmpa37SgUxJp1nut8NqINekK2P+p9iHP8
         0O+ePxYtdOc+NKNqX5iCCyYeaMcxzXYdc2rGBUwQmAJNAVZjRTNIGmOFuqSqQBoQdoDc
         vVkWvI/cl4u/oHEQE2LiLFT1n4xReLm9wvYiSSNEBVZlI84Rp3leRcc/ydVcl6rz8RXQ
         OHqexNizzlctGtaXQkZY/ODZ46zQbQxP0KN1o8J9TDQ63u0K2uYX4DSyIO/eRfmmMEZ7
         xbjGDFDYdO0w/nzf5Axr6TV3MTMVWwXt3bjgcfJfvrV5rYofoDP51e8cLqlekQsJXb3s
         8LDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+qZZbuT843G0ykcP4WOBCe4Afr8ELi6EnDD0MmBi+I4=;
        b=I1776wFirDkstbnoDWt2Cr/bYPHEoGO9UJJBHL0pH3yhfp5kwKE8+x0S+IIkfm4tDC
         hy+TvmFJLDNXmk1qkIumVQVMupzAph0UQ4SCxtqOTU+jmkvszDEjLWD2d98JacP/V7Hm
         2ey3NgHGDcosYOe53qDZZOXTlqtGQAovZZMPaYfZBfCIOFyNpDeujhrEgT9ZfxueGtDZ
         9Mxhn6XPq1+Mog9pUkFhOCYBdVsEcA8n9e9RftrGk2NtA6S5iUyYaWE1QMBt1tDiJmo6
         Ds0uUf3Z0/R5gV91kRY793InMurIiN4LVKSDjHSeR1PjLkgkCNbGN1qcwZAJji8BAjp1
         +6Ew==
X-Gm-Message-State: AOAM532zKlovJgXKz/b7jiaIUOX015PP4p0ht6XcW88xKGuD67pUob0T
        ZoyYrV1mFgFSv6llE2mq0uu8liDCdOsVX/vKQOrNnA==
X-Google-Smtp-Source: ABdhPJz/7dzzKIcOTkCfA7HyKaMiShlW5edXQ9UXQspFQ4VSXLLphRu+GFq2HxwSJt8TDxiIDqOwpBhdbeS8jtJjiB4=
X-Received: by 2002:ab0:30ba:: with SMTP id b26mr2042602uam.77.1589948941382;
 Tue, 19 May 2020 21:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200504181616.175477-1-srinivas.pandruvada@linux.intel.com>
 <20200504181616.175477-4-srinivas.pandruvada@linux.intel.com>
 <a9af415d-9fd0-dcea-79ee-0fb90f45045e@linaro.org> <2cd6c73b890b3eab12420adf4ae29101672e6a0b.camel@linux.intel.com>
In-Reply-To: <2cd6c73b890b3eab12420adf4ae29101672e6a0b.camel@linux.intel.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 20 May 2020 09:58:18 +0530
Message-ID: <CAHLCerMfnHPuJnj6G4EvRPvODf1_Se4xM-OobA1o7eao5eetzg@mail.gmail.com>
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

On Tue, May 19, 2020 at 5:10 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2020-05-18 at 18:37 +0200, Daniel Lezcano wrote:
> > On 04/05/2020 20:16, Srinivas Pandruvada wrote:
> > > Add new attributes in thermal syfs when a thermal drivers provides
> > > callbacks for them and CONFIG_THERMAL_USER_EVENT_INTERFACE is
> > > defined.
> > >
> > > These attribute allow user space to stop polling for temperature.
> > >
> > > These attributes are:
> > > - temp_thres_low: Specify a notification temperature for a low
> > > temperature threshold event.
> > > temp_thres_high: Specify a notification temperature for a high
> > > temperature threshold event.
> > > temp_thres_hyst: Specify a change in temperature to send
> > > notification
> > > again.
> > >
> > > This is implemented by adding additional sysfs attribute group. The
> > > changes in this patch are trivial to add new attributes in thermal
> > > sysfs as done for other attributes.
> >
> > Isn't it duplicate with the trip point?
> A trip point is where an in-kernel governor takes some action. This is
> not same as a notification temperature. For example at trip point
> configured by ACPI at 85C, the thermal governor may start aggressive
> throttling.
> But a user space can set a notification threshold at 80C and start some
> active controls like activate some fan to reduce the impact of passive
> control on performance.

Then what is the use of thermal trip type "ACTIVE" ?

> We need a way to distinguish between temperature notification threshold
> and actual trip point. Changing a trip point means that user wants
> kernel to throttle at temperature.

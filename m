Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3838E11A64A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 09:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfLKIx2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 03:53:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:50290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfLKIx2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Dec 2019 03:53:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4D77208C3;
        Wed, 11 Dec 2019 08:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576054407;
        bh=SluCNcgOpF5zs1ukH8fJ++acdM5SKeCcIprj36+ughw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1VSj9PwYWK/XeRThtp1FC5vNTGdpV12wHDJt6Vy0m8FJhBPRKJXNjZVSpsJRvposq
         xUnZz2wWsgVkuFZhXfvAJ6+ZCM77zFYyajEzTgrR/ijnZuDNnYRrHvQ2SqvqJZSmTS
         ZEtPv1xL3F6zaKNvkb51WR3WBHiLDK2sor+A25oI=
Date:   Wed, 11 Dec 2019 09:53:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Wei Wang <wvw@google.com>, Wei Wang <wei.vince.wang@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/3] thermal: introduce by-name softlink
Message-ID: <20191211085324.GA500800@kroah.com>
References: <20191205071953.121511-1-wvw@google.com>
 <69dd3a7a-c5fe-3ae7-8a4d-c3939870eed8@linaro.org>
 <CAGXk5yrsmvHK_xwvp_kFNmSqKOZ7Ef3HrVBHYDMBmDsCz0FNSQ@mail.gmail.com>
 <0603228e-5f0b-d335-30ce-67cf0626a489@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0603228e-5f0b-d335-30ce-67cf0626a489@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 10, 2019 at 09:54:11PM +0100, Daniel Lezcano wrote:
> On 10/12/2019 21:01, Wei Wang wrote:
> > On Tue, Dec 10, 2019 at 6:36 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 05/12/2019 08:19, Wei Wang wrote:
> >>> The paths thermal_zone%d and cooling_device%d are not intuitive and the
> >>> numbers are subject to change due to device tree change. This usually
> >>> leads to tree traversal in userspace code.
> >>> The patch creates `tz-by-name' and `cdev-by-name' for thermal zone and
> >>> cooling_device respectively.
> >>
> >> Instead of adding another ABI, I suggest we put the current one
> >> deprecated with a warning in the dmesg, update the documentation and
> >> change the name the next version.
> >>
> >>
> > 
> > IMHO, we should keep the existing path which is a common pattern for
> > sysfs interface. There are reasons we need couple thermal zone and
> > cooling device in one class, but might be worth considering split as
> > the latter might be used for other purposes e.g. battery current limit
> > for preventive vdrop prevention. By nature, thermal zone are sensors,
> > and cooling devices are usually components with potential high power
> > use.
> 
> [Added Greghk and Rafael in Cc]
> 
> I understand but I would like to have Greg's and Rafael's opinion on that.
> 
> The result is:
> 
> ls -al /sys/devices/virtual/thermal/
> total 0
> drwxr-xr-x 22 root root 0 Dec 10 12:34 .
> drwxr-xr-x 15 root root 0 Dec 10 12:34 ..
> drwxr-xr-x  2 root root 0 Dec 10 13:18 cdev-by-name

Ick!

> drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device0
> drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device1
> drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device10
> drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device11
> drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device12
> drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device13
> drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device14
> drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device15
> drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device2
> drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device3
> drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device4
> drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device5
> drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device6
> drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device7
> drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device8
> drwxr-xr-x  3 root root 0 Dec 10 12:34 cooling_device9
> drwxr-xr-x  3 root root 0 Dec 10 12:34 thermal_zone0
> drwxr-xr-x  3 root root 0 Dec 10 12:34 thermal_zone1
> drwxr-xr-x  2 root root 0 Dec 10 13:18 tz-by-name
> 
> ls -al /sys/devices/virtual/thermal/cdev-by-name/
> total 0
> drwxr-xr-x  2 root root 0 Dec 10 13:18 .
> drwxr-xr-x 22 root root 0 Dec 10 12:34 ..
> lrwxrwxrwx  1 root root 0 Dec 10 13:18 thermal-cpufreq-0 ->
> ../cooling_device0

Ick ick ick!

What is this all for?

Where is the Documentation/ABI/ entry trying to explain this mess?
Please provide that and we can go from there as I have no idea what this
is trying to "help with".

thanks,

greg k-h

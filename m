Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B533C7CA20
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 19:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbfGaRRX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 13:17:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbfGaRRX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Jul 2019 13:17:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23C33206A2;
        Wed, 31 Jul 2019 17:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564593442;
        bh=IDr9Fa9DcZN3QqvhuNOkUnI9meArg9GzLkhzynEnQG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tK0GSZuV2dT2SKU1ULOz668DWrYR3xwgpzpfEHM3QR8bn19L6uwDrfR+FSBDFb9Mq
         254lPC/kEPeoKITXFQpA2dA+szC34Em06JC6fVdMA2wRQh3Cc0vp3+LLuulmnXzt7n
         rXsec0tt5uuE7hUcnqtdmnMsYXncIo4ASHwiOz2g=
Date:   Wed, 31 Jul 2019 19:17:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tri Vo <trong@android.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v5] PM / wakeup: show wakeup sources stats in sysfs
Message-ID: <20190731171720.GA15301@kroah.com>
References: <20190730024309.233728-1-trong@android.com>
 <5d40d5b3.1c69fb81.6047f.1cc3@mx.google.com>
 <CAJZ5v0hj-GpiYN7nwPJvKJag71MG6zEFbJ6BNwzDidD+7fNFWw@mail.gmail.com>
 <3963324.N1Qi0Ay72S@kreacher>
 <5d41cc55.1c69fb81.9480d.8a49@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d41cc55.1c69fb81.9480d.8a49@mx.google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 31, 2019 at 10:13:57AM -0700, Stephen Boyd wrote:
> Quoting Rafael J. Wysocki (2019-07-31 04:58:36)
> > On Wednesday, July 31, 2019 10:34:11 AM CEST Rafael J. Wysocki wrote:
> > > On Wed, Jul 31, 2019 at 1:41 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > > >
> > > 
> > > > We can run into the same problem when two buses name their devices the
> > > > same name and then we attempt to attach a wakeup source to those two
> > > > devices. Or we can have a problem where a virtual wakeup is made with
> > > > the same name, and again we'll try to make a duplicate named device.
> > > > Using something like 'event' or 'wakeup' or 'ws' as the prefix avoids this
> > > > problem and keeps things clean.
> > > 
> > > Or suffix, like "<devname-wakeup>.
> > > 
> > > But if prefixes are used by an existing convention, I would prefer
> > > "ws-" as it is concise enough and should not be confusing.
> 
> Another possibility is 'eventN', so it reads as /sys/class/wakeup/event0

"eventX" is a prefix already used by the input subsystem, so you might
run into conflicts here :(

"wakeupX" makes sense, no namespace colisions there at all.

thanks,

greg k-h

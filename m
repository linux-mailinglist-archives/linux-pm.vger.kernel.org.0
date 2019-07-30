Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE437B2A8
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 20:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfG3SvP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 14:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfG3SvP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Jul 2019 14:51:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3053320693;
        Tue, 30 Jul 2019 18:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564512674;
        bh=CsmCRJXukR0FZ6/5kobffgcEJX6Pp1GPGySlVRYW5js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bsuJcdmhOlXBLCSe1VpVY3yIZKNYZ0N60s/p0emjIOvoZqX6A7jACiG0cG9mxOM5K
         gRuxr/VkEAx5JFwfwpRcCl6SerEcYCVdMhvqENgmH99J1YN09T/dBp90H9ivis18+k
         J4Sz/nZgLHnzhCNzXTqtRm7Iddmr08EeaC9nQ4Qg=
Date:   Tue, 30 Jul 2019 20:51:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tri Vo <trong@android.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
Message-ID: <20190730185112.GA17119@kroah.com>
References: <20190730024309.233728-1-trong@android.com>
 <CAJZ5v0jJn=vHdYExbzwRAMsk=Ad5bhvOAvHEXe-FHOj2R4Gwig@mail.gmail.com>
 <CANA+-vBKg_W88Oy_wJs1NNYaZ2ciJKO=Mrs47etYTDNXUKW9Uw@mail.gmail.com>
 <5d4090ea.1c69fb81.d5cab.4dcd@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d4090ea.1c69fb81.d5cab.4dcd@mx.google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 30, 2019 at 11:48:09AM -0700, Stephen Boyd wrote:
> Quoting Tri Vo (2019-07-30 11:39:34)
> > On Mon, Jul 29, 2019 at 10:46 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Tue, Jul 30, 2019 at 4:45 AM Tri Vo <trong@android.com> wrote:
> > > > - Device registering the wakeup source is now the parent of the wakeup source.
> > > >   Updated wakeup_source_register()'s signature and its callers accordingly.
> > >
> > > And I really don't like these changes.  Especially having "wakeup"
> > > twice in the path.
> > 
> > I can trim it down to /sys/class/wakeup/<ID>/. Does that sound good?
> 
> Using the same prefix for the class and the device name is quite common.
> For example, see the input, regulator, tty, tpm, remoteproc, hwmon,
> extcon classes. I'd prefer it was left as /sys/class/wakeup/wakeupN. The
> class name could be changed to wakeup_source perhaps (i.e.
> /sys/class/wakeup_source/wakeupN)?
> 

Ah, the issue is that these end up on the virtual "bus".  Yeah, sorry,
you are right, they need to have a unique prefix in order to prevent
name collisions.

thanks,

greg k-h

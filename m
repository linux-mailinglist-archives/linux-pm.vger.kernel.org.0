Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7956D14DA82
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2020 13:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgA3MT1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jan 2020 07:19:27 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:56500 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3MT1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jan 2020 07:19:27 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1A7F41C2604; Thu, 30 Jan 2020 13:19:26 +0100 (CET)
Date:   Thu, 30 Jan 2020 13:19:26 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jonas Meurer <jonas@freesources.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Tim Dittler <tim.dittler@systemli.org>,
        Yannik Sembritzki <yannik@sembritzki.me>
Subject: Re: [PATCH v3] PM: suspend: Add sysfs attribute to control the "sync
 on suspend" behavior
Message-ID: <20200130121926.cdz7dtrcbeuodqca@ucw.cz>
References: <d05a1c0c-1212-17f4-3772-042e2ff76a40@freesources.org>
 <CAJZ5v0gXMkL8Z_=jUvNGoVjDr4s5osO8RNekJ1yg-b+=zi7GSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gXMkL8Z_=jUvNGoVjDr4s5osO8RNekJ1yg-b+=zi7GSw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi!

> > The sysfs attribute `/sys/power/sync_on_suspend` controls, whether or not
> > filesystems are synced by the kernel before system suspend.
> >
> > Congruously, the behaviour of build-time switch CONFIG_SUSPEND_SKIP_SYNC
> > is slightly changed: It now defines the run-tim default for the new sysfs
> > attribute `/sys/power/sync_on_suspend`.
> >
> > The run-time attribute is added because the existing corresponding
> > build-time Kconfig flag for (`CONFIG_SUSPEND_SKIP_SYNC`) is not flexible
> > enough. E.g. Linux distributions that provide pre-compiled kernels
> > usually want to stick with the default (sync filesystems before suspend)
> > but under special conditions this needs to be changed.
> >
> > One example for such a special condition is user-space handling of
> > suspending block devices (e.g. using `cryptsetup luksSuspend` or `dmsetup
> > suspend`) before system suspend. The Kernel trying to sync filesystems
> > after the underlying block device already got suspended obviously leads
> > to dead-locks. Be aware that you have to take care of the filesystem sync
> > yourself before suspending the system in those scenarios.
> >
> > Signed-off-by: Jonas Meurer <jonas@freesources.org>
> 
> Applied as 5.6 material with minor changes in the ABI document, thanks!

For the record, I still believe this is bad idea.

User should not have to tweak variables in /sys for system not to
deadlock with cryptsetup.. and we are stuck with this pretty much
forever.

									Pavel

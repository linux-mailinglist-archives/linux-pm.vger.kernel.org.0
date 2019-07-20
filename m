Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEED46EF49
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jul 2019 14:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfGTMJ5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sat, 20 Jul 2019 08:09:57 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53809 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfGTMJ5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 Jul 2019 08:09:57 -0400
Received: from 79.184.255.39.ipv4.supernova.orange.pl (79.184.255.39) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id bde321c3301db1fa; Sat, 20 Jul 2019 14:09:55 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Kenneth R. Crudup" <kenny@panix.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [Fwd: Commit 555c45fe0d0 ("int340X/processor_thermal_device: add support for MMIO RAPL") boot failure]
Date:   Sat, 20 Jul 2019 14:09:55 +0200
Message-ID: <1740115.QtvjdlHhER@kreacher>
In-Reply-To: <CAJZ5v0j7QxrWtY8h=GgHWjpTm37AhnpNe5j=zLY3v7EwGi94ig@mail.gmail.com>
References: <alpine.DEB.2.21.1907181955330.2769@hp-x360> <1563585953.2455.7.camel@intel.com> <CAJZ5v0j7QxrWtY8h=GgHWjpTm37AhnpNe5j=zLY3v7EwGi94ig@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Saturday, July 20, 2019 12:18:39 PM CEST Rafael J. Wysocki wrote:
> On Sat, Jul 20, 2019 at 3:25 AM Zhang Rui <rui.zhang@intel.com> wrote:
> >
> > On 五, 2019-07-19 at 10:31 -0700, Kenneth R. Crudup wrote:
> > > On Fri, 19 Jul 2019, Zhang Rui wrote:
> > >
> > > >
> > > > please try the patch below and confirm if it helps or not.
> > > >
> > > > From: Zhang Rui <rui.zhang@intel.com>
> > > > Date: Fri, 19 Jul 2019 23:25:14 +0800
> > > > Subject: [PATCH] powercap: adjust init order
> > > The patch fixes the boot crash, yes.
> > >
> > Hi, Kenny,
> >
> > thanks for testing.
> >
> > Rafael,
> >
> > can we merge this urgent fix before the merge window closed?
> 
> Well, we could try that, but it is not even in Patchwork ATM and it
> would be good to let it appear in linux-next too.
> 
> Please resend it as a proper patch, so that Patchwork can pick it up
> and I'll queue it up and push it next week.

BTW, I picked it up from email, so it will appear in linux-next on Mon, but
I needed to fix it up to make it apply and I made some changes in the
subject and changelog.

Also, it would be good to explain in the changelog what exactly causes the
crash to occur.

Thanks!




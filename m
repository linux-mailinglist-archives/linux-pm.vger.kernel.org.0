Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EE82A80F0
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 15:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbgKEObX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 09:31:23 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:60204 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKEObW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 09:31:22 -0500
Received: from 89-64-88-191.dynamic.chello.pl (89.64.88.191) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.514)
 id 655d08c39cdc583d; Thu, 5 Nov 2020 15:31:20 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mike Galbraith <efault@gmx.de>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: v5.8+ powersave governor breakage?
Date:   Thu, 05 Nov 2020 15:31:19 +0100
Message-ID: <2948497.iyA2Nh11HS@kreacher>
In-Reply-To: <59d0b9516ce9a553b1e526c6495ac302f1f73e0d.camel@gmx.de>
References: <580d12716f6363d7404805fd4bc50e2d5ab459b0.camel@gmx.de> <59d0b9516ce9a553b1e526c6495ac302f1f73e0d.camel@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, November 2, 2020 7:18:41 AM CET Mike Galbraith wrote:
> On Sun, 2020-11-01 at 17:23 +0100, Mike Galbraith wrote:
> > Greetings,
> >
> > As you can see in the data below, my i4790 box used to default to the
> > powersave governor despite CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y, and
> > disallowed switching to ondemand.
> 
> Ok, my HP lappy running master.today still defaults to powersave, with
> CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y, still disallows selecting
> ondemand as before, and powersave still works. IOW for lappy, it was
> business as usual, no change.

OK

> Desktop box did, it gained a working ondemand, while its previously
> working powersave went broke.

Most likely that's because it was handled by intel_pstate in the "active" mode
previously, while it is now handled by it in the "passive" mode (the modes are
described in detail in Documentation/admin-guide/pm/intel_pstate.rst) and the
default governor should be "schedutil".

Which should be slightly better from the functionality perspective.

> Box had schedutil forced upon it, but it
> seems perfectly fine with that performance wise.

Which is the expected outcome (sorry for the confusion).

Cheers!




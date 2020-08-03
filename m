Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4F623AB9C
	for <lists+linux-pm@lfdr.de>; Mon,  3 Aug 2020 19:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgHCRXa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 13:23:30 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54826 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgHCRXa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2020 13:23:30 -0400
Received: from 89-64-89-42.dynamic.chello.pl (89.64.89.42) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 2f54c0c1df3e4a29; Mon, 3 Aug 2020 19:23:28 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Francisco Jerez <francisco.jerez.plata@intel.com>
Subject: Re: [PATCH v4 0/2] cpufreq: intel_pstate: Implement passive mode with HWP enabled
Date:   Mon, 03 Aug 2020 19:23:27 +0200
Message-ID: <2039925.Us6koL3qmo@kreacher>
In-Reply-To: <6febe0592d1830dac04aab281f66b47498dda887.camel@linux.intel.com>
References: <4981405.3kqTVLv5tO@kreacher> <13207937.r2GEYrEf4f@kreacher> <6febe0592d1830dac04aab281f66b47498dda887.camel@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Saturday, August 1, 2020 6:39:30 PM CEST Srinivas Pandruvada wrote:
> 
> --=-bU21ZBsdw4g45G9I/wXt
> Content-Type: text/plain; charset="UTF-8"
> Content-Transfer-Encoding: 7bit
> 
> On Tue, 2020-07-28 at 17:09 +0200, Rafael J. Wysocki wrote:
> > Hi All,
> > 
> > On Monday, July 27, 2020 5:13:40 PM CEST Rafael J. Wysocki wrote:
> > > On Thursday, July 16, 2020 7:37:04 PM CEST Rafael J. Wysocki wrote:
> > > > This really is a v2 of this patch:
> > > > 
> > > > https://patchwork.kernel.org/patch/11663271/
> > > > 
> > > > with an extra preceding cleanup patch to avoid making unrelated
> > > > changes in the
> > > > [2/2].
> > > 
> I applied this series along with
> [PATCH] cpufreq: intel_pstate: Fix EPP setting via sysfs in active mode
> on 5.8 latest master (On top of raw epp patchset).
> 
> When intel_pstate=passive from kernel command line then it is fine, no
> crash. But switch dynamically, crashed:
> Attached crash.txt. I may need to try your linux-pm tree.

Please try the v5 on top of my linux-next branch:

https://patchwork.kernel.org/patch/11698495/

FWIW, I cannot reproduce the crash with it.

> Then after some playing I reached a state when I monitor MSR 0x774:
> while true; do rdmsr 0x774; sleep 1; done
> 80002704
> ...
> ...
> ff000101
> ff000101
> ff000101
> ff000101
> ff000101
> ff000101
> ff000101
> ff000101
> 
> Don't have a recipe to reproduce this.

Well, maybe it locked up due to the deadlock in the v4 of the patch.

Please see if you get this with the v5 above applied.

Cheers!




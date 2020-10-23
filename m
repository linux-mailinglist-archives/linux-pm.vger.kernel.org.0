Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C5E2971E8
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 17:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465530AbgJWPGO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 11:06:14 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56046 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S465518AbgJWPGM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 11:06:12 -0400
Received: from 89-64-88-190.dynamic.chello.pl (89.64.88.190) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id 124138861e9212dc; Fri, 23 Oct 2020 17:06:09 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH] sched/fair: check for idle core
Date:   Fri, 23 Oct 2020 17:06:08 +0200
Message-ID: <2251006.PXaUfaNY4o@kreacher>
In-Reply-To: <20201023061246.irzbrl62baoawmqv@vireshk-i7>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr> <34115486.YmRjPRKJaA@kreacher> <20201023061246.irzbrl62baoawmqv@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, October 23, 2020 8:12:46 AM CEST Viresh Kumar wrote:
> On 22-10-20, 13:45, Rafael J. Wysocki wrote:
> > On Thursday, October 22, 2020 12:47:03 PM CEST Viresh Kumar wrote:
> > > And I am not really sure why we always wanted this backup performance
> > > governor to be there unless the said governors are built as module.
> > 
> > Apparently, some old drivers had problems with switching frequencies fast enough
> > for ondemand to be used with them and the fallback was for those cases.  AFAICS.
> 
> Do we still need this ?

For the reasonably modern hardware, I don't think so.

> Or better ask those platforms to individually
> enable both of them.

Bu who knows what they are? :-)




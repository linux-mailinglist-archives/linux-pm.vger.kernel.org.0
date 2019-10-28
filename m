Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14960E7507
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 16:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfJ1P0T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 11:26:19 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43828 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfJ1P0S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 11:26:18 -0400
Received: from cust-east-parth2-46-193-72-114.wb.wifirst.net (46.193.72.114) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id b9bc03ccfbeada10; Mon, 28 Oct 2019 16:26:16 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Preeti U Murthy <preeti@linux.vnet.ibm.com>,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] cpufreq: powernv: fix stack bloat and NR_CPUS limitation
Date:   Mon, 28 Oct 2019 16:26:16 +0100
Message-ID: <3664438.dB2cPXlXpS@kreacher>
In-Reply-To: <20191018050712.qr2axffmbms5h4xb@vireshk-i7>
References: <20191018045539.3765565-1-jhubbard@nvidia.com> <20191018050712.qr2axffmbms5h4xb@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, October 18, 2019 7:07:12 AM CET Viresh Kumar wrote:
> On 17-10-19, 21:55, John Hubbard wrote:
> > The following build warning occurred on powerpc 64-bit builds:
> > 
> > drivers/cpufreq/powernv-cpufreq.c: In function 'init_chip_info':
> > drivers/cpufreq/powernv-cpufreq.c:1070:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > 
> > This is due to putting 1024 bytes on the stack:
> > 
> >     unsigned int chip[256];
> > 
> > ...and while looking at this, it also has a bug: it fails with a stack
> > overrun, if CONFIG_NR_CPUS > 256.
> > 
> > Fix both problems by dynamically allocating based on CONFIG_NR_CPUS.
> > 
> > Fixes: 053819e0bf840 ("cpufreq: powernv: Handle throttling due to Pmax capping at chip level")
> > Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> > Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: linux-pm@vger.kernel.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> > ---
> > 
> > Changes since v1: includes Viresh's review commit fixes.
> > 
> >  drivers/cpufreq/powernv-cpufreq.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> 

Applying as 5.5 material, thanks!





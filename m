Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD5FEDD72
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 12:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfKDLHC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 06:07:02 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49075 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfKDLHC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 06:07:02 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 2c11b88dbf4206f5; Mon, 4 Nov 2019 12:07:00 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Preeti U Murthy <preeti@linux.vnet.ibm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] cpufreq: powernv: fix stack bloat and hard limit on num cpus
Date:   Mon, 04 Nov 2019 12:06:59 +0100
Message-ID: <8351130.8dpKiuZLPc@kreacher>
In-Reply-To: <20191031052159.4125031-1-jhubbard@nvidia.com>
References: <20191031052159.4125031-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, October 31, 2019 6:21:59 AM CET John Hubbard wrote:
> The following build warning occurred on powerpc 64-bit builds:
> 
> drivers/cpufreq/powernv-cpufreq.c: In function 'init_chip_info':
> drivers/cpufreq/powernv-cpufreq.c:1070:1: warning: the frame size of
> 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> This is with a cross-compiler based on gcc 8.1.0, which I got from:
>   https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/
> 
> The warning is due to putting 1024 bytes on the stack:
> 
>     unsigned int chip[256];
> 
> ...and it's also undesirable to have a hard limit on the number of
> CPUs here.
> 
> Fix both problems by dynamically allocating based on num_possible_cpus,
> as recommended by Michael Ellerman.
> 
> Fixes: 053819e0bf840 ("cpufreq: powernv: Handle throttling due to Pmax capping at chip level")
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> 
> Changes since v2: applied fixes from Michael Ellerman's review:
> 
> * Changed from CONFIG_NR_CPUS to num_possible_cpus()
> 
> * Fixed up commit description: added a note about exactly which
>   compiler generates the warning. And softened up wording about
>   the limitation on number of CPUs.
> 
> Changes since v1: includes Viresh's review commit fixes.

Applying as 5.5 material, thanks!




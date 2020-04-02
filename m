Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E21BA19BE72
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 11:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbgDBJPJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 05:15:09 -0400
Received: from foss.arm.com ([217.140.110.172]:40278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729033AbgDBJPJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 05:15:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D44831B;
        Thu,  2 Apr 2020 02:15:08 -0700 (PDT)
Received: from bogus (unknown [10.37.12.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DAF93F68F;
        Thu,  2 Apr 2020 02:15:06 -0700 (PDT)
Date:   Thu, 2 Apr 2020 10:14:55 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] cpufreq: Select schedutil when using big.LITTLE
Message-ID: <20200402091446.GA19366@bogus>
References: <20200402080239.7471-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402080239.7471-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 02, 2020 at 10:02:39AM +0200, Linus Walleij wrote:
> When we are using a system with big.LITTLE HMP
> configuration, we need to use EAS to schedule the
> system.
> 
> As can be seen from kernel/sched/topology.c:
> 
>  "EAS can be used on a root domain if it meets all the following conditions:
>   1. an Energy Model (EM) is available;
>   2. the SD_ASYM_CPUCAPACITY flag is set in the sched_domain hierarchy.
>   3. no SMT is detected.
>   4. the EM complexity is low enough to keep scheduling overheads low;
>   5. schedutil is driving the frequency of all CPUs of the rd;"
> 
> This means that at the very least, schedutil needs to be
> available as a scheduling policy for EAS to work on these
> systems. Make this explicit by defaulting to the schedutil
> governor if BIG_LITTLE is selected.
> 
> Currently users of the TC2 board (like me) has to figure these
> dependencies out themselves and it is not helpful.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Good to see another user of TC2 ;)

FWIW:
Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

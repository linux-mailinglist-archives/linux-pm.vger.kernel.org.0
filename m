Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE068B7E12
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 17:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391221AbfISPXH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 11:23:07 -0400
Received: from foss.arm.com ([217.140.110.172]:60806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391210AbfISPXG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Sep 2019 11:23:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2686F28;
        Thu, 19 Sep 2019 08:23:06 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 749903F575;
        Thu, 19 Sep 2019 08:23:05 -0700 (PDT)
Date:   Thu, 19 Sep 2019 16:23:00 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sujeet Kumar Baranwal <sbaranwal@marvell.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org
Subject: Re: [EXT] Re: SCMI & Devfreq
Message-ID: <20190919152300.GA11801@bogus>
References: <BYAPR18MB24387C9DDE32067F1763B6DEAFB00@BYAPR18MB2438.namprd18.prod.outlook.com>
 <20190913102304.GC2559@bogus>
 <BYAPR18MB2438723658EF1F0586170CDDAF8C0@BYAPR18MB2438.namprd18.prod.outlook.com>
 <20190916101505.GB6109@bogus>
 <BYAPR18MB2438DC4E8CA4E90455F0345BAF8C0@BYAPR18MB2438.namprd18.prod.outlook.com>
 <BYAPR18MB2438047B622951C6EFE92FABAF8E0@BYAPR18MB2438.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR18MB2438047B622951C6EFE92FABAF8E0@BYAPR18MB2438.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

(Adding linux-pm list)

On Wed, Sep 18, 2019 at 10:53:07PM +0000, Sujeet Kumar Baranwal wrote:
> Sudeep, One trivial question wrt SCMI-CPUFREQ framework.
> 
> The SCMI perf protocol would tell what are different frequencies the
> platform support in the beginning.
>
> For example, the command :
> cat  /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
> shows:
> 280000 560000 840000 1120000 1400000 1820000 1960000 2240000 2520000 2800000
>
> /* Attempt to change the frequency */
> ~ # echo 2240000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
> It works.
>
> But in a scenario, where user tries a number which is not listed, SCP
> applies its own logic to get a nearby value frequency for CPU and returns.
>
> My question is that could we add some print message in kernel that user wish
> is not exactly fulfilled, an approximation has been done so the user
> explicitly knows his command has been partially met.  If this to happen, a
> patch might be needed in kernel. What is your opinion?
>

May be, you need to check with the maintainers ? :)

The path of execution is:
cpufreq_set(policy, freq) [cpufreq_userspace.c]
__cpufreq_driver_target(policy, freq, CPUFREQ_RELATION_L) [cpufreq_userspace.c]
index = cpufreq_frequency_table_target(policy, target_freq, relation) [cpufreq.c]
__target_index(policy, index) [cpufreq.c]

So if you need logs, it needs to be in core file rather than individual
drivers.

--
Regards,
Sudeep

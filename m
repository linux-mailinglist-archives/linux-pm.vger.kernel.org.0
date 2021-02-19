Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271DB31FF50
	for <lists+linux-pm@lfdr.de>; Fri, 19 Feb 2021 20:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhBSTRr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Feb 2021 14:17:47 -0500
Received: from foss.arm.com ([217.140.110.172]:42964 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230101AbhBSTRq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Feb 2021 14:17:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1976D1FB;
        Fri, 19 Feb 2021 11:17:01 -0800 (PST)
Received: from bogus (unknown [10.57.7.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B5163F73D;
        Fri, 19 Feb 2021 11:16:59 -0800 (PST)
Date:   Fri, 19 Feb 2021 19:16:50 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Nicola Mazzucato <nicola.mazzucato@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, vireshk@kernel.org,
        cristian.marussi@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, ionela.voinescu@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v8 0/3] CPUFreq: Add support for opp-sharing cpus
Message-ID: <20210219191650.q7bu6ogbhh2hcmww@bogus>
References: <20210218222326.15788-1-nicola.mazzucato@arm.com>
 <20210219041944.uox45mesrabvfm72@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219041944.uox45mesrabvfm72@vireshk-i7>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Fri, Feb 19, 2021 at 09:49:44AM +0530, Viresh Kumar wrote:
> On 18-02-21, 22:23, Nicola Mazzucato wrote:
> > Hi Viresh,
> > 
> > In this V8 I have addressed your comments:
> > - correct the goto in patch 1/3
> > - improve comment in patch 2/3 for dev_pm_opp_get_opp_count()
> 
> LGTM. I will apply them after the merge window is over. Thanks.

I am planning to merge the series on scmi[1] which changes scmi-cpufreq.c
and will conflict with these changes I think. If possible either,

1. Share a branch with these changes that I can merge or
2. I can take patch 1/3 and 2/3 with other scmi changes with your Ack.

I am fine either way, let me know by v5.12-rc1

--
Regards,
Sudeep

[1] https://lore.kernel.org/linux-arm-kernel/20210202221555.41167-1-cristian.marussi@arm.com/

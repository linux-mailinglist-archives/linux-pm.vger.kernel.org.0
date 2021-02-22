Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2093214DF
	for <lists+linux-pm@lfdr.de>; Mon, 22 Feb 2021 12:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhBVLPW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Feb 2021 06:15:22 -0500
Received: from foss.arm.com ([217.140.110.172]:41682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230044AbhBVLPW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Feb 2021 06:15:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61C2C1FB;
        Mon, 22 Feb 2021 03:14:36 -0800 (PST)
Received: from bogus (unknown [10.57.7.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8CCC3F73B;
        Mon, 22 Feb 2021 03:14:34 -0800 (PST)
Date:   Mon, 22 Feb 2021 11:14:28 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Nicola Mazzucato <nicola.mazzucato@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, vireshk@kernel.org,
        cristian.marussi@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, ionela.voinescu@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v8 0/3] CPUFreq: Add support for opp-sharing cpus
Message-ID: <20210222111428.okyazrtufefumhfk@bogus>
References: <20210218222326.15788-1-nicola.mazzucato@arm.com>
 <20210219041944.uox45mesrabvfm72@vireshk-i7>
 <20210219191650.q7bu6ogbhh2hcmww@bogus>
 <20210222043904.j36d6btl2v64xg6q@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222043904.j36d6btl2v64xg6q@vireshk-i7>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 22, 2021 at 10:09:04AM +0530, Viresh Kumar wrote:
> On 19-02-21, 19:16, Sudeep Holla wrote:
> > Hi Viresh,
> > 
> > On Fri, Feb 19, 2021 at 09:49:44AM +0530, Viresh Kumar wrote:
> > > On 18-02-21, 22:23, Nicola Mazzucato wrote:
> > > > Hi Viresh,
> > > > 
> > > > In this V8 I have addressed your comments:
> > > > - correct the goto in patch 1/3
> > > > - improve comment in patch 2/3 for dev_pm_opp_get_opp_count()
> > > 
> > > LGTM. I will apply them after the merge window is over. Thanks.
> > 
> > I am planning to merge the series on scmi[1] which changes scmi-cpufreq.c
> > and will conflict with these changes I think. If possible either,
> > 
> > 1. Share a branch with these changes that I can merge or
> > 2. I can take patch 1/3 and 2/3 with other scmi changes with your Ack.
> > 
> > I am fine either way, let me know by v5.12-rc1
> 
> I have applied 3/3, you can take first two and add my Ack.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Thanks Viresh, I will pick after v5.12-rc1

-- 
Regards,
Sudeep

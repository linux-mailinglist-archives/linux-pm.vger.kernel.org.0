Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CBC1C70C8
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 14:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgEFMtm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 08:49:42 -0400
Received: from foss.arm.com ([217.140.110.172]:35878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbgEFMtm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 May 2020 08:49:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B00411FB;
        Wed,  6 May 2020 05:49:41 -0700 (PDT)
Received: from bogus (unknown [10.37.8.198])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62EE53F68F;
        Wed,  6 May 2020 05:49:39 -0700 (PDT)
Date:   Wed, 6 May 2020 13:49:32 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, john.garry@huawei.com,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Thanu Rangarajan <Thanu.Rangarajan@arm.com>
Subject: Re: [RFC PATCH] cpufreq: add support for HiSilicon SoC HIP09
Message-ID: <20200506124932.GA20426@bogus>
References: <1588227599-46438-1-git-send-email-wangxiongfeng2@huawei.com>
 <20200430095559.GB28579@bogus>
 <3ba950dd-4065-e4a5-d406-dc5c6c1781a7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ba950dd-4065-e4a5-d406-dc5c6c1781a7@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+ Thanu, Souvik who work with ASWG

On Wed, May 06, 2020 at 05:36:51PM +0800, Hanjun Guo wrote:
> Hi Sudeep,
>
> On 2020/4/30 17:55, Sudeep Holla wrote:
> > On Thu, Apr 30, 2020 at 02:19:59PM +0800, Xiongfeng Wang wrote:
> > > HiSilicon SoC has a separate System Control Processor(SCP) dedicated for
> > > clock frequency adjustment and has been using the cpufreq driver
> > > 'cppc-cpufreq'. New HiSilicon SoC HIP09 add support for CPU Boost, but
> > > ACPI CPPC doesn't support this. In HiSilicon SoC HIP09, each core has
> > > its own clock domain. It is better for the core itself to adjust its
> > > frequency when we require fast response. In this patch, we add a
> > > separate cpufreq driver for HiSilicon SoC HIP09.
> > >
> >
> > I disagree with this approach unless you have tried to extend the CPPC
> > in ACPI to accommodate this boost feature you need. Until you show those
> > efforts and disagreement to do that from ASWG, I am NACKing this approach.
>
> Unfortunately we are not in ASWG at now, could you please give some
> help about extending CPPC in ACPI to support boost feature?
>

You may have to provide more details than the commit log for sure as I
haven't understood the boost feature and what is missing in ACPI CPPC.

--
Regards,
Sudeep

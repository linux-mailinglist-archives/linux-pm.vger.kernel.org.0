Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 156246D2F0
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 19:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfGRRla (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 13:41:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48302 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRRla (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 13:41:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7569260E3F; Thu, 18 Jul 2019 17:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563471689;
        bh=lVFlEoflCmqI7DqZxWRv5iAXmSD3G5OYiXbXrkCxEFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oRSy/SbHGcih031VmvFWuJks1y4W3MRcNyoFlAqk01JnMbs9SOXSQ5KC333CiV9+s
         qsPzyOmpYFZrbuJ1mZgzaMOkXcmMXUjhHjnB2Y+JE6olm2ndKCviw/vdfhGCF2fWbL
         0kR9i/6LHiWeVT0UBrbULzYMmR42G6eCO4Ahpnwc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6E4EA607EB;
        Thu, 18 Jul 2019 17:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563471678;
        bh=lVFlEoflCmqI7DqZxWRv5iAXmSD3G5OYiXbXrkCxEFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UStSy+lE4QoOupgj89GwC6zwlpy9wpMu4KsRTMBxdS31Av8x+wNEx0G5CfGDBFqDd
         abivphmpwVS3fvrc0a4fxuustkhZ6mUiZLzl/83ejm12D93tZOOK1dXnF/XJt8UYdL
         tBKlVf1faL3xnetIEwsr6ynYGjkTdyry5G/wtLiU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E4EA607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 18 Jul 2019 11:41:16 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/18] drivers: firmware: psci: Manage runtime PM in the
 idle path for CPUs
Message-ID: <20190718174116.GD25567@codeaurora.org>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
 <20190513192300.653-15-ulf.hansson@linaro.org>
 <20190716155317.GB32490@e121166-lin.cambridge.arm.com>
 <CAPDyKFrJ75mo+s6GuUCTQ-nVv7C+9YJyTVmwuBZ2RKFOvOi3Nw@mail.gmail.com>
 <20190718133053.GA27222@e121166-lin.cambridge.arm.com>
 <CAPDyKFr4NmichQk4uf+Wgbanh=5idKYY=37WCb6U_hNFDVYg=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPDyKFr4NmichQk4uf+Wgbanh=5idKYY=37WCb6U_hNFDVYg=w@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 18 2019 at 10:55 -0600, Ulf Hansson wrote:
>On Thu, 18 Jul 2019 at 15:31, Lorenzo Pieralisi
><lorenzo.pieralisi@arm.com> wrote:
>>
>> On Thu, Jul 18, 2019 at 12:35:07PM +0200, Ulf Hansson wrote:
>> > On Tue, 16 Jul 2019 at 17:53, Lorenzo Pieralisi
>> > <lorenzo.pieralisi@arm.com> wrote:
>> > >
>> > > On Mon, May 13, 2019 at 09:22:56PM +0200, Ulf Hansson wrote:
>> > > > When the hierarchical CPU topology layout is used in DT, let's allow the
>> > > > CPU to be power managed through its PM domain, via deploying runtime PM
>> > > > support.
>> > > >
>> > > > To know for which idle states runtime PM reference counting is needed,
>> > > > let's store the index of deepest idle state for the CPU, in a per CPU
>> > > > variable. This allows psci_cpu_suspend_enter() to compare this index with
>> > > > the requested idle state index and then act accordingly.
>> > >
>> > > I do not see why a system with two CPU CPUidle states, say CPU retention
>> > > and CPU shutdown, should not be calling runtime PM on CPU retention
>> > > entry.
>> >
>> > If the CPU idle governor did select the CPU retention for the CPU, it
>> > was probably because the target residency for the CPU shutdown state
>> > could not be met.
>>
>> The kernel does not know what those cpu states represent, so, this is an
>> assumption you are making and it must be made clear that this code works
>> as long as your assumption is valid.
>>
>> If eg a "cluster" retention state has lower target_residency than
>> the deepest CPU idle state this assumption is wrong.
>
>Good point, you are right. I try to find a place to document this assumption.
>
>>
>> And CPUidle and genPD governor decisions are not synced anyway so,
>> again, this is an assumption, not a certainty.
>>
>> > In this case, there is no point in allowing any other deeper idle
>> > states for cluster/package/system, since those have even greater
>> > residencies, hence calling runtime PM doesn't make sense.
>>
>> On the systems you are testing on.
>
>So what you are saying typically means, that if all CPUs in the same
>cluster have entered the CPU retention state, on some system the
>cluster may also put into a cluster retention state (assuming the
>target residency is met)?
>
>Do you know of any systems that has these characteristics?
>
Many QCOM SoCs can do that. But with the hardware improving, the
power-performance benefits skew the results in favor of powering off
the cluster than keeping the CPU and cluster in retention.

Kevin H and I thought of this problem earlier on. But that is a second
level problem to solve and definitely to be thought of after we have the
support for the deepest states in the kernel. We left that out for a
later date. The idea would have been to setup the allowable state(s) in
the DT for CPU and cluster state definitions and have the genpd take
that into consideration when deciding the idle state for the domain.

Thanks,
Lina


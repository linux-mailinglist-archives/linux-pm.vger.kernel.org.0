Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46CB017E24B
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 15:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgCIOLE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 10:11:04 -0400
Received: from foss.arm.com ([217.140.110.172]:52940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgCIOLE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Mar 2020 10:11:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C1F830E;
        Mon,  9 Mar 2020 07:11:03 -0700 (PDT)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C8F53F67D;
        Mon,  9 Mar 2020 07:11:03 -0700 (PDT)
Date:   Mon, 9 Mar 2020 14:11:01 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     will@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        suzuki.poulose@arm.com, lukasz.luba@arm.com,
        valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        rjw@rjwysocki.net, pkondeti@codeaurora.org,
        linux-doc@vger.kernel.org, peterz@infradead.org,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 0/7] arm64: ARMv8.4 Activity Monitors support
Message-ID: <20200309141101.GA13343@arm.com>
References: <20200305090627.31908-1-ionela.voinescu@arm.com>
 <20200306112134.GD2503422@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306112134.GD2503422@arrakis.emea.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Catalin, Sudeep,

On Friday 06 Mar 2020 at 11:21:34 (+0000), Catalin Marinas wrote:
> Hi Ionela,
> 
> On Thu, Mar 05, 2020 at 09:06:20AM +0000, Ionela Voinescu wrote:
> > v5 -> v6
> >  - v5 can be found at [7]
> >  - The current series is based on arm64/master [8].
> 
> arm64/master is just some random point in the Linus tree, I didn't
> realise people are using it. I moved it to v5.6-rc3 as that's the base
> for the final arm64 for-next/core.
> 
> >  - [1/7] kernel parameter removed as Catalin recommended
> >  - [2/7, 4/7] changelog and documentation changed to remove information
> >    about the removed kernel parameter
> >  - [2/7, 3/7, 6/7] collected reviewed-by and acked-by from James,
> >    Marc and Lukasz.
> 
> The series looks fine. Once Sudeep reviews/acks the arch topology patch,
> I'll queue the patches.
>

Thank you both!

Ionela.

> Thanks.
> 
> -- 
> Catalin

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11A4B17BB86
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 12:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCFLVj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 06:21:39 -0500
Received: from foss.arm.com ([217.140.110.172]:59858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgCFLVj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Mar 2020 06:21:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9259731B;
        Fri,  6 Mar 2020 03:21:38 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 637213F6C4;
        Fri,  6 Mar 2020 03:21:36 -0800 (PST)
Date:   Fri, 6 Mar 2020 11:21:34 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     will@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        suzuki.poulose@arm.com, sudeep.holla@arm.com, lukasz.luba@arm.com,
        valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        rjw@rjwysocki.net, pkondeti@codeaurora.org,
        linux-doc@vger.kernel.org, peterz@infradead.org,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 0/7] arm64: ARMv8.4 Activity Monitors support
Message-ID: <20200306112134.GD2503422@arrakis.emea.arm.com>
References: <20200305090627.31908-1-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305090627.31908-1-ionela.voinescu@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ionela,

On Thu, Mar 05, 2020 at 09:06:20AM +0000, Ionela Voinescu wrote:
> v5 -> v6
>  - v5 can be found at [7]
>  - The current series is based on arm64/master [8].

arm64/master is just some random point in the Linus tree, I didn't
realise people are using it. I moved it to v5.6-rc3 as that's the base
for the final arm64 for-next/core.

>  - [1/7] kernel parameter removed as Catalin recommended
>  - [2/7, 4/7] changelog and documentation changed to remove information
>    about the removed kernel parameter
>  - [2/7, 3/7, 6/7] collected reviewed-by and acked-by from James,
>    Marc and Lukasz.

The series looks fine. Once Sudeep reviews/acks the arch topology patch,
I'll queue the patches.

Thanks.

-- 
Catalin

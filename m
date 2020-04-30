Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB8E1BF499
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 11:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgD3J4D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 05:56:03 -0400
Received: from foss.arm.com ([217.140.110.172]:51616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgD3J4D (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Apr 2020 05:56:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14DCE1063;
        Thu, 30 Apr 2020 02:56:03 -0700 (PDT)
Received: from bogus (unknown [10.37.12.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 928963F68F;
        Thu, 30 Apr 2020 02:56:01 -0700 (PDT)
Date:   Thu, 30 Apr 2020 10:55:59 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        guohanjun@huawei.com, john.garry@huawei.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC PATCH] cpufreq: add support for HiSilicon SoC HIP09
Message-ID: <20200430095559.GB28579@bogus>
References: <1588227599-46438-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588227599-46438-1-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 30, 2020 at 02:19:59PM +0800, Xiongfeng Wang wrote:
> HiSilicon SoC has a separate System Control Processor(SCP) dedicated for
> clock frequency adjustment and has been using the cpufreq driver
> 'cppc-cpufreq'. New HiSilicon SoC HIP09 add support for CPU Boost, but
> ACPI CPPC doesn't support this. In HiSilicon SoC HIP09, each core has
> its own clock domain. It is better for the core itself to adjust its
> frequency when we require fast response. In this patch, we add a
> separate cpufreq driver for HiSilicon SoC HIP09.
>

I disagree with this approach unless you have tried to extend the CPPC
in ACPI to accommodate this boost feature you need. Until you show those
efforts and disagreement to do that from ASWG, I am NACKing this approach.

--
Regards,
Sudeep

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6532C3C2C
	for <lists+linux-pm@lfdr.de>; Wed, 25 Nov 2020 10:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgKYJaC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 04:30:02 -0500
Received: from foss.arm.com ([217.140.110.172]:35140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgKYJaC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Nov 2020 04:30:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F84E106F;
        Wed, 25 Nov 2020 01:30:01 -0800 (PST)
Received: from [10.57.27.121] (unknown [10.57.27.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5ED933F70D;
        Wed, 25 Nov 2020 01:29:59 -0800 (PST)
Subject: Re: [PATCH 0/2] SCMI performance protocol power scale interface
To:     rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Dietmar.Eggemann@arm.com, cristian.marussi@arm.com,
        morten.rasmussen@arm.com, viresh.kumar@linaro.org
References: <20201124104346.27167-1-lukasz.luba@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <a7ba00cc-990f-8cee-ec1a-698aa4f0f65e@arm.com>
Date:   Wed, 25 Nov 2020 09:29:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201124104346.27167-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 11/24/20 10:43 AM, Lukasz Luba wrote:
> Hi all,
> 
> The Energy Model (EM) supports power values expressed in an abstract scale
> via new API. The SCMI performance protocol provides the information about
> power scale. This patch set implements the needed interface and updates
> cpufreq driver to set the right scale in the EM.
> 
> It is based on top of patch series adding milli-Watts flag in EM [1]
> (next-20201124 was used as a base).
> 
> Regards,
> Lukasz
> 
> [1] https://lore.kernel.org/linux-pm/20201103090600.29053-1-lukasz.luba@arm.com/
> 
> Lukasz Luba (2):
>    firmware: arm_scmi: Add power_scale_mw_get() interface
>    cpufreq: arm_scmi: Discover the power scale in performance protocol
> 
>   drivers/cpufreq/scmi-cpufreq.c   | 4 +++-
>   drivers/firmware/arm_scmi/perf.c | 8 ++++++++
>   include/linux/scmi_protocol.h    | 1 +
>   3 files changed, 12 insertions(+), 1 deletion(-)
> 

Could you take this patch set, please?

Patch 1/2, which is ARM firmware protocol change, got ACK from Sudeep in
case it would go via your PM tree.

The patch series is a follow up to the EM changes, which you have taken
recently into your PM tree (link in the cover letter above).

Regards,
Lukasz

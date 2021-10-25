Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0730439BED
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 18:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhJYQpk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 12:45:40 -0400
Received: from foss.arm.com ([217.140.110.172]:48052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234036AbhJYQpi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Oct 2021 12:45:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 498441FB;
        Mon, 25 Oct 2021 09:43:16 -0700 (PDT)
Received: from [10.57.21.241] (unknown [10.57.21.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 006DD3F5A1;
        Mon, 25 Oct 2021 09:43:12 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Refactor thermal pressure update to avoid code
 duplication
To:     rafael@kernel.org, viresh.kumar@linaro.org,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, amitk@kernel.org,
        amit.kachhap@gmail.com, thara.gopinath@linaro.org,
        bjorn.andersson@linaro.org, agross@kernel.org
References: <20211015144550.23719-1-lukasz.luba@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <3cc80fea-1320-9a1a-9954-85b30f3d933a@arm.com>
Date:   Mon, 25 Oct 2021 17:43:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20211015144550.23719-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 10/15/21 3:45 PM, Lukasz Luba wrote:
> Hi all,
> 
> This patch set v2 aims to refactor the thermal pressure update
> code. There are already two clients which do similar thing:
> convert the capped frequency value into the capacity of
> affected CPU and call the 'set' function to store the
> reduced capacity into the per-cpu variable.
> There might be more than two of these users. In near future
> it will be scmi-cpufreq driver, which receives notification
> from FW about reduced frequency due to thermal. Other vendors
> might follow. Let's avoid code duplication and potential
> conversion bugs. Move the conversion code into the arch_topology.c
> where the capacity calculation setup code and thermal pressure sit.
> 
> Apart from that $subject patches, there is one patch (3/5) which fixes
> issue in qcom-cpufreq-hw.c when the thermal pressure is not
> updated for offline CPUs. It's similar fix that has been merged
> recently for cpufreq_cooling.c:
> 2ad8ccc17d1e4270cf65a3f2
> 
> Changes:
> v2:
> - added Reviewed-by from Thara for patch 3/5
> - changed the doxygen comment and used mult_frac()
>    according to Thara's suggestion in patch 1/5
> v1 -> [1]
> 

Gentle ping.

Viresh, Daniel, Rafael could you have a look at this, please?

Regards,
Lukasz

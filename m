Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C9F339493
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 18:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhCLRUP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 12:20:15 -0500
Received: from foss.arm.com ([217.140.110.172]:57724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232850AbhCLRT6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Mar 2021 12:19:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F89A1FB;
        Fri, 12 Mar 2021 09:19:58 -0800 (PST)
Received: from [10.57.17.106] (unknown [10.57.17.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 285753F7D7;
        Fri, 12 Mar 2021 09:19:56 -0800 (PST)
Subject: Re: [PATCH v2 5/5] thermal/drivers/cpufreq_cooling: Remove unused
 list
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
References: <20210312170316.3138-1-daniel.lezcano@linaro.org>
 <20210312170316.3138-5-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <04b7fa9e-f67d-d1d8-99a2-0548f55f1858@arm.com>
Date:   Fri, 12 Mar 2021 17:19:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210312170316.3138-5-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/12/21 5:03 PM, Daniel Lezcano wrote:
> There is a list with the purpose of grouping the cpufreq cooling
> device together as described in the comments but actually it is
> unused, the code evolved since 2012 and the list was no longer needed.
> 
> Delete the remaining unused list related code.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/cpufreq_cooling.c | 13 -------------
>   1 file changed, 13 deletions(-)
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

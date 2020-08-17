Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCDD24665A
	for <lists+linux-pm@lfdr.de>; Mon, 17 Aug 2020 14:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgHQM2s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 08:28:48 -0400
Received: from foss.arm.com ([217.140.110.172]:54458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgHQM2s (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Aug 2020 08:28:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA29330E;
        Mon, 17 Aug 2020 05:28:47 -0700 (PDT)
Received: from [10.37.12.68] (unknown [10.37.12.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF22B3F66B;
        Mon, 17 Aug 2020 05:28:45 -0700 (PDT)
Subject: Re: [PATCH] memory: samsung: exynos5422-dmc: Additional locking for
 'curr_rate'
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     oss-self-reviewed-patches@listhost.cambridge.arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kgene@kernel.org, b.zolnierkie@samsung.com
References: <20200811101727.3976-1-lukasz.luba@arm.com>
 <20200817115435.GA2346@kozik-lap>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <b1cbd097-b31d-b1f2-243b-f4ed3074a9ce@arm.com>
Date:   Mon, 17 Aug 2020 13:28:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200817115435.GA2346@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 8/17/20 12:54 PM, Krzysztof Kozlowski wrote:
> On Tue, Aug 11, 2020 at 11:17:27AM +0100, Lukasz Luba wrote:
>> The 'curr_rate' is protected by local 'dmc->lock' in various places, but
>> not in a function exynos5_dmc_get_status(). The lock protects frequency
>> (and voltage) change process and the corresponding value stored in
>> 'curr_rate'. Add the locking mechanism to protect the 'curr_rate' reading
>> also in the exynos5_dmc_get_status().
>>
>> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/memory/samsung/exynos5422-dmc.c | 3 +++
> 
> Thanks, applied.
> 

Thank you for applying it.

Regards,
Lukasz

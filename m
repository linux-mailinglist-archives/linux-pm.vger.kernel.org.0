Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D7E22E79A
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 10:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgG0IVF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 04:21:05 -0400
Received: from foss.arm.com ([217.140.110.172]:39346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgG0IVF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Jul 2020 04:21:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 840D8D6E;
        Mon, 27 Jul 2020 01:21:04 -0700 (PDT)
Received: from [10.37.12.33] (unknown [10.37.12.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E74D3F71F;
        Mon, 27 Jul 2020 01:21:01 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] memory: samsung: exynos5422-dmc: Adjust polling
 interval and uptreshold
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, willy.mh.wolff.ml@gmail.com,
        k.konieczny@samsung.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        s.nawrocki@samsung.com, kgene@kernel.org
References: <20200710191122.11029-1-lukasz.luba@arm.com>
 <20200710191122.11029-2-lukasz.luba@arm.com>
 <20200720144623.GB22791@kozik-lap>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <decc2758-8c57-8b32-26fb-d4a5b2ca5224@arm.com>
Date:   Mon, 27 Jul 2020 09:20:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200720144623.GB22791@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/20/20 3:46 PM, Krzysztof Kozlowski wrote:
> On Fri, Jul 10, 2020 at 08:11:21PM +0100, Lukasz Luba wrote:
>> In order to react faster and make better decisions under some workloads,
>> benchmarking the memory subsystem behavior, adjust the polling interval
>> and upthreshold value used by the simple_ondemand governor.
>>
>> Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/memory/samsung/exynos5422-dmc.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Feel free to take it via devfreq tree.
> 
> Best regards,
> Krzysztof
> 

Thank you Krzysztof for the review.

Regards,
Lukasz

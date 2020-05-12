Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E021CEF70
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 10:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgELIrY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 04:47:24 -0400
Received: from foss.arm.com ([217.140.110.172]:49504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgELIrY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 May 2020 04:47:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B14F21FB;
        Tue, 12 May 2020 01:47:23 -0700 (PDT)
Received: from [10.37.12.83] (unknown [10.37.12.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A066F3F305;
        Tue, 12 May 2020 01:47:21 -0700 (PDT)
Subject: Re: [PATCH] memory/samsung: reduce unnecessary mutex lock area
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bernard Zhao <bernard@vivo.com>
Cc:     Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
References: <20200508131338.32956-1-bernard@vivo.com>
 <20200512065023.GA10741@kozik-lap>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <e762ce12-eff0-d3a5-f083-2b592921de59@arm.com>
Date:   Tue, 12 May 2020 09:47:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200512065023.GA10741@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

I am sorry, I was a bit busy recently.

On 5/12/20 7:50 AM, Krzysztof Kozlowski wrote:
> On Fri, May 08, 2020 at 06:13:38AM -0700, Bernard Zhao wrote:
>> Maybe dmc->df->lock is unnecessary to protect function
>> exynos5_dmc_perf_events_check(dmc). If we have to protect,
>> dmc->lock is more better and more effective.
>> Also, it seems not needed to protect "if (ret) & dev_warn"
>> branch.
>>
>> Signed-off-by: Bernard Zhao <bernard@vivo.com>
>> ---
>>   drivers/memory/samsung/exynos5422-dmc.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> I checked the concurrent accesses and it looks correct.
> 
> Lukasz, any review from your side?

The lock from devfreq lock protects from a scenario when
concurrent access from devfreq framework uses internal dmc fields 'load' 
and 'total' (which are set to 'busy_time', 'total_time').
The .get_dev_status can be called at any time (even due to thermal
devfreq cooling action) and reads above fields.
That's why the calculation of the new values inside dmc is protected.

This patch should not be taken IMO. Maybe we can release lock before the
if statement, just to speed-up.

Regards,
Lukasz


> 
> Best regards,
> Krzysztof
> 

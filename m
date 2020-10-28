Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12DF29D976
	for <lists+linux-pm@lfdr.de>; Wed, 28 Oct 2020 23:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389726AbgJ1Wyu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 18:54:50 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16472 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733260AbgJ1Wyq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 18:54:46 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9964a70001>; Wed, 28 Oct 2020 05:31:35 -0700
Received: from [10.26.45.122] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 12:31:30 +0000
Subject: Re: [PATCH V2] cpufreq: tegra186: Fix initial frequency
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200824145907.331899-1-jonathanh@nvidia.com>
 <20200825055003.qfsuktsv7cyouxei@vireshk-i7>
 <09ac354e-a55b-5300-12ae-3f24c8f8b193@nvidia.com>
 <20201016040700.wzfegk7hmabxgpff@vireshk-i7>
 <9c37db70-9406-8005-3478-dc4a5e94c566@nvidia.com>
 <c6ab92fe-e5ea-4568-6457-7a28c8496114@nvidia.com>
 <20201028041152.733tkghz4vnqz2io@vireshk-i7>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <382ba642-dbea-c36a-0c71-6e91ccb7b775@nvidia.com>
Date:   Wed, 28 Oct 2020 12:31:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201028041152.733tkghz4vnqz2io@vireshk-i7>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603888295; bh=WzzOaEYzIzsUI3cCl2d2uX4B6nM/EI/XkOk1VFdax78=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=Qitm16SUB86mjL+1uY8ctmLnjoeRyRtQ7q3QyhEocvw1dN2ObM8q4aqz+9Wky2kl2
         DGwT+i5qqMWzB+LlDtkjFxwn86PfWN2tk8GCtyx8yRqIza+j6Ki4f1mZoUHZ2oqVtU
         x2LcYeP1AG1x9lByZlAfYdpzuFaaivHUwVnj4cOlsSZwrlHFiTCBI5fBNiIJleIOdc
         XbUZRui/wbJ7eqK2khGoaqy3E3bQYUQZl7jBVF/2km4aH5xemVDJAhcqA5barRBTHd
         N6DB/GSWllOm6FooPVtMx5+qlPA7WyIs1G6TSjKtsWR3wjGWAwOYZn5L00Qk9/WeIf
         PUFmVIB3jarYw==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 28/10/2020 04:11, Viresh Kumar wrote:
> On 26-10-20, 12:57, Jon Hunter wrote:
>> Thinking about this some more, what are your thoughts on making the
>> following change? 
>>
>> Basically, if the driver sets the CPUFREQ_NEED_INITIAL_FREQ_CHECK,
> 
> This flag only means that the platform would like the core to check
> the currently programmed frequency and get it in sync with the table.

Yes exactly.

>> then I wonder if we should not fail if the frequency return by
>>> get() is not known.
> 
> When do we fail if the frequency isn't known ? That's the case where
> we try to set it to one from the table.

Currently, if the frequency is not known, we fail right before we do the
initial frequency check [0].

> But (looking at your change), ->get() can't really return 0. We depend
> on it to get us the exact frequency the hardware is programmed at
> instead of reading a cached value in the software.

Actually it can and it does currently. Note in tegra186_cpufreq_get()
the variable 'freq' is initialised to 0, and if no match is found, then
it returns 0. This is what happens currently on some Tegra186 boards.

>>> This would fix the problem I see on Tegra186
>> where the initial boot frequency may not be in the frequency table.
> 
> With current mainline, what's the problem you see now ? Sorry I missed
> track of it a bit :)

No problem, this has been an on-going saga now for sometime.

Cheers
Jon

[0]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/cpufreq/cpufreq.c#n1429
[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/cpufreq/tegra186-cpufreq.c#n95

-- 
nvpublic

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D069D298D57
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 13:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773358AbgJZM5L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 08:57:11 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8459 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1769233AbgJZM5L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 08:57:11 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f96c7ae0000>; Mon, 26 Oct 2020 05:57:18 -0700
Received: from [10.26.45.122] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 12:57:09 +0000
Subject: Re: [PATCH V2] cpufreq: tegra186: Fix initial frequency
From:   Jon Hunter <jonathanh@nvidia.com>
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
Message-ID: <c6ab92fe-e5ea-4568-6457-7a28c8496114@nvidia.com>
Date:   Mon, 26 Oct 2020 12:57:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9c37db70-9406-8005-3478-dc4a5e94c566@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603717038; bh=ksNzLqPs+U0EdGuNq1xOrbKFnEf3bcjA/ee9MYo5WzA=;
        h=Subject:From:To:CC:References:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=J16gu04SdEGV1qO2R1jKTmKzgUWZCz5o9jepWSQ7CS8OjzazfybO2S0oOZwgh+7+u
         h/cgEK4kbd7h3WoT788ulP9dvcWQ0YDMS11jGWOMBVYOm7iLK6kPJ2zeePHjH+g5sE
         bkXagLIZgC3TqptN5oOmjRdgKBsduJ20EIG4TIGlX7CzmTW5WQNCwPOWvxrB/zTiNn
         zfCHl8dhMhagO6EuF+08PGexQnNn33rqcuMZOVnWMLtk20nbq4Uhnf12bQbgMgqk+l
         cIdkLyouPyZlC9tGxym2gtxGyttKpq4kucThfmEKbr7CauRI1/JDy59Oz7HtRVKCIa
         tRxAQzMCeqfkQ==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 19/10/2020 10:33, Jon Hunter wrote:
> 
> On 16/10/2020 05:07, Viresh Kumar wrote:
>> On 15-10-20, 15:03, Jon Hunter wrote:
>>> If not too late, would you mind dropping this patch for v5.10?
>>
>> It is already part of Linus's master now.
> 
> OK, thanks. I will send a revert for this once rc1 is out.


Thinking about this some more, what are your thoughts on making the
following change? 

Basically, if the driver sets the CPUFREQ_NEED_INITIAL_FREQ_CHECK,
then I wonder if we should not fail if the frequency return by
>get() is not known. This would fix the problem I see on Tegra186
where the initial boot frequency may not be in the frequency table.

Cheers
Jon

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index f4b60663efe6..b7d3b61577b0 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1426,13 +1426,8 @@ static int cpufreq_online(unsigned int cpu)
                                CPUFREQ_CREATE_POLICY, policy);
        }
 
-       if (cpufreq_driver->get && has_target()) {
+       if (cpufreq_driver->get && has_target())
                policy->cur = cpufreq_driver->get(policy->cpu);
-               if (!policy->cur) {
-                       pr_err("%s: ->get() failed\n", __func__);
-                       goto out_destroy_policy;
-               }
-       }
 
        /*
         * Sometimes boot loaders set CPU frequency to a value outside of
@@ -1471,6 +1466,11 @@ static int cpufreq_online(unsigned int cpu)
                        pr_info("%s: CPU%d: Running at unlisted initial frequency: %u KHz, changing to: %u KHz\n",
                                __func__, policy->cpu, old_freq, policy->cur);
                }
+       } else {
+               if (!policy->cur) {
+                       pr_err("%s: ->get() failed\n", __func__);
+                       goto out_destroy_policy;
+               }
        }
 
        if (new_policy) {

-- 
nvpublic

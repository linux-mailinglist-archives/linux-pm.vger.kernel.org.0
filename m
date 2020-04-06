Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 427A819F03D
	for <lists+linux-pm@lfdr.de>; Mon,  6 Apr 2020 08:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgDFGGq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Apr 2020 02:06:46 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10673 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgDFGGq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2020 02:06:46 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e8ac6e80000>; Sun, 05 Apr 2020 23:06:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 05 Apr 2020 23:06:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 05 Apr 2020 23:06:45 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Apr
 2020 06:06:45 +0000
Received: from [10.24.37.103] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Apr 2020
 06:06:41 +0000
Subject: Re: [TEGRA194_CPUFREQ Patch v2 0/3] Add cpufreq driver for Tegra194
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rjw@rjwysocki.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bbasu@nvidia.com>,
        <mperttunen@nvidia.com>
References: <1586028547-14993-1-git-send-email-sumitg@nvidia.com>
 <20200406024726.sbtutqsv2t2p2gkg@vireshk-i7>
From:   sumitg <sumitg@nvidia.com>
Message-ID: <69c5a02d-994e-9141-3638-cbe08f5e112e@nvidia.com>
Date:   Mon, 6 Apr 2020 11:36:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200406024726.sbtutqsv2t2p2gkg@vireshk-i7>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586153192; bh=sFCRL5jNwqU2tlIogO1XkyF3JvM/cO2gFSLsQBV6B/8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=LL6O7RGdyl7OccZE4fMKyA+iqapaxHOOqyFPwcFfvNxe5vSpnh/5DHygZqXNP50Zi
         p2VKRAicqjVXIa4VeZ3iY608aPKnDYNtoHXQHMXtV3TzKZIPPhBxsJxmNBOakQilic
         ZkBPszNPHv1MW1fClh7dkmNY3MckRD4OjjzDO6qo4SbvXk6EygfUTmMe0MFRTgIwUi
         W8gssJzwEh/UZszzRF51Gde44RlNpb7MSVxzzUDQAwuO4csbmMqaClDlVqCoAXXmp6
         6KfAyNadN949RirBSJoJar4q66cCtxEkPvOm34WErDfMGP6Nexxm/bKDSfemNpmMdS
         YzVT7uraXZZ8w==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 06/04/20 8:17 AM, Viresh Kumar wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 05-04-20, 00:59, Sumit Gupta wrote:
>> The patch series adds cpufreq driver for Tegra194 SOC.
>>
>> v1[1] -> v2:
>> - Remove cpufreq_lock mutex from tegra194_cpufreq_set_target [Viresh].
>> - Remove CPUFREQ_ASYNC_NOTIFICATION flag [Viresh].
>> - Remove redundant _begin|end() call from tegra194_cpufreq_set_target.
>> - Rename opp_table to freq_table [Viresh].
> 
> Have we concluded the earlier discussion already ? I posted some
> questions where I had doubts and you just answered them and posted a
> new version. Please wait for the reviewers to have a chance to reply
> to them. Your new version may be okay, but still we can avoid another
> set of patches which may be wrong.
> 
> --
> viresh
> 
Sorry for that. I will wait for ongoing review to conclude before 
posting new version.
Thankyou for the inputs.

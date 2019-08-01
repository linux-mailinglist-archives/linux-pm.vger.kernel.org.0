Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C612B7E167
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 19:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387840AbfHARvk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 13:51:40 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17409 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfHARvk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 13:51:40 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4326ac0001>; Thu, 01 Aug 2019 10:51:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 01 Aug 2019 10:51:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 01 Aug 2019 10:51:39 -0700
Received: from [10.110.103.107] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 1 Aug
 2019 17:51:39 +0000
Subject: Re: [PATCH v7 11/20] cpufreq: tegra124: Add suspend and resume
 support
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <linus.walleij@linaro.org>,
        <stefan@agner.ch>, <mark.rutland@arm.com>,
        <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <jckuo@nvidia.com>,
        <josephl@nvidia.com>, <talho@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mperttunen@nvidia.com>, <spatra@nvidia.com>, <robh+dt@kernel.org>,
        <digetx@gmail.com>, <devicetree@vger.kernel.org>,
        <rjw@rjwysocki.net>, <linux-pm@vger.kernel.org>
References: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
 <1564607463-28802-12-git-send-email-skomatineni@nvidia.com>
 <20190801054055.trmabmcaj3cpe4pc@vireshk-i7>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <69aba3b2-d021-4851-d058-fcaa70446f58@nvidia.com>
Date:   Thu, 1 Aug 2019 10:51:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190801054055.trmabmcaj3cpe4pc@vireshk-i7>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564681900; bh=Ct87ksEmIdR3vDJq7VNh9iecFDiJ29H6vpg1zZvn58s=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=fxq7t7ocZFKQsJVsPDQ0pJMHSy1LAHJ68xmtpIvWxBZHqHTbBX+UuyEjtMDea8a0b
         3Ohyx64QDEiL9xywlp0T3+YtcEfKuGv9sh/R3nawxcFs7c441RxFi99975MHCTjsRU
         2mm5kBwiEmcLVbAsQy1QfWjsp/6s8seRAXi2UEZ2XdqwdozI996r3ynfSo+CWvuaDY
         59NYz1Aod4kbjTRxIxBPTk1xoSk13GMEHGuHZecuHuUVWr6fxeji4oe2V6DFTIbcrA
         P812jXGhUH/0mDTSCtivsa2vXQI6rShJ73nHkcuD33gyr11p8yI3ahyGUD/giz4878
         mF3Pgx7fpchvQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 7/31/19 10:40 PM, Viresh Kumar wrote:
> On 31-07-19, 14:10, Sowjanya Komatineni wrote:
>> This patch adds suspend and resume pm ops for cpufreq driver.
>>
>> PLLP is the safe clock source for CPU during system suspend and
>> resume as PLLP rate is below the CPU Fmax at Vmin.
>>
>> CPUFreq driver suspend switches the CPU clock source to PLLP and
>> disables the DFLL clock.
>>
>> During system resume, warmboot code powers up the CPU with PLLP
>> clock source. So CPUFreq driver resume enabled DFLL clock and
>> switches CPU back to DFLL clock source.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   drivers/cpufreq/tegra124-cpufreq.c | 60 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 60 insertions(+)
> Is there any hard dependency of this patch on the rest of the patches?
> Can I apply it alone to cpufreq tree ?
>
This patch cannot be applied alone as it has dependency on dfll clock 
suspend and resume sequence.

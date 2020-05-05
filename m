Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C332A1C4BD5
	for <lists+linux-pm@lfdr.de>; Tue,  5 May 2020 04:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgEECNF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 22:13:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46982 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726549AbgEECNF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 May 2020 22:13:05 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 49DE07E1D44437D1473C;
        Tue,  5 May 2020 10:13:03 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.101) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Tue, 5 May 2020
 10:12:55 +0800
Subject: Re: [RFC PATCH] cpufreq: add support for HiSilicon SoC HIP09
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <guohanjun@huawei.com>, <john.garry@huawei.com>
References: <1588227599-46438-1-git-send-email-wangxiongfeng2@huawei.com>
 <20200430095559.GB28579@bogus>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <84181382-2daf-b05f-ec46-278c1d5fe8a8@huawei.com>
Date:   Tue, 5 May 2020 10:12:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200430095559.GB28579@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.101]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sudeep,

Thanks for your reply.

On 2020/4/30 17:55, Sudeep Holla wrote:
> On Thu, Apr 30, 2020 at 02:19:59PM +0800, Xiongfeng Wang wrote:
>> HiSilicon SoC has a separate System Control Processor(SCP) dedicated for
>> clock frequency adjustment and has been using the cpufreq driver
>> 'cppc-cpufreq'. New HiSilicon SoC HIP09 add support for CPU Boost, but
>> ACPI CPPC doesn't support this. In HiSilicon SoC HIP09, each core has
>> its own clock domain. It is better for the core itself to adjust its
>> frequency when we require fast response. In this patch, we add a
>> separate cpufreq driver for HiSilicon SoC HIP09.
>>
> 
> I disagree with this approach unless you have tried to extend the CPPC
> in ACPI to accommodate this boost feature you need. Until you show those
> efforts and disagreement to do that from ASWG, I am NACKing this approach.

I will try to extend the CPPC to accommodate the CPU Boost feature.

Thanks,
Xiongfeng

> 
> --
> Regards,
> Sudeep
> 
> .
> 


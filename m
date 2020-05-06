Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628981C6D10
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 11:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgEFJhD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 05:37:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40032 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728640AbgEFJhD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 May 2020 05:37:03 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 75286179B7B14BBF5296;
        Wed,  6 May 2020 17:36:58 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.93) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 6 May 2020
 17:36:52 +0800
Subject: Re: [RFC PATCH] cpufreq: add support for HiSilicon SoC HIP09
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
CC:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <john.garry@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
References: <1588227599-46438-1-git-send-email-wangxiongfeng2@huawei.com>
 <20200430095559.GB28579@bogus>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <3ba950dd-4065-e4a5-d406-dc5c6c1781a7@huawei.com>
Date:   Wed, 6 May 2020 17:36:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200430095559.GB28579@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.213.93]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sudeep,

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

Unfortunately we are not in ASWG at now, could you please give some
help about extending CPPC in ACPI to support boost feature?

Thanks
Hanjun


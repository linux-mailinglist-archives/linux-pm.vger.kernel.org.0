Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F162312F70
	for <lists+linux-pm@lfdr.de>; Mon,  8 Feb 2021 11:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhBHKtX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Feb 2021 05:49:23 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12150 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbhBHKqA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2021 05:46:00 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DZ2gW6mNZz1658y;
        Mon,  8 Feb 2021 18:43:35 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Mon, 8 Feb 2021
 18:44:52 +0800
Subject: Re: [PATCH 1/4] driver core: Use subdir-ccflags-* to inherit debug
 flag
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <jdelvare@suse.com>, <linux@roeck-us.net>, <giometti@enneenne.com>,
        <abbotti@mev.co.uk>, <hsweeten@visionengravers.com>,
        <kw@linux.com>, <helgaas@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kbuild@vger.kernel.org>, <masahiroy@kernel.org>,
        <michal.lkml@markovi.net>, <linuxarm@openeuler.org>,
        <prime.zeng@huawei.com>
References: <1612518255-23052-1-git-send-email-yangyicong@hisilicon.com>
 <1612518255-23052-2-git-send-email-yangyicong@hisilicon.com>
 <YB0Vk6ERJ3lFc3WD@kroah.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <08017751-a1be-ea07-50de-73d14ab6d57e@hisilicon.com>
Date:   Mon, 8 Feb 2021 18:44:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YB0Vk6ERJ3lFc3WD@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Greg,

On 2021/2/5 17:53, Greg KH wrote:
> On Fri, Feb 05, 2021 at 05:44:12PM +0800, Yicong Yang wrote:
>> From: Junhao He <hejunhao2@hisilicon.com>
>>
>> Use subdir-ccflags-* instead of ccflags-* to inherit the debug
>> settings from Kconfig when traversing subdirectories.
> 
> That says what you do, but not _why_ you are doing it.

i'll illustrate the reason and reword the commit.

> 
> What does this offer in benefit of the existing way?  What is it fixing?
> Why do this "churn"?

currently we have added ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG in the Makefile
of driver/base and driver/base/power, but not in the subdirectory
driver/base/firmware_loader. we cannot turn the debug on for subdirectory
firmware_loader if we config DEBUG_DRIVER and there is no kconfig option
for the it.

as there is no other debug config in the subdirectory of driver/base,
CONFIG_DEBUG_DRIVER may also mean turn on the debug in the subdirectories, so use
subdir-ccflags-* instead for the -DDEBUG will allow us to enable debug for all
the subdirectories.

Thanks,
Yicong

> 
> thanks,
> 
> greg k-h
> 
> .
> 


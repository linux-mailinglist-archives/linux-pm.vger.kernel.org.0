Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138082C099F
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 14:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgKWNJz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 08:09:55 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16548 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733155AbgKWNJy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2020 08:09:54 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbbb4a70001>; Mon, 23 Nov 2020 05:09:59 -0800
Received: from [10.26.72.66] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov
 2020 13:09:52 +0000
Subject: Re: [RFC] PM Domains: Ensure the provider is resumed first
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <0e00f9ba-571a-23a0-7774-84f893ce6bd5@nvidia.com>
 <CAPDyKFrxKhO0V-uTDLDV6RFQFwhjesE0zfnuBLfYs-n5bNxXtg@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <35721978-d166-c5d9-06f6-45cec0d835ad@nvidia.com>
Date:   Mon, 23 Nov 2020 13:09:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrxKhO0V-uTDLDV6RFQFwhjesE0zfnuBLfYs-n5bNxXtg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606136999; bh=mUb4r/DR6yOR0tIUdYGVaS++Rrl9KBifgLFiXcAoglw=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=UD5zmNmoyvpeccXPDKSe69wMJjz3Ie2fN2aS+KFFoFceOU1AVFCC1X2Sonl9bPJiH
         7PxDl0gLs16WjLFSV+X7wCngKyyjMlPEcQvoz2Z6CSz1A3GdsNXKuaZh9JrJoPyViT
         CtsLKkrhx9dE2YPoztDqoSvLXievwBfUoW4QhYKM36Z5f6ToQIhFWv6Y25y2MTMR6B
         mqiMGOjhw3lstFC45t4VgqY8bcLYo/UbHqzpnyabE+DVs3qF4WzNSlAeo6O6fPlNE/
         PtU9oEXOf5Wp01TeAZYSJBrjyY+0dVHQZZCuhc/oWwFIZK0g6fenFLcgL7MCYQL2hP
         ErVtff/JFfjzg==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ulf,

On 19/11/2020 10:15, Ulf Hansson wrote:
> On Mon, 16 Nov 2020 at 17:17, Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>> Hi all,
>>
>> We recently ran into a problem on Tegra186 where it was failing to
>> resume from suspend. It turned out that a driver, the Tegra ACONNECT
>> (drivers/bus/tegra-aconnect.c), was being resumed before the PM domain
>> provider, the BPMP (drivers/firmware/tegra/bpmp.c), and the Tegra
>> ACONNECT was trying to enable the PM domain before the provider had been
>> resumed.
>>
>> According to commit 4d23a5e84806 it states that 'genpd powers on the PM
>> domain unconditionally in the system PM resume "noirq" phase'. However,
>> what I don't see is anything that guarantees that the provider is
>> resumed before any device that requires power domains. Unless there is
>> something that I am missing?
> 
> The genpd provider's ->power_on() callback should be invoked as soon
> as an attached device gets resumed via the ->resume_noirq() callback
> (genpd_resume_noirq). Have you verified that this is working as
> expected for you?

Yes this is working as expected. The problem is that the ->power_on
callback for a device is occurring before the provider itself has been
resumed.

> Note that, if there is no device attached to the genpd, the
> ->power_on() callback may not be invoked - unless there is a child
> domain being powered on.
> 
> From the genpd provider driver point of view - why do you need to
> implement system suspend/resume callbacks at all? Do you have some
> additional operations to run, besides those executed from the
> ->power_on|off() callbacks?

The provider in this case is an embedded controller, the BPMP, and it
needs to be resumed [0] prior to calling the provider callbacks. I am
wondering if any other providers have this requirement?

Thanks
Jon

[0]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/firmware/tegra/bpmp.c#n797

-- 
nvpublic

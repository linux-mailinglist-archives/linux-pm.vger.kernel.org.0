Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3EB3DBC10
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 06:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbfJREzE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 00:55:04 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14946 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfJREzE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 00:55:04 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da9427d0000>; Thu, 17 Oct 2019 21:41:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 17 Oct 2019 21:41:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 17 Oct 2019 21:41:22 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Oct
 2019 04:41:21 +0000
Received: from [10.110.48.28] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Oct
 2019 04:41:21 +0000
Subject: Re: [PATCH] cpufreq: powernv: fix stack bloat and NR_CPUS limitation
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-pm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
References: <20191018000431.1675281-1-jhubbard@nvidia.com>
 <20191018042715.f76bawmoyk66isap@vireshk-i7>
 <c3f16019-5724-a181-8068-8dda60fb67fa@nvidia.com>
 <20191018043856.srvgft6jhqw62bx3@vireshk-i7>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <a4a1467f-2c92-34f2-a8bf-718feaa17da7@nvidia.com>
Date:   Thu, 17 Oct 2019 21:41:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191018043856.srvgft6jhqw62bx3@vireshk-i7>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571373693; bh=eas1oqJi0RWep9NlG6nV2zlERS92z4dwuv5GLnpbgOg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=GqiDodTWJNjdDG4WLEe9RmzLCTLYMEcne1zcHzQSbeCI9XdFqhsgYnITm99Z9ABbX
         IMPoUVYk7vzAiwE99xIt1ryeG0/O9hOXvANQqZP5zqBDcj1wBRsyBq5LkNuPo3ivrW
         htFlD6qqxR/dRECFd5Sqe+ZBQ94Nbhof0TCuiqUyXQTLeVzKDw6xmXaProCPfT8PWO
         77mI6h0tUJN9oh1KZsGeak4PH1W1T70vAD0yUOt8ih8wOWihiUovQoFjbXbuMfSoL+
         KmL7K02KQEXgQwFY42GrzY9oTPy7HkC9FOWmGWdQK+yY7TUCypZgw7B5HuNikdkKdw
         ckLbTlj1EGQUA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/17/19 9:38 PM, Viresh Kumar wrote:
> On 17-10-19, 21:34, John Hubbard wrote:
>> On 10/17/19 9:27 PM, Viresh Kumar wrote:
>>> On 17-10-19, 17:04, John Hubbard wrote:
>>>> The following build warning occurred on powerpc 64-bit builds:
>>>>
>>>> drivers/cpufreq/powernv-cpufreq.c: In function 'init_chip_info':
>>>> drivers/cpufreq/powernv-cpufreq.c:1070:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>>>
>>> How come we are catching this warning after 4 years ?
>>>
>>
>> Newer compilers. And btw, I don't spend a lot of time in powerpc
>> code, so I just recently ran this, and I guess everyone has been on less
>> new compilers so far, it seems.
>>
>> I used a gcc 8.1 cross compiler in this case:
> 
> Hmm, okay.
> 
> I hope you haven't missed my actual review comments on your patch,
> just wanted to make sure we don't end up waiting for each other
> indefinitely here :)
> 

Ha, I did overlook those. It's late around here, I guess. :)

I'll send a v2 with those changes. 

thanks,

John Hubbard
NVIDIA

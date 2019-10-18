Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D17BDBC11
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 06:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbfJREzF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 00:55:05 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14945 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfJREzE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 00:55:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da940f00000>; Thu, 17 Oct 2019 21:34:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 17 Oct 2019 21:34:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 17 Oct 2019 21:34:45 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Oct
 2019 04:34:45 +0000
Received: from [10.110.48.28] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Oct
 2019 04:34:44 +0000
Subject: Re: [PATCH] cpufreq: powernv: fix stack bloat and NR_CPUS limitation
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Preeti U Murthy <preeti@linux.vnet.ibm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-pm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
References: <20191018000431.1675281-1-jhubbard@nvidia.com>
 <20191018042715.f76bawmoyk66isap@vireshk-i7>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <c3f16019-5724-a181-8068-8dda60fb67fa@nvidia.com>
Date:   Thu, 17 Oct 2019 21:34:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191018042715.f76bawmoyk66isap@vireshk-i7>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571373296; bh=Rx+GgSz5ZaCKM6ZVWjMWxWP6l9wESsNJ8Pg+CRriU3k=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=WlTTFGi+AW1cpVxLjrs3k8ct7IRcSwLMlcB1VoUvIgOvhpy0sZ7jLoFWyB5BHgNiM
         5wp7xLBwKA2KvbE5a57Ovnr0pgIO1B8wmxe5lOcpdzaChYnL4yshjN+bKWPDZdELEC
         y6g/otss4TxpEUxCddKfKfsIKq9efIPvw/Ac+RMdtQhpc7m5ha1SBpohR3cgEmKNp7
         RSvUEvFKLYIpfE+ObXISnyRzueh0vip+XorSEzzaVDrk2ubY10iIZQI7BXD/nQEtKB
         39GaFWZiltzh212WsM6Vk3/Qk4IZx+C+j1KSICJbrQZpJkhSU2WFJBOUBlfAgnglt9
         jNdFGP9PTB6PA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/17/19 9:27 PM, Viresh Kumar wrote:
> On 17-10-19, 17:04, John Hubbard wrote:
>> The following build warning occurred on powerpc 64-bit builds:
>>
>> drivers/cpufreq/powernv-cpufreq.c: In function 'init_chip_info':
>> drivers/cpufreq/powernv-cpufreq.c:1070:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> How come we are catching this warning after 4 years ?
> 

Newer compilers. And btw, I don't spend a lot of time in powerpc
code, so I just recently ran this, and I guess everyone has been on less
new compilers so far, it seems.

I used a gcc 8.1 cross compiler in this case:

$ $ /blue_exp/kernel/cross-compilers/powerpc64/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-gcc -v
Using built-in specs.
COLLECT_GCC=/blue_exp/kernel/cross-compilers/powerpc64/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-gcc
COLLECT_LTO_WRAPPER=/home/jhubbard/blue_exp/kernel/cross-compilers/powerpc64/gcc-8.1.0-nolibc/powerpc64-linux/bin/../libexec/gcc/powerpc64-linux/8.1.0/lto-wrapper
Target: powerpc64-linux
Configured with: /home/arnd/git/gcc/configure --target=powerpc64-linux --enable-targets=all --prefix=/home/arnd/cross/x86_64/gcc-8.1.0-nolibc/powerpc64-linux --enable-languages=c --without-headers --disable-bootstrap --disable-nls --disable-threads --disable-shared --disable-libmudflap --disable-libssp --disable-libgomp --disable-decimal-float --disable-libquadmath --disable-libatomic --disable-libcc1 --disable-libmpx --enable-checking=release
Thread model: single
gcc version 8.1.0 (GCC) 



thanks,

John Hubbard
NVIDIA


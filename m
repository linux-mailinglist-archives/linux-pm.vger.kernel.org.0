Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6C02D65C6
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 17:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733092AbfJNPCz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Oct 2019 11:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732566AbfJNPCz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Oct 2019 11:02:55 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69AFD2133F;
        Mon, 14 Oct 2019 15:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571065374;
        bh=xAz/E30ln4PaVxA2LxqmAdU7rS99ejibxgpoMmxFkVo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Pf/zweZKXSuPvzgFMmtNCTNSumUDU7Jtuw5EZievu7smrXdaOy62G8kU3j21PPLEU
         tf2iVUhQr1MLGUr1nG1c/BzqebzboMHSE99IRWkZh+JeFITczQZpWmMAW3SXwodK9Y
         4mGcNgsOEWSdPdoMjm5p8v4EcyXd0c50LPdjzVyU=
Subject: Re: [PATCH v2] cpupower : Handle set and info subcommands correctly
To:     Abhishek <huntbag@linux.vnet.ibm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trenn@suse.com, ego@linux.vnet.ibm.com, shuah <shuah@kernel.org>
References: <20190913080712.26383-1-huntbag@linux.vnet.ibm.com>
 <2614b112-5e19-96dc-179b-8d4e3b8c8858@kernel.org>
 <9f493ef7-8222-3e12-5068-41ea76e660a2@kernel.org>
 <b65b1063-941b-2838-4564-f6a6c40509c6@linux.vnet.ibm.com>
From:   shuah <shuah@kernel.org>
Message-ID: <64ac5ebd-ddc7-1563-bab9-ab3266279563@kernel.org>
Date:   Mon, 14 Oct 2019 09:02:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b65b1063-941b-2838-4564-f6a6c40509c6@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/14/19 3:38 AM, Abhishek wrote:
> Hi Shuah,
> 
> 
> On 10/04/2019 03:45 AM, shuah wrote:
>> Hi Abhishek,
>>
>> On 10/3/19 8:38 AM, shuah wrote:
>>> On 9/13/19 2:07 AM, Abhishek Goel wrote:
>>>> Cpupower tool has set and info options which are being used only by
>>>> x86 machines. This patch removes support for these two subcommands
>>>> from generic cpupower utility. Thus, these two subcommands will now be
>>>> available only for intel.
>>>> This removes the ambiguous error message while using set option in case
>>>> of using non-intel systems.
>>>>
>>>> Without this patch on a non-intel box:
>>>>
>>>> root@ubuntu:~# cpupower info
>>>> System does not support Intel's performance bias setting
>>>>
>>>> root@ubuntu:~# cpupower set -b 10
>>>> Error setting perf-bias value on CPU
>>>>
>>>> With this patch on a non-intel box:
>>>>
>>>> root@ubuntu:~# cpupower info
>>>> Supported commands are:
>>>>          frequency-info
>>>>          frequency-set
>>>>          idle-info
>>>>          idle-set
>>>>          monitor
>>>>          help
>>>>
>>>> Same result for set subcommand.
>>>>
>>>> This patch does not affect results on a intel box.
>>>>
>>>> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
>>>> Acked-by: Thomas Renninger <trenn@suse.de>
>>>> ---
>>>>
>>>> changes from v1:
>>>>     Instead of bailing out early in set and info commands, in V2, we
>>>>     are cutting out support for these two commands for non-intel
>>>>     systems.
>>>
>>> thanks. I will get this in for 5.4-rc3 veru likely. Definitely in 5.4
>>>
>>
>> Okay I almost applied this and decided it needs improvements.
>>
>> I don't like using #if defined(__x86_64__) || defined(__i386__)
>>
>> tools/power/cpupower/utils/cpupower.c main() already does this
>> dynamically using uname(). Please use the same logic do this,
>> instead of adding compile time code.
>>
>> thanks,
>> -- Shuah
> 
> Do you want the decision to be taken in cpupower-set and cpupower-info
> file as was done in v1 but using uname() by identifying the architecture
> there itself?
> 

As I recall my objection to the v1 was that it is making the call very
early and bails out. Ideally, I would like to see the change as part
of set/info handling and then print out appropriate message.

thanks,
-- Shuah

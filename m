Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23DC9CB1D3
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 00:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbfJCWPS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Oct 2019 18:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730297AbfJCWPS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 3 Oct 2019 18:15:18 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B673720867;
        Thu,  3 Oct 2019 22:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570140917;
        bh=Iwjv0cYSZTuQsc9KwzGWDMEOZCnt/5QZ+H4+pxuSkcw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=1XGiqxhQpiS8qJU1660yhorYGIMPs+gVEr2itAc63pnWSnmBTDVqJa9oP2/2vXnjb
         c9fWZbFmmI11v+l95/lUuQsXvjbSMwkH150Y3ibzlTYKaJLwlafkwOanpwQNN8CCAd
         izahV9qz0naHh4ZH3aSE7haoJp6xMTxEN5K9x2pQ=
Subject: Re: [PATCH v2] cpupower : Handle set and info subcommands correctly
To:     Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trenn@suse.com, ego@linux.vnet.ibm.com, shuah <shuah@kernel.org>
References: <20190913080712.26383-1-huntbag@linux.vnet.ibm.com>
 <2614b112-5e19-96dc-179b-8d4e3b8c8858@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <9f493ef7-8222-3e12-5068-41ea76e660a2@kernel.org>
Date:   Thu, 3 Oct 2019 16:15:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2614b112-5e19-96dc-179b-8d4e3b8c8858@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Abhishek,

On 10/3/19 8:38 AM, shuah wrote:
> On 9/13/19 2:07 AM, Abhishek Goel wrote:
>> Cpupower tool has set and info options which are being used only by
>> x86 machines. This patch removes support for these two subcommands
>> from generic cpupower utility. Thus, these two subcommands will now be
>> available only for intel.
>> This removes the ambiguous error message while using set option in case
>> of using non-intel systems.
>>
>> Without this patch on a non-intel box:
>>
>> root@ubuntu:~# cpupower info
>> System does not support Intel's performance bias setting
>>
>> root@ubuntu:~# cpupower set -b 10
>> Error setting perf-bias value on CPU
>>
>> With this patch on a non-intel box:
>>
>> root@ubuntu:~# cpupower info
>> Supported commands are:
>>          frequency-info
>>          frequency-set
>>          idle-info
>>          idle-set
>>          monitor
>>          help
>>
>> Same result for set subcommand.
>>
>> This patch does not affect results on a intel box.
>>
>> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
>> Acked-by: Thomas Renninger <trenn@suse.de>
>> ---
>>
>> changes from v1:
>>     Instead of bailing out early in set and info commands, in V2, we
>>     are cutting out support for these two commands for non-intel
>>     systems.
> 
> thanks. I will get this in for 5.4-rc3 veru likely. Definitely in 5.4
> 

Okay I almost applied this and decided it needs improvements.

I don't like using #if defined(__x86_64__) || defined(__i386__)

tools/power/cpupower/utils/cpupower.c main() already does this
dynamically using uname(). Please use the same logic do this,
instead of adding compile time code.

thanks,
-- Shuah

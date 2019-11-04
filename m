Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6E9BEE95F
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 21:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfKDUVN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 15:21:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:53530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbfKDUVN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 Nov 2019 15:21:13 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CAE32089C;
        Mon,  4 Nov 2019 20:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572898872;
        bh=/YukPhSH7HqflWK5cwwwvDNV+VAirsmpAmR47CbNn2M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RsSTXrm2hL2cdo5DFD5o3RshGmWojC9jUtrcCbRCOR9znnfPXQvKlcSOgqgGkDm29
         xYhG4oaB8YEdM5MyAKYspm0WS2WWrV7E43uD+9x1yMdbY1kBIcVfkET48VQdk4CBEM
         55P9wZcPZXBw+pspEgQHARRAVwY5ZmI0s4NzTEgs=
Subject: Re: [PATCHv2 0/3] Update cpupower and make it more accurate
To:     Thomas Renninger <trenn@suse.com>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        Borislav Petkov <bp@suse.de>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>, shuah <shuah@kernel.org>
References: <cover.1570819652.git.Janakarajan.Natarajan@amd.com>
 <ab5d732b-f322-0aeb-3970-99167afc177c@amd.com>
 <14300539.3gDY5kWNTU@skinner.arch.suse.de>
 <4a095339-82ab-54c7-4957-63d0338d122f@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <5c6eb321-7462-7458-a069-aa4919b39063@kernel.org>
Date:   Mon, 4 Nov 2019 13:21:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4a095339-82ab-54c7-4957-63d0338d122f@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/25/19 9:18 AM, shuah wrote:
> On 10/25/19 4:47 AM, Thomas Renninger wrote:
>> Hi,
>>
>> Removed: Pu Wen <puwen@hygon.com>
>>
>> On Tuesday, October 22, 2019 6:39:11 PM CEST Natarajan, Janakarajan 
>> wrote:
>>> On 10/11/2019 2:37 PM, Natarajan, Janakarajan wrote:
>>>
>>>> This patchset updates cpupower to make it more accurate by removing
>>>> the userspace to kernel transitions and read_msr initiated IPI delays.
>>
>> Acked-by: Thomas Renninger <trenn@suse.de>
>>
>> Shuan: If you do not object, it would be great if you can schedule these
>> to be included into Rafael's pm tree.
>>
> 
> I have no objections.
> 
>> It's a nice enhancement for these CPUs.
>> Doing it even nicer and more generic (per cpu measures) needs further
>> restructuring, but should not delay this any further.
>>
> 
> Thanks. I was waiting for you to Ack these before I pulled them in.
> I will get them in for 5.5-rc1
> 

Hi Janak,

All your patches fail Signed-off-by check.

WARNING: Missing Signed-off-by: line by nominal patch author 'Natarajan, 
Janakarajan <Janakarajan.Natarajan@amd.com>'

There is a mismatch between your From: and Signed-off-by names? Can you
fix these and resend all 4 patches.

thanks,
-- Shuah


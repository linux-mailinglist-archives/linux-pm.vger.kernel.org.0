Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DECC35D178
	for <lists+linux-pm@lfdr.de>; Mon, 12 Apr 2021 21:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238091AbhDLTv4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 15:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49576 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237946AbhDLTv4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Apr 2021 15:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618257097;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5P/eSXvLeEKIrDEUii8lpIPiiq4SsVgbm3uyEQEEKf4=;
        b=Ky68jKfxEgPpslZc1oSDAlVYMr4CJrkBvWoPx4BdzYHjEMcWQ4one/p18dOqUtaRjAtgPc
        y42r+Jn7WnMZYqE1n9c/glHC0WCwV6Io7ZWyHEl8up6G+kUO1lgzZV103ZEMuM4J37uCAi
        A6GY2jVZBWZi9mjHQtYVYuABq6tlQz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-GIGo0jZvNCeHf2gpe1YExQ-1; Mon, 12 Apr 2021 15:51:34 -0400
X-MC-Unique: GIGo0jZvNCeHf2gpe1YExQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1B7664157;
        Mon, 12 Apr 2021 19:51:32 +0000 (UTC)
Received: from crecklin.bos.csb (unknown [10.10.115.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5729E1002388;
        Mon, 12 Apr 2021 19:51:27 +0000 (UTC)
Reply-To: crecklin@redhat.com
Subject: Re: [PATCH v6 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
To:     Ard Biesheuvel <ardb@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     Simo Sorce <simo@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210412140932.31162-1-crecklin@redhat.com>
 <YHSHPIXLhHjOu0jw@gmail.com>
 <5795c815-7715-1ecb-dd83-65f3d18b9092@redhat.com>
 <YHSdgV6LIqSVxk+i@gmail.com>
 <CAMj1kXGZt8+5MVG-mNi67KsG8=4HCqEPs+RkrtzHusmCPFqSTg@mail.gmail.com>
From:   Chris von Recklinghausen <crecklin@redhat.com>
Organization: Red Hat
Message-ID: <862c8208-5809-9726-7e22-7a16fcd30edd@redhat.com>
Date:   Mon, 12 Apr 2021 15:51:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXGZt8+5MVG-mNi67KsG8=4HCqEPs+RkrtzHusmCPFqSTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/12/21 3:27 PM, Ard Biesheuvel wrote:
> On Mon, 12 Apr 2021 at 21:20, Eric Biggers <ebiggers@kernel.org> wrote:
>> On Mon, Apr 12, 2021 at 03:04:58PM -0400, Chris von Recklinghausen wrote:
>>> On 4/12/21 1:45 PM, Eric Biggers wrote:
>>>> On Mon, Apr 12, 2021 at 10:09:32AM -0400, Chris von Recklinghausen wrote:
>>>>> Suspend fails on a system in fips mode because md5 is used for the e820
>>>>> integrity check and is not available. Use crc32 instead.
>>>>>
>>>>> This patch changes the integrity check algorithm from md5 to crc32.
>>>>>
>>>>> The purpose of the integrity check is to detect possible differences
>>>>> between the memory map used at the time when the hibernation image is
>>>>> about to be loaded into memory and the memory map used at the image
>>>>> creation time, because it is generally unsafe to load the image if the
>>>>> current memory map doesn't match the one used when it was created. so
>>>>> it is not intended as a cryptographic integrity check.
>>>> This still doesn't actually explain why a non-cryptographic checksum is
>>>> sufficient.  "Detection of possible differences" could very well require
>>>> cryptographic authentication; it depends on whether malicious changes need to be
>>>> detected or not.
>>> Hi Eric,
>>>
>>> The cases that the commit comments for 62a03defeabd mention are the same as
>>> for this patch, e.g.
>>>
>>>      1. Without this patch applied, it is possible that BIOS has
>>>         provided an inconsistent memory map, but the resume kernel is still
>>>         able to restore the image anyway(e.g, E820_RAM region is the superset
>>>         of the previous one), although the system might be unstable. So this
>>>         patch tries to treat any inconsistent e820 as illegal.
>>>
>>>      2. Another case is, this patch replies on comparing the e820_saved, but
>>>         currently the e820_save might not be strictly the same across
>>>         hibernation, even if BIOS has provided consistent e820 map - In
>>>         theory mptable might modify the BIOS-provided e820_saved dynamically
>>>         in early_reserve_e820_mpc_new, which would allocate a buffer from
>>>         E820_RAM, and marks it from E820_RAM to E820_RESERVED).
>>>         This is a potential and rare case we need to deal with in OS in
>>>         the future.
>>>
>>> Maybe they should be added to the comments with this patch as well? In any
>>> case, the above comments only mention detecting consequences of BIOS
>>> issues/actions on the e820 map and not intrusions from attackers requiring
>>> cryptographic protection. Does that seem to be a reasonable explanation to
>>> you? If so I can add these to the commit comments.
>>>
>>> I'll make the other changes you suggest below.
>>>
>>> Thanks,
>>>
>> Those details are still missing the high-level point.  Is this just meant to
>> detect non-malicious changes (presumably caused by BIOS bugs), or is it meant to
>> detect malicious changes?  That's all that really needs to be mentioned.
>>
> This is not about BIOS bugs. Hibernation is deep suspend/resume
> grafted onto cold boot, and it is perfectly legal for the firmware to
> present a different memory map to the OS after a cold boot. It is
> Linux that decides that it can restore the entire system state from a
> swap file, and carry on as if the cold boot was just a [firmware
> assisted] suspend/resume.
>
> So forging collisions is *not* a concern here. Let's avoid accidental
> or malicious, as those adjectives seem to confuse some people. The
> bottom line is that there is no need to protect against deliberate
> attempts to hide the fact that the memory map has changed, and so
> there is no reason to use cryptographic hashes here.
>
How about :

The check is intended to differentiate between a resume (which expects 
an identical e820 map to the one saved in suspend), and a cold boot 
(which need not have an identical e820 map to that saved in suspend if 
any was done at all). It is not necessary here to protect against 
deliberate attempts to hide the fact that the memory map has changed, so 
crc32 is sufficient for detection.



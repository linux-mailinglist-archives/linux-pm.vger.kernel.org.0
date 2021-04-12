Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB95635D0BD
	for <lists+linux-pm@lfdr.de>; Mon, 12 Apr 2021 21:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236894AbhDLTF2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 15:05:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33929 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236781AbhDLTF1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Apr 2021 15:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618254308;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TJqhZf/Gn6rZQI95LxJC4/D4og7tmZxsd/cajSd6aPo=;
        b=X34EHJlUi3YNpD+uTvsrjJaUDiXgO7mtepxkDp+57hMIdHcN3jYHjM453foJpPAItnW0nW
        haQZQBsxpjZIbTbmrLImRfzcgshZn+Cxs7zwFFefV2kIuaePwsQ9RegnVRD03EaWNOI6Af
        wTAUDudIIEyMzQLo/4FznsWAw5uCZMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-eL2jf2qpOz65GDl7l0qh9Q-1; Mon, 12 Apr 2021 15:05:04 -0400
X-MC-Unique: eL2jf2qpOz65GDl7l0qh9Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B0218189C7;
        Mon, 12 Apr 2021 19:05:03 +0000 (UTC)
Received: from crecklin.bos.csb (unknown [10.10.115.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D30315C1C2;
        Mon, 12 Apr 2021 19:04:58 +0000 (UTC)
Reply-To: crecklin@redhat.com
Subject: Re: [PATCH v6 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ardb@kernel.org, simo@redhat.com, rafael@kernel.org,
        decui@microsoft.com, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210412140932.31162-1-crecklin@redhat.com>
 <YHSHPIXLhHjOu0jw@gmail.com>
From:   Chris von Recklinghausen <crecklin@redhat.com>
Organization: Red Hat
Message-ID: <5795c815-7715-1ecb-dd83-65f3d18b9092@redhat.com>
Date:   Mon, 12 Apr 2021 15:04:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YHSHPIXLhHjOu0jw@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/12/21 1:45 PM, Eric Biggers wrote:
> On Mon, Apr 12, 2021 at 10:09:32AM -0400, Chris von Recklinghausen wrote:
>> Suspend fails on a system in fips mode because md5 is used for the e820
>> integrity check and is not available. Use crc32 instead.
>>
>> This patch changes the integrity check algorithm from md5 to crc32.
>>
>> The purpose of the integrity check is to detect possible differences
>> between the memory map used at the time when the hibernation image is
>> about to be loaded into memory and the memory map used at the image
>> creation time, because it is generally unsafe to load the image if the
>> current memory map doesn't match the one used when it was created. so
>> it is not intended as a cryptographic integrity check.
> This still doesn't actually explain why a non-cryptographic checksum is
> sufficient.  "Detection of possible differences" could very well require
> cryptographic authentication; it depends on whether malicious changes need to be
> detected or not.

Hi Eric,

The cases that the commit comments for 62a03defeabd mention are the same 
as for this patch, e.g.

     1. Without this patch applied, it is possible that BIOS has
        provided an inconsistent memory map, but the resume kernel is still
        able to restore the image anyway(e.g, E820_RAM region is the 
superset
        of the previous one), although the system might be unstable. So this
        patch tries to treat any inconsistent e820 as illegal.

     2. Another case is, this patch replies on comparing the e820_saved, but
        currently the e820_save might not be strictly the same across
        hibernation, even if BIOS has provided consistent e820 map - In
        theory mptable might modify the BIOS-provided e820_saved dynamically
        in early_reserve_e820_mpc_new, which would allocate a buffer from
        E820_RAM, and marks it from E820_RAM to E820_RESERVED).
        This is a potential and rare case we need to deal with in OS in
        the future.

Maybe they should be added to the comments with this patch as well? In 
any case, the above comments only mention detecting consequences of BIOS 
issues/actions on the e820 map and not intrusions from attackers 
requiring cryptographic protection. Does that seem to be a reasonable 
explanation to you? If so I can add these to the commit comments.

I'll make the other changes you suggest below.

Thanks,

Chris

>
>> Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memory map
>>         by md5 digest")
>>
>> Signed-off-by: Chris von Recklinghausen <crecklin@redhat.com>
>> ---
>> v1 -> v2
>>     bump up RESTORE_MAGIC
>> v2 -> v3
>>     move embelishment from cover letter to commit comments (no code change)
>> v3 -> v4
>>     add note to comments that md5 isn't used for encryption here.
>> v4 -> v5
>>     reword comment per Simo's suggestion
>> v5 -> v6
>>     use wording from Eric Biggers, use crc32_le instead of crc32 from crypto
>> 	framework (crc32_le is in the core API and removes need for #defines)
>>
>>   arch/x86/power/hibernate.c | 76 +++++++++++---------------------------
>>   1 file changed, 22 insertions(+), 54 deletions(-)
>>
>> diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
>> index cd3914fc9f3d..f39e507e34ca 100644
>> --- a/arch/x86/power/hibernate.c
>> +++ b/arch/x86/power/hibernate.c
>> @@ -13,6 +13,8 @@
>>   #include <linux/kdebug.h>
>>   #include <linux/cpu.h>
>>   #include <linux/pgtable.h>
>> +#include <linux/types.h>
>> +#include <linux/crc32.h>
>>   
>>   #include <crypto/hash.h>
> crypto/hash.h is no longer needed.
>
>>   
>> @@ -55,94 +57,60 @@ int pfn_is_nosave(unsigned long pfn)
>>   }
>>   
>>   
>> -#define MD5_DIGEST_SIZE 16
>> +#define CRC32_DIGEST_SIZE (sizeof (u32))
>>   
>>   struct restore_data_record {
>>   	unsigned long jump_address;
>>   	unsigned long jump_address_phys;
>>   	unsigned long cr3;
>>   	unsigned long magic;
>> -	u8 e820_digest[MD5_DIGEST_SIZE];
>> +	u8 e820_digest[CRC32_DIGEST_SIZE];
>>   };
> It would be simpler to just make this field 'unsigned long'.  Then there would
> be no need to deal with memcpy().
>
>> -#if IS_BUILTIN(CONFIG_CRYPTO_MD5)
>>   /**
>> - * get_e820_md5 - calculate md5 according to given e820 table
>> + * get_e820_crc32 - calculate crc32 according to given e820 table
> Calling this "compute_e820_crc32()" would avoid confusion with retrieving the
> previously-stored crc32 value.
>
>> +	ret = crc32_le(0, (unsigned char const *)table, size);
> It would be better to do ~crc32_le(~0, ...) (i.e., invert at beginning and end)
> to match the recommended usage of CRC-32.  Unfortunately the library function
> doesn't do the inversions by default.
>
>>   static int hibernation_e820_save(void *buf)
>>   {
>> -	return get_e820_md5(e820_table_firmware, buf);
>> +	return get_e820_crc32(e820_table_firmware, buf);
>>   }
> This should be inlined into arch_hibernation_header_save().  Also note that it
> can no longer fail.
>
>>   
>>   static bool hibernation_e820_mismatch(void *buf)
>>   {
> This should be inlined into arch_hibernation_header_restore().
>
>>   	int ret;
>> -	u8 result[MD5_DIGEST_SIZE];
>> +	u8 result[CRC32_DIGEST_SIZE];
>>   
>> -	memset(result, 0, MD5_DIGEST_SIZE);
>> +	memset(result, 0, CRC32_DIGEST_SIZE);
>>   	/* If there is no digest in suspend kernel, let it go. */
>> -	if (!memcmp(result, buf, MD5_DIGEST_SIZE))
>> +	if (!memcmp(result, buf, CRC32_DIGEST_SIZE))
>>   		return false;
> There's no need to handle the "no digest" case anymore, right?  Since crc32_le()
> is always available.
>
> - Eric
>


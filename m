Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587B23588EA
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 17:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhDHPyQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 11:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231712AbhDHPyQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 11:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617897244;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xg9rgRtLAeC6gfM/QTN+VrsrAKKycaTO24jDSl5FrIc=;
        b=ajbaZ2nzmzl7DvMUkG1PSO2SCxnkx7IT+dDtS4yjJyXXRbqmDRWD/WnN5CSlpYQNZv4N22
        rXPf9kwj7OQPDgptuoXeqd/1vv1C2t61qVff4O7iw5zMdIy3p57XsSu6krmPXN5riZlFIL
        za8/eOPXSP8ejzTgFTeBWTDNlpbqwBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-kZI-u5BiOs-r3PVH4lCAeA-1; Thu, 08 Apr 2021 11:54:02 -0400
X-MC-Unique: kZI-u5BiOs-r3PVH4lCAeA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBBF5106BC9A;
        Thu,  8 Apr 2021 15:54:00 +0000 (UTC)
Received: from crecklin.bos.csb (ovpn-113-158.rdu2.redhat.com [10.10.113.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 064314DA32;
        Thu,  8 Apr 2021 15:53:59 +0000 (UTC)
Reply-To: crecklin@redhat.com
Subject: Re: [PATCH v5 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ardb@kernel.org, simo@redhat.com, rafael@kernel.org,
        decui@microsoft.com, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210408131506.17941-1-crecklin@redhat.com>
 <YG8hgzBPQAvov9Vz@sol.localdomain>
From:   Chris von Recklinghausen <crecklin@redhat.com>
Organization: Red Hat
Message-ID: <f01021a0-2edd-da43-5f04-043b4f42be8b@redhat.com>
Date:   Thu, 8 Apr 2021 11:53:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YG8hgzBPQAvov9Vz@sol.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/8/21 11:30 AM, Eric Biggers wrote:
> On Thu, Apr 08, 2021 at 09:15:06AM -0400, Chris von Recklinghausen wrote:
>> Suspend fails on a system in fips mode because md5 is used for the e820
>> integrity check and is not available. Use crc32 instead.
>>
>> This patch changes the integrity check algorithm from md5 to
>> crc32. This integrity check is used only to verify accidental
>> corruption of the hybernation data and is not intended as a
>> cryptographic integrity check.
>> Md5 is overkill in this case and also disabled in FIPS mode because it
>> is known to be broken for cryptographic purposes.
>>
>> Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memory map
>>         by md5 digest")
>>
>> Tested-by: Dexuan Cui <decui@microsoft.com>
>> Reviewed-by: Dexuan Cui <decui@microsoft.com>
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
>>
>>   arch/x86/power/hibernate.c | 35 +++++++++++++++++++----------------
>>   1 file changed, 19 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
>> index cd3914fc9f3d..b56172553275 100644
>> --- a/arch/x86/power/hibernate.c
>> +++ b/arch/x86/power/hibernate.c
>> @@ -55,31 +55,31 @@ int pfn_is_nosave(unsigned long pfn)
>>   }
>>   
>>   
>> -#define MD5_DIGEST_SIZE 16
>> +#define CRC32_DIGEST_SIZE 16
>>   
>>   struct restore_data_record {
>>   	unsigned long jump_address;
>>   	unsigned long jump_address_phys;
>>   	unsigned long cr3;
>>   	unsigned long magic;
>> -	u8 e820_digest[MD5_DIGEST_SIZE];
>> +	u8 e820_digest[CRC32_DIGEST_SIZE];
>>   };
>>   
>> -#if IS_BUILTIN(CONFIG_CRYPTO_MD5)
>> +#if IS_BUILTIN(CONFIG_CRYPTO_CRC32)
> Should CONFIG_CRYPTO_CRC32 be getting selected from somewhere?


Yes, presumably from the same source that sets CONFIG_CRYPTO_MD5. Also 
presumably there's value to not forcing the check if the config value is 
not set.


>
> If that is too hard because it would pull in too much of the crypto API, maybe
> using the library interface to CRC-32 (lib/crc32.c) would be a better fit?


Based on my statement above, the intent is to provide a simple drop in 
replacement for md5 so that users of FIPS mode can suspend/resume 
without any errors.

Thanks,

Chris


>
> - Eric
>


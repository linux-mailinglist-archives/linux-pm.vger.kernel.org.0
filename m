Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E4835A720
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 21:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbhDIT2j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 15:28:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27985 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234887AbhDIT2h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Apr 2021 15:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617996504;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gtQRyJkei76MgWJGNFUnR7KOo7QbxlHYKJLaZxgsRec=;
        b=dN1JdqjwSzrJHiZXkmw5O7rc4eVrfHEtj9F4nl4N6E5uU8Gq4H1iHjChAXpb5qZpG61cAj
        EQBRi0EKFQNRR21ve/2Wk4NNSAOenKjJhPpylDw19lyDLzIdMAoTR81z7S2iTf+QXyjbCx
        +3jHS4kKxWm3TLkVquf0sJXicpJd1os=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-z8sidzyZP0CHhR2Aqn2ACg-1; Fri, 09 Apr 2021 15:28:22 -0400
X-MC-Unique: z8sidzyZP0CHhR2Aqn2ACg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 102BB1008062;
        Fri,  9 Apr 2021 19:28:21 +0000 (UTC)
Received: from crecklin.bos.csb (ovpn-113-158.rdu2.redhat.com [10.10.113.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1A7019704;
        Fri,  9 Apr 2021 19:28:15 +0000 (UTC)
Reply-To: crecklin@redhat.com
Subject: Re: [PATCH v4 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
To:     David Laight <David.Laight@ACULAB.COM>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "simo@redhat.com" <simo@redhat.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "decui@microsoft.com" <decui@microsoft.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210408104629.31357-1-crecklin@redhat.com>
 <6be63531313d46caa7161697bf240dfc@AcuMS.aculab.com>
From:   Chris von Recklinghausen <crecklin@redhat.com>
Organization: Red Hat
Message-ID: <822eaebf-4ef9-d469-4238-54107c8ba6a6@redhat.com>
Date:   Fri, 9 Apr 2021 15:28:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <6be63531313d46caa7161697bf240dfc@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/9/21 12:56 PM, David Laight wrote:
> From: Chris von Recklinghausen
>> Sent: 08 April 2021 11:46
>>
>> Suspend fails on a system in fips mode because md5 is used for the e820
>> integrity check and is not available. Use crc32 instead.
>>
>> Prior to this patch, MD5 is used only to create a digest to ensure integrity of
>> the region, no actual encryption is done. This patch set changes the integrity
>> check to use crc32 instead of md5 since crc32 is available in both FIPS and
>> non-FIPS modes.
>>
>> Note that the digest is only used as an integrity check. No actual encryption
>> is done.
> If crc32 is good enough, would a 1's compliment sum be good enough?
> It is likely to be faster to calculate and not need special
> functions be built into the kernel at all.


Eric Biggers <ebiggers@kernel.org> suggested using crc32_le() which is 
in the library interface (lib/crc32.c) and will always be available 
without any special ifdefs. That's what my next version will be based on.

Thanks,

Chris


>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>


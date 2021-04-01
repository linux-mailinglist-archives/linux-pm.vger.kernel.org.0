Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A45C351A30
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 20:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbhDAR6g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 13:58:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52315 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234376AbhDAR4S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 13:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617299776;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a0Q1VkfOZIavvpczXjt7TZjbwwjRT1qxWEncvyA0WC8=;
        b=NDMaGp3Mj1AzVqhj6dk2OE8BIStjC+yAYFSxc5Lhp4xNg/4EaxYYmS9YRQEjoJPv4KKBZB
        oMNCJJkk6E5AfaBRrFqhbYFdbrD4AQVp2G72pEezeLfFMOFkRhbEpO8+BUP8ih2CyQEYaw
        8n3bRqibmYYE9+TmO+Af1bqvULDpzgs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-bTpy2vqsPHWKDQ6nxtplsw-1; Thu, 01 Apr 2021 09:54:45 -0400
X-MC-Unique: bTpy2vqsPHWKDQ6nxtplsw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC44A1018F95;
        Thu,  1 Apr 2021 13:54:23 +0000 (UTC)
Received: from crecklin.bos.csb (unknown [10.22.8.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FA865D9CC;
        Thu,  1 Apr 2021 13:54:21 +0000 (UTC)
Reply-To: crecklin@redhat.com
Subject: Re: Fix hibernation in FIPS mode?
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Simo Sorce <simo@redhat.com>, Dexuan Cui <decui@microsoft.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <MW2PR2101MB08924CD74C6EB773C4D5FAFDBF7E9@MW2PR2101MB0892.namprd21.prod.outlook.com>
 <CAJZ5v0g+=AnRAmAAn8NpHm8bmZ1WkwDpjb5rr_zPOVABW1PYug@mail.gmail.com>
 <4e95307db43e2f7cc8516e645b81db7db0dd8ad4.camel@redhat.com>
 <CAMj1kXHg2RDgwmOhJkaAPoWeHpxnd6tixp94Kha1-bzNvCaQUg@mail.gmail.com>
 <504652e70f0a4e42e4927583b9ed47cd78590329.camel@redhat.com>
 <CAMj1kXHRduBs0TJcLC4iMkyoGXyyrXPM_WpVVij33ki8THf9Kw@mail.gmail.com>
 <CAJZ5v0hKPBtUzGKfGHD6KX-c2QEETfatCkNjCK8ukh-AhVfUhA@mail.gmail.com>
From:   Chris von Recklinghausen <crecklin@redhat.com>
Organization: Red Hat
Message-ID: <2b452865-ca6c-892d-f04e-3e6e2a74b598@redhat.com>
Date:   Thu, 1 Apr 2021 09:54:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hKPBtUzGKfGHD6KX-c2QEETfatCkNjCK8ukh-AhVfUhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/1/21 9:38 AM, Rafael J. Wysocki wrote:
> On Thu, Apr 1, 2021 at 10:47 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>> On Tue, 30 Mar 2021 at 21:56, Simo Sorce <simo@redhat.com> wrote:
>>> On Tue, 2021-03-30 at 21:45 +0200, Ard Biesheuvel wrote:
>>>> On Tue, 30 Mar 2021 at 20:05, Simo Sorce <simo@redhat.com> wrote:
>>>>> On Tue, 2021-03-30 at 16:46 +0200, Rafael J. Wysocki wrote:
>>>>>> On Tue, Mar 30, 2021 at 12:14 AM Dexuan Cui <decui@microsoft.com> wrote:
>>>>>>> Hi,
>>>>>>> MD5 was marked incompliant with FIPS in 2009:
>>>>>>> a3bef3a31a19 ("crypto: testmgr - Skip algs not flagged fips_allowed in fips mode")
>>>>>>> a1915d51e8e7 ("crypto: testmgr - Mark algs allowed in fips mode")
>>>>>>>
>>>>>>> But hibernation_e820_save() is still using MD5, and fails in FIPS mode
>>>>>>> due to the 2018 patch:
>>>>>>> 749fa17093ff ("PM / hibernate: Check the success of generating md5 digest before hibernation")
>>>>>>>
>>>>>>> As a result, hibernation doesn't work when FIPS is on.
>>>>>>>
>>>>>>> Do you think if hibernation_e820_save() should be changed to use a
>>>>>>> FIPS-compliant algorithm like SHA-1?
>>>>>> I would say yes, it should.
>>>>>>
>>>>>>> PS, currently it looks like FIPS mode is broken in the mainline:
>>>>>>> https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg49414.html
>>>>> FYI, SHA-1 is not a good choice, it is only permitted in HMAC
>>>>> constructions and only for specified uses. If you need to change
>>>>> algorithm you should go straight to SHA-2 or SHA-3 based hashes.
>>>>>
>>>> What is the reason for using a [broken] cryptographic hash here? if
>>>> this is just an integrity check, better use CRC32
> Not really.
>
> CRC32 is not really sufficient for integrity checking here AFAICS.  It
> might be made a fallback option if MD5 is not available, but making it
> the default would be somewhat over the top IMO.


Would ghash be a better choice? It produces the same size digest as md5.

Does anyone have any other suggestions of algorithms to try?

Thanks,

Chris

>
>>> If the integrity check is used exclusively to verify there were no
>>> accidental changes and is not used as a security measure, by all means
>>> I agree that using crc32 is a better idea.
>>>
>> Looking at 62a03defeabd58f74e07ca030d6c21e069d4d88e which introduced
>> this, it is only a best effort check which is simply omitted if md5
>> happens to be unavailable, so there is definitely no need for crypto
>> here.
> Yes, it is about integrity checking only.  No, CRC32 is not equivalent
> to MD5 in that respect AFAICS.
>
> Thanks!
>


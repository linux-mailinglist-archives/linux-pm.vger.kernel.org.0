Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D4934EB19
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 16:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhC3OwM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Mar 2021 10:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232064AbhC3Ovz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Mar 2021 10:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617115914;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJVm+BmDLZgTWR3iPU4bINy5jGu0DH6bKNz0lNZl+3Q=;
        b=Xf0sYMoLVX7S77QilXAyBWokCldKRbDN2erDs4Osa0Ne0qfHIQNaRqf64vB+VkocBMxFd2
        JLlEz/IO14eRMoaPYj9Kg+SwukbPSjJPyvZIA8ZARCIeJV+B85eJnpQf3y9CxIzstkkRjq
        1YFLzNTN9U4cvnqCSw13Faeyg9olfk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-JaTNFoPKMVSSWsWfcIgTnw-1; Tue, 30 Mar 2021 10:51:50 -0400
X-MC-Unique: JaTNFoPKMVSSWsWfcIgTnw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7F96802B40;
        Tue, 30 Mar 2021 14:51:48 +0000 (UTC)
Received: from crecklin.bos.csb (unknown [10.22.8.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16C8E19C44;
        Tue, 30 Mar 2021 14:51:48 +0000 (UTC)
Reply-To: crecklin@redhat.com
Subject: Re: Fix hibernation in FIPS mode?
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <MW2PR2101MB08924CD74C6EB773C4D5FAFDBF7E9@MW2PR2101MB0892.namprd21.prod.outlook.com>
 <CAJZ5v0g+=AnRAmAAn8NpHm8bmZ1WkwDpjb5rr_zPOVABW1PYug@mail.gmail.com>
From:   Chris von Recklinghausen <crecklin@redhat.com>
Organization: Red Hat
Message-ID: <c5524a2e-a405-e3a5-c68e-b74953a2f8a8@redhat.com>
Date:   Tue, 30 Mar 2021 10:51:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0g+=AnRAmAAn8NpHm8bmZ1WkwDpjb5rr_zPOVABW1PYug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/30/21 10:46 AM, Rafael J. Wysocki wrote:
> On Tue, Mar 30, 2021 at 12:14 AM Dexuan Cui <decui@microsoft.com> wrote:
>> Hi,
>> MD5 was marked incompliant with FIPS in 2009:
>> a3bef3a31a19 ("crypto: testmgr - Skip algs not flagged fips_allowed in fips mode")
>> a1915d51e8e7 ("crypto: testmgr - Mark algs allowed in fips mode")
>>
>> But hibernation_e820_save() is still using MD5, and fails in FIPS mode
>> due to the 2018 patch:
>> 749fa17093ff ("PM / hibernate: Check the success of generating md5 digest before hibernation")
>>
>> As a result, hibernation doesn't work when FIPS is on.
>>
>> Do you think if hibernation_e820_save() should be changed to use a
>> FIPS-compliant algorithm like SHA-1?
> I would say yes, it should.


If we're not actually encrypting anything, shouldn't something like 
ghash work as well?


>
>> PS, currently it looks like FIPS mode is broken in the mainline:
>> https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg49414.html



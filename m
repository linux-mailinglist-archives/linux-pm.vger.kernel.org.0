Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A74A2F6279
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 14:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbhANN4A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 08:56:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55834 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725961AbhANN4A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2021 08:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610632473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ryoOglCNSLZKerbJh3Xkw7k8AxCpZZuHlo1F5IbNO+s=;
        b=E5eDOar90KAggikS2lfvkXFVI50T+GOkZdoiKVCKt+j2vhf7CqeCDAsoRlm0Nbu91sZi7Z
        GSG76SgegZQNVr69rF1XYjgIHgKHdteLJCtQIJ5wcW3CglsgE+4KhOysRdsjIXggz47KUk
        GmsKRiqTclBWmddF5Hl8Im6XPRTietw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-DTLPCR4hMoGwrG5mzmQ5_w-1; Thu, 14 Jan 2021 08:54:31 -0500
X-MC-Unique: DTLPCR4hMoGwrG5mzmQ5_w-1
Received: by mail-ej1-f71.google.com with SMTP id gu19so2239861ejb.13
        for <linux-pm@vger.kernel.org>; Thu, 14 Jan 2021 05:54:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ryoOglCNSLZKerbJh3Xkw7k8AxCpZZuHlo1F5IbNO+s=;
        b=d/RN0t+pMqadbkpIKhuxKA459asAJGnlVAnwQ8aO0bZe4C0mPcIA2PCVxQVDj/j42t
         LI1PqDB3fSHXJlKLfmV1abZ//rTxsHeHSw0WbcR6aszte+KXxbS3E/MhFoXLvDNRmEsq
         t7T6VbI7YdtKGgoxUs2hkwBt0Ji+GV5BfjeTi6cyHxv1aBtySdfliHJio7exdNKawB2a
         akhwYWPk+OUk2HOi2dnlCO8+VNq3Zba1bd5wlKZ66TvFy5syvzGzQzT6CF/9Xn5t3Hdn
         68dPxNvbmAn9vNqpHfQP8Q04UrI5bbG/JoKCPbG7yemzkQuBgRoTptZauImk96dAP2rB
         nTbg==
X-Gm-Message-State: AOAM5331sCZ39M7hmjS9kzw7pJ30Up4fgq4HyRluyoX257jyvg01dQj1
        2fNyao+NrRF6rqvBcLQskkAUQNRkFLQCmhCaaYksVFpv/ghw2Tv9DL9EdE0JN+BQytrAUEeWU3u
        2Ur4dC9qeXe0G92yJjJw=
X-Received: by 2002:a50:d484:: with SMTP id s4mr5781712edi.13.1610632470569;
        Thu, 14 Jan 2021 05:54:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygBY08/YQ6p30Im+zPLZ8WC+iEM9WduwmbG+NuTLdmHslDc7f+5HnRQvjtTSg7FoUtjRwsSA==
X-Received: by 2002:a50:d484:: with SMTP id s4mr5781701edi.13.1610632470402;
        Thu, 14 Jan 2021 05:54:30 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id h12sm1982788eja.113.2021.01.14.05.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 05:54:29 -0800 (PST)
Subject: Re: [PATCH RESEND 1/2] ACPI: platform-profile: Drop const qualifier
 for cur_profile
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20210114073429.176462-1-jiaxun.yang@flygoat.com>
 <20210114073429.176462-2-jiaxun.yang@flygoat.com>
 <CAJZ5v0i=bFw7WJA615UyLXnZ4kgK4E+0ZB=Ykgge+o3+9onnPA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <00166b14-d9aa-fd0d-99b1-4a93151f1cf3@redhat.com>
Date:   Thu, 14 Jan 2021 14:54:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0i=bFw7WJA615UyLXnZ4kgK4E+0ZB=Ykgge+o3+9onnPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 1/14/21 1:16 PM, Rafael J. Wysocki wrote:
> On Thu, Jan 14, 2021 at 8:42 AM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>>
>> All planned uses of cur_profile have their platform_profile_handler
>> defined as const, so just drop const qualifier here to prevent build
>> error.
>>
>> Link: https://lore.kernel.org/linux-acpi/5e7a4d87-52ef-e487-9cc2-8e7094beaa08@redhat.com/
>> Suggested-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>  drivers/acpi/platform_profile.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
>> index 91be50a32cc8..9dddf44b43d4 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -9,7 +9,7 @@
>>  #include <linux/platform_profile.h>
>>  #include <linux/sysfs.h>
>>
>> -static const struct platform_profile_handler *cur_profile;
>> +static struct platform_profile_handler *cur_profile;
> 
> I think that it's not just here, but also in the
> platform_profile_register() argument.

Correct, this needs to be fixed in platform_profile_register() too,
both in drivers/acpi/platform_profile.c and in
include/linux/platform_profile.h

Otherwise we will get a compiler warning (or maybe even an error)
about assigning a pointer pointing to const memory to a pointer not
pointing to const mem.

Regards,

Hans




> 
>>  static DEFINE_MUTEX(profile_lock);
>>
>>  static const char * const profile_names[] = {
>> --
>> 2.30.0
>>
> 


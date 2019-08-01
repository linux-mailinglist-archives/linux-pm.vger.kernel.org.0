Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E464A7E09A
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 18:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbfHAQy6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 12:54:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38178 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732294AbfHAQyx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 12:54:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so74346425wrr.5
        for <linux-pm@vger.kernel.org>; Thu, 01 Aug 2019 09:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xk32o95NCOLgUCqaaBPTpr45XpC6FO5dIRTVup5ncyo=;
        b=h+aEXKMKhEcYKhm8PJ5uUhqBnN3Cho1kurmhda/NJJK47KkJyaVxjJfzEQaVmCxxkZ
         Y5wuH2XnpOcWwk7CThCxEHJLT8e7vVh3k6j44plW86UMWkivKyPLRdvN3VtyQoF0AO0Z
         URyaNEH3gLS1rwMmr8Bf/xh6d5f3Y3JwOm+pq22ivSFPk8cFcs9oxD5qZBTVrnZUd1fY
         8QSZcxePbA4jj4ohtJYt5+WmuXgiko3B6OOntg2zMuQ/TeQUfYJf0MIFt19pLFaHetpq
         igcsxaiSmN/zmVSbtkv8sOOc+CP2+2VmYkL+mADZNd6im8z+sUUVYxwcEgIvOK4Ri6uA
         WGLw==
X-Gm-Message-State: APjAAAW6RWEfwdzxCwsD4EdgUezEtML7suYBqK72xjDuPjzrIh/v2GDG
        GiYp21jLyqhsoFt0oMXBQVyJjscYzj8=
X-Google-Smtp-Source: APXvYqx4rwx51xdjuRB5YgIrLUydM30Bos6mOWLmy3EJ68VNQ2cELBXtN3JThNTb+NcCk2E7jyCLAQ==
X-Received: by 2002:a5d:438e:: with SMTP id i14mr18809848wrq.122.1564678491260;
        Thu, 01 Aug 2019 09:54:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91e7:65e:d8cd:fdb3? ([2001:b07:6468:f312:91e7:65e:d8cd:fdb3])
        by smtp.gmail.com with ESMTPSA id r11sm114254839wre.14.2019.08.01.09.54.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 09:54:50 -0700 (PDT)
Subject: Re: [PATCH] cpuidle-haltpoll: Enable kvm guest polling when dedicated
 physical CPUs are available
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <1564643196-7797-1-git-send-email-wanpengli@tencent.com>
 <7b1e3025-f513-7068-32ac-4830d67b65ac@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c3fe182f-627f-88ad-cb4d-a4189202b438@redhat.com>
Date:   Thu, 1 Aug 2019 18:54:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7b1e3025-f513-7068-32ac-4830d67b65ac@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/08/19 18:51, Rafael J. Wysocki wrote:
> On 8/1/2019 9:06 AM, Wanpeng Li wrote:
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> The downside of guest side polling is that polling is performed even
>> with other runnable tasks in the host. However, even if poll in kvm
>> can aware whether or not other runnable tasks in the same pCPU, it
>> can still incur extra overhead in over-subscribe scenario. Now we can
>> just enable guest polling when dedicated pCPUs are available.
>>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Cc: Marcelo Tosatti <mtosatti@redhat.com>
>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> 
> Paolo, Marcelo, any comments?

Yes, it's a good idea.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

> 
>> ---
>>   drivers/cpuidle/cpuidle-haltpoll.c   | 3 ++-
>>   drivers/cpuidle/governors/haltpoll.c | 2 +-
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle-haltpoll.c
>> b/drivers/cpuidle/cpuidle-haltpoll.c
>> index 9ac093d..7aee38a 100644
>> --- a/drivers/cpuidle/cpuidle-haltpoll.c
>> +++ b/drivers/cpuidle/cpuidle-haltpoll.c
>> @@ -53,7 +53,8 @@ static int __init haltpoll_init(void)
>>         cpuidle_poll_state_init(drv);
>>   -    if (!kvm_para_available())
>> +    if (!kvm_para_available() ||
>> +        !kvm_para_has_hint(KVM_HINTS_REALTIME))
>>           return 0;
>>         ret = cpuidle_register(&haltpoll_driver, NULL);
>> diff --git a/drivers/cpuidle/governors/haltpoll.c
>> b/drivers/cpuidle/governors/haltpoll.c
>> index 797477b..685c7007 100644
>> --- a/drivers/cpuidle/governors/haltpoll.c
>> +++ b/drivers/cpuidle/governors/haltpoll.c
>> @@ -141,7 +141,7 @@ static struct cpuidle_governor haltpoll_governor = {
>>     static int __init init_haltpoll(void)
>>   {
>> -    if (kvm_para_available())
>> +    if (kvm_para_available() && kvm_para_has_hint(KVM_HINTS_REALTIME))
>>           return cpuidle_register_governor(&haltpoll_governor);
>>         return 0;
> 
> 


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70F14AF050
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2019 19:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437078AbfIJRP5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Sep 2019 13:15:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437012AbfIJRP5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Sep 2019 13:15:57 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E944368E2
        for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2019 17:15:56 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id n6so9222793wrm.20
        for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2019 10:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eOSlZvBN2Ca83BiWTP8n+uA4/rhpoJrl/QSiHK9ZrVo=;
        b=GYJi05B8DBBakvWMzpJlsrT3rWB8C2hfg0ilHErdIMoUDOgYfNqCXzhgN7OUo0ULP+
         qKb9iB4o8ydSSSNHVNoCv6O3MnHjUgDn0X6bmVtEHy6sJgjYguKqvvZAxaaNwh+Yg3BQ
         LcGPtAtTKxTM4kmPSjpK7sJyJKMexxzuJ+oFxGXvvc9PLAeNLss4WjtpUY+k3kLipEtZ
         1Or3ZnS3LxhS+iFPYZDEVOSXjdNF61WjhnhCODsJHTfOURDh7M7EL4f9H0tEuyBQBtxH
         b1h1bU9tKS/wF/7WdZa4ariud9WfsuoC1RCRujXfSfzKgJzRvFrQLlnbrf2aeUGnsMzC
         +FcA==
X-Gm-Message-State: APjAAAXQxEk14vhHr1H9KKVdKZh8TSm8eVxbZIjSbHcY8Wn9PCi6+5hq
        reyhXOgna8SmOD2L4KQ+kWuiF2HzZk0rVtBRcL5rDBGLcrhAlwKIP0Ab4buHXMZUcNWMbgXm1Bt
        6dSy+Qcph4z0HAHpHEkI=
X-Received: by 2002:a1c:7414:: with SMTP id p20mr446118wmc.68.1568135754725;
        Tue, 10 Sep 2019 10:15:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzLjatH2HoTUhtKdkw1BHN68vuXVqluXyaYtbmsYYvaw5QPP0gKenYj2w89mEdSi1fEy0k+jw==
X-Received: by 2002:a1c:7414:: with SMTP id p20mr446104wmc.68.1568135754464;
        Tue, 10 Sep 2019 10:15:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1435:25df:c911:3338? ([2001:b07:6468:f312:1435:25df:c911:3338])
        by smtp.gmail.com with ESMTPSA id a190sm477474wme.8.2019.09.10.10.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2019 10:15:53 -0700 (PDT)
Subject: Re: [PATCH v2] cpuidle-haltpoll: Enable kvm guest polling when
 dedicated physical CPUs are available
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <1567068597-22419-1-git-send-email-wanpengli@tencent.com>
 <a70aeec2-1572-ea09-a0c5-299cd70ddc8a@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <84a0c1b3-4590-6fdb-0b01-915c3f109e65@redhat.com>
Date:   Tue, 10 Sep 2019 19:15:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a70aeec2-1572-ea09-a0c5-299cd70ddc8a@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/09/19 11:48, Rafael J. Wysocki wrote:
> On 8/29/2019 10:49 AM, Wanpeng Li wrote:
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> The downside of guest side polling is that polling is performed even
>> with other runnable tasks in the host. However, even if poll in kvm
>> can aware whether or not other runnable tasks in the same pCPU, it
>> can still incur extra overhead in over-subscribe scenario. Now we can
>> just enable guest polling when dedicated pCPUs are available.
>>
>> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> 
> As stated before, I'm going to queue up this change for 5.4, with the
> Paolo's ACK.
> 
> BTW, in the future please CC power management changes to
> linux-pm@vger.kernel.org for easier handling.

Thanks.  This patch makes sense to me and I don't know what
"limitations" are there in KVM_HINTS_REALTIME that Marcelo mentioned.

Any improvements that Marcelo can discuss can be made on top of this
during the 5.4 merge window, via the KVM tree.

Thanks Rafael for handling the reviewing and merging of this series.

Paolo

> 
>> -- 
>> v1 -> v2:
>>   * export kvm_arch_para_hints to fix haltpoll driver build as module
>> error
>>   * just disable haltpoll driver instead of both driver and governor
>>     since KVM_HINTS_REALTIME is not defined in other arches, and governor
>>     doesn't depend on x86, to fix the warning on powerpc
>>
>>   arch/x86/kernel/kvm.c              | 1 +
>>   drivers/cpuidle/cpuidle-haltpoll.c | 3 ++-
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>> index f48401b..68463c1 100644
>> --- a/arch/x86/kernel/kvm.c
>> +++ b/arch/x86/kernel/kvm.c
>> @@ -711,6 +711,7 @@ unsigned int kvm_arch_para_hints(void)
>>   {
>>       return cpuid_edx(kvm_cpuid_base() | KVM_CPUID_FEATURES);
>>   }
>> +EXPORT_SYMBOL_GPL(kvm_arch_para_hints);
>>     static uint32_t __init kvm_detect(void)
>>   {
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
> 
> 


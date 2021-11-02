Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951174434F7
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 18:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbhKBSA7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Nov 2021 14:00:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51396 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230392AbhKBSA7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Nov 2021 14:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635875903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7YWae8/c2+VpFHCahTyZSU56P7dkdlZsynEUAcRXcs8=;
        b=AH/YEf82UsmSVS1uXoQ7/2VXkpQZqZyQo6eA9NgQVo/x33LCgrGjcbXL9INcYVTD4Hlar8
        ydMveXR/c2+ToaI7C4K2PUQCvSeplCiyYCpFAj7hVer8iR7OV9O6DMDqi6npDjBr3MNuHN
        RiYC50NUitP3FP6WD7nA1I+lRtMm1eY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-3Jg8Jp71Ngyo8uURJudJgw-1; Tue, 02 Nov 2021 13:58:22 -0400
X-MC-Unique: 3Jg8Jp71Ngyo8uURJudJgw-1
Received: by mail-ed1-f72.google.com with SMTP id z1-20020a05640235c100b003e28c89743bso66745edc.22
        for <linux-pm@vger.kernel.org>; Tue, 02 Nov 2021 10:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7YWae8/c2+VpFHCahTyZSU56P7dkdlZsynEUAcRXcs8=;
        b=MZE7NtvART6oNQ5TiodzcJBQrdVeBxC4lDbyibmj4bPjl3SwwO+drKgiGhTt429svd
         QcOzxNf0pTlZlG05r1+Aj5nVMzNSRVppJU1UlxyLY2plee1g4r3kHiFDGMThvL55A+1U
         e3zs9G6tLCJGUDctylDweEdOBZd8xvGWiHeqnBKe5j3+DRVO0OKaIECSMX12knoLLa7T
         02s/BZ4h3j0qMm96gw1rl2+c8o09VrS6BB0dN9v0Qv5keJv6V1QoQSG4Ld4gL2lqPuFv
         Ozw7ypfiNWMcEyEcpaCmthhASisGmg5I56m+hH6pSa6VTtXv0Jrfdl0mNev8F7gyMcC0
         KUpg==
X-Gm-Message-State: AOAM531MZQc89QpxW2uGa/+FEL5WSscH1rAd9jl15Ks+C0Rk89NFUZn/
        vnB/8bQyi2PdKJF5RTpq9eQWkHoj1Qq4rWnRjM3qB967U6CrFvisOtMUUKARilvXs0MTK7Q3YOn
        xbyfLatb0q4/qWkuVLhg=
X-Received: by 2002:a05:6402:1c95:: with SMTP id cy21mr30982354edb.320.1635875901804;
        Tue, 02 Nov 2021 10:58:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4LRnCc2ywjCJCkzUey0AE4rRRgjUs3hTJutR2Ki1XGzhFVxd5OwCRFJa/mVZ/uC9LuY+1xw==
X-Received: by 2002:a05:6402:1c95:: with SMTP id cy21mr30982339edb.320.1635875901562;
        Tue, 02 Nov 2021 10:58:21 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f7sm11107373edl.33.2021.11.02.10.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 10:58:21 -0700 (PDT)
Message-ID: <b5548052-11c8-d34e-9851-ad64d9032267@redhat.com>
Date:   Tue, 2 Nov 2021 18:58:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] power: supply: bq27xxx: Fix kernel crash on IRQ
 handler register error
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
References: <20211031152522.3911-1-hdegoede@redhat.com>
 <CAHp75Vc6GO4e0_Qp6HfFtd_kbSakaMXsQN4oEPArdmMrxTFb7A@mail.gmail.com>
 <20211102132352.yqazgy2njnbthujb@earth.universe>
 <e74947c4-74c8-a17e-f4cb-752a79851954@redhat.com>
 <20211102164117.pnbpvephlh4wgrwb@earth.universe>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211102164117.pnbpvephlh4wgrwb@earth.universe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 11/2/21 17:41, Sebastian Reichel wrote:
> Hi Hans,
> 
> On Tue, Nov 02, 2021 at 03:12:51PM +0100, Hans de Goede wrote:
>> Hi Sebastian,
>>
>> On 11/2/21 14:23, Sebastian Reichel wrote:
>>> Hi,
>>>
>>> On Sun, Oct 31, 2021 at 09:34:46PM +0200, Andy Shevchenko wrote:
>>>> On Sun, Oct 31, 2021 at 5:25 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>
>>>>> When registering the IRQ handler fails, do not just return the error code,
>>>>> this will free the devm_kzalloc()-ed data struct while leaving the queued
>>>>> work queued and the registered power_supply registered with both of them
>>>>> now pointing to free-ed memory, resulting in various kernel crashes
>>>>> soon afterwards.
>>>>>
>>>>> Instead properly tear-down things on IRQ handler register errors.
>>>>
>>>> FWIW,
>>>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>>
>>> Thanks, queued.
>>
>> Thank you, note these 2 patches (for the bq25980 driver) are also
>> pure bug-fixes, I posted them as part of a larger series, but
>> in hindsight I should have probably posted them separately:
>>
>> https://lore.kernel.org/platform-driver-x86/20211030182813.116672-4-hdegoede@redhat.com/
>> https://lore.kernel.org/platform-driver-x86/20211030182813.116672-5-hdegoede@redhat.com/
>>
>> It would be good if you can pick these 2 up too
>> (I'll respin the rest of the series to address various
>> review comments without them then).
>> Let me know if you want me to resend these 2 as a stand alone
>> series.
> 
> Thanks for the pointer, I queued both of them. I had to slightly
> rebase, since your base did not include 172d0ccea55c. I have not
> yet reviewed the remaining patchset, but considering there are more
> patches to bq25890 a rebase would be ncie.

Ack, I'll rebase for the next version of that series.

Regards,

Hans


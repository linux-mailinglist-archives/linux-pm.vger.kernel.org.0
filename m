Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35F4F36952
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 03:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfFFBfc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 21:35:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42455 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfFFBfc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 21:35:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so342990pgd.9;
        Wed, 05 Jun 2019 18:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/QxdqYoMgOzIx2YVy8fAWt2ho9RD+sHh6bkx2lXobUc=;
        b=scdo9fwoyDWgCiLeWlCocSXX8chUMiPIhNZpPAKowgNRzG1R8Dy3x9SE1CgkbzhNZg
         fmn2MgtKtuOpBhYiXDg9XQWSwYYUN3IKiZFis/6tPpYO5ZDsQRzwAgZSk5YZEGRgN/Q4
         RIFqN8t5eeVdCbwTLNoq+Eo67lyVOaGWdGmjTtSsDNfg0do+c9V2dmJhKLAyj1+e068c
         joRs4TFnzFp7+xJt8KNcjMKcJNWwonPRqapKoAUDJaxpD96pKaPCnDxhpuuASdDLIPLm
         mbFyvZ1iABUiT+x15uEyJ8nFulDQwix1CtIo0CtzkHZ03rI7YKG9jQc5sw9WQfsqHmqw
         NdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/QxdqYoMgOzIx2YVy8fAWt2ho9RD+sHh6bkx2lXobUc=;
        b=nGi7gvRP16LUBTrqB2KyAsJlreLHFXBYWdZ5SbUOhCOl/u9xH6zmYrSoa8ocOyPGrC
         Sy198jvimRgLVpwuhr4loSmuS5E80ga3BmKtYwFQWf+VrmDrz908FuJlf50B/C4CZvqW
         XWLMb1LppDVJ+56kLu00OAFIijWzkjefZ9SdOQDoeGunCnNul6A/8yrkOzWxNskYUztO
         i1hBYNByz1O5iQNJqqwUd0bl8hZ3klBIdcHXL9bBMy5lM2kTdVkpV45HFyM21Qm5zNBq
         peYuVPrcnTC6P4G/6QlUmKY9Hj8B5A+jcybVmtxM9rOk/VX2Ilnw36Cop43XmEcs9MCN
         OP8A==
X-Gm-Message-State: APjAAAVlcZPuD/9/LkxBct7tVnWCv4oGbkVSTtqEPBRyp4jMG5zuIsPZ
        xBK7Lzjthp/fYbwchMoFqKFrBdjK
X-Google-Smtp-Source: APXvYqzdoP302oG1MIvKL5EugKA3mai1ZTWLgs0PUz/RmS2qaC9g2Xw2XdozsJg1A7y5V6ZBxA3hVQ==
X-Received: by 2002:a62:3287:: with SMTP id y129mr44663628pfy.101.1559784931144;
        Wed, 05 Jun 2019 18:35:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a22sm188409pfn.173.2019.06.05.18.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 18:35:29 -0700 (PDT)
Subject: Re: [PATCH 3/3] drivers: hwmon: i5k_amb: remove unnecessary #ifdef
 MODULE
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, jdelvare@suse.com, khalid@gonehiking.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        aacraid@microsemi.com, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-scsi@vger.kernel.org
References: <1559397700-15585-1-git-send-email-info@metux.net>
 <1559397700-15585-4-git-send-email-info@metux.net>
 <20190601224946.GA6483@roeck-us.net>
 <e91fabd4-a7a4-3afa-9f3a-95a6d90e8c7b@metux.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b830e977-88a6-7780-a048-08d8847fc325@roeck-us.net>
Date:   Wed, 5 Jun 2019 18:35:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e91fabd4-a7a4-3afa-9f3a-95a6d90e8c7b@metux.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/5/19 4:59 PM, Enrico Weigelt, metux IT consult wrote:
> On 01.06.19 22:49, Guenter Roeck wrote:
>> On Sat, Jun 01, 2019 at 04:01:40PM +0200, Enrico Weigelt, metux IT consult wrote:
>>> The MODULE_DEVICE_TABLE() macro already checks for MODULE defined,
>>> so the extra check here is not necessary.
>>>
>>> Signed-off-by: Enrico Weigelt <info@metux.net>
>>> ---
>>>   drivers/hwmon/i5k_amb.c | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
>>> index b09c39a..b674c2f 100644
>>> --- a/drivers/hwmon/i5k_amb.c
>>> +++ b/drivers/hwmon/i5k_amb.c
>>> @@ -482,14 +482,12 @@ static int i5k_channel_probe(u16 *amb_present, unsigned long dev_id)
>>>       { 0, 0 }
>>>   };
>>> -#ifdef MODULE
>>>   static const struct pci_device_id i5k_amb_ids[] = {
>>>       { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5000_ERR) },
>>>       { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5400_ERR) },
>>>       { 0, }
>>>   };
>>>   MODULE_DEVICE_TABLE(pci, i5k_amb_ids);
>>> -#endif
>>
>> I'd rather know what this table is used for in the first place.
> 
> Seems it's really just used for the module loader, while actual probing
> is using a different table. IMHO, the worst thing my patch could do is
> introducing a warning on unused variable (IMHO shouldn't happen when
> it's static const).
> 

You are wrong. You'll need __maybe_unused qualifiers for those variables
to avoid the warning.

Guenter

> I've just rewritten it to move everything into i5k_amb_ids ... just need
> to run build tests on it (unfortunately can't run-test, as I don't have
> that device).
> 
> 
> --mtx
> 


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046C63173DA
	for <lists+linux-pm@lfdr.de>; Thu, 11 Feb 2021 00:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhBJXAg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 18:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbhBJXAe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2021 18:00:34 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F3CC061756;
        Wed, 10 Feb 2021 14:59:53 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d26so2298721pfn.5;
        Wed, 10 Feb 2021 14:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KT1/+q26UpMTGY5hez+ykySBsh/GlZRPF35yJMtlWVA=;
        b=R2zvjlRWz47+CI6PwBa5mA9+zEsWKdASVNkzwaFRkBS0MshqfBzI/RuZHgtGGL20+K
         /8Q2orswd8eEHES2Ygt5FWwhnV7pBR7ZckC77wOC3hI+hUgs8AQUVtK7yRdCiqw4p8Pm
         M84+FlLhtZqfrS5nn5qPg/qj54CMzqe7+ULm5rcc2Mrkx0dkNiK5BcyybXy+Ul6g/1lm
         RdML9KVwjl5B8ZGg1lHCOpe79jvNir/j8ZgKz7FnQeiuvDj1TvelBdPa9MCzqV0j7dhN
         98Whn3vOygAhHm7uNVBgsgczjPK2h1YJStQzuw2B1y6VTZLU9p6qblm5wLFoKRV0IZ5S
         /cOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KT1/+q26UpMTGY5hez+ykySBsh/GlZRPF35yJMtlWVA=;
        b=T8M7TtFf7umA03u3dbz1qGd4Frxc7T2soEWgiPDgKOlmdT9CvPpV/p4QqGn6EtwyMI
         gYvkm6PivV/9v3Msv0lp7F6qgsMdtOFp0ngNE0zRUIYzNwlOzLY4m0yutFDY36KrNHCT
         djWhgz0YvUooHodKpUKd7Y1UlencUAA5Qb4GaluB6EE7gqyrqBHusOVtaehxzZgHVRib
         hEB8iKx05YliWp1Tm6ifD7qPScZdMoyRqJBlsE+Dan0HKf3jgp9MRArzaxC2P4VBu50j
         OtyI3NMzE4e+DMXjQlEu/vKW9VtnKbLeNLd+R6mFihJ6DTs0q/XduZUf8S4KgQ9O2/j4
         y6bg==
X-Gm-Message-State: AOAM532wP4whd++MyNwb0Ew5sSMe5rCgcZYOWoJTRZehkQwQGBZRDjls
        hYDqXZg85bcGGIl4TEBYmZdoEQVAosI=
X-Google-Smtp-Source: ABdhPJxaG/M0B4A/sBmPVP7xbuAxvBMYhH7GqnHxNk2UDcS4vU4spH22S2zKwEwDv1cIe/xBd/+vtw==
X-Received: by 2002:a63:eb05:: with SMTP id t5mr5086534pgh.389.1612997992978;
        Wed, 10 Feb 2021 14:59:52 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y67sm3395360pfb.71.2021.02.10.14.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 14:59:52 -0800 (PST)
Subject: Re: bcm2711_thermal: Kernel panic - not syncing: Asynchronous SError
 Interrupt
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        stefan.wahren@i2se.com, Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.con>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20210210114829.2915de78@gollum>
 <6d9ca41b4ad2225db102da654d38bc61f6c1c111.camel@suse.de>
 <35e17dc9-c88d-582f-607d-1d90b20868fa@arm.com>
 <c6774af169854dc1d4efa272b439e80cea8cd8ff.camel@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6612b35f-86bb-bb1e-bae8-188366495dbe@gmail.com>
Date:   Wed, 10 Feb 2021 14:59:45 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <c6774af169854dc1d4efa272b439e80cea8cd8ff.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2/10/2021 8:55 AM, Nicolas Saenz Julienne wrote:
> Hi Robin,
> 
> On Wed, 2021-02-10 at 16:25 +0000, Robin Murphy wrote:
>> On 2021-02-10 13:15, Nicolas Saenz Julienne wrote:
>>> [ Add Robin, Catalin and Florian in case they want to chime in ]
>>>
>>> Hi Juerg, thanks for the report!
>>>
>>> On Wed, 2021-02-10 at 11:48 +0100, Juerg Haefliger wrote:
>>>> Trying to dump the BCM2711 registers kills the kernel:
>>>>
>>>> # cat /sys/kernel/debug/regmap/dummy-avs-monitor\@fd5d2000/range
>>>> 0-efc
>>>> # cat /sys/kernel/debug/regmap/dummy-avs-monitor\@fd5d2000/registers
>>>>
>>>> [   62.857661] SError Interrupt on CPU1, code 0xbf000002 -- SError
>>>
>>> So ESR's IDS (bit 24) is set, which means it's an 'Implementation Defined
>>> SError,' hence IIUC the rest of the error code is meaningless to anyone outside
>>> of Broadcom/RPi.
>>
>> It's imp-def from the architecture's PoV, but the implementation in this 
>> case is Cortex-A72, where 0x000002 means an attributable, containable 
>> Slave Error:
>>
>> https://developer.arm.com/documentation/100095/0003/system-control/aarch64-register-descriptions/exception-syndrome-register--el1-and-el3?lang=en
>>
>> In other words, the thing at the other end of an interconnect 
>> transaction said "no" :)
>>
>> (The fact that Cortex-A72 gets too far ahead of itself to take it as a 
>> synchronous external abort is a mild annoyance, but hey...)
> 
> Thanks for both your clarifications! Reading arm documentation is a skill on
> its own.

Yes it is.

> 
>>> The regmap is created through the following syscon device:
>>>
>>> 	avs_monitor: avs-monitor@7d5d2000 {
>>> 		compatible = "brcm,bcm2711-avs-monitor",
>>> 			     "syscon", "simple-mfd";
>>> 		reg = <0x7d5d2000 0xf00>;
>>>
>>> 		thermal: thermal {
>>> 			compatible = "brcm,bcm2711-thermal";
>>> 			#thermal-sensor-cells = <0>;
>>> 		};
>>> 	};
>>>
>>> I've done some tests with devmem, and the whole <0x7d5d2000 0xf00> range is
>>> full of addresses that trigger this same error. Also note that as per Florian's
>>> comments[1]: "AVS_RO_REGISTERS_0: 0x7d5d2200 - 0x7d5d22e3." But from what I can
>>> tell, at least 0x7d5d22b0 seems to be faulty too.
>>>
>>> Any ideas/comments? My guess is that those addresses are marked somehow as
>>> secure, and only for VC4 to access (VC4 is RPi4's co-processor). Ultimately,
>>> the solution is to narrow the register range exposed by avs-monitor to whatever
>>> bcm2711-thermal needs (which is ATM a single 32bit register).
>>
>> When a peripheral decodes a region of address space, nobody says it has 
>> to accept accesses to *every* address in that space; registers may be 
>> sparsely populated, and although some devices might be "nice" and make 
>> unused areas behave as RAZ/WI, others may throw slave errors if you poke 
>> at the wrong places. As you note, in a TrustZone-aware device some 
>> registers may only exist in one or other of the Secure/Non-Secure 
>> address spaces.
>>
>> Even when there is a defined register at a given address, it still 
>> doesn't necessarily accept all possible types of access; it wouldn't be 
>> particularly friendly, but a device *could* have, say, some registers 
>> that support 32-bit accesses and others that only support 16-bit 
>> accesses, and thus throw slave errors if you do the wrong thing in the 
>> wrong place.
>>
>> It really all depends on the device itself.
> 
> All in all, assuming there is no special device quirk to apply, the feeling I'm
> getting is to just let the error be. As you hint, firmware has no blame here,
> and debugfs is a 'best effort, zero guarantees' interface after all.

We should probably fill a regmap_access_table to deny reading registers
for which there is no address decoding and possibly another one to deny
writing to the read-only registers.
-- 
Florian

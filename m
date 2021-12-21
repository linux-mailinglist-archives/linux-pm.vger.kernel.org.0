Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89D947C377
	for <lists+linux-pm@lfdr.de>; Tue, 21 Dec 2021 17:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbhLUQGM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Dec 2021 11:06:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21732 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239400AbhLUQGK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Dec 2021 11:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640102770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h8j90K6L+jMTJ+92nwkdhzdimoieBEu9gIYMqpMiA+k=;
        b=dU9em89lRI1RHQDHdQLQNv1ujWPcL7vF9HnpyrjkCXfwZrCtME2a3v6B6+S6r7pO7xCaXA
        ltGN2KN3jzwkJeCrjV1bM74reEi2O8q7gMcUFkinkU64/H3nNFcdXKaiERSNUKZvj020Sc
        nvhiD3dyrI8YLy2Zk8keC6uH9To1Aec=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-UxrxqlFWPUCK8WJOTcEgQA-1; Tue, 21 Dec 2021 11:06:07 -0500
X-MC-Unique: UxrxqlFWPUCK8WJOTcEgQA-1
Received: by mail-ed1-f71.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso10783560edt.20
        for <linux-pm@vger.kernel.org>; Tue, 21 Dec 2021 08:06:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h8j90K6L+jMTJ+92nwkdhzdimoieBEu9gIYMqpMiA+k=;
        b=2NoyiIGhYRE8Gv+K8l4AnBXPFqdN7zpgdghxO2HvfKmaEN2ijKfzGaSfGy3VZzQaOF
         vtrogydP5q+Woulhb+jjBsqYDLRMPmYKK8lbeDAp8Nf1FOFBXJSrgve2dgx7QwoPJ/in
         NOHkDnznL7WNpMrro0/BkyAcAngh92U7dNKZQrXuEhlRptDcCfChAy4ao/LVhkeL3Kbu
         6AqUYmechzE3aXNqAGkoiYUoehdfwBUHrl++jqni9f2quE0lUvRWG5fWVIyxilAH3mhe
         0WPx1R5tTLaz/0VN0QTI2wg31Hwb8cDpqA346ieCrKA7Pa4z0ctBIoX0gS2vGqrIMNa7
         x5Kg==
X-Gm-Message-State: AOAM5311eIV42C9A8hS2aLd6eMCM4SfyAu9e3FsPumw3H+4WxqojU5/y
        FgVEoB+kswfpSVP4orNeaKFYrV25oD0VtzuqAEbMi7wsvR76S4urKRhYbpAc4QOG4QTCuMw0hnp
        c9Qms1mLFllvz1vbKwnM=
X-Received: by 2002:a17:906:c113:: with SMTP id do19mr3452272ejc.386.1640102766153;
        Tue, 21 Dec 2021 08:06:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+kRtxhqJ1CGneSm94jZP3MegGl113EQ2yZjMTqNZ5gCM6/LfJa6vjVtgAVr3CWxay7JN6Ig==
X-Received: by 2002:a17:906:c113:: with SMTP id do19mr3452253ejc.386.1640102765935;
        Tue, 21 Dec 2021 08:06:05 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id oz7sm2018016ejc.81.2021.12.21.08.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 08:06:05 -0800 (PST)
Message-ID: <b858c808-6153-66fd-beb5-68595b148a7e@redhat.com>
Date:   Tue, 21 Dec 2021 17:06:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 0/4] power: supply: add charge_behaviour property
 (force-discharge, inhibit-charge)
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
Cc:     linux-pm@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        linux-kernel@vger.kernel.org, linrunner@gmx.net, bberg@redhat.com,
        hadess@hadess.net, markpearson@lenovo.com,
        nicolopiazzalunga@gmail.com, njoshi1@lenovo.com, smclt30p@gmail.com
References: <20211123232704.25394-1-linux@weissschuh.net>
 <20211203213305.dfjedjj3b25ftj2z@earth.universe>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211203213305.dfjedjj3b25ftj2z@earth.universe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 12/3/21 22:33, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Nov 24, 2021 at 12:27:00AM +0100, Thomas Weißschuh wrote:
>> This series adds support for the charge_behaviour property to the power
>> subsystem and thinkpad_acpi driver.
>>
>> As thinkpad_acpi has to use the 'struct power_supply' created by the generic
>> ACPI driver it has to rely on custom sysfs attributes instead of proper
>> power_supply properties to implement this property.
>>
>> Patch 1: Adds the power_supply documentation and basic public API
>> Patch 2: Adds helpers to power_supply core to help drivers implement the
>>   charge_behaviour attribute
>> Patch 3: Adds support for force-discharge to thinkpad_acpi.
>> Patch 4: Adds support for inhibit-discharge to thinkpad_acpi.
>>
>> Patch 3 and 4 are largely taken from other patches and adapted to the new API.
>> (Links are in the patch trailer)
>>
>> Ognjen Galic:
>>
>> Your S-o-b is on the original inhibit_charge and force_discharge patches.
>> I would like to add you as Co-developed-by but to do that it will also require
>> your S-o-b. Could you give your sign-offs for the new patches, so you can be
>> properly attributed?
>>
>> Sebastian Reichel:
>>
>> Currently the series does not actually support the property as a proper
>> powersupply property handled fully by power_supply_sysfs.c because there would
>> be no user for this property.
> 
> I'm not too happy how the acpi-battery hooks work, but that's not
> your fault and this patchset does not really make the situation
> worse. So:
> 
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Sebastian, I have taken the liberty to assume that this means that you are
ok with merging the entire series through the pdx86 tree (I've done a test-merge
with linux-power-supply/for-next and there are no conflicts).

Thomas, Thank you for your patch-series, I've applied the series
to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans





> 
> -- Sebastian
> 
>> Previous discussions about the API:
>>
>> https://lore.kernel.org/platform-driver-x86/20211108192852.357473-1-linux@weissschuh.net/
>> https://lore.kernel.org/platform-driver-x86/21569a89-8303-8573-05fb-c2fec29983d1@gmail.com/
>>
>> v1: https://lore.kernel.org/lkml/20211113104225.141333-1-linux@weissschuh.net/
>> v1 -> v2:
>>
>> * Use sysfs_emit-APIs instead of plain sprintf
>> * More cecks for actual feature availability
>> * Validation of the written values
>> * Read inhibit-charge via BICG instead of PSSG (peak shift state)
>> * Don't mangle error numbers in charge_behaviour_store()
>>
>> Open points:
>>
>> Thomas Koch has observed that on a T450s with two batteries
>> inhibit-charge on BAT0 will affect both batteries and for BAT1 it is ignored
>> entirely, this seems to be a bug in the EC.
>> On my T460s with two batteries it works correctly.
>>
>> Thomas Weißschuh (4):
>>   power: supply: add charge_behaviour attributes
>>   power: supply: add helpers for charge_behaviour sysfs
>>   platform/x86: thinkpad_acpi: support force-discharge
>>   platform/x86: thinkpad_acpi: support inhibit-charge
>>
>>  Documentation/ABI/testing/sysfs-class-power |  14 ++
>>  drivers/platform/x86/thinkpad_acpi.c        | 191 +++++++++++++++++++-
>>  drivers/power/supply/power_supply_sysfs.c   |  51 ++++++
>>  include/linux/power_supply.h                |  16 ++
>>  4 files changed, 268 insertions(+), 4 deletions(-)
>>
>>
>> base-commit: 66f4beaa6c1d28161f534471484b2daa2de1dce0
>> -- 
>> 2.34.0
>>


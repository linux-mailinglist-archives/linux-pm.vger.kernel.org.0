Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996FB6628B4
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jan 2023 15:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjAIOmm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Jan 2023 09:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjAIOmj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2023 09:42:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7C61A835
        for <linux-pm@vger.kernel.org>; Mon,  9 Jan 2023 06:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673275313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gn67qzc8n5vMTxpGkDlTw2FWaLmxliDIMWVXs/A4Cqw=;
        b=OVIfpRVEjNDTOPVeqjS0VDmWSZdqgAhdyes9PW7PEBCGqG9dAxcrR+CJAS79a0pqXJqyM4
        q8PHaqargC7MUgRip8wG1U1JPbPMPsct44bUrw5yfw2eJ6uZgTGOQdSPpe/LNmz8WYdwlP
        LmLRvTs4WTcQ3YTQIGuIfu8CEfd7Db0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-630-B226bLFvPGSHt2QhNO7UOw-1; Mon, 09 Jan 2023 09:41:45 -0500
X-MC-Unique: B226bLFvPGSHt2QhNO7UOw-1
Received: by mail-ej1-f69.google.com with SMTP id sg39-20020a170907a42700b007c19b10a747so5582074ejc.11
        for <linux-pm@vger.kernel.org>; Mon, 09 Jan 2023 06:41:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gn67qzc8n5vMTxpGkDlTw2FWaLmxliDIMWVXs/A4Cqw=;
        b=JNCf7SWuCn35mLgEDiIX2cnrsuhaGjE8AD9OjwJB3L0jA+KsYG0i7TuAszKVqlnX1l
         DOGolG0GnLSFxTr9GgklkZlecu9T54qfASamjGoQhHNtyVRnWim7qL6APjM9OMQaLt7I
         u8kiC1HjXTxg1WxM9bCPqslb8NH6KomFcvRedv6pFURJ+nEADhi7MeLOXIGNWAy2i5N8
         q7y6moRsL01iId7ljyvRgx/iN27lX0iIClJPT6ttFuWdi/fsaKMsDUD1peEwbDW0rmIS
         hIrn+mt2SEN4bs6mLrsNhbpZbf/dbpOR7rJ+g5vZfkS3Wt71pkeMeL7PeaVUR2t76wcf
         ajuA==
X-Gm-Message-State: AFqh2koIyH1OcLfXkWCskh8bGzrTThpEdLNarbrAvDrshSAfv5BOzBih
        2aW/QYqoaxqqQgqBO6TJhAaRWeIqltcr7UnEPeeFxrWUmBR2XRcPnjzFZIoxfyoeMCqox6SJ21V
        seOXTLvSN5cAeY+12KzY=
X-Received: by 2002:a17:906:7e55:b0:7c1:7442:8b70 with SMTP id z21-20020a1709067e5500b007c174428b70mr60853407ejr.75.1673275303671;
        Mon, 09 Jan 2023 06:41:43 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs7zR8qpKqJBFaEf7dYsXmiXTUSiKO9DP6bCBUS44CJgoVHDpw80FXi5ZfAgOf34b7z0fNJsw==
X-Received: by 2002:a17:906:7e55:b0:7c1:7442:8b70 with SMTP id z21-20020a1709067e5500b007c174428b70mr60853394ejr.75.1673275303431;
        Mon, 09 Jan 2023 06:41:43 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id e6-20020a170906314600b00781be3e7badsm3855038eje.53.2023.01.09.06.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 06:41:42 -0800 (PST)
Message-ID: <3706e642-5172-0359-afda-6e9b9e738d79@redhat.com>
Date:   Mon, 9 Jan 2023 15:41:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 0/9] power: supply: bq25890: Fixes for 6.2 + further
 work for 6.3
Content-Language: en-US, nl
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
References: <20221128092856.71619-1-hdegoede@redhat.com>
 <20230102231530.3eumtnr6jqjv5jlt@mercury.elektranox.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230102231530.3eumtnr6jqjv5jlt@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On 1/3/23 00:15, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Nov 28, 2022 at 10:28:47AM +0100, Hans de Goede wrote:
>> Hi Sebastian, Marek,
>>
>> Here is v2 of my bq25890 series from yesterday, addressing the few
>> small remarks from Marek + adding Marek's Reviewed-by to most of
>> my patches. Note I dropped patch 1/10 from the v1 series since that
>> has already been merged.
>>
>> Here is a (slightly updated) copy of the v1 cover letter:
>>
>> I have been working on getting a Lenovo Yoga Tab 3 Pro (YT3-X90F) to
>> work with the mainline kernel. This tablet has 2 batteries with
>> 2 bq25892 chargers both connected to a single Micro-USB connector.
>>
>> Supporting the 2 charger board also requires the recent HiZ mode patches
>> from Marek, to avoid merging order problems / conflicts I have included
>> a copy of Marek's series here so this series obsoletes the:
>>
>> [PATCH 1/2] power: supply: bq25890: Factor out chip state update
>> [PATCH 2/2] power: supply: bq25890: Add HiZ mode support
>> [PATCH v2 1/2] power: supply: bq25890: Factor out chip state update
>> [PATCH v2 2/2] power: supply: bq25890: Add HiZ mode support
>>
>> patches from Marek.
>>
>> While working on adding support for this I also noticed some generic issues
>> with the bq25890 driver currently in linux-power-supply/for-next and I also
>> have some fixes to the HiZ support on top of Marek's support.
>>
>> So this entire series consist of 4 parts:
>>
>> 1. Patches 1-2:
>>
>> Generic bugfixes for the bq25890 charger in its current state
>> in linux-power-supply/for-next.
>>
>> 2. Patches 3-4:
>>
>> Marek's HiZ support work, thank you Marek.
>>
>> 3. Patches 5-6:
>>
>> Some fixes / improvements from me to Marek's HiZ support.
>>
>> 4. Patch 7-9:
>>
>> The actual support for boards with 2 chargers.
> 
> I just queued patches 3-7 to power-supply's for-next branch.

Thank you!

Any particular reason why 8/9 and 9/9 have not been merged?

8/9 has Marek's Reviewed-by and no other remarks.

9/9 had a small remark by Marek about clamping the percentage,
but that was for v1 and has been fixed (clamping added when reading
the property) in v2.

Regards,

Hans




> 
> Thanks,
> 
> -- Sebastian
> 
>>
>> Regards,
>>
>> Hans
>>
>>
>> Hans de Goede (7):
>>   power: supply: bq25890: Ensure pump_express_work is cancelled on
>>     remove
>>   power: supply: bq25890: Fix usb-notifier probe and remove races
>>   power: supply: bq25890: Fix setting of F_CONV_RATE rate when disabling
>>     HiZ mode
>>   power: supply: bq25890: Always take HiZ mode into account for ADC rate
>>   power: supply: bq25890: Support boards with more then one charger IC
>>   power: supply: bq25890: Add support for having a secondary charger IC
>>   power: supply: bq25890: Add new linux,iinlim-percentage property
>>
>> Marek Vasut (2):
>>   power: supply: bq25890: Factor out chip state update
>>   power: supply: bq25890: Add HiZ mode support
>>
>>  drivers/platform/x86/x86-android-tablets.c |   2 +-
>>  drivers/power/supply/bq25890_charger.c     | 226 ++++++++++++++++-----
>>  2 files changed, 179 insertions(+), 49 deletions(-)
>>
>> -- 
>> 2.37.3
>>


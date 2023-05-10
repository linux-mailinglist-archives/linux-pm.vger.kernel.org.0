Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421276FD886
	for <lists+linux-pm@lfdr.de>; Wed, 10 May 2023 09:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbjEJHtC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 May 2023 03:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbjEJHsw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 May 2023 03:48:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B8AE7F
        for <linux-pm@vger.kernel.org>; Wed, 10 May 2023 00:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683704881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mirV9OfAEarL6qNhmDRQmeKMCzDFzAn/aQX66R/aVrk=;
        b=bML8f5fbqNr481zilODxGsMD6JIFssldwKoS+S+QkE+51U1NGfCrs66k01HpA5dA6lB7iS
        nCjad1zeYFWowZ4lcCs/io3MompuWqtUiyb1//3Diz9ZcZiMeqf5Qz9Kvz74gdbE3a78ZI
        ejy4MPuCONP7a9E9ratOXeiC9avKonk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461--QYrx4RNMd-xL8yNIU6xjQ-1; Wed, 10 May 2023 03:47:59 -0400
X-MC-Unique: -QYrx4RNMd-xL8yNIU6xjQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-965b9e29579so774040566b.0
        for <linux-pm@vger.kernel.org>; Wed, 10 May 2023 00:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683704878; x=1686296878;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mirV9OfAEarL6qNhmDRQmeKMCzDFzAn/aQX66R/aVrk=;
        b=BDF4par0dfvCLe3TvHnzhbVCmh+y7PCUYoNN0ISmoZsVe5H5Xd0AOI21LFDrAMT8Et
         SDkBatZO+06+I+xTM9C2/tyAtBgn6v/uR2oMP89lJyMECTkfmUIUTIMi7KmMTrKa2/xd
         5pl+4Y8BPUSmGKmfSc9Rf5Dk63RKFzVCcDTbyHp5hiTN8YIN81jcC6QHRVIXhwPxEzDE
         PUTGREN5BQ35aaSvP4+/9yAWdqbP8dVp+BtzHAj+A1lMbTt71kc8QyeHakMrd/tj46Vw
         v6MkiB0FaHs6h/dPs8QaqyUVxfTZXIfXwok9QAAHU0l7zF1wpRqL1+z8ecvaURLUINdK
         yU+w==
X-Gm-Message-State: AC+VfDy8oPZppzZtqvTIyfL2u1ci2njEL6ekV9U0aiGIp9F/KRBJ0R5k
        LfCOuVlBRI2VXa9VkQnIFlqOCVoZvfJqQTanDvIj46W8yObd1hCIVSua21alx2KlddljcO7jtOP
        NKTilyqttfQdjX+Uij3AY3llEqs4=
X-Received: by 2002:a17:907:3f25:b0:969:edf8:f73b with SMTP id hq37-20020a1709073f2500b00969edf8f73bmr5286652ejc.60.1683704878286;
        Wed, 10 May 2023 00:47:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5PNR76WakED7ycsEM+jq3WkqmLH7WT68xk28nVvCB3WCM1UwfLHP//xfF986D+5lV4Ay2XLQ==
X-Received: by 2002:a17:907:3f25:b0:969:edf8:f73b with SMTP id hq37-20020a1709073f2500b00969edf8f73bmr5286627ejc.60.1683704877934;
        Wed, 10 May 2023 00:47:57 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gt20-20020a170906f21400b0094f7744d135sm2337151ejb.78.2023.05.10.00.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 00:47:57 -0700 (PDT)
Message-ID: <ad589b4b-c6e4-9d78-9fc5-1f1012a6a8fe@redhat.com>
Date:   Wed, 10 May 2023 09:47:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/1] power: supply: axp288_charger: Use alt usb-id extcon
 on some x86 android tablets
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
References: <20230401150651.597155-1-hdegoede@redhat.com>
 <48e4b8b3-29fb-4d97-db1d-446c00403c80@redhat.com>
In-Reply-To: <48e4b8b3-29fb-4d97-db1d-446c00403c80@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 5/9/23 12:48, Hans de Goede wrote:
> Hi Sebastian,
> 
> On 4/1/23 17:06, Hans de Goede wrote:
>> Hi Sebastian,
>>
>> This patch used to be part of a patch set with 2 ACPI patches which
>> introduce the acpi_quirk_skip_gpio_event_handlers() which this patch
>> depends on.
>>
>> Rafael has picked up the 2 ACPI patches and submitted them to Linus
>> as fixes for this cycle:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5adc409340b1fc82bc1175e602d14ac82ac685e3
>>
>> But this patch was not picked up.
>>
>> So I'm resubmitting this patch hereby for direct inclusion into
>> your linux-power-supply tree.
>>
>> Note this relies on commit 5adc409340b1 ("ACPI: x86: Introduce an
>> acpi_quirk_skip_gpio_event_handlers() helper") which is in Linus
>> tree, but only in v6.3-rc3 and later.
> 
> Thank you for merging a bunch of my patches yesterday.
> 
> It looks like this one has fallen through the cracks though ?
> 
> Ideally this would go to 6.4 as a fix (as mentioned above the
> patch it depends on has landed in v6.3-rc3).

Never mind I see that this patch has already found its way
upstream. Sorry for the noise.

Regards,

Hans




>> Hans de Goede (1):
>>   power: supply: axp288_charger: Use alt usb-id extcon on some x86
>>     android tablets
>>
>>  drivers/power/supply/axp288_charger.c | 15 +++++++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>
> 


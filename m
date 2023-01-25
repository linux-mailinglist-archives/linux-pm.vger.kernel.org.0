Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A253967B311
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jan 2023 14:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjAYNNu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Jan 2023 08:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjAYNNt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2023 08:13:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A63E5618D
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 05:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674652376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XyGlAv299Y2NUzcO+vXTNNhSqmDMyL4VFEgA/ub6qDk=;
        b=Xe4oPVBez39pRoKV1gSHBHyPZVSeFxSJtrK1YPuhSyIh+NIRCJQ/PoOS3Cn59VbO4Uttc4
        sAmDVXnl931aBTKfXGV/LBmfETkunR4NuKqOlScp7kA9hhyPhdibsZgNpQX/eVcrMI/MVQ
        zBUE7Yb1vOI2EJzKd8e8SsiT33Y/BI0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-656-kXh8D59hM0ORugjTGxgB2g-1; Wed, 25 Jan 2023 08:12:55 -0500
X-MC-Unique: kXh8D59hM0ORugjTGxgB2g-1
Received: by mail-ed1-f72.google.com with SMTP id f11-20020a056402354b00b0049e18f0076dso12933665edd.15
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 05:12:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XyGlAv299Y2NUzcO+vXTNNhSqmDMyL4VFEgA/ub6qDk=;
        b=a6eWhyjY2Z7OaMjsTqIUkX0sZ/H9om50240maBjNPMVWeCaSoDL+Rp9AwjxBkVfyuu
         U5hyofoekMGZ3ibQSmCwoNkpS/Zu0KdGPPx3ZDl7kCAcmoNPU5sMcVhjNHMcu+k4CeFA
         6fInbXZr9DI62mX/UM9lnUDckiXy8W/R2uya2CyMS6MxZYvi9AcSpkzYDB6B85t6c7p2
         lGoAlW5bkcFSYC0ceDrEyviR7sc57ppHaMG+ND3VC2OrhLJ6AxdpCuJxGM1zP9o46S5L
         hfbCW5KTSK9wf16s7iD3eQBEVf8taCytEAb/RV/ZgcYPhAEtMGTg7107Hn5J4fj22Qpq
         bDNg==
X-Gm-Message-State: AFqh2krg0IkTWSgaXiRIkkJ430smJ7cfpTkhdXwHXfLNofA48IcRe5kF
        elWi1Vn98XR05pGbuEdjtOGs14Qr16o0WVrqZGi5dlvV8G/GbLXDT2DUIzx06qNmzi8g7qRZ5L9
        uk7g5Y9NDt6F4+sR9jqc=
X-Received: by 2002:a17:906:abc6:b0:86c:b710:dacf with SMTP id kq6-20020a170906abc600b0086cb710dacfmr33727900ejb.62.1674652374054;
        Wed, 25 Jan 2023 05:12:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsbV1BH2Wki36H0deWEse4p3d4OeSWUeh0ZCzzQhFW1EeVMxXykbp6fojI9Z7/g0C0QlTGnxg==
X-Received: by 2002:a17:906:abc6:b0:86c:b710:dacf with SMTP id kq6-20020a170906abc600b0086cb710dacfmr33727886ejb.62.1674652373865;
        Wed, 25 Jan 2023 05:12:53 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gu23-20020a170906f29700b0086a4bb74cf7sm2348564ejb.212.2023.01.25.05.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 05:12:53 -0800 (PST)
Message-ID: <ef4088fc-e17e-40aa-3446-2f08c51d809b@redhat.com>
Date:   Wed, 25 Jan 2023 14:12:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/2] power: supply: bq25890: Add new
 linux,iinlim-percentage property
Content-Language: en-US, nl
To:     Marek Vasut <marex@denx.de>, Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
References: <20230125105850.17935-1-hdegoede@redhat.com>
 <20230125105850.17935-3-hdegoede@redhat.com>
 <bce44755-9a27-74e4-47ae-ee8051780575@denx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <bce44755-9a27-74e4-47ae-ee8051780575@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marek,

On 1/25/23 14:02, Marek Vasut wrote:
> On 1/25/23 11:58, Hans de Goede wrote:
> 
> [...]
> 
>> @@ -1390,6 +1404,17 @@ static int bq25890_fw_probe(struct bq25890_device *bq)
>>       device_property_read_u32(bq->dev, "linux,pump-express-vbus-max",
>>                    &bq->pump_express_vbus_max);
>>   +    ret = device_property_read_u32(bq->dev, "linux,iinlim-percentage", &val);
>> +    if (ret == 0) {
>> +        if (val > 100) {
>> +            dev_err(bq->dev, "Error linux,iinlim-percentage %u > 100\n", val);
>> +            return -EINVAL;
>> +        }
>> +        bq->iinlim_percentage = val;
>> +    } else {
>> +        bq->iinlim_percentage = 100;
>> +    }
> 
> Should we really return -EINVAL if > 100 % or shall we clamp the value instead ?

Either one will work, returning -EINVAL frpm probe() for invalid property
values is something other drivers do to AFAIK.

I don't really have a preference either way.

Regards,

Hans


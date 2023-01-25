Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E49967B3A7
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jan 2023 14:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbjAYNpT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Jan 2023 08:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbjAYNpR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2023 08:45:17 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F9B58643
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 05:45:02 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 58E1985615;
        Wed, 25 Jan 2023 14:45:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1674654300;
        bh=2ifQa5zR3zDV1+o3rqE264bSRlPApOh5eCIKwUGeRi0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kFvUlMMX5KHQ2w2hXBj5sJIlTESZIR6vv5RQXf+P+4um3lZJNCUl8NYTwlQachvjc
         mRwxrTBJymF2sBcd28ObBTgH5q8gwIq3Z5Aj6NtVjF1gR5iLbgtgrru2SbcANb4n6o
         +BUITGeaMJwLOqfTuMNFGiSSAvPuxJ3+2Cr50W80/ksuE7+C+2lpCRaNnC1zRvZVQC
         vI5fNJ58ltl+9gsnxHzDEbQTcEKJ9CRBW4B1SqF/SgpWZKv52VkNlpTm/X1Hpro6sV
         jK+O+z9Es3D9O/VnvIk4wTrjeP+ZIjC9E9Yc1Rz+bYbA1rsYVQPA0t67FLyYN0cTOJ
         8E1K5EBtWPANw==
Message-ID: <b288df3d-8c98-0be2-1fe1-2179ceee90e6@denx.de>
Date:   Wed, 25 Jan 2023 14:44:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/2] power: supply: bq25890: Add new
 linux,iinlim-percentage property
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
References: <20230125105850.17935-1-hdegoede@redhat.com>
 <20230125105850.17935-3-hdegoede@redhat.com>
 <bce44755-9a27-74e4-47ae-ee8051780575@denx.de>
 <ef4088fc-e17e-40aa-3446-2f08c51d809b@redhat.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <ef4088fc-e17e-40aa-3446-2f08c51d809b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/25/23 14:12, Hans de Goede wrote:
> Hi Marek,

Hi,

> On 1/25/23 14:02, Marek Vasut wrote:
>> On 1/25/23 11:58, Hans de Goede wrote:
>>
>> [...]
>>
>>> @@ -1390,6 +1404,17 @@ static int bq25890_fw_probe(struct bq25890_device *bq)
>>>        device_property_read_u32(bq->dev, "linux,pump-express-vbus-max",
>>>                     &bq->pump_express_vbus_max);
>>>    +    ret = device_property_read_u32(bq->dev, "linux,iinlim-percentage", &val);
>>> +    if (ret == 0) {
>>> +        if (val > 100) {
>>> +            dev_err(bq->dev, "Error linux,iinlim-percentage %u > 100\n", val);
>>> +            return -EINVAL;
>>> +        }
>>> +        bq->iinlim_percentage = val;
>>> +    } else {
>>> +        bq->iinlim_percentage = 100;
>>> +    }
>>
>> Should we really return -EINVAL if > 100 % or shall we clamp the value instead ?
> 
> Either one will work, returning -EINVAL frpm probe() for invalid property
> values is something other drivers do to AFAIK.
> 
> I don't really have a preference either way.

I think my argument is this -- assume the device comes with a DT baked 
in ROM, and the DT cannot be changed, and the DT is defective. Should we 
really fail or gracefully handle the condition, print a warning, fix it 
up and still probe ?

This is very much a hypothetical case however, I think in most cases, 
the DT based systems with this chip will have exchangeable DT and the 
system integrator would be able to correct the defective DT. So maybe it 
is indeed better to fail and make sure the system integrator does notice 
the DT defect.

In either case:

Reviewed-by: Marek Vasut <marex@denx.de>

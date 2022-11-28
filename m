Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D60763A1ED
	for <lists+linux-pm@lfdr.de>; Mon, 28 Nov 2022 08:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiK1HVa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Nov 2022 02:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiK1HV3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2022 02:21:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C45656E
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 23:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669620029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iFgZhYlRdh3uyuZz+YHT36HCw/m0nwG4Ls1QVVsRQvc=;
        b=dLbkhhAnUKglUNtSDGtgUCajWkwvJmcbLkAt121VV9ZUGOfMdfwUDmsbqIY8GlOAtgIutM
        USqtpnGqdq2Uv09ibePj7G/xz73S+YlEuqcfUCPw4F1QWAcfJdU90l3czlp1ZuTfkhfdor
        GiUfWimAANEpyLEScgDRPY8a2FJKm+E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-209-xmkeZNW1OU2qmLQJ8N2yvQ-1; Mon, 28 Nov 2022 02:20:28 -0500
X-MC-Unique: xmkeZNW1OU2qmLQJ8N2yvQ-1
Received: by mail-ej1-f71.google.com with SMTP id xj11-20020a170906db0b00b0077b6ecb23fcso3827011ejb.5
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 23:20:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFgZhYlRdh3uyuZz+YHT36HCw/m0nwG4Ls1QVVsRQvc=;
        b=V/WpW1TtiEad71PnnDZrApLsMioAczy2L7A+iECl5lwJXVmkCNiEiTuBYaJOvUAnyF
         CWn5ZhhAmG9/jg6P+Zh3boh9KholLfOwad/4KwqAuzcLU9g7ac9zPe7qA8IF4ynpgB0v
         MmfNSSCMInkz1qhM6UnTs7FpX4ZYmj6YKq+4SbjwYkvNLOWqusGb0v2DGvnHjyblxV7f
         U+vf6Dn70OqoAZ6vtcBFZizK6bQIwH/nykN09s5ZihNLxEj6VGbcJURboOHg+nRiamof
         Fc9A9O56912s8ZVEbD1T5Kdwf4lexI5X9mwsYLZkxkwl6BuGLgoEr9CT6mDFJ31xkpcs
         /DEw==
X-Gm-Message-State: ANoB5pn1/+7mg3m4/Z907sT/S0DQpEiwVFVeiN48YLc60UGAtIR3dtYL
        ELZzzXKErNwsESRTaXjC7noct5likKOHQp672rhecdlX7CDJw0+7t2vNHmRXVRSDqXRwtWGxEak
        2h6POlwr7ms7j2upuFqI=
X-Received: by 2002:a17:906:4d41:b0:7bd:4e4e:feec with SMTP id b1-20020a1709064d4100b007bd4e4efeecmr10365718ejv.561.1669620026454;
        Sun, 27 Nov 2022 23:20:26 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4qf1vQhat9isKc91OjI8cLDVHZBd47/WXVl2HZX1XKhoT9f9whIdWaJqTE7b7JlJEXGP9hzA==
X-Received: by 2002:a17:906:4d41:b0:7bd:4e4e:feec with SMTP id b1-20020a1709064d4100b007bd4e4efeecmr10365705ejv.561.1669620026214;
        Sun, 27 Nov 2022 23:20:26 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id fe9-20020a1709072a4900b007ae0fde7a9asm4584742ejc.201.2022.11.27.23.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 23:20:25 -0800 (PST)
Message-ID: <dcae0336-1319-3364-ef6d-802b76cbf14d@redhat.com>
Date:   Mon, 28 Nov 2022 08:20:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 02/10] power: supply: bq25890: Ensure pump_express_work is
 cancelled on remove
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
References: <20221127180233.103678-1-hdegoede@redhat.com>
 <20221127180233.103678-3-hdegoede@redhat.com>
 <20221127231716.dtt5nrpvv7dheeqd@mercury.elektranox.org>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221127231716.dtt5nrpvv7dheeqd@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On 11/28/22 00:17, Sebastian Reichel wrote:
> Hi,
> 
> On Sun, Nov 27, 2022 at 07:02:25PM +0100, Hans de Goede wrote:
>> The pump_express_work which gets queued from an external_power_changed
>> callback might be pending / running on remove() (or on probe failure).
>>
>> Add a devm action cancelling the work, to ensure that it is cancelled.
>>
>> Note the devm action is added before devm_power_supply_register(), making
>> it run after devm unregisters the power_supply, so that the work cannot
>> be queued anymore (this is also why a devm action is used for this).
>>
>> Fixes: 48f45b094dbb ("power: supply: bq25890: Support higher charging voltages through Pump Express+ protocol")
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/power/supply/bq25890_charger.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
>> index 512c81662eea..30d77afab839 100644
>> --- a/drivers/power/supply/bq25890_charger.c
>> +++ b/drivers/power/supply/bq25890_charger.c
>> @@ -1317,6 +1317,13 @@ static int bq25890_fw_probe(struct bq25890_device *bq)
>>  	return 0;
>>  }
>>  
>> +static void bq25890_non_devm_cleanup(void *data)
>> +{
>> +	struct bq25890_device *bq = data;
>> +
>> +	cancel_delayed_work_sync(&bq->pump_express_work);
>> +}
>> +
>>  static int bq25890_probe(struct i2c_client *client)
>>  {
>>  	struct device *dev = &client->dev;
>> @@ -1372,6 +1379,10 @@ static int bq25890_probe(struct i2c_client *client)
>>  	/* OTG reporting */
>>  	bq->usb_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
>>  
>> +	ret = devm_add_action_or_reset(dev, bq25890_non_devm_cleanup, bq);
>> +	if (ret)
>> +		return ret;
> 
> ret = devm_delayed_work_autocancel(dev, &bq->pump_express_work, bq25890_pump_express_work);
> if (ret)
>     return ret;
> 
> (+ removing the INIT_DELAYED_WORK)

That is a good point, but patch 8/10 builds on top of this
and uses bq25890_non_devm_cleanup() to release the idr id
needed when using multiple chargers on one board.

And like cancelling the work this too can only be done
after unregistering the psy device, and since the psy device
is unregistered using devm this means the idr_remove() needs
to use a devm callback too (to get the ordering right).

I do plan to prepare a v2 for patches 2-10 addressing Marek's
remarks this morning but given the need to have a devm action
anyways (devm_delayed_work_autocancel() is just a convenience
wrapper around devm_add_action) I plan to keep this as is.

Otherwise we end up with 2 devm actions without any need for
having 2 of them.

Regards,

Hans







> 
> -- Sebastian
> 
>> +
>>  	ret = bq25890_register_regulator(bq);
>>  	if (ret)
>>  		return ret;
>> -- 
>> 2.38.1
>>


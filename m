Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B6C6E312E
	for <lists+linux-pm@lfdr.de>; Sat, 15 Apr 2023 13:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjDOLzf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Apr 2023 07:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjDOLze (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Apr 2023 07:55:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523354EED
        for <linux-pm@vger.kernel.org>; Sat, 15 Apr 2023 04:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681559695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g4bcTFJhp89gwlbELjscfHEtCVfUEvD/erElglQUSQk=;
        b=IzhiJEjDgd4M7WubufPBqYUqhkllMzhhzafI70HYdmw3yCjiA+XSC1c1Ty07fRnfQtK59g
        OEERMMcxEqlAkjFT0P77S6XnO+sTY7N0NwZTuS/0lCVZ0/lyZmEr+tJT3icFjP2SncTL0J
        zz0q2fxaC5E0EAqndbdKpmbGpL0nZPo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-SKEOd00yMZ2q1nDV6H4W_Q-1; Sat, 15 Apr 2023 07:54:53 -0400
X-MC-Unique: SKEOd00yMZ2q1nDV6H4W_Q-1
Received: by mail-ed1-f70.google.com with SMTP id b60-20020a509f42000000b00504eca73d05so6173983edf.18
        for <linux-pm@vger.kernel.org>; Sat, 15 Apr 2023 04:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681559692; x=1684151692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g4bcTFJhp89gwlbELjscfHEtCVfUEvD/erElglQUSQk=;
        b=BIxOngv3xXctqsb/8IYHjm3wBMVOh5YZ4D88VT9SbJI6T24oVWND2Uo76HTyLyNP9W
         JLKgMEuFM3C8KNKt9HlVgIuMQMjZK2vgokYu4rF+/NXeSnKnkR/zl83c8ZJQfyXsHImL
         Gt94nyGPEv9ghGgKTOZEEy4ENlCfQrPEMfSUcfhSAoEmrbDVYdteZekanUj+4orjoMvf
         TuziVdFKV0S+Im4xl6OkOkckYedkN1tcmpTRVocF7tM84PeG0E2zjSRbuZ6utCmCwdsB
         gQzQE5W3cvgWqCAlv3D+8wtH+U0wD8VXxb5Z5Z8Fr4cK8ft90p6mOGnWcNU5CGC/bBKS
         VaKg==
X-Gm-Message-State: AAQBX9eU0l3mW4vW3bo4wZfHO8YXFI5gzNdPzeiVtRRIAGwNXu2D3JWV
        lgcZ0oBPMo1qC9iYkf6DVLpGXcaQmpbd0nGRddGkWDNfaOVcEKRl2UmGKqt+kKmtoSmpn6Md3px
        o3hekyUbiCV4kCQwnqjQ=
X-Received: by 2002:a17:906:53d9:b0:94a:7097:7893 with SMTP id p25-20020a17090653d900b0094a70977893mr1955766ejo.40.1681559692669;
        Sat, 15 Apr 2023 04:54:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y2LH8n7cMQRgQwpvT27NOtKf5S63lRYGxzs2bmxAclfnY/xO2TJ+dTEQPmIIBm46fjE+q6sA==
X-Received: by 2002:a17:906:53d9:b0:94a:7097:7893 with SMTP id p25-20020a17090653d900b0094a70977893mr1955744ejo.40.1681559692288;
        Sat, 15 Apr 2023 04:54:52 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gj19-20020a170906e11300b0094a83007249sm3798793ejb.16.2023.04.15.04.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Apr 2023 04:54:51 -0700 (PDT)
Message-ID: <74434b1e-e1a2-4b86-4f3b-8f9caf1bc9f7@redhat.com>
Date:   Sat, 15 Apr 2023 13:54:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 9/9] power: supply: bq25890: Call power_supply_changed()
 after updating input current or voltage
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Marek Vasut <marex@denx.de>, laji Xiao <3252204392abc@gmail.com>,
        linux-pm@vger.kernel.org
References: <20230413095405.71685-1-hdegoede@redhat.com>
 <20230413095405.71685-10-hdegoede@redhat.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230413095405.71685-10-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 4/13/23 11:54, Hans de Goede wrote:
> The bq25892 model relies on external charger-type detection and once
> that is done the bq25890_charger code will update the input current
> and if pumpexpress is used also the input voltage.
> 
> In this case, when the initial power_supply_changed() call is made
> from the interrupt handler, the input settings are 5V/0.5A which
> on many devices is not enough power to charge (while the device is on).
> 
> On many devices the fuel-gauge relies in its external_power_changed
> callback to timely signal userspace about charging <-> discharging
> status changes. Add a power_supply_changed() call after updating
> the input current or voltage. This allows the fuel-gauge driver
> to timely recheck if the battery is charging after the new input
> settings have been applied and then it can immediately notify
> userspace about this.
> 
> Fixes: 48f45b094dbb ("power: supply: bq25890: Support higher charging voltages through Pump Express+ protocol")
> Fixes: eab25b4f93aa ("power: supply: bq25890: On the bq25892 set the IINLIM based on external charger detection")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/power/supply/bq25890_charger.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index bfe08d7bfaf3..794512285629 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -775,6 +775,7 @@ static void bq25890_charger_external_power_changed(struct power_supply *psy)
>  	}
>  
>  	bq25890_field_write(bq, F_IINLIM, input_current_limit);
> +	power_supply_changed(bq->charger);

Self NACK I just finished debugging a crash related to a race between
external_power_changed() callbacks and these callbacks using the
result of power_supply_register().

Referring to the psy for which the external power has changed
in external_power_changed() callbacks must always be done through
the psy argument. More info in my series fixing these races when
I'm done preparting the series.

For now please don't merge this patch, note patches 1-8 are
still fine. I'll post a v2 series later.

Regards,

Hans





>  }
>  
>  static int bq25890_get_chip_state(struct bq25890_device *bq,
> @@ -1106,6 +1107,8 @@ static void bq25890_pump_express_work(struct work_struct *data)
>  	dev_info(bq->dev, "Hi-voltage charging requested, input voltage is %d mV\n",
>  		 voltage);
>  
> +	power_supply_changed(bq->charger);
> +
>  	return;
>  error_print:
>  	bq25890_field_write(bq, F_PUMPX_EN, 0);


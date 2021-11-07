Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA41C4475E4
	for <lists+linux-pm@lfdr.de>; Sun,  7 Nov 2021 21:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbhKGUon (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Nov 2021 15:44:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234199AbhKGUom (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Nov 2021 15:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636317719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/kqIrqL+vk85B9hJxfus4EhDpiGAiNCwWUN+jiamhu4=;
        b=GnEzwFbmfexGz5lnY1TEdGjhnhYqQkj4ixOKSsyBtoZHz5SeFTgkdA2yf5QIgRGb4+j93P
        s28higQl1ic4v5kvegzYNFjr+KCcwPSXVIeL+SoB2oyP5PqkMvbzXbyRC/eaGiGai3mHKL
        U/rr34lRzp3VKwXmmPGK8/aSPcH5T34=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-eABlpqidMbKKwDtp773UVw-1; Sun, 07 Nov 2021 15:41:57 -0500
X-MC-Unique: eABlpqidMbKKwDtp773UVw-1
Received: by mail-ed1-f71.google.com with SMTP id z21-20020a05640240d500b003e3340a215aso2214104edb.10
        for <linux-pm@vger.kernel.org>; Sun, 07 Nov 2021 12:41:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/kqIrqL+vk85B9hJxfus4EhDpiGAiNCwWUN+jiamhu4=;
        b=oWu6k8lSGNFg5Gqw1osCoW69r9tjcBFlxX82HFOiSsV/fjC6FpPZ3dVUfiPOSknHL/
         AZwAbEI0KHDpT1DMy6++nwQxxwHPLzqWbr0nhw+0G+jFsIVY4TfM7J1Rh0uee5h9fFiy
         k/q0mMwIgMeOpcjSViNY9q/SRjQwzRP846GbJYkuWV6cy+YmAqY59mDjRR1RtQqROXua
         CEkwGlgQgC3kMnaW/rPwzteI0H6K9YpDxK8uo24geNbpemH+OEfwGE4yGQdnevrfxrY/
         0T6X4EuK2iOEuiBUCpQMgKuJTLuPETf2zIW0PxTWw51m0VMjBPMxqmSxIrJdt1/xSHs5
         +nEw==
X-Gm-Message-State: AOAM530Rw5W3a9ocGMkGms1+CCywv1Xr8Ju0jHJU6PD8UquJVe++qhJO
        FrJQs94n+T/NNJT5mIONFsL0uXieTo1lsQ98dvBW+SSqq+JC5CFjLWmWE7uZOtQ6J2nbUKjsOhQ
        7pb9kyu9BaDdCd808qvA=
X-Received: by 2002:a17:906:2ad2:: with SMTP id m18mr89431027eje.64.1636317716437;
        Sun, 07 Nov 2021 12:41:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEOv/EfT85ormddr4tpebZBgkmwolq/LisVfT+VBZZDoQDvhBEP+pwpItWilDCJpoOvWo/zA==
X-Received: by 2002:a17:906:2ad2:: with SMTP id m18mr89431011eje.64.1636317716265;
        Sun, 07 Nov 2021 12:41:56 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id sa3sm4775635ejc.113.2021.11.07.12.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 12:41:55 -0800 (PST)
Message-ID: <85a4674a-9212-6f02-d351-72b2223cc4a9@redhat.com>
Date:   Sun, 7 Nov 2021 21:41:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/4] bq25890: Add max input current limit property
Content-Language: en-US
To:     Yauhen Kharuzhy <jekhor@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211107202001.54579-1-jekhor@gmail.com>
 <20211107202001.54579-2-jekhor@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211107202001.54579-2-jekhor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Yauhen,

On 11/7/21 21:19, Yauhen Kharuzhy wrote:
> Add property 'ti,input-max-current' to define input current limit if
> needed. It will be applied if automatic charger type detection is
> disabled and using of ILIM pin is disabled or such pin defines greater
> limit than IINLIM field.

Sorry, but this makes no sense, as the datasheet says the charger
itself updates iinlim dynamically when it has done charger-type
detection (for the bq25890 version) and for the bq25892 version
which does not have the D+ + D- USB pins for BC1.2 detection,
the iinlim should be updated based on the charger detection
done elsewhere (by the Whiskey Cove PMIC in case of the Yoga Book).

My plan for this is to have drivers/extcon/extcon-intel-cht-wc.c
also register a power_supply device which models the detected
charger / negotiated external charger/power-brick settings and
which is the supplier of the bq25892 charger.

Then an external_power_changed handler can be added to the
bq25892_charger code using the
power_supply_set_input_current_limit_from_supplier()
helper to dynamically set iinlim based on the detected
"power-brick"/external-charger.

This is also how this is done for (X86) devices with an
full-featured USB Type-C port where this needs to be handled
by the kernel (rather then it being done in firmware) in
this case the current-max property of the Type-C power-supply
class device gets set either based on the Type-C pull-up
resistor in the charger (setting 0.5A / 1.5A / 3A), with
a fallback to BC1.2 for the 0.5A case, or based on the
USB-PD negotiated max-current.

Since we will need this mechanism to dynamically set
iinlim based on the PMIC-s charger-detection it seems
to me that setting it at boot is both unnecessary and a bad
idea, since we don't know the correct value to set at boot.

The extcon code will start a charger-detection cycle
as soon as it loads (if there is Vbus present) and then
trigger the external_power_changed handler .

TL;DR: I don't really see a need for this ?

Regards,

Hans




> ---
>  drivers/power/supply/bq25890_charger.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 34467bfb9537..1c43555d5bd8 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -85,6 +85,7 @@ struct bq25890_init_data {
>  	u8 treg;	/* thermal regulation threshold */
>  	u8 rbatcomp;	/* IBAT sense resistor value    */
>  	u8 vclamp;	/* IBAT compensation voltage limit */
> +	u8 iinlim_max;	/* maximum input current limit allowed */
>  };
>  
>  struct bq25890_state {
> @@ -657,6 +658,7 @@ static int bq25890_hw_init(struct bq25890_device *bq)
>  		{F_TREG,	 bq->init_data.treg},
>  		{F_BATCMP,	 bq->init_data.rbatcomp},
>  		{F_VCLAMP,	 bq->init_data.vclamp},
> +		{F_IINLIM,	 bq->init_data.iinlim_max},
>  	};
>  
>  	ret = bq25890_chip_reset(bq);
> @@ -870,11 +872,13 @@ static int bq25890_fw_read_u32_props(struct bq25890_device *bq)
>  		{"ti,thermal-regulation-threshold", true, TBL_TREG, &init->treg},
>  		{"ti,ibatcomp-micro-ohms", true, TBL_RBATCOMP, &init->rbatcomp},
>  		{"ti,ibatcomp-clamp-microvolt", true, TBL_VBATCOMP, &init->vclamp},
> +		{"ti,input-max-current", true, TBL_IINLIM, &init->iinlim_max},
>  	};
>  
>  	/* initialize data for optional properties */
>  	init->treg = 3; /* 120 degrees Celsius */
>  	init->rbatcomp = init->vclamp = 0; /* IBAT compensation disabled */
> +	init->iinlim_max = 0x3f;
>  
>  	for (i = 0; i < ARRAY_SIZE(props); i++) {
>  		ret = device_property_read_u32(bq->dev, props[i].name,
> 


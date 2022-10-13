Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61355FD717
	for <lists+linux-pm@lfdr.de>; Thu, 13 Oct 2022 11:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiJMJ3j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Oct 2022 05:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiJMJ3i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Oct 2022 05:29:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BECE8A
        for <linux-pm@vger.kernel.org>; Thu, 13 Oct 2022 02:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665653375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=35SImz7Mq70+08Qp+ZNeB6crhhV4PXeT2AlA9zAroTc=;
        b=BMw7kkrt5oiQt9MNsB29q9Qe1d4nPrlgkBAgl9o4jPMfAK9UwfM0daSl/26SkWPBRY2DMw
        EbjVlkFU72vvqYdBMYpUAvu+iavQaBALEv4RUlTFUjkcU+CmJr+fClk+TQeuxOIiFfihsH
        +nxt4MRKvtbgjEaHlZxAV/9UaZm6cFM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-88-z3yyk6tpMLyHA0qLD_h2tw-1; Thu, 13 Oct 2022 05:29:34 -0400
X-MC-Unique: z3yyk6tpMLyHA0qLD_h2tw-1
Received: by mail-ej1-f72.google.com with SMTP id xj11-20020a170906db0b00b0077b6ecb23fcso599924ejb.5
        for <linux-pm@vger.kernel.org>; Thu, 13 Oct 2022 02:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35SImz7Mq70+08Qp+ZNeB6crhhV4PXeT2AlA9zAroTc=;
        b=fstMl0jKfmRqQXQ67hoLKvZMIgbbfAr9Lb/6EkR1J5yOSq/OqXNuZ5iesTAdYgCofv
         i2Pf+znTrl7AsTGYcnvh5sG9ayaTE26LdBRRfgUVrx2byXFCGL0UvXvLrRIiZgErGfR0
         zBMHZr5XppYbsIgVYdOiE6vebXLNTGu6cLj9vuMtMOxG3KBHOBkHQicy9rRDhRq0md9J
         K3OwJEkCeHTAhIbicQLTZFVowNXfjA1Aay3xvNjgCq9n9TAxfWV7n2pUABS0G/rPwYfX
         GPoG0SKQuthX9xhKp2rOyG1WnSsnHdRc7vxSKZ8704Ub8fEg+0wI3gDOu5EKsrsa+bYo
         YXbA==
X-Gm-Message-State: ACrzQf0f9rtdXmxbP2RBZjFvNH59ZLogKoyUHgYzFhATAicA7pq6upEE
        4AlrWzoSZbMsbDRimnYnG83v4Xmf8yxGjOitoSzGnfkyTqDszt3ZdIzpT/pQZsJ0pgBtdjZ8x9u
        jDWvrxlE68ZFPjUW7AMY=
X-Received: by 2002:a17:907:1689:b0:78d:e460:1d98 with SMTP id hc9-20020a170907168900b0078de4601d98mr8649142ejc.451.1665653372587;
        Thu, 13 Oct 2022 02:29:32 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5sJqR9CZX+21JVwf9a99UnoXsS8mZyOLnK1LcRu7cDuOkXnJ15YIUzFGY9e+4V3cTOy/T4AA==
X-Received: by 2002:a17:907:1689:b0:78d:e460:1d98 with SMTP id hc9-20020a170907168900b0078de4601d98mr8649137ejc.451.1665653372421;
        Thu, 13 Oct 2022 02:29:32 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id d6-20020a50f686000000b00459e3a3f3ddsm13136843edn.79.2022.10.13.02.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 02:29:31 -0700 (PDT)
Message-ID: <4bc6f02e-ca1e-28da-59a4-44fefdfc17ad@redhat.com>
Date:   Thu, 13 Oct 2022 11:29:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 7/7] power: supply: bq25890: Add Vsys regulator
Content-Language: en-US, nl
To:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221010210310.165461-1-marex@denx.de>
 <20221010210310.165461-7-marex@denx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221010210310.165461-7-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 10/10/22 23:03, Marek Vasut wrote:
> The chip is capable of reporting Vsys voltage supplied to the system.
> Add regulator which represents the Vsys supply. This can be used e.g.
> as a supply for system PMIC input.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> To: linux-pm@vger.kernel.org

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/power/supply/bq25890_charger.c | 32 ++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 2be5861cfcb66..d8c39a0d6c965 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -1106,6 +1106,20 @@ static int bq25890_vbus_get_voltage(struct regulator_dev *rdev)
>  	return bq25890_get_vbus_voltage(bq);
>  }
>  
> +static int bq25890_vsys_get_voltage(struct regulator_dev *rdev)
> +{
> +	struct bq25890_device *bq = rdev_get_drvdata(rdev);
> +	int ret;
> +
> +	/* Should be some output voltage ? */
> +	ret = bq25890_field_read(bq, F_SYSV); /* read measured value */
> +	if (ret < 0)
> +		return ret;
> +
> +	/* converted_val = 2.304V + ADC_val * 20mV (table 10.3.15) */
> +	return 2304000 + ret * 20000;
> +}
> +
>  static const struct regulator_ops bq25890_vbus_ops = {
>  	.get_voltage = bq25890_vbus_get_voltage,
>  };
> @@ -1133,6 +1147,18 @@ static const struct regulator_desc bq25890_vbus_boost_desc = {
>  	.ops = &bq25890_vbus_boost_ops,
>  };
>  
> +static const struct regulator_ops bq25890_vsys_ops = {
> +	.get_voltage = bq25890_vsys_get_voltage,
> +};
> +
> +static const struct regulator_desc bq25890_vsys_desc = {
> +	.name = "vsys",
> +	.of_match = "vsys",
> +	.type = REGULATOR_VOLTAGE,
> +	.owner = THIS_MODULE,
> +	.ops = &bq25890_vsys_ops,
> +};
> +
>  static int bq25890_register_regulator(struct bq25890_device *bq)
>  {
>  	struct bq25890_platform_data *pdata = dev_get_platdata(bq->dev);
> @@ -1155,6 +1181,12 @@ static int bq25890_register_regulator(struct bq25890_device *bq)
>  				     "registering vbus regulator");
>  	}
>  
> +	reg = devm_regulator_register(bq->dev, &bq25890_vsys_desc, &cfg);
> +	if (IS_ERR(reg)) {
> +		return dev_err_probe(bq->dev, PTR_ERR(reg),
> +				     "registering vsys regulator");
> +	}
> +
>  	return 0;
>  }
>  #else


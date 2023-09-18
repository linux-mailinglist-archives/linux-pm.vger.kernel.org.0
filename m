Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A197A4082
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 07:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239569AbjIRFiO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 01:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239770AbjIRFiC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 01:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9DBD2
        for <linux-pm@vger.kernel.org>; Sun, 17 Sep 2023 22:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695015431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y6uwQw2TQzRDCyynk3SluHNCszt0yuiUGbPEkJxyENg=;
        b=inS5QGW24ViX/b7wG4uom/FSlFBMRileZ+h1ImFkN47PAzAWkkS2pT2vyAvBHsUkdiTcYz
        mfD4IOBZKKOW/+e47w8EXvq2+GnPAwUFhLXm8Zkqbm00ld4yX0omDje5QgLlRhtD5prNrF
        /bH+01AlOZp72ll+0BwnWRqYdCtXwIc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-_lPUbKi5OUmOP_8rgJNyPQ-1; Mon, 18 Sep 2023 01:37:07 -0400
X-MC-Unique: _lPUbKi5OUmOP_8rgJNyPQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1c3257c8971so42669675ad.0
        for <linux-pm@vger.kernel.org>; Sun, 17 Sep 2023 22:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695015426; x=1695620226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6uwQw2TQzRDCyynk3SluHNCszt0yuiUGbPEkJxyENg=;
        b=AXN9uep/GH2+PyKrai4pN8oFJ8Efz7ZA6yiaFK2lqEKs6i4XqAA9X/R/VZsiUTx8ux
         K9AbGVl/ZYiwXHdKDPvFyhhupfJ0Oain6KdXU9HHyrEZrd3rj0W/8JFXkeGR6eCHHjLY
         tgFlraKP/6RAyAh3femmQvFfgYZGKZ+o3lEzzsHNnGmShvSP0nEug4GGxlnwh6ZzGzHs
         +zSQCXNF2BmcQIyrBWQtMnGJnQrxloF0cCCpEXn/7sIG1cmWlVuLQWNBP8TrVndw3oI9
         VO+/zGJAGhr1Wg7NGNfR/Dwivcl/bPvNWVbMpmlQsEXWyKTec8nSPNhHrumCs6Zkhudq
         DBMA==
X-Gm-Message-State: AOJu0YxEEO5xiPFLkF9G93KcSf7HcKvmocts4xTU1aR0tj6QchlowGDi
        VCqYuSXxSR/EAHakcR/4jkKKCn872EdRwtRbsJ9AqwterUhzrGf5y028mymu9zQnd7wo5B4sxfn
        XhNviarifjYB1OzzuEos=
X-Received: by 2002:a17:902:ab12:b0:1c3:df77:3159 with SMTP id ik18-20020a170902ab1200b001c3df773159mr7962012plb.50.1695015426136;
        Sun, 17 Sep 2023 22:37:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4LA6vy59tdBGF7Ljgoach/YoGNT9CDJsVEh22V2F8alWKcyjdRZQRbNbCFRoo5eBTb6guIw==
X-Received: by 2002:a17:902:ab12:b0:1c3:df77:3159 with SMTP id ik18-20020a170902ab1200b001c3df773159mr7962003plb.50.1695015425836;
        Sun, 17 Sep 2023 22:37:05 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902e54500b001b9d95945afsm7488399plf.155.2023.09.17.22.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 22:37:05 -0700 (PDT)
Message-ID: <add60819-1d36-9b96-7bfa-148907dc44ce@redhat.com>
Date:   Mon, 18 Sep 2023 15:36:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 19/35] ACPI: Move acpi_bus_trim_one() before
 acpi_scan_hot_remove()
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-20-james.morse@arm.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230913163823.7880-20-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 9/14/23 02:38, James Morse wrote:
> A subsequent patch will change acpi_scan_hot_remove() to call
> acpi_bus_trim_one() instead of acpi_bus_trim(), meaning it can no longer
> rely on the prototype in the header file.
> 
> Move these functions further up the file.
> No change in behaviour.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   drivers/acpi/scan.c | 76 ++++++++++++++++++++++-----------------------
>   1 file changed, 38 insertions(+), 38 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index f898591ce05f..a675333618ae 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -244,6 +244,44 @@ static int acpi_scan_try_to_offline(struct acpi_device *device)
>   	return 0;
>   }
>   
> +static int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
> +{
> +	struct acpi_scan_handler *handler = adev->handler;
> +
> +	acpi_dev_for_each_child_reverse(adev, acpi_bus_trim_one, NULL);
> +
> +	adev->flags.match_driver = false;
> +	if (handler) {
> +		if (handler->detach)
> +			handler->detach(adev);
> +
> +		adev->handler = NULL;
> +	} else {
> +		device_release_driver(&adev->dev);
> +	}
> +	/*
> +	 * Most likely, the device is going away, so put it into D3cold before
> +	 * that.
> +	 */
> +	acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
> +	adev->flags.initialized = false;
> +	acpi_device_clear_enumerated(adev);
> +
> +	return 0;
> +}
> +
> +/**
> + * acpi_bus_trim - Detach scan handlers and drivers from ACPI device objects.
> + * @adev: Root of the ACPI namespace scope to walk.
> + *
> + * Must be called under acpi_scan_lock.
> + */
> +void acpi_bus_trim(struct acpi_device *adev)
> +{
> +	acpi_bus_trim_one(adev, NULL);
> +}
> +EXPORT_SYMBOL_GPL(acpi_bus_trim);
> +
>   static int acpi_scan_hot_remove(struct acpi_device *device)
>   {
>   	acpi_handle handle = device->handle;
> @@ -2506,44 +2544,6 @@ int acpi_bus_scan(acpi_handle handle)
>   }
>   EXPORT_SYMBOL(acpi_bus_scan);
>   
> -static int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
> -{
> -	struct acpi_scan_handler *handler = adev->handler;
> -
> -	acpi_dev_for_each_child_reverse(adev, acpi_bus_trim_one, NULL);
> -
> -	adev->flags.match_driver = false;
> -	if (handler) {
> -		if (handler->detach)
> -			handler->detach(adev);
> -
> -		adev->handler = NULL;
> -	} else {
> -		device_release_driver(&adev->dev);
> -	}
> -	/*
> -	 * Most likely, the device is going away, so put it into D3cold before
> -	 * that.
> -	 */
> -	acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
> -	adev->flags.initialized = false;
> -	acpi_device_clear_enumerated(adev);
> -
> -	return 0;
> -}
> -
> -/**
> - * acpi_bus_trim - Detach scan handlers and drivers from ACPI device objects.
> - * @adev: Root of the ACPI namespace scope to walk.
> - *
> - * Must be called under acpi_scan_lock.
> - */
> -void acpi_bus_trim(struct acpi_device *adev)
> -{
> -	acpi_bus_trim_one(adev, NULL);
> -}
> -EXPORT_SYMBOL_GPL(acpi_bus_trim);
> -
>   int acpi_bus_register_early_device(int type)
>   {
>   	struct acpi_device *device = NULL;

Thanks,
Gavin


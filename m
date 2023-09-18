Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978567A404C
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 07:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239504AbjIRFEG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 01:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbjIRFD5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 01:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB2310C
        for <linux-pm@vger.kernel.org>; Sun, 17 Sep 2023 22:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695013386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hCDoXZnQJiBgGjXOi0ciKhKqeO4OfqPdXpxnEdvp7mI=;
        b=OyBEYO6orn2cEbaDBI8d4xPfvVMiIcy3ewIclGczX9m3uJs/JvUX0cSqnN3oHSt+kdbdNp
        Gy9BcUF+DCUQ3eOvO0hGIHPEkr5LGHoXFlorMLGWDhMN8lgfzz/3nEmYEqslL3OJmobeqm
        +XyZDV2nParLKJhVisp+DGBSyN45HAI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-6gQNOS-sPn6N47GasFV5lw-1; Mon, 18 Sep 2023 01:03:02 -0400
X-MC-Unique: 6gQNOS-sPn6N47GasFV5lw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-68fb9874533so4095595b3a.1
        for <linux-pm@vger.kernel.org>; Sun, 17 Sep 2023 22:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695013381; x=1695618181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hCDoXZnQJiBgGjXOi0ciKhKqeO4OfqPdXpxnEdvp7mI=;
        b=Rigi6jcrSvmd9+wBkUfa4bx+pMbHYYjOaz/p5YN7UvvBD1Gy6CKLVNyc9t3Y80vDqa
         /T/71byWpCl19avObAkNDHtBSRf+6qahPHmRyKVTS9t3O+O4ZweDeE6SphGUQ201Dxvg
         WA0B3HfMtnT3noz5iFuQgFSIpotb6uW2ii500YEVegd4Ndm9dMLsb7AWBw9XvHSLLWAs
         Zq4k2YiPrTlf+j/uMrjCYEaWa56MR8EkIjB8qKM85ZGIf4ZQV6sf2ZRcCZQgFWRpC9MN
         YasbtxzepIv3LElz9mdMSHm/9CT0/1ADfxtgBWcNy5ViG0fFoLYd7d81quuDDC6CdP39
         dyUw==
X-Gm-Message-State: AOJu0YyiWYKhfjDqjekSnIhHJGjjbQkUmJoqg1dmu9JZKS2tYl4DyeMu
        launkVeijTXeujP3rr2qo/aBLclJ7xoxXJxfHX9banpF3w0l8imp1kTSrVqGGm+XCC7HCYYwtgB
        kuObMMdeQYEzlz0dI1uw=
X-Received: by 2002:a05:6a00:2344:b0:68e:43ed:d30b with SMTP id j4-20020a056a00234400b0068e43edd30bmr6879606pfj.21.1695013381109;
        Sun, 17 Sep 2023 22:03:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqmnfE9QFPe9E5tdKFUUF/pg2T2yxaduIzlP4FnKDLuVWyov/hE0tCEtGqZQwTLT17gzDFFw==
X-Received: by 2002:a05:6a00:2344:b0:68e:43ed:d30b with SMTP id j4-20020a056a00234400b0068e43edd30bmr6879587pfj.21.1695013380748;
        Sun, 17 Sep 2023 22:03:00 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id j26-20020aa783da000000b00687a4b70d1esm6322062pfn.218.2023.09.17.22.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 22:03:00 -0700 (PDT)
Message-ID: <50571c2f-aa3c-baeb-3add-cd59e0eddc02@redhat.com>
Date:   Mon, 18 Sep 2023 15:02:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 15/35] ACPI: processor: Add support for processors
 described as container packages
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
 <20230913163823.7880-16-james.morse@arm.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230913163823.7880-16-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 9/14/23 02:38, James Morse wrote:
> ACPI has two ways of describing processors in the DSDT. Either as a device
> object with HID ACPI0007, or as a type 'C' package inside a Processor
> Container. The ACPI processor driver probes CPUs described as devices, but
> not those described as packages.
> 
> Duplicate descriptions are not allowed, the ACPI processor driver already
> parses the UID from both devices and containers. acpi_processor_get_info()
> returns an error if the UID exists twice in the DSDT.
> 
> The missing probe for CPUs described as packages creates a problem for
> moving the cpu_register() calls into the acpi_processor driver, as CPUs
> described like this don't get registered, leading to errors from other
> subsystems when they try to add new sysfs entries to the CPU node.
> (e.g. topology_sysfs_init()'s use of topology_add_dev() via cpuhp)
> 
> To fix this, parse the processor container and call acpi_processor_add()
> for each processor that is discovered like this. The processor container
> handler is added with acpi_scan_add_handler(), so no detach call will
> arrive.
> 
> Qemu TCG describes CPUs using packages in a processor container.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   drivers/acpi/acpi_processor.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 

I don't understand the last sentence of the commit log. QEMU
always have "ACPI0007" for the processor devices.

#define ACPI_PROCESSOR_DEVICE_HID      "ACPI0007"
#define ACPI_PROCESSOR_OBJECT_HID      "LNXCPU"

[gshan@gshan q]$ git grep ACPI0007
hw/acpi/cpu.c:                aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0007")));
hw/arm/virt-acpi-build.c:        aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0007")));
hw/riscv/virt-acpi-build.c:            aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0007")));
[gshan@gshan q]$ git grep LNXCPU

> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index c0839bcf78c1..b4bde78121bb 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -625,9 +625,31 @@ static struct acpi_scan_handler processor_handler = {
>   	},
>   };
>   
> +static acpi_status acpi_processor_container_walk(acpi_handle handle,
> +						 u32 lvl,
> +						 void *context,
> +						 void **rv)
> +{
> +	struct acpi_device *adev;
> +	acpi_status status;
> +
> +	adev = acpi_get_acpi_dev(handle);
> +	if (!adev)
> +		return AE_ERROR;
> +
> +	status = acpi_processor_add(adev, &processor_device_ids[0]);
> +	acpi_put_acpi_dev(adev);
> +
> +	return status;
> +}
> +
>   static int acpi_processor_container_attach(struct acpi_device *dev,
>   					   const struct acpi_device_id *id)
>   {
> +	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, dev->handle,
> +			    ACPI_UINT32_MAX, acpi_processor_container_walk,
> +			    NULL, NULL, NULL);
> +
>   	return 1;
>   }
>   

Thanks,
Gavin


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BF47A56C2
	for <lists+linux-pm@lfdr.de>; Tue, 19 Sep 2023 02:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjISA6F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 20:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjISA6E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 20:58:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC83107
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 17:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695085035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bIURaVhU/G5DJJinyquD0ptYbPAZ38yx5KNcjiMal4E=;
        b=gC3jNUheufzzhpYHMirHAPAI7iG2RUsIou7U4YVu9DNdTw/I25q6xjs6TXyV9ZoJHxKjfR
        GcZr6ao7enfrFh++gaJwy0DxaYHusKD/EDKMjT10oDFnOq2A7TWDzt8lh77O4Ee9ToQY4O
        cnP3qF3vLJdbGX81j9xZwh/mF/WN6jI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-wfnpTGx5Pi2s9EmhVxJl9Q-1; Mon, 18 Sep 2023 20:49:41 -0400
X-MC-Unique: wfnpTGx5Pi2s9EmhVxJl9Q-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-690a0eedb24so868863b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 17:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695084581; x=1695689381;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bIURaVhU/G5DJJinyquD0ptYbPAZ38yx5KNcjiMal4E=;
        b=QDT8fl7XpM2ZyNRiJ+Q3Z7S8amcrfq4LdXpyuZ8ecpgGUihZHau6OAfearO0tzi8p8
         AeXOFAUuodnPHxFTQ4RtpC6rPefMhEcHkqjnXsHdvJKEl4UAiXeGxEdHMktghMknfWuQ
         1RzD//ih/vkio/2iIIpsHaeYdBzZXWQClpjeNTfi/cvm+ZxFHqZYCksTitCvdevu/Rdr
         ALrAWzxRGoiwdhdOKXqfwvXvUXtbDpvpR5WPdePjrYc26+61pqG3o8TUuUcIan1iDex8
         2ALXlrb/2sl4K5R1MZqIFXwlc6jJzchGBkQo83//JCCfMicP3q21Gqb+Q8txZAOyCfgu
         wTEg==
X-Gm-Message-State: AOJu0YwlYp5j7yfCLQczOYiJQ3mAocWv9/cWCr85kBybdSeuua7GSsjP
        sJxkodwIKb0Trq1a/DxWq8odc8mGsN1FSN7LsBLKaLHin/tHHJkb/kFdPu5furIrgGvNfJVxs+x
        +87G4rvu7cHbqL+F36m0=
X-Received: by 2002:a05:6a00:13a9:b0:68a:6173:295b with SMTP id t41-20020a056a0013a900b0068a6173295bmr11687170pfg.2.1695084580786;
        Mon, 18 Sep 2023 17:49:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3oVg5VMiqyNQpSBftI/mkgS1m694rJEONxMKwBMkdMp9Ry/rErZrzBJO2CPP2aN+mnlKKqg==
X-Received: by 2002:a05:6a00:13a9:b0:68a:6173:295b with SMTP id t41-20020a056a0013a900b0068a6173295bmr11687156pfg.2.1695084580437;
        Mon, 18 Sep 2023 17:49:40 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id i13-20020aa787cd000000b0068fe76cdc62sm70310pfo.93.2023.09.18.17.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 17:49:39 -0700 (PDT)
Message-ID: <54c91de8-f0d2-787f-5710-2da1dfc80937@redhat.com>
Date:   Tue, 19 Sep 2023 10:49:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 23/35] ACPI: Warn when the present bit changes but
 the feature is not enabled
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
 <20230913163823.7880-24-james.morse@arm.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230913163823.7880-24-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 9/14/23 02:38, James Morse wrote:
> ACPI firmware can trigger the events to add and remove CPUs, but the
> OS may not support this.
> 
> Print a warning when this happens.
           ^^^^^^^
           error message
> 
> This gives early warning on arm64 systems that don't support
> CONFIG_ACPI_HOTPLUG_PRESENT_CPU, as making CPUs not present has
> side effects for other parts of the system.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   drivers/acpi/acpi_processor.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 

Maybe a warning message is enough, but a error message
is also fine, I think.

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 2cafea1edc24..b67616079751 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -188,8 +188,10 @@ static int acpi_processor_make_present(struct acpi_processor *pr)
>   	acpi_status status;
>   	int ret;
>   
> -	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU))
> +	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU)) {
> +		pr_err_once("Changing CPU present bit is not supported\n");
>   		return -ENODEV;
> +	}
>   
>   	if (invalid_phys_cpuid(pr->phys_id))
>   		return -ENODEV;
> @@ -462,8 +464,10 @@ static void acpi_processor_make_not_present(struct acpi_device *device)
>   {
>   	struct acpi_processor *pr;
>   
> -	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU))
> +	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU)) {
> +		pr_err_once("Changing CPU present bit is not supported");
>   		return;
> +	}
>   
>   	pr = acpi_driver_data(device);
>   	if (pr->id >= nr_cpu_ids)

Thanks,
Gavin


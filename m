Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352624B4E8D
	for <lists+linux-pm@lfdr.de>; Mon, 14 Feb 2022 12:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241760AbiBNLcK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Feb 2022 06:32:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351661AbiBNLai (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Feb 2022 06:30:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4D2449274
        for <linux-pm@vger.kernel.org>; Mon, 14 Feb 2022 03:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644837185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cd7FfNhaOUqw4MafFCrvctc+5I4/l56rH8rjuuoMQx8=;
        b=EphOaXML+De4JBnoV8MLtsu1dTXpX7nu0Okpc1fb0oxHJYW3DKnuggN1+7oxGeQf6baVjx
        RYFcDrZbBW2GlIQNxsa0wA+1JTZNTZuFGYKnAnzqiOrQYOiwKWMk8U9ago7r+uhRHK7N+2
        VRaequv/pYkBlrr9p8RTa2usgel9fzw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-beJGX6_cPtG7YC5_Lig2Ow-1; Mon, 14 Feb 2022 06:13:04 -0500
X-MC-Unique: beJGX6_cPtG7YC5_Lig2Ow-1
Received: by mail-ej1-f70.google.com with SMTP id r18-20020a17090609d200b006a6e943d09eso5681412eje.20
        for <linux-pm@vger.kernel.org>; Mon, 14 Feb 2022 03:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cd7FfNhaOUqw4MafFCrvctc+5I4/l56rH8rjuuoMQx8=;
        b=enXCLk+F2KpfqawZjWXNN5URrtNh1kGavcC6OQC6qKBeY+FjbNpZ8uucFt//IOiIlM
         V8O4tzZO4kcS6Fj0DylrRzlQIed76qoktIv0H05RA9rj+0e17p1XiyK376g2W7LMRNKr
         Q9Nua5PbfxxWQV4r4NwN/IPmBfflhYQdHJTviBUrx8HeDgqCasPutce5/1Z4VVRBA1v2
         6mVWEiryTioJhA1Taoy1X06BOlHNXRxMEgXaq7adBmzk4/xzJbWiWCb15j2CpEMr6/EI
         DTn5JDtECB2A8cmvF5/XbCRENbl8XMy/WWmsNayb/K/OUvYJ9gu5xIsp8Wunk/lCiwAJ
         MqsA==
X-Gm-Message-State: AOAM531wJZXbxW2IV4eZ6er+anQHlTi5hdK3VMyQMTw4Q1sOgw8ec/oj
        P+7tMcxHEMhrGPuBL56QG7P1upONa7vGRvqrzp9Pq+63S0zlwA2JDYe1IHGTimEqVpkxr9lLuuL
        0q3ZgpWxUR55acuvjEz0=
X-Received: by 2002:aa7:d40f:: with SMTP id z15mr11148451edq.357.1644837183435;
        Mon, 14 Feb 2022 03:13:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzaDY+IY+Ydj+aXMFKhLtloPk4nt05m+QD+99CTBrzop3qEzQnXTRrUQXMBvsF014QaDo+TYg==
X-Received: by 2002:aa7:d40f:: with SMTP id z15mr11148436edq.357.1644837183291;
        Mon, 14 Feb 2022 03:13:03 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id z5sm10405008eja.20.2022.02.14.03.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 03:13:02 -0800 (PST)
Message-ID: <ecd789b3-74df-f4fe-ae66-8728f9bf24ab@redhat.com>
Date:   Mon, 14 Feb 2022 12:13:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] fix linux 5.16 freeze regression on 32-bit ThinkPad T40
Content-Language: en-US
To:     Woody Suwalski <wsuwalski@gmail.com>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <80742062-8629-3978-e78d-92ffc9bb2e0b@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <80742062-8629-3978-e78d-92ffc9bb2e0b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 2/9/22 22:05, Woody Suwalski wrote:
> From: Woody Suwalski <wsuwalski@gmail.com>
> 
> Add and ACPI idle power level limit for 32-bit ThinkPad T40.
> 
> There is a regression on T40 introduced by commit d6b88ce2, starting with kernel 5.16:
> 
> commit d6b88ce2eb9d2698eb24451eb92c0a1649b17bb1
> Author: Richard Gong <richard.gong@amd.com>
> Date:   Wed Sep 22 08:31:16 2021 -0500
> 
>     ACPI: processor idle: Allow playing dead in C3 state
> 
> The above patch is trying to enter C3 state during init, what is causing a T40 system freeze. I have not found a similar issue on any other of my 32-bit machines.
> 
> The fix is to add another exception to the processor_power_dmi_table[] list.
> As a result the dmesg shows as expected:
> 
>     2.155398] ACPI: IBM ThinkPad T40 detected - limiting to C2 max_cstate. Override with "processor.max_cstate=9"
> [    2.155404] ACPI: processor limited to max C-state 2
> 
> The fix is trivial and affects only vintage T40 systems.
> 
> Signed-off-by: Woody Suwalski <wsuwalski@gmail.com>
> ---

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> --- a/drivers/acpi/processor_idle.c    2022-02-04 09:09:54.515906362 -0500
> +++ b/drivers/acpi/processor_idle.c    2022-02-04 14:21:08.264911271 -0500
> @@ -96,6 +96,11 @@ static const struct dmi_system_id proces
>        DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
>        DMI_MATCH(DMI_PRODUCT_NAME,"L8400B series Notebook PC")},
>       (void *)1},
> +    /* T40 can not handle C3 idle state */
> +    { set_max_cstate, "IBM ThinkPad T40", {
> +      DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
> +      DMI_MATCH(DMI_PRODUCT_NAME, "23737CU")},
> +     (void *)2},
>      {},
>  };
> 
> 


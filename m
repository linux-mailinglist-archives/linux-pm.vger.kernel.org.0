Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CE34DD6BE
	for <lists+linux-pm@lfdr.de>; Fri, 18 Mar 2022 10:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiCRJCW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Mar 2022 05:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiCRJCV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2022 05:02:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F7471F89D8
        for <linux-pm@vger.kernel.org>; Fri, 18 Mar 2022 02:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647594062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R9vj4kn+OCOdsFlfKFDqgJw0bLwF2E8LWLm3AjC+7KU=;
        b=fCGrP4nuDKCMVvVNKKDnM5p7H4F4MOmTR5r8A7cUf7LeOWtlLl3Wjp2aNbl/H3ST/J4Rb1
        QYqANhID1E+qIgTG3pC9D1MnuwQwDU3OlVEmSwH32kim1CZLnpVJ6fw/XyyTazVF/g9hH/
        jN99HJoYaD6Vr3JyeA6vQSnpBcGlAi8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-278-XomqMgCQNouoxKR3iy4r8Q-1; Fri, 18 Mar 2022 05:01:01 -0400
X-MC-Unique: XomqMgCQNouoxKR3iy4r8Q-1
Received: by mail-ej1-f71.google.com with SMTP id ga31-20020a1709070c1f00b006cec400422fso4201745ejc.22
        for <linux-pm@vger.kernel.org>; Fri, 18 Mar 2022 02:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R9vj4kn+OCOdsFlfKFDqgJw0bLwF2E8LWLm3AjC+7KU=;
        b=SuOWpZINV9s8C2qQwapdgUVRqMQsqK6v3eHswtiNAWlj+MZ1KO60OvTJu8HdyMDt4z
         vQ3z1knfgopIcDjHOi5q9ZBwV1tSq/eIGkQoqxoaPgCrRE5N9+lt5Mkqj9/gUHzO3fXr
         3XJCXPWlcj1XunDyEBruDhBnloJXHxKZgqnm64tVu8qfTkioLwYzVL1roI51KK2LOzf3
         ATQeWt0+gVsHXNnyK++a3wbidr+Baue5HaIIPDpvLoqGeELyqDrzl1mebVz/ExzsRpoA
         eMhPiL+M0N1CI9QFQBjTYMOACLk3GGsOwRUFY5ds594oJ4ahROB5vLxTvHAnjoWM/L9a
         jceg==
X-Gm-Message-State: AOAM531BkC6yjSkZmRPYGMBQvnw2mDLLnIyCDX+Zimt1NubbL4idAslj
        3g+oMworjSvailI1e+TyJ2OnmJRQL+XG+1ck70eVlx5/StX8h1QUoTwYKt0CYulslIpzdT4QNVY
        AAlNhhuKtWQY1MTx6wrI=
X-Received: by 2002:a05:6402:2711:b0:416:6442:76dc with SMTP id y17-20020a056402271100b00416644276dcmr8666822edd.314.1647594060063;
        Fri, 18 Mar 2022 02:01:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQV3U1yHxHRJKifRnvpPhtZiu6ruvQHw0HDBh7W+OqqVtC+9x8xj7Yqu8km6BslQKfEAx9Ag==
X-Received: by 2002:a05:6402:2711:b0:416:6442:76dc with SMTP id y17-20020a056402271100b00416644276dcmr8666809edd.314.1647594059891;
        Fri, 18 Mar 2022 02:00:59 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:cdb2:2781:c55:5db0? (2001-1c00-0c1e-bf00-cdb2-2781-0c55-5db0.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:cdb2:2781:c55:5db0])
        by smtp.gmail.com with ESMTPSA id f2-20020a170906738200b006df69629a3dsm3485121ejl.28.2022.03.18.02.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 02:00:59 -0700 (PDT)
Message-ID: <3c890d11-75c6-8370-5659-a78b1a9baea2@redhat.com>
Date:   Fri, 18 Mar 2022 10:00:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/4] power: supply: max17042_battery: Add unit conversion
 macros
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     Purism Kernel Team <kernel@puri.sm>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220318001048.20922-1-sebastian.krzyszkowiak@puri.sm>
 <20220318001048.20922-2-sebastian.krzyszkowiak@puri.sm>
 <97d88728-4e73-0820-07e7-199377ebff2a@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <97d88728-4e73-0820-07e7-199377ebff2a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 3/18/22 09:16, Krzysztof Kozlowski wrote:
> On 18/03/2022 01:10, Sebastian Krzyszkowiak wrote:
>> Instead of sprinkling the code with magic numbers, put the unit
>> definitions used by the gauge into a set of macros. Macros are
>> used instead of simple defines in order to not require floating
>> point operations for divisions.
>>
>> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
>> ---
>>  drivers/power/supply/max17042_battery.c | 40 +++++++++++++++----------
>>  1 file changed, 24 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
>> index ab031bbfbe78..c019d6c52363 100644
>> --- a/drivers/power/supply/max17042_battery.c
>> +++ b/drivers/power/supply/max17042_battery.c
>> @@ -51,6 +51,15 @@
>>  
>>  #define MAX17042_VMAX_TOLERANCE		50 /* 50 mV */
>>  
>> +#define MAX17042_CURRENT_LSB		1562500ll /* µV */
> 
> Is this really long long? The usage in max17042_get_status() is with int
> operand and result.

The "ll" is part of the original code which these macros replace,
dropping the "ll" is IMHO out of scope for this patch, it would
clearly break the only change 1 thing per patch/commit rule.

>> +#define MAX17042_CURRENT_RSENSE(x)	(x * MAX17042_CURRENT_LSB) /* µV */
>> +#define MAX17042_CAPACITY_LSB		5000000ll /* µVh */
>> +#define MAX17042_CAPACITY_RSENSE(x)	(x * MAX17042_CAPACITY_LSB) /* µVh */
>> +#define MAX17042_TIME(x)		(x * 5625 / 1000) /* s */
>> +#define MAX17042_VOLTAGE(x)		(x * 625 / 8) /* µV */
>> +#define MAX17042_RESISTANCE(x)		(x / 4096) /* Ω */
>> +#define MAX17042_TEMPERATURE(x)		(x / 256) /* °C */
> 
> Please enclose the "x" in (), in each macro

Ack, right I should have spotted that in my own review.

Regards,

Hans




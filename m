Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3676FD23F
	for <lists+linux-pm@lfdr.de>; Wed, 10 May 2023 00:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjEIWKJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 May 2023 18:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEIWKI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2023 18:10:08 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E2D4498
        for <linux-pm@vger.kernel.org>; Tue,  9 May 2023 15:10:07 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-76c304efb8fso19135139f.1
        for <linux-pm@vger.kernel.org>; Tue, 09 May 2023 15:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683670207; x=1686262207;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s2k5UTerH0tzS6zId+E7KrJWjlGMZCSewICEjT1MB6Q=;
        b=Gh0INJj/bEdyWQeEV6+CCZWIk0sKWaaOQXoVTddfV2BNyejYIkMMjtBzynUuXNlFdK
         XhGwT94yHqRE7NQyGLjFVakuuzjp5WuD4WQjM0J6vti83qR/5unJh5pNdJCYurw1Li2C
         YYesWWAtqoamH73GsZxRNUtLbnz1id9RJWnFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683670207; x=1686262207;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2k5UTerH0tzS6zId+E7KrJWjlGMZCSewICEjT1MB6Q=;
        b=E8vcQtcs1jmw+wAZTVqu+90cQqwCa/8Jgnp7ERPEDJcU5H0h6NYYL4N+HcvNiQxGDa
         z2RGcR+DIQXtxNrnziIr/CIgxyy6DBcrjSz4Skj3/UP05i7PMEbrEuYC8qr0mH7Y9DIt
         GJmVmok1LDp9z83eNMWQEMzm/wamf7Ye4yJ8jtWdGYhcPXt/usF3POIFh1jP7xFKy/cF
         7BY9e2OIAIl9XiFRJBMDQ8UVoTCQ/jyVUIi9ar/icE8X4HxDDQt7sYLtqvXdwFpGO+9d
         vAoOBb1BA290UHVc5ImRkMLiPozoyVTaHGUpqA9pcBsOhDAIAO75wKoOI0Q38B6BzbCQ
         zWmQ==
X-Gm-Message-State: AC+VfDwI6ZBNYRDURqoFOuXgfX4p9wzky0afUS6x20lGiTmqBevmz1/w
        eVGYYWHIE5Z0kF3hhdgPY1brej9Qwg0TNZZzHyE=
X-Google-Smtp-Source: ACHHUZ7bh+LwNreqLxV+vW7oh85lQfN+hwQtZ2vnurjFV4k6RDaX/ZgKLA1MBAvm92SKIiGWZp704A==
X-Received: by 2002:a6b:3b49:0:b0:76c:5c79:81bf with SMTP id i70-20020a6b3b49000000b0076c5c7981bfmr1527355ioa.2.1683670206876;
        Tue, 09 May 2023 15:10:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t193-20020a0254ca000000b004142191a7b4sm3060402jaa.169.2023.05.09.15.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 15:10:06 -0700 (PDT)
Message-ID: <eeca542a-eb7f-50a0-b62b-7bab8993185a@linuxfoundation.org>
Date:   Tue, 9 May 2023 16:10:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] cpupower: Bump soname version
Content-Language: en-US
To:     Salvatore Bonaccorso <carnil@debian.org>,
        Thomas Renninger <trenn@suse.com>, linux-pm@vger.kernel.org
Cc:     Ben Hutchings <ben@decadent.org.uk>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20160610005619.GQ7555@decadent.org.uk>
 <ZFqV3ZFROy0m+/Xt@eldamar.lan>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZFqV3ZFROy0m+/Xt@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/9/23 12:50, Salvatore Bonaccorso wrote:
> Hi Thomas,
> 
> On Fri, Jun 10, 2016 at 01:56:20AM +0100, Ben Hutchings wrote:
>> Several functions in the libcpupower API are renamed or removed in
>> Linux 4.7.  This is an backward-incompatible ABI change, so the
>> library soname should change from libcpupower.so.0 to
>> libcpupower.so.1.
>>
>> Fixes: ac5a181d065d ("cpupower: Add cpuidle parts into library")
>> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
>> ---
>> I have to say the choice of variable names here is rather confusing.
>> LIB_MIN is used for the soname version, which would normally be the
>> *major* part of the version.
>>
>> I'll send a second patch that switches to more conventional library
>> versioning.
>>
>> Ben.
>>
>>   tools/power/cpupower/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
>> index 8358863259c5..0b85f5915ce8 100644
>> --- a/tools/power/cpupower/Makefile
>> +++ b/tools/power/cpupower/Makefile
>> @@ -64,7 +64,7 @@ DESTDIR ?=
>>   
>>   VERSION=			$(shell ./utils/version-gen.sh)
>>   LIB_MAJ=			0.0.1
>> -LIB_MIN=			0
>> +LIB_MIN=			1
>>   
>>   PACKAGE =			cpupower
>>   PACKAGE_BUGREPORT =		linux-pm@vger.kernel.org
> 
> Repinging this patch. Thomas, we are shipping it in Debian since, and
> I'm wondering if the patch did just felt trough the cracks.
> 

Please resend the patch for review.

thanks,
-- Shuah


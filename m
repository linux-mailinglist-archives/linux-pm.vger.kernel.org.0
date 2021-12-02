Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49999466907
	for <lists+linux-pm@lfdr.de>; Thu,  2 Dec 2021 18:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376290AbhLBR0s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Dec 2021 12:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbhLBR0q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Dec 2021 12:26:46 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47E8C06174A;
        Thu,  2 Dec 2021 09:23:23 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id u3so242210lfl.2;
        Thu, 02 Dec 2021 09:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=QEgwvnQKAaoulGSkuVxazWLI6dtVB713e++3sOrQ19c=;
        b=M997yKrMNeXKYYUjvbXDCLnImkWG2T8IjysVo6bsm8xP8MQIgPwX3EPDnLNY6XXE8n
         nQbmNAhhP06dQ08TtQSCRrPB2bCciwLe2ShcXXJweUc1hCWdSJO19KP9NzxYe3zkVmKA
         c021M/qrdlJw35RA4c2vBCrphKuAIZWbCC1RAoYCNXGKx3i1cWzEG+DCWJNj6KzjAdWe
         Nf17L6FGk5GpsfIgVqjcK9Rgd5qBOF/EwZ2oyYOpF8mR5rBLymOrxT5fCkY18WBApBK+
         dq+cKwI3ThX1zQgzZjj/0MHZfoPHiZfa+WxC6mBuovnIDHO2JRZ6roYPmBJb02AWsMJw
         KuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QEgwvnQKAaoulGSkuVxazWLI6dtVB713e++3sOrQ19c=;
        b=xFFhC2sndMPYoglL6hMRBpr3TOiAhhMy/65Sjw4DJh+XLsyOR/BHP9IT2GNjhwUh65
         a3ypElrkgXXH9O3AoPGFLbK5x4OsJRSlRdtnooHdwp+qxV2uWpQ0h+A38XmXGy7z2iuu
         jFYM6dObWChygP8g0CPT8fDzC5u0y2/C1NFYZSyN63Uxsssq2eocFygl5+DmTGgaMl++
         H5/kI+jF3ORgyCr+7IAa3fHT+wZ6ia6zXT9fnNf0QuQ9TVwzz+yuIVVE/KKEOfYF7PF7
         HQ/EihnC+bcyPtGu6FxMaJsI0otlIuALR0AETShAolMntO3xgHw2PBl5OXx6lAuZ/8V1
         i85A==
X-Gm-Message-State: AOAM531gJRs3ryo4rPTco6Ero8cFkfmorYfRSZqfLZSKCwd2CQomBFiY
        Yf4k2gqc0Ima7qE33XBdHCw=
X-Google-Smtp-Source: ABdhPJzEuYGQ/nZwZXYixgdn3Ak1Ri9mhy8i8z0AVsP4geMg2s8SJI1Kk7Hs3N8Ieoj90p8YvB/JTg==
X-Received: by 2002:ac2:5091:: with SMTP id f17mr13339327lfm.206.1638465802090;
        Thu, 02 Dec 2021 09:23:22 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id n14sm45126lji.28.2021.12.02.09.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 09:23:21 -0800 (PST)
Message-ID: <b95213ca-2597-fd27-7e0c-50250e645d48@gmail.com>
Date:   Thu, 2 Dec 2021 18:23:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:95.0) Gecko/20100101
 Thunderbird/95.0
Subject: Re: [PATCH RFC 0/3] reset: syscon-reboot: add "reg" property support
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20211102152207.11891-1-zajec5@gmail.com>
 <CAL_JsqL5qJZz8K7330cOhV8x86097LUE7oFNx5Qu3M4XLL+gMg@mail.gmail.com>
 <8f02af47-d9dc-a29d-b839-e10969a448d0@gmail.com>
 <CAL_JsqJB+KneifCaybF7ng0KuwbLgtYk3UMKjkFNOL5Bj8U2pg@mail.gmail.com>
 <20211202172143.44bwtgiiagczfqlr@earth.universe>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20211202172143.44bwtgiiagczfqlr@earth.universe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 02.12.2021 18:21, Sebastian Reichel wrote:
> On Fri, Nov 12, 2021 at 04:32:48PM -0600, Rob Herring wrote:
>> On Fri, Nov 12, 2021 at 4:23 PM Rafał Miłecki <zajec5@gmail.com> wrote:
>>>
>>> On 12.11.2021 23:18, Rob Herring wrote:
>>>> On Tue, Nov 2, 2021 at 10:22 AM Rafał Miłecki <zajec5@gmail.com> wrote:
>>>>>
>>>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>>>
>>>>> During my work on MFD binding for Broadcom's TWD block I received
>>>>> comment from Rob saying that "syscon-reboot" should use "reg" property.
>>>>> I'm not sure if my understanding & implementation are correct so I'm
>>>>> sending this RFC.
>>>>>
>>>>> What bothers me is non-standard "reg" property usage. Treating it as a
>>>>> simple (unsigned) integer number means different logic when it comes to
>>>>> ranges.
>>>>
>>>> It shouldn't be. The idea is that 'reg' works like normal. See below.
>>>>
>>>>> Consider this example:
>>>>>
>>>>> timer@400 {
>>>>>           compatible = "simple-mfd", "syscon";
>>>>>           reg = <0x400 0x3c>;
>>>>>           ranges;
>>>>
>>>> ranges = <0 0x400 0x100>; // Just guessing for size
>>>>
>>>>>
>>>>>           #address-cells = <1>;
>>>>>           #size-cells = <1>;
>>>>>
>>>>>           reboot@434 {
>>>>
>>>> reboot@34
>>>>
>>>> Just reading 'reg' is fine, but really, Linux should be either getting
>>>> the translated address or have a function to get the offset from the
>>>> parent base. IOW, it should also work if you just changed 'reg' to
>>>> '<0x434 0x4>'.
>>>
>>> Are you aware of anyone working on support for getting translated
>>> address? Do you recall any efforts on implementing such a helper?
>>
>> All the DT address functions give you translated addresses. It's the
>> latter that doesn't exist that I'm aware of offhand. It's just
>> of_address_to_resource() on the child and parent nodes and then
>> calculate the offset.
> 
> Has a new version beent sent with this change, that I missed?

Not yet, I was sidetracked by pinctrl & OpenWrt stuff.

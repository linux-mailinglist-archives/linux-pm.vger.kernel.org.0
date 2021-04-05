Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387093548A3
	for <lists+linux-pm@lfdr.de>; Tue,  6 Apr 2021 00:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhDEWej (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Apr 2021 18:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbhDEWei (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Apr 2021 18:34:38 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DADDC06174A;
        Mon,  5 Apr 2021 15:34:31 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x21so14180909eds.4;
        Mon, 05 Apr 2021 15:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U4kgsl4taTd1spNjzfQOZDGCoWUhUf9MRTnGCPFFMsE=;
        b=ZvoT/L8gxJTUL3ZAmf3cRL6PMJy8DnmORY4t9HA2ir5euBGkYIDa13xBoLtIIEbJMs
         Ge1eBIG31wglXosAAB81s+aBD2GU1AN+Ojqc3Thu6oVna7f1gXR9Pb/p6MEfDAj2qPQo
         gWqmIsE79pQnosXxLGVea6VE717+2RV4XmZjE5N9/wYX9PJm9P7aw1Of+ukfT49K/gti
         10fzBPafx1fRI9QE8PoedNGHEcJgj+VXVFJMWkHG/QvtbnKDG59a8MYAnSvzQnpiTGA2
         MJfVREkAvk6etqNNmwp4JJ5VBfU4eE6D0oCyET1lOvpV5cImp6lNNl++WZlXEA1hrbG+
         RcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U4kgsl4taTd1spNjzfQOZDGCoWUhUf9MRTnGCPFFMsE=;
        b=UWi6seZbp4m0x3Dkggwagb4B4juGSOtIZeK6zvlWevE8sYYBPJbAmvLjmBhQIiS83h
         qkBiciFRAcbb29R0w/aIOlAzAnOQCBrohIecjatgyDI56K/L9yT9y+IZIpXQNHlq160l
         4GBvcyNZ7U66tZLztyYott+shxc9Ca+C5vuMIbgUO8qWQcaOpQkxjmHfOUW38twuNPMD
         +KvbEd1gP+Dkm7402oFhsF6Z0tbYPhpgeIIpxWxuDdlvR7bkatuivvJcKAS+VAyzMeaX
         Oq6lnJRIrLvuRpjVm2k+DUqVGotGBxjcPV8SulLTGTA1fnHIwKxdMja1xSyo1eQQJ7Jp
         5+gA==
X-Gm-Message-State: AOAM532hgA4x+88Wowklp6WAyvW05QrpLzS+xWho9AMmURwO7n0GO/gv
        Kmf7xXRkIAnCzR0tOKF2RqqAGhT2WwM=
X-Google-Smtp-Source: ABdhPJzW61Z5BJ7peH2efSGSBPH2NdvgItcx620zaEhMIzn4Lm4XK05hGl6LkhaoPC/ppxRpeNIEkA==
X-Received: by 2002:a05:6402:3493:: with SMTP id v19mr35136604edc.355.1617662070060;
        Mon, 05 Apr 2021 15:34:30 -0700 (PDT)
Received: from [10.18.0.9] ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id pg2sm9603384ejb.49.2021.04.05.15.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 15:34:29 -0700 (PDT)
Subject: Re: [PATCH 1/2] power: supply: Add battery driver for Surface
 Aggregator Module
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210309000530.2165752-1-luzmaximilian@gmail.com>
 <20210309000530.2165752-2-luzmaximilian@gmail.com>
 <20210405153752.2r4ii5lguogchgl4@earth.universe>
 <046f6149-55fd-431e-d582-cc5915d10e20@gmail.com>
 <20210405213241.r6xhtbaf4qkzylz2@earth.universe>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <5e6692b9-d043-8a18-8d76-afb235caddbb@gmail.com>
Date:   Tue, 6 Apr 2021 00:34:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210405213241.r6xhtbaf4qkzylz2@earth.universe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 4/5/21 11:32 PM, Sebastian Reichel wrote:
> [...]
>>>> +static void spwr_battery_unregister(struct spwr_battery_device *bat)
>>>> +{
>>>> +	ssam_notifier_unregister(bat->sdev->ctrl, &bat->notif);
>>>> +	cancel_delayed_work_sync(&bat->update_work);
>>>> +	device_remove_file(&bat->psy->dev, &alarm_attr);
>>>> +	power_supply_unregister(bat->psy);
>>>
>>> power_supply_unregister being the last function call is a clear
>>> sign, that devm_power_supply_register can be used instead.
>>
>> Right, that works here. I normally try to not mix devm code with
>> non-devm code (apart from maybe allocations).
> 
> well allocations are usually done first and free'd last making
> them the first targets in the conversion and pretty much a no
> brainer.
> 
> Next merge window it's possible to easily go to full devm by
> using devm_delayed_work_autocancel(), which has been merged
> by Greg two weeks ago. Then last but not least do the ssam
> notifier unregister via devm_add_action_or_reset and its fully
> converted :)

Neat, I'll have a look at maybe adding some devm versions for the
SSAM notifiers. Should help in at least one other driver apart from
these two.

Thanks,
Max

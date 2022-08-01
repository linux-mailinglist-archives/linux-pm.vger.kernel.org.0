Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DF45867D3
	for <lists+linux-pm@lfdr.de>; Mon,  1 Aug 2022 12:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiHAKu6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Aug 2022 06:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiHAKu4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2022 06:50:56 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825315F62
        for <linux-pm@vger.kernel.org>; Mon,  1 Aug 2022 03:50:54 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 50BDD8021D;
        Mon,  1 Aug 2022 12:50:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1659351051;
        bh=cR1j9hffG6EANPglGexXe/wmy3V1X01kiaPX9n/ahOM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qp25Yjzxj/5q/QT8eEZOenvhxaXZX5WJQlmPEjsJEEG2pyqDh6MLNHW4vHWfWv0mp
         mIj+5uuNo1IWyysXbF9SPTofj3o+7oYcvy4NfwV9YLJj1l9ZyTurb2rlPxx5Jb8CdF
         s5AvC7p9+a6VnnKCxcEiifSOpvBKgBUByuNOHV6dea21g/Tzy6Xfcc/i54W2AXMIGK
         tosJsXPILvASne133m39Rck4qw9Fmfp6GrYdKFqLE5M3tSVrzK+J5iIFPy3njDG7tV
         GQB8MSE3xTR4cJiV1sygmgB1vuVJrZDq1NfcGmzqTS6KOccWr/oD00C+ysz6ZVzALK
         gvViGOZD7me9A==
Message-ID: <c1708457-d5c8-b5e0-a9ad-6e482ba034aa@denx.de>
Date:   Mon, 1 Aug 2022 12:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] power: supply: bq25890: Add support for setting IINLIM
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20220730180630.152098-1-marex@denx.de>
 <a28026fb-a69b-3ca5-9851-95e6983b9404@redhat.com>
 <b18944f4-4e87-dfd1-37af-568a8959c57c@denx.de>
 <f12ca549-ceed-f2e2-ed86-bc2f42933939@redhat.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <f12ca549-ceed-f2e2-ed86-bc2f42933939@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/1/22 09:15, Hans de Goede wrote:
> Hi,

Hi,

>>>> +static int bq25890_power_supply_set_property(struct power_supply *psy,
>>>> +                         enum power_supply_property psp,
>>>> +                         const union power_supply_propval *val)
>>>> +{
>>>> +    struct bq25890_device *bq = power_supply_get_drvdata(psy);
>>>> +    u32 lval;
>>>> +
>>>> +    switch (psp) {
>>>> +    case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>>>> +        lval = clamp(val->intval, 100000, 3250000);
>>>> +        lval = DIV_ROUND_UP(lval - 100000, 50000);
>>>
>>> I'm not sure DIV_ROUND_UP is the right thing to do here. This means
>>> that when the user e.g. asks for 1040 mA the iinlim will get set to
>>> 1050mA so more then which is being requested.
>>>
>>> IMHO it would be better to use rounding down, aka standard divide
>>> behavior here.
>>>
>>> But even better would be to replace both lval = ... statements
>>> with a single:
>>>
>>>      lval = bq25890_find_idx(val->intval, TBL_IINLIM);
>>>
>>> which takes care of all this for you and is also what is used
>>> by bq25890_charger_external_power_changed() to set iinlim based
>>> on charger-type-detection done by other chips on the board
>>> (e.g. PMICs / usb-phys Type-C controllers).
>>
>> Nice, fixed in v2, thanks.
>>
>> There is one thing which I don't quite understand about this driver though -- shouldn't we implement .external_power_changed() callback and then somehow listen for which charger gets plugged in (like, USB standard one, or 1.5A one or 3A one, or even some adapter), and based on that tweak the IINLIM too ? Or is this more of a userspace kind of policy, so it should be up to userspace to write this sysfs entry as needed ?
> 
> There already is an external_power_changed() callback that is what
> the bq25890_charger_external_power_changed() function I mentioned is... ?

Doh ... clearly wasn't my best moment.

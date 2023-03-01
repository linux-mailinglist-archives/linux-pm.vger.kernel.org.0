Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71446A6C96
	for <lists+linux-pm@lfdr.de>; Wed,  1 Mar 2023 13:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCAMsD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Mar 2023 07:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCAMsA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2023 07:48:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C63F3BDB2
        for <linux-pm@vger.kernel.org>; Wed,  1 Mar 2023 04:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677674831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PrHWi0O3bp5TW073HxIoo2GqwQh60ydUW1vLbyoS8FU=;
        b=TCDHMqCmqHOxRM5QtpqYDPa+29+jQWl3x4nbuRHyIqBT/jY9yYGiViECo1cLHP6WbPZiuP
        f5vkgiw/54KEixCIcXlpsnmcPfS4ZAqnX0J3uFW4LuUwnwLk49EM8jC+Hm/O/5n4AY6FRX
        XZQ1pyQFsGoEjAFzngV2rjHCqL9QVBw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-578-qdZfpqwJPQG72k4UTnJeRA-1; Wed, 01 Mar 2023 07:47:10 -0500
X-MC-Unique: qdZfpqwJPQG72k4UTnJeRA-1
Received: by mail-ed1-f72.google.com with SMTP id cz22-20020a0564021cb600b004a245f58006so19285710edb.12
        for <linux-pm@vger.kernel.org>; Wed, 01 Mar 2023 04:47:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrHWi0O3bp5TW073HxIoo2GqwQh60ydUW1vLbyoS8FU=;
        b=gLMfuXF/0GpbXOuS9w9ounClozJpWmndzqyFJS5LXFfEzax9aDul7qw2pcQqb9ZY7h
         CPx4VGlJ2nNLd4Zx3PBaQ+Hd9uOgXepPJzezRfMbro8GYJz+IQDvOZjlhBzHr9pgE2ph
         ozzpCE7WCjLo1HLtvtdANIdw4ulTGLDyDpLcGMfGSccHQxmoY6UFzW69oRPAJApsKVhW
         BIcVCvjXfCCIJNBdmJ8MbdB9MeP+EKVfsoUzbGaIh3973MAnZTL8YVSUjgi64gYyIRuZ
         NGWAJbDlpDMxDKEMnY+F5eudUPKTmAni/RWR8qLB2o5yZIKA09dx9+mF4CqpyRR+yJYA
         CMfw==
X-Gm-Message-State: AO0yUKVHzq6qUikP37PmaqDBGZN0RdbYVf7jGhZDN73Qx4Kckzp7sFKh
        MjOQ7urDOfP7Jzl7pGyyA+lLV+VoT+GQ3/6TL/QBYGV6P7FIUjc7VKG7WpIlhBnniSsw4Q/memT
        QwgyfqyqOICdMyuQvFdM=
X-Received: by 2002:aa7:d6c4:0:b0:4af:59c0:744a with SMTP id x4-20020aa7d6c4000000b004af59c0744amr7757579edr.24.1677674829575;
        Wed, 01 Mar 2023 04:47:09 -0800 (PST)
X-Google-Smtp-Source: AK7set/gegt3wNPFIA5UaAFSkM0H/Cu2JETEa5VzADkRpzuOeLZLY8c4YHH4dVV9FidRJQJWbeU9sQ==
X-Received: by 2002:aa7:d6c4:0:b0:4af:59c0:744a with SMTP id x4-20020aa7d6c4000000b004af59c0744amr7757547edr.24.1677674829268;
        Wed, 01 Mar 2023 04:47:09 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id b18-20020a50b412000000b004bda465da32sm374934edh.1.2023.03.01.04.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 04:47:08 -0800 (PST)
Message-ID: <5bb49015-0a9c-5b9d-b22c-38011439c984@redhat.com>
Date:   Wed, 1 Mar 2023 13:47:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/8] drivers: select REGMAP instead of depending on it
Content-Language: en-US, nl
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Riku Voipio <riku.voipio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        Michael Shych <michaelsh@nvidia.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        platform-driver-x86@vger.kernel.org,
        Yegnesh S Iyer <yegnesh.s.iyer@intel.com>,
        Bin Gao <bin.gao@intel.com>, Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        Oskar Senft <osk@google.com>, linux-serial@vger.kernel.org
References: <20230226053953.4681-1-rdunlap@infradead.org>
 <7dd27ec5-0619-128d-8407-6711a05ef271@redhat.com>
 <6a95a337-2972-427f-635d-5ef4e91a82fa@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <6a95a337-2972-427f-635d-5ef4e91a82fa@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 2/27/23 17:07, Randy Dunlap wrote:
> 
> 
> On 2/27/23 01:31, Hans de Goede wrote:
>> Hi Randy,
>>
>> On 2/26/23 06:39, Randy Dunlap wrote:
>>> REGMAP is a hidden (not user visible) symbol. Users cannot set it
>>> directly thru "make *config", so drivers should select it instead of
>>> depending on it if they need it.
>>>
>>> Consistently using "select" or "depends on" can also help reduce
>>> Kconfig circular dependency issues.
>>>
>>> REGMAP is selected 94 times and is depended on 11 times in
>>> current linux-next. Eliminate the uses of "depends on" by
>>> converting them to "select".
>>
>> Thank you for your work on this. Mixing of depends on vs select
>> is a real problem with many Kconfig symbols.
>>
>>>  [PATCH 1/8] ipmi: ASPEED_BT_IPMI_BMC: select REGMAP_MMIO instead of depending on it
>>>  [PATCH 2/8] clk: HI655X: select REGMAP instead of depending on it
>>>  [PATCH 3/8] gpio: GPIO_REGMAP: select REGMAP instead of depending on it
>>>  [PATCH 4/8] leds: TI_LMU_COMMON: select REGMAP instead of depending on it
>>>  [PATCH 5/8] platform: mellanox: select REGMAP instead of depending on it
>>>  [PATCH 6/8] platform: x86: MLX_PLATFORM: select REGMAP instead of depending on it
>>>  [PATCH 7/8] thermal: intel: BXT_PMIC: select REGMAP instead of depending on it
>>>  [PATCH 8/8] serial: 8250: ASPEED_VUART: select REGMAP instead of depending on it
>>
>> For patch 5/8 and 6/8, do you want me to merge them through the pdx86
>> (platform-drivers-x86) tree, or do you plan to merge this whole series
>> in one go through some other tree?
> 
> Hi Hans,
> Please merge them thru the pdx86 tree.

Ok, I've applied patch 5/8 + 6/8 to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I'll rebase that branch once 6.3-rc1 is out and then push the rebased
patch to the fixes branch and include it in my next 6.3 fixes pull-req
to Linus.

Regards,

Hans





>>>
>>> diffstat:
>>>  drivers/char/ipmi/Kconfig         |    3 ++-
>>>  drivers/clk/Kconfig               |    2 +-
>>>  drivers/gpio/Kconfig              |    2 +-
>>>  drivers/leds/Kconfig              |    2 +-
>>>  drivers/platform/mellanox/Kconfig |    9 ++++-----
>>>  drivers/platform/x86/Kconfig      |    3 ++-
>>>  drivers/thermal/intel/Kconfig     |    3 ++-
>>>  drivers/tty/serial/8250/Kconfig   |    3 ++-
>>>  8 files changed, 15 insertions(+), 12 deletions(-)
>>>
>>> Cc: Andrew Jeffery <andrew@aj.id.au>
>>> Cc: Corey Minyard <minyard@acm.org>
>>> Cc: openipmi-developer@lists.sourceforge.net
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Riku Voipio <riku.voipio@linaro.org>
>>> Cc: Stephen Boyd <sboyd@kernel.org>
>>> Cc: Michael Turquette <mturquette@baylibre.com>
>>> Cc: linux-clk@vger.kernel.org
>>> Cc: Michael Walle <michael@walle.cc>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
>>> Cc: linux-gpio@vger.kernel.org
>>> Cc: Dan Murphy <dmurphy@ti.com>
>>> Cc: Pavel Machek <pavel@ucw.cz>
>>> Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>>> Cc: Lee Jones <lee@kernel.org>
>>> Cc: linux-leds@vger.kernel.org
>>> Cc: Darren Hart <dvhart@infradead.org>
>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>> Cc: Michael Shych <michaelsh@nvidia.com>
>>> Cc: Mark Gross <markgross@kernel.org>
>>> Cc: Vadim Pasternak <vadimp@nvidia.com>
>>> Cc: platform-driver-x86@vger.kernel.org
>>> Cc: Yegnesh S Iyer <yegnesh.s.iyer@intel.com>
>>> Cc: Bin Gao <bin.gao@intel.com>
>>> Cc: Zhang Rui <rui.zhang@intel.com>
>>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Amit Kucheria <amitk@kernel.org>
>>> Cc: linux-pm@vger.kernel.org
>>> Cc: Oskar Senft <osk@google.com>
>>> Cc: linux-serial@vger.kernel.org
>>>
>>
> 


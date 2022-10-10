Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109C35FA2CC
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 19:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJJRj4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Oct 2022 13:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJJRjw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2022 13:39:52 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC3925D9
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2022 10:39:47 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E14AC84E35;
        Mon, 10 Oct 2022 19:39:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665423585;
        bh=SPoryZ3bATu5SCkGBXArwGRZkIf0XGKyVRxQhd51SpI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=h6drTojAG/LrXkGs0DwWnw9yMiG5MXjrUXalCUl5NFFLAduha1FbgEKjAck8rz7CC
         KIwLFQL00jQeodZoz3wXoLXv3VE+P+V1T/w967nWPcPFS/tlQAXrim+uHav/IUVqY4
         0yJwHZcdv7TARijJ1Hqmn5FQbOqVjrRBMJjnmmNWKtliD8Mexpe+iYC3+BqLfFByuf
         HDL0m08KAoQSchQarICaYgqlLQUXtrLd5yUprsqKHIFiGjWYqyQCwalMrQDZPSrWNu
         XuVmvWsbzlZ2XrUwebd4eEDUKVeyBM3Fq9SO/k1R0G04awe/zOpkzzwT/4ipkUwd5E
         ZfmIJohol48cg==
Message-ID: <5cca6274-6b48-115f-51f1-e98079e29a6c@denx.de>
Date:   Mon, 10 Oct 2022 19:39:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/2] power: supply: bq25890: Rename
 POWER_SUPPLY_PROP_CURRENT_NOW to CC current
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221009191839.102686-1-marex@denx.de>
 <20221009191839.102686-2-marex@denx.de> <Y0NSBvkcOOx/3XcR@qmqm.qmqm.pl>
 <1da48c09-fe83-c4d7-8d6f-c5e5a7189bc0@denx.de>
 <36389281-89dd-8bbf-851b-3b227765c17d@redhat.com>
 <2bcdbfa7-0029-fd49-edfd-70c061e34e2a@denx.de>
 <5521819a-4879-10d1-37ac-8a8fd38436e6@redhat.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <5521819a-4879-10d1-37ac-8a8fd38436e6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/10/22 19:31, Hans de Goede wrote:
> Hi,

Hi,

[...]

>>> having an attribute simply named "current" is not really helpful,
>>> it is fine (and widely used by userspace) on battery-type power_supply
>>> class devices since there is only the 1 current going into/out-off
>>> the battery.
>>>
>>> I see 3 solutions for this for charger style devices:
>>>
>>> 1. Document that current_now is for the (dis)charge current flowing
>>> into/out-off the attached battery. So basically document what
>>> the bq25890 driver is doing now.
>>>
>>> 2. Add a new charge_current_now attribute for this and switch
>>> bq25890 over.
>>>
>>> 3. Don't report the charge-current in the charger driver, since
>>> this is duplicate info with the fuel-gauge driver.
>>>
>>> 2. has a bit of a risk of breaking userspace, so I'm not
>>> sure if that is a viable option. Given this I have a slight
>>> preference for solution 1.
>>>
>>> I hope this helps clarify the confusion surrounding this a bit.
>>
>> Maybe we should add POWER_SUPPLY_PROP_CHARGE_CURRENT_NOW and deprecate POWER_SUPPLY_PROP_CURRENT_NOW ? That won't break userspace and would be clear in what it does. Yes, we would have duplicate sysfs attribute.
> 
> We have a long history of upower (GNOME, XFCE, others) and
> the KDE equivalent (PowerDevil?) using POWER_SUPPLY_PROP_CURRENT_NOW
> so I'm afraid we will not be able to remove that in a long long time.
> 
> As such I believe it would be better to just clearly
> document that the current attribute is for the power
> going into/out-of the battery and leave it at that.

ACK. This already seems documented in the sysfs attributes in 
Documentation, so I will only add a comment into this driver.

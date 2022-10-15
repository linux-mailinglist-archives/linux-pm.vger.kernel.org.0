Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B412E5FFB90
	for <lists+linux-pm@lfdr.de>; Sat, 15 Oct 2022 19:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJORwi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Oct 2022 13:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJORwi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Oct 2022 13:52:38 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499E943E58
        for <linux-pm@vger.kernel.org>; Sat, 15 Oct 2022 10:52:37 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 0382384D5E;
        Sat, 15 Oct 2022 19:52:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665856354;
        bh=GE2WPFMMKDS6MY8HKGskb9PZEqpJdsFB7gM7B6immxc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Wp0r15xrvCgho/m0ERGjAUa+FJLhdZLVNT++SjKDkzEz4o7rSIOCaTHSCq3z5J5dE
         Qhvx3yU5WrrEnDKQ2UyJAs4ycsDu5/mYh84bgPrdUjt2KzLp+R2GeqwLyvIdF6wdPX
         zKLPkU0IM+FnGa05QMBQ0IpWGnT9UzmccbZMN1IJFpXZxB20gaq7F+xczwal7sx2JI
         9kzqCGrZ+GcKhbKGfVMmbHa+NVzBmXsheK1wT64MDXh6zvbWph9wQeEzMiFziNC0wB
         aA7GQ9bb85zOV6f1dbRSZSGKavJ7fgx9gSLj45PluNZc5VM4CsSWcdcw13NFbAK5kr
         2+BUew/ndm7vQ==
Message-ID: <5369532e-548d-09c5-38b6-c4405dc3f79c@denx.de>
Date:   Sat, 15 Oct 2022 19:52:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 5/7] power: supply: bq25890: Factor out regulator
 registration code
To:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221010210310.165461-1-marex@denx.de>
 <20221010210310.165461-5-marex@denx.de>
 <e0659fb1-7e1e-de5c-de6a-99a8f180bd3f@redhat.com>
 <00e6b9b0-ddef-6e2f-0603-9a25fd3b9e0d@denx.de>
 <848ada38-00a1-0631-871f-926bb33a166f@redhat.com>
 <021a1dfc-eb05-77ad-644c-f967a5bf7799@denx.de>
 <27d4c17a-1894-e055-9311-9fb6d69d3665@redhat.com>
 <08bbfa77-8001-9a69-94ea-936afe8195a8@denx.de>
 <a86c5d18-5e4d-30f7-7634-675e78ee3a19@redhat.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <a86c5d18-5e4d-30f7-7634-675e78ee3a19@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/15/22 16:16, Hans de Goede wrote:

Hi,

>>>>> Looking at standard Linux userspace (Debian/Fedora/etc.)
>>>>> all the userspace tools capable of reporting voltages
>>>>> of various voltage rails inside the system to the user
>>>>> use the hwmon interface for this. This is also why
>>>>> the power-supply class core recently got support for
>>>>> proxying some psy properties to a hwmon class device.
>>>>>
>>>>> So the way I see it is that if we want to report Vsys to
>>>>> userspace, that we then clearly need to report it through
>>>>> the hwmon interface.
>>>>
>>>> For regulators, you can read their values via /sys/class/regulators/* , if the user is interesting in Vsys .
>>>>
>>>> Maybe that is where we disagree -- I'm not particularly interested in exposing Vsys to user space, but since it was exposed before, I tried to retain that exposure, although via different channel. And the regulator also makes the Vsys useful, since it can be used as a supply on the kernel level.
>>>
>>> I don't particularly care a lot about exposing Vsys to user space either,
>>> but like you I do believe that we should at least keep the functionality
>>> around while fixing the wrong property use.
>>
>> I agree.
>>
>>> I'm still not 100% convinced a regular for Vsys is not a bit
>>> overkill but I don't want to block going this route either.
>>
>> Why would a regulator be an overkill compared to hwmon ?
>> What am I missing here ?
> 
> A regulator is another struct device, and also more code at the
> driver level then just adding a new property (there already is
> a hwmon device related to the psy device, so a new property would
> just use that.
> 
> Anyways you have expressed a clear preference for the regulator
> approach and I'm fine with that, lets see what sre has to say.

Let's do that indeed.

Thanks for clarifying!

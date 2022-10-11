Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173E15FB85B
	for <lists+linux-pm@lfdr.de>; Tue, 11 Oct 2022 18:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJKQjN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Oct 2022 12:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJKQjL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Oct 2022 12:39:11 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8115912D33
        for <linux-pm@vger.kernel.org>; Tue, 11 Oct 2022 09:39:10 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C5D0884D9F;
        Tue, 11 Oct 2022 18:39:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665506348;
        bh=m6nJ4RG374+JjZVOp0n0p+XqKIV+Lam9mzeitkJ7XDY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=B8oDhX+txa4pthj7GF9XdEs/NcY6/cQn306JzS3WLOjK4jSmEgP5MlAKqDJ0UECMi
         o6oxuoIvNXEkPTRMEEl2k3WkyPOizI3z9/cjyOTm+G9YhVixHFnp19ii9fb8V9Qt34
         J6ALx+X6ZbiTGRsaPbK5N28Fck5n/bJRjjT0c2o5cM5vxpTxLyw9Y9eUrFBcfYBrEP
         4Ci1D0U/pS4QHzrIjMOzxiF2HxK+AvSwTz159G81w0iI9IqtSDxOpE84EycbDfvq5H
         Pr2vNtQmXWMAOt8DkG8dzRjVt6xQEbtxd+A+cBDQj0M9yZsO+XLYYE/I1FZX6nDf36
         ONCsWiYpKlplQ==
Message-ID: <00e6b9b0-ddef-6e2f-0603-9a25fd3b9e0d@denx.de>
Date:   Tue, 11 Oct 2022 18:39:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 5/7] power: supply: bq25890: Factor out regulator
 registration code
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221010210310.165461-1-marex@denx.de>
 <20221010210310.165461-5-marex@denx.de>
 <e0659fb1-7e1e-de5c-de6a-99a8f180bd3f@redhat.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <e0659fb1-7e1e-de5c-de6a-99a8f180bd3f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/11/22 10:20, Hans de Goede wrote:
> Hi,

Hi,

> On 10/10/22 23:03, Marek Vasut wrote:
>> Pull the regulator registration code into separate function, so it can
>> be extended to register more regulators later. Currently this is only
>> moving ifdeffery into one place and other preparatory changes. The
>> dev_err_probe() output string is changed to explicitly list vbus
>> regulator failure, so that once more regulators are registered, it
>> would be clear which one failed.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> First of all thank you for your work on this series. Based purely
> on reading the commit messages patches 1-4 sound good to me. I will
> do a more detailed review tomorrow.
> 
> As for patch 5-7 thinking some more about adding a Vsys regulator
> just to report the Vsys reading feels wrong to me.
> 
> A regulator device's voltage in sysfs is about the value the regulator
> is supposed to try and regulate its outputted voltage to, while here
> we are talking about an ADC reading of the actual outputted voltage.
> 
> This really should *not* be modeled as a regulator if anything the
> hwmon interface would be applicable for this ADC reading and
> the power_supply core has support for exporting some of
> the psy info through hwmon now.
> 
> So what should happen for Vsys IMHO is make it a new
> POWER_SUPPLY_PROP_SYSTEM_VOLTAGE property and while adding support
> for this new property to the power-supply core, also make the core's
> hwmon glue code export this in the registered hwmon device so that
> e.g. a sensors applet on the desktop can easily show it (*).
> 
> Sorry for the confusion with my ack in the other thread which
> only meant to agree with a part of the alinea/sentence I put
> the ack under.

I'm not sure that's all there is to the Vsys regulator, it would let us 
model the connection between the charger chip and PMIC, where the 
charger would be the supply and the PMIC the regulator consumer. If the 
PMIC can determine its input voltage, it might be able to configure 
itself to some more optimal mode of operation. With the Vsys regulator, 
the PMIC can determine its voltage. So I think the Vsys regulator would 
be useful in that scenario (that's how it is wired on my board btw.).

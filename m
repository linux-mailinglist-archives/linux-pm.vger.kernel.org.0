Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B9E630F1E
	for <lists+linux-pm@lfdr.de>; Sat, 19 Nov 2022 15:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiKSOP4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Nov 2022 09:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiKSOP4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 19 Nov 2022 09:15:56 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CC186FE0
        for <linux-pm@vger.kernel.org>; Sat, 19 Nov 2022 06:15:55 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5CEBD85268;
        Sat, 19 Nov 2022 15:15:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1668867353;
        bh=tqYhIjoQAnbUsdIvu8TLDRsmAUwvgO9KsgIuiuBO2mI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vzOlTAojFE7eeNJAuQuUkIaDefzfcFLN6Lp6snsZwl15XRkfZldAw3soDTfrhWzrY
         H441WeQKctxAAweUQ+fbT8eh8qEAUs0jMi+Rfp0xi6TcOFAVWyIYZCyOI2B7Egplkm
         aP21nBF4h/1WiDENd/SZjDx2YA3huh8CVgPO14EoTvRyKpPdtkKQ8kLfiSJZu+cvCL
         iSsOo36HZ6sbO6Qg/pmu63WVquWRp/x2MNEa0xpcqp0WaB+yfquT/h2zevDEYyEqKt
         T8T0i8QDWA7rpZWjyQDGwYPp2D2+s+3F1JkqulEXuzKQJwfFi15nXnZ3CETqR4owDt
         op73jXZJ4xGkg==
Message-ID: <1b3ba3db-dfb0-89af-5398-17642586b85e@denx.de>
Date:   Sat, 19 Nov 2022 15:14:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 2/2] power: supply: bq25890: Add HiZ mode support
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>
References: <20221109221504.79562-1-marex@denx.de>
 <20221109221504.79562-2-marex@denx.de>
 <ffd849db-fdb5-8578-85c2-74a8e030d86a@redhat.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <ffd849db-fdb5-8578-85c2-74a8e030d86a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/19/22 14:52, Hans de Goede wrote:
> Hi,
> 
> On 11/9/22 23:15, Marek Vasut wrote:
>> The bq25890 is capable of disconnecting itself from the external supply,
>> in which case the system is supplied only from the battery. This can be
>> useful e.g. to test the pure battery operation, or draw no power from
>> USB port.
>>
>> Implement support for this mode, which can be toggled by writing 0 or
>> non-zero to sysfs 'online' attribute, to select either offline or online
>> mode.
>>
>> The IRQ handler has to be triggered to update chip state, as switching
>> to and from HiZ mode does not generate an interrupt automatically.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
>> Cc: Sebastian Reichel <sre@kernel.org>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Also your timing is excellent :)  As a hobby project I'm working
> on a x86 Lenovo Android tablet which has 2 separate batteries and
> each battery has its own bq25892 chip.
> 
> This requires putting the secondary bq25892 in Hi-Z mode when
> e.g. enabling the 5V USB/OTG boost regulator on the primary
> bq25892 to make the micro-usb output 5V.
> 
> Which is functionality which I can nicely build on top of this
> series.

:)

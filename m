Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E946317EB
	for <lists+linux-pm@lfdr.de>; Mon, 21 Nov 2022 01:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiKUAuF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Nov 2022 19:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiKUAuE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Nov 2022 19:50:04 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18E42099C
        for <linux-pm@vger.kernel.org>; Sun, 20 Nov 2022 16:50:03 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 0838B8526B;
        Mon, 21 Nov 2022 01:50:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1668991802;
        bh=RKodKOofT9aweYKOdBgKeWZyz/amUbesD+QKObZ53+4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Jo4gXEexFRBp2h0lVnj9cZUD0EIGtMcghjVQEBSHVG2/qvkMppGDRf3vnISaeonYH
         fDdtQnn5wF4sGl5TM90t+SwemVbP4OKOKQvSUDEYSya4SjvKdnJH2Q+TzJk1nU44zf
         DMGiLUuvV7Ocp8aygj9rKUEVws2ttd3SRW/cxU4D4JxKOgFyfZ2xRVx961RIZ2AHkK
         dejFr/zUbaXW2AVWEU2Jt+DtNExRTBc95nmHXtTmZL6lrx1kCXzyIxvmZ+M1Mhvzfq
         3EBHITNpIsEJdIcRJHHHjKK2XyEcjmHTV1qdevTM9vijz+ZwHfvGY1dwrSMVY4f1+G
         QIUNo/KoXVGcg==
Message-ID: <c0cc1774-8373-ec5d-29c7-5f7d056821b3@denx.de>
Date:   Mon, 21 Nov 2022 01:50:01 +0100
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
 <1cde6f13-c131-332f-44f2-9a6a80b72330@redhat.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <1cde6f13-c131-332f-44f2-9a6a80b72330@redhat.com>
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

On 11/20/22 22:29, Hans de Goede wrote:
> 
> 
> On 11/19/22 14:52, Hans de Goede wrote:
>> Hi,
>>
>> On 11/9/22 23:15, Marek Vasut wrote:
>>> The bq25890 is capable of disconnecting itself from the external supply,
>>> in which case the system is supplied only from the battery. This can be
>>> useful e.g. to test the pure battery operation, or draw no power from
>>> USB port.
>>>
>>> Implement support for this mode, which can be toggled by writing 0 or
>>> non-zero to sysfs 'online' attribute, to select either offline or online
>>> mode.
>>>
>>> The IRQ handler has to be triggered to update chip state, as switching
>>> to and from HiZ mode does not generate an interrupt automatically.
>>>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> ---
>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
>>> Cc: Sebastian Reichel <sre@kernel.org>
>>
>> Thanks, patch looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Also your timing is excellent :)  As a hobby project I'm working
>> on a x86 Lenovo Android tablet which has 2 separate batteries and
>> each battery has its own bq25892 chip.
>>
>> This requires putting the secondary bq25892 in Hi-Z mode when
>> e.g. enabling the 5V USB/OTG boost regulator on the primary
>> bq25892 to make the micro-usb output 5V.
>>
>> Which is functionality which I can nicely build on top of this
>> series.
> 
> So one thing which I noticed while working on my own stuff
> on top of this, is that the charger IC resets (disables) Hi-Z
> mode when its internal PG (power-good) signal goes from false
> to true.
> 
> The Android kernel fork for the tablet I'm working on detects
> the PG false -> true transition in its IRQ handler and then
> re-enabled Hi-Z mode if it was requested.
> 
> I wonder if we should do something similar: remember the last
> value written to /sys/class/power_supply/bq2589o-charger/online
> and then in the IRQ handler if Hi-Z mode was requested re-enable
> Hi-Z mode ?

Uhhhhh, that sounds like the HiZ mode is unreliable .

Of course, there seems to be no way to completely inhibit the PG 
detection, is there ?

I wonder whether we should support this kind of workaround at all ?

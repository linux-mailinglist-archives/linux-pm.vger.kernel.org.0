Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E2C6397A9
	for <lists+linux-pm@lfdr.de>; Sat, 26 Nov 2022 19:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKZSkI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Nov 2022 13:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKZSkI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Nov 2022 13:40:08 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5224B13F09
        for <linux-pm@vger.kernel.org>; Sat, 26 Nov 2022 10:40:06 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id B089585073;
        Sat, 26 Nov 2022 19:40:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669488005;
        bh=gNGWQRI0vJlMwMQ4m16cUgCCH3BiBPM5k75nIuYGEsU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cK3gSCMmYmYwkmFqNWKWbcOuI5shwn/tHEi5+7x3uD6ZVpfcPkvjGzfEBw5nhZku1
         ckGMAammOIX2f5dmbJyJu5V4ZfhXfG2s3djVoT/pT0Etz/rwbHeWvORZazRD+1l6+Z
         h/45BRS/jAquv9kCB+PXa0BSB5ohdU6UquEYLP6h4upURyVmzKNBx++7JFBSal+fmG
         ExkwEjoVELbBEVguhliA4Nln/sXuCzoi7zA0Cwx+pep7HBFekdEDY8QKpZYknpmBGe
         vOgcf6XITCtPVOi2VJYjpG5Id+EicHOXvh7s/BhfremBkCjPAgfANthRq1F2LVjI9n
         a/FtTkKP/WSKw==
Message-ID: <a6d61a1a-ac5e-0ced-2fb3-51f6dc8adf24@denx.de>
Date:   Sat, 26 Nov 2022 19:40:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] power: supply: bq25890: Add HiZ mode support
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>
References: <20221109221504.79562-1-marex@denx.de>
 <20221109221504.79562-2-marex@denx.de>
 <ffd849db-fdb5-8578-85c2-74a8e030d86a@redhat.com>
 <1cde6f13-c131-332f-44f2-9a6a80b72330@redhat.com>
 <c0cc1774-8373-ec5d-29c7-5f7d056821b3@denx.de>
 <2ae29632-58e9-4ee5-3d59-397bff4932fc@redhat.com>
 <7e2ee4f1-25d1-86db-7b8d-8785caef6c37@denx.de>
 <28aec5ab-53fb-4295-3859-6ab29b1cb3dd@redhat.com>
 <96e20bf6-c5c0-fcce-901d-fd0a292aaf0b@denx.de>
 <34f1010f-3f6d-b243-ad56-043ab3a7ed04@redhat.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <34f1010f-3f6d-b243-ad56-043ab3a7ed04@redhat.com>
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

On 11/26/22 16:50, Hans de Goede wrote:
> Hi,

Hi,

[...]

>>> I do like the v2 of your patches better because that really guarantees
>>> the second charger is "offline" when we want it to be offline and allows
>>> me to put it in Hi-Z mode before enabling the 5v boost output on the
>>> main charger instead of letting the secondary battery briefly charge
>>> from the main battery. It also allows me to remove a struct delayed_Work
>>> which I added for the 300ms delay ...
>>
>> Pardon my ignorance here, but doesn't that implementation above work only in case you have two chargers ? Note that in my case, I have one charger and one battery.
> 
> Right the workaround above is specifically for the tablet with
> 2 chargers which I'm working on. Iy is not a generic fix/WA for
> the auto-reset of Hi-Z mode issue.
> 
>>> Can you please let me know if you want to move forward with your v2,
>>> or since that version is not strictly necessary if you would prefer
>>> to rollback to v1 ?
>>
>> If we want to have HiZ mode support upstream, we might as well keep the workaround to retain the HiZ mode across replugs. So let's move forward with v2 ?
> 
> Ack, sounds good to me, thanks.
> 
>>> Then I can adjust my patches accordingly before posting them
>>>
>>> I was pretty much about to post them just now :)
>>
>> Sorry about the delay this week.
> 
> No problem and thank you for your work on this.

Glad I could help.

I dropped the RB from v2 2/2 since there are changes which could use 
review. If you could have a look again at that patch, that would be nice.

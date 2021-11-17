Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15771454D46
	for <lists+linux-pm@lfdr.de>; Wed, 17 Nov 2021 19:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhKQSjh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 13:39:37 -0500
Received: from mout.gmx.net ([212.227.17.20]:57967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231389AbhKQSjh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Nov 2021 13:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637174170;
        bh=RcdUlaXiijMh8++al6CbaJLwuT55hVMAIUbHC65BQ6o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dGNMzGUCkjirQ1ORFYgXGvHNCRLdsZW/WxP64wQpQ4kJLKDcP6f9daNlDJtPBVJUZ
         oGRbMlWjhj4DXzLarsbs2caHIZzkTOCjc+5Tv5B7TLIpYcK/XzVCSvQDLnjME8NtPR
         IqOI2PkaPoOP2pP2slsoA/OTjTm+/RfbvEQrmfiY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.135.7.100] ([87.122.254.75]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqs4f-1mIWt92N1d-00mtHo; Wed, 17
 Nov 2021 19:36:10 +0100
Subject: Re: [PATCH 0/4] power: supply: add charge_behaviour property
 (force-discharge, inhibit-charge)
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
Cc:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        linux-kernel@vger.kernel.org, bberg@redhat.com, hadess@hadess.net,
        markpearson@lenovo.com, nicolopiazzalunga@gmail.com,
        njoshi1@lenovo.com, smclt30p@gmail.com
References: <20211113104225.141333-1-linux@weissschuh.net>
 <9cebba85-f399-a7aa-91f7-237852338dc5@gmx.net>
 <d1bc62e9-a5da-4c23-b31f-8ba718faf4a3@t-8ch.de>
From:   Thomas Koch <linrunner@gmx.net>
Message-ID: <16d33b74-1b04-8b9e-7799-4f4b3a89c004@gmx.net>
Date:   Wed, 17 Nov 2021 19:36:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <d1bc62e9-a5da-4c23-b31f-8ba718faf4a3@t-8ch.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3PNZ8KDwJ+XWUPz1ULOBFZETWCa6dag6Enh+ZaSCoypPF0xzQNh
 5Hkqnw8c6Gdhadon0HNcj/xgoad0L2TTSEovyAfAqNoT71w3mvRet5MRVns4dHdu5hACOkx
 JFByKofXl6SgBrx5D5M/ufKOnay3668ppF5vhxMDrPQ3gA1KN3G6TTLtDKwcuS5rReU1JGK
 nXHn2V5L1Xvc3317QH11w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0ND3RcJXYFk=:5QY3QSvs+FsMS9E6M/6Xe0
 v9IkMg05btolupNdl24EQ6vnzeM2uchYhgPyMVla0oWYS8RLZ4tmgxBxJOa8YyghaX3qk0cg3
 EaiD9jNfDEFRxkN84TUjZCPwRF3CUB3sdtE3qEgRNILeXWbB8/6zR/8rWV7PMLztbbHQJyTPY
 2NxAmzk+/V1XsE+E/M/idkso4aJNFF1uddaYm+BhZVofTkEgm0J/+79iwezb6ikJMTLQ2pmbv
 cZ+qgIJXwwzT5qImndwQzH3dWUBzxWTH/3cX6tDTvUxQyO0FF7yMWQ6bWENl862YPs0PsDzcj
 fKXihL/3+HwgZDb5ydhb7kj37THnPvg5b7Pllq3wyfn3ZJ1G9KZnyF37tZgiyXx8yg1LA9krn
 Q2tYVNWybBZZCQcbwGsgQE1nPoIRE/y1ToyXPq50OdTw7SShSz0zmFu9dvaI74D9dCzAQYsaB
 3gl65nQOVqWY875G2MBvfs8VojBq8W2kJf/opcG7d1hnke7NiAfe8wvCnDlgjEq5n1B3y2SJt
 r0i1mB2+xUtXKQTLOQe5mkZHWO6HYIKVvPuj+u3MeUF4Z/2J5qRTOdSatOFj1henu0xRnjpwu
 LhdbgHdpTgxVmc8YB91vKM2CSqS5GWhVe0tuEXMXVrRtT4lPp0tvq1YA4M/PkJxBATJapBWR3
 3TWhsP4YSB/GU/KBcRrujS3XldWADQ0FHx+9dzREA0/PU43s8S6IBesuyNtdTx9gqDQk+s8my
 0NQ0NgrcPnRmr0iQ70pF9POXaj7m8hxwAJDFWs4CxmUfMkA87b9+60eOyUD2z9tVHGwDqayXS
 Sl2XvUXmMlI0K2NQgy0DdYB595jsvLIqtZPPKBUh3b2LdzGWzcMFSjXRGa9RJzz0BJmNNrpXh
 NuV+sotwtwkAQKM1mmj4CZVtvmrjYQJA+oRTJrT6k2pLbrnTVj13OSXxCav8l13rtIbbu4PFE
 D6eYb50kZaBNDeYkBdFKyUnP7XIhIfrnNiXwZTKsHplsWRtuIArPsU110GPZA1PHKZAed/61L
 nE+rYBlfEcsskbqVVQh+90j6w7E5l3aSIijrODpAGFk+FwAHx7D4lyDcvF48qmj8SfpnKmlv6
 KItAJG5BRF6dd4=
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Thomas,

On 17.11.21 18:57, Thomas Wei=C3=9Fschuh wrote:
> On 2021-11-16 17:56+0100, Thomas Koch wrote:
>> thank you very much for working on this. It is high time that we leave
>> external kernel modules for ThinkPads behind us.
>>
>> On 13.11.21 11:42, Thomas Wei=C3=9Fschuh wrote:
>>> Hi,
>>>
>>> this series adds support for the charge_behaviour property to the powe=
r
>>> subsystem and thinkpad_acpi driver.
>>>
>>> As thinkpad_acpi has to use the 'struct power_supply' created by the g=
eneric
>>> ACPI driver it has to rely on custom sysfs attributes instead of prope=
r
>>> power_supply properties to implement this property.
>>>
>>> Patch 1: Adds the power_supply documentation and basic public API
>>> Patch 2: Adds helpers to power_supply core to help drivers implement t=
he
>>>     charge_behaviour attribute
>>> Patch 3: Adds support for force-discharge to thinkpad_acpi.
>>> Patch 4: Adds support for inhibit-discharge to thinkpad_acpi.
>>>
>>> Patch 3 and 4 are largely taken from other patches and adapted to the =
new API.
>>> (Links are in the patch trailer)
>>>
>>> Ognjen Galic, Nicolo' Piazzalunga, Thomas Koch:
>>>
>>> Your S-o-b is on the original inhibit_charge and force_discharge patch=
es.
>>> I would like to add you as Co-developed-by but to do that it will also=
 require
>>> your S-o-b. Could you give your sign-offs for the new patches, so you =
can be
>>> properly attributed?
>> S-o-b/Co-developed-by/Tested-by is fine with me.
>>
>> I tested your patches.
>>
>> Hardware:
>>
>> - ThinkPad X220, BAT0
>> - ThinkPad T450s, BAT0+BAT1
>> - ThinkPad X1C6, BAT0
>>
>> Test Results:
>>
>> 1. force-discharge
>>
>> Everythings works as expected
>> - Writing including disengaging w/ "auto" : OK
>> - Reading: OK
>>
>> - Battery discharging: OK
>> - Disengaging with "auto": OK
>>
>> 2. inhibit-charge
>>
>> Works as expected:
>> - Writing: OK
>>
>> - Disengaging with "auto": OK
>>
>>
>> Discrepancies:
>> - Battery charge inhibited: BAT0 OK, BAT1 no effect e.g. continues char=
ging
>> - Reading: always returns "auto"
>
> I tested it on a T460s with two batteries and there inhibit-charge works
> fine for both batteries.
> What does not work is setting force-discharge for both batteries at the =
same
> time.
> This makes somewhat sense as on a physical level probably only one of th=
em can
> be used at a time.

My experience confirms your consideration. The ThinkPad battery circuit
can handle exactly one battery at a time i.e.
- Charging, AC connected
- Forced discharging,  AC connected
- Discharging, AC disconnected
The other battery is always idle during this time.

> Mark Pearson: Could you confirm that this is the intended behaviour?
>
> In my changes queued for v2 of the series[0] I added validation of the w=
ritten
> settings and an EIO is now reported if the settings were not applied, so=
 this
> should help userspace handle this situatoin.
>
> The plan is to submit v2 after the first round of review for the core PM
> changes.

Please wait until i'm finished with testing your queued v2. I am getting
errors here and would first like to rule out homemade problems with my
kernel build and/or base version.

> [0] https://git.sr.ht/~t-8ch/linux/tree/charge-control


=2D-
Freundliche Gr=C3=BC=C3=9Fe / Kind regards,
Thomas Koch

Mail : linrunner@gmx.net
Web  : https://linrunner.de/tlp

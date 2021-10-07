Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB574424CF0
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 07:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbhJGF6O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 01:58:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:45001 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231661AbhJGF6N (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 Oct 2021 01:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633586174;
        bh=YSFeltWGg9MVGSq2Ruy2wXL7OtJ7GWz/i0FUYf1V9vs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bz/oOymWjetDTvOk5beAOqkt78RPG6WLGqNvJzsWfhkHTUQfcQgxKiTz7MiNz0SPH
         Ej9/xHpEn7zWdTl4ktzezGB7Jy50Edt9blig96FIy8Tb67UYwMYPj26p+OXo4smkHb
         ujz0ovA/9Ji6R1a9HIlN574ArsIZEKD+NAIlvvMQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.135.7.100] ([87.123.178.31]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MY6Cb-1mIFb10AxB-00YR6M; Thu, 07
 Oct 2021 07:56:14 +0200
Subject: Re: [RFC] add standardized attributes for force_discharge and
 inhibit_charge
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@weissschuh.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        =?UTF-8?Q?Nicol=c3=b2_Piazzalunga?= <nicolopiazzalunga@gmail.com>,
        linux-pm@vger.kernel.org,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "smclt30p@gmail.com" <smclt30p@gmail.com>
References: <77e39b3e-fa51-54fe-1898-4f43895ac2c6@redhat.com>
 <20211005162352.emaoveimhkp5uzfw@earth.universe>
 <06fa7a23-4dec-cba9-4e00-c00cf0bf9337@redhat.com>
 <20211005220630.zurfqyva44idnplu@earth.universe>
 <8cbf7671-d9ee-6bfc-d8fd-d360ccb2c595@redhat.com>
 <f2e99c38-2e2f-4777-8318-fb4dae6e8bf1@t-8ch.de>
 <04693bb2-9fd1-59fa-4c21-99848e8aa4c4@redhat.com>
 <20211006162834.ujxfcn7jjrdl4kjx@earth.universe>
 <9ec694b7-48a9-5d86-0970-daefdf204712@redhat.com>
 <10fe30d4-f076-0612-002b-8bdf4e0a1fd5@gmx.net>
 <cdc45a93-dd17-4ff1-8ce7-9002ae6ae23b@t-8ch.de>
From:   Thomas Koch <linrunner@gmx.net>
Message-ID: <48c9dd0e-ffe7-6ee5-c201-517392269da5@gmx.net>
Date:   Thu, 7 Oct 2021 07:56:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cdc45a93-dd17-4ff1-8ce7-9002ae6ae23b@t-8ch.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dzpBgqKWn1FJ/zWvnmCexnxM7rGc6DMlz50F02zznNXnY6oFkSP
 aeyA0aScyW/e86YRIXawXgYjC3Pf8ohswY65xKNfEzJVa/0xjJ8KmNvtDM62Fr8Ln2CFH7R
 ued+06efzULWM2GKUNBZZ3i14r5TdUSY8P8jpoMDQ+rFYsLOPHFoMvIsgJnvGTiS2d7sTLh
 PzY6RWoJW7RzWjQ7qYGpw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PjQtcdEucBw=:RhLvf/amJQFEK+JbRLy90I
 g1iR8jdTJ74VCi0vjycUOJoknPJpnyUwZKDPm8tTsVMX+UMtKE6btY2qgafaFeLLp+lbSs5TB
 MnixjnHe1IRh11XF7zYEZy+0ujEHG+Xq6HpZYg5DqL957mf9uQjeI7UrgwCU/y4WbmOk2ilr9
 h2N/oN0O7r1jFCLtRQnsXb8Ua6m7Fd7dwIXBYpFNC1Ku9Y+ia3ctNLSGaJzmC+JmrFkXFI3dI
 SD5M7dPWC5WBwdHUMo1yuUSAuYajkQcq8A48d+LUt0b22BQGaby9I2V3ZUywhn0JuqAB8NQS0
 oMUE2MfSaFemeqk9oKMTnmbOPlE2lqDLGFPjypeT/Cv2tHXjzAnso+zBuhBJxAxH58m0y1xmk
 qlqaFSf1y3zOXW3QAUtzDNxzS21aUqQI7dhwHyXu4Wj1CxNSs4lbu6YJoyyi/IS4yIl7KTw0m
 lBzwSo0+Nds8ioNxV2IxcXj1ndKWHnfip6S7OzmWIx0M0hyZsABCPjczJ1DwNNvIiqJjSyMN2
 7lmNJpDAYmGZaR+S65wP39JOLILf9HMotUua1UcEaSIDduC7EYVkt9vWj9rpFQ+wkKQzVm6Ur
 eCYpq/XBRCm4iSSdy3BQLtbncEKKVkwQjiyFdOjBeijwc1of7gLX5TkrdcWWqQSKBiTRMpdPJ
 vwpT8XGTKq7TxXDFC7iu9pp43vZp7y5ZmNNxoXUVR9TS1DNg2cWANl0ZEO7NSA4vp1MXudevR
 Z/9btLDdGEzXVk3B48uuolH3lCeHs7ISFkFFbA7n6Fbk8pRpD8OzfBEMEXWQwE+K+jzhLgKv6
 tndh5thK9micp1fJgv/lUuZfl8kHNWVCSh+ynOXl6ah1hjD9o7CIAoU6v2qkyOsnnkqKx4V9j
 UzprwpoUcda0fwPddnHnJhPQRTcDECVFlD61+GlF1joOo00gJWZJZwBOHeYQ0eeEqyu7jbnHa
 MgYCsXpxpRQXGGMTxow3yM3W9gTzynwQ9TVQ+8mqJnV3LkZuVxpobSx6bsk9Q6bmUL0KGFDbF
 NZ/zFBHY+Lvxc+R88eGZ0416N8nf3QRUFNmyPW4x0AlEkDLXQY38gAT5tgwa/BHlzmE706DJH
 aiFljBVj+uORqA=
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 06.10.21 23:39, Thomas Wei=C3=9Fschuh wrote:
> On 2021-10-06T21:24+0200, Thomas Koch wrote:
>> Date: Wed, 6 Oct 2021 21:24:14 +0200
>> From: Thomas Koch <linrunner@gmx.net>
>> To: Hans de Goede <hdegoede@redhat.com>, Sebastian Reichel
>>   <sebastian.reichel@collabora.com>
>> Cc: Thomas Wei=C3=9Fschuh <thomas@weissschuh.net>, Nicol=C3=B2 Piazzalu=
nga
>>   <nicolopiazzalunga@gmail.com>, linux-pm@vger.kernel.org,
>>   "platform-driver-x86@vger.kernel.org"
>>   <platform-driver-x86@vger.kernel.org>, "smclt30p@gmail.com"
>>   <smclt30p@gmail.com>
>> Subject: Re: [RFC] add standardized attributes for force_discharge and
>>   inhibit_charge
>> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
>>   Thunderbird/78.13.0
>>
>> Hi,
>>
>> On 06.10.21 19:47, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 10/6/21 6:28 PM, Sebastian Reichel wrote:
>>>> Hi,
>>>>
>>>> On Wed, Oct 06, 2021 at 05:27:22PM +0200, Hans de Goede wrote:
>>>>> On 10/6/21 4:49 PM, Thomas Wei=C3=9Fschuh wrote:
>>>>>> On 2021-10-06T10:10+0200, Hans de Goede wrote:
>>>>>>> On 10/6/21 12:06 AM, Sebastian Reichel wrote:
>>>>>>>> On Tue, Oct 05, 2021 at 08:01:12PM +0200, Hans de Goede wrote:
>>>>>>>>> Right, force-discharge automatically implies charging is
>>>>>>>>> being inhibited, so putting this in one file makes sense.
>>>>>>>>>
>>>>>>>>> Any suggestion for the name of the file?
>>>>>>>>
>>>>>>>> Maybe like this?
>>>>>>>>
>>>>>>>> -----------------------------------------------------------------=
----
>>>>>>>> What: /sys/class/power_supply/<supply_name>/charge_behaviour
>>>>>>>> Date: October 2021
>>>>>>>> Contact: linux-pm@vger.kernel.org
>>>>>>>> Description:
>>>>>>>>    Configure battery behaviour when a charger is being connected.
>>>>>>>>
>>>>>>>>    Access: Read, Write
>>>>>>>>
>>>>>>>>    Valid values:
>>>>>>>>
>>>>>>>>    0: auto / no override
>>>>>>>>       When charger is connected battery should be charged
>>>>>>>>    1: force idle
>>>>>>>>       When charger is connected the battery should neither be cha=
rged
>>>>>>>>       nor discharged.
>>>>>>>>    2: force discharge
>>>>>>>>       When charger is connected the battery should be discharged
>>>>>>>>       anyways.
>>>>>>>> -----------------------------------------------------------------=
----
>>>>>>>
>>>>>>> That looks good to me. Although I just realized that some hw may
>>>>>>> only support 1. or 2. maybe explicitly document this and that
>>>>>>> EOPNOTSUPP will be reported when the value is not supported
>>>>>>> (vs EINVAL for plain invalid values) ?
>>>>>>
>>>>>> Would that not force a userspace applications to offer all possibil=
ities to
>>>>>> the user only to tell them that it's not supported?
>>>>>> If the driver knows what is supported and what not it should make t=
his
>>>>>> discoverable without actually performing the operation.
>>>>>>
>>>>>> Maybe something along the lines of /sys/power/mem_sleep.
>>>>>
>>>>> Good point, but something like /sys/power/mem_sleep works
>>>>> very differently then how all the other power_supply properties work=
.
>>>>
>>>> Actually we already use this format in power-supply for USB
>>>> types, implemented in power_supply_show_usb_type().
>>>>
>>>>> In general if something is supported or not on a psy class
>>>>> device is communicated by the presence / absence of attributes.
>>>>>
>>>>> So I think we should move back to having 2 separate attributes
>>>>> for this after all; and group the 2 together in the doc and
>>>>> document that enabling (setting to 1) one of force_charge /
>>>>> inhibit_charge automatically clears the setting of the other.
>>>>>
>>>>> Then the availability of the features can simply be probed
>>>>> by checking for the presence of the property files.
>>>>
>>>> If it's two files, then somebody needs to come up with proper
>>>> names. Things like 'force_discharge' look sensible in this context,
>>>> but on a system with two batteries (like some Thinkpads have) it
>>>> is easy to confuse with "I want to discharge this battery before
>>>> the other one (while no AC is connected)". > Ah I did not realize the=
re was already some (read-only) precedence
>>> for this in the psy subsystem.
>>>
>>> Since there is precedence for this using
>>> /sys/class/power_supply/<supply_name>/charge_behaviour
>>>
>>> with an example contents of say:
>>>
>>> [auto] inhibit-charge force-discharge
>>>
>>> Works for me and having 1 file instead of 2 is better then
>>> because this clearly encapsulates that inhibit-charge and
>>> force-discharge are mutually exclusive.
>> In fact they do not reset each other on ThinkPads. It's possible to
>>
>> 1. set force_discharge=3D1 -- discharging commences
>> 2. set inhibit_charge=3D1 -- discharging continues, force_discharge rem=
ains 1
>> 3. set force_discharge=3D0 -- battery does not charge, inhibit_charge
>> remains 1
>
> But in the end there are only three states the user cares about, or?
> (inhibit, force_discharge and normal)
>
> So when selecting inhibit or force_discharge the driver itself can reset=
 the
> other option so the users do not have to care about the internal state o=
f the
> EC.
Correct. It works with the three states Sebastian suggested because
force_discharge overrules inhibit_charge.

Whereby for user-friendliness I would prefer Hans' strings

 >>> [auto] inhibit-charge force-discharge


to Sebastian's numbered states.

>
> Thomas
>

Freundliche Gr=C3=BC=C3=9Fe / Kind regards,
Thomas Koch

Mail : linrunner@gmx.net
Web  : https://linrunner.de/tlp

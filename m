Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879934246A8
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 21:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbhJFT0N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 15:26:13 -0400
Received: from mout.gmx.net ([212.227.17.21]:37015 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231807AbhJFT0M (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 Oct 2021 15:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633548255;
        bh=r1b2zsekMs7VwPoVY5hrZ8tdaBnIOX/fxBqk4WcPwtQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QgsKdDYpBATBev/ByF+2OE3aIsqY+BrMjJn17GD+5QYwseiavP+OAuvhBoP+ZDFi7
         IHzFfhkhbtpo80eg8jb6N7NLeJEExz9a8b1bAD/NcpCZu0b+ZX3ygPhAzmHSvFWbBN
         +NPeKQF2jebtQejmoiVEoZA1brTg/qf5pfue9yFc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.135.7.100] ([87.122.242.45]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6m4-1nCjLP0inU-00lY6w; Wed, 06
 Oct 2021 21:24:15 +0200
Subject: Re: [RFC] add standardized attributes for force_discharge and
 inhibit_charge
To:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@weissschuh.net>,
        =?UTF-8?Q?Nicol=c3=b2_Piazzalunga?= <nicolopiazzalunga@gmail.com>,
        linux-pm@vger.kernel.org,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "smclt30p@gmail.com" <smclt30p@gmail.com>
References: <21569a89-8303-8573-05fb-c2fec29983d1@gmail.com>
 <77e39b3e-fa51-54fe-1898-4f43895ac2c6@redhat.com>
 <20211005162352.emaoveimhkp5uzfw@earth.universe>
 <06fa7a23-4dec-cba9-4e00-c00cf0bf9337@redhat.com>
 <20211005220630.zurfqyva44idnplu@earth.universe>
 <8cbf7671-d9ee-6bfc-d8fd-d360ccb2c595@redhat.com>
 <f2e99c38-2e2f-4777-8318-fb4dae6e8bf1@t-8ch.de>
 <04693bb2-9fd1-59fa-4c21-99848e8aa4c4@redhat.com>
 <20211006162834.ujxfcn7jjrdl4kjx@earth.universe>
 <9ec694b7-48a9-5d86-0970-daefdf204712@redhat.com>
From:   Thomas Koch <linrunner@gmx.net>
Message-ID: <10fe30d4-f076-0612-002b-8bdf4e0a1fd5@gmx.net>
Date:   Wed, 6 Oct 2021 21:24:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <9ec694b7-48a9-5d86-0970-daefdf204712@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4kpNEfGae9AisGFoCZMErzHsssOeDUmpHgWYBpMfYfBEftPUFtn
 G8A/9r+Nf3jPeXxNLTrn/Hw1mv3bCDYRdikBwJuYyEnN6k2I6S9FZmf28FRTRtHr6Q87nb1
 qaqSo8aZeOgpenyMPrhBYXqwD/cKAfggxr4YgQhcCTChMZB1bDB/paecl8Atc9/25nupnNQ
 0cmg4x0oruq5KqtNPh+VQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SJlg4koLdQ8=:TkodLvep/srAw6ujsJNUjG
 B+vZMq+bvnS96aLleif4C1Qwdn8pR4Rxe6TX6N3hmzVjFxLe6T+znC9+xl1MpfAqZFa3N6Ufx
 rvdSOITFEl+12lwo96QtjiygmaIpzfA+U8Xz0QqmerYJgG2C2bpZmecTMw28C2ouV7O8DIg5x
 5jy7y+oJabo7PN3/m5uPiVbU1pMTncSPE+4xsMQuRYN7rAUIXupGU4ykPSCcgUJ2jRpkAk9JS
 0ApfLss6SF5b8rA/nx8F6uLLDpk2PiKymsAt3pTNf7CpEfjbvJY6gY13QmhpQZFf8Ghd39RsX
 l/GnN36kX10/8bZLrXPirKsNGa7cDqL9vKQjxJflJMJckyBE+WOBliUEx1m4LIhPukGoCzo+q
 N/CeoRxtEPsf4/WcQ5+kJTGkQvqkcJqMGtqacX9QBMSPbFdqIwtt7b0irA+K5fL4Tjb8aIuNu
 mQmJT9mC5waViq7k8V7YDlEw+r64M4UdYI8GtQTUfYe1XiDuuqwBKZUeB56I/0dT/EuQjygjH
 PHZtcUwZU+XcvCEdLSe7Vr92oM7t3gXZzitztWOxUX436bO5NVmqwjL7b0SzoevzDVyAQkKOz
 3YmRE0DhQKsmKkwe3RWos7xpqUHR+wqiIwRfV9gbhZC0YhBUork5xddLiR+PMDNeCz0C/2Irf
 HCYxsKZLu+QVxypNziusfXWiT4HUMRlle44+iBhdqtIOpQLzsoF4VLDR8UjIRbzGRWvqdb7Tb
 j7Ru3Ad8Ie6JHm5gtfaTmyEbSinyzWIjyjBOR69p6qNsoEURjnPyjzLlInvaVlvFWHyWPjksZ
 SdBk/3DLnLkt877hxP+WyaDbOril04IUEgsrKEighSx8tuvpJoM+mwNkIzsRDudDgac2vqy4R
 rlxdAlSiBa+AiWZXhnrmdsr60xu8VlqxJMgfpcGtclJb4QbqRxns84BazB8gG2+MZ6ecAT1rs
 gxrscb/b8ATHaK751TwRwsWIWODMOMwkzMa013ZNR+QKKyhdLUewWL3iu8f3oaFCw686XXFzO
 DizTdmCtu8MZfyYk1+EV9zM3EtLO9gWso89RS9YBkJiUSX9VAYxg0MIzH1Z0JdoJJEpILokg+
 s+L9FizSgX4t9U=
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 06.10.21 19:47, Hans de Goede wrote:
> Hi,
>
> On 10/6/21 6:28 PM, Sebastian Reichel wrote:
>> Hi,
>>
>> On Wed, Oct 06, 2021 at 05:27:22PM +0200, Hans de Goede wrote:
>>> On 10/6/21 4:49 PM, Thomas Wei=DFschuh wrote:
>>>> On 2021-10-06T10:10+0200, Hans de Goede wrote:
>>>>> On 10/6/21 12:06 AM, Sebastian Reichel wrote:
>>>>>> On Tue, Oct 05, 2021 at 08:01:12PM +0200, Hans de Goede wrote:
>>>>>>> Right, force-discharge automatically implies charging is
>>>>>>> being inhibited, so putting this in one file makes sense.
>>>>>>>
>>>>>>> Any suggestion for the name of the file?
>>>>>>
>>>>>> Maybe like this?
>>>>>>
>>>>>> -------------------------------------------------------------------=
--
>>>>>> What: /sys/class/power_supply/<supply_name>/charge_behaviour
>>>>>> Date: October 2021
>>>>>> Contact: linux-pm@vger.kernel.org
>>>>>> Description:
>>>>>>   Configure battery behaviour when a charger is being connected.
>>>>>>
>>>>>>   Access: Read, Write
>>>>>>
>>>>>>   Valid values:
>>>>>>
>>>>>>   0: auto / no override
>>>>>>      When charger is connected battery should be charged
>>>>>>   1: force idle
>>>>>>      When charger is connected the battery should neither be charge=
d
>>>>>>      nor discharged.
>>>>>>   2: force discharge
>>>>>>      When charger is connected the battery should be discharged
>>>>>>      anyways.
>>>>>> -------------------------------------------------------------------=
--
>>>>>
>>>>> That looks good to me. Although I just realized that some hw may
>>>>> only support 1. or 2. maybe explicitly document this and that
>>>>> EOPNOTSUPP will be reported when the value is not supported
>>>>> (vs EINVAL for plain invalid values) ?
>>>>
>>>> Would that not force a userspace applications to offer all possibilit=
ies to
>>>> the user only to tell them that it's not supported?
>>>> If the driver knows what is supported and what not it should make thi=
s
>>>> discoverable without actually performing the operation.
>>>>
>>>> Maybe something along the lines of /sys/power/mem_sleep.
>>>
>>> Good point, but something like /sys/power/mem_sleep works
>>> very differently then how all the other power_supply properties work.
>>
>> Actually we already use this format in power-supply for USB
>> types, implemented in power_supply_show_usb_type().
>>
>>> In general if something is supported or not on a psy class
>>> device is communicated by the presence / absence of attributes.
>>>
>>> So I think we should move back to having 2 separate attributes
>>> for this after all; and group the 2 together in the doc and
>>> document that enabling (setting to 1) one of force_charge /
>>> inhibit_charge automatically clears the setting of the other.
>>>
>>> Then the availability of the features can simply be probed
>>> by checking for the presence of the property files.
>>
>> If it's two files, then somebody needs to come up with proper
>> names. Things like 'force_discharge' look sensible in this context,
>> but on a system with two batteries (like some Thinkpads have) it
>> is easy to confuse with "I want to discharge this battery before
>> the other one (while no AC is connected)". > Ah I did not realize there=
 was already some (read-only) precedence
> for this in the psy subsystem.
>
> Since there is precedence for this using
> /sys/class/power_supply/<supply_name>/charge_behaviour
>
> with an example contents of say:
>
> [auto] inhibit-charge force-discharge
>
> Works for me and having 1 file instead of 2 is better then
> because this clearly encapsulates that inhibit-charge and
> force-discharge are mutually exclusive.
In fact they do not reset each other on ThinkPads. It's possible to

1. set force_discharge=3D1 -- discharging commences
2. set inhibit_charge=3D1 -- discharging continues, force_discharge remain=
s 1
3. set force_discharge=3D0 -- battery does not charge, inhibit_charge
remains 1

>
> Regards,
>
> Hans
>
>

Freundliche Gr=FC=DFe / Kind regards,
Thomas Koch

Mail : linrunner@gmx.net
Web  : https://linrunner.de/tlp
